Return-Path: <linux-integrity+bounces-5012-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB485A49B8F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D21A188BEEE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7026E17F;
	Fri, 28 Feb 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPGtgMHV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FC26E169;
	Fri, 28 Feb 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752006; cv=none; b=a63vL8xOR1mVtzn3uCHorprDqCRZcqMEccTdnNXWX0Vsll2UGmE9LRA7kimwqC8iT6Iiz8EtkYrFPU7+IsfBZ3qXrvGK0ITktaoUR4PLzmNtxQO0M71gEDIrADdclbzyUkwVHSWS+5/6umEdPpLLzYjYmqQG5h7n1jLpF1O88PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752006; c=relaxed/simple;
	bh=VVIDcMnoH7hPbhberNOLlP1qoZPeOV5SLRdCSsFHrj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScqrhKKBNv3kx+fMTZGh7TqQH3N5YFcg1coacSJ/kWopCZlJG+8GcyeK15s8wz7+sKN+zTxLqAmLhtmjNg+B3+igEAsqK2qD9vNWZ87ULtHjHvWIgiWsd82vJI+Ys1eezwb/YFMoUIx8yyOQiatgQkx0m3luhF2EXXwDeRG0Q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPGtgMHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74170C4CEE9;
	Fri, 28 Feb 2025 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752005;
	bh=VVIDcMnoH7hPbhberNOLlP1qoZPeOV5SLRdCSsFHrj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YPGtgMHVnFo6x/h0FPQLBRnMNZB6FnypZxZR3uZI1gWQ6UNlGANox19PF8DYna/O0
	 qobyT3f4YyyjwvTdh72X+kWeXt1sNVR7WVo6qakTEuRHLI1LGURjtO+plFbW5sZspv
	 9MvVh7j9WxEjv9uHwN9HC0SCokPuu+m9KXhEecjsubF2d60EO28GzJKjWJjjlRc6Ps
	 6/INyLqxvwpOjwY4YSWqd83+3m+JcJX5Bl5jDxC11DEpUeEfN30BqrpSIkRNf9cnLS
	 uIvEUfzNSFwmrrq15l1TMcPZW6oCfUv7cITz01NGRBEQ+f173t+DRILYGiD+vEdx35
	 bwJS3EPjuo33Q==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf06950db5so328397866b.1;
        Fri, 28 Feb 2025 06:13:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEwVDA6KMUumZfn5kbcIMI2JfVaWRSyDTHwX6pQ4aLnJNcfQCHqI0c4e6rN7JI5sWqveTCZXcEfa9FXnM=@vger.kernel.org, AJvYcCUisode25H1VqtO8EkvaUprHR9bhqV0KJ8gsea8RtWVEqDodVdbjMJfZVhnpVEOisgh8qZvNyaTq0qZAIlTnlQG@vger.kernel.org, AJvYcCW++n9yGYl/VElpXnHW11ghn/bqItZJYjAHjsuUx3P/XVPX5p2hZzDpXp3WhT8y7wGbr+3UFFWa2ZrgRoQI@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTNQ05l8DTznhmqUCO1d/T2z602sTyUHRj8CYlAg2g57lPfNR
	LwQw+bluBqDX1soCMIem3xmpY6CDEmZXgRMxW1zCZj7bGDboxW0WUuezXLz9a/BZOj6qarpJXqP
	BUd1eNllOyW2OfP0tvFg7WBlv9Qo=
X-Google-Smtp-Source: AGHT+IHQV0/AoJbVv8/kktbul8lIZMTIcX8dgu+kgyS+lgEw8A+QnIjYp0ZnMf504B6etDxi6Jc/pi7Nqua0hYQXf8c=
X-Received: by 2002:a17:907:7f91:b0:abf:24c7:f81b with SMTP id
 a640c23a62f3a-abf25f8db0amr324317566b.6.1740752003900; Fri, 28 Feb 2025
 06:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226030358.15924-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250226030358.15924-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 28 Feb 2025 22:13:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xyRrF1_=E7rLM3dHeYAEBdMufYQvgoxAq6+d6s5U4Eg@mail.gmail.com>
X-Gm-Features: AQ5f1JrCZ9bfAhFSbtUzVcSFF_xizdCX_Qw-twqvCYIPSVnkRJ_jehWs1iBzR1U
Message-ID: <CAAhV-H5xyRrF1_=E7rLM3dHeYAEBdMufYQvgoxAq6+d6s5U4Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Drivers for Loongson security engine
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Wed, Feb 26, 2025 at 11:04=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.c=
n> wrote:
>
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in it.
>
> mfd is the baser driver, crypto and tpm are users.
Loongson SE should not strongly bound to LS6000, so the naming can be impro=
ved:

MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,  ls6000se-rng.c ->
loongson-rng.c
TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c


Huacai

>
> v4: Please look at changelog in tpm and MAINTAINERS. No changes to tpm
>     and crypto.
> v3: Put the updates to the MAINTAINERS in a separate patch.
> v2: Removed misc driver. Added tpm driver.
>
> Qunqin Zhao (6):
>   mfd: Add support for Loongson Security Module
>   MAINTAINERS: Add entry for Loongson Security Module driver
>   crypto: loongson - add Loongson RNG driver support
>   MAINTAINERS: Add entry for Loongson RNG driver
>   tpm: Add a driver for Loongson TPM device
>   MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry
>
>  MAINTAINERS                            |  14 +
>  drivers/char/tpm/Kconfig               |   9 +
>  drivers/char/tpm/Makefile              |   1 +
>  drivers/char/tpm/tpm_lsse.c            | 103 +++++++
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   6 +
>  drivers/crypto/loongson/Makefile       |   2 +
>  drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
>  drivers/mfd/Kconfig                    |  10 +
>  drivers/mfd/Makefile                   |   2 +
>  drivers/mfd/ls6000se.c                 | 374 +++++++++++++++++++++++++
>  include/linux/mfd/ls6000se.h           |  75 +++++
>  13 files changed, 788 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_lsse.c
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/ls6000se-rng.c
>  create mode 100644 drivers/mfd/ls6000se.c
>  create mode 100644 include/linux/mfd/ls6000se.h
>
>
> base-commit: bd315242821784e9384abae911a70d5fda9a3298
> --
> 2.43.0
>
>

