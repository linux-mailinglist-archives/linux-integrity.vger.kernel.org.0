Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EAD33FC68
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Mar 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRAvC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 20:51:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14366 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCRAul (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 20:50:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F17gf2JZxz8ypN;
        Thu, 18 Mar 2021 08:48:46 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 08:50:29 +0800
Subject: Re: [PATCH] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>
References: <1615971586-21039-1-git-send-email-tiantao6@hisilicon.com>
 <YFJtcUzj6SGRRgq9@kernel.org>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <32fee14a-1b53-2833-b0b8-0532fc62620e@huawei.com>
Date:   Thu, 18 Mar 2021 08:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YFJtcUzj6SGRRgq9@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


ÔÚ 2021/3/18 4:58, Jarkko Sakkinen Ð´µÀ:
> On Wed, Mar 17, 2021 at 04:59:46PM +0800, Tian Tao wrote:
>> disable_irq() after request_irq() still has a time gap in which
>> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
>> disable IRQ auto-enable because of requesting.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Is this a new feature?
yes £¬you can see cbe16f35bee6880becca6f20d2ebf6b457148552 genirq: Add 
IRQF_NO_AUTOEN for request_irq/nmi()
> What would be great is a "Link:" tag to the patch set if it is fairly
> recent (i.e. lore.kernel.org link).
>
> /Jarkko
>
>> ---
>>   drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> index ec9a65e..25299e5 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> @@ -705,14 +705,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
>>   
>>   	if (client->irq > 0) {
>>   		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
>> -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
>> +				      IRQF_NO_AUTOEN,
>>   				      dev->driver->name, chip);
>>   		if (rc < 0) {
>>   			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
>>   			return rc;
>>   		}
>>   
>> -		disable_irq(client->irq);
>>   		priv->irq = client->irq;
>>   	} else {
>>   		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
>> -- 
>> 2.7.4
>>
>>
> .
>

