Return-Path: <linux-integrity+bounces-529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21293817935
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9F6287F0A
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1387144B;
	Mon, 18 Dec 2023 17:51:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7972061;
	Mon, 18 Dec 2023 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 257F330016C04;
	Mon, 18 Dec 2023 18:51:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EEB731FC00; Mon, 18 Dec 2023 18:51:37 +0100 (CET)
Date: Mon, 18 Dec 2023 18:51:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
Message-ID: <20231218175137.GA12115@wunner.de>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
 <20231122112949.GA18812@wunner.de>
 <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
 <20231123085943.GA15463@wunner.de>
 <ZYCCiMzTQWztcFk9@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYCCiMzTQWztcFk9@francesco-nb.int.toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Francesco,

On Mon, Dec 18, 2023 at 06:34:00PM +0100, Francesco Dolcini wrote:
> On Thu, Nov 23, 2023 at 09:59:43AM +0100, Lukas Wunner wrote:
> > On Wed, Nov 22, 2023 at 04:15:18PM +0100, Francesco Dolcini wrote:
> > > On Wed, Nov 22, 2023 at 12:29:49PM +0100, Lukas Wunner wrote:
> > > > On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
> > > > > Not to mention that I was able to see the driver probe succeed in a
> > > > > similar setup to the one you are describing in the commit message
> > > > > (different board, arm64, but nothing done by the platform firmware).
> > > > 
> > > > Hm, is the RST# pin even connected on that board?
> > > 
> > > Yes, it's connected and it is asserted/de-asserted (aka toggled) during
> > > startup from the HW reset circuit. However this is not implementing the
> > > reset sequence you are implementing here.
> > 
> > Section 4.5 of the datasheet seems to indicate that unless the sequence
> > in Figure 3 is observed, the TPM may enter a defense mode against
> > dictionary attacks "from which a recovery is very complex or even not
> > possible."
> > 
> > Simply toggling the RST# pin might therefore not be sufficient to ensure
> > the TPM is operable.
> 
> I am trying to follow-up with infineon on this regard, do you already
> have any insight from them maybe?
> 
> Maybe this procedure is relevant only when the device is in "security
> defense state"?

Sorry, I honestly don't know.  A colleague has talked to an FAE at an
Infineon reseller but they couldn't give a definitive answer either.
I'm very interested to hear whatever you learn from Infineon.

Thanks,

Lukas

