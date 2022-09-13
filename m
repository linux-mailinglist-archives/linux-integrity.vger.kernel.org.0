Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8B5B6BA0
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIMK3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIMK33 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 06:29:29 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7525C960;
        Tue, 13 Sep 2022 03:29:25 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oY39f-004Bph-Lc; Tue, 13 Sep 2022 20:28:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 Sep 2022 18:28:35 +0800
Date:   Tue, 13 Sep 2022 18:28:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Varun Sethi <V.Sethi@nxp.com>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added
 to the tfm
Message-ID: <YyBbU9sNC88EXFJs@gondor.apana.org.au>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
 <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
 <DU2PR04MB86308DB7CFBC7A31CEB612D295419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhuC3QlurfSgdXG@gondor.apana.org.au>
 <AM9PR04MB8211C7D59379D4C9F877D20EE8449@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <Yx/lc1YjWm9+df1r@gondor.apana.org.au>
 <AM9PR04MB82112828E21FDA2043073216E8479@AM9PR04MB8211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB82112828E21FDA2043073216E8479@AM9PR04MB8211.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 13, 2022 at 10:01:13AM +0000, Varun Sethi wrote:
>
> [Varun] The proposed patchset makes things more scalable. With the hardware backed key flag, there's no need for the security co-processor driver to register separate set of algorithms. This makes things simpler and more scalable for the consumers (OpenSSL, AF_ALG, KTLS etc), as they can continue to use standard set of algorithms and leave the key specific complexity to the driver.

Users already need to specify which driver they are going to use in
order to actually access the hardware keys instead of getting a software
implementation of the same algorithm.

So I don't see what extra burdens are placed on them by the current
regime.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
