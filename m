Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC37732B300
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Mar 2021 04:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhCCBTw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Mar 2021 20:19:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13031 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378363AbhCBBFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 20:05:42 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqJlG4Vp7zMgM3;
        Tue,  2 Mar 2021 09:02:50 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Mar 2021
 09:04:53 +0800
Subject: [PATCH v9 9/9] certs: Add support for using elliptic curve keys for
 signing modules
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <patrick@puiterwijk.org>,
        <linux-integrity@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
 <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
 <8618fdb7107ec6ec1aeb4e37faf82421050bdf91.camel@linux.ibm.com>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <f49f8d88-d7c1-3a78-115f-07b93d2eb160@huawei.com>
Date:   Tue, 2 Mar 2021 09:04:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <8618fdb7107ec6ec1aeb4e37faf82421050bdf91.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



在 2021/3/1 21:11, Mimi Zohar 写道:
> On Sat, 2021-02-27 at 11:35 +0800, yumeng wrote:
>> 在 2021/2/26 0:08, Stefan Berger 写道:
>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>
>>> diff --git a/certs/Makefile b/certs/Makefile
>>> index 3fe6b73786fa..c487d7021c54 100644
>>> --- a/certs/Makefile
>>> +++ b/certs/Makefile
>>> @@ -69,6 +69,18 @@ else
>>>    SIGNER = -signkey $(obj)/signing_key.key
>>>    endif # CONFIG_IMA_APPRAISE_MODSIG
>>>    
>>
>> Is there anything wrong in this patch?
>> I can't apply it when I use 'git am '.
>> errors like below:
>>
>> error: certs/Kconfig: does not match index
>> error: patch failed: certs/Makefile:69
>> error: certs/Makefile: patch does not apply
>>
>> Thanks
> 
> Nothing wrong with the patch, just a dependency.  From the Change log:
>     - This patch builds on top Nayna's series for 'kernel build support
>     for loading the kernel module signing key'.
>     - https://lkml.org/lkml/2021/2/18/856
> 
> thanks,
> 
> Mimi
> 
> 

OK, thank you. Sorry for the noise.
