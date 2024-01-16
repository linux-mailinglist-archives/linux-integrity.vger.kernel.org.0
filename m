Return-Path: <linux-integrity+bounces-823-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A982F461
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0921F2492A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA71CD31;
	Tue, 16 Jan 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUX3Zpt1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C310A1A;
	Tue, 16 Jan 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430228; cv=none; b=Jq1eXLnLFXtJTqdvTPC72x7EmqVqZ6p2jpYzKHdpPY2xYOc25Nv6Blj9+q0ern5Tl1gi6uJcFXEArxYSxM0ubmaTrXiDFoKk0hlu7u3UrH7+gcp110sXA8w20HfzTIq3rOMVeUrFLlhzv0oDDOdoGYu00L4d/IEawedVduTwCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430228; c=relaxed/simple;
	bh=Y5vvGd8nKvvbzMcdjzzUBFGNkkXCqj92/HLGh4OyYdE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=FQlIIljRSro7q2aVFIVoNMje1YHvDLSF8yXu31RxnDIvVz8dkgQceTu45uV2UAyAEapsa8QtzVIOepIOTOAA+3jWd39Y6a2sxMMh20uw3Lktb6KGGFNbnvwkBaHhx3jICtWQouX4wqnjSyXgoWN2+u7z2MYfMfRDGkzRQoWEhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUX3Zpt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEBEC433C7;
	Tue, 16 Jan 2024 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430227;
	bh=Y5vvGd8nKvvbzMcdjzzUBFGNkkXCqj92/HLGh4OyYdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUX3Zpt1eyLvR+W3zL/vZOOdscX4ijOKCLYs8Sw5AQW9vBGumyqzywgnymW1T3yhT
	 yNyMbe+yLy/7g+awe7iOHBGw5UnKVEecuyQHzDK178+jJzk9+UTG0cN9/Pwv3rWPhA
	 GX6ree090s+imaRaXxbm7Ws8BFpC597JBLiMvQatLqEF6UWVvoFKFOBOM28vtiPYBb
	 FcGtq28MbqtuSDDfGE8VAx60OsFZUqcaTBygUXBCau0g1UoiO9v7ZNFO1Wvos+Fpyq
	 A4TNNhmDhL7+tDG0w17R9i6ZEg427d4HdLLMaxmm7ZVhH3N2CpN/zkL3Tv9I8hVEcK
	 +AtJZs2+s9dvw==
Date: Tue, 16 Jan 2024 12:37:05 -0600
From: Rob Herring <robh@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 1/4] dt-bindings: tpm: Add compatible string
 atmel,attpm20p
Message-ID: <20240116183705.GA220865-robh@kernel.org>
References: <cover.1705140898.git.lukas@wunner.de>
 <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>
 <CYDW3GS1VGP4.2PUT4XW283L99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYDW3GS1VGP4.2PUT4XW283L99@kernel.org>

On Sat, Jan 13, 2024 at 11:17:39PM +0200, Jarkko Sakkinen wrote:
> On Sat Jan 13, 2024 at 7:10 PM EET, Lukas Wunner wrote:
> > Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
> > added a devicetree node for the Trusted Platform Module on certain
> > Gateworks boards.
> >
> > The commit only used the generic "tcg,tpm_tis-spi" compatible string,
> > but public documentation shows that the chip is an ATTPM20P from Atmel
> > (nowadays Microchip):
> > https://trac.gateworks.com/wiki/tpm
> >
> > Add the chip to the supported compatible strings of the TPM TIS SPI
> > schema.
> >
> > For reference, a datasheet is available at:
> > https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> >
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> > index c3413b4..6cb2de7 100644
> > --- a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> > +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> > @@ -20,6 +20,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - atmel,attpm20p
> >            - infineon,slb9670
> >            - st,st33htpm-spi
> >            - st,st33zp24-spi
> 
> You should to send the patch set with Rob Herring as CC for syncing
> up. Please do it for future versions, if there is need for additional
> versions.

More specifically, use what get_maintainers.pl outputs.

I don't actually care if I'm Cc'ed because I'm just Cc'ed on everything 
to the DT list.

> Rob, 3 out of 4 patches are TPM patches. Do you mind if I take all
> four patches once the patch set is ready or do you want to pick this
> patch (assuming that you think it is correctly implemented ofc)?

You can take it.

Rob

