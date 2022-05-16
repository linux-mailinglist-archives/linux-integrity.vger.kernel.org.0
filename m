Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2C52922F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiEPUvz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348326AbiEPUum (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 16:50:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD96324;
        Mon, 16 May 2022 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652732758;
        bh=7QFhKk3Oy/ae7wVl4Hge9UJW/zVtri2qd6A8mUdd0IY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G/2UptXwzEPTOQALlTtAAV4Zzv/PWHH+blUhVPNUxpkKF8bfWQFEfmnOmJYadg10b
         bN3FLIuA/TMJ9k4kwmgKy0/NsId0sxzV0Q8wVCvATs2HcjC2y8l3abzKPpGmUYn0Xj
         1PhI/pEFZyrVp573r417rjEr2Q53dtt4Tf3n+I/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1oEg3R00Hz-00P49z; Mon, 16
 May 2022 22:25:58 +0200
Subject: Re: [PATCH v4 5/6] tpm, tpm_tis: Move irq test from tpm_tis_send() to
 tpm_tis_probe_irq_single()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-6-LinoSanfilippo@gmx.de> <YnvRrT19Pe2SPDNe@kernel.org>
 <34f47a0c-5c2d-1cdc-fb97-03666a5e1918@gmx.de> <YoKPCKarZiKRWa4b@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <0378b8ac-22c6-b1ba-0fd7-dae8fa15cb81@gmx.de>
Date:   Mon, 16 May 2022 22:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YoKPCKarZiKRWa4b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPtLjFFqbLVj4RcOID4eeDrMNUaq+VNqgMxTz9DzsxuI0ebaNUr
 zz/4KxK/qW92vV8I3LQsYokaz6HrQarg82wRnA07Pz1Uloc8W1hoV1rbcYGdsl3v2VC5GNr
 71eIC7zxKWAZYbCTSXhuh5p+23rVsmLJLJltOX99zjWvF0YSyBP1iLmsGlZ2ckJSGYzYoeP
 ksjxtTCBZnsokfnTKBnOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PxQPMwQfsvo=:UFbwNzB3LVYCZGC1DRTLYe
 nuJuhuhWOiPFkk57agFQLS3Fd60xs+q2wYGZ6LZnLAU40i5J/T3pfAtoSMQrLYLrx0w/PR7XB
 1nA7qCFEZa47T5bD0AtsrT8buyO2ekoGlK/kHuVo6eCRgu/Y+rROD7z1tU5AoN9EVr5uodJQf
 DgayJMjKBJ8/dceRf0Kq/F5LKE9iMBKzzRQxTLRWjz2Ge6uViNybeG8a3KRK8GbtAWCU87WPL
 sTqCMtvo1upHT6AuINaaNL31OgOIYZfjTUbEXTbDK8UdtThpfoFy4scdj/KYI+Ar2H6qPopKL
 U6sfmBWB1Ic8j97DsfNMkOIwIG1gz3e6aMq8Exm/1VDOGONq6AJvAcXHLPhPBHES3OXRQbXoA
 17u22F247oRYYP+k4pWZdI1Lg9O/zeGLlX1ZjvtT9Ohsgefv99AMwYhbIvWJKeawBlwNT7xMt
 NRIWAVKEOmDOaonqFkKlfsuPPJICg96epAJOShcpwy88LN8TIquNLu+idMuxyXQddBQjaOmFe
 ne3ilqlhTBgU16t+voMzodZPWpCo9YN2qcZbeZjPnmNDw+iKDFgW8sPRmJgK49ppLQH3GM+5A
 XBgh1jYrCy/Emq7c+6SBCvyE2rdPiL5lgS8idUUhPYqyDNr+miCGgYMrxNXK1IEDfnynUVYyI
 LwEq5SP3jXvdULhADCflUsHv2DYiXAoVXf1ubDGDN/69qhXkWrcQW3RFuY3Gf6IT5HIYxjfpR
 Zz4xrQM0feVsHdEfflBG+B4RhjTQDwXpG5vAx1KfKueq6WzwH8hJF5o4KX0gXbYye18LHkhBF
 LKHkfNto+qZbBbG2LE6AnXVnkXlD/Oj/g40xzIus40NmThhP2AETXAwGtd2Ypd9vPt2fvObH5
 YQEBu+ETSaB/HDxPw1WctFUNkyqEe707bqE/5rezoNOXF5c5wkxkL4DfvmcNS6cSLJb4JeiVv
 iGLInsQ6W6je+2O1Uq7CAytoNcohiux1apzy+5Bb/XliAn/8waCv+IQ/KEh3gcXadgTU1YbO+
 HsyNttU4e9SWU9QRqW+lFK12lT+Kh8E2GO4NJY3FnO32QL5HRa5jO2fkYphAIsNZuqeCXxc1k
 j9Xr6q6nyJYHUfZ7syTP+N40KZnfxXGMa2xnRcBhlXGoxA95cd/opNo0g==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 16.05.22 at 19:51, Jarkko Sakkinen wrote:
> On Wed, May 11, 2022 at 09:56:59PM +0200, Lino Sanfilippo wrote:
>> On 11.05.22 at 17:09, Jarkko Sakkinen wrote:
>>> On Mon, May 09, 2022 at 10:05:58AM +0200, Lino Sanfilippo wrote:
>>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>
>>>> There is no need to check for the irq test completion at each data
>>>> transmission during the driver livetime. Instead do the check only on=
ce at
>>>> driver startup.
>>>>
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>> ---
>>>>  drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++--------------------=
--
>>>>  1 file changed, 22 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_t=
is_core.c
>>>> index bdfde1cd71fe..4c65718feb7d 100644
>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>> @@ -432,7 +432,7 @@ static void disable_interrupts(struct tpm_chip *c=
hip)
>>>>   * tpm.c can skip polling for the data to be available as the interr=
upt is
>>>>   * waited for here
>>>>   */
>>>> -static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, s=
ize_t len)
>>>> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>>>  {
>>>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>>>  	int rc;
>>>> @@ -465,30 +465,6 @@ static int tpm_tis_send_main(struct tpm_chip *ch=
ip, const u8 *buf, size_t len)
>>>>  	return rc;
>>>>  }
>>>>
>>>> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>>> -{
>>>> -	int rc, irq;
>>>> -	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>>> -
>>>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
>>>> -	     test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>>> -		return tpm_tis_send_main(chip, buf, len);
>>>> -
>>>> -	/* Verify receipt of the expected IRQ */
>>>> -	irq =3D priv->irq;
>>>> -	priv->irq =3D 0;
>>>> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>>>> -	rc =3D tpm_tis_send_main(chip, buf, len);
>>>> -	priv->irq =3D irq;
>>>> -	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>>> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>>> -		tpm_msleep(1);
>>>> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>>> -		disable_interrupts(chip);
>>>> -	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>>>> -	return rc;
>>>> -}
>>>> -
>>>>  struct tis_vendor_durations_override {
>>>>  	u32 did_vid;
>>>>  	struct tpm1_version version;
>>>> @@ -759,51 +735,54 @@ static int tpm_tis_probe_irq_single(struct tpm_=
chip *chip, u32 intmask,
>>>>
>>>>  	rc =3D tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>>>>  			   &original_int_vec);
>>>> -	if (rc < 0)
>>>> +	if (rc < 0) {
>>>> +		disable_interrupts(chip);
>>>>  		return rc;
>>>> +	}
>>>>
>>>>  	rc =3D tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>>>>  	if (rc < 0)
>>>> -		return rc;
>>>> +		goto out_err;
>>>>
>>>>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_st=
atus);
>>>>  	if (rc < 0)
>>>> -		return rc;
>>>> +		goto out_err;
>>>>
>>>>  	/* Clear all existing */
>>>>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_st=
atus);
>>>>  	if (rc < 0)
>>>> -		return rc;
>>>> +		goto out_err;
>>>>
>>>>  	/* Turn on */
>>>>  	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>>>>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>>>>  	if (rc < 0)
>>>> -		return rc;
>>>> +		goto out_err;
>>>>
>>>>  	clear_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>>>> -	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>>>
>>>>  	/* Generate an interrupt by having the core call through to
>>>>  	 * tpm_tis_send
>>>>  	 */
>>>>  	rc =3D tpm_tis_gen_interrupt(chip);
>>>>  	if (rc < 0)
>>>> -		return rc;
>>>> +		goto out_err;
>>>>
>>>> -	/* tpm_tis_send will either confirm the interrupt is working or it
>>>> -	 * will call disable_irq which undoes all of the above.
>>>> -	 */
>>>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>> -		rc =3D tpm_tis_write8(priv, original_int_vec,
>>>> -				TPM_INT_VECTOR(priv->locality));
>>>> -		if (rc < 0)
>>>> -			return rc;
>>>> +	tpm_msleep(1);
>>>>
>>>> -		return 1;
>>>> -	}
>>>> +	/* Verify receipt of the expected IRQ */
>>>> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>>> +		goto out_err;
>>>> +
>>>> +	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>>>
>>>>  	return 0;
>>>> +
>>>> +out_err:
>
> Rename this as just 'err'.
>
>>>> +	disable_interrupts(chip);
>>>> +	tpm_tis_write8(priv, original_int_vec, TPM_INT_VECTOR(priv->localit=
y));
>>>> +
>>>> +	return rc;
>>>>  }
>>>>
>>>>  /* Try to find the IRQ the TPM is using. This is for legacy x86 syst=
ems that
>>>> @@ -1075,12 +1054,9 @@ int tpm_tis_core_init(struct device *dev, stru=
ct tpm_tis_data *priv, int irq,
>>>>  		if (irq) {
>>>>  			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>>>>  						 irq);
>>>> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>>>>  				dev_err(&chip->dev, FW_BUG
>>>>  					"TPM interrupt not working, polling instead\n");
>>>> -
>>>> -				disable_interrupts(chip);
>>>> -			}
>>>>  		} else {
>>>>  			tpm_tis_probe_irq(chip, intmask);
>>>>  		}
>>>> --
>>>> 2.36.0
>>>>
>>>
>>> For me this looks just code shuffling.
>>>
>>> I don't disagree but changing working code without actual semantical
>>> reasons neither makes sense.
>>>
>>> BR, Jarkko
>>>
>>
>> Well the semantical reason for this change is that the check for irq te=
st completion
>> only has to be done once for the driver livetime. There is no point in =
doing it
>> over and over again for each transmission.
>> So the code is not simply shuffled around, it is shifted to a place whe=
re it is only
>> executed once.
>>
>> This is not a bugfix but it is clearly an improvement/cleanup. As far a=
s I understood
>> from your comments on the earlier versions of this patch set cleanups a=
re also ok as
>> long as they are not intermixed with bugfixes.
>
> The patch does not do anything particulary useful IMHO. There's no
> stimulus to do this change.
>

Ok, I will drop this patch in the next version of this series then.

Regards,
Lino

