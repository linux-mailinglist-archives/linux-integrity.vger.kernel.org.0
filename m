Return-Path: <linux-integrity+bounces-4575-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972DA136CF
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2025 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337671660E9
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D61D9A50;
	Thu, 16 Jan 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht1fKz+b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7231B653C;
	Thu, 16 Jan 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020361; cv=none; b=mJfMFW7sHSR801vbaAgTemMxRGAadd1x6FC48LpP+R2pP+jDXZO7fBvHNMZDxd233DfsZbgzPa2SWVP0U8yON84IJG7TRiPYvy6l7ELuE1MArv//kCw2mMrg59kaLXJaMHsT2wsn+BthUEIgNb/XiONtR9PzwXtmOo1gmH9RKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020361; c=relaxed/simple;
	bh=OW0l48cjaueWer3KiQYx3jnkDL08lZypiZQpxNqWvzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCYmOUXTyScnQf7IElZBmA23CtAXjqeySmS/+VfOzU+5BiWRYNAuDa0GJ8USr13dO1tVdZr8a7faNU+L+Lwc+cQw1PfMvWFzWcWO06XkeEKwrtmHu9+CiPNBxfSiAuyD2jkpA+8zf5E1pqnBbyDVp4wAan1EK598Ra3bUVomrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht1fKz+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39099C4CED6;
	Thu, 16 Jan 2025 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737020361;
	bh=OW0l48cjaueWer3KiQYx3jnkDL08lZypiZQpxNqWvzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ht1fKz+blLTleB4jQCZq5+fs3wGZZhB75xnCqJ8wTeUwybXcj2mZpULmMY+dNg54t
	 DxrKTtVVIxbSReeJeiBM6K6BrDs3lGJHpRxcrgNIAkmYX9BBDA7yOybgcHLwGoaPqE
	 3c/uW5E5hFxeohji8eERZQwTcF5wxqwDJ6MKHbE0IOP40JIMiWlvbVyi4Vl/VWGspS
	 k38QpJHTLbYPEOu2I1EJ0Z0vam1paYiwPblLalBhAtC8LbA1eQDcpeHFGZ9V6znu2M
	 SWvH+iA3u3b4msL/9HVJdoABeD4V4UWjnk68ckHadrL7bwaNsJiUF+yvJXbHTL+jv/
	 NRLHCr4+VOGoA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b21cso6462511fa.1;
        Thu, 16 Jan 2025 01:39:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM5gDIgMcNTWT1mGlXznP8QqkwVDcdSEGBOFAJNjZZ6FU11NXLrGDT8SBUpeYBLHCdhUjTFyyVjWoyZGI=@vger.kernel.org, AJvYcCUViHICRcvTgT/9/wh6hl5x3fAFQnl4kqQoVlcanMZsdroNIlCYoIWSg6mE3bQjKRjI1UYqPqIm@vger.kernel.org
X-Gm-Message-State: AOJu0YzYl1wlNc9gD4Sd59btVjxdf4mWDIg+kyKR4o9xELE+nAOc0sOu
	OJD2cXW+eXcvFfLKJamZ3K5s0l56cRgS+6/DyWsW6GzvNkk8rTyWh4VA1Usdq5t9KJ8vkXr6WUy
	8222fpgciU5Y0vSPJRAiV4ZsAVWU=
X-Google-Smtp-Source: AGHT+IE1/vsJ1Jj6g4MYC7KZgNvomh+sFYYaP8Ecc4sKRMO2P3bP/0TKQAGmV4RAN3jZWRnC02YCWbXs+Qp6TetYsAI=
X-Received: by 2002:a05:651c:19a6:b0:300:2464:c0c2 with SMTP id
 38308e7fff4ca-305f453158amr96024911fa.8.1737020359602; Thu, 16 Jan 2025
 01:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115224315.482487-1-jarkko@kernel.org>
In-Reply-To: <20250115224315.482487-1-jarkko@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 Jan 2025 10:39:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE=39DB2PNGytXFTEsKX2L929NOcsPmFhBUqQ6r+AFm2Q@mail.gmail.com>
X-Gm-Features: AbW1kvZAhfrGqqCTcfG2ZOaVGlSeHby33WYqht6sLXpxKxgV4HxA7hJLX0HFqqA
Message-ID: <CAMj1kXE=39DB2PNGytXFTEsKX2L929NOcsPmFhBUqQ6r+AFm2Q@mail.gmail.com>
Subject: Re: [PATCH v10] tpm: Map the ACPI provided event log
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Colin Ian King <colin.i.king@gmail.com>, 
	Stefan Berger <stefanb@us.ibm.com>, Reiner Sailer <sailer@us.ibm.com>, 
	Seiji Munetoh <munetoh@jp.ibm.com>, Andrew Morton <akpm@osdl.org>, Kylene Jo Hall <kjhall@us.ibm.com>, 
	stable@vger.kernel.org, Andy Liang <andy.liang@hpe.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 23:55, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> The following failure was reported:
>
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
>
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug with kvmalloc() and devm_add_action_or_reset().
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: stable@vger.kernel.org # v2.6.16+
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v10:
> * Had forgotten diff to staging (sorry).
> v9:
> * Call devm_add_action() as the last step and execute the plain action
>   in the fallback path:
>   https://lore.kernel.org/linux-integrity/87frlzzx14.wl-tiwai@suse.de/
> v8:
> * Reduced to only to this quick fix. Let HPE reserve 16 MiB if they want
>   to. We have mapping approach backed up in lore.
> v7:
> * Use devm_add_action_or_reset().
> * Fix tags.
> v6:
> * A new patch.
> ---
>  drivers/char/tpm/eventlog/acpi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 69533d0bfb51..50770cafa835 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
>         return n == 0;
>  }
>
> +static void tpm_bios_log_free(void *data)
> +{
> +       kvfree(data);
> +}
> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> @@ -136,7 +141,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>         }
>
>         /* malloc EventLog space */
> -       log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> +       log->bios_event_log = kvmalloc(len, GFP_KERNEL);
>         if (!log->bios_event_log)
>                 return -ENOMEM;
>
> @@ -161,10 +166,14 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>                 goto err;
>         }
>
> +       ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> +       if (ret)
> +               goto err;
> +
>         return format;
>
>  err:
> -       devm_kfree(&chip->dev, log->bios_event_log);
> +       tpm_bios_log_free(log->bios_event_log);
>         log->bios_event_log = NULL;
>         return ret;
>  }
> --
> 2.48.0
>

