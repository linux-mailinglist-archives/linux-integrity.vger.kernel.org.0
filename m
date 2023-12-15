Return-Path: <linux-integrity+bounces-501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78F814BAE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Dec 2023 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFC62819C5
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Dec 2023 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C9364BE;
	Fri, 15 Dec 2023 15:24:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A763A8C9;
	Fri, 15 Dec 2023 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3212C2801371D;
	Fri, 15 Dec 2023 16:24:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 038C43F34A; Fri, 15 Dec 2023 16:24:11 +0100 (CET)
Date: Fri, 15 Dec 2023 16:24:11 +0100
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
Message-ID: <20231215152411.GA20902@wunner.de>
References: <cover.1701093036.git.lukas@wunner.de>
 <3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de>
 <CAL_JsqKwJsaJhoi07gG76TgDtrwh0i=iGtxL-_pbQbGDZ_8C3A@mail.gmail.com>
 <20231213162319.GA31314@wunner.de>
 <CAL_JsqJ=14b19yHZ=rnVd8uLu=kn5W9y0irk0XA983Eo+ByBnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ=14b19yHZ=rnVd8uLu=kn5W9y0irk0XA983Eo+ByBnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 13, 2023 at 11:01:21AM -0600, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 10:23AM Lukas Wunner <lukas@wunner.de> wrote:
> > Ideally the validator would match a regex against the $nodename of the
> > parent and see if it contains "spi" or "i2c".  But I think matching
> > against the parent's $nodename isn't possible, is it?
> 
> No. I've thought of adding something like that, but haven't.

Please consider this a feature request. :)

It would be good if it were possible to define constraints not just
for the $nodename of the parent, but any of its properties.

E.g. with i2c, the clock-frequency is set at the host controller's
devicetree node, not at each attached i2c peripheral's node.
For ACPI, i2c_acpi_find_bus_speed() walks the bus to find the
highest clock speed supported by all attached i2c peripherals,
but for OF, the onus is on the devicetree author to manually
determine the clock.

Thus, for a TPM such as infineon,slb9635tt which only supports 100 kHz,
I want to validate that the parent node's clock-frequency is less than
or equal to that.

In Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
there's an example showing a clock-frequency property at the
peripheral's node and I mistakenly carried that over to the yaml
schema.  A look at the code reveals that's entirely bogus so I'll
drop the clock-frequency property in v3.  I will retain textual
hints that infineon,slb9635tt is limited to 100 kHz and
infineon,slb9645tt to 400 kHz, but as it stands I can't define
rules that would allow the validator to check that automatically.

Thanks,

Lukas

