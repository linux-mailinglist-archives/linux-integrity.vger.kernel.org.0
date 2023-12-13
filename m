Return-Path: <linux-integrity+bounces-430-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD8811928
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629D1B210AE
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0933CDF;
	Wed, 13 Dec 2023 16:23:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39680D5;
	Wed, 13 Dec 2023 08:23:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A27CA101954B3;
	Wed, 13 Dec 2023 17:23:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 72ABAB0320; Wed, 13 Dec 2023 17:23:19 +0100 (CET)
Date: Wed, 13 Dec 2023 17:23:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Nayna Jain <nayna@linux.ibm.com>,
	Thirupathaiah Annapureddy <thiruan@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	Johannes Holland <Johannes.Holland@infineon.com>,
	Amir Mizinski <amirmizi6@gmail.com>,
	Benoit HOUYERE <benoit.houyere@st.com>,
	Peter Delevoryas <peter@pjd.dev>
Subject: Re: [PATCH v2 1/3] dt-bindings: tpm: Consolidate TCG TIS bindings
Message-ID: <20231213162319.GA31314@wunner.de>
References: <cover.1701093036.git.lukas@wunner.de>
 <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
 <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 27, 2023 at 10:31:06AM -0600, Rob Herring wrote:
> On Mon, Nov 27, 2023 at 8:09AM Lukas Wunner <lukas@wunner.de> wrote:
> > A significant number of Trusted Platform Modules conform to the "TIS"
> > specification published by the Trusted Computing Group ("TCG PC Client
> > Specific TPM Interface Specification").  These chips typically use an
> > SPI, I²C or LPC bus as transport (via MMIO in the latter case).  Some
> > of them even support multiple of those buses (selectable through a
> > config strap) or the same chip is available in multiple SKUs, each with
> > a different bus interface.
> >
> > The devicetree bindings for these TPMs have not been converted to DT
> > schema yet and are spread out across 3 generic files and 3 chip-specific
> > files.  A few TPM compatible strings were added to trivial-devices.yaml
> > even though additional properties are documented in the plaintext
> > bindings.
> >
> > Consolidate the devicetree bindings into 3 files, one per bus.
[...]
> > Changes v1 -> v2:
> >   * Drop google,cr50 SPI example (Rob).
> 
> That's going to avoid a warning in the examples, but it's going to
> fail any actual google,c50 SPI user. What's going to happen is both
> the SPI and I2C TPM schemas will be applied. Any SPI based cases will
> fail if they have SPI properties because the I2C schema won't allow
> them. If there is no fallback for google,cr50, then you must do a
> separate schema doc (well, you could do an if/then schema in
> tcg,tpm-tis-i2c.yaml to reference spi-peripheral-props.yaml, but that
> would look kind of odd).

I'm wondering if a "select:" property in the schema would be a viable
(and acceptable) way to solve this.

Ideally the validator would match a regex against the $nodename of the
parent and see if it contains "spi" or "i2c".  But I think matching
against the parent's $nodename isn't possible, is it?  I can only
match the TPM's $nodename, right?

All the devicetree nodes in arch/arm64/boot/dts/* containing a
google,cr50 compatible string have an spi-max-frequency property if
they're attached to SPI.  So I think it may be possible to select the
i2c or spi schema based on presence of that property if the compatible
string is google,cr50.  A bit kludgy perhaps but if there's no better
option?

What I don't like about creating a custom schema for google,cr50 is that
there may be other chips in the future which support multiple buses,
so we'd need an spi+i2c schema and probably also an spi+i2c+mmio,
i2c+mmio, spi+mmio schema.  It gets messy.  Granted we could enforce
that these newly added chips use a fallback compatible that we could
select the schema with.  Still, automatically selecting the right
schema would be better, in particular if I could somehow match against
the $nodename of the parent.

Thoughts?

Thanks,

Lukas

