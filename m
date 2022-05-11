Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69977523D48
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiEKTTJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiEKTTI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:19:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF50541A4;
        Wed, 11 May 2022 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652296720;
        bh=K6++BUf6/YdegjM4BnlUkF76z9/6nIa57i654gYKFwg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T/woSgcwitQUDyi8m4Ah7EDL3k3Q+Da+10SEgWnWKh0sUA4JgpT1SklBMUrgS/7Px
         D8gxGmYgirxBrzSJ8pBPm9iU0UrHIJnVkzAtZMabpyF+jK4TiGtpvbM8seF6PSrBPZ
         UBe83135XoH85ioxAGAsWB3ytCNWp6ovdMl8AmYI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.12]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1nfpJf2fN1-00AoPq; Wed, 11
 May 2022 21:18:40 +0200
Subject: Re: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-2-LinoSanfilippo@gmx.de> <YnucgDH3I87RI8PN@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <486cec01-ec02-3f11-0b81-037e0700c503@gmx.de>
Date:   Wed, 11 May 2022 21:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnucgDH3I87RI8PN@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:isOjDfYGs9rj3rFvgoSSlcdFwtYl/xB/3PYo10NFQYguhcBoORe
 rkmEuS2ylsl5mRo+Vp03AnDvbURnm3Q7SO2594DDENp1KR1+oTibJb0s3puEH2UKmWNUu1J
 Lirp/k8iiPUnCf7X9f5QUROUHVOza7iI5YODuONcBJFxSdQHZukvOlah+wDnrA3z7Mq0SAa
 od/sdOY1JmIRocXlY2jzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eXJ1qHVv3nk=:5OO9LtosDPQb1K80uv70Ef
 YEsYh9g6UjN+uADMLSvoDT+VwB16Z+EwFH/UahyHi/ChD78thsWhK59tuOWTYkenmHFveeRAf
 1vGERV/WrqM+P9aC1fjiMK2/kDFsJJd1hyOixMCeJM6dGG9yP9jixTtPJICROX5SP6E9g6HcC
 J06v1jO2PlbE6k3/14sXptP1cxOKZ2CyaeeTBXNEmhwiu1bPsFN3gIGjwk8385vgGsQxVLeKr
 OJ6RWqyWhXcEYizXaS1sDSoy3Vex4OTLST+sRBATXh0gdPB4IiXrljDPRWKz5C/t4ZCZ7/WV8
 xnFNssFzfY0nYBiw7kZEr0mAc309gP5cInbE2hMAc2rPUIyJSlkXNf1SOxUA1im7PQSRJANNn
 kRLF0f8UYnOdsFxFXrQgRua46SCg/dusqokrDFUjRxjkCEmckrr0VshRgyeflKqXSG5HsTE9W
 0+0LDDXxS1vFkMCAfdbfdXCJrzd/ZfZEI4jjn2d2zYA/Vti3ez+umr36d2914eU5P++Cwh9S8
 /G6Xff5LJOPXbFIQPIxOOSXAeWr1uTkuFWVHFcOLLlBQh0uIjldidSpgC3l6sZW8xBomy9Qoe
 lAvU1S4IxYtlobUG1ka8TLQxoNHCkoSQNrCDjif2sNLeGif/HgY4lFoR4QTx1KfLvDURn3mY/
 BwUKjcSRsLD6c3zFYeUE9LX7XXeb7jRansOl6fJWrmB1YAGker961WpgRlfc1tTMuA9JoKg3z
 0QRr9ZU8ktCs4ivu2dl/67RN/qctcqZlnErhBNJgfmIXM6fqMWeDfe/PwsSdflXBYfOv4iJp5
 syNNomr7GnHJnedANJCij6gSDE/qTLcCLssB4raNH/MJArQ8tAebQ6zZriBepfeDZ6zAqBck6
 RU9UxA44U8SMJ+McQE0pG+pmZwIrOEIGwlcz/kociGfCQJx/AkZGjWMtjevE83LEZFgsHAI3c
 7gscEcuHW1p7JqwqK8n9Szqf2IZxcHFb9CbfEw0lNyw4tsUVwbXFZafYlssQlbhGDFgrJEHbn
 gS9EwEtQayq0Ro00BW/IzyRPAMftWZpcL0/qxjRLDeHnHPT9TEfmayvSWYlVVMKQgvC2200UX
 1+DYY8txEaT5Ag=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11.05.22 at 13:22, Jarkko Sakkinen wrote:
> On Mon, May 09, 2022 at 10:05:54AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Interrupt handling at least includes reading and writing the interrupt
>> status register within the interrupt routine. Since accesses over the S=
PI
>> bus are synchronized by a mutex, request a threaded interrupt handler t=
o
>> ensure a sleepable context during interrupt processing.
>>
>> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver"=
)
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> When you state that it needs a sleepable context, you should bring a
> context why it needs it. This not to disregard the code change overally =
but
> you cannot make even the most obvious claim without backing data.
>

so what kind of backing data do you have in mind? Would it help to emphasi=
ze more
that the irq handler is running in hard irq context in the current code an=
d thus
must not access registers over SPI since SPI uses a mutex (I consider it a=
s basic
knowledge that a mutex must not be taken in hard irq context)?


Regards,
Lino


>> ---
>>  drivers/char/tpm/tpm_tis_core.c     | 15 +++++++++++++--
>>  drivers/char/tpm/tpm_tis_core.h     |  1 +
>>  drivers/char/tpm/tpm_tis_spi_main.c |  5 +++--
>>  3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index dc56b976d816..52369ef39b03 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -747,8 +747,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chi=
p *chip, u32 intmask,
>>  	int rc;
>>  	u32 int_status;
>>
>> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
>> -			     dev_name(&chip->dev), chip) !=3D 0) {
>> +
>> +	if (priv->flags & TPM_TIS_USE_THREADED_IRQ) {
>> +		rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>> +					       tis_int_handler,
>> +					       IRQF_ONESHOT | flags,
>> +					       dev_name(&chip->dev),
>> +					       chip);
>> +	} else {
>> +		rc =3D devm_request_irq(chip->dev.parent, irq, tis_int_handler,
>> +				      flags, dev_name(&chip->dev), chip);
>> +	}
>> +
>> +	if (rc) {
>>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
>>  			 irq);
>>  		return -1;
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 3be24f221e32..43b724e55192 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -86,6 +86,7 @@ enum tis_defaults {
>>  enum tpm_tis_flags {
>>  	TPM_TIS_ITPM_WORKAROUND		=3D BIT(0),
>>  	TPM_TIS_INVALID_STATUS		=3D BIT(1),
>> +	TPM_TIS_USE_THREADED_IRQ	=3D BIT(2),
>>  };
>>
>>  struct tpm_tis_data {
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm=
_tis_spi_main.c
>> index 184396b3af50..f56613f2946f 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -223,9 +223,10 @@ static int tpm_tis_spi_probe(struct spi_device *de=
v)
>>  	phy->flow_control =3D tpm_tis_spi_flow_control;
>>
>>  	/* If the SPI device has an IRQ then use that */
>> -	if (dev->irq > 0)
>> +	if (dev->irq > 0) {
>>  		irq =3D dev->irq;
>> -	else
>> +		phy->priv.flags |=3D TPM_TIS_USE_THREADED_IRQ;
>> +	} else
>>  		irq =3D -1;
>>
>>  	init_completion(&phy->ready);
>> --
>> 2.36.0
>>
>
>
> BR, Jarkko
>

