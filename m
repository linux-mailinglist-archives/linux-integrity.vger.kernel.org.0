Return-Path: <linux-integrity+bounces-824-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBB82F464
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4945F1F23C47
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75061CD21;
	Tue, 16 Jan 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPgwJF62"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9810A1A;
	Tue, 16 Jan 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430246; cv=none; b=llPh/TjqQBmynrjEkV4XMIgT6Vg5z0xvw5OY2RHQ38MeLYn5cHBi3BgWcWKUDix6pxWbj1N3ZZZk1qke8+c4P18vYaj9xXYFrouNOctsew5zA2QpTRMdY1PN2N8qxhOvwQMDXT6db3TT4bdCPr+onqytSC2eqIDmaZbzDPauY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430246; c=relaxed/simple;
	bh=jrIsUp3Yu92BDS9AS1nygqbjDfUTqNglCYFfLtfQHcQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=GYQlHokbjViCKHzYjERqdixVBc/xUpbnivV33vWhWeAavVJ6ML3kiXvk6AY67/l6rPfyCmsAU2jwIZXVW7KbuuVBh09/zI56K4ZJdmWtYZL7rKuFsbarJZNaGy473NM3EnhJyShqcoerkAA77RhrK+jJowu5jjDXLFZt1TxqbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPgwJF62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA72C433C7;
	Tue, 16 Jan 2024 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430246;
	bh=jrIsUp3Yu92BDS9AS1nygqbjDfUTqNglCYFfLtfQHcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPgwJF62opjSvOf5sqots1g8r++Bz1trGryiqV013HxPCs5E9HZPI23hfsSQuhzxM
	 f9fhWm8Af4TKahVnkk3Nms7x9M7LMqDXDlAvlEbzd6xiOmvrIoCrS0YTEz0BqqNnrg
	 J1kACfnKn2/nw/TuAJwtnRzIfiJDJBsRHVRQZQco7brrFvIJ31Y3RJnmAYDVebXgXY
	 ocRZD7xYjtQTmzxMy/nZuO/3YBTNnWqzzxJ1q9J/N9JYuJfNrx6edHvs8khMCcw2g4
	 RIP3/n2ZOscbgOWTnkpVuz4cHm6L7te56EO+n54DoLZxELr8AWIWBZXO8x3zZBwVm0
	 8seKHtDhrHsKA==
Date: Tue, 16 Jan 2024 12:37:24 -0600
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: tpm: Add compatible string
 atmel,attpm20p
Message-ID: <170543024347.224631.17074750918076888826.robh@kernel.org>
References: <cover.1705140898.git.lukas@wunner.de>
 <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>


On Sat, 13 Jan 2024 18:10:51 +0100, Lukas Wunner wrote:
> Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
> added a devicetree node for the Trusted Platform Module on certain
> Gateworks boards.
> 
> The commit only used the generic "tcg,tpm_tis-spi" compatible string,
> but public documentation shows that the chip is an ATTPM20P from Atmel
> (nowadays Microchip):
> https://trac.gateworks.com/wiki/tpm
> 
> Add the chip to the supported compatible strings of the TPM TIS SPI
> schema.
> 
> For reference, a datasheet is available at:
> https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


