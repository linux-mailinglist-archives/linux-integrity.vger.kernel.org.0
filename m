Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C355533F207
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 14:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCQN7K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhCQN65 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 09:58:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CEBC06174A
        for <linux-integrity@vger.kernel.org>; Wed, 17 Mar 2021 06:58:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMWhH-0002lo-SS; Wed, 17 Mar 2021 14:58:51 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <YFEFZujgsMpX7VbU@kernel.org>
Message-ID: <0d0adfa1-b5c3-8fd6-82f6-2a9c4de2b3f0@pengutronix.de>
Date:   Wed, 17 Mar 2021 14:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFEFZujgsMpX7VbU@kernel.org>
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

On 16.03.21 20:22, Jarkko Sakkinen wrote:
> On Tue, Mar 16, 2021 at 06:01:18PM +0100, Ahmad Fatoum wrote:
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> The CAAM does crypto acceleration, hardware number generation and
>> has a blob mechanism for encapsulation/decapsulation of sensitive material.
>>
>> This blob mechanism depends on a device specific random 256-bit One Time
>> Programmable Master Key that is fused in each SoC at manufacturing
>> time. This key is unreadable and can only be used by the CAAM for AES
>> encryption/decryption of user data.
>>
>> This makes it a suitable backend (source) for kernel trusted keys.
>>
>> Previous commits generalized trusted keys to support multiple backends
>> and added an API to access the CAAM blob mechanism. Based on these,
>> provide the necessary glue to use the CAAM for trusted keys.
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> Too early to ack, as I've not included the TEE thing to any PR yet.

No problem. I'd be happy to incorporate the feedback I receive in the meantime.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
