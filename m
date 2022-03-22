Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F44E39AD
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiCVHe4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiCVHey (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 03:34:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01211F620
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 00:33:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nWZ0U-0007ql-Hp; Tue, 22 Mar 2022 08:32:42 +0100
Message-ID: <23cd140f-1046-7059-c9bd-ca4aac1d5183@pengutronix.de>
Date:   Tue, 22 Mar 2022 08:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-4-a.fatoum@pengutronix.de>
 <DU2PR04MB86302DB35042F4DAE7C27FA695179@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB86302DB35042F4DAE7C27FA695179@DU2PR04MB8630.eurprd04.prod.outlook.com>
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

On 22.03.22 07:25, Pankaj Gupta wrote:
> Hi Ahmad,
> 
> Suggested to define macro with more details.
> Please find comments in-line.
> 

> len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 + 
>>>>> + CAAM_PTR_SZ_MAX) + 4;
> 
>> +/* header + (key mod immediate) + 2x seq_intlen pointers + op */
>> +#define CAAM_BLOB_DESC_BYTES_MAX \
>> +       (CAAM_CMD_SZ + \
>> +        CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH + \
>> +        2 * (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \
>> +        CAAM_CMD_SZ)
>> +
> 
> Suggested to replace the above macro like below:
> 
> +#define CAAM_BLOB_DESC_BYTES_MAX \			
> +       (CAAM_CMD_SZ + \					/* Command to initialize & stating length of  descriptor */
> +        CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH + \	/* Command to append the key-modifier + followed by the key-modifier data */
> +        (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \		/* Command to include input plain key and pointer to the input key */
> +        (CAAM_CMD_SZ + CAAM_PTR_SZ_MAX) + \		/* Command to include output-key blob and pointer to the output-key blob */
> +        CAAM_CMD_SZ)						/* Command describing the Operation to perform */


Sure thing, will do for v7. Otherwise, if all looks good to you,
can I have your Reviewed-by?

Thanks,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
