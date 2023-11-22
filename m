Return-Path: <linux-integrity+bounces-200-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6C7F4A0A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CC928100C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28E25571;
	Wed, 22 Nov 2023 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1419E;
	Wed, 22 Nov 2023 07:15:26 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 007CD20618;
	Wed, 22 Nov 2023 16:15:22 +0100 (CET)
Date: Wed, 22 Nov 2023 16:15:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Lukas Wunner <lukas@wunner.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
Message-ID: <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
 <20231122112949.GA18812@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122112949.GA18812@wunner.de>

Hello Lukas,

On Wed, Nov 22, 2023 at 12:29:49PM +0100, Lukas Wunner wrote:
> On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
> > On Tue, Sep 26, 2023 at 09:09:36PM +0200, Lukas Wunner wrote:
> > > Normally the platform firmware is responsible for taking a Trusted
> > > Platform Module out of reset on boot and storing measurements into it.
> > > 
> > > However if the platform firmware is incapable of doing that -- as is the
> > > case on the Raspberry Pi -- then the onus is on the kernel to take the
> > > TPM out of reset before trying to attach a driver to it.
> > > 
> > > Provide a reset driver for such platforms.
> > > 
> > > The Infineon SLB9670 TPM requires a specific reset sequence on its RST#
> > > pin which is documented in sections 5.4 and 5.5 of the datasheet:
> > 
> > Are you really sure that this change is required?
> > I have seen the RST# Timing diagram in the datasheet, however I wonder
> > if a reset is required at all during power-up, for example.
> 
> If the RST# pin is not toggled at all upon a warm reset (reboot),
> the TPM will remain in whatever state it was during the previous boot.
...
> Also, the pin controller connected to RST# might be reset upon a reboot
> (think of a SoC internal pin controller setting all its registers to 0)
> and RST# might be asserted as a result.  It is then necessary to take
> the TPM out of reset.

Toggled at boot is different from what you are doing here.

> > Not to mention that I was able to see the driver probe succeed in a
> > similar setup to the one you are describing in the commit message
> > (different board, arm64, but nothing done by the platform firmware).
> 
> Hm, is the RST# pin even connected on that board?

Yes, it's connected and it is asserted/de-asserted (aka toggled) during
startup from the HW reset circuit. However this is not implementing the
reset sequence you are implementing here.

Francesco


