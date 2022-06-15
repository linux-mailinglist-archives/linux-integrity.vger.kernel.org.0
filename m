Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2454D43A
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiFOWGy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiFOWGy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 18:06:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B698563A5;
        Wed, 15 Jun 2022 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655330797;
        bh=GM9SlrCYV8PwJ9onPly7c4ic1qrCz0yZCUZrXibGeos=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZrBPkzWTP6net5ETIf8PqfZVlE/TgAvOLziKnQAqmTlSmECwMOE67sP+nC6AXwHuR
         eOPwdKOlFrhDeQTi9RXD+zpOVOaN0CUfpWBtutjwIIhnMqAW5fcXpv+hoOOeKFOXUU
         Es0+V0AitgKylpz/UEmOdqOe4ct36BhsioLJF/ZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1o2h5N2bMi-0018uh; Thu, 16
 Jun 2022 00:06:37 +0200
Subject: Re: [PATCH v5 01/10] tpm, tpm_tis: Avoid cache incoherency in test
 for interrupts
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-2-LinoSanfilippo@gmx.de> <YqntNDU5tcwgDdvG@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <967ab8d9-2c57-508f-b009-586f560b2c57@gmx.de>
Date:   Thu, 16 Jun 2022 00:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YqntNDU5tcwgDdvG@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aayh+eyoa4dbOV5mgY5A+2v4adW/4qLTT+wnPY257HBF8F4Ap53
 FTPPp5DWV2Vv0LQ3QiFyuTNShOo5YPqFaw61drMi4NWe+oqnUZP/akAs91g6UWq7/6azQN1
 CE7LSSyUz2WGKwcP7TyrEclPyPVEULN28otKvjuXQ1wCQ4H8C7yZgXlhUHyTjom/wIQuVst
 E2GldzRY4iK8ihv1s/9Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VK3V4mROMSk=:hEnqNlBLnL54h7PAgKYaES
 9SdMbUNV2Jo6au+7rfSM76+ce8dU6m5J3q5tY7xaOA7sg6B81rBDSDRlwWqwjUz3ABBVOjhNM
 zZdh4To1UcSi1yDix47XXK0oyYryVCWf+ll8nq8tuRL4Hka17ui6QxBS6cDqR5ZRdspAdMJrp
 dyZiClkoZHUaplLBHIJbQIjR/AEv70gePdm2HMjT85A9rm2RaKArn/mKZRBj6W8MiWS+Gh9fr
 biBZgR0Ww2c1gOeQbojJ9tYT5E19mxpmndnXa1irJ0coJr62eYvE7YIGRXVnpaU4F3nR7cQsq
 6VSQ08UKBZtzCiSEOGTGi/d98sutI8Y9axvfZmokQDo9hMqc4xb+lnwU3wINZYr8r9GX3RbPm
 37Kc+QnyD2LmI44iiPuukiKPZw6xh6/KX5E/lYmkNYOs3DpP4ZfytjE4lsKjTBhLx6B8O4hYX
 iYMbBZUqFYMyo20XJHA6MVIS5kNR0XxJuuyg21DzQVScvRjjeWQMw+UEOJW12UXoLPRPynL3S
 hIm2npq0XrTdv5wu46f9RMxHNTw7xWERc9PojbbjxcEKWPQU1YtRWFXK5q/hEs++bWV6SZDxe
 OP+6VSjNM3nruyMJ4saCkCJ0G4Af0aIwxjNd9EEghDWs9aiC7K8AMpOYwEQfJ3rzvA4zNPRz6
 jc0Nl+jVrY4AJpksFL/tUszaHDWibm97EkP5MbDBd22dItQEBKrRbKh0SSbeuvpXA33tAOJ94
 AAV7mJktMdcWFFkJbqkjcxp8kUYaMwyUMD9yWe9nbcorBD0u7aRs+ppKDQCpnGUBLlcllV+cI
 l2FqTRLgIng4ewLf54ir3oB5lv3njupILom9Hf0fAx46T+WBhvephwWa+1GK5B27J+juDUj2z
 EsMeitk5lModGWJH9fbkL8cRxr3ibOWns+flRtyhgx3vYUBSwH4cKADmK3p80O3bFvrEW7QS5
 P+PFJtADYfVLhW6Vf9Cz+oIEdHMI5db+jQVm27P6OtFnnLx5diTpc15y4Imol589rwoqC3PUJ
 mKi5ISUvAzcqceKDOTN0ypBKv9DZIPiMwZGxdOCrNjA2xy+gdvNQ7xiHX/GFwaGSXXZkL+nKx
 NwxitKgliSQOm6PX6FA/f4E+y5jGgwjgRc4mrfDAqqJBYPclKlKs076yw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 15.06.22 at 16:32, Jarkko Sakkinen wrote:
