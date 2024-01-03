Return-Path: <linux-integrity+bounces-636-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BE82310B
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A121C20A79
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6481B28E;
	Wed,  3 Jan 2024 16:10:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D71B28F
	for <linux-integrity@vger.kernel.org>; Wed,  3 Jan 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A018830000647;
	Wed,  3 Jan 2024 17:10:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 946212B0031; Wed,  3 Jan 2024 17:10:36 +0100 (CET)
Date: Wed, 3 Jan 2024 17:10:36 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Tim Harvey <tharvey@gateworks.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: Add compatible string atmel,attpm20p
Message-ID: <20240103161036.GA21138@wunner.de>
References: <188b88ffeeae958847370dcd1fb28fe708a2aeb7.1703323863.git.lukas@wunner.de>
 <CY54EBMTTLQ2.194Z8E1D2OZGF@suppilovahvero>
 <CY54GMOIMYHU.3BTC0MFJZ4XAK@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY54GMOIMYHU.3BTC0MFJZ4XAK@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 03, 2024 at 03:57:00PM +0200, Jarkko Sakkinen wrote:
> On Wed Jan 3, 2024 at 3:53 PM EET, Jarkko Sakkinen wrote:
> > On Sat Dec 23, 2023 at 11:34 AM EET, Lukas Wunner wrote:
> > > Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
> > > added a devicetree node for the Trusted Platform Module on certain
> > > Gateworks boards.
> > >
> > > The commit only used the generic "tcg,tpm_tis-spi" compatible string,
> > > but public documentation shows that the chip is an ATTPM20P from Atmel
> > > (nowadays Microchip):
> > > https://trac.gateworks.com/wiki/tpm
> > >
> > > Add the chip to the supported compatible strings of the TPM TIS SPI
> > > driver.
[...]
> > > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > > @@ -327,6 +327,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
> > >  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> > >  
> > >  static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
> > > +	{ .compatible = "atmel,attpm20p", .data = tpm_tis_spi_probe },
> > >  	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
> > >  	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
> > >  	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
> 
> Taking this back as checkpatch gives warning:
> 
> WARNING: DT compatible string "atmel,attpm20p" appears un-documented -- check ./Documentation/devicetree/bindings/
> #36: FILE: drivers/char/tpm/tpm_tis_spi_main.c:330:
> +	{ .compatible = "atmel,attpm20p", .data = tpm_tis_spi_probe },

Yes, sorry for the confusion.

Before applying this patch, you'd first have to pick up this series
to clean up TPM dt-bindings (it has a Reviewed-by from Rob):

https://lore.kernel.org/all/cover.1702806810.git.lukas@wunner.de/

Plus the following patch I just submitted which adds "atmel,attpm20p"
to the dt-bindings (feel free to squash with the patch "dt-bindings:
tpm: Consolidate TCG TIS bindings" in the above-linked series):

https://lore.kernel.org/all/20240103155414.93-qGU4jYFy5x6c0EXMdyw2SO2Vyz5tChxsDLbWzSFE@z/

Note that there are two other patches pending to add missing compatible
strings to the driver, but they likewise depend on the above-linked
series to clean up TPM dt-bindings:

https://lore.kernel.org/all/096e5d9d22eaed0a256d2d9b315a77245bd423c6.1701095446.git.lukas@wunner.de/
https://lore.kernel.org/all/5c92620082189dc4e6be277952d0b46df26a6478.1702811113.git.lukas@wunner.de/

Thanks,

Lukas

