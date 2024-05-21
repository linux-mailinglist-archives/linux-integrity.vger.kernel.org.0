Return-Path: <linux-integrity+bounces-2525-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171E8CB1C4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74D71F23651
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1E148318;
	Tue, 21 May 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aImJhakQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB51448C7;
	Tue, 21 May 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306918; cv=none; b=Db/SAzPnREVMgMN3bUffDjlxUGbGrdTCnkh6Ow0Fbczy+u1KLGsDd7tuAoBfW+Edz6TUtQNR0gQKhZzdTNQq/Bcx0HkpZpfkrNdqUSqZvKBsMX/KpEdvK9kmCgnsieaVCTcWvx5JjFAp7cPNYjcOIH+0Plw9KaVUh+cuZCwVYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306918; c=relaxed/simple;
	bh=ETX7OlYVaf7lHnLpkZDxTXz9uHxRNuqfRK69QfLpOHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BF56i10m73Okpm2luibzVLFAayfp/F5rcH6fCL5ZJmgV24zPsjmfqCT9XDnPLaEpBYvqmlOdG9p4psNt8zlaMrS+QDGvbPEn2fqQyO0BJt3injyqMoxEF+auaI7IoGuozc9xSuS0ZGIoS8fZA1db92VQS5tYsN84WbVGl9ZDSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aImJhakQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCC0C2BD11;
	Tue, 21 May 2024 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716306918;
	bh=ETX7OlYVaf7lHnLpkZDxTXz9uHxRNuqfRK69QfLpOHY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aImJhakQPS4KIkXVzI+H6A9AfMNwMnmfCUz6GT1bjDe5T4Xc9p/fk5639f0eNx7B/
	 BFEVawJpn7eeaYPj2rW94xTK4JHt/TByeAyU79nGjizkGHCMdShhSK22dbQBonxv3d
	 jCw+Boyf7BkF/jwU+ImVm5Q6w+BGFgFcOkM276PRL2HrDnn3ijm21rrAMg9BwijI//
	 1mS1j38BifPJw0DAIxAMpEEy2stTluso09KsGjh3/w5ON8r6nzWD7GAtj2KhxgGWfd
	 NgXf3U9K1VIx9jkV/Gj3Ax9+iKEzRkkpllq2NGCRYRIMlHuN9V5ZbwX6UM3BtUPlmw
	 jnCB5fsM68gyA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 18:55:14 +0300
Message-Id: <D1FG0VPIBMJI.2XLL7FD5DYXBX@kernel.org>
Cc: <va@nvidia.com>, <csoto@nvidia.com>
Subject: Re: [PATCH] tpm_tis_spi: Account for SPI header when allocating TPM
 SPI xfer buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Matthew R. Ochs" <mochs@nvidia.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521154028.3339742-1-mochs@nvidia.com>
In-Reply-To: <20240521154028.3339742-1-mochs@nvidia.com>

On Tue May 21, 2024 at 6:40 PM EEST, Matthew R. Ochs wrote:
> The TPM SPI transfer mechanism uses MAX_SPI_FRAMESIZE for computing the
> maximum transfer length and the size of the transfer buffer. As such, it
> does not account for the 4 bytes of header that prepends the SPI data
> frame. This can result in out-of-bounds accesses and was confirmed with
> KASAN.
>
> Introduce MAX_SPI_BUFSIZE to account for the header and use to allocate
> the transfer buffer.
>
> Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> Tested-by: Carol Soto <csoto@nvidia.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index 3f9eaf27b41b..ba50eaead9d8 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -37,6 +37,8 @@
>  #include "tpm_tis_spi.h"
> =20
>  #define MAX_SPI_FRAMESIZE 64
> +#define MAX_SPI_HDRSIZE 4
> +#define MAX_SPI_BUFSIZE (MAX_SPI_HDRSIZE + MAX_SPI_FRAMESIZE)

"MAX_" prefix does not make sense in the new entries.

> =20
>  /*
>   * TCG SPI flow control is documented in section 6.4 of the spec[1]. In =
short,
> @@ -247,7 +249,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_dat=
a *data, u32 addr,
>  int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy=
,
>  		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>  {
> -	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
> +	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_BUFSIZE, GFP_KERNEL);

It would better to open code here "SPI_HDRSIZE + MAX_SPI_FRAMESIZE".

I.e. less cross-referencing and documents better what is going on at
the call site.

>  	if (!phy->iobuf)
>  		return -ENOMEM;
> =20

BR, Jarkko

