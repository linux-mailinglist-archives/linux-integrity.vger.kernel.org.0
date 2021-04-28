Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362CB36E1CC
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhD1Win (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 18:38:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:33045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhD1Wim (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 18:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619649462;
        bh=7lUAX4Vgd7j9+ARRccRvC/EruImvMWRCxOk8mt6CLi8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IRGNDKwKJ/X4fNK+GOWqz9oXsA/DgGCL2v8y4W5+ma6rpadPt+QFcUkJBHqHBlo0D
         gXDwK7x5r2MFK2NaDBnTeIIoAIVnqjsGMTKOi/Z5PY22kYP8xk6/j41GcpiJjl28vC
         5cJ+tTeTLwwlKMvqKLWm6fFn1jf12vuOqc5Kt5NM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1m5mQ51BYV-00YvKK; Thu, 29
 Apr 2021 00:37:42 +0200
Subject: Re: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
 <YIikDCTBcMMxjots@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <495e816a-afba-4ea0-560c-bc748df26337@gmx.de>
Date:   Thu, 29 Apr 2021 00:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIikDCTBcMMxjots@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VRjLLgx1jMPG5HHqpGMzBJHdHG6JdqBiP+7diHvO2FfohPbpOyv
 zLzpt1Y9FKbY3S0DHIKZyO7qsY6Vbdt08wfJON7VltJFJCZ40fwPWOPPcmRXGbpHEwS8vbh
 1t3/s27OouD/qQdlFk4Y4R9S0omxbgnV8qhtNtXPlKDeTLSSAKGCm+OSZh1OibCQcYgc7DL
 1X3I/zD1Y5cV9GUxzc1cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JMTQeTgh6nA=:/1JolsotzXliCXPpmkxh9b
 H7g4STFEX5ZioVWP6VvNt4BbxwIQPbDh9vQrwBmYNg+N+aRv7GMZrFCRkRDuPZZuOGC98/+i3
 uQErDulMpjVptdGzOQhtvCgNRKrBs1VQQ3a4nF+LKZ3WDF2AdmYbrXr3wbmkwulUQEy1wzKYj
 mq41kverx0Wg3xTF5OF3oWOpxS8CACvdDrWXI4yZuP9rdwSmG0TFzrZekBWUuh+7xYHCtY/M7
 rGOz4pYCANnPMtCHLRNyzfu2G9kIQmUxMVgG66hwZY1VFQJX5aXBsj4rpYIhKSH8QJEqQFM55
 JACJehG4dCRfpMlcX3XXjWUFXVvTE+tJ+c/S3jzRFKfWvKB5NdkyFVcZGsZFjFdidYo2Qx6c/
 R+LkUudMb9295awf7L0oIES7HwuhjMnL5MoqaNR0ympdu8TFHM1ZNCA4Yy17PJLKIwh0+3f7U
 CdGmzQDzWU4Q4U3txeYEZ9dJPtypXGcdbPGNqww7NEiBrNVevQgn+1aX/BTR1UxXxvUUUCGJL
 zOD4HK744YE3zD48CapWnxUofdhJ04CrufBloWXqFGjADUJr6rqQgeEvPURW+Xuc6PlC6Irry
 2GS/gDJAtglcMF9sc5ULiF9B7Kk31xr+la+WqdGk8Tz3wesWZBNfBKn4JRVvZeHmblevAoZoF
 2OP4EUjKeLjaQSzRE4vglUT+RH27ti5LtFgbLtlata6vx4K2/Iz5FH2V3xojKcDMXsqWr6UDh
 35k1GffRx05w8VRQEF3y00TAiDK4Nze/b1IrGz+76351j5qOLF8UByPX0Ua3nHBifybWtEglE
 m1+vOCcJ1DNFiNdCqpZhF46FGLNCji4gc9G7ZWUvlNPsbmL4vVslZ25lGemH9i+IQ5xees9IO
 3UWBNnLHHbzLOPssAn29KnVliTiDLkl66n8NWQoHFL7r6Y2i+LOn16ZJ3W7fpMud4wR2HjGL9
 eTzs9DPDu0EyP2z0R+ZwQY2Mi5tPmgBQQZbhv/fxIcbFuctvYhtQMakSGzDv9miTsfMJ+qcj1
 znSDfSCngnXfLW3jWMlHTcSCZoXrp+ZZm4T5nUJiR4O/Hhe5UykE17l4HPVB0qDIT6Wq+Pex2
 IMX1fkY8a4bswO0cgp7pHetFBSLuCG9XzkM355h/xtX295LwGmLUgn4h/cOgrUFia49lRRWhw
 Lg0wFdQcBbTTN+XkOIGUFVpVJt491YGyEMVKqrBuG3E+7e7GYUiKW3mjVvy5aS9hWNkXCgnYp
 Kdy7GpiVXu2XcZBV4
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 28.04.21 at 01:53, Jarkko Sakkinen wrote:
> On Mon, Apr 26, 2021 at 01:47:17AM +0200, Lino Sanfilippo wrote:
>> Interrupt handling at least includes reading and writing the interrupt
>> status register from the interrupt routine. However over SPI those acce=
sses
>> require a sleepable context, since a mutex is used in the concerning
>> functions.
>> For this reason request a threaded interrupt handler which is running i=
n
>> (sleepable) process context.
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index e7d1eab..0959559 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -781,8 +781,10 @@ static int tpm_tis_probe_irq_single(struct tpm_chi=
p *chip, u32 intmask,
>>  	int rc;
>>  	u32 int_status;
>>
>> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
>> -			     dev_name(&chip->dev), chip) !=3D 0) {
>> +
>> +	if (devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>> +				      tis_int_handler, IRQF_ONESHOT | flags,
>> +				      dev_name(&chip->dev), chip) !=3D 0) {
>>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
>>  			 irq);
>>  		return -1;
>> --
>> 2.7.4
>>
>
> Why?
>
> https://elixir.bootlin.com/linux/v5.12/source/drivers/char/tpm/tpm_tis_c=
ore.c#L670
>
> I don't see anything that sleeps there.
>
> /Jarkko1
>

The problem are the register read/write functions which we use to access t=
he status register in
the interrupt handler. In case of SPI they result in taking the spi_bus_lo=
ck which is a mutex.

E.g tpm_tis_spi_read32: tpm_tis_spi_read_bytes->tpm_tis_spi_transfer->spi_=
bus_lock->mutex_lock

Using a threaded interrupt handler seemed to me the easiest way to avoid t=
his issue.

Regards,
Lino


