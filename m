Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2068178429
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 21:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgCCUjM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 15:39:12 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46950 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731560AbgCCUjM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 15:39:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 06EDA8EE26A;
        Tue,  3 Mar 2020 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583267951;
        bh=0DZEqBkjEA0Y7SVg7sjdrOreeQRcTOP6c0OLaHICZPk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W/1Fepwju7/rfKPF6zksCHlCCqUdfzIqeMdHGSL/7XK+vL7zNdXNSzG2eMMFBk8oy
         6PXmf8YBWXIAMfeh19EgK7Fg+4ZmZqLMpeUlJ86ofVaaUPhTqrrWWBRZ/6sBD8vAuc
         S8aQQF3vpyDl529tlmW35w754PIbWOnV2BpPllCw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ia3LsEvlLovb; Tue,  3 Mar 2020 12:39:10 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EEE5B8EE17D;
        Tue,  3 Mar 2020 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583267950;
        bh=0DZEqBkjEA0Y7SVg7sjdrOreeQRcTOP6c0OLaHICZPk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G3q8zMMv3wo+K0xO5sVpNKKdjY9qNipFErnaw2YRAJTLiEuHWh528D0ewNwSI/6hE
         bmDi2mTW1ODfmCdgvD5SQ1IWTVNLnsjJ7t5K0XEOlNRYcNadt2MWx7quVdHE9bqXTi
         RCjKP5/3EIPFZyKRPHCjJFrl+nPLmqJEDKTS/xU8=
Message-ID: <1583267948.3638.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 3/6] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Tue, 03 Mar 2020 15:39:08 -0500
In-Reply-To: <20200303193302.GC5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-4-James.Bottomley@HansenPartnership.com>
         <20200303193302.GC5775@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-03-03 at 21:33 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:56AM -0500, James Bottomley wrote:
> > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > actually recommended you to hash variable length passwords and use
> > the sha1 hash as the authorization.  Because the spec doesn't
> > require this hashing, the current authorization for trusted keys is
> > a 40 digit hex number.  For TPM 2.0 the spec allows the passing in
> > of variable length passwords and passphrases directly, so we should
> > allow that in trusted keys for ease of use.  Update the 'blobauth'
> > parameter to take this into account, so we can now use plain text
> > passwords for the keys.
> > 
> > so before
> > 
> > keyctl add trusted kmk "new 32
> > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > 
> > after we will accept both the old hex sha1 form as well as a new
> > directly supplied password:
> > 
> > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > 
> > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > password must be 20 or less, we use the length as the discriminator
> > for which form is input.
> > 
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing
> > in
> > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > patch
> > makes the Microsoft TPM emulator work with trusted keys.
> 
> The commit message does not mention it but there limitation that you
> cannot have this as a *password*:
> 
>   f572d396fae9206628714fb2ce00f72e94f2258f
> 
> The commit message should explicitly state this.

Well, that's impossible anyway: the password can be at most
TPM_DIGEST_SIZE characters and the above is twice that, so the
discriminator is fairly simple: if the string size is less than or
equal to TPM_DIGEST_SIZE, then it's a plain password, if it's exactly
2xTPM_DIGEST_SIZE it must be a hex value and if it's anything else,
it's illegal.  I thought the sentence

   Since a sha1 hex code must be exactly 40 bytes long and a direct
   password must be 20 or less, we use the length as the discriminator
   for which form is input.

Was the explanation for this, but I can update it.

> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > chips")
> 
> Fixes should be before SOB.

OK, I'll reverse them.

James

