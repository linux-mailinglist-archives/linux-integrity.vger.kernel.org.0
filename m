Return-Path: <linux-integrity+bounces-6876-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38668B2C458
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A549189291E
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81341335BDC;
	Tue, 19 Aug 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op6q3UE7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207421765B;
	Tue, 19 Aug 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608124; cv=none; b=cne76+bK98/1BpAPIYl79CJimnVjEdROAAbsGLff0cnsuWVQ2/FRecnfGVRJ06dAq8u7TJdEmejBnXi7Ym9glAAE0dFuQV1e9f2WVxD6su2cDaNYHOPrEVh37VhR3AwT91M8Mza7t6ziA/IHNeiDYNETFKD1shGC7w+UbQcFi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608124; c=relaxed/simple;
	bh=+1/10nzw4Yf4yiVjA7ztc1dX3OYsmM9+0qlQA3cpdSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmmysCGMOOBgDYaicuwibIjas56QYSxSKU54MO4uy7pCD2ZGaA+hZT/A1DgSqN46CE1Z1ud8sHMF3vMqCXLPDW/07IG5hUOeFNQG8qz6SEFFmQeVzL8GVuxf+ZVlNwHLGqUWJduGCOzTgxB3ENtZwXcObU9ti1xMl+PSZ7bDqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op6q3UE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D705C4CEF1;
	Tue, 19 Aug 2025 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755608123;
	bh=+1/10nzw4Yf4yiVjA7ztc1dX3OYsmM9+0qlQA3cpdSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Op6q3UE7eKv7xYk37W//xhzKMUL2XvdoNTa45dNkDlSf/a0dqxSKLzGkTFjy1ODhC
	 gOfaNm1m5FpSsq0WGgFhmbTi11oQ5UT2a6utUz25TkBRkYfHfmjB6l9AGbaGLtX5Lg
	 M9le2ylpxoFrce1kmFrMqwbieVaCIdyb8z0IkNZWiulgV8tw1HqujTHFV4m9QI/fh9
	 NfJDeVggrWmvGUreyIo4UrBCejq9BOWTOlTae3A4VDfGZWzgGTQKZ/DUNuebOPnlsN
	 oCL2ady6yZfisD5j5SWcqRBG0XxGb2koSMhhWKBDolwocwJl6wkrI31vjuyARtpBae
	 yNmxj40rSPOiQ==
Date: Tue, 19 Aug 2025 13:55:18 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, jarkko@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v12 2/4] crypto: loongson - add Loongson RNG driver
 support
Message-ID: <20250819125518.GF7508@google.com>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250705072045.1067-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705072045.1067-3-zhaoqunqin@loongson.cn>

On Sat, 05 Jul 2025, Qunqin Zhao wrote:

> Loongson's Random Number Generator is found inside Loongson Security
> Engine chip.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   5 +
>  drivers/crypto/loongson/Makefile       |   1 +
>  drivers/crypto/loongson/loongson-rng.c | 209 +++++++++++++++++++++++++
>  5 files changed, 217 insertions(+)
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/loongson-rng.c
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 9f8a3a5be..f6117bc77 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -827,6 +827,7 @@ config CRYPTO_DEV_CCREE
>  	  If unsure say Y.
>  
>  source "drivers/crypto/hisilicon/Kconfig"
> +source "drivers/crypto/loongson/Kconfig"
>  
>  source "drivers/crypto/amlogic/Kconfig"
>  
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index 22eadcc8f..125b99b24 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -44,6 +44,7 @@ obj-y += inside-secure/
>  obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
>  obj-y += xilinx/
>  obj-y += hisilicon/
> +obj-y += loongson/
>  obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
>  obj-y += intel/
>  obj-y += starfive/
> diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
> new file mode 100644
> index 000000000..15475da8f
> --- /dev/null
> +++ b/drivers/crypto/loongson/Kconfig
> @@ -0,0 +1,5 @@
> +config CRYPTO_DEV_LOONGSON_RNG
> +	tristate "Support for Loongson RNG Driver"
> +	depends on MFD_LOONGSON_SE
> +	help
> +	  Support for Loongson RNG Driver.
> diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
> new file mode 100644
> index 000000000..1ce5ec32b
> --- /dev/null
> +++ b/drivers/crypto/loongson/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)  += loongson-rng.o
> diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
> new file mode 100644
> index 000000000..3a4940260
> --- /dev/null
> +++ b/drivers/crypto/loongson/loongson-rng.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 HiSilicon Limited. */
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/crypto.h>
> +#include <linux/err.h>
> +#include <linux/hw_random.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mfd/loongson-se.h>

This depends on the first patch in the series.

Does this one have an Ack?

-- 
Lee Jones [李琼斯]

