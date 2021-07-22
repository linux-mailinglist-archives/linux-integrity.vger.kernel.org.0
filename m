Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF63D1E0E
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGVFhT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 01:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhGVFhS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 01:37:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB46C0613C1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 23:17:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v6so6813862lfp.6
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WORoTGHF102QmcPLJnYL0wl9JDz1GesGd0P0NJ/o4VY=;
        b=IHTNNSIGRh52lvqCaFt1jBoEW1/opFfVCgkb3Ln7p1RrwsNMrPogYpKHKMMe9ZTH+C
         Uqjx6nU7X5lHZNtAN8gMsvTGS201uow8OyfcWgp3zzsVPXuTzeQpm/UUdNedfMCXntId
         ISSOQCRoPSssGaJBTa/LKtraNnxMiWYjk1SRg0Ft+x4aBgzji4CD9BwNRrQfp8pKGSLO
         WdWy5q3j5ewpdwNwB52IwOcvRn3Zx1KZPg6I/AEg7XnE8o4p8/Mkjd9UR493w0QTtIa4
         kFIPi3a4t4xPHnCcYC3hZhRtGpszwAFy+MWqjWqxpfsP7PHayUf1qyhDTjG3I54knlkp
         WyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WORoTGHF102QmcPLJnYL0wl9JDz1GesGd0P0NJ/o4VY=;
        b=HzJ1skl453smIH6w6UlFiCw/FQGu7PJB7B++CHrbkdj74MY5m99hEeYvQitDCA+2AY
         JuDbdjCCP0Kt4ZjQmXki1otm5FAqmJP+8juNgoNpRfsf0z/ug2p5l2Rj1OHtFHN+2dVj
         3/l0FRKXegbrvSHPf7i5t5F+eb6YCQFv0KAGhJq6xUq23ZYPtjdQfIdhhQFjhulnjORk
         csnS7aeeFyoqDgPH3ifHUBlqMezDUu6BO1GoC7UJPdrt3OlTrqffxbaJgYChEWvQWZeL
         7eaF+l177nF/2d+rl3WuuPufU69lgm50kWKzsoIDmjDB/O6tgHC8onAfENp9lnajXdAv
         4ioA==
X-Gm-Message-State: AOAM532UJD1Ass3ZwfpJNF9ARGxWYv2a2AHvZwfgEzr1yojgvvzGQBOw
        mOkZjr8e/EcurUhUwlYjVDktb1AjE1Y2XivYAAiEnA==
X-Google-Smtp-Source: ABdhPJxwqkYYSDj6ayPNqBy3Xzy0MH1wQFA8Q/nRMaU5NRIQDMZn4xDFUsJiqwUgCaiyv5WVxn3f5GLhYq4kN7GFzj4=
X-Received: by 2002:a19:6e0d:: with SMTP id j13mr27727553lfc.108.1626934672014;
 Wed, 21 Jul 2021 23:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <3b93fda0155af1a8776e9cc9984ecdb39ce827e4.1626885907.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <3b93fda0155af1a8776e9cc9984ecdb39ce827e4.1626885907.git-series.a.fatoum@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 22 Jul 2021 11:47:40 +0530
Message-ID: <CAFA6WYOjXtFtVgviZtdGhf_MpTP6AQrtaPfju0AwEAYMDL=5hQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KEYS: trusted: allow users to use kernel RNG for key material
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 21 Jul 2021 at 22:19, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> The two existing trusted key sources don't make use of the kernel RNG,
> but instead let the hardware doing the sealing/unsealing also
> generate the random key material. However, Users may want to place
> less trust into the quality of the trust source's random number
> generator and instead use the kernel entropy pool, which can be
> seeded from multiple entropy sources.
>
> Make this possible by adding a new trusted.kernel_rng parameter,
> that will force use of the kernel RNG. In its absence, it's up
> to the trust source to decide, which random numbers to use,
> maintaining the existing behavior.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> To: James Bottomley <jejb@linux.ibm.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geant=C4=83" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt   |  7 ++++++-
>  Documentation/security/keys/trusted-encrypted.rst | 20 +++++++++-------
>  security/keys/trusted-keys/trusted_core.c         | 17 +++++++++++++-
>  3 files changed, 35 insertions(+), 9 deletions(-)
>

