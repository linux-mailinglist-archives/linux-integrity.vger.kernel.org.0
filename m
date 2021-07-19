Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F305B3CCF20
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhGSIJ0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhGSIJZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 04:09:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692DC0613DB
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 01:06:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f30so28800666lfj.1
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7EMzH3aAsHkgh4oi6xqy9qUOqO8CbBG7b1bzqeCZMWU=;
        b=QmF/6AEU+CeklpqEfSixTUxLuHjmhtOIhJLUi0gaDtnbU4LFHke9We2fcWDJCU23Av
         oRcOiC0em74DTMzbEkMS1lAuvEF4jq/T3cyvdjLORjNZLkHLc97R8cL2dlb4gF/i4GFk
         r0cHOJ0QepwM1K2l5hxl/Uo8yRJzyYEBmnlABG6XRHwswY2IxeSDn3GoflBHyicH/kjS
         c5u55X/xWb3h0kvVCycWaqv8ggs4JnzdWF6SuexKwjLHlBg6Na8onXn2BHMK8w+LBwS5
         XTibeJJEIviVkmwmufbtTVARh/26ukJIxandpLeLUkUfI/o1CC18qMYadOQYT1YRwZgf
         UYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7EMzH3aAsHkgh4oi6xqy9qUOqO8CbBG7b1bzqeCZMWU=;
        b=nzA/qwt2jeZcZl6OQrO3DIIw4xw4LTsnyz2yyExJMhOLc+HLUyXH5hLndGK/FEGOGf
         r+Ew2EfykoO8XTJdKkqUeFBBTAi1tvD3c6S8Q8BWmq77DZ4AgzrEjuM6jfNU5M4soV9P
         rYQYkisQ4dGY3apYRGOC/Z05oLM0W9PMvW/LGfJhpekqS+oudi3FCu8eJIQ1s9vk4Tar
         A9R2Hkrw2byoz4GVMDdNYwno4zlHqK3EneCID0qp6Pa7/gwHUHcKQ+83Pp33IoXXS6GD
         LqHIMSzi0OpwN8hOH1y+knBL0YsfIX0gNw5of99j+6o/JvJValuHZ63ACqmtz/oqKgoW
         JHSQ==
X-Gm-Message-State: AOAM530jZ0lar+rRasAxrDY2XFTQFt+xnZnsFTqt/nNmh8q5Q75QvG2K
        b9/SqfUNx05k3qfXjeRzQr5kHmm/CkUFMvlbMxMq0g==
X-Google-Smtp-Source: ABdhPJzFIEFTWME4XmrM7h5S73WUBmKqTsf1vSjelGT7qEGYcDwzAuj2oRvAaaoQWoT7z6nvPJ94t2UxgcP4IMxPaWM=
X-Received: by 2002:a05:6512:2115:: with SMTP id q21mr17559808lfr.546.1626681981148;
 Mon, 19 Jul 2021 01:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210716081722.4130161-1-andreas@rammhold.de> <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
In-Reply-To: <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 19 Jul 2021 13:36:09 +0530
Message-ID: <CAFA6WYNC2xasX4uKmgcK+ZmA4HUh5PhCci+e12VFWPfF0b0eWQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as module
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andreas Rammhold <andreas@rammhold.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 19 Jul 2021 at 12:40, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Andreas,
>
> On 16.07.21 10:17, Andreas Rammhold wrote:
> > Before this commit the kernel could end up with no trusted key sources
> > even thought both of the currently supported backends (tpm & tee) were
> > compoiled as modules. This manifested in the trusted key type not being
> > registered at all.
>
> I assume (TPM) trusted key module use worked before the TEE rework? If so=
,
>
> an appropriate Fixes: Tag would then be in order.
>
> > When checking if a CONFIG_=E2=80=A6 preprocessor variable is defined we=
 only
> > test for the builtin (=3Dy) case and not the module (=3Dm) case. By usi=
ng
> > the IS_ENABLE(=E2=80=A6) macro we to test for both cases.
>
> It looks to me like you could now provoke a link error if TEE is a module
> and built-in trusted key core tries to link against trusted_key_tee_ops.
>

That's true.

> One solution for that IS_REACHABLE(). Another is to address the root caus=
e,
> which is the inflexible trusted keys Kconfig description:
>
> - Trusted keys despite TEE support can still only be built when TCG_TPM i=
s enabled
> - There is no support to have TEE or TPM enabled without using those for
>   enabled trusted keys as well
> - As you noticed, module build of the backend has issues
>
> I addressed these three issues in a patch[1], a month ago, but have yet t=
o
> receive feedback.

That's an oversight on my part since this patch was part of the new
CAAM trust source patch-set. Although I do admit that it was on my
TODO list. So I have provided some feedback on that patch. Can you
post the next version as an independent fix patch?

-Sumit

>
> [1]: https://lore.kernel.org/linux-integrity/f8285eb0135ba30c9d846cf9dd39=
5d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de/
>
> Cheers,
> Ahmad
>
> > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > ---
> >  security/keys/trusted-keys/trusted_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/=
trusted-keys/trusted_core.c
> > index d5c891d8d353..fd640614b168 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, char=
p, 0);
> >  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> >
> >  static const struct trusted_key_source trusted_key_sources[] =3D {
> > -#if defined(CONFIG_TCG_TPM)
> > +#if IS_ENABLED(CONFIG_TCG_TPM)
> >       { "tpm", &trusted_key_tpm_ops },
> >  #endif
> > -#if defined(CONFIG_TEE)
> > +#if IS_ENABLED(CONFIG_TEE)
> >       { "tee", &trusted_key_tee_ops },
> >  #endif
> >  };
> >
>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
