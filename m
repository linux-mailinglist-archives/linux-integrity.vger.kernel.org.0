Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0836F3CD0C5
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhGSIrW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhGSIrF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 04:47:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B9C061767
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 01:29:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m5PHJ-0006Ck-GR; Mon, 19 Jul 2021 11:09:33 +0200
Subject: Re: [PATCH v2 1/6] KEYS: trusted: allow use of TEE as backend without
 TCG_TPM support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Andreas Rammhold <andreas@rammhold.de>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
 <f8285eb0135ba30c9d846cf9dd395d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de>
 <CAFA6WYMJp5u_+3bNc0ykFzveakOS4nqJfPvSoaFGQApFctL47A@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <6003f9a3-1588-c317-4eeb-889d8e6c40e3@pengutronix.de>
Date:   Mon, 19 Jul 2021 11:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFA6WYMJp5u_+3bNc0ykFzveakOS4nqJfPvSoaFGQApFctL47A@mail.gmail.com>
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

Hello Sumit,

On 19.07.21 10:04, Sumit Garg wrote:
> Hi Ahmad,
> 
> On Tue, 22 Jun 2021 at 18:08, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> With recent rework, trusted keys are no longer limited to TPM as trust
>> source. The Kconfig symbol is unchanged however leading to a few issues:
>>
>>  - TCG_TPM is required, even if only TEE is to be used
>>  - Enabling TCG_TPM, but excluding it from available trusted sources
>>    is not possible
>>  - TEE=m && TRUSTED_KEYS=y will lead to TEE support being silently
>>    dropped, which is not the best user experience
>>
>> Remedy these issues by introducing two new Kconfig symbols:
>> TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
>> dependencies.
>>
> 
> This should include a fixes tag to the rework commit.

Yes. I wasn't aware of the regression that Andreas (CC'd) recently
reported. Knowing, it now indeed warrants a backport. Will add in v2.

>> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
>> index 64b81abd087e..6fdb953b319f 100644
>> --- a/security/keys/Kconfig
>> +++ b/security/keys/Kconfig
>> @@ -70,23 +70,23 @@ config BIG_KEYS
>>
>>  config TRUSTED_KEYS
>>         tristate "TRUSTED KEYS"
>> -       depends on KEYS && TCG_TPM
>> +       depends on KEYS
> 
>>         select CRYPTO
>>         select CRYPTO_HMAC
>>         select CRYPTO_SHA1
>>         select CRYPTO_HASH_INFO
> 
> Should move these as well to TRUSTED_KEYS_TPM as the core code doesn't
> mandate their need.

Ok, will test and change appropriately.

> 
>> -       select ASN1_ENCODER
>> -       select OID_REGISTRY
>> -       select ASN1

>>  $(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
>> -trusted-y += trusted_tpm2.o
>> -trusted-y += tpm2key.asn1.o
>> +trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
>> +trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
>> +
>> +trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
>>
>>  trusted-$(CONFIG_TEE) += trusted_tee.o
> 
> This should be dropped.

Right..

Thanks for the review. I'll isolate this patch for v2.

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
