Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367AF38BB0C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 02:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhEUAyY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 20:54:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4775 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhEUAyY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 20:54:24 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmSfw4ZrWzqVHV;
        Fri, 21 May 2021 08:49:28 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 08:52:59 +0800
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 08:52:59 +0800
Subject: Re: [PATCH v3] char: tpm: move to use request_irq by IRQF_NO_AUTOEN
 flag
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>
References: <1621406999-16816-1-git-send-email-tiantao6@hisilicon.com>
 <YKaPdtwAG+IgAZZO@kernel.org>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <22af90d0-347b-9caf-5941-a966d03f8fcc@huawei.com>
Date:   Fri, 21 May 2021 08:52:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YKaPdtwAG+IgAZZO@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


ÔÚ 2021/5/21 0:33, Jarkko Sakkinen Ð´µÀ:
> On Wed, May 19, 2021 at 02:49:59PM +0800, Tian Tao wrote:
>> disable_irq() after request_irq() still has a time gap in which
>> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
>> disable IRQ auto-enable because of requesting.
>>
>> Link: https://lore.kernel.org/patchwork/patch/1388765/
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>> v2: add the Link.
>> v3: put sob last.
>> ---
>>   drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> index f19c227..44dde2f 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> @@ -706,14 +706,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
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
> How does this differ from
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=da2f0c7b46171175ab54da248752b1139c42fee4
> ?
There is no difference, except that this patch was not merged into 5.12, 
so it was resent once in 5.13
> /Jarkko
> .
>

