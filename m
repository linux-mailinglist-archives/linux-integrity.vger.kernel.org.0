Return-Path: <linux-integrity+bounces-2549-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9FD8CC0D6
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976E2B225D4
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52813D537;
	Wed, 22 May 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOBd36Sp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81354823DD;
	Wed, 22 May 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379480; cv=none; b=e+K4J9ZHh/4VvRCWcY4ZyhzuYmFJbDaXFudvfy0S905vMk9rR670CR50pF/kXiqe6ClWlgnEslO0G0ZYd6cAmCWAblRWBeije6A+Wtz0AFLwMl1wbIzSwusga+MKMVnliFA9KNxJf36pLr6HclvQlPYH9FlGh+JysbupAKthn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379480; c=relaxed/simple;
	bh=XoYGy7De4iTTJPgjMdPND90OnPf0ReGU/f6Jtd3TQxM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rysDKkz/ECtD6FTh17lrghRLPyIZ/moc8VmhW+p+MmhHtf5w+AI4VfrcBi/mH5whgf86YLnbvAnPCwhfsE1MVhfzPLQsJsq9tlcU+hH1hVYToraJgrzJZGLvczmsUgtr+jNCPaGOuHhAyyILy0Ywa4gCDwDws8gfhjmSojdyTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOBd36Sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4429BC2BD11;
	Wed, 22 May 2024 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716379480;
	bh=XoYGy7De4iTTJPgjMdPND90OnPf0ReGU/f6Jtd3TQxM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=vOBd36SpyvEp5LnY280fRu48qj7wLvndK77XNrLgoz47MB7yNTc9J6fpBmLzaoO/4
	 vrNOe6l/R5B0k79FmNnQ+mNtA84azDWHjP3aLBlDL0ODrPY33d31itDMSyBusFI/8c
	 s1WfgqSQAbY5/Y9ZwOs0ior3iULeSVj+B7oYtJoYBvsAasj8v++TV6FsQeFKvgGSVe
	 Ys1DqMkga07qnXCKrbWB1l4m1L6EF3iiWFXdw+340GAup5TU8BTRXfWVw4sap+/WhV
	 tBFSXu+GUs2/5OJAuFitUvU0WFEtLgAic8fTSs8RDJPIZmYJnbooTyPsWbVnDE4Gg6
	 uTsSocxdB+mFQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 15:04:36 +0300
Message-Id: <D1G5QU7X1NK0.VACMWFR8IB49@kernel.org>
Cc: <va@nvidia.com>, <csoto@nvidia.com>
Subject: Re: [PATCH v2] tpm_tis_spi: Account for SPI header when allocating
 TPM SPI xfer buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Matthew R. Ochs" <mochs@nvidia.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521154028.3339742-1-mochs@nvidia.com>
 <20240522015932.3742421-1-mochs@nvidia.com>
In-Reply-To: <20240522015932.3742421-1-mochs@nvidia.com>

On Wed May 22, 2024 at 4:59 AM EEST, Matthew R. Ochs wrote:
> The TPM SPI transfer mechanism uses MAX_SPI_FRAMESIZE for computing the
> maximum transfer length and the size of the transfer buffer. As such, it
> does not account for the 4 bytes of header that prepends the SPI data
> frame. This can result in out-of-bounds accesses and was confirmed with
> KASAN.
>
> Introduce SPI_HDRSIZE to account for the header and use to allocate the
> transfer buffer.
>
> Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> Tested-by: Carol Soto <csoto@nvidia.com>
> ---
> v2: Removed MAX_SPI_BUFSIZE in favor of open coding the buffer allocation
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index 3f9eaf27b41b..c9eca24bbad4 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -37,6 +37,7 @@
>  #include "tpm_tis_spi.h"
> =20
>  #define MAX_SPI_FRAMESIZE 64
> +#define SPI_HDRSIZE 4
> =20
>  /*
>   * TCG SPI flow control is documented in section 6.4 of the spec[1]. In =
short,
> @@ -247,7 +248,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_dat=
a *data, u32 addr,
>  int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy=
,
>  		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>  {
> -	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
> +	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESIZE,=
 GFP_KERNEL);
>  	if (!phy->iobuf)
>  		return -ENOMEM;
> =20

Thanks, this is much better. Now when reading the code after months go
by, it is easy to see why the metrics for buffer size are what they
are.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Given that it is a bug fix, I can put this to rc2 pull request. Thanks
for finding and fixing the bug.

BR, Jarkko

