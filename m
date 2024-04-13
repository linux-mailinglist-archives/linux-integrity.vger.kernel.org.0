Return-Path: <linux-integrity+bounces-2094-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC08A3C59
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AB6B216BB
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84F335D3;
	Sat, 13 Apr 2024 10:56:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04E32C8E;
	Sat, 13 Apr 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005777; cv=none; b=m2Z2zFjZSGoWQTbjiF1SzzWIbkMf4nxmVFBhayYzQynw4Xdip7IBFh92GIN8Fgg9SXxrY/0vy1dzjsdmhGf6KwKYm07nPW6mBZMT092uMThQ9xykMLeKaco15Mv3IpmEQBDOjAceoCU7SKtyuH0oXeEIis+NeT8N7sZkD3sFKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005777; c=relaxed/simple;
	bh=i4dRBcoOhEifKzQLdb6ZPJ/GvNemhgZuPFYuS2Xg6rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajluBsDywHGsM6RXX2DpsMRhLp8FClzLg+AJ63RNXqUjt/0P/eqK3MW5N7oZ4zuRaHE7FmuLgVU1BBK7n9PZ5arcEoYV1a4/nxKHef33ZGTDTajD/Gi2BEyv+Hwc7fb4Uu3PyY1CBgp7+4TahpNtapEUNzUnI/DnV6fV4t4Pdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5C0EA280269B9;
	Sat, 13 Apr 2024 12:56:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4908A48444; Sat, 13 Apr 2024 12:56:13 +0200 (CEST)
Date: Sat, 13 Apr 2024 12:56:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "M. Haener" <michael.haener@siemens.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Message-ID: <ZhpkzWhOdW3OaJfn@wunner.de>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
 <ZhpjozjbeWrb0OTl@wunner.de>
 <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>

On Sat, Apr 13, 2024 at 12:53:25PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2024 12:51, Lukas Wunner wrote:
> > The binding requires two entries in the compatible string used in the DT,
> > the chip name followed by the generic string:
> > 
> >         items:
> >           - enum:
> >               - infineon,slb9673
> >               - nuvoton,npct75x
> >           - const: tcg,tpm-tis-i2c
> > 
> > This allows us to deal with device-specific quirks, should they pop up
> > (e.g. special timing requirements, hardware bugs).  We don't know in
> > advance if they will be discovered, but if they are, it's cumbersome
> > to determine after the fact which products (and thus DTs) are affected.
> > So having the name of the actual chip used on the board has value.
> 
> So you say devices are compatible. Then the second patch is wrong.
> 
> I cannot respond to it, though... so NAK-here-for-second-patch.

I disagree.  It's ugly to have inconsistencies between the DT bindings
and the driver.  So I think patch [1/2] in this series is fine.

Thanks,

Lukas

