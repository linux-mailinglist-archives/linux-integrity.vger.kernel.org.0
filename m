Return-Path: <linux-integrity+bounces-647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1882485B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A052875A7
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636FA28E1B;
	Thu,  4 Jan 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0Jc5VRG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B528E0F;
	Thu,  4 Jan 2024 18:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E2AC433C8;
	Thu,  4 Jan 2024 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704393994;
	bh=sENc5CCnxhI6r+hrIlR9tlhr2WUZEqLABBgNTIa2NzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0Jc5VRGht41sBI1wBEvrgYuZzegmyVNiwD8dYnY5SWBbVHyUelzEWC+RU9xC8Ch+
	 fwB8iTeeEJb/BBXxs32a9XveEKcVurNGVxT9/zNORFRk0C1nIKoP7Mwrh11A+g3s4V
	 02hg/4qHtO3bieo/VaZThvBix6otXiF1gLFhYUfuWPmD9wqB8jg+xDSTXbir0vMYRH
	 j4eCBK0aKJ0lix2UEN80xmgJd+SRMJtBFdn+qDUsam3dV0VhhLyTsPwThH5C59818z
	 BXsQtIc+SQDU0KxmQEbXV0btCpxD0F7eJRNDaeHgBYtLm9uQLlBCz8iSPOHcQyf2rO
	 LwGW4FG0Qt7Gw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jan 2024 20:46:30 +0200
Message-Id: <CY658TZN29WJ.2DMIWN3W68P2P@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Tim
 Harvey" <tharvey@gateworks.com>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: tpm: Add compatible string atmel,attpm20p
X-Mailer: aerc 0.15.2
References: <ea312fdaab76efd1cbcc4ed9fd0e15e5afd1ef88.1704296746.git.lukas@wunner.de> <CY62RZMRHTT4.30ELSWNQFH6K4@suppilovahvero>
In-Reply-To: <CY62RZMRHTT4.30ELSWNQFH6K4@suppilovahvero>

On Thu Jan 4, 2024 at 6:50 PM EET, Jarkko Sakkinen wrote:
> On Tue Jan 3, 2023 at 5:51 PM EET, Lukas Wunner wrote:
> > Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device"=
)
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
> > https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platf=
orm-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> >
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > ---
> > This patch depends on the following series to consolidate TCG TIS bindi=
ngs:
> > https://lore.kernel.org/all/cover.1702806810.git.lukas@wunner.de/
> >
> >  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml=
 b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
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
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

meant:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I can pick this if no objections.

BR, Jarkko

