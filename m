Return-Path: <linux-integrity+bounces-176-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325D7F3A4D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C101C20C66
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9BF5647D;
	Tue, 21 Nov 2023 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CF98;
	Tue, 21 Nov 2023 15:34:07 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BA818201F1;
	Wed, 22 Nov 2023 00:34:04 +0100 (CET)
Date: Wed, 22 Nov 2023 00:33:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Lukas Wunner <lukas@wunner.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
Message-ID: <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>

Hello Lino, hello Lukas,

On Tue, Sep 26, 2023 at 09:09:36PM +0200, Lukas Wunner wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Normally the platform firmware is responsible for taking a Trusted
> Platform Module out of reset on boot and storing measurements into it.
> 
> However if the platform firmware is incapable of doing that -- as is the
> case on the Raspberry Pi -- then the onus is on the kernel to take the
> TPM out of reset before trying to attach a driver to it.
> 
> Provide a reset driver for such platforms.
> 
> The Infineon SLB9670 TPM requires a specific reset sequence on its RST#
> pin which is documented in sections 5.4 and 5.5 of the datasheet:
> 
> https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6
> 
> The sequence with minimum wait intervals is as follows:
> 
>   deassert RST#
>   wait at least 60 ms
>   assert RST#
>   wait at least 2 usecs
>   deassert RST#
>   wait at least 60 ms
>   assert RST#
>   wait at least 2 usecs
>   deassert RST#
>   wait at least 60 ms before issuing the first TPM command

Are you really sure that this change is required?
I have seen the RST# Timing diagram in the datasheet, however I wonder
if a reset is required at all during power-up, for example.

Not to mention that I would have expected some firmware to implement
such reset timing and I was not able to find any (I looked at
arm/arm64), if this is really required I the driver can work at all?
Which platform firmware implements such reset sequence?

Not to mention that I was able to see the driver probe succeed in a
similar setup to the one you are describing in the commit message
(different board, arm64, but nothing done by the platform firmware).

What am I missing?

Thanks,
Francesco


