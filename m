Return-Path: <linux-integrity+bounces-3496-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC42971FFB
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2024 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8842870C9
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511A17BB1C;
	Mon,  9 Sep 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcd1KsfP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4D17BB17;
	Mon,  9 Sep 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901536; cv=none; b=Oujhn46xRci/Zm0qGFULEsfHQvbQ9Rmnw0LGUb0Zoe9tWy4x9jXraTUBp90Ao2S5VIxjSi1Mf62STNhXxDECyzqhyuHOR4ADHrRZGv7XnLpJ38s9+KO2WjvxD8bVCyONH2j2gRVtyzl7lUB02REeoSRsWYXWU6L1H9Q4IbKVs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901536; c=relaxed/simple;
	bh=F2CbpEX98qGe7LvwhLE0VH3uSYFDGmAg68m7O9KJ7jU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q1tX1A3u5fEaEYpw655cnmpn1dQX2A+FMWlp+v9FZKxptr5cV0QPZKDpui37qLQ0k+lMv/H9mb5i28Qm5GCNGiiJ6nbvpcQUAZBrPzZ8rwNjeIzkT3MB0331/mPleBBDJOHT5qQgIfcxWS09tf2NTkzQzU7vdPvA+za7ahdsoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcd1KsfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACFCC4CEC7;
	Mon,  9 Sep 2024 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725901535;
	bh=F2CbpEX98qGe7LvwhLE0VH3uSYFDGmAg68m7O9KJ7jU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kcd1KsfPQOOreESZYjRqrk2Z6FGVonu4Gvhektb30EYY0s+1FIPTZVNvedTPpBe3r
	 /Mb4eSTi24YgSe40d8kchFhaBSeWfnKhaNweN/vaw2bHIAWEQbayNpg4h/fqR+GRQD
	 Fqh0HihDSZ3FfpsCmb1vdIx68z0fTFVO6rU6xngYDMOH4LYJQBp3LUG+wVrU99DF0e
	 tVoOp7DapCqhIjNKeqekHtbG164fqYjSzOFeowqdMwRo/iifyhs3H6A6MVDDyPkL2o
	 UWte9lO81UEuz0ayoRDBe3ikJ+3LcPAUF6SX4movrFNhH+f4MiorvhkiconyuIaiTr
	 OuUfLewwqn3Bg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 20:05:31 +0300
Message-Id: <D41X15Z6ZQ4K.3HGVA7H9C6PJ5@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] tpm: tpm_tis_spi: Ensure SPI mode 0
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20240906060947.4844-1-wahrenst@gmx.net>
 <20240906060947.4844-2-wahrenst@gmx.net>
 <D3Z3UFHWQ3MG.N8JU7ZHX3XHN@kernel.org>
 <e7d402f4-0463-4bb2-b1ea-afb36a58e59a@gmx.net>
In-Reply-To: <e7d402f4-0463-4bb2-b1ea-afb36a58e59a@gmx.net>

On Fri Sep 6, 2024 at 5:46 PM EEST, Stefan Wahren wrote:
> Am 06.09.24 um 11:47 schrieb Jarkko Sakkinen:
> > On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
> >> According to TCG PC Client Platform TPM Profile (PTP) Specification
> >> only SPI mode 0 is supported. In order to ensure the SPI controller
> >> supports the necessary settings, call spi_setup() and bail out
> >> as soon as possible in error case.
> >>
> >> This change should affect all supported TPM SPI devices, because
> >> tpm_tis_spi_probe is either called direct or indirectly.
> >>
> >> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> >> ---
> >>   drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tp=
m_tis_spi_main.c
> >> index 61b42c83ced8..e62d297b040e 100644
> >> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> >> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> >> @@ -248,6 +248,17 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis=
_data *data, u32 addr,
> >>   int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy =
*phy,
> >>   		     int irq, const struct tpm_tis_phy_ops *phy_ops)
> >>   {
> >> +	int ret;
> >> +
> >> +	spi->mode &=3D ~SPI_MODE_X_MASK;
> >> +	spi->mode |=3D SPI_MODE_0;
> >> +
> >> +	ret =3D spi_setup(spi);
> >> +	if (ret < 0) {
> >> +		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >>   	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMES=
IZE, GFP_KERNEL);
> >>   	if (!phy->iobuf)
> >>   		return -ENOMEM;
> >> --
> >> 2.34.1
> >
> > Why?
> SPI protocol driver usually call spi_setup to verify that the SPI
> controller accept the settings (SPI mode, bit, clock rate ...). Bailing
> out early is more helpful for debugging issues.

What problem has this patch solved for you? I think it makes the code
only less robust and more error prone.

BR, Jarkko

