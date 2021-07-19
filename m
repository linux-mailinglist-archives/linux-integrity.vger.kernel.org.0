Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4D3CCDE2
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhGSG37 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbhGSG36 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 02:29:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A6C061762
        for <linux-integrity@vger.kernel.org>; Sun, 18 Jul 2021 23:26:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so28278786lfs.11
        for <linux-integrity@vger.kernel.org>; Sun, 18 Jul 2021 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lPCqQljJf2IbScxAFf1031HOfRkixI8y+inmwaEQLU=;
        b=z2jvnSeXzDI9LPibiAzjKQbSIyzToX8RVGLxm1q6JUMlUH1kl0pL+3wgTp6oW882g1
         xyogIuA7XaCw1fRG5z7RhOMgH7biVV5AJlOQdCUiWu3H+tGYqv9Tt7WoqluESFL1MZMM
         OHBSr0ZQ02dme41z/gRxG57q+hi8wfHMVnKtqMsq3xhqnqG/s2gfePY6gNoS7TLPCo6k
         tke5hJgz9GFURVOKSr8GxysmbIi3gC/Mv9BHcGYzVkYS5BQUlGSei4TOQO5jBnXilObb
         DdjvuG4IVAo/JDgW2wnUXhK6joE88nG97kREx8s15jqnx1MJVFWv4ljjNeTnvwnZfN6v
         zioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lPCqQljJf2IbScxAFf1031HOfRkixI8y+inmwaEQLU=;
        b=NhUyjpdKxocb9Ss8V4BW8VkRsRfnbTUHx7uqeC8qPa23SaHv9VeA/E93I65Nskaynr
         GFYpTim8FMgjsTR5Ai8Z3mYMymwv9dMKXvFAAVs9f5XYXUgCP2kj2C4HwgL5r3fB1Fcf
         n3MzPJqajO52gTAXWK1cPU6PM1Q6EvDytUhhRhWIZB6HMGk7q6ttIke1JJOgunmKtWvJ
         oQ1LCJnXW++2qWRjGVySRTytS25BcfgS/GpwNRN1dX7uWElH3k1lAqw0fhNcci2/hkUX
         8m/3AIH/xKJ8y+f4jXntXTuR0WLMQ49LdTiogVhLPggaYApnw4SVWa9ny65BHrqEf9Cp
         nx7Q==
X-Gm-Message-State: AOAM5301CiFjvUQZ6r0jU/lwGFtdiFIvzhK1q61qfOuZRaTQXcoeA1Bn
        HKqTICN5aogEF0h2mU6lZ6bgjaeOt8Gym/nqVDuvSJ6XcxCpyA==
X-Google-Smtp-Source: ABdhPJwcVB5VSPOP+/OH08BW5Jay0hN57oGFKlGhOhwsFjFhAJ5AjL1LvhtxB4k5IkyqvZfHbetmuyk5aibT9lfPDQ0=
X-Received: by 2002:a19:c757:: with SMTP id x84mr17381730lff.302.1626676016627;
 Sun, 18 Jul 2021 23:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210716081722.4130161-1-andreas@rammhold.de>
In-Reply-To: <20210716081722.4130161-1-andreas@rammhold.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 19 Jul 2021 11:56:45 +0530
Message-ID: <CAFA6WYNu+XxESXKLUQ8k3TDY18n1Y-R7m9=iTp-BerU69wLWdg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as module
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 16 Jul 2021 at 13:54, Andreas Rammhold <andreas@rammhold.de> wrote:
>
> Before this commit the kernel could end up with no trusted key sources
> even thought both of the currently supported backends (tpm & tee) were

s/thought/though/

> compoiled as modules. This manifested in the trusted key type not being

s/compoiled/compiled/

> registered at all.
>
> When checking if a CONFIG_=E2=80=A6 preprocessor variable is defined we o=
nly
> test for the builtin (=3Dy) case and not the module (=3Dm) case. By using
> the IS_ENABLE(=E2=80=A6) macro we to test for both cases.
>

s/to/do/

> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Apart from minor nits above, add a corresponding fixes tag. With that:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index d5c891d8d353..fd640614b168 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp,=
 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>
>  static const struct trusted_key_source trusted_key_sources[] =3D {
> -#if defined(CONFIG_TCG_TPM)
> +#if IS_ENABLED(CONFIG_TCG_TPM)
>         { "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if IS_ENABLED(CONFIG_TEE)
>         { "tee", &trusted_key_tee_ops },
>  #endif
>  };
> --
> 2.32.0
>
