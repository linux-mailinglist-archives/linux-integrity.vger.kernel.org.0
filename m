Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5C51EA5E
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387536AbiEGVeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 17:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiEGVeM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 17:34:12 -0400
Received: from mail.actia.se (212-181-117-226.customer.telia.com [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB4BC32;
        Sat,  7 May 2022 14:30:19 -0700 (PDT)
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 23:30:16 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%10]) with mapi id
 15.01.2375.024; Sat, 7 May 2022 23:30:16 +0200
From:   John Ernberg <john.ernberg@actia.se>
To:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>
CC:     "andreas@rammhold.de" <andreas@rammhold.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "franck.lenormand@nxp.com" <franck.lenormand@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        John Ernberg <john.ernberg@actia.se>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "s.trumtrar@pengutronix.de" <s.trumtrar@pengutronix.de>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: Re: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Topic: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Index: AQHYYJCRaP1BJI53pkGuwIjy0ObIW60QaeKAgANmr4A=
Date:   Sat, 7 May 2022 21:30:16 +0000
Message-ID: <20220507213003.3373206-1-john.ernberg@actia.se>
References: <09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de>
In-Reply-To: <09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-originating-ip: [10.12.12.58]
x-esetresult: clean, is OK
x-esetid: 37303A293105C852617465
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

> > 
> > dmesg snips:
> > [    1.296772] trusted_key: Job Ring Device allocation for transform failed
> > ...
> > [    1.799768] caam 31400000.crypto: device ID = 0x0a16040000000100 (Era 9)
> > [    1.807142] caam 31400000.crypto: job rings = 2, qi = 0
> > [    1.822667] caam algorithms registered in /proc/crypto
> > [    1.830541] caam 31400000.crypto: caam pkc algorithms registered in /proc/crypto
> > [    1.841807] caam 31400000.crypto: registering rng-caam
> > 
> > I didn't quite have the time to get a better trace than that.
> 
> I don't see a crypto@31400000 node upstream. Where can I see your device tree?

Apologies for forgetting to mention that, I took it from the NXP tree
while removing the SM and SECO bits [1].
I also had to rebase some of their patches onto 5.17 for the CAAM to
probe, as the SCU makes some register pages unavailable.

> Initcall ordering does the right thing, but if CAAM device probe is deferred beyond
> late_initcall, then it won't help.
> 
> This is a general limitation with trusted keys at the moment. Anything that's
> not there by the time of the late_initcall won't be tried again. You can work
> around it by having trusted keys as a module. We might be able to do something
> with fw_devlinks in the future and a look into your device tree would help here,
> but I think that should be separate from this patch series.

Thank for you the explanation, it makes sense, and I agree that such work
would be a different patch set.

> 
> Please let me know if the module build improves the situation for you.
> 

After I changed trusted keys to a module I got it working. Which is good
enough for me as QXP CAAM support is not upstream yet.

Feel free to add my tested by if you need to make another spin.
Tested-by: John Ernberg <john.ernberg@actia.se> # iMX8QXP

I didn't test v9 as I would have to patch around the new patch due to
the SCU.

Best regards // John Ernberg

[1]: https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8-ss-security.dtsi?h=lf-5.10.y
