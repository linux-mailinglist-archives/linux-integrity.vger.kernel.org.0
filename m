Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1751C39C
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381184AbiEEPRL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381199AbiEEPRJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 11:17:09 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 08:13:28 PDT
Received: from mail.actia.se (212-181-117-226.customer.telia.com [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90A5C35C;
        Thu,  5 May 2022 08:13:27 -0700 (PDT)
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 16:58:24 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%10]) with mapi id
 15.01.2375.024; Thu, 5 May 2022 16:58:24 +0200
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
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Topic: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Index: AQHYYJCRaP1BJI53pkGuwIjy0ObIWw==
Date:   Thu, 5 May 2022 14:58:23 +0000
Message-ID: <20220505145756.2492566-1-john.ernberg@actia.se>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
In-Reply-To: <20220428140145.870527-1-a.fatoum@pengutronix.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-originating-ip: [10.12.12.58]
x-esetresult: clean, is OK
x-esetid: 37303A293105C852667D6B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Gave this a go on iMX8QXP with Linux 5.17.5 and I can't quite get it working.

I get -ENODEV from add_key() via keyctl. When I traced it in dmesg I couldn't
get an as clear picture as I would like but CAAM (and thus possibly JRs?)
initialzing after trusted_key.

dmesg snips:
[    1.296772] trusted_key: Job Ring Device allocation for transform failed
...
[    1.799768] caam 31400000.crypto: device ID = 0x0a16040000000100 (Era 9)
[    1.807142] caam 31400000.crypto: job rings = 2, qi = 0
[    1.822667] caam algorithms registered in /proc/crypto
[    1.830541] caam 31400000.crypto: caam pkc algorithms registered in /proc/crypto
[    1.841807] caam 31400000.crypto: registering rng-caam

I didn't quite have the time to get a better trace than that.

Best regards // John Ernberg
