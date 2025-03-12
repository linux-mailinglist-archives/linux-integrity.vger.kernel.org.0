Return-Path: <linux-integrity+bounces-5247-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA45A5D7D7
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 09:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52907163A73
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD823024D;
	Wed, 12 Mar 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4y9MXHq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656922DFBE;
	Wed, 12 Mar 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766891; cv=none; b=M1Qze7gPdTWD9MhcRpC8y+BjoJkgi6W3IC5sDnzmx8LIS1TqepjHIK39xLbPzg6ghxWps+p3jg98fNpeoUvW1McrJmoZyAOOO8wuKjNxhPP3+LLXrKgIiHfpzYUuNnGeJkHFqjHLkxh94LUOpaz4D9NKhUVoLXLFmIC2jJjaQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766891; c=relaxed/simple;
	bh=E0YvQYkYc/gAigFg00Fo8cPNoGuGbrRbV1pMBUqk/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brWLjcE4YBEOWg+i5+3yTvUzpRw0tViCh/Qa1Q6A2HSqZE14R5ItkMso0HwB/DYi/7W3Jgmhim1M0U+kogWQWFNjHieWBW+0wg4uaf0bypBoPXB6cqQGa4oRHRAU/mbUbxqizeyOgPWgve2uGnBgkDQGkxr09uD+6yg+YOnAtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4y9MXHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A223C4CEE3;
	Wed, 12 Mar 2025 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766890;
	bh=E0YvQYkYc/gAigFg00Fo8cPNoGuGbrRbV1pMBUqk/f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4y9MXHqoaBQp7ToS6ifvVlR/+ggAuZMRnKWoCCXzuhKAg4GCv6XM1T+34e67ne3H
	 UWL0KsKGWflCOJ0h2Mpxq0uk/ypaL9EpyaeogH2S2uAUxrOFb7p+HwZFaNuzpHbXJQ
	 urIj6uEdSC6nekqUg2x9yFBTcV4hUUrBuSg7gw5bo82oeg99HHPddWGsWnrrtl4ew6
	 cOSp3ct+JvYT7aYw8nUpg+uG3/ACLR/epzlzUbHmibnsg5jpu1xVXChtdljdpfMojn
	 E/KG4EhFyAq85xJbBFw59CyBmH8NiidLGJCD5PowNfAGK5IJtPjrZslrN70tuW0wmu
	 oXLKrYluj2d/A==
Date: Wed, 12 Mar 2025 08:08:05 +0000
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH v4 1/6] mfd: Add support for Loongson Security Module
Message-ID: <20250307200031.GG8350@google.com>
References: <20250226030358.15924-1-zhaoqunqin@loongson.cn>
 <20250226030358.15924-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226030358.15924-2-zhaoqunqin@loongson.cn>

On Wed, 26 Feb 2025, Qunqin Zhao wrote:

> This driver supports Loongson Security Module, which provides the control
> for it's hardware encryption acceleration child devices.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v3-v4: None
> 
> v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
>     Passed dmamem size to SE firmware in se_init_hw() function.
> 
>  drivers/mfd/Kconfig          |  10 +
>  drivers/mfd/Makefile         |   2 +
>  drivers/mfd/ls6000se.c       | 374 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ls6000se.h |  75 +++++++
>  4 files changed, 461 insertions(+)
>  create mode 100644 drivers/mfd/ls6000se.c
>  create mode 100644 include/linux/mfd/ls6000se.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d44c69bb3d..318fb113c1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2439,5 +2439,15 @@ config MFD_UPBOARD_FPGA
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called upboard-fpga.
>  
> +config MFD_LS6000SE
> +	tristate "Loongson Security Module Interface"
> +	depends on LOONGARCH && ACPI
> +	select MFD_CORE
> +	help
> +	  The Loongson security module provides the control for hardware
> +	  encryption acceleration devices. Each device uses at least one
> +	  channel to interact with security module, and each channel may
> +	  have its own buffer provided by security module.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9220eaf7cf..9556de7715 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -294,3 +294,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>  
>  obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
> +
> +obj-$(CONFIG_MFD_LS6000SE)	+= ls6000se.o
> diff --git a/drivers/mfd/ls6000se.c b/drivers/mfd/ls6000se.c
> new file mode 100644
> index 0000000000..24d76c2ffc
> --- /dev/null
> +++ b/drivers/mfd/ls6000se.c

[...]

> +static const struct mfd_cell se_devs[] = {
> +	{ .name = "ls6000se-sdf" },
> +	{ .name = "ls6000se-tpm" },
> +};

Where are the drivers for these devices?  I don't see them anywhere.

I do see ls6000se-rng.  How is that registered?

-- 
Lee Jones [李琼斯]

