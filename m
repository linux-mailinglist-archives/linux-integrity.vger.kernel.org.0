Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8B60C07D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 03:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJYBII (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Oct 2022 21:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJYBHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Oct 2022 21:07:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116CA2A8C;
        Mon, 24 Oct 2022 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666656953;
        bh=PKvMgtvNQQBZF3hpZU9U4m1Jli3g3rGmsQm6YiKfM9Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SiK4ykHSf35EkByRTX1pXma+HCGaPRAiWwRvNqDRi4svhoCK80xvm8wbUBhCr13CC
         FvGmGSEKST8Jad5Z/FJ/K+JhFLsL3dTDx/GnQ/iS38dzrdzm4ryY9IoeOEmTyWoUxV
         ITCNYoP9ZsSmvryy1/YRnImZttAS2RTIJ5uPt1HM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.83] ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1pNYHs3XCu-00cgxJ; Tue, 25
 Oct 2022 02:15:52 +0200
Message-ID: <fcf53b02-a505-46ac-006e-0e317f00bbe3@gmx.de>
Date:   Tue, 25 Oct 2022 02:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de> <Y1TFzO1CBY8d4rfa@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <Y1TFzO1CBY8d4rfa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s8LxJ2tFfYfU0VZDiHXBMX4ln3S3UJ7Xuw58rF2hZnyX40bRCLn
 5nD1KtIoBv4ZFHq4hzbHtd5xKI93GWZHOoLzBuoh5ubKaN7ykZEf+1LePoEAsG1x+SDjOaT
 bnGH2186u5AGy+ZoafygFPVqVOmLkXqU9iGFMi1xdroLbdQXuEKURmy1fUMus7gwxQiCY84
 XK2QhteyLlVVDltusy4vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tq/UCOIPMRM=:sjqKxkc7HNegWwKGjGGvUt
 byMk+g7/3bu0pikM8ydR28oOFkXkp7RyU+u1Wzvs1UYOcthK+yJRO/cXqSNP6gwi6UKNh7Oh8
 y/WUqqS9IVy8hezYlew1zzh6tygZvC2+qVI9brirmi5Lk8Ylry/gIeMXua4992rDx8ZZWmsXE
 Vvstrcu5wkJloxO6va+jDuH7LL2AnGwtanwcyyyUY3foLRPCFnizFczrTDUiPZjE/tM906gbV
 V/iU3nmb3JjNTP1KK1K3NShHOt0xAjeQJNRXBysjJ6HDMzPX25TnZ4y+45yQRRvVR468BaaoH
 dVMhWliHpBDlPxd+Iqi6tHDYAIqlxJxQAmPqxP8RMZxtFz6+PaniqzZm3aFdnIcb3SAwlgm4J
 lUTgFGeLReT2w0nSYc1QCLxaUqV0H21Ikjvf3K3j3VDPKgCGv1Jfd4vplZz26tNf9s5/hdBMk
 wjV0V1gIUvPVkp1zHcD+USZCCys8L319qU2XgkOVbEaDaZCiWXJ07VXJkLpz3EQlriyMto8FB
 FBzSi7daKKKJkilI09b9Jaij2f86Olcc4geNYTRJ3PifrswgVqE12/5Hq//CSh1k5pGpJqjRW
 LpIiaFfP7i9OVmmWORGlrR9L9ywRotBM9nQgXi5NnrIhw2vbJlfCIOq3A5SeNdhKYxn2XhLMW
 GrJChZjdK1YF1AmWtmmfCGwNiIiTfSm+M6FVLxZZi4kR4Csifm47IPd5ZOr2iqxB/pvRgUXQb
 TNbYaD+DIVWmcUpG6TEwNm+a79vtF9BybWscPwcjK0Qz7KLMfzxzti2IBbPreSrWCwAp2XVI2
 xNkpyYU+zS4w+/n6OeVRf3jtM91plFoKh3djmfUCAi7v0iJ251FyBNqM2S521jCK5ucE0qXGg
 RvUXmEunNQLtUY7zx9qKuS/iGVK1T4fg1EbGcW5idWH+9/r2IyZx7/stTx3ZyKv8XvHdlKQHq
 ZhmVYN89XcnRqnCUiLMutQ36ReHeziDLp+nxcy8KM4wjdVD+W3rgkQVpymWCge4EXnG1aESkx
 7M0biXwSPWrd5T2aA9fEU7izCOJj8+VhrogSByiBijxyv+PdewT07u0zHHFrOuYRjPY4uVEOm
 bPVTV8W9bczIspe+o0aef5YvcLvtvSDCr+XBWYFmUMS8cp4XvisefYxezUS7obxrkytCHtRC/
 7z9qnEbxCKrKvQ7mKCQs2dhUCtXheE9+s2H6C2T2HAZtP3iewUREoIjzsa3mBrtI5XsyjgzSP
 QGnh1N5FRE6T6ahXdtXBbCln8NVcgl8hrXNyRVujwjwmxnv1mwPFZyRhVYGhyyDC3GIziq8ma
 TXVI3nA8y2LOxe2oKdXNGqvnS40cJqqFZkXIHilDfq6+AsrZ6EkqpVq/n0MzATe0z/CX/f1mv
 QV0fZqv3TBH2+8BXHslBBwlUeMQq9Py/4NbdpsCEX3h1ijp9QBn0mAXTRvJMveYgpYhZwLM2t
 vDfvsbTeg8hxSxY1tjnbqV/3YB5e70v2eppW34xPOz/W6Z3nTtLRToXppd12OUlbcD631/ZoN
 R/yp/wPkQLWeEpdB77MLNh8ef8ekRUJmTQXJu66x1Z0Lm
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 23.10.22 06:40, Jarkko Sakkinen wrote:
> On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Implement a usage counter for the (default) locality used by the TPM TI=
S
>> driver:
>> Request the locality from the TPM if it has not been claimed yet, other=
wise
>> only increment the counter. Also release the locality if the counter is=
 0
