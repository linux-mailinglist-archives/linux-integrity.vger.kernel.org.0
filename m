Return-Path: <linux-integrity+bounces-528-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC388178D6
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839191F23474
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED75A878;
	Mon, 18 Dec 2023 17:35:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D835498B7;
	Mon, 18 Dec 2023 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CBCD029CDA;
	Mon, 18 Dec 2023 18:35:00 +0100 (CET)
Date: Mon, 18 Dec 2023 18:34:00 +0100
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
Message-ID: <ZYCCiMzTQWztcFk9@francesco-nb.int.toradex.com>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
 <20231122112949.GA18812@wunner.de>
 <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
 <20231123085943.GA15463@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123085943.GA15463@wunner.de>

Hello Lukas,

On Thu, Nov 23, 2023 at 09:59:43AM +0100, Lukas Wunner wrote:
> On Wed, Nov 22, 2023 at 04:15:18PM +0100, Francesco Dolcini wrote:
> > On Wed, Nov 22, 2023 at 12:29:49PM +0100, Lukas Wunner wrote:
> > > On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
> > > > Not to mention that I was able to see the driver probe succeed in a
> > > > similar setup to the one you are describing in the commit message
> > > > (different board, arm64, but nothing done by the platform firmware).
> > > 
> > > Hm, is the RST# pin even connected on that board?
> > 
> > Yes, it's connected and it is asserted/de-asserted (aka toggled) during
> > startup from the HW reset circuit. However this is not implementing the
> > reset sequence you are implementing here.
> 
> Section 4.5 of the datasheet seems to indicate that unless the sequence
> in Figure 3 is observed, the TPM may enter a defense mode against
> dictionary attacks "from which a recovery is very complex or even not
> possible."
> 
> Simply toggling the RST# pin might therefore not be sufficient to ensure
> the TPM is operable.

I am trying to follow-up with infineon on this regard, do you already
have any insight from them maybe?

Maybe this procedure is relevant only when the device is in "security
defense state"?

Francesco


