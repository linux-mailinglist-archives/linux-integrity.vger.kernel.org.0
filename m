Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7BA170D23
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 01:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgB0AZH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 19:25:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37611 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AZH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 19:25:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so644178pfn.4;
        Wed, 26 Feb 2020 16:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3CadKvM+eCMUxmC/eeBKQK/q7RdQUMJE+pGfasasc0=;
        b=eAvdWDWa4oIsZt/4lu6e6OLMh3JPN60GBnGWYZuD7+i5Ayp8Li4BnUCXtumPefXKwe
         EJEKh9Kddo5aeD8Zy6AmZuoQqyQAZCfHHwuu8SKVXostYsmRvHW3imFfhkRtOjVJ5WZQ
         zebz+DHmlUZtm/LoPIuC/x9NeGROmexu9qiJVskF84Bippje0NKGB07w31MjfpAQMumD
         0sMrBR/btgs57xNdxJXTVVUTZC7KmPk0rkNOzW0tJw19Uagg5Z0Ymvi87tWgs7Iye4y0
         Bs7D0IuBCBMvQUFhJRBiMfrpBEqub2AqaZlh+B2iEYC+T1LveoseoY2mQR0ude+FEkla
         Jaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3CadKvM+eCMUxmC/eeBKQK/q7RdQUMJE+pGfasasc0=;
        b=q2ZXypJncpcH7f1BRiiBx/YROPJW8PkWqnMdjioyjwle69OJ9qvzjXYlD+3gjCWpKC
         s0QI+iXc6iUJnU2DxuXWTZ0qhA2IK5CSqPtJ2dNhuygKdO00EiYEWwN7SHug64DCxn2X
         AdwmIpVntUHb+7ERvIJ9gYiZV8dZItArWwucwWYtfpDFjF79KzVP0nz1P9gANgCGiIgd
         CKWymtPZ0luhgckpRUG0RG+mlsc0CAV/8ZXtbF3OC+4gIt2OF4+NSJmdkwwW0zt0kWSI
         2yGVoEQvOWxI/nI0oRpmtbNawzoR53zISFhAiW/aViycG3yp7eyvxoC9R5wug6zWlar8
         SpJw==
X-Gm-Message-State: APjAAAX8TTCKgUlSkRkFFIGkyXSt4kxZKCXrCC5xCTq1V622QP9Kx8JF
        OF9UHLjBf0B5ro0KD46X9+Q=
X-Google-Smtp-Source: APXvYqwBunRBcHBLq+dmv6mUtoq2op4kUNwYTpW7OgBcn4LrCXVlNEaV8iTwe61ev3QmYvVOPz+eSg==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr1374646pfk.112.1582763105984;
        Wed, 26 Feb 2020 16:25:05 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id d23sm4332535pfo.176.2020.02.26.16.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 16:25:05 -0800 (PST)
Message-ID: <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:20:38 -0800
In-Reply-To: <1582761736.4245.12.camel@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > I have been using your set of patches in order to get this ASN.1
> > parser/definition. I am implementing an asymmetric key parser/type
> > TPM2
> > keys for enc/dec/sign/verify using keyctl. Note that this
> > implementation goes in crypto/asymmetric_keys/, and your patches
> > sit
> > in
> > security/keys/trusted-keys/.
> > 
> > Currently I am just including "../../security/keys/trusted-
> > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1
> > parser
> > to verify my keys, but this obviously isn't going to fly.
> > 
> > Do you (or anyone) have any ideas as to how both trusted keys and
> > asymmetric keys could share this ASN.1 parser/definition? Some
> > common
> > area that both security and crypto could include? Or maybe there is
> > some common way the kernel does things like this?
> 
> Actually TPM2 asymmetric keys was also on my list.  I was going to
> use
> the existing template and simply move it somewhere everyone could
> use. 
> I also think you need the policy parser pieces because at least one
> implementation we'd need to be compatible with supports key policy.

In terms of policy, I haven't looked into that at all for asymmetric
keys. I do already have enc/dec/sign/verify asymmetric key operations
all working, and used your ASN1 template for parsing (just copied it
into asymmetric_keys for now). Since the asymmetric operations use HMAC
sessions I didn't see much carry over from your patches (but this could
change if policy stuff gets introduced).

This will go in the eventual RFC soon but while I have you here:

I also implemented key wrapping. Exposing this as a keyctl API may take
some rework, hopefully with some help from others in this subsystem. As
it stand now you have to padd a key pair, then do a (new) pkey_wrap
operation on it. This returns a DER with the wrapped TPM2 key. This
required modifying the public_key type, which I really did not like
since it now depends on TPM. Not sure if the route I went is gonna fly
without tweaking, but this is all new to me :) Again, some guidance for
how this should be is needed.

Before I send these patches I need to get some testing done on real
TPM2 hardware. So far its just been emulation. But these patches should
be coming very soon.

Thanks,
James


 

> 
> Regards,
> 
> James
> 

