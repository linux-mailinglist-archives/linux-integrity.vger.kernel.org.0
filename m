Return-Path: <linux-integrity+bounces-2529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619DA8CB3EB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AAA1C21D40
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9C147C95;
	Tue, 21 May 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuoPbOY/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1E1FBB;
	Tue, 21 May 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317853; cv=none; b=q3I24C+qgEMZXeThLB/BbfaPlP2HvQir6v9PCFz7SNMpJ6jbo8/JA6Iabnjf34eaFxRS9ideX1sDCuBZCDNRN2YWG7mvU5ROaIhZAQcjIfKIZ2/lFWyo6VjQaQoctTyABihG1YbrIpJRJ70y3cmKNMGJa45vEIqXprzMeJaGtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317853; c=relaxed/simple;
	bh=n422abIrY6lZt4Oye/wsbFrRuxjddYMBuSioz43dbSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EHLLbY7A+RJVAG0vX8+XjfersHeJaqEhbiZxnkugLE/gMD0vPbnlTkSWp+eI8kmHznBHbQ/DMwU9Qppx/lT/vWkrFiG8msO2NnUtj3IC401wO2sKX+hulegM5Meomog2fmUSlItxTf+dsB08Bq6uSAJw4eiXO1CSPy0WdZ1wLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuoPbOY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF1C2BD11;
	Tue, 21 May 2024 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317853;
	bh=n422abIrY6lZt4Oye/wsbFrRuxjddYMBuSioz43dbSk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=fuoPbOY/ljx/kTmCkpap9m0e1GITv2gKb2ZKlj7wTpn/BMiLppRDmnxw+MrxJrcAm
	 3EMo8jao1Re2Eb9VGzL19SAFCj1BNT+tFnufiW5C2CYCekb/q4na86BjuqJfNRHe/x
	 V/jCbRXDJrVPRhOnhyGG7sQalb5KxAM/QsMeLts6+Gw/jPK5qC6EdHsxdIzO6Fa0MQ
	 onilEiZe3iN6HZ5KRWew9H9z7XEEEJmEeGYEVYzA53jcCAF+klJN1ya6s5MgeJ9G49
	 ETnrs+9O5fdwuBnaNuujlfxvhmf5Uk/VjYWgfnxNuvULQ8HtXjY4NAlvG58tO/hKyE
	 upYb3NCtkW39Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 21:57:29 +0300
Message-Id: <D1FJWF5LK0T4.K5YFU4OBSKCI@kernel.org>
To: "Matt Ochs" <mochs@nvidia.com>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vishwaroop
 A" <va@nvidia.com>, "Carol Soto" <csoto@nvidia.com>
Subject: Re: [PATCH] tpm_tis_spi: Account for SPI header when allocating TPM
 SPI xfer buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521154028.3339742-1-mochs@nvidia.com>
 <D1FG0VPIBMJI.2XLL7FD5DYXBX@kernel.org>
 <66503B6E-44C3-42DF-B423-7D0214620686@nvidia.com>
In-Reply-To: <66503B6E-44C3-42DF-B423-7D0214620686@nvidia.com>

On Tue May 21, 2024 at 8:59 PM EEST, Matt Ochs wrote:
> > On May 21, 2024, at 10:55 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> >>=20
> >> /*
> >>  * TCG SPI flow control is documented in section 6.4 of the spec[1]. I=
n short,
> >> @@ -247,7 +249,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_=
data *data, u32 addr,
> >> int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *p=
hy,
> >> 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
> >> {
> >> -	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL=
);
> >> +	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_BUFSIZE, GFP_KERNEL);
> >=20
> > It would better to open code here "SPI_HDRSIZE + MAX_SPI_FRAMESIZE".
> >=20
> > I.e. less cross-referencing and documents better what is going on at
> > the call site.
>
> Sure, will make this change in a v2.

Yeah, and thanks for spotting the bug and fixing it! Looking forward to
the final fix.

BR, Jarkko

