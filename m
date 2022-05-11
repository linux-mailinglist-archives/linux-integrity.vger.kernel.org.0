Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03F523E1F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347424AbiEKT50 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiEKT5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:57:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40A23108A;
        Wed, 11 May 2022 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652299020;
        bh=LAJQRV0TZVJjqcNITffxHHBpgXzLXe0jFSSpCldmml0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JuM1u+CsONWTKbyYuJyKSLkUfKMhqvYOgoF3wSgOjLmJkVN/KD2kxmUX83YChbPpA
         ijc4AZuaLMdQKTiUubesi3XE4/Mg8S2TvFnEEzpGvBQ8yDSt2aktjfKhgy3B4v/Ff0
         TqRypzabXLrxDvxS7BKFLbFQHKsEJohnRc3XQDSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.12]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1oEcMj3BMz-00jYpg; Wed, 11
 May 2022 21:57:00 +0200
Subject: Re: [PATCH v4 5/6] tpm, tpm_tis: Move irq test from tpm_tis_send() to
 tpm_tis_probe_irq_single()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-6-LinoSanfilippo@gmx.de> <YnvRrT19Pe2SPDNe@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <34f47a0c-5c2d-1cdc-fb97-03666a5e1918@gmx.de>
Date:   Wed, 11 May 2022 21:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnvRrT19Pe2SPDNe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RGDtSxGZMfrSr8yRCh6c57RM6+vCI56Wfp2d/oBnXn7CpS10Nwi
 W1aukCr56aGunICkkmBQXQBAgPIr8iK4YapYCLFERGk4xVXtDePQagYXnbc4+05m70RkPKU
 EzNM4dXv4JYIZjHHrkhlLPdeadCYPkuPbP0ah4ApyhXez9YzjFR1B4wYXZT1JQbhU1zxaR5
 E3Lm6X07lXWxlhwp2GLTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gqY1Azz4uNo=:atkRhvey9X/0gXMVJ/FU0k
 XDvXivxhgVZfLP0BdmLV8P1HjC+4XbQhtvuA5K+53gPchrnhoeLpbzkihOgdYx5EAncu1uqWa
 BhA0sX6D0Nq+K4a0UutLTXBtP1ujsNHGVFeWAtoSx9Z5FmyqMzZwcuAjPe16npkt8rrYbOtq5
 06oCyOtErR9Nn6JHqAGjprksDvBCN9zFp4waj6Ra2SHLaldeWKq3hl3BYP2s6tNrkHtjVo1nb
 Dwzqfc0zXU7NoJ7UVQDzrq/DbUGJou2ubMc8JrnQbz0dYbpV7oZyvo3y27Rxv6T7nPGFYd/uB
 OkdWUFyYGbfovOlFMVYeZShH70xB0Nh86DY8/LcMwlxQHXyYK9jZnF58PYMHpuXDA1aK5b5H8
 LIWf7to1vu3yjGaPqGzqHYhB1fU+3cvh6fSzAuxO3wgb6szCjt78EpaXolrGQMrbv/oaNYvo2
 +UGNHDnAHUtX+nuOhyuVGjqAlx6fe+9IPOGzv/Xemu1UWOSdXUKNS6V294k3aeu2MOKKuhtsn
 cPo4VA1MWp0QZPlGUOx6VZueDS5SjMEDAk5DacLObK717KemEUs+KSXSucnLXXZFw1Jor5dm2
 DCVVkwHFSfgMlqXVODh+O5jr+LWppo3HwBvRK7wpeGf1pIlbCRAsu//GEj6K5yMCQsXkVRhDY
 js83aOXkCBAXJYUpbCawvqUFEBtNg2Ts1gA8RXsV/z5J7Ov+2it75zPU39Pcqts7tnNmTaOzx
 TMGCs/0SW0Bf+cEc4vKtxFfrPnjSB5ifa5jmTb+RyUQM0YwtTq16Q8G8KiULQiCrAlezER94r
 4jOUk+vUuToNgOAxWzCov2GPzMMtNiKTyTnMbWGLvLCD2CCrMaRweN72Sbieb94U77TPtrxj3
 1gn3LYfg/Z3/w5gLIBk5c6EgWlhVTsCIWNbLAuf7/P2C680FBZ3PpcvaUo8cvYLEbS4ow5pCZ
 twTmK1Bw41SSCeMocEB5LJojCj89Fu1frnXC6n7Ds6XX7g3Em/Q/hpOWwuPh0pBH4JIVvOcle
 UiTPI4Jq2DAVjHaG6S8jR/rAHn5nC+yNC9/DtIc8ZTshHy6HAcUiuM1sr1aGn2/NYsOOjkvY2
 ROuxeRgYD+OijWcqW0mbPNfitmidvKvFATZMj1v3C3vvGwhUkGLTYK4cg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11.05.22 at 17:09, Jarkko Sakkinen wrote:
