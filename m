Return-Path: <linux-integrity+bounces-226-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88D7FA66B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C89FB20B92
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE030F8F;
	Mon, 27 Nov 2023 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TffA28v8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FF36AEA;
	Mon, 27 Nov 2023 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C05CC433C9;
	Mon, 27 Nov 2023 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102680;
	bh=QyrwuZSluoOjDbBks6BhG0l158nQkSBESH7pk3BuN/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TffA28v8TQYOj/Sb3yTimxZBiF3/XGnEc1+oojAdi2hPpPfj424H85o0QP8MdaL8w
	 AE1i94EwHCHsYv0VRxGj8imypbozPKn1yrvdntnBsbp7WAMFoVQl+jZN9N6qDuYJRh
	 bl9dvf4iWkLqteUHMox7C/VZkxk2TGTT1sasAGUReOSeIJOJT3Mq1ehwPH4GGvuooD
	 WBw20cRxxqp4aBOHjfwXx0z/5f4h0CFI1MbCSlVXZBC1fvF/+xi047G8U6kCKvy1/v
	 NwEUqwUz5bWVdweucLmgEHTZD8EaupYHfD/wp+r2SSIvR43ZM4aBM59dKoK/1YHhGx
	 S+R4oAz9Tz1og==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ba75e33f3so3468559e87.2;
        Mon, 27 Nov 2023 08:31:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yz7HDG1SBwGaWDRdAEnOG2yo9onP43NeCf+kETHwTess7dyx2kd
	6yYXMyi/HqIeWdCaKbA/x/26oI6LbDUa9uUhHw==
X-Google-Smtp-Source: AGHT+IHFeX3nhFy49WRqdXV+PP4d4cXmmkxRaXig2AIq3mYt0a41fSudyhyy1H4l8l6jZKZv+ppy567rFcegLRgtz+Y=
X-Received: by 2002:ac2:52ab:0:b0:50b:ae2f:4d9f with SMTP id
 r11-20020ac252ab000000b0050bae2f4d9fmr3064778lfm.54.1701102678303; Mon, 27
 Nov 2023 08:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701093036.git.lukas@wunner.de> <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
In-Reply-To: <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 27 Nov 2023 10:31:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
Message-ID: <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 8:09=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> A significant number of Trusted Platform Modules conform to the "TIS"
> specification published by the Trusted Computing Group ("TCG PC Client
> Specific TPM Interface Specification").  These chips typically use an
> SPI, I=C2=B2C or LPC bus as transport (via MMIO in the latter case).  Som=
e
> of them even support multiple of those buses (selectable through a
> config strap) or the same chip is available in multiple SKUs, each with
> a different bus interface.
>
> The devicetree bindings for these TPMs have not been converted to DT
> schema yet and are spread out across 3 generic files and 3 chip-specific
> files.  A few TPM compatible strings were added to trivial-devices.yaml
> even though additional properties are documented in the plaintext
> bindings.
>
> Consolidate the devicetree bindings into 3 files, one per bus.
>
> Move common properties to a separate tpm-common.yaml.
>
> Document compatible strings which are supported by the TPM TIS driver
> but were neglected to be added to the devicetree bindings.
>
> Document the memory-region property recently introduced by commit
> 1e2714bb83fc ("tpm: Add reserved memory event log").
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes v1 -> v2:
>   * Overhaul i2c compatible definitions.  Turns out that the fallback
>     tcg,tpm-tis-i2c only applies to chips conforming to the PTP spec,
>     wheras other chips use a vendor-specific interface and thus omit
>     the fallback.
>   * Don't enforce fallback compatible tcg,tpm_tis-spi for google,cr50.
>   * Add nodename restriction to tpm-common.yaml.
>   * Add clock constraints that were previously documented for
>     infineon,slb9635tt and infineon,slb9645tt.
>   * Drop google,cr50 SPI example (Rob).

That's going to avoid a warning in the examples, but it's going to
fail any actual google,c50 SPI user. What's going to happen is both
the SPI and I2C TPM schemas will be applied. Any SPI based cases will
fail if they have SPI properties because the I2C schema won't allow
them. If there is no fallback for google,cr50, then you must do a
separate schema doc (well, you could do an if/then schema in
tcg,tpm-tis-i2c.yaml to reference spi-peripheral-props.yaml, but that
would look kind of odd).

Rob

