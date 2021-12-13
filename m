Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A81472A6E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbhLMKla (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 05:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbhLMKlS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 05:41:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038CC024A2F
        for <linux-integrity@vger.kernel.org>; Mon, 13 Dec 2021 02:34:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mwifJ-0007XV-Ac; Mon, 13 Dec 2021 11:34:41 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v4 4/5] crypto: caam - add in-kernel interface for blob
 generator
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <3ea6e5c37559eddfdc51f26c4dff0abbbc894839.1633946449.git-series.a.fatoum@pengutronix.de>
 <YawFYFV8xGIPZvUJ@iki.fi>
Message-ID: <3e33a215-12d2-da30-d1e1-2fde753a7a0a@pengutronix.de>
Date:   Mon, 13 Dec 2021 11:34:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YawFYFV8xGIPZvUJ@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jarkko,

On 05.12.21 01:18, Jarkko Sakkinen wrote:
> On Mon, Oct 11, 2021 at 12:02:37PM +0200, Ahmad Fatoum wrote:
>> The CAAM can be used to protect user-defined data across system reboot:
>>
>>   - When the system is fused and boots into secure state, the master
>>     key is a unique never-disclosed device-specific key
>>   - random key is encrypted by key derived from master key
>>   - data is encrypted using the random key
>>   - encrypted data and its encrypted random key are stored alongside
>>   - This blob can now be safely stored in non-volatile memory
>>
>> On next power-on:
>>   - blob is loaded into CAAM
>>   - CAAM writes decrypted data either into memory or key register
>>
>> Add functions to realize encrypting and decrypting into memory alongside
>> the CAAM driver.
>>
>> They will be used in a later commit as a source for the trusted key
>> seal/unseal mechanism.
>>
>> Reviewed-by: David Gstir <david@sigma-star.at>
>> Tested-By: Tim Harvey <tharvey@gateworks.com>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> What is CAAM? This is missing.

That's Crypto Accelerator on NXP SoCs. There is a description in the cover
letter and in the follow-up patch wiring this into the new trusted key
source. I didn't elaborate on this here as this patch touches
drivers/crypto/caam and I assumed familiarity.

For v5, I can add some extra info:

"The NXP Cryptographic Acceleration and Assurance Module (CAAM)
 can be used to protect user-defined data across system reboot..."

Sounds good? Does the last patch in the series look ok to you?

Cheers,
Ahmad

> 
> /Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
