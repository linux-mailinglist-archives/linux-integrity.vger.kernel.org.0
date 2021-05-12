Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170037B354
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 03:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhELBNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 21:13:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2706 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELBNi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 21:13:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfxXY178Bz1BLX0;
        Wed, 12 May 2021 09:09:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 09:12:27 +0800
Subject: Re: [PATCH 1/1] tpm: fix error return code in tpm2_get_cc_attrs_tbl()
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508025444.1977-1-thunder.leizhen@huawei.com>
 <YJhI+lIt4devpAoS@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b79b306a-71da-f655-3e68-11f1c9df4115@huawei.com>
Date:   Wed, 12 May 2021 09:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJhI+lIt4devpAoS@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021/5/10 4:41, Jarkko Sakkinen wrote:
> On Sat, May 08, 2021 at 10:54:44AM +0800, Zhen Lei wrote:
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function.
>>
>> Fixes: 58472f5cd4f6("tpm: validate TPM 2.0 commands")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> In the commit message:
> 
> 1. Instead of writing "a negative error code", write -EFAULT.
OK, I will change it.

> 2. Some explanation of the choice.
Do you mean why I choice error code -EFAULT? There's a similar one above this branch.

        if (nr_commands > 0xFFFFF) {
                rc = -EFAULT;
                goto out;
        }


> 
>> ---
>>  drivers/char/tpm/tpm2-cmd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index eff1f12d981a..c84d23951219 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -656,6 +656,7 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
>>  
>>  	if (nr_commands !=
>>  	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
>> +		rc = -EFAULT;
>>  		tpm_buf_destroy(&buf);
>>  		goto out;
>>  	}
>> -- 
>> 2.25.1
>>
>>
>>
> 
> Other than that looks good.
> 
> /Jarkko
> 
> .
> 

