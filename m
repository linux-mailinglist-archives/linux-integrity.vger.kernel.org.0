Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E55399A9E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCG2x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 02:28:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3396 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFCG2w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 02:28:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FwbS91VT8z67mC;
        Thu,  3 Jun 2021 14:23:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 14:27:06 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 14:27:06 +0800
Subject: Re: [PATCH 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210601064507.9989-1-thunder.leizhen@huawei.com>
 <20210601175728.gyi3yepdtvu4hald@kernel.org>
 <277d929b-0602-ffbb-5866-64731a19ff14@huawei.com>
 <20210603052954.ms7s4cmkejpxo2lc@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <427a9ec1-a841-e42a-0970-81f2a890db1f@huawei.com>
Date:   Thu, 3 Jun 2021 14:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210603052954.ms7s4cmkejpxo2lc@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021/6/3 13:29, Jarkko Sakkinen wrote:
> On Wed, Jun 02, 2021 at 09:11:47AM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/6/2 1:57, Jarkko Sakkinen wrote:
>>> On Tue, Jun 01, 2021 at 02:45:07PM +0800, Zhen Lei wrote:
>>>> No functional change.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> No change, no need to apply?
>>
>> But it can make the code look simpler, easier to read and maintain(The start
>> address does not need to appear twice). I think that's why these DEFINE_RES_*
>> macros are defined.
>>
>> By the way, would it be better to change the letters in 0xFED40000 to lowercase?
> 
> I mean "No functional change" does not really tell anything about anything.
> 
> Please just describe what the commit does.

I'm sorry to have misunderstood your intention. OK, I rewrite the commit message.

> 
> /Jarkko
> 
>>
>>>
>>> /Jarkko
>>>
>>>> ---
>>>>  drivers/char/tpm/tpm_tis.c | 6 +-----
>>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>>>> index 4ed6e660273a414..d3f2e5364c275f4 100644
>>>> --- a/drivers/char/tpm/tpm_tis.c
>>>> +++ b/drivers/char/tpm/tpm_tis.c
>>>> @@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
>>>>  {
>>>>  	struct platform_device *pdev;
>>>>  	static const struct resource x86_resources[] = {
>>>> -		{
>>>> -			.start = 0xFED40000,
>>>> -			.end = 0xFED40000 + TIS_MEM_LEN - 1,
>>>> -			.flags = IORESOURCE_MEM,
>>>> -		},
>>>> +		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
>>>>  	};
>>>>  
>>>>  	if (!force)
>>>> -- 
>>>> 2.26.0.106.g9fadedd
>>>>
>>>>
>>>>
>>>
>>> .
>>>
>>
>>
> 
> .
> 

