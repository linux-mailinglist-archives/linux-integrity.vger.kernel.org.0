Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B300170D82
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 01:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgB0AyG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 19:54:06 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60648 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbgB0AyG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 19:54:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 30AF38EE182;
        Wed, 26 Feb 2020 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582764846;
        bh=qcnnK0NTYSZ4D6YKq6nYhyMW7swNZTUWt3qNo1tg2SM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uXCNMsgAdmRs7f1JLVs2ezLN29xSif6qLlkSjEnvsbeB3vSwWRCxpfFKwh9xOkcXJ
         nE+qIH1pWzJAYYIWYq2EZc4c+7ysqrBg959zuvmAAhOugOOy0A8UYGBgmjkgbTjX0u
         71Ly657V1/Kb/5Gmt7QrHd3rk+/TAeI6v1oFl1Rc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vanSO21UYCXj; Wed, 26 Feb 2020 16:54:06 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B84948EE0D2;
        Wed, 26 Feb 2020 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582764846;
        bh=qcnnK0NTYSZ4D6YKq6nYhyMW7swNZTUWt3qNo1tg2SM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uXCNMsgAdmRs7f1JLVs2ezLN29xSif6qLlkSjEnvsbeB3vSwWRCxpfFKwh9xOkcXJ
         nE+qIH1pWzJAYYIWYq2EZc4c+7ysqrBg959zuvmAAhOugOOy0A8UYGBgmjkgbTjX0u
         71Ly657V1/Kb/5Gmt7QrHd3rk+/TAeI6v1oFl1Rc=
Message-ID: <1582764844.4245.29.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:54:04 -0800
In-Reply-To: <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-26 at 16:20 -0800, James Prestwood wrote:
> > > I have been using your set of patches in order to get this ASN.1
> > > parser/definition. I am implementing an asymmetric key
> > > parser/type TPM2 keys for enc/dec/sign/verify using keyctl. Note
> > > that this implementation goes in crypto/asymmetric_keys/, and
> > > your patches sit in security/keys/trusted-keys/.
> > > 
> > > Currently I am just including "../../security/keys/trusted-
> > > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1
> > > parser to verify my keys, but this obviously isn't going to fly.
> > > 
> > > Do you (or anyone) have any ideas as to how both trusted keys and
> > > asymmetric keys could share this ASN.1 parser/definition? Some
> > > common area that both security and crypto could include? Or maybe
> > > there is some common way the kernel does things like this?
> > 
> > Actually TPM2 asymmetric keys was also on my list.  I was going to
> > use the existing template and simply move it somewhere everyone
> > could use.  I also think you need the policy parser pieces because
> > at least one implementation we'd need to be compatible with
> > supports key policy.
> 
> In terms of policy, I haven't looked into that at all for asymmetric
> keys. I do already have enc/dec/sign/verify asymmetric key operations
> all working, and used your ASN1 template for parsing (just copied it
> into asymmetric_keys for now). Since the asymmetric operations use
> HMAC sessions I didn't see much carry over from your patches (but
> this could change if policy stuff gets introduced).

There's a related patch that introduces HMAC and encryption sessions
for pretty much everything in the TPM:

https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership.com

I didn't resend this time around because of patch overload, and anyway,
the last patch needs updating for the current policy c

> This will go in the eventual RFC soon but while I have you here:
> 
> I also implemented key wrapping. Exposing this as a keyctl API may
> take some rework, hopefully with some help from others in this
> subsystem.

Wrapping for what?  The output privkey in the ASN.1 is wrapped by the
TPM using its internal AES key.  The ASN.1 also defines ECDH wrapping,
that's what the secret element of the sequence is for, but you'd only
use that for creating a wrapped key to pass in to the TPM knowing the
parent.  The way current TPM crypto systems use this is they generate
an EC parent from the storage primary seed on the NIST P256 curve.

It's on my todo list to accept bare primary identifiers as parents in
the kernel code and create the EC primary on the fly, but it's not in
this patch set.

There's also another policy problem in that generating an RSA2048 key
can lock the TPM up for ages, so there should likely be some type of
block on someone doing this.  I was thinking that an unprivileged user
should be allowed to create EC keys but not RSA ones.

> As it stand now you have to padd a key pair, then do a (new)
> pkey_wrap operation on it. This returns a DER with the wrapped TPM2
> key. This required modifying the public_key type, which I really did
> not like since it now depends on TPM. Not sure if the route I went is
> gonna fly without tweaking, but this is all new to me :) Again, some
> guidance for how this should be is needed.

The way it's defined to be done using the ASN.1 secret parameter is
simply the way the TPM2 command manual defines duplication with an
outer wrapper.  The TPM2 manual even has a coded example in section 4
and the secret is simply a TPM2B_ENCRYPTED_SECRET.

> Before I send these patches I need to get some testing done on real
> TPM2 hardware. So far its just been emulation. But these patches
> should be coming very soon.

Sure thing, but you may want to look at some of the existing code that
this will need to interoperate with.  The most complete is the openssl
engine, but there's also the intel version of that and openconnect
which all use the same key format:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

Regards,

James

