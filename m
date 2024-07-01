Return-Path: <linux-integrity+bounces-2948-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E391E328
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296432877D5
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B016C841;
	Mon,  1 Jul 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0RxSM2L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779016B739;
	Mon,  1 Jul 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846135; cv=none; b=ADwLSw8PgmWmNI/m+wJ753vNPoTKqx2Rxtoh4xmHWdRGI+Hy1qfZDuXs+2gxq0nd7HSR+MJofKIRh7SVxwiUF0tZU5ZwAVyxuTitwqzb6xtqIDHUi5ySyUWdHoakiFqyiLtStdK2TLvoJsKBAfsoeVcUuCIMQ6jqVc0TEJPZz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846135; c=relaxed/simple;
	bh=uqathgmbSM8m38d4fIzNW2zu9IWw8l+lf1vgqx51hdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2Khj+hz1kOji6eMSp8Jf/BzuBQwCr/LjyfUXkCH9YRt8qv1pq8ipUJUUo86c4Z8JEcCKZLCjCGt8f3pnC7IE9ItP5Z9TFZACDn2tQlLhLMKzlN3+knljYBBlCLDAlOUXo/8QxeaawdhwPg8ovM2yL89azvYnzfvlY5VBYS+81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0RxSM2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB399C116B1;
	Mon,  1 Jul 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846135;
	bh=uqathgmbSM8m38d4fIzNW2zu9IWw8l+lf1vgqx51hdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L0RxSM2LYiElQtH9cBnJze28HtH8IHUmgu1ONOjYMSOKEwIKjzO0m9lR+Kd0B36e+
	 uQSnFPFSmT2IDyB3FXFCoREBIiy4BVs4yEn2cKkesaMvtGrtlRMEgMO3mCU5m6pRwr
	 NdPDwX0ooaW+yOV5PJZP8aqihKNggSlyfcMOlyOXyR5MGUuF5O30qOG0JzSVikjuAF
	 hMVx4bXxGsnGs0hgU4pscRKQGzjxTAkyvtH8aqlMl3yaWm1pD1EsCmHZDCpGxvVlrE
	 RIlvAb9qJszX62Oc6S8gmv3FYRtRbpbifFJQUol73w7c+sWKP3rfgMhxJxoQQQqxIi
	 6s4quqyjbao0Q==
Message-ID: <0c5445a5142612fa617fef91cb85fa7ed174447f.camel@kernel.org>
Subject: Re: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Vitor Soares <ivitro@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Lukas Wunner <lukas@wunner.de>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 01 Jul 2024 15:02:11 +0000
In-Reply-To: <20240621095045.1536920-1-ivitro@gmail.com>
References: <20240621095045.1536920-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 10:50 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> "atmel,attpm20p" DT compatible is missing its SPI device ID entry, not
> allowing module autoloading and leading to the following message:
>=20
> =C2=A0 "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20p"
>=20
> Based on:
> =C2=A0 commit 7eba41fe8c7b ("tpm_tis_spi: Add missing SPI ID")
>=20
> Fix this by adding the corresponding "attpm20p" spi_device_id entry.
>=20
> Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attpm20p")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

This is not a bug fix. This is a feature.

BR, Jarkko

