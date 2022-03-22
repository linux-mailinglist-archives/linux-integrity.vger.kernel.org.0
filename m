Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B14E39AC
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiCVHfo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiCVHf1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 03:35:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD2B85D
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 00:33:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nWZ1M-0007uz-8w; Tue, 22 Mar 2022 08:33:36 +0100
Message-ID: <c946cce8-674a-43d2-1000-b57eba4bc45c@pengutronix.de>
Date:   Tue, 22 Mar 2022 08:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/4] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-5-a.fatoum@pengutronix.de> <YjeWSx84ev7u/YAi@iki.fi>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <YjeWSx84ev7u/YAi@iki.fi>
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

Hello Jarkko,

On 20.03.22 22:02, Jarkko Sakkinen wrote:
> On Wed, Mar 16, 2022 at 05:43:35PM +0100, Ahmad Fatoum wrote:
>> @@ -192,6 +217,19 @@ Usage::
>>  specific to TEE device implementation.  The key length for new keys is always
>>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>>  
>> +Trusted Keys usage: CAAM
>> +------------------------
>> +
>> +Usage::
>> +
>> +    keyctl add trusted name "new keylen" ring
>> +    keyctl add trusted name "load hex_blob" ring
>> +    keyctl print keyid
>> +
>> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
>> +specific to CAAM device implementation.  The key length for new keys is always
>> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>> +
>>  Encrypted Keys usage
>>  --------------------
>>  
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 05fd080b82f3..f13382a14967 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10647,6 +10647,15 @@ S:	Supported
>>  F:	include/keys/trusted_tee.h
>>  F:	security/keys/trusted-keys/trusted_tee.c
>>  
>> +KEYS-TRUSTED-CAAM
>> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
>> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>> +L:	linux-integrity@vger.kernel.org
>> +L:	keyrings@vger.kernel.org
>> +S:	Maintained
>> +F:	include/keys/trusted_caam.h
>> +F:	security/keys/trusted-keys/trusted_caam.c
>> +
>>  KEYS/KEYRINGS
>>  M:	David Howells <dhowells@redhat.com>
>>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> 
> Documentation and MAINTAINERS updates must be separate patches.

I will do so for v7. Does this patch look otherwise ok to you?

Thanks,
Ahmad

> 
> BR, Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
