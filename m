Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7617B5F1
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 06:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCFFDi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 00:03:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34905 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFFDi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 00:03:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id a12so827417ljj.2
        for <linux-integrity@vger.kernel.org>; Thu, 05 Mar 2020 21:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgxoDxn7isDbqiNeMSbGlbVvXyla56aJBv3ggEco/PY=;
        b=E8lu+LYma2rUzzVLjzv803SdKxb/mmqJINwt+kVzCr50akNjAHIqfLHEHSq3AK1s0d
         LAeVE4fGwQilvoc6vLqK838TwlJt/87H8RzRJ944G1/fmdefzX5Bx9azRIREdMugAOag
         kjCTPr1fgB2tUoJ0L8gVAkYCrwQl/aePJLY/NsPQCuujnSbIfSXUXqZ5e3hTOUaDWYBK
         lNYiInm4uQH092xZHtXJ7YzVpqp4raUa6GMT+lPC7c23ucBCxjqje/4KrDK6dzYOfZb8
         ZuUswKlrv5Fm9ZKOTVijKvnboDaKsCIVP3r93Bv7/OKFjjlQge9aBkyldBOQPusQ+cp7
         jfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgxoDxn7isDbqiNeMSbGlbVvXyla56aJBv3ggEco/PY=;
        b=V9vMpYULcE21zP2Q1gFVjg8hiaWcOKmExezyFebTp9HuWkLd6qWrAxO4wrQ7RGfa4Q
         FgyQFfkpVoQisQho2pnqNVtugudJqXzD2JF8VjcwNbSjZ/n+s84iyyQGZOy9FdNhvj79
         7xHg4vXjUw+D75++TFrzCArVGGyl5KN3tE3ydz4ITh74grUOLX6378rAEskUxhMKRZND
         TI9Fy+JmqPCXZwinnh95Y+SdroRbecutFr4AXAckt5wSYQBK8pgpSQhEwePLDK/Pp9fR
         dNyo/YbQ5+LNHc1o0yPEYMOlAXXu2y1MtLHp1DVCZrZl2ji3mFxXWZIoaeXknFt2cGM9
         PFLQ==
X-Gm-Message-State: ANhLgQ3TitphjOKRTjv5WzwKeSBVdr3C+bIPh4Ue/ZRP7klobVQMmvBQ
        Cb2upZyQlAEDBlW3eaCmqpzbVT2nEfuv1g52dgnB3Q==
X-Google-Smtp-Source: ADFU+vvo+v3/q5o96URjltWMa+waAoKpdkS+W4orQ4VsY+8ZNMYwVfoC3c1NvIDuXdbsm+Ka3CE7nGsanb6MvI++Jng=
X-Received: by 2002:a2e:9910:: with SMTP id v16mr878221lji.281.1583471015683;
 Thu, 05 Mar 2020 21:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 6 Mar 2020 10:33:24 +0530
Message-ID: <CAFA6WYOUbacZtMEUuhhTwsVJ7RbQu08a2=-LJfczzbZsyxuOBQ@mail.gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
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

On Fri, 6 Mar 2020 at 02:00, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
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
> files in security/keys/trusted-keys/ are identified as part of
> KEYS-TRUSTED.
>
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

> ---
> Changes to v1:
>   - use a global pattern for matching the whole security/keys/trusted-keys/
>     directory.
> Changes to v2:
>   - name the correct directory in the commit message
>
> Sumit, please ack.
> Jarkko, please pick this patch v3.
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
