Return-Path: <linux-integrity+bounces-432-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D82811A50
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D33B1F211C4
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CD39FD7;
	Wed, 13 Dec 2023 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSQfDZUI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D031D52D;
	Wed, 13 Dec 2023 17:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D26C433C9;
	Wed, 13 Dec 2023 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702486896;
	bh=4fBJv8PIdFoElPSrlOgisn8Fu54FIbWJlu7W6b9QNlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cSQfDZUIpIRag5sSA8GXWihfGknftAuyuKFCSxvu/luypq5MMMDXhijTX7+91npL6
	 yRiK1wlCIs/h5VfPdm54g81S3rpnFnhwUJjstK+hhYrTF8J3Dg1MTs4tQs6RFld32u
	 H0VIYeL9mFo+wcDJ8R8/0QJoDIr2ocF4D9BgZSNC6YRRcfGlvWIwzVKOFlWWfxPj+S
	 uU8VNuEypx2RTrRO+4owKEx0AAwOK0varDGaX9fjmYGV2F017FcxFNqbJk2VuwT8hj
	 WFR3H41so0/zq+pbYiJJUsyXEFnShEtNNet71CM5iodrvkij7yqnqzEyExcdUFhNUm
	 dfNRRQGXKzTbA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso8308354e87.0;
        Wed, 13 Dec 2023 09:01:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzX4dPG2jnAdGXse7ok4nEbzS+8qNDItujU6t8jCcOHa3YxZNxg
	6x56Lw8OZ124w10IKL7t/BHYEtttqWcYF/1C/g==
X-Google-Smtp-Source: AGHT+IErN3H8UhdvFf1+7pMbUlaEbtDcsulhyP6DTTjiD81wOIhFRwyJsoYSKfwsMDIDj0y4fR7IdaqEkmklxl8mmF8=
X-Received: by 2002:a05:6512:3b09:b0:50b:f269:64d1 with SMTP id
 f9-20020a0565123b0900b0050bf26964d1mr4411884lfv.72.1702486894216; Wed, 13 Dec
 2023 09:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701093036.git.lukas@wunner.de> <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
 <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com> <20231213162319.GA31314@wunner.de>
In-Reply-To: <20231213162319.GA31314@wunner.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 13 Dec 2023 11:01:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=14b19yHZ=rnVd8uLu=kn5W9y0irk0XA983Eo+ByBnA@mail.gmail.com>
Message-ID: <CAL_JsqJ=14b19yHZ=rnVd8uLu=kn5W9y0irk0XA983Eo+ByBnA@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 10:23=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Mon, Nov 27, 2023 at 10:31:06AM -0600, Rob Herring wrote:
> > On Mon, Nov 27, 2023 at 8:09AM Lukas Wunner <lukas@wunner.de> wrote:
> > > A significant number of Trusted Platform Modules conform to the "TIS"
> > > specification published by the Trusted Computing Group ("TCG PC Clien=
t
> > > Specific TPM Interface Specification").  These chips typically use an
> > > SPI, I=E6=B6=8E or LPC bus as transport (via MMIO in the latter case)=
.  Some
> > > of them even support multiple of those buses (selectable through a
> > > config strap) or the same chip is available in multiple SKUs, each wi=
th
> > > a different bus interface.
> > >
> > > The devicetree bindings for these TPMs have not been converted to DT
> > > schema yet and are spread out across 3 generic files and 3 chip-speci=
fic
> > > files.  A few TPM compatible strings were added to trivial-devices.ya=
ml
> > > even though additional properties are documented in the plaintext
> > > bindings.
> > >
> > > Consolidate the devicetree bindings into 3 files, one per bus.
> [...]
> > > Changes v1 -> v2:
> > >   * Drop google,cr50 SPI example (Rob).
> >
> > That's going to avoid a warning in the examples, but it's going to
> > fail any actual google,c50 SPI user. What's going to happen is both
> > the SPI and I2C TPM schemas will be applied. Any SPI based cases will
> > fail if they have SPI properties because the I2C schema won't allow
> > them. If there is no fallback for google,cr50, then you must do a
> > separate schema doc (well, you could do an if/then schema in
> > tcg,tpm-tis-i2c.yaml to reference spi-peripheral-props.yaml, but that
> > would look kind of odd).
>
> I'm wondering if a "select:" property in the schema would be a viable
> (and acceptable) way to solve this.
>
> Ideally the validator would match a regex against the $nodename of the
> parent and see if it contains "spi" or "i2c".  But I think matching
> against the parent's $nodename isn't possible, is it?

No. I've thought of adding something like that, but haven't.

>  I can only
> match the TPM's $nodename, right?

Right.

> All the devicetree nodes in arch/arm64/boot/dts/* containing a
> google,cr50 compatible string have an spi-max-frequency property if
> they're attached to SPI.  So I think it may be possible to select the
> i2c or spi schema based on presence of that property if the compatible
> string is google,cr50.  A bit kludgy perhaps but if there's no better
> option?

I don't think we should make spi-max-frequency required.

> What I don't like about creating a custom schema for google,cr50 is that
> there may be other chips in the future which support multiple buses,
> so we'd need an spi+i2c schema and probably also an spi+i2c+mmio,
> i2c+mmio, spi+mmio schema.  It gets messy.  Granted we could enforce
> that these newly added chips use a fallback compatible that we could
> select the schema with.  Still, automatically selecting the right
> schema would be better, in particular if I could somehow match against
> the $nodename of the parent.

Seems like more of a theoretical problem than realistic. I think cr50
is a bit of a special case. It also has other functions AIUI and maybe
we'll need other DT properties. If we do have new ones, I think
enforcing the fallback should be enough. After all, that's what you
tried to do in v1, but we're stuck with it for cr50.

Another option is combine the SPI and I2C schemas. Then you just need:

if:
  properties:
    compatible:
      contains:
        enum:
          - tcg,tpm_tis-spi
          - google,cr50
then:
  $ref: spi-peripheral-props.yaml

I would leave MMIO separate in that case. Seems unlikely something
would have MMIO and a serial interface.

I still lean towards a separate schema for cr50 over this.

BTW, there's now another conversion patch[1] which I forgot to Cc you
on my reply.

Rob

[1] https://lore.kernel.org/all/20231213161347.GA1204384-robh@kernel.org/

