Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8DF26CA39
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Sep 2020 21:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIPTw3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Sep 2020 15:52:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55536 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgIPTwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Sep 2020 15:52:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 400A08EE7B7;
        Wed, 16 Sep 2020 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600285936;
        bh=CM5FFtoiUXeFDS04HDTOcYoUbEJiATN117O4vHwx2oo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LpGstKQBeDnpBUf59CwzaJlszBaCFr1PtqY/G//bx/zEUnl02pqVCM+6heHLIjvbU
         gTcvpn+Bg9XqtKD8FFvpEXUt+j1zszj3lkFa2o3sFMFfWHGLLo6hRvNRpkk2eee1EZ
         PSsRr3XDJuiSaGSgpflN+UVQB9EleUirRGmlmtsA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YvCNN2sTluOY; Wed, 16 Sep 2020 12:52:16 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACA828EE792;
        Wed, 16 Sep 2020 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600285936;
        bh=CM5FFtoiUXeFDS04HDTOcYoUbEJiATN117O4vHwx2oo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LpGstKQBeDnpBUf59CwzaJlszBaCFr1PtqY/G//bx/zEUnl02pqVCM+6heHLIjvbU
         gTcvpn+Bg9XqtKD8FFvpEXUt+j1zszj3lkFa2o3sFMFfWHGLLo6hRvNRpkk2eee1EZ
         PSsRr3XDJuiSaGSgpflN+UVQB9EleUirRGmlmtsA=
Message-ID: <1600285934.7475.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 3/5] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 16 Sep 2020 12:52:14 -0700
In-Reply-To: <20200915090950.GB3612@linux.intel.com>
References: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
         <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
         <20200915090950.GB3612@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-09-15 at 12:09 +0300, Jarkko Sakkinen wrote:
> On Sat, Sep 12, 2020 at 10:26:41AM -0700, James Bottomley wrote:
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
> > in 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > the Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > patch makes the Microsoft TPM emulator work with trusted keys.
> > 
> > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > chips")
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I created a key:
> 
> $ sudo ./tpm2-root-key
> 0x80000000
> $ sudo ./tpm2-list-handles
> 0x80000000
> $ keyctl add trusted kmk "new 32 blobauth=hello keyhandle=0x80000000"
> <keyctl usage>

Well, you're getting that because the command isn't complete ... you
need a keyring specifier at the end, like @u.  However, even with that
there's a bug in the code that would cause this to return EINVAL: the
blobauth handler has a return 0 where it should have a break ... I
think that happened as a result of the v6 rework which split up the if
... else if ... else chain.  The result is the processing of options
terminates at blobauth, so if it's last, as I've been testing with,
everything is fine.  If it's first as you specify, none of the options
following the blobauth get processed.  I'll fix this up and add an @u
to the commit message.

James

