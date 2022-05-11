Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9685230EF
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiEKKr0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiEKKrW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 06:47:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C54BB8E
        for <linux-integrity@vger.kernel.org>; Wed, 11 May 2022 03:47:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nojs0-0005aX-R8; Wed, 11 May 2022 12:47:04 +0200
Message-ID: <3a8c493b-b19c-4490-85b4-22d240bfd06e@pengutronix.de>
Date:   Wed, 11 May 2022 12:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 0/7] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <49e1738c55c73819ee0e2cac0be74d81@walle.cc>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <49e1738c55c73819ee0e2cac0be74d81@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Michael,

On 06.05.22 12:52, Michael Walle wrote:
> Am 2022-05-06 08:25, schrieb Ahmad Fatoum:
>> Series applies on top of v5.18-rc5. Would be great if this could make it
>> into v5.19.
>>
>> v8 was here:
>> https://lore.kernel.org/linux-integrity/09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de
>>
>> Changelog is beneath each individual patch. Compared to v8, only code
>> change is checking whether CAAM can support blobbing at init-time as
>> apparently some Layerscape SoCs are available in a non-E(ncryption)
>> variant that doesn't do AES. Previously, adding trusted keys on such
>> SoCs would return an error with a cryptic error message.
>>
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique
>> never-disclosed device-specific key.
>>
>> There has been multiple discussions on how to represent this within the kernel:
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique
>> never-disclosed device-specific key. There has been multiple
>> discussions on how to represent this within the kernel:
>>
>>  - [RFC] crypto: caam - add red blobifier
>>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>>    best integrate the blob mechanism.
>>    Mimi suggested that it could be used to implement trusted keys.
>>    Trusted keys back then were a TPM-only feature.
>>
>>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>>    Udit Agarwal added[2] a new "secure" key type with the CAAM as backend.
>>    The key material stays within the kernel only.
>>    Mimi and James agreed that this needs a generic interface, not specific
>>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>>    basis for TEE-backed keys.
>>
>>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>>    Franck added[3] a new "caam_tk" key type based on Udit's work. This time
>>    it uses CAAM "black blobs" instead of "red blobs", so key material stays
>>    within the CAAM and isn't exposed to kernel in plaintext.
>>    James voiced the opinion that there should be just one user-facing generic
>>    wrap/unwrap key type with multiple possible handlers.
>>    David suggested trusted keys.
>>
>>  - Introduce TEE based Trusted Keys support
>>    Sumit reworked[4] trusted keys to support multiple possible backends with
>>    one chosen at boot time and added a new TEE backend along with TPM.
>>    This now sits in Jarkko's master branch to be sent out for v5.13
>>
>> This patch series builds on top of Sumit's rework to have the CAAM as
>> yet another
>> trusted key backend.
>>
>> The CAAM bits are based on Steffen's initial patch from 2015. His work had been
>> used in the field for some years now, so I preferred not to deviate
>> too much from it.
>>
>> This series has been tested with dmcrypt[5] on an i.MX6Q/DL and an i.MX8M[6].
>>
>> Looking forward to your feedback.
> 
> For the whole series:
> 
> Tested-by: Michael Walle <michael@walle.cc> # on ls1028a (non-E and E)

Thanks! Did you test checkpatch.pl and make htmldocs/pdfdocs too
or should I add the Tested-by just for the first 5 patches?

Cheers,
Ahmad

> 
> -michael
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
