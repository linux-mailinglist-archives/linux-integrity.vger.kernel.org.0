Return-Path: <linux-integrity+bounces-3482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E7A96F020
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8152828643D
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEF1C8709;
	Fri,  6 Sep 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKWUHgCG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FC41A8F;
	Fri,  6 Sep 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616076; cv=none; b=hLN//DwYO7qg3lg4bo1DWHy9S6RWeOaCXmweyukif4L3RJafFhf4GLKve2EHRSfQaz2+lMGPALzAcXJ/pqUQ2Nlw/9/RBZnGSWq728uy4euNpJCDL44gS4HSLNWwLMw3sEG+mr39ImopjOYDQgGpu/6Zq90o7WXHG1Ljul8T8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616076; c=relaxed/simple;
	bh=t9WXDI7C8MEWM9cGLSJKb0IC5/+Pqc2jbnUhHiU9H6w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bEAX0XWv9NkVrZn90ojkm0/bVQcOUimgKkBPcotyVa4hy2qqGDPEmJHhV0Z5iu9xrC5AsWFwoBlKIK55GJjQNf9yJgTkVV1UxGprS7J3iKUZkqfWtbgWdZWV56wdePKrALLpHqmtFx2+/X94LVFFHu7yHIrPunmuuvLIi332H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKWUHgCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10134C4CEC4;
	Fri,  6 Sep 2024 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725616075;
	bh=t9WXDI7C8MEWM9cGLSJKb0IC5/+Pqc2jbnUhHiU9H6w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UKWUHgCG8Vo5woHikdETAfFMbJBCI9KKfz4Yco1Y3ppfYpiTF7wCeqPTKQq4449HA
	 XGpDwuycHRKwINBOzccFgRmAbu+Jcsv2mxAQaS76P553VWzZzGpB0UCIPWpuAkEoLh
	 RYTkf+cy5tRp495ZKP77qkgx0HdUHi7zxfCjr7A7WCfY2JIwF9Z4UnQUEhk/pVsmRx
	 WKDlGg6jrxdknh1PhlmWoPiAfAQ4VhfQ2TvdeZUJ9j9TCIgokjYj5LvN7xD3TNIgnS
	 AHQ4mFIqr1INC5v9QmbSpWYl9374JXhdvk28Rf1UZ/GRyAENG7x6obPqLuerctNhDk
	 AbxZuePqYpo3w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 12:47:51 +0300
Message-Id: <D3Z3UFHWQ3MG.N8JU7ZHX3XHN@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] tpm: tpm_tis_spi: Ensure SPI mode 0
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20240906060947.4844-1-wahrenst@gmx.net>
 <20240906060947.4844-2-wahrenst@gmx.net>
In-Reply-To: <20240906060947.4844-2-wahrenst@gmx.net>

On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
> According to TCG PC Client Platform TPM Profile (PTP) Specification
> only SPI mode 0 is supported. In order to ensure the SPI controller
> supports the necessary settings, call spi_setup() and bail out
> as soon as possible in error case.
>
> This change should affect all supported TPM SPI devices, because
> tpm_tis_spi_probe is either called direct or indirectly.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index 61b42c83ced8..e62d297b040e 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -248,6 +248,17 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_da=
ta *data, u32 addr,
>  int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy=
,
>  		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>  {
> +	int ret;
> +
> +	spi->mode &=3D ~SPI_MODE_X_MASK;
> +	spi->mode |=3D SPI_MODE_0;
> +
> +	ret =3D spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESIZE,=
 GFP_KERNEL);
>  	if (!phy->iobuf)
>  		return -ENOMEM;
> --
> 2.34.1


Why?

BR, Jarkko

