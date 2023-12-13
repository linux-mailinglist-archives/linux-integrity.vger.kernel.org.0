Return-Path: <linux-integrity+bounces-434-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3703811C2A
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023C61C212F7
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C459B48;
	Wed, 13 Dec 2023 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2P92Cgd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495C3173D;
	Wed, 13 Dec 2023 18:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670E5C433C7;
	Wed, 13 Dec 2023 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702491524;
	bh=VmD4PSEal/Oz36jy5f+5kaRai9u7pyp8fynzdDmI2do=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=X2P92CgdOxQRlOF6Y/p2g5JD1pkpHumiiu9p5GDFPCiLmujjHvpYytSN41+m+dFbM
	 LPf5Fcv5lFuMzDJb7YIYytx5y3jShptvJAUD3lox1shQM+eGRGvAK/IWDCNsbqpKCq
	 nF191Vv4/8qxf+i5UjcXUNEjGbZqMPoLzvXAQpnbV9BFN7vlzDMtZMVx4SMZ8fIuNs
	 Ffws+/iE/wjlT7ufm7QnqblkO7NomQZk22M6/MWNlp0dgUgn1EbrPkfoFgtuWTTx/2
	 oSb2w4EBkFOXrY4I/yfFIbRQ5KloinB/P3cxzOrlhbN+W5DKTgSPHVLlw1RzW6T92Q
	 +o/7nl5bbZt8A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Dec 2023 20:18:35 +0200
Message-Id: <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
Cc: <patrick.rudolph@9elements.com>, <vincent@vtremblay.dev>,
 <peteryin.openbmc@gmail.com>, <lakshmiy@us.ibm.com>, <bhelgaas@google.com>,
 <naresh.solanki@9elements.com>, <alexander.stein@ew.tq-group.com>,
 <festevam@denx.de>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <geissonator@yahoo.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ninad Palsule" <ninad@linux.ibm.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <joel@jms.id.au>, <andrew@codeconstruct.com.au>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <keescook@chromium.org>, <tony.luck@intel.com>,
 <gpiccoli@igalia.com>, <johannes.holland@infineon.com>,
 <linux@roeck-us.net>, <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
In-Reply-To: <20231212164004.1683589-2-ninad@linux.ibm.com>

On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
> Document the new compatibles used on IBM system1-bmc
>
> Tested:

this not very useful line :-) (nit)

>     This board is tested using the simics simulator.

Just leave this (w/o indentation)

>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 6f7543463d89..ebebe14c42aa 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -85,6 +85,7 @@ properties:
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> +              - ibm,system1-bmc
>                - ibm,tacoma-bmc
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 441b55723675..b12a60d2eb0f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -135,6 +135,8 @@ properties:
>            - ibm,cffps1
>              # IBM Common Form Factor Power Supply Versions 2
>            - ibm,cffps2
> +            # Infineon barometric pressure and temperature sensor
> +          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38060 Voltage Regulator

BR, Jarkko

