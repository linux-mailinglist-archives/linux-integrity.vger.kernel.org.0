Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51250523DA4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiEKTgf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347028AbiEKTgE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:36:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9726EE8E;
        Wed, 11 May 2022 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652297745;
        bh=8a/nLJRdG0DcXGzlhhwGdt6K2I3jxutxuh7LywxUD4M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QW9hZTLsAH8TUTmB8iSYGICUcJbvMbG6TOUL9/MZ7tWByFl2PfK18zKyNvJrePzra
         GoZzEtL9gb6uV0QDe3ECB5JohayrfyfnYT3uq7wsXrXs69ZZtPoQOgE6SmIxEzrmE9
         9y/kuCQJZip4vxTCXDoBaY66RhpQSbzLWT+6FjAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.12]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1nfq7C0elb-00Anod; Wed, 11
 May 2022 21:35:45 +0200
Subject: Re: [PATCH v4 4/6] tpm, tpm_tis: avoid CPU cache incoherency in irq
 test
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-5-LinoSanfilippo@gmx.de> <YnvRC3FI7bcXj7zL@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <b7885fcf-70ae-9d7d-dcfb-97d77251c71d@gmx.de>
Date:   Wed, 11 May 2022 21:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnvRC3FI7bcXj7zL@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqvTSwyYJARRE7xXrZJqg0suRyzvg1KUmf6PlkZBWRHQyDMNgmN
 ga17pAFfc9lC4QRXhEstbp+aT3pxc+wZ9DFtneZ40pkmvZ0ek4vpB1M2agVJE+9b5DGCm5b
 GqOt8xmlrWOG72GB2iA+fZvSdrUEfrpR9MuWT5HrAQMwxpNMU7m8HSXr7nRMOu6ZTjRYsFX
 WkSxBs0mA3dUW1SsOtQFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yIeYcy+Hkos=:kJuXDiOoc5qotIsOa+5Fw7
 Vf+OpvAyMM5cgW9dV6VhmY+vLaFjyL8kj3GJSo60MPGNZsT8cFbcrWfdTXT5kP26l2cvK4P8q
 /s6g9OI5QNjAADfhCRPkiX/YpSvx6rYL6RqgN49++v7muNN/ge3ldkw/2VaBXqWmejRF43dwN
 N6XWQR2RvYIdmdI32NXFD2XkeMtIaxgLb7xA+zlC5H32LWFCsRebyydNXI/2VoV32/cX/Kg1R
 n6NGKWz3tVosJaVzOQqOG75auz2I7uzCCrhu6ICyg5J7Y0cDm1YB1WINV/snsZhL9Agws8ZBG
 3LodtdP71a4DnyCGn7THaeQd4bJ5q243r6GyKKuKbhxSTbKeTNzkIjww/Y1UZM93XPffjitfO
 f9q1lUgmXqAibBqVPxQW4U42YMtkuh5mQnbftJjVfHYQin/S6JpxibMjBmSifmUV31J4oWikJ
 CTFCmDNc0q2mVexFFM9j46cAfGKPSbjLbGFQbXiTvxpuumojus+RwDyEn0y/zY3jZ1J6AfJ8n
 25N8TlCrDm7mgG2ORrDflLZw2sBOz14eTW7UTiFMBUsWt+VI9IQse9oyRvbw+9gQLJoIEsq4G
 p7n1apdyFjk4AdKrk5V5eZiIiUfN/093yitxCuvKA2BCEZea+JWiHCs6Rexk30VqMHiuirR40
 VthXvq+KMXaVZrU9Wi0BZM9Ok3h0G48yvztaWN4jpQ6IXoUbzxfCqncjljfukA8Wbck6rnKyL
 OAFRblP1RCLKglDwQPvlGWmEDm6/6QKNgtyzfHM2krz5dacHnsR9A+L1/HqKYbN1FXy4REeJM
 OZYiQW4Uqqi6oa5BfKxYpyqYG2gnHRxJffMDA7YyFC3/pLdPC1Xvcua8rj25GhNiGPYmyGvuQ
 39HRloGBUqtSQHk4D/6o8hFxQJp954PpXWyPTL3qVwSEsPKY8yh+tP6TZeekUzXU1wQEdOhr1
 11OVjM7aTQayowzw79qXvlPOVN8tBpRrjoNHq+pOgnuSCNb4thSm01ijErS74q84hRyFc2o62
 aVYuLKVO2a5TqHUf+Y041GhEH4aUA8fR/KohU/y1NhFe3eNraugNR+s3zuwlNWac0uKHV6a12
 fn/pLnU18g27+0=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11.05.22 at 17:06, Jarkko Sakkinen wrote:
