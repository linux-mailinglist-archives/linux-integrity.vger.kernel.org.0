Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12443D1E46
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhGVFvS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhGVFvR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 01:51:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179AC0613C1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 23:31:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b26so6873964lfo.4
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CYkqe4g3VLBX8Hb5LmueO3C4AbVGUfd62D9jkXzQh10=;
        b=mU/g1ltZPaGC8L3S24o+kCRancRgTxYtCXBsV2f759apd/DxxumZVbmGBi4VgZZ0Xm
         ZAlExAwX63zwUgqwWo/2I9L0Rsq3PPO+xrrQbTpNbBUSbVdSEAi6HRP1Ilz/+39omogt
         94uarhbtVjF0zRLc29bKdj72vCI5qYaoEiVgFW4pCpNLAduzpZoIED5F4okKq37ZpHGx
         zmyZuyoziTl3SVfODmss6VMTDi7IyXZz2L6mSLtMTawBcqYVo07WFopVgMThm+tEUTnE
         GkgnBfYgJlJdqdj7J0yv+83/xeygDILfhHLbd6BfPqQo8hne57nTJp57sUgwuiMW++8k
         O5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CYkqe4g3VLBX8Hb5LmueO3C4AbVGUfd62D9jkXzQh10=;
        b=Jgx34OenVgYfex6Qc9jKGqvK0MboQziY3YAAtTUxejdlD+I4i7IkmXWlNALibjrCue
         t686wFomb9dq7zby2zBl8kq+WWDcgVSnfYEiuDzUBOmMjZHs3fD1d3SgSb5GwkliB+E4
         xNpEke00e42A/cbVXAofjGdvGvUEw1qQJtfaGVrMHPT4OGQZtjvF2WD59cpCzjbH5q4w
         txD4zHZ53dxr2RvY1q6o9eVxB2caAKBDvbT7GnJO2VLbBm2kZgLYUnqI8/v9zHyZtucy
         5wySUsOl1SmTttp+GNxyCMHkChtpRls1/2kGojiFxtJooShAqPPhUOXZJ8J794cLszsO
         9RUw==
X-Gm-Message-State: AOAM531ZS6xhBYQ6Q5eEUxn0i/f5e2lhec30EorgPmXY3MQbOtHi/2x2
        QLm7DYGOxqPbeP0Z8Prt6H8givdy2YbOmSKFLL7aeQ==
X-Google-Smtp-Source: ABdhPJw7K0q3fw+k/PMYcM9dTkSADGg9BbZSydjrjfGRXUG8kRxrNL2OPsAA1EKRSD6SFd7GgLJ2JALBc22ZPQzXJSw=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr28933803lfb.396.1626935511146;
 Wed, 21 Jul 2021 23:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <7b771da7b09a01c8b4da2ed21f05251ea797b2e8.1626885907.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <7b771da7b09a01c8b4da2ed21f05251ea797b2e8.1626885907.git-series.a.fatoum@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 22 Jul 2021 12:01:40 +0530
Message-ID: <CAFA6WYOskwZNe5Wb5PTtnSHQBonSXZ48eEex0w9jQ+JW4vG=+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] KEYS: trusted: allow trust sources to use kernel RNG
 for key material
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
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
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
> but instead let the hardware that does the sealing/unsealing also
> generate the random key material. While a previous change offers users
> the choice to use the kernel RNG instead for both, new trust sources
> may want to unconditionally use the kernel RNG for generating key
> material, like it's done elsewhere in the kernel.
>
> This is especially prudent for hardware that has proven-in-production
> HWRNG drivers implemented, as otherwise code would have to be duplicated
> only to arrive at a possibly worse result.
>
> Make this possible by turning struct trusted_key_ops::get_random
> into an optional member. If a driver leaves it NULL, kernel RNG
> will be used instead.
>
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
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
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
>  include/keys/trusted-type.h               | 2 +-
>  security/keys/trusted-keys/trusted_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index d89fa2579ac0..4eb64548a74f 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -64,7 +64,7 @@ struct trusted_key_ops {
>         /* Unseal a key. */
>         int (*unseal)(struct trusted_key_payload *p, char *datablob);
>
> -       /* Get a randomized key. */
> +       /* Optional: Get a randomized key. */
>         int (*get_random)(unsigned char *key, size_t key_len);
>
>         /* Exit key interface. */
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index 569af9af8df0..d2b7626cde8b 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -334,7 +334,7 @@ static int __init init_trusted(void)
>                         continue;
>
>                 get_random =3D trusted_key_sources[i].ops->get_random;
> -               if (trusted_kernel_rng)
> +               if (trusted_kernel_rng || !get_random)
>                         get_random =3D kernel_get_random;
>

For ease of understanding, I would prefer to write it as:

                  get_random =3D trusted_key_sources[i].ops->get_random ?:
                                         kernel_get_random;
                  if (trusted_kernel_rng)
                        get_random =3D kernel_get_random;

With that:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>                 static_call_update(trusted_key_init,
> --
> git-series 0.9.1
