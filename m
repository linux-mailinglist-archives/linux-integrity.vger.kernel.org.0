Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2630522F44
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiEKJVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbiEKJVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 05:21:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6903B3FB
        for <linux-integrity@vger.kernel.org>; Wed, 11 May 2022 02:21:46 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1noiWz-0001tq-95; Wed, 11 May 2022 11:21:17 +0200
Message-ID: <fd7a6a34-4064-19f0-2d4d-d867a371422a@pengutronix.de>
Date:   Wed, 11 May 2022 11:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630501008F661C596C0106295C69@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5e7c0b3c9bc285f1cf9f7b20f055aa376e1688cc.camel@pengutronix.de>
 <DU2PR04MB8630A6F925454E5C007FA3EA95C89@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB8630A6F925454E5C007FA3EA95C89@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Pankaj,

On 11.05.22 11:16, Pankaj Gupta wrote:
>> -----Original Message-----
>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>> +       if (ctrlpriv->era < 10) {
>>>>                 rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
>>>>                            CHA_ID_LS_RNG_MASK) >>
>>>> CHA_ID_LS_RNG_SHIFT;
>>>
>>> Check for AES CHAs for Era < 10, should be added.
>>
>> Do I need this? I only do this check for Era >= 10, because apparently there are
>> Layerscape non-E processors that indicate BLOB support via CTPR_LS_BLOB, but
>> fail at runtime. Are there any Era < 10 SoCs that are similarly broken?
>>
> 
> For non-E variants, it might happen that Blob protocol is enabled, but number of AES CHA are zero.

Do you know any SoC where this is the case?
(i.e. era < 10 && CTPR_LS_BLOB && AES_CHA == 0) 

> If the output of below expression is > 0, then only blob_present should be marked present or true.
> For era > 10, you handled. But for era < 10, please add the below code.
> 	
> (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
>                            CHA_ID_LS_AES_MASK) >> CHA_ID_LS_AES_SHIFT;

Sorry, I am not fond of adding quirk handling for Hardware that might
not even exist.

Cheers,
Ahmad

> 
>> Cheers,
>> Ahmad
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
