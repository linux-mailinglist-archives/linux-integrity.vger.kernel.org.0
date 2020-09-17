Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6087A26DFB4
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIQPbs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 11:31:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:9074 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgIQPbn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 11:31:43 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:31:40 EDT
IronPort-SDR: 94aBwliQ1C1nBmcFdKM7vA/ghA2xH8LcmLcemg0i6/oPGcLBnCZrj//J47eECPN0KNgmVt5e++
 VsmjlZklZgEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157107484"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="157107484"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 08:22:03 -0700
IronPort-SDR: IZG7WXN5+7oWENMzB31OtquHbg4t/UtDS3zCpMfH4swni9wlGWlHMzV7i68kPPT2zj1//CaOs5
 B3WEN0hczsow==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="483787229"
Received: from sdompke-mobl.ger.corp.intel.com (HELO localhost) ([10.249.45.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 08:22:01 -0700
Date:   Thu, 17 Sep 2020 18:21:59 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200917152159.GB7389@linux.intel.com>
References: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
 <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
 <20200915090950.GB3612@linux.intel.com>
 <1600285934.7475.19.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600285934.7475.19.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 16, 2020 at 12:52:14PM -0700, James Bottomley wrote:
> On Tue, 2020-09-15 at 12:09 +0300, Jarkko Sakkinen wrote:
> > On Sat, Sep 12, 2020 at 10:26:41AM -0700, James Bottomley wrote:
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
> > > in 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > > the Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > > patch makes the Microsoft TPM emulator work with trusted keys.
> > > 
> > > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > > chips")
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > I created a key:
> > 
> > $ sudo ./tpm2-root-key
> > 0x80000000
> > $ sudo ./tpm2-list-handles
> > 0x80000000
> > $ keyctl add trusted kmk "new 32 blobauth=hello keyhandle=0x80000000"
> > <keyctl usage>
> 
> Well, you're getting that because the command isn't complete ... you
> need a keyring specifier at the end, like @u.  However, even with that
> there's a bug in the code that would cause this to return EINVAL: the
> blobauth handler has a return 0 where it should have a break ... I
> think that happened as a result of the v6 rework which split up the if
> ... else if ... else chain.  The result is the processing of options
> terminates at blobauth, so if it's last, as I've been testing with,
> everything is fine.  If it's first as you specify, none of the options
> following the blobauth get processed.  I'll fix this up and add an @u
> to the commit message.

Ugh, it's true, missing @u from the tail :-) And I was looking for a long
time old test script and this and wondering where is the difference...

Fix those so that we can finally merge this :-)

> 
> James
> 

/Jarkko
