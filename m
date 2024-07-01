Return-Path: <linux-integrity+bounces-2949-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFC91E3FD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7B5B28215
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1616D9BF;
	Mon,  1 Jul 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fXWJvykL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70216D9AF;
	Mon,  1 Jul 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846894; cv=none; b=iVazTIjkyWhCRdNk6p1d7sYWphIz6T7Is32AQuHRerVbOtKLkUVgLFxNS0lOirHr0xTm0ZiRwoIKNIcDst5IfPv/kbdxU3C130fzZm2jqwAyM1cynHP+rRSenmHnZjkmVzIZhm0fSq45ZKFWKRWRTPgCJfhjDKp2pTrrFpcm2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846894; c=relaxed/simple;
	bh=emEo2nK6RszIfwU6cYRYPUlBrb6n+mIoqRWrZ8dz85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jly0B8x8j78qk38fTseebszymW90+odUoPSB0xiVMOqYrTDN8s9cOtjrzK3Qb373LqfUUWYAsp9NZflMKlog1cWAYCE1onNzOg5p3+/FGEuMr6L5GFdj1295oDF4n6h01+zx7mnUD790gr5yPGu7h9pyNcqO7cmvw0S8YTlRu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fXWJvykL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 80E991F9E9;
	Mon,  1 Jul 2024 17:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719846880;
	bh=lM5/Wnna7Hm3iMcWVYaGjff8NYGJOCK4TV7iz134cXU=; h=From:To:Subject;
	b=fXWJvykL7b9J3bF2RofTCBLONFtRRcLUaY1ACfo2EoNwq5ztoEDz/buPH0kvy25zX
	 ZORBcfEQIVSa2MseOJId6N/lxHc+aj8BqSlRcF4jfEzFtGabBdECAoVBa7JYZR6fWl
	 tef5/kB6A1+VoZeQ3qsZgkiYop2AaHJZ0j0tFWIBuiR/EmwFky9+rTO+0+tNc09oV7
	 M3Nk2mG6c3ThRjiwCNp2Wb4o65yvaJXhSRVEVRNJmMLJTtjabiFRUUVRaYTCcy+52s
	 OxJ3W/oBjQiZ525J4Ctd9CjxKsXI2ddZWx2yPoLEUGgYIOA9gH/5bgZkPghwawA/ky
	 oweV0mP9BVVGg==
Date: Mon, 1 Jul 2024 17:14:36 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Vitor Soares <ivitro@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lukas Wunner <lukas@wunner.de>,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
Message-ID: <20240701151436.GA41530@francesco-nb>
References: <20240621095045.1536920-1-ivitro@gmail.com>
 <0c5445a5142612fa617fef91cb85fa7ed174447f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c5445a5142612fa617fef91cb85fa7ed174447f.camel@kernel.org>

On Mon, Jul 01, 2024 at 03:02:11PM +0000, Jarkko Sakkinen wrote:
> On Fri, 2024-06-21 at 10:50 +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> > 
> > "atmel,attpm20p" DT compatible is missing its SPI device ID entry, not
> > allowing module autoloading and leading to the following message:
> > 
> >   "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20p"
> > 
> > Based on:
> >   commit 7eba41fe8c7b ("tpm_tis_spi: Add missing SPI ID")
> > 
> > Fix this by adding the corresponding "attpm20p" spi_device_id entry.
> > 
> > Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attpm20p")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> 
> This is not a bug fix. This is a feature.

I believe that some maintainer have a different view on this kind of
patches compared to you, adding new device id would be material for
stable, or this specific issue preventing module auto loading.

I noticed that this specific view is not new from you, see
https://lore.kernel.org/all/CY54PJM8KY92.UOCXW1JQUVF7@suppilovahvero/.

With that said, I am ok with it.

Do you want a new patch version without Fixes/Cc:stable tags or you can
remove those while applying?

Francesco



