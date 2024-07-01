Return-Path: <linux-integrity+bounces-2952-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D143E91E40F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1261C21606
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C916C86B;
	Mon,  1 Jul 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s21PuLhH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654416132E;
	Mon,  1 Jul 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847652; cv=none; b=mnbNsG7j0dMFB+vtNBtnwFHvX00CiYgXx5TgU40H4adZRK2/P7LgK3T/rIUqj3147+OwN3Vueq4sJfWH5TiLoTmaiAOcDhIeBICfsaZl/6yvGY+rUWQ/D270wtRdF5qK6RvbgmRFz12aFOjrLDuEODUPMuEfhf+cI6/kBjXobMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847652; c=relaxed/simple;
	bh=11K/fmv0fQcqztY3g6dRvwjGk6CQog4laHMyZmLUW9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/xe8dfhZ4rWOqWsWFNkr8K5ayGhXsCPoh/sYLVvOAqH0ttxsdt2oE3vkELiWaxH4lhUArsQJRSPM/064aOcW1TKnItz4TgBXrd6HqtWg9KH5N4/pbQwBqp9lgYyRbshrsBm82jxKOg9PAcx2UHX+IyXkwzboKkzhpOMJ7/id2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s21PuLhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B7DC116B1;
	Mon,  1 Jul 2024 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847651;
	bh=11K/fmv0fQcqztY3g6dRvwjGk6CQog4laHMyZmLUW9Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s21PuLhHGSi92tKBxyY68Nt9wn4ja8M8Eof9OSzIDvmajJRtSYoeHsApBUhIz/cac
	 ge0c2urJcfZrPLbtJ0Jh5qokx3SKI/Kp8v3qeSCB44NwxZWCcQhdyvEMRWGQtwJABY
	 BBEWMhAbl+gb1JyANmeLC6nng54h7BmpVLs9PXcf5K3LRIrSLrkOmBSfUE/PUNThQP
	 gsX4LkCe+3SagQcOif3+53zvEKzzIXA/UOVzqk9tRd7uhtp0qAvNxy61ozEN93JICh
	 0Q/w+g9e6BiAO2ApmEu1Quz9OVivMboOV5KLg4qf0r/AGx+H8SOsQsojx5zjyCiA5s
	 qdbKEJKx6PMvQ==
Message-ID: <b565856a28cff8e01fc1dbb6a776067a3467af9c.camel@kernel.org>
Subject: Re: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Vitor Soares <ivitro@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Lukas Wunner <lukas@wunner.de>, Vitor Soares
 <vitor.soares@toradex.com>,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Mon, 01 Jul 2024 15:27:28 +0000
In-Reply-To: <20240701151436.GA41530@francesco-nb>
References: <20240621095045.1536920-1-ivitro@gmail.com>
	 <0c5445a5142612fa617fef91cb85fa7ed174447f.camel@kernel.org>
	 <20240701151436.GA41530@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:14 +0200, Francesco Dolcini wrote:
> On Mon, Jul 01, 2024 at 03:02:11PM +0000, Jarkko Sakkinen wrote:
> > On Fri, 2024-06-21 at 10:50 +0100, Vitor Soares wrote:
> > > From: Vitor Soares <vitor.soares@toradex.com>
> > >=20
> > > "atmel,attpm20p" DT compatible is missing its SPI device ID entry, no=
t
> > > allowing module autoloading and leading to the following message:
> > >=20
> > > =C2=A0 "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20=
p"
> > >=20
> > > Based on:
> > > =C2=A0 commit 7eba41fe8c7b ("tpm_tis_spi: Add missing SPI ID")
> > >=20
> > > Fix this by adding the corresponding "attpm20p" spi_device_id entry.
> > >=20
> > > Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attpm2=
0p")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > This is not a bug fix. This is a feature.
>=20
> I believe that some maintainer have a different view on this kind of
> patches compared to you, adding new device id would be material for
> stable, or this specific issue preventing module auto loading.
>=20
> I noticed that this specific view is not new from you, see
> https://lore.kernel.org/all/CY54PJM8KY92.UOCXW1JQUVF7@suppilovahvero/.
>=20
> With that said, I am ok with it.
>=20
> Do you want a new patch version without Fixes/Cc:stable tags or you can
> remove those while applying?
>=20
> Francesco

Hmm... OK, I'll apply this version, I see your point here!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

