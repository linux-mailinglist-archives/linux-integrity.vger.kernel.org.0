Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305194D8831
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Mar 2022 16:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiCNPfc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Mar 2022 11:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiCNPfa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Mar 2022 11:35:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731720196
        for <linux-integrity@vger.kernel.org>; Mon, 14 Mar 2022 08:34:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nTmhd-0006ou-Cw; Mon, 14 Mar 2022 16:33:45 +0100
Message-ID: <7f1e4cbd-2d02-2345-493b-68ded3357f26@pengutronix.de>
Date:   Mon, 14 Mar 2022 16:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface
 for blob generator
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Gstir <david@sigma-star.at>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-5-a.fatoum@pengutronix.de> <YhZVmBy3/nWbqf+/@iki.fi>
 <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
 <DU2PR04MB863084B70239A69E4DE9D65B953E9@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB863084B70239A69E4DE9D65B953E9@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Pankaj,

On 25.02.22 13:20, Pankaj Gupta wrote:
>>>> +static u32 *caam_blob_alloc_desc(size_t keymod_len) {
>>>> +    size_t len;
>>>> +
>>>> +    /* header + (key mod immediate) + 2x pointers + op */
>>>> +    len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 +
>>>> + CAAM_PTR_SZ_MAX) + 4;
>>>
>>> Nit: the amount of magic numbers is overwhelming here. I neither
>>> understand the statement nor how that comment should help me to
>> understand it.
>>
>> header              =  4
>> (key mod immediate) = (4 + ALIGN(keymod_len, 4))
>> 2x pointer          =  2 * (4 + 4 + CAAM_PTR_SZ_MAX)
>> op                  =  4
> 
> Instead of the function caam_blob_alloc_desc(), it will be great if the caller functions caam_encap_blob()/caam_encap_blob (), could add local array:
> uint32_t desc[CAAM_DESC_BYTES_MAX];

I just looked into this and placing desc on stack is not possible
as it is used for DMA inside caam_jr_enqueue().

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
