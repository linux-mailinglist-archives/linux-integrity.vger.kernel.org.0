Return-Path: <linux-integrity+bounces-5519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E500CA763E0
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE991888CC6
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B21DF26A;
	Mon, 31 Mar 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTFRAHzx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8881DF247;
	Mon, 31 Mar 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415941; cv=none; b=QgiBwL+ZBiKC8lDSeo1yGN724aRuEkpw7OchVMhMRogFsmNoCUxxlTlR+/mUCa6cup2meDBHK+TPb3o9fTpBOpacTaVBF45YOe/IxDbBevieiiVxvBxZU8gUMNdMEG6gCDwDzbStkqylE52TsfbKFgIJCm/+/BKvO8i2ylSIZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415941; c=relaxed/simple;
	bh=mBG+3dp3Dhvh1FHdtXraI/p3TThcHNlTbeuo2+pmhnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvv4t5PZQm9r6dZUq3K8WvGH3dJo44CrxpB3g0f0y9YK/CFnheOy3OyhM1tEX8QZgi4D8s46CvFF3mSMarrKwuFV+91KfuTU0ah6cGM1qq1qIOGdSMEkqWZccVj46jVOsXzNE94XuMSMeuQDWfQrZMelpC+IO/Xaxd3+VWQOHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTFRAHzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458CEC4CEEB;
	Mon, 31 Mar 2025 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743415941;
	bh=mBG+3dp3Dhvh1FHdtXraI/p3TThcHNlTbeuo2+pmhnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PTFRAHzxfJdHtKIG6GiPgME2z+eM7Nv3WiKZq7PQrlDl72hF4JtbkZVhdrFkbCLRS
	 2AyP2PdKpBHj0zhv9Qgnjd2yMzQEWG1D4so3Ae9XaJPXCm/znZhf4s5t+ZJ8lF5hv9
	 75Y+8/23Jxtgn5KL29pFEToDlQ8XuB3jxJK6decXrEPhqsMWb7og5A6RgAK+nC+ENN
	 xAIPIMyrzBtrGZ3lLoVTua3uVGOz7JR9RlC055TNSL3vQNhSV0aXdDA2wSnUnECYP+
	 me9ch5d7AWmcvZ/fzsnH/XmJpTQtcs5TZA2OLxsUSeifNsdKjiFkIRqiVmtBHXJtuN
	 af+mUuYsFxuZQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2963dc379so680726866b.2;
        Mon, 31 Mar 2025 03:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8kt0iBPywy15wYo28agYSNgIUK1MzhdClwq1AzGjtsv7NnpqSPtDnxAotOcGvtAjkANZ1Jhal60L9RD1Y@vger.kernel.org, AJvYcCUhHsaieHJ+YbLk0JcbgLtJbhklW3FfzC70lhkiKj4H201wsqi7prjhli75MATDmfEm8rdi4CAl6Pa2pWOfrWeF@vger.kernel.org, AJvYcCWmuM5Mmv8vO57s7Fx3PuO/nZfLkLzf/GjFslphGNe/l3YK0H3+OVifMwxWYCfpiuP1+uFE/yxBfj0teTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+KRtph8EHizN/KJc2eTlkpeUldX+s9rz3j74JpyTiX7CzQze
	NMUy+Puklm7dLj+PLTdDzGOGNocbSSCDGX8BctxpDThlztgJwbMwRx3JtNdJoEb8Z70Q3ZNxKnN
	VnJ4NKeQMo7wApnILmt3PchO56KI=
X-Google-Smtp-Source: AGHT+IH1xftVfCSsq7SDWRuCGUlw+i7g12tBDDd8Gl+VRn6g4RehR9k69ESR3Y50BYnFfgeO9fa9qRZIF4wgDwmZc84=
X-Received: by 2002:a17:906:e28a:b0:ac7:391b:e687 with SMTP id
 a640c23a62f3a-ac7391be985mr625947266b.61.1743415939855; Mon, 31 Mar 2025
 03:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327021809.29954-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250327021809.29954-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Mar 2025 18:12:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6xxhM4r19iCrtpmASR68YYzarbK2yFqMGhoZt80vLg5w@mail.gmail.com>
X-Gm-Features: AQ5f1Jqkj-f6mhuAnXtMLAXdFdnUCbefkEVIaPXBiQF5CE_HTMdaQLR8_qXJ8_E
Message-ID: <CAAhV-H6xxhM4r19iCrtpmASR68YYzarbK2yFqMGhoZt80vLg5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Drivers for Loongson security engine
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Thu, Mar 27, 2025 at 10:17=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.c=
n> wrote:
>
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in it.
>
> mfd is the baser driver, crypto and tpm are users.
I have some small comments, if you make changes then you can add
"Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>" for all patches.


Huacai

>
> v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
>
>     crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
>     ls6000se-rng.c ->loongson-rng.c
>
>     tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c
>
> v5: Registered "ls6000se-rng" device in mfd driver.
> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
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
>   MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
>
>  MAINTAINERS                            |  14 +
>  drivers/char/tpm/Kconfig               |   9 +
>  drivers/char/tpm/Makefile              |   1 +
>  drivers/char/tpm/tpm_loongson.c        | 103 +++++++
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   6 +
>  drivers/crypto/loongson/Makefile       |   2 +
>  drivers/crypto/loongson/loongson-rng.c | 190 +++++++++++++
>  drivers/mfd/Kconfig                    |  10 +
>  drivers/mfd/Makefile                   |   2 +
>  drivers/mfd/loongson-se.c              | 374 +++++++++++++++++++++++++
>  include/linux/mfd/loongson-se.h        |  75 +++++
>  13 files changed, 788 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/loongson-rng.c
>  create mode 100644 drivers/mfd/loongson-se.c
>  create mode 100644 include/linux/mfd/loongson-se.h
>
>
> base-commit: b904243247d1acb0ebbd4978feb639441dc51fc1
> --
> 2.45.2
>
>

