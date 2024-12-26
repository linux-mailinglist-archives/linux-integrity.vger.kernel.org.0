Return-Path: <linux-integrity+bounces-4478-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A852A9FCD7A
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 20:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE711880742
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4613BAD5;
	Thu, 26 Dec 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/ck/VWl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64C139E;
	Thu, 26 Dec 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735242899; cv=none; b=j9sJSECc1g0JaiZNEi0tSx/lo788wUVb+YekAdUU5wg2/e/neGay3tlp1os/ie9InBKOhKAx+72Wnl3H6A5cSo1+Dkfvc5lzgOHwFzAxVSeDxNTWynoQCRY5siE4RjtaT70lv4s6zogpooiAusqTZN43TTXjvzGsA13WWwdBlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735242899; c=relaxed/simple;
	bh=rq4B90XeRA6BAWm8wIFGtJbL3N/vons8CeKyjqxC+pY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bKA4HbU1miD1azQyJN0+41NdwEHsdQbBIuNCmT4ixzxcTAc8WYDNJG6INXnqrAGyHvQOWwxrInos32zy0BsXPnRVHNKCDv4dLqVA3ZzVBMYc5bydvPg8u7WP3lt3dfj/+FbbKrnT2REj83I6m41oUuvwtXvF2zu/eCQejIH1J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/ck/VWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F441C4CED1;
	Thu, 26 Dec 2024 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735242899;
	bh=rq4B90XeRA6BAWm8wIFGtJbL3N/vons8CeKyjqxC+pY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=J/ck/VWlKJjKP236O3QCMI4dQ/z5Hy2TqtWKhMvYcir3tDmeCBKnAkQXtY+NHtm45
	 z27eMyew8XRzwZ8LF+E4G8jg62gYXVUSs3eOEn5SReiY9u3DczKb9bLDGZNFZgCfLG
	 ESx/GwKdcBKkvVYuJW9XtvocSMcUnC/IHYAlVgvtB6Xzl2FO2SMDAoIqfpWbDo9b+X
	 65iyuvCxryZgWWZPpwDOsGjN0iDhoo95zcSwhAGg150qZyh6JDYMdkMjaVKzSf5+z3
	 aP4DXOnTrjf4lB9EO2HhCdLA6VU9icALI/FQGg8xD1gvBbrZxn6/Co14m2pEr2+2BV
	 VzRwfLdpYn/vA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Dec 2024 21:54:54 +0200
Message-Id: <D6LW9OLX0RGQ.1N4FRX7R7ZYS6@kernel.org>
Cc: "Conor Dooley" <conor+dt@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lukas Wunner"
 <lukas@wunner.de>, "Peter Huewe" <peterhuewe@gmx.de>, "Rob Herring"
 <robh@kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Marek Vasut" <marex@denx.de>, <devicetree@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241226171124.83735-1-marex@denx.de>
In-Reply-To: <20241226171124.83735-1-marex@denx.de>

On Thu Dec 26, 2024 at 7:10 PM EET, Marek Vasut wrote:
> Add the ST chip st33tphf2ei2c to the supported compatible strings of the
> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
                          ~~~~
			  chip

> Profile specification.
>
> For reference, a databrief is available at:
> https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf

Or just this would be enough:

Link: https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf

>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b=
/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> index af7720dc4a12c..fdd7fd874e01e 100644
> --- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> @@ -33,6 +33,7 @@ properties:
>                - infineon,slb9673
>                - nuvoton,npct75x
>                - st,st33ktpm2xi2c
> +              - st,st33tphf2ei2c
>            - const: tcg,tpm-tis-i2c
> =20
>        - description: TPM 1.2 and 2.0 chips with vendor-specific I=C2=B2C=
 interface


BR, Jarkko

