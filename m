Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548A2172314
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgB0QTx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:19:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:18983 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgB0QTx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:19:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="385205579"
Received: from asliwa-mobl.ger.corp.intel.com (HELO localhost) ([10.252.26.84])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 08:19:50 -0800
Date:   Thu, 27 Feb 2020 18:19:49 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-ID: <20200227161949.GD5140@linux.intel.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
 <20200225164850.GB15662@linux.intel.com>
 <1582765091.4245.33.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582765091.4245.33.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 26, 2020 at 04:58:11PM -0800, James Bottomley wrote:
> On Tue, 2020-02-25 at 18:48 +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 30, 2020 at 11:18:09AM +0100, James Bottomley wrote:
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
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> > 
> > Should have a fixes tag.
> 
> I made all the other changes, but I'm not sure what to identify in the
> fixes tag.  The problem is the code I updated was simply carried over
> unaltered from TPM 1.2
> 
> You could certainly argue that commit
> 
> commit 0fe5480303a1657b328a0a389f8d99249d9961f5
> Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Date:   Fri Jun 26 22:28:26 2015 +0300
> 
>     keys, trusted: seal/unseal with TPM 2.0 chips
> 
> Should have updated the blobauth handling ... is that the one you'd
> like fixes: to identify?

What I'm thinking is to have fixes tag w/o cc to stable. I'm not
sure at this point whether we want to backport this but it still
makes sense to tag it.

/Jarkko
