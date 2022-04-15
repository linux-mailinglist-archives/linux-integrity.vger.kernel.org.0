Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E23502F84
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Apr 2022 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351017AbiDOUKB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Apr 2022 16:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351119AbiDOUJ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Apr 2022 16:09:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47091DAFFF
        for <linux-integrity@vger.kernel.org>; Fri, 15 Apr 2022 13:07:22 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nfSDg-0005eL-9y; Fri, 15 Apr 2022 22:07:04 +0200
Message-ID: <7c9c093a-cfb8-c997-87f8-db769eaa2c62@pengutronix.de>
Date:   Fri, 15 Apr 2022 22:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630BDFC29AA31074C623A7B95199@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <ae941471-43c0-1aea-2567-89eed98a61a6@pengutronix.de>
 <DU2PR04MB86306DE99EA993BF596BA729951D9@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB86306DE99EA993BF596BA729951D9@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 28.03.22 11:29, Pankaj Gupta wrote:
>>> struct keyblob_info {
>>>         void *key;
>>>         size_t key_len;
>>>
>>>         void *blob;
>>>         size_t blob_len;
>>>
>>>         size_t key_mod_len;
>>>         const void *key_mod;
>>> };
>>
>> I can do that.
>>
> 
> Please do. Thanks.

I went with your other suggestion instead: void *input and void *output.
This keeps the code simple and avoids having to do:

if (encap) {
  in = info->key;
  in_len = info->key_len;
  out = info->blob_len;
  out_len = info->key_len + CAAM_BLOB_OVERHEAD; 
} else {
  in = info->blob;
  in_len = info->blob_len;
  out = info->key_len;
  out_len = info->blob_len - CAAM_BLOB_OVERHEAD; 
}

> Patch 4/4, needs to be re-worked to.
> 
>> Whats your opinion on the desc size computation? Comment the macro or
>> add the static inline helper?
>>
> 
> Comment the macro is fine.
> 
>> Cheers,
>> Ahmad
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       |
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
>> pengutronix.de%2F&amp;data=04%7C01%7Cpankaj.gupta%40nxp.com%7C4
>> d60f0d524a04b7cbd7b08da0d7e7d21%7C686ea1d3bc2b4c6fa92cd99c5c30163
>> 5%7C0%7C0%7C637837134158793951%7CUnknown%7CTWFpbGZsb3d8eyJWI
>> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> 000&amp;sdata=PetvZm8teusBwQ4BeZ1VLEOvBlCrZ2k2bNG3SJBEXPw%3D&
>> amp;reserved=0  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
