Return-Path: <linux-integrity+bounces-2953-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0F91E417
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436B31C215D4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0716C86E;
	Mon,  1 Jul 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDAA0GKr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14116CD04;
	Mon,  1 Jul 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847727; cv=none; b=iNdUywGqqcXs1bkRAF0mOcwC/DxekpRoIwuz7TZzzBZi77Qw7vAovMkx/tFB02dzUcv5gDIdkwACRn2oZQA4RDhE2MzVvbC5M/MBCBz6cCeqFrBRdnMobTMLq+7G+HhSE6cBhqsG9J+2lCuI6lmypIrccf3lsknctJPTei2rSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847727; c=relaxed/simple;
	bh=7pFQCZF0TK7ge4TJfBJVjPmPKLYdXcSUa4GgK0+Inco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Le3orR4YI6ztioLd8qUZICkv8DnCNd1SpjpzdnNNSiYGPxamEmjz3hP70nOA3xz8XFpLUTZ/U9KjCUpmxG/aXwK+tyjTSlU2/56ZnxczBHu1yO6dL5QoGhMYpBnsUBjvw/8ZGSb0Q6LwjTEiZNoTQ2yIjXoCp+7d+oV5xfDvY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDAA0GKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FF4C32781;
	Mon,  1 Jul 2024 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847726;
	bh=7pFQCZF0TK7ge4TJfBJVjPmPKLYdXcSUa4GgK0+Inco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iDAA0GKre8S1rv2bMacDuuz2ODoaSPjEuD96mYfLOPDuzZ/5KvMA+q7qJvBiOCVxg
	 pvhUP5VLVb4z0cT5i/DdKiWJxS14MUBW9va92DXZBLdbbXM6PWJRTrvbskG9cB04LJ
	 thla3/hQgZJb3nSTR5n15pSIPW0i7Vuw3a9CpmoAe8tnY2k+lA3Ok8Uufq3Q5gcxrP
	 QBwijG7Ji2owD2rDC+xisECkvw6iEY4zKEwvNFPFiIUNI1F8MKpPRwwQsK295TQzXg
	 gMiWAL8pmkDbGxnMufrKwkABNDN/YQf0dhOnuiVny5DV/h6DAq88Kjvmr4TB3njG+i
	 ZclkeNVPBQBFg==
Message-ID: <c1cffcdc24c5689b6f9e93f3259480d1e28a46d2.camel@kernel.org>
Subject: Re: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Vitor Soares <ivitro@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Lukas Wunner <lukas@wunner.de>, Vitor Soares
 <vitor.soares@toradex.com>,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Mon, 01 Jul 2024 15:28:43 +0000
In-Reply-To: <b565856a28cff8e01fc1dbb6a776067a3467af9c.camel@kernel.org>
References: <20240621095045.1536920-1-ivitro@gmail.com>
	 <0c5445a5142612fa617fef91cb85fa7ed174447f.camel@kernel.org>
	 <20240701151436.GA41530@francesco-nb>
	 <b565856a28cff8e01fc1dbb6a776067a3467af9c.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 15:27 +0000, Jarkko Sakkinen wrote:
> On Mon, 2024-07-01 at 17:14 +0200, Francesco Dolcini wrote:
> > On Mon, Jul 01, 2024 at 03:02:11PM +0000, Jarkko Sakkinen wrote:
> > > On Fri, 2024-06-21 at 10:50 +0100, Vitor Soares wrote:
> > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > >=20
> > > > "atmel,attpm20p" DT compatible is missing its SPI device ID entry, =
not
> > > > allowing module autoloading and leading to the following message:
> > > >=20
> > > > =C2=A0 "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm=
20p"
> > > >=20
> > > > Based on:
> > > > =C2=A0 commit 7eba41fe8c7b ("tpm_tis_spi: Add missing SPI ID")
> > > >=20
> > > > Fix this by adding the corresponding "attpm20p" spi_device_id entry=
.
> > > >=20
> > > > Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attp=
m20p")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > >=20
> > > This is not a bug fix. This is a feature.
> >=20
> > I believe that some maintainer have a different view on this kind of
> > patches compared to you, adding new device id would be material for
> > stable, or this specific issue preventing module auto loading.
> >=20
> > I noticed that this specific view is not new from you, see
> > https://lore.kernel.org/all/CY54PJM8KY92.UOCXW1JQUVF7@suppilovahvero/.
> >=20
> > With that said, I am ok with it.
> >=20
> > Do you want a new patch version without Fixes/Cc:stable tags or you can
> > remove those while applying?
> >=20
> > Francesco
>=20
> Hmm... OK, I'll apply this version, I see your point here!
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Should be soon available in -next.

BR, Jarkko

