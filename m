Return-Path: <linux-integrity+bounces-2918-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F789132D4
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Jun 2024 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70D01C21384
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Jun 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8214B078;
	Sat, 22 Jun 2024 09:07:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA01422B6;
	Sat, 22 Jun 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719047277; cv=none; b=ma+TLklA4R3HMLD9dST5bLwLWncx1td//8tq46XwHL0sCF+t89g+M3pSIeWjdo3QLp9J5yf8+EZWh9+7f2GpXP5b5pMdu+fKxh70vPgj0JMFXhGMAzyDzIEFNSVzPDGwsMyXxFjELyRlpxMioTCUiH4btt51r5pWaIgMKfhbNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719047277; c=relaxed/simple;
	bh=+FuvJtsP9SJ6aiyTqiZW9XCzUF9EjlW9UdyiooZxPBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csy+tfqH5vsQ7N1YR8izhB5cfPExg0KIzLQIoy/B2u0pZIcjlrkscMWfrg5JzWt9E/VESMJl8Szf8ngaZZtoHuOkfTc31JUCI3UA401ZQ5Sso/ZKFaYhP3JGMwLq+sJ8/BOh+dyqHc/XrR6RYoCkPVCv0pr0XM1FAk6OsyS+qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id AAD223000ACA9;
	Sat, 22 Jun 2024 11:07:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 80E4153DB7; Sat, 22 Jun 2024 11:07:44 +0200 (CEST)
Date: Sat, 22 Jun 2024 11:07:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
Message-ID: <ZnaUYICRxvSG-sTX@wunner.de>
References: <20240621095045.1536920-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621095045.1536920-1-ivitro@gmail.com>

[removing stable@vger.kernel.org from cc -- they're only interested
in your patch once it's in Linus' tree]

On Fri, Jun 21, 2024 at 10:50:45AM +0100, Vitor Soares wrote:
> "atmel,attpm20p" DT compatible is missing its SPI device ID entry, not
> allowing module autoloading and leading to the following message:
> 
>   "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20p"
[...]
> Fix this by adding the corresponding "attpm20p" spi_device_id entry.
> 
> Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attpm20p")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

The old problem that spi modules aren't auto-loaded based on
MODULE_DEVICE_TABLE(of, ...), but only on MODULE_DEVICE_TABLE(spi, ...):

https://lore.kernel.org/all/20170811081429.GA9957@wunner.de/

Completely forgot that this is still a problem after all these years. :(

Thanks,

Lukas

