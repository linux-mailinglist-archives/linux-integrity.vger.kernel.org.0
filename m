Return-Path: <linux-integrity+bounces-183-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD27F44EE
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C01C208C9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4EB5467C;
	Wed, 22 Nov 2023 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C96110;
	Wed, 22 Nov 2023 03:29:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 78B5830000D39;
	Wed, 22 Nov 2023 12:29:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6D36237039; Wed, 22 Nov 2023 12:29:49 +0100 (CET)
Date: Wed, 22 Nov 2023 12:29:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
Message-ID: <20231122112949.GA18812@wunner.de>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
> On Tue, Sep 26, 2023 at 09:09:36PM +0200, Lukas Wunner wrote:
> > Normally the platform firmware is responsible for taking a Trusted
> > Platform Module out of reset on boot and storing measurements into it.
> > 
> > However if the platform firmware is incapable of doing that -- as is the
> > case on the Raspberry Pi -- then the onus is on the kernel to take the
> > TPM out of reset before trying to attach a driver to it.
> > 
> > Provide a reset driver for such platforms.
> > 
> > The Infineon SLB9670 TPM requires a specific reset sequence on its RST#
> > pin which is documented in sections 5.4 and 5.5 of the datasheet:
> 
> Are you really sure that this change is required?
> I have seen the RST# Timing diagram in the datasheet, however I wonder
> if a reset is required at all during power-up, for example.

If the RST# pin is not toggled at all upon a warm reset (reboot),
the TPM will remain in whatever state it was during the previous boot.

Also, the pin controller connected to RST# might be reset upon a reboot
(think of a SoC internal pin controller setting all its registers to 0)
and RST# might be asserted as a result.  It is then necessary to take
the TPM out of reset.


> Not to mention that I would have expected some firmware to implement
> such reset timing and I was not able to find any (I looked at
> arm/arm64), if this is really required I the driver can work at all?
> Which platform firmware implements such reset sequence?

I can't answer how a TPM is reset by firmware on arm/arm64, you'd have
to ask an FAE at ARM.  Normally I'd expect firmware in ROM do that so
all subsequently executed code which is mutable (EFI, bootloader, kernel)
can be measured.  Again, on simple platforms such as the Raspberry Pi
there's no support to reset a TPM in ROM.


> Not to mention that I was able to see the driver probe succeed in a
> similar setup to the one you are describing in the commit message
> (different board, arm64, but nothing done by the platform firmware).

Hm, is the RST# pin even connected on that board?

Thanks,

Lukas