> On Mon, May 09, 2022 at 10:05:57AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> The interrupt handler that sets irq_tested to indicate that interrupts =
are
>> working may run on another CPU than the thread that checks this variabl=
e in
>> tmp_tis_send().
>>
>> Since no synchronization is used to access irq_tested, there is no
>> guarantee for cache coherency between the CPUs, so that the value set b=
y
>> the interrupt handler might not be visible to the testing thread.
>>
>> Avoid this issue by using a bitfield instead of a boolean variable and =
by
>> accessing this field with bit manipulating functions that guarantee cac=
he
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
>> index 4f3b82c3f205..bdfde1cd71fe 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -470,7 +470,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *=
buf, size_t len)
>>  	int rc, irq;
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>
>> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
>> +	     test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>  		return tpm_tis_send_main(chip, buf, len);
>>
>>  	/* Verify receipt of the expected IRQ */
>> @@ -480,11 +481,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8=
 *buf, size_t len)
>>  	rc =3D tpm_tis_send_main(chip, buf, len);
>>  	priv->irq =3D irq;
>>  	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>> -	if (!priv->irq_tested)
>> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>  		tpm_msleep(1);
>> -	if (!priv->irq_tested)
>> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>>  		disable_interrupts(chip);
>> -	priv->irq_tested =3D true;
>> +	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>>  	return rc;
>>  }
>>
>> @@ -689,7 +690,7 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
>>  	if (interrupt =3D=3D 0)
>>  		return IRQ_NONE;
>>
>> -	priv->irq_tested =3D true;
>> +	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>>  		wake_up_interruptible(&priv->read_queue);
>>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
>> @@ -780,7 +781,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip=
 *chip, u32 intmask,
>>  	if (rc < 0)
>>  		return rc;
>>
>> -	priv->irq_tested =3D false;
>> +	clear_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>>  	chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>>
>>  	/* Generate an interrupt by having the core call through to
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 43b724e55192..c8972ea8e13e 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -89,11 +89,15 @@ enum tpm_tis_flags {
>>  	TPM_TIS_USE_THREADED_IRQ	=3D BIT(2),
>>  };
>>
>> +enum tpm_tis_irqtest_flags {
>> +	TPM_TIS_IRQTEST_OK		=3D BIT(0),
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
>> 2.36.0
>>
>
> So, this would caused by changing to threaded IRQs?
>
> BR, Jarkko
>

No, this is caused by the fact that we access irq_tested from different pa=
ths of execution.
The writing and reading to/from irq_tested from different execution paths =
without any
synchronization is a plain bug in the existing code:
We simply cannot guarantee that the value we set for irq_tested in the int=
errupt handler
which may run on CPU 1 is visible in tpm_tis_send() which may run on CPU2.=
 This is because
there is no enforced data transfer between the CPUs and thus the written v=
alue may end up in
the CPU cache of CPU 1 and never (or at least not within the timout of 1 m=
s as used in tpm_tis_send())
be seen by CPU 2.
This kind of issues are in length described in memory-barriers.txt.

The patch is supposed to fix this bug.

Regards,
Lino
