Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F99D4E3BCE
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 10:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiCVJi6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiCVJi5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 05:38:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A777EA0B
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 02:37:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nWawt-0006Jj-Mp; Tue, 22 Mar 2022 10:37:07 +0100
Message-ID: <828a8d00-ab9a-a7eb-4ad0-f95a63c7fb39@pengutronix.de>
Date:   Tue, 22 Mar 2022 10:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Content-Language: en-US
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
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
 <DU2PR04MB86302DB35042F4DAE7C27FA695179@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <23cd140f-1046-7059-c9bd-ca4aac1d5183@pengutronix.de>
In-Reply-To: <23cd140f-1046-7059-c9bd-ca4aac1d5183@pengutronix.de>
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

On 22.03.22 08:32, Ahmad Fatoum wrote:
> Hello Pankaj,
> 
> On 22.03.22 07:25, Pankaj Gupta wrote:
>> Hi Ahmad,
>>
>> Suggested to define macro with more details.
>> Please find comments in-line.
>>
> 
>> len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 + 
>>>>>> + CAAM_PTR_SZ_MAX) + 4;
>>
>>> +/* header + (key mod immediate) + 2x seq_intlen pointers + op */
>>> +#define CAAM_BLOB_DESC_BYTES_MAX \
>>> +       (CAAM_CMD_SZ + \
>>> +        CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH + \
>>> +        2 * (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \
>>> +        CAAM_CMD_SZ)
>>> +
>>
>> Suggested to replace the above macro like below:
>>
>> +#define CAAM_BLOB_DESC_BYTES_MAX \			
>> +       (CAAM_CMD_SZ + \					/* Command to initialize & stating length of  descriptor */
>> +        CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH + \	/* Command to append the key-modifier + followed by the key-modifier data */
>> +        (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \		/* Command to include input plain key and pointer to the input key */
>> +        (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \		/* Command to include output-key blob and pointer to the output-key blob */
>> +        CAAM_CMD_SZ)						/* Command describing the Operation to perform */
> 
> 
> Sure thing, will do for v7. Otherwise, if all looks good to you,
> can I have your Reviewed-by?
This doesn't compile as-is and it leads to quite long lines.
The description isn't accurate also, because what's plain and what's blob
changes depending on whether we encapsulate or decapsulate.

Here's my revised macro version:

#define CAAM_BLOB_DESC_BYTES_MAX                                        \
        /* Command to initialize & stating length of descriptor */      \
        (CAAM_CMD_SZ +                                                  \
        /* Command to append the key-modifier + key-modifier data */    \
         CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH +                        \
        /* Command to include input key + pointer to the input key */   \
         CAAM_CMD_SZ + CAAM_PTR_SZ_MAX +                                \
        /* Command to include output key + pointer to the output key */ \
         CAAM_CMD_SZ + CAAM_PTR_SZ_MAX +                                \
        /* Command describing the Operation to perform */               \
         CAAM_CMD_SZ)

Alternatively, I can change it back into a function:

static inline u32 *caam_blob_desc_alloc(void)
{
        size_t size = 0;

        /* Command to initialize & stating length of descriptor */
        size += CAAM_CMD_SZ;
        /* Command to append the key-modifier + key-modifier data */
        size += CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH;
        /* Command to include input plain key + pointer to the input key */
        size += CAAM_CMD_SZ + CAAM_PTR_SZ_MAX;
        /* Command to include output-key blob + pointer to the output key */
        size += CAAM_CMD_SZ + CAAM_PTR_SZ_MAX;
        /* Command describing the Operation to perform */
        size += CAAM_CMD_SZ;

        return kzalloc(size, GFP_KERNEL | GFP_DMA);
}

Let me know what works better for you.

Cheers,
Ahmad

> 
> Thanks,
> Ahmad
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
