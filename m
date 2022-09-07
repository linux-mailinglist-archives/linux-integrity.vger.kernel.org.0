Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105AD5AFD7F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiIGH3G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGH3F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:29:05 -0400
X-Greylist: delayed 87389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 00:29:04 PDT
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA9D255BD;
        Wed,  7 Sep 2022 00:29:04 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3F84B1272;
        Wed,  7 Sep 2022 09:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662535742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XdYANHumvJoHiUgwc3LkZN9xfkFB4kHk29XFWva6fE=;
        b=zGJyhVPnJouK84ClD1oot7n9AeY0TVJ0kr3AObUz+r/GGIfjl9q7tQnr4h6OOMPGfwP03c
        jvA5iIrxzPU0iL5FxZve6/k7sJ1f+yko1FdSInTx+sHqXEU2LnlTITCjsXLx/cMq8NCHT3
        F0TT3gOK9fnruhDPGa3Dsk/cCXA4Cuw43C4Wc7y5zYQwq0MK/z9CloO06j7er2u6sGvGeA
        gUNd+vwujpgvH05bEVWQI8jgaBVd1viDZ5aEdUiDVUJK417YgCapxdBPU7OOImc/CYFHWj
        q4ddqGntYWcm6PeU9tsQuZduV8WpUlxl0wFVvUBV2m6JGgAQwlr3DlheTbO8pw==
MIME-Version: 1.0
Date:   Wed, 07 Sep 2022 09:29:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, a.fatoum@pengutronix.de
Cc:     jarkko@kernel.org, Jason@zx2c4.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dhowells@redhat.com, sumit.garg@linaro.org,
        david@sigma-star.at, john.ernberg@actia.se, jmorris@namei.org,
        serge@hallyn.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
In-Reply-To: <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <047746e1134d5bdce699d8c021f849b6@walle.cc>
 <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5d67b4d45aa1b2a3d2738c93edaeffdd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 2022-09-07 09:22, schrieb Pankaj Gupta:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Tuesday, September 6, 2022 12:43 PM
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>
>> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
>> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
>> sumit.garg@linaro.org; david@sigma-star.at; john.ernberg@actia.se;
>> jmorris@namei.org; serge@hallyn.com; herbert@gondor.apana.org.au;
>> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
>> richard@nod.at; keyrings@vger.kernel.org; 
>> linux-crypto@vger.kernel.org;
>> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> security-module@vger.kernel.org; Sahil Malhotra
>> <sahil.malhotra@nxp.com>; Kshitiz Varshney <kshitiz.varshney@nxp.com>;
>> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
>> Subject: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
>> 
>> Caution: EXT Email
>> 
>> Hi,
>> 
>> Am 2022-09-06 08:51, schrieb Pankaj Gupta:
>> > Hardware Bound key(HBK), is never acessible as plain key outside of
>> > the hardware boundary. Thus, it is un-usable, even if somehow fetched
>> > from kernel memory. It ensures run-time security.
>> >
>> > This patchset adds generic support for classing the Hardware Bound
>> > Key, based on:
>> >
>> > - Newly added flag-'is_hbk', added to the tfm.
>> >
>> >   Consumer of the kernel crypto api, after allocating
>> >   the transformation, sets this flag based on the basis
>> >   of the type of key consumer has.
>> >
>> > - This helps to influence the core processing logic
>> >   for the encapsulated algorithm.
>> >
>> > - This flag is set by the consumer after allocating
>> >   the tfm and before calling the function crypto_xxx_setkey().
>> >
>> > First implementation is based on CAAM.
>> >
>> > NXP built CAAM IP is the Cryptographic Acceleration and Assurance
>> > Module.
>> > This is contain by the i.MX and QorIQ SoCs by NXP.
>> >
>> > CAAM is a suitable backend (source) for kernel trusted keys.
>> > This backend source can be used for run-time security as well by
>> > generating the hardware bound key.
>> >
>> > Along with plain key, the CAAM generates black key. A black key is an
>> > encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
>> > black key can only be used by CAAM. Thus it is declared as a hardware
>> > bound key.
>> 
>> What is the difference to the current trusted keys with CAAM?
>> When I tested the patch series back then, I wasn't able to import a 
>> sealed
>> key on another board with the same SoC.
>> 
> 
> Currently, keys that are part of trusted key-ring, contains plain key.
> 
> With this patch-set, these key will become Hw Bound Key, which is not
> a plain key anymore.
> After this patch-set, if somehow the HB-key is retrieved from the
> keyring, the retrieved key  would be un-usable without hw.

This doesn't answer my question why I couldn't import one key on
another board with the same SoC.

Ahmad (as you were the author of the original series), is this supposed
to work or is the seal export already encrypted with the per SoC key?

-michael
