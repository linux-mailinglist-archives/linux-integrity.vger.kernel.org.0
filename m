Return-Path: <linux-integrity+bounces-531-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F199C817C5B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 22:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61341F231BB
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6773465;
	Mon, 18 Dec 2023 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL7jv8za"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD8A2D;
	Mon, 18 Dec 2023 21:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A27C43395;
	Mon, 18 Dec 2023 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702933315;
	bh=AB00qD3Ni0x+sMJqQuHXkbBurZHwihPTNyuC62l4mIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OL7jv8zagTR9Wa/Z1MKeYECZV7HUW9g6bhf1+6VRaXLN1zJpzTX1rF4u/ixDOjvQp
	 HgJKxeG29XwsK4pHHylksO5cmdYF9pK7whGbn+pBW1THpuG2ah1iWc0hR0RIEBSzba
	 W8XIiSmqwFn2CAiuBlgagbXHUyyJD+DQdPpQguxiCEC31h4RA/RIlyrVjj8YKieY2Y
	 U2EqjrnTrlZcnYCd+pTk/vbBBX3WaR4LDl0tWCz4BDuZeaBHuy1dmHhVx4JBTAjYmw
	 mIkamE8HJag5c1C3+oyKMrBkW0WWTaScLdvshOc8kTIF17Lzr9K83A7lRwJpWe7LG5
	 zO2Hse0zcoXTg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e384cd6ebso1847811e87.3;
        Mon, 18 Dec 2023 13:01:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzONsUjNAlVTjHNpW8UN/JWYRkC/UDLt3o9HtyRqoLz2/ot/IRL
	3dIMs+m4ixsLxuPEPtn/nar3Va9qmKfB50wfFQ==
X-Google-Smtp-Source: AGHT+IFk5wtJASz/OLwqlySUAfrjwRkGoOk+cgnDJrdvoscQSusQODPnNFtFda6GCFbdHjqbNw3yJXK/LYHii9MCWy0=
X-Received: by 2002:ac2:551b:0:b0:50e:3ccc:a8e with SMTP id
 j27-20020ac2551b000000b0050e3ccc0a8emr525177lfk.30.1702933313826; Mon, 18 Dec
 2023 13:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701093036.git.lukas@wunner.de> <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
 <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
 <20231213162319.GA31314@wunner.de> <CAL_JsqJ=14b19yHZ=rnVd8uLu=kn5W9y0irk0XA983Eo+ByBnA@mail.gmail.com>
 <20231215152411.GA20902@wunner.de>
In-Reply-To: <20231215152411.GA20902@wunner.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 18 Dec 2023 15:01:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHV+7Mcw9CeRVrd6qJR0Yv=+XG_ZwLR8B+113Kp2Wn4g@mail.gmail.com>
Message-ID: <CAL_JsqLHV+7Mcw9CeRVrd6qJR0Yv=+XG_ZwLR8B+113Kp2Wn4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: tpm: Consolidate TCG TIS bindings
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, 
	Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, 
	Alexander Steffen <Alexander.Steffen@infineon.com>, 
	Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, 
	Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:24=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Dec 13, 2023 at 11:01:21AM -0600, Rob Herring wrote:
> > On Wed, Dec 13, 2023 at 10:23AM Lukas Wunner <lukas@wunner.de> wrote:
> > > Ideally the validator would match a regex against the $nodename of th=
e
> > > parent and see if it contains "spi" or "i2c".  But I think matching
> > > against the parent's $nodename isn't possible, is it?
> >
> > No. I've thought of adding something like that, but haven't.
>
> Please consider this a feature request. :)
>
> It would be good if it were possible to define constraints not just
> for the $nodename of the parent, but any of its properties.

You could write such a schema, but it would have to be applied to the
parent node rather than the child node. It would have to be applied to
every 'i2c' node and in theory you could have one for every i2c
device. We could define something like "$defs/parent-schema" within
the child device schema and make the tools apply it to the parent
node.

> E.g. with i2c, the clock-frequency is set at the host controller's
> devicetree node, not at each attached i2c peripheral's node.
> For ACPI, i2c_acpi_find_bus_speed() walks the bus to find the
> highest clock speed supported by all attached i2c peripherals,
> but for OF, the onus is on the devicetree author to manually
> determine the clock.
>
> Thus, for a TPM such as infineon,slb9635tt which only supports 100 kHz,
> I want to validate that the parent node's clock-frequency is less than
> or equal to that.
>
> In Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
> there's an example showing a clock-frequency property at the
> peripheral's node and I mistakenly carried that over to the yaml
> schema.  A look at the code reveals that's entirely bogus so I'll
> drop the clock-frequency property in v3.  I will retain textual
> hints that infineon,slb9635tt is limited to 100 kHz and
> infineon,slb9645tt to 400 kHz, but as it stands I can't define
> rules that would allow the validator to check that automatically.

We could adapt the bindings to accept that. Makes sense as that's
mostly a property of each device. SPI freq is per child, but I guess
I2C has to be the minimum of all the child nodes.

Rob

