Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071C11D2E1E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgENLT1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:19:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:20938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgENLT0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:19:26 -0400
IronPort-SDR: +dW7hjW5yv+6ZkWKMSKpm7WwXe0SaaJEN1nsPp42ipPZHRSvS/bSDa/K2ZEjGQZ8cxNvJc5qAr
 uA56TquXe9ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 04:19:25 -0700
IronPort-SDR: pI8PuaqsLtGJiFrUo5CHjobhm/q1KimyjU5udwk1yKSsXmBi7OJ4w2aheIRx4lWN54kDhGXjvK
 9eZ+hg7IjwuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="251630950"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2020 04:19:22 -0700
Message-ID: <911b3ebeb912ee82e205be96c738b33022740dfb.camel@linux.intel.com>
Subject: Re: [PATCH v9 3/8] security: keys: trusted: fix TPM2 authorizations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Thu, 14 May 2020 14:19:21 +0300
In-Reply-To: <1589420469.9117.12.camel@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
         <00325dff8292a18212bbdaa3fd81cebee2a60bc2.camel@linux.intel.com>
         <664f00cf18c68e3f6316b50679b2fd56919d5aeb.camel@linux.intel.com>
         <1589420469.9117.12.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-13 at 18:41 -0700, James Bottomley wrote:
> On Thu, 2020-05-14 at 04:12 +0300, Jarkko Sakkinen wrote:
> > On Thu, 2020-05-14 at 04:11 +0300, Jarkko Sakkinen wrote:
> > > On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
> > > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > > actually recommended you to hash variable length passwords and
> > > > use the sha1 hash as the authorization.  Because the spec doesn't
> > > > require this hashing, the current authorization for trusted keys
> > > > is a 40 digit hex number.  For TPM 2.0 the spec allows the
> > > > passing in of variable length passwords and passphrases directly,
> > > > so we should allow that in trusted keys for ease of use.  Update
> > > > the 'blobauth' parameter to take this into account, so we can now
> > > > use plain text passwords for the keys.
> > > > 
> > > > so before
> > > > 
> > > > keyctl add trusted kmk "new 32
> > > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > > > 
> > > > after we will accept both the old hex sha1 form as well as a new
> > > > directly supplied password:
> > > > 
> > > > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > > > 
> > > > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > > > password must be 20 or less, we use the length as the
> > > > discriminator for which form is input.
> > > > 
> > > > Note this is both and enhancement and a potential bug fix.  The
> > > > TPM 2.0 spec requires us to strip leading zeros, meaning empyty
> > > > authorization is a zero length HMAC whereas we're currently
> > > > passing in 20 bytes of zeros.  A lot of TPMs simply accept this
> > > > as OK, but the Microsoft TPM emulator rejects it with
> > > > TPM_RC_BAD_AUTH, so this patch makes the Microsoft TPM emulator
> > > > work with trusted keys.
> > > > 
> > > > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > > > chips")
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > > .com>
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Have not checked yet the tail. Probably won't check before PR for
> > > v5.8 is out.
> > > 
> > > Just wondering would it hurt to merge everything up until this
> > > patch?
> 
> Everything would be OK if you applied 1, 2 and 3.  Except we'd have an
> ASN.1 API in the tree with no consumers, which excites some people.
> 
> > I.e. could land it also to the release.
> 
> That would likely be fine and should satisfy the API with no consumers
> issue.

Hmm. Right, it does not sense to merge unused API.

I'd like to still pick this patch (3/8) but you need to fix these first:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#17: 
keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"

WARNING: line over 80 characters
#89: FILE: security/keys/trusted-keys/trusted_tpm1.c:801:
+			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {

WARNING: line over 80 characters
#111: FILE: security/keys/trusted-keys/trusted_tpm2.c:94:
+	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);

The best way is probably to encapsulate into helper function. It is more or
less a sign that the code is too complicated to live inside a switch-case
statement.

Can you do that and send it as a separate patch?

/Jarkko