Sounds like a reasonable approach to me.

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index bdb22006f713..0267ead88902 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5734,6 +5734,13 @@
>                         first trust source as a backend which is initiali=
zed
>                         successfully during iteration.
>
> +       trusted.kernel_rng =3D    [KEYS]
> +                       Format: <bool>
> +                       When set to true (1), the kernel random number po=
ol
> +                       is used to generate key material for trusted keys=
.
> +                       The default is to leave the RNG's choice to each
> +                       individual trust source.
> +
>         tsc=3D            Disable clocksource stability checks for TSC.
>                         Format: <string>
>                         [x86] reliable: mark tsc clocksource as reliable,=
 this
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index 80d5a5af62a1..1d4b4b8f12f0 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -87,22 +87,26 @@ Key Generation
>  Trusted Keys
>  ------------
>
> -New keys are created from random numbers generated in the trust source. =
They
> -are encrypted/decrypted using a child key in the storage key hierarchy.
> -Encryption and decryption of the child key must be protected by a strong
> -access control policy within the trust source.
> +New keys are created from random numbers. They are encrypted/decrypted u=
sing
> +a child key in the storage key hierarchy. Encryption and decryption of t=
he
> +child key must be protected by a strong access control policy within the
> +trust source. The random number generator in use differs according to th=
e
> +selected trust source:
>
> -  *  TPM (hardware device) based RNG
> +  *  TPM: hardware device based RNG
>
> -     Strength of random numbers may vary from one device manufacturer to
> -     another.
> +     Keys are generated within the TPM. Strength of random numbers may v=
ary
> +     from one device manufacturer to another.
>
> -  *  TEE (OP-TEE based on Arm TrustZone) based RNG
> +  *  TEE: OP-TEE based on Arm TrustZone based RNG
>
>       RNG is customizable as per platform needs. It can either be direct =
output
>       from platform specific hardware RNG or a software based Fortuna CSP=
RNG
>       which can be seeded via multiple entropy sources.
>
> +Optionally, users may specify ``trusted.kernel_rng=3D1`` on the kernel
> +command-line to override the used RNG with the kernel's random number po=
ol.
> +
>  Encrypted Keys
>  --------------
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index 8cab69e5d0da..569af9af8df0 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -16,12 +16,17 @@
>  #include <linux/key-type.h>
>  #include <linux/module.h>
>  #include <linux/parser.h>
> +#include <linux/random.h>
>  #include <linux/rcupdate.h>
>  #include <linux/slab.h>
>  #include <linux/static_call.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>
> +static bool trusted_kernel_rng;
> +module_param_named(kernel_rng, trusted_kernel_rng, bool, 0);
> +MODULE_PARM_DESC(kernel_rng, "Generate key material from kernel RNG");
> +
>  static char *trusted_key_source;
>  module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> @@ -312,8 +317,14 @@ struct key_type key_type_trusted =3D {
>  };
>  EXPORT_SYMBOL_GPL(key_type_trusted);
>
> +static int kernel_get_random(unsigned char *key, size_t key_len)
> +{
> +       return get_random_bytes_wait(key, key_len) ?: key_len;
> +}
> +
>  static int __init init_trusted(void)
>  {
> +       int (*get_random)(unsigned char *key, size_t key_len);
>         int i, ret =3D 0;
>
>         for (i =3D 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> @@ -322,6 +333,10 @@ static int __init init_trusted(void)
>                             strlen(trusted_key_sources[i].name)))
>                         continue;
>
> +               get_random =3D trusted_key_sources[i].ops->get_random;
> +               if (trusted_kernel_rng)
> +                       get_random =3D kernel_get_random;
> +
>                 static_call_update(trusted_key_init,
>                                    trusted_key_sources[i].ops->init);
>                 static_call_update(trusted_key_seal,
> @@ -329,7 +344,7 @@ static int __init init_trusted(void)
>                 static_call_update(trusted_key_unseal,
>                                    trusted_key_sources[i].ops->unseal);
>                 static_call_update(trusted_key_get_random,
> -                                  trusted_key_sources[i].ops->get_random=
);
> +                                  get_random);
>                 static_call_update(trusted_key_exit,
>                                    trusted_key_sources[i].ops->exit);
>                 migratable =3D trusted_key_sources[i].ops->migratable;
> --
> git-series 0.9.1