> On Mon, May 09, 2022 at 10:05:58AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> There is no need to check for the irq test completion at each data
>> transmission during the driver livetime. Instead do the check only once=
 at
>> driver startup.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++----------------------
>>  1 file changed, 22 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index bdfde1cd71fe..4c65718feb7d 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -432,7 +432,7 @@ static void disable_interrupts(struct tpm_chip *chi=
p)
>>   * tpm.c can skip polling for the data to be available as the interrup=
t is
>>   * waited for here
>>   */
>> -static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, siz=
e_t len)
>> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>  {
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>  	int rc;
>> @@ -465,30 +465,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip=
, const u8 *buf, size_t len)
>>  	return rc;
>>  }
>>
>> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> -{
>> -	int rc, irq;
>> -	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> -
>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
>> -	     test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>> -		return tpm_tis_send_main(chip, buf, len);
>> -
>> -	/* Verify receipt of the expected IRQ */
>> -	irq =3D priv->irq;
>> -	priv->irq =3D 0;
>> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>> -	rc =3D tpm_tis_send_main(chip, buf, len);
>> -	priv->irq =3D irq;
>> -	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>> -		tpm_msleep(1);
>> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>> -		disable_interrupts(chip);
>> -	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>> -	return rc;
>> -}
>> -
>>  struct tis_vendor_durations_override {
>>  	u32 did_vid;
>>  	struct tpm1_version version;
>> @@ -759,51 +735,54 @@ static int tpm_tis_probe_irq_single(struct tpm_ch=
ip *chip, u32 intmask,
>>
>>  	rc =3D tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>>  			   &original_int_vec);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		disable_interrupts(chip);
>>  		return rc;
>> +	}
>>
>>  	rc =3D tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>>  	if (rc < 0)
>> -		return rc;
>> +		goto out_err;
>>
>>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_stat=
us);
>>  	if (rc < 0)
>> -		return rc;
>> +		goto out_err;
>>
>>  	/* Clear all existing */
>>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_stat=
us);
>>  	if (rc < 0)
>> -		return rc;
>> +		goto out_err;
>>
>>  	/* Turn on */
>>  	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>>  	if (rc < 0)
>> -		return rc;
>> +		goto out_err;
>>
>>  	clear_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>> -	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>
>>  	/* Generate an interrupt by having the core call through to
>>  	 * tpm_tis_send
>>  	 */
>>  	rc =3D tpm_tis_gen_interrupt(chip);
>>  	if (rc < 0)
>> -		return rc;
>> +		goto out_err;
>>
>> -	/* tpm_tis_send will either confirm the interrupt is working or it
>> -	 * will call disable_irq which undoes all of the above.
>> -	 */
>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>> -		rc =3D tpm_tis_write8(priv, original_int_vec,
>> -				TPM_INT_VECTOR(priv->locality));
>> -		if (rc < 0)
>> -			return rc;
>> +	tpm_msleep(1);
>>
>> -		return 1;
>> -	}
>> +	/* Verify receipt of the expected IRQ */
>> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>> +		goto out_err;
>> +
>> +	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>
>>  	return 0;
>> +
>> +out_err:
>> +	disable_interrupts(chip);
>> +	tpm_tis_write8(priv, original_int_vec, TPM_INT_VECTOR(priv->locality)=
);
>> +
>> +	return rc;
>>  }
>>
>>  /* Try to find the IRQ the TPM is using. This is for legacy x86 system=
s that
>> @@ -1075,12 +1054,9 @@ int tpm_tis_core_init(struct device *dev, struct=
 tpm_tis_data *priv, int irq,
>>  		if (irq) {
>>  			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>>  						 irq);
>> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>>  				dev_err(&chip->dev, FW_BUG
>>  					"TPM interrupt not working, polling instead\n");
>> -
>> -				disable_interrupts(chip);
>> -			}
>>  		} else {
>>  			tpm_tis_probe_irq(chip, intmask);
>>  		}
>> --
>> 2.36.0
>>
>
> For me this looks just code shuffling.
>
> I don't disagree but changing working code without actual semantical
> reasons neither makes sense.
>
> BR, Jarkko
>

Well the semantical reason for this change is that the check for irq test =
completion
only has to be done once for the driver livetime. There is no point in doi=
ng it
over and over again for each transmission.
So the code is not simply shuffled around, it is shifted to a place where =
it is only
executed once.

This is not a bugfix but it is clearly an improvement/cleanup. As far as I=
 understood
from your comments on the earlier versions of this patch set cleanups are =
also ok as
long as they are not intermixed with bugfixes.

Regards,
Lino