> On Fri, Jun 10, 2022 at 01:08:37PM +0200, LinoSanfilippo@gmx.de wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> The interrupt handler that sets the boolean variable irq_tested may run=
 on
>> another CPU as the thread that checks irq_tested as part of the irq tes=
t in
>> tmp_tis_send().
>>
>> Since nothing guarantees cache coherency between CPUs for unsynchronize=
d
>> accesses to boolean variables the testing thread might not perceive the
>> value change done in the interrupt handler.
>>
>> Avoid this issue by using a bitfield instead of a boolean variable and =
by
>> accessing this field with the bit manipulating functions that provide c=
ache
>> coherency.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 13 +++++++------
>>  drivers/char/tpm/tpm_tis_core.h |  6 +++++-
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index dc56b976d816..6f2cf75add8b 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -470,7 +470,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *=
buf, size_t len)
>>  	int rc, irq;
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>
>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
>> +	     test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>>  		return tpm_tis_send_main(chip, buf, len);
>>
>>  	/* Verify receipt of the expected IRQ */
>> @@ -480,11 +481,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8=
 *buf, size_t len)
>>  	rc =3D tpm_tis_send_main(chip, buf, len);
>>  	priv->irq =3D irq;
>>  	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>> -	if (!priv->irq_tested)
>> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>>  		tpm_msleep(1);
>> -	if (!priv->irq_tested)
>> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>>  		disable_interrupts(chip);
>> -	priv->irq_tested =3D true;
>> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>>  	return rc;
>>  }
>>
>> @@ -693,7 +694,7 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
>>  	if (interrupt =3D=3D 0)
>>  		return IRQ_NONE;
>>
>> -	priv->irq_tested =3D true;
>> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>>  		wake_up_interruptible(&priv->read_queue);
>>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
>> @@ -779,7 +780,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip=
 *chip, u32 intmask,
>>  	if (rc < 0)
>>  		return rc;
>>
>> -	priv->irq_tested =3D false;
>> +	clear_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>>
>>  	/* Generate an interrupt by having the core call through to
>>  	 * tpm_tis_send
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 3be24f221e32..0f29d0b68c3e 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -88,11 +88,15 @@ enum tpm_tis_flags {
>>  	TPM_TIS_INVALID_STATUS		=3D BIT(1),
>>  };
>>
>> +enum tpm_tis_irqtest_flags {
>> +	TPM_TIS_IRQ_TESTED		=3D BIT(0),
>> +};
>> +
>>  struct tpm_tis_data {
>>  	u16 manufacturer_id;
>>  	int locality;
>>  	int irq;
>> -	bool irq_tested;
>> +	unsigned long irqtest_flags;
>>  	unsigned long flags;
>>  	void __iomem *ilb_base_addr;
>>  	u16 clkrun_enabled;
>> --
>> 2.36.1
>>
>
> Otherwise looks fine, but please add TPM_TIS_IRQ_TESTED to 'flags', and
> convert existing sites to use set_bit() and and test_bit().
>
> BR, Jarkko
>

Ok, will do.

Regards,
Lino
