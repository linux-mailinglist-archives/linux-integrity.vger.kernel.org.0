Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132783DB283
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 06:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhG3Eyc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jul 2021 00:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhG3Eya (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jul 2021 00:54:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED8C0613C1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jul 2021 21:54:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x8so1934781lfe.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jul 2021 21:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=26cLx9q8rosx/ecicZmvDaHKsvwoSzGuRC6wOLHJtNA=;
        b=yeXSbxyDokjWczrODAJejItwOt0diRi24EVgseJepoyLiTGg0kPU35xi2yf5GagW6+
         3wG4Bau8c1dHU6UeYua5l5rfEbpGmvsoVlpSal5dvilE6nLhbFVN9Z73CVXoFV90KlQH
         RIUxRAT6Jt68PZxtDjlVNAce3gBCrjFNG+UFWJ4wYa9b3lUovEPEin/mmo+CoflEVYcT
         y2sOO3WKfJDF8dPmDiQIttBY63S/MbdfRCzZ1qSQN3x9ZjFBzK4N2pHRv0FnluYi18Sd
         AdulqBhQc6CkWdduK44cDMDUFVifP9JDps6RZ3YYwRkXoNtg28D7TK/BABEbt4mtnw+H
         zxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=26cLx9q8rosx/ecicZmvDaHKsvwoSzGuRC6wOLHJtNA=;
        b=UgXluK2F3B0utBrudhKEz9Ln9QUjsG/cmNmYNQvrmsBn+57loEZjb48zMMHxLsIblz
         jpMYLEiXtUTi4jqEfnvUyv+kO5NyrFXMCE/7auclvXCtE8Vyd7JtUgX+mfkqRCCtewWg
         Uye6Olifr6vSWjL+NizFKnvdr6k1qwgLd1sTEvcUHOINmZNqt6JtDpss7kxKCNvoHL3F
         cUy+zY+YanZo+DzA2ALqN7EOhIq7vuL5350Fz5Q3ZEp8Oy7j0+3kH+w+x4TennPFk5Zz
         DuhxjyJU10Q7EDGuoFP/DUsAFPKTF0PpI2Ww/KrKINds5eahcQSK98VzJEJqcy6hlGep
         b1kw==
X-Gm-Message-State: AOAM533rdy1b8ql4Ayo9bHxhc7nZ+OHmZdn2mC+GWib8K4If2zDAebkM
        BrLM4sFN3SpsVyTeJpXScwNEYW0hDsEF+49BuAnfGQ==
X-Google-Smtp-Source: ABdhPJxWONtco8cudb0xi/7JqnX8J1mzvb8nmBW+OW7JqUn+9cAKU5U7NTUu+oYM9hY+mM/ySDySXyVichecYCRWqEE=
X-Received: by 2002:a19:6e0d:: with SMTP id j13mr459081lfc.108.1627620864329;
 Thu, 29 Jul 2021 21:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210730012822.3460913-1-andreas@rammhold.de>
In-Reply-To: <20210730012822.3460913-1-andreas@rammhold.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 30 Jul 2021 10:24:12 +0530
Message-ID: <CAFA6WYNbMD5rEraT5OP1BaZ6bFq6v2OpEKQ2+amHL_+s485P=w@mail.gmail.com>
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when building
 as module
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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

On Fri, 30 Jul 2021 at 06:58, Andreas Rammhold <andreas@rammhold.de> wrote:
>
> Before this commit the kernel could end up with no trusted key sources
> even though both of the currently supported backends (TPM and TEE) were
> compiled as modules. This manifested in the trusted key type not being
> registered at all.
>
> When checking if a CONFIG_=E2=80=A6 preprocessor variable is defined we o=
nly
> test for the builtin (=3Dy) case and not the module (=3Dm) case. By using
> the IS_REACHABLE() macro we do test for both cases.
>
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> ---
>
> v3:
> * Fixed patch formatting
>
> v2:
> * Fixed commit message
> * Switched from IS_DEFINED() to IS_REACHABLE()
>
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

LGTM.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index d5c891d8d353..5b35f1b87644 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp,=
 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>
>  static const struct trusted_key_source trusted_key_sources[] =3D {
> -#if defined(CONFIG_TCG_TPM)
> +#if IS_REACHABLE(CONFIG_TCG_TPM)
>         { "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if IS_REACHABLE(CONFIG_TEE)
>         { "tee", &trusted_key_tee_ops },
>  #endif
>  };
> --
> 2.32.0
>
