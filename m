Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AA51358B
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Apr 2022 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbiD1Ns0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347600AbiD1NsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 09:48:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6171E63D4
        for <linux-integrity@vger.kernel.org>; Thu, 28 Apr 2022 06:45:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nk4Rd-00040Y-7B; Thu, 28 Apr 2022 15:44:33 +0200
Message-ID: <73bb42fc-5d69-0c89-d42f-226a6d13248f@pengutronix.de>
Date:   Thu, 28 Apr 2022 15:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
 <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Pankaj,

On 28.04.22 14:50, Pankaj Gupta wrote:
> Hi Ahmad,
> 
> I have tested the patch-set.
> It is working as expected even when CAAM is compiled as kernel module.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Thanks for test and review. I have applied the tags on all patches
in the series except the Tested-by for the last two. I think a Tested-by
for maintainer and doc changes looks a bit odd. ^^

I will incorporate Jarkko's documentation feedback and send a new series
shortly.

Cheers,
Ahmad

> 
> Regards
> Pankaj
> 
>> -----Original Message-----
>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Sent: Saturday, April 16, 2022 2:27 AM
>> To: Jarkko Sakkinen <jarkko@kernel.org>; Horia Geanta
>> <horia.geanta@nxp.com>; Mimi Zohar <zohar@linux.ibm.com>; Pankaj
>> Gupta <pankaj.gupta@nxp.com>; Herbert Xu
>> <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>;
>> James Bottomley <jejb@linux.ibm.com>
>> Cc: kernel@pengutronix.de; David Howells <dhowells@redhat.com>; James
>> Morris <jmorris@namei.org>; Serge E. Hallyn <serge@hallyn.com>; Steffen
>> Trumtrar <s.trumtrar@pengutronix.de>; Jan Luebbe
>> <j.luebbe@pengutronix.de>; David Gstir <david@sigma-star.at>; Eric Biggers
>> <ebiggers@kernel.org>; Richard Weinberger <richard@nod.at>; Franck
>> Lenormand <franck.lenormand@nxp.com>; Sumit Garg
>> <sumit.garg@linaro.org>; Andreas Rammhold <andreas@rammhold.de>;
>> tharvey@gateworks.com; Matthias Schiffer <matthias.schiffer@ew.tq-
>> group.com>; linux-integrity@vger.kernel.org; keyrings@vger.kernel.org;
>> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
>> module@vger.kernel.org
>> Subject: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
>> CAAM-based trusted keys
>>
>> Caution: EXT Email
>>
>> Series applies on top of v5.18-rc2
>>
>> v6 was here:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flinux-integrity%2F20220316164335.1720255-1-
>> a.fatoum%40pengutronix.de%2F&amp;data=04%7C01%7Cpankaj.gupta%40n
>> xp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd
>> 99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZ
>> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
>> n0%3D%7C3000&amp;sdata=HX0dpx79%2BRpfD0CTzd59XgcdEIOmUV0BtL3Y
>> 36Sx1AY%3D&amp;reserved=0
>>
>> Changelog is beneath each individual patch.
>>
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique never-
>> disclosed device-specific key.
>>
>> There has been multiple discussions on how to represent this within the
>> kernel:
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique never-
>> disclosed device-specific key. There has been multiple discussions on how to
>> represent this within the kernel:
>>
>>  - [RFC] crypto: caam - add red blobifier
>>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>>    best integrate the blob mechanism.
>>    Mimi suggested that it could be used to implement trusted keys.
>>    Trusted keys back then were a TPM-only feature.
>>
>>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>>    Udit Agarwal added[2] a new "secure" key type with the CAAM as backend.
>>    The key material stays within the kernel only.
>>    Mimi and James agreed that this needs a generic interface, not specific
>>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>>    basis for TEE-backed keys.
>>
>>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>>    Franck added[3] a new "caam_tk" key type based on Udit's work. This time
>>    it uses CAAM "black blobs" instead of "red blobs", so key material stays
>>    within the CAAM and isn't exposed to kernel in plaintext.
>>    James voiced the opinion that there should be just one user-facing generic
>>    wrap/unwrap key type with multiple possible handlers.
>>    David suggested trusted keys.
>>
>>  - Introduce TEE based Trusted Keys support
>>    Sumit reworked[4] trusted keys to support multiple possible backends with
>>    one chosen at boot time and added a new TEE backend along with TPM.
>>    This now sits in Jarkko's master branch to be sent out for v5.13
>>
>> This patch series builds on top of Sumit's rework to have the CAAM as yet
>> another trusted key backend.
>>
>> The CAAM bits are based on Steffen's initial patch from 2015. His work had
>> been used in the field for some years now, so I preferred not to deviate too
>> much from it.
>>
>> This series has been tested with dmcrypt[5] on an i.MX6Q/DL and an
>> i.MX8M[6].
>>
>> Looking forward to your feedback.
>>
>> Cheers,
>> Ahmad
>>
>>  [1]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flinux-crypto%2F1447082306-19946-2-git-send-email-
>> s.trumtrar%40pengutronix.de%2F&amp;data=04%7C01%7Cpankaj.gupta%40
>> nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92c
>> d99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbG
>> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn0%3D%7C3000&amp;sdata=1SsslHlyFr2xaWNsE3aa0DEdQ3r5%2BLqDI16X
>> bLBEi5M%3D&amp;reserved=0
>>  [2]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flinux-integrity%2F20180723111432.26830-1-
>> udit.agarwal%40nxp.com%2F&amp;data=04%7C01%7Cpankaj.gupta%40nxp.
>> com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd99c
>> 5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZsb3
>> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>> %3D%7C3000&amp;sdata=%2FvQXaQAJZc5aid84IWIUyfRLSUPSylOhkpoaB%2
>> FAgMgs%3D&amp;reserved=0
>>  [3]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flkml%2F1551456599-10603-2-git-send-email-
>> franck.lenormand%40nxp.com%2F&amp;data=04%7C01%7Cpankaj.gupta%4
>> 0nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92
>> cd99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>> 6Mn0%3D%7C3000&amp;sdata=%2F2fSdeN%2FG%2BObdJW9hpPrR%2B%2B
>> KoKOvtUGvijdu2rgSMCg%3D&amp;reserved=0
>>  [4]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flkml%2F1604419306-26105-1-git-send-email-
>> sumit.garg%40linaro.org%2F&amp;data=04%7C01%7Cpankaj.gupta%40nxp.c
>> om%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd99c5
>> c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZsb3d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>> 3D%7C3000&amp;sdata=YNRk2%2FYFm9mI8vEigYxoIDRcHilHR4U6uqYXSj8dJ
>> VI%3D&amp;reserved=0
>>  [5]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flinux-integrity%2F20210122084321.24012-2-
>> a.fatoum%40pengutronix.de%2F&amp;data=04%7C01%7Cpankaj.gupta%40n
>> xp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd
>> 99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZ
>> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
>> n0%3D%7C3000&amp;sdata=TlA7QBMbBGhJTyx5wHk3%2BhQUhuqBWW3W
>> tEZq94w13kY%3D&amp;reserved=0
>>  [6]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Flinux-
>> integrity%2FDU2PR04MB8630D83FE9BBC0D782C4FAF595089%40DU2PR04MB
>> 8630.eurprd04.prod.outlook.com%2F&amp;data=04%7C01%7Cpankaj.gupta
>> %40nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFp
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
>> I6Mn0%3D%7C3000&amp;sdata=jOJusQxZ%2BUfjxDKyMImc4BYjO8sFmamV
>> b5LnAo%2BknFc%3D&amp;reserved=0
>>
>> ---
>> To: Jarkko Sakkinen <jarkko@kernel.org>
>> To: "Horia Geantă" <horia.geanta@nxp.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>
>> To: Herbert Xu <herbert@gondor.apana.org.au>
>> To: "David S. Miller" <davem@davemloft.net>
>> To: James Bottomley <jejb@linux.ibm.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
>> Cc: David Gstir <david@sigma-star.at>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Andreas Rammhold <andreas@rammhold.de>
>> Cc: Tim Harvey <tharvey@gateworks.com>
>> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>> Cc: linux-integrity@vger.kernel.org
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-crypto@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>>
>> Ahmad Fatoum (6):
>>   KEYS: trusted: allow use of TEE as backend without TCG_TPM support
>>   KEYS: trusted: allow use of kernel RNG for key material
>>   crypto: caam - add in-kernel interface for blob generator
>>   KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
>>   doc: trusted-encrypted: describe new CAAM trust source
>>   MAINTAINERS: add myself as CAAM trusted key maintainer
>>
>>  .../admin-guide/kernel-parameters.txt         |  11 ++
>>  .../security/keys/trusted-encrypted.rst       |  60 ++++++-
>>  MAINTAINERS                                   |   9 +
>>  drivers/crypto/caam/Kconfig                   |   3 +
>>  drivers/crypto/caam/Makefile                  |   1 +
>>  drivers/crypto/caam/blob_gen.c                | 164 ++++++++++++++++++
>>  include/keys/trusted-type.h                   |   2 +-
>>  include/keys/trusted_caam.h                   |  11 ++
>>  include/soc/fsl/caam-blob.h                   | 102 +++++++++++
>>  security/keys/Kconfig                         |  18 +-
>>  security/keys/trusted-keys/Kconfig            |  38 ++++
>>  security/keys/trusted-keys/Makefile           |  10 +-
>>  security/keys/trusted-keys/trusted_caam.c     |  82 +++++++++
>>  security/keys/trusted-keys/trusted_core.c     |  45 ++++-
>>  14 files changed, 527 insertions(+), 29 deletions(-)  create mode 100644
>> drivers/crypto/caam/blob_gen.c  create mode 100644
>> include/keys/trusted_caam.h  create mode 100644 include/soc/fsl/caam-
>> blob.h  create mode 100644 security/keys/trusted-keys/Kconfig
>>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
>>
>> --
>> 2.30.2
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
