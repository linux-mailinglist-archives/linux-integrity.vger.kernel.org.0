Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7874D925A
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Mar 2022 02:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbiCOB42 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Mar 2022 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOB41 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Mar 2022 21:56:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F35F5D;
        Mon, 14 Mar 2022 18:55:17 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHbyz2H8Gz921M;
        Tue, 15 Mar 2022 09:53:15 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 09:55:07 +0800
Message-ID: <bd3219cc-9258-096e-3e28-e81eb0e695b8@huawei.com>
Date:   Tue, 15 Mar 2022 09:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>, <wangweiyang2@huawei.com>,
        <xiujianfeng@huawei.com>, <weiyongjun1@huawei.com>,
        <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220307104827.40843-1-guozihua@huawei.com>
 <20220314163705.GA64706@ziepe.ca>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <20220314163705.GA64706@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/3/15 0:37, Jason Gunthorpe wrote:
> On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
>> Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
>> call put_device on error, while tpm->devs is left untouched. Call
>> put_device on tpm->devs as well if devm_add_action_or_reset returns an
>> error.
>>
>> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>>   drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index b009e7479b70..0a92334e8c40 100644
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
>>   	return 0;
>>   }
>>   
>> +static void tpm_chip_free(struct tpm_chip *chip)
>> +{
>> +	put_device(&chip->devs);
>> +	put_device(&chip->dev);
>> +}
>> +
>>   /**
>>    * tpm_chip_alloc() - allocate a new struct tpm_chip instance
>>    * @pdev: device to which the chip is associated
>> @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>   	return chip;
>>   
>>   out:
>> -	put_device(&chip->devs);
>> -	put_device(&chip->dev);
>> +	tpm_chip_free(chip);
>>   	return ERR_PTR(rc);
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_chip_alloc);
>> @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>>   		return chip;
>>   
>>   	rc = devm_add_action_or_reset(pdev,
>> -				      (void (*)(void *)) put_device,
>> -				      &chip->dev);
>> +				      (void (*)(void *)) tpm_chip_free,
>> +				      chip);
>>   	if (rc)
> 
> This looks like the same issue as was adressed by the recent discussion..
> 
> Jason
> .

Hi Jason,

Would you mind refer me to the discussion?

-- 
Best
GUO Zihua
