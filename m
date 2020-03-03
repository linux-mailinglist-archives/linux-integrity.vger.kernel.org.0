Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006771784F0
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 22:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbgCCVcw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 16:32:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:3053 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgCCVcw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 16:32:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 13:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="243731878"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2020 13:32:40 -0800
Date:   Tue, 3 Mar 2020 23:32:38 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 3/6] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200303213238.GD110353@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-4-James.Bottomley@HansenPartnership.com>
 <20200303193302.GC5775@linux.intel.com>
 <1583267948.3638.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583267948.3638.7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 03, 2020 at 03:39:08PM -0500, James Bottomley wrote:
> On Tue, 2020-03-03 at 21:33 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 02, 2020 at 07:27:56AM -0500, James Bottomley wrote:
> > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > actually recommended you to hash variable length passwords and use
> > > the sha1 hash as the authorization.  Because the spec doesn't
> > > require this hashing, the current authorization for trusted keys is
> > > a 40 digit hex number.  For TPM 2.0 the spec allows the passing in
> > > of variable length passwords and passphrases directly, so we should
> > > allow that in trusted keys for ease of use.  Update the 'blobauth'
> > > parameter to take this into account, so we can now use plain text
> > > passwords for the keys.
> > > 
> > > so before
> > > 
> > > keyctl add trusted kmk "new 32
> > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > > 
> > > after we will accept both the old hex sha1 form as well as a new
> > > directly supplied password:
> > > 
> > > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > > 
> > > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > > password must be 20 or less, we use the length as the discriminator
> > > for which form is input.
> > > 
> > > Note this is both and enhancement and a potential bug fix.  The TPM
> > > 2.0 spec requires us to strip leading zeros, meaning empyty
> > > authorization is a zero length HMAC whereas we're currently passing
> > > in
> > > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > > patch
> > > makes the Microsoft TPM emulator work with trusted keys.
> > 
> > The commit message does not mention it but there limitation that you
> > cannot have this as a *password*:
> > 
> >   f572d396fae9206628714fb2ce00f72e94f2258f
> > 
> > The commit message should explicitly state this.
> 
> Well, that's impossible anyway: the password can be at most
> TPM_DIGEST_SIZE characters and the above is twice that, so the
> discriminator is fairly simple: if the string size is less than or
> equal to TPM_DIGEST_SIZE, then it's a plain password, if it's exactly
> 2xTPM_DIGEST_SIZE it must be a hex value and if it's anything else,
> it's illegal.  I thought the sentence
> 
>    Since a sha1 hex code must be exactly 40 bytes long and a direct
>    password must be 20 or less, we use the length as the discriminator
>    for which form is input.
> 
> Was the explanation for this, but I can update it.

Thanks! No need to update. I missed that part somehow.

/Jarkko