>> otherwise only decrement the counter. Ensure thread-safety by protectin=
g
>> the counter with a mutex.
>>
>> This allows to request and release the locality from a thread and the
>> interrupt handler at the same time without the danger to interfere with
>> each other.
>>
>> By doing this refactor the names of the amended functions to use the pr=
oper
>> prefix.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> Tested-by: Michael Niew=C3=B6hner <linux@mniewoehner.de>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 75 ++++++++++++++++++++++-----------
>>  drivers/char/tpm/tpm_tis_core.h |  2 +
>>  2 files changed, 53 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 4336f7ea8c2b..79dfab65976f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -165,16 +165,27 @@ static bool check_locality(struct tpm_chip *chip,=
 int l)
>>  	return false;
>>  }
>>
>> -static int release_locality(struct tpm_chip *chip, int l)
>> +static int tpm_tis_release_locality_locked(struct tpm_tis_data *priv, =
int l)
>
> Nit: usually you would actually use "unlocked" here, not locked.
>
> Probably best name would be __tpm_tis_release_locality().


Agreed. This is also consistent with the naming scheme used for many other
kernel functions.

>
>> +{
>> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
>>  {
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>
>> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>> +	mutex_lock(&priv->locality_count_mutex);
>> +	priv->locality_count--;
>> +	if (priv->locality_count =3D=3D 0)
>> +		tpm_tis_release_locality_locked(priv, l);
>> +	mutex_unlock(&priv->locality_count_mutex);
>>
>>  	return 0;
>>  }
>
> Since the function pointer has the word "relinquish" and not "release",
> perhaps these should also use that word for consistency.
>
>>
>> -static int request_locality(struct tpm_chip *chip, int l)
>> +static int tpm_tis_request_locality_locked(struct tpm_chip *chip, int =
l)
>>  {
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>  	unsigned long stop, timeout;
>> @@ -215,6 +226,20 @@ static int request_locality(struct tpm_chip *chip,=
 int l)
>>  	return -1;
>>  }
>>
>> +static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>> +{
>> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> +	int ret =3D 0;
>> +
>> +	mutex_lock(&priv->locality_count_mutex);
>> +	if (priv->locality_count =3D=3D 0)
>> +		ret =3D tpm_tis_request_locality_locked(chip, l);
>> +	if (!ret)
>> +		priv->locality_count++;
>> +	mutex_unlock(&priv->locality_count_mutex);
>> +	return ret;
>> +}
>> +
>>  static u8 tpm_tis_status(struct tpm_chip *chip)
>>  {
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> @@ -682,7 +707,7 @@ static int probe_itpm(struct tpm_chip *chip)
>>  	if (vendor !=3D TPM_VID_INTEL)
>>  		return 0;
>>
>> -	if (request_locality(chip, 0) !=3D 0)
>> +	if (tpm_tis_request_locality(chip, 0) !=3D 0)
>>  		return -EBUSY;
>>
>>  	rc =3D tpm_tis_send_data(chip, cmd_getticks, len);
>> @@ -703,7 +728,7 @@ static int probe_itpm(struct tpm_chip *chip)
>>
>>  out:
>>  	tpm_tis_ready(chip);
>> -	release_locality(chip, priv->locality);
>> +	tpm_tis_release_locality(chip, priv->locality);
>>
>>  	return rc;
>>  }
>> @@ -762,7 +787,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *c=
hip)
>>  	cap_t cap;
>>  	int ret;
>>
>> -	ret =3D request_locality(chip, 0);
>> +	ret =3D tpm_tis_request_locality(chip, 0);
>>  	if (ret < 0)
>>  		return ret;
>>
>> @@ -771,7 +796,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *c=
hip)
>>  	else
>>  		ret =3D tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>>
>> -	release_locality(chip, 0);
>> +	tpm_tis_release_locality(chip, 0);
>>
>>  	return ret;
>>  }
>> @@ -796,33 +821,33 @@ static int tpm_tis_probe_irq_single(struct tpm_ch=
ip *chip, u32 intmask,
>>  	}
>>  	priv->irq =3D irq;
>>
>> -	rc =3D request_locality(chip, 0);
>> +	rc =3D tpm_tis_request_locality(chip, 0);
>>  	if (rc < 0)
>>  		return rc;
>>
>>  	rc =3D tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>>  			   &original_int_vec);
>>  	if (rc < 0) {
>> -		release_locality(chip, priv->locality);
>> +		tpm_tis_release_locality(chip, priv->locality);
>>  		return rc;
>>  	}
>>
>>  	rc =3D tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>>  	if (rc < 0) {
>> -		release_locality(chip, priv->locality);
>> +		tpm_tis_release_locality(chip, priv->locality);
>>  		return rc;
>>  	}
>>
>>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_stat=
us);
>>  	if (rc < 0) {
>> -		release_locality(chip, priv->locality);
>> +		tpm_tis_release_locality(chip, priv->locality);
>>  		return rc;
>>  	}
>>
>>  	/* Clear all existing */
>>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_stat=
us);
>>  	if (rc < 0) {
>> -		release_locality(chip, priv->locality);
>> +		tpm_tis_release_locality(chip, priv->locality);
>>  		return rc;
>>  	}
>>
>> @@ -830,11 +855,11 @@ static int tpm_tis_probe_irq_single(struct tpm_ch=
ip *chip, u32 intmask,
>>  	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>>  	if (rc < 0) {
>> -		release_locality(chip, priv->locality);
>> +		tpm_tis_release_locality(chip, priv->locality);
>>  		return rc;
>>  	}
>>
>> -	release_locality(chip, priv->locality);
>> +	tpm_tis_release_locality(chip, priv->locality);
>>  	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>
>>  	/* Generate an interrupt by having the core call through to
>> @@ -970,8 +995,8 @@ static const struct tpm_class_ops tpm_tis =3D {
>>  	.req_complete_mask =3D TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>>  	.req_complete_val =3D TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>>  	.req_canceled =3D tpm_tis_req_canceled,
>> -	.request_locality =3D request_locality,
>> -	.relinquish_locality =3D release_locality,
>> +	.request_locality =3D tpm_tis_request_locality,
>> +	.relinquish_locality =3D tpm_tis_release_locality,
>>  	.clk_enable =3D tpm_tis_clkrun_enable,
>>  };
>>
>> @@ -1005,6 +1030,8 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>  	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
>>  	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>>  	priv->phy_ops =3D phy_ops;
>> +	priv->locality_count =3D 0;
>> +	mutex_init(&priv->locality_count_mutex);
>>
>>  	dev_set_drvdata(&chip->dev, priv);
>>
>> @@ -1083,14 +1110,14 @@ int tpm_tis_core_init(struct device *dev, struc=
t tpm_tis_data *priv, int irq,
>>
>>  	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
>>
>> -	rc =3D request_locality(chip, 0);
>> +	rc =3D tpm_tis_request_locality(chip, 0);
>>  	if (rc < 0) {
>>  		rc =3D -ENODEV;
>>  		goto out_err;
>>  	}
>>
>>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> -	release_locality(chip, 0);
>> +	tpm_tis_release_locality(chip, 0);
>>
>>  	rc =3D tpm_chip_start(chip);
>>  	if (rc)
>> @@ -1124,13 +1151,13 @@ int tpm_tis_core_init(struct device *dev, struc=
t tpm_tis_data *priv, int irq,
>>  		 * proper timeouts for the driver.
>>  		 */
>>
>> -		rc =3D request_locality(chip, 0);
>> +		rc =3D tpm_tis_request_locality(chip, 0);
>>  		if (rc < 0)
>>  			goto out_err;
>>
>>  		rc =3D tpm_get_timeouts(chip);
>>
>> -		release_locality(chip, 0);
>> +		tpm_tis_release_locality(chip, 0);
>>
>>  		if (rc) {
>>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
>> @@ -1150,11 +1177,11 @@ int tpm_tis_core_init(struct device *dev, struc=
t tpm_tis_data *priv, int irq,
>>  			dev_err(&chip->dev, FW_BUG
>>  					"TPM interrupt not working, polling instead\n");
>>
>> -			rc =3D request_locality(chip, 0);
>> +			rc =3D tpm_tis_request_locality(chip, 0);
>>  			if (rc < 0)
>>  				goto out_err;
>>  			disable_interrupts(chip);
>> -			release_locality(chip, 0);
>> +			tpm_tis_release_locality(chip, 0);
>>  		}
>>  	}
>>
>> @@ -1221,13 +1248,13 @@ int tpm_tis_resume(struct device *dev)
>>  	 * an error code but for unknown reason it isn't handled.
>>  	 */
>>  	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
>> -		ret =3D request_locality(chip, 0);
>> +		ret =3D tpm_tis_request_locality(chip, 0);
>>  		if (ret < 0)
>>  			return ret;
>>
>>  		tpm1_do_selftest(chip);
>>
>> -		release_locality(chip, 0);
>> +		tpm_tis_release_locality(chip, 0);
>>  	}
>>
>>  	return 0;
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 2deef11c88db..13bdcf38e56f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -91,6 +91,8 @@ enum tpm_tis_flags {
>>
>>  struct tpm_tis_data {
>>  	u16 manufacturer_id;
>> +	struct mutex locality_count_mutex;
>
> BTW, why mutex and not spinlock?
>
> Hmm.. also I think you might have given feedback already on this
> but could the lock cover the whole struct instead of a counter?
> I tried to dig lore for earlier response but could not find. I'm
> sorry if I'm asking the same question again.
>

Actually thats on me, since it took me much too long to send the v8 after =
the v7 review.

However the reason that we need a mutex here is that we not only increase =
or decrease
the locality_counter under the mutex, but also do the locality request and=
 release by
writing to the ACCESS register. Since in the SPI case each communication o=
ver the spi bus
is protected by the bus_lock_mutex of the SPI device we must not hold a sp=
inlock when doing
the register accesses.

Concerning covering the whole tpm_tis_data struct:
Most structure elements are set once at driver startup but never changed a=
t driver
runtime. So no locking needed for these. The only exception is "flags" and=
 "locality_count"
whereby "flags" is accessed by atomic bit manipulating functions and thus
does not need extra locking. So "locality_count" is AFAICS the only elemen=
t that needs to be
protected by the mutex.


> You could probably use rcu for that.
>
>> +	unsigned int locality_count;

Note that we do not only have to increase or decrease the counter atomical=
ly, but the first
increment (when the counter goes from 1 to 0) AND requesting the locality =
by writing to the
ACCESS register has to be atomic.
Likewise the last decrement (when the counter goes from 1 to 0) AND releas=
ing the locality
has to be done atomically:

	mutex_lock(&priv->locality_count_mutex);
	priv->locality_count--;
	if (priv->locality_count =3D=3D 0)
		tpm_tis_release_locality_locked(priv, l);
	mutex_unlock(&priv->locality_count_mutex);

I dont know if this is possible with RCU, especially since AFAIK RCU works=
 with pointers instead of
integral data types.


Regards,
Lino





>>  	int locality;
>>  	int irq;
>>  	unsigned int int_mask;
>> --
>> 2.36.1
>>
>
> BR, Jarkko
