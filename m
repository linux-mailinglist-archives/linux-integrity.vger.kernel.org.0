Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1E4D92D9
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Mar 2022 04:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbiCODMo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Mar 2022 23:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiCODMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Mar 2022 23:12:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DF48324;
        Mon, 14 Mar 2022 20:11:32 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KHdgc0z6DzfZ1w;
        Tue, 15 Mar 2022 11:10:04 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 11:11:30 +0800
Message-ID: <489ef3a4-2f9b-f773-f6bf-90199f995e67@huawei.com>
Date:   Tue, 15 Mar 2022 11:11:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <wangweiyang2@huawei.com>,
        <xiujianfeng@huawei.com>, <weiyongjun1@huawei.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
References: <20220307104827.40843-1-guozihua@huawei.com>
 <YiYMgnpnf3Y6l8IY@iki.fi> <aa1b89b5-d13e-3dc8-ec2c-62823ea10021@huawei.com>
 <22e6a4b4b01a219282e4da6a941eaad68897841f.camel@kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <22e6a4b4b01a219282e4da6a941eaad68897841f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/3/12 0:34, Jarkko Sakkinen wrote:
> On Thu, 2022-03-10 at 11:33 +0800, Guozihua (Scott) wrote:
>>
>>
>> On 2022/3/7 21:45, Jarkko Sakkinen wrote:
>>> On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
>>>> Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
>>>> call put_device on error, while tpm->devs is left untouched. Call
>>>> put_device on tpm->devs as well if devm_add_action_or_reset returns an
>>>> error.
>>>>
>>>> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
>>>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>>>> ---
>>>>    drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>>> index b009e7479b70..0a92334e8c40 100644
>>>> --- a/drivers/char/tpm/tpm-chip.c
>>>> +++ b/drivers/char/tpm/tpm-chip.c
>>>> @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
>>>>          return 0;
>>>>    }
>>>>    
>>>> +static void tpm_chip_free(struct tpm_chip *chip)
>>>> +{
>>>> +       put_device(&chip->devs);
>>>> +       put_device(&chip->dev);
>>>> +}
>>>> +
>>>>    /**
>>>>     * tpm_chip_alloc() - allocate a new struct tpm_chip instance
>>>>     * @pdev: device to which the chip is associated
>>>> @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>>>          return chip;
>>>>    
>>>>    out:
>>>> -       put_device(&chip->devs);
>>>> -       put_device(&chip->dev);
>>>> +       tpm_chip_free(chip);
>>>>          return ERR_PTR(rc);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(tpm_chip_alloc);
>>>> @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>>>>                  return chip;
>>>>    
>>>>          rc = devm_add_action_or_reset(pdev,
>>>> -                                     (void (*)(void *)) put_device,
>>>> -                                     &chip->dev);
>>>> +                                     (void (*)(void *)) tpm_chip_free,
>>>> +                                     chip);
>>>>          if (rc)
>>>>                  return ERR_PTR(rc);
>>>>    
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>> Please test against the latest in
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>>>
>>> and share your results.
>>>
>>> BR, Jarkko
>>> .
>>
>> Hi Jarkko,
>>
>> I'll do that. Do we have a test set for TPM? Or do we just build and run
>> it and see if everything works as expected?
>>
>> This is an error handling optimization BTW.
> 
> There is kselftest in tools/testing/kselftes/tpm2 that you can use
> but do not have to.
> 
> BR, Jarkko
> 
> 

Hi Jarkko,

The code on the master branch on 
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git 
seems to be quite different from what I saw on linux upstream. Namely 
tpm_chip->devs does not exist on linux-tpmdd. Has this member been deleted?

-- 
Best
GUO Zihua
