Return-Path: <linux-integrity+bounces-201-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC97F5AB0
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Nov 2023 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA245281670
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Nov 2023 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5A1C6B6;
	Thu, 23 Nov 2023 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E059109;
	Thu, 23 Nov 2023 00:59:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C9D223000242C;
	Thu, 23 Nov 2023 09:59:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BB6373D6A3; Thu, 23 Nov 2023 09:59:43 +0100 (CET)
Date: Thu, 23 Nov 2023 09:59:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
Message-ID: <20231123085943.GA15463@wunner.de>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
 <20231122112949.GA18812@wunner.de>
 <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 22, 2023 at 04:15:18PM +0100, Francesco Dolcini wrote:
> On Wed, Nov 22, 2023 at 12:29:49PM +0100, Lukas Wunner wrote:
> > On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
> > > Not to mention that I was able to see the driver probe succeed in a
> > > similar setup to the one you are describing in the commit message
> > > (different board, arm64, but nothing done by the platform firmware).
> > 
> > Hm, is the RST# pin even connected on that board?
> 
> Yes, it's connected and it is asserted/de-asserted (aka toggled) during
> startup from the HW reset circuit. However this is not implementing the
> reset sequence you are implementing here.

Section 4.5 of the datasheet seems to indicate that unless the sequence
in Figure 3 is observed, the TPM may enter a defense mode against
dictionary attacks "from which a recovery is very complex or even not
possible."

Simply toggling the RST# pin might therefore not be sufficient to ensure
the TPM is operable.

Here's the relevant section in the datasheet:

   "The OPTIGA TPM SLB 9670 features a sophisticated protection mechanism
    against dictionary attacks on TPM-based authorization data. Basically,
    the device counts the number of failed authorization attempts in a
    counter which is located in the non-volatile memory. An attacker who
    has physical access to the device could try to cirumvent that mechanism
    by resetting the device after the authorization attempt but before the
    updated failure counter has been written into the NVM.

    Certain countermeasures have been added to the OPTIGA TPM SLB 9670.
    In certain time windows during power-on or warm boot of the device,
    such reset events might influence the dictionary attack counters and
    trigger other security mechanisms as well. In worst case, this might
    trigger special security defense modes from which a recovery is very
    complex or even not possible.

    To avoid that the OPTIGA TPM SLB 9670 reaches such a security defense
    state, the RST# signal must not be asserted in certain time windows.
    After the deassertion of the RST# signal, the system should wait for
    a minimum time of tRSTIN before asserting RST# again (see Figure 3
    and Table 11).

    TPM commands should only be started after tRSTIN has expired (see
    Figure 3 again). If a TPM command is running, RST# should not be
    asserted; otherwise, this might also trigger some security functions.
    When the TPM shall be reset, the command TPM2_Shutdown should be
    issued before the assertion of the RST# signal.

    https://www.infineon.com/dgdl/?fileId=5546d4626fc1ce0b016fc78270350cd6

Thanks,

Lukas

