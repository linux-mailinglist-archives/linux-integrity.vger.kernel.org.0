Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D179EAE
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 05:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCEEnc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Mar 2020 23:43:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36702 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEEnb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 23:43:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id 195so4539267ljf.3
        for <linux-integrity@vger.kernel.org>; Wed, 04 Mar 2020 20:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ig10XyduVsZjw4w3HMmJwxDdosoLr+guVyiHfv8gK0=;
        b=Jlh/X/YEDONR3IOXn6nxoGLEnIeUJ3iyKiyAQ8f2QzEuxov1wR2zT1eYqvUS/AYq5F
         9xHKaOXV0yEACS/FXpwgnh2EKdpPwjrEPNNO38PqKTEuWZ+CgHMEwxD+HkI/LrROg0hB
         YR3i/KCqEdPBTwRaDSSs6L8tGCWX06xKdweZavMUm33yUpnoFnrH4RYiYlcaChAFOVvZ
         KMPno2mNmtNw9VAltjQmUnFMUWGuvmu27lO9GnhA3PQ9MW/a3wqk5feEPtyUZOVBJWrn
         cSfYJGa9xuYJA+pyDxU4wQ67Y1qe43jCIoAmUSBHTThkEO5AzWYbhrpNVcYGxEe+uP/M
         Dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ig10XyduVsZjw4w3HMmJwxDdosoLr+guVyiHfv8gK0=;
        b=LFZNGx8w1duYL9qihj4tzF6agVyPyrfS2vL4pBy/4XhRD9LuhGnnjhZsC3SjS0IIPl
         HuwuNYR0nVTPgEU9pCb2048LeP07diMZdFw2/+K/VBYqUhbSccpLrCDxc9MN1N2qH5jt
         dVftFa+Z0Q38uL1pvNG9PgG6j+epAQ7vjVgp6epiQ6S/xsYTUCcIRCN3+1X3R3WohF/c
         7NgDJ+vgWx3R6IFVkJFmVNNws6ii936p44uQIj+sSspS4nvAgW1YYXS8MKypAq0ws8EU
         E5283/6cM0O3XZpOOHouUx8nIJa3jWjYBD5S6yTB3vCQx3CaT4HO3NcN59YU9aQWYLDy
         3xxQ==
X-Gm-Message-State: ANhLgQ2w2cUFaAMEccfPjGSxVJNXsgLnPSwM28z9JNANmsa0wNNojQEh
        bbgn2YEKzIqECvT1QEHAre/w/kXRhK0OiRYPt6YHog==
X-Google-Smtp-Source: ADFU+vsdtsIPN/hjdmMTRmXabwL436fmEFM1KY5oGBIXd3XKcqkjLBih3S1oNvDRDLlp88m5djXZztpTsxX2PHnpxUg=
X-Received: by 2002:a05:651c:147:: with SMTP id c7mr3817550ljd.206.1583383407161;
 Wed, 04 Mar 2020 20:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20200304211254.5127-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200304211254.5127-1-lukas.bulwahn@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 5 Mar 2020 10:13:15 +0530
Message-ID: <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: adjust to trusted keys subsystem creation
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 5 Mar 2020 at 02:43, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> to trusted-keys/trusted_tpm1.c in security/keys/.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: security/keys/trusted.c
>   warning: no file matches F: include/keys/trusted.h
>
> Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> files in security/keys/ are identified as part of KEYS-TRUSTED.
>

I guess you meant here security/keys/trusted-keys/ instead of security/keys/.

-Sumit

> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Changes to v1:
> - use a global pattern for matching the whole security/keys/ directory.
> Sumit, please ack.
> James or Jarkko, please pick this patch v2.
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c755e03ddee..7f11ac752b91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9276,8 +9276,8 @@ L:        keyrings@vger.kernel.org
>  S:     Supported
>  F:     Documentation/security/keys/trusted-encrypted.rst
>  F:     include/keys/trusted-type.h
> -F:     security/keys/trusted.c
> -F:     include/keys/trusted.h
> +F:     include/keys/trusted_tpm.h
> +F:     security/keys/trusted-keys/
>
>  KEYS/KEYRINGS
>  M:     David Howells <dhowells@redhat.com>
> --
> 2.17.1
>
