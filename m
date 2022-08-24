Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7659F127
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiHXB4H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHXB4G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 21:56:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AEF6566C
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 18:56:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MC8Hj3h0jzlWJd;
        Wed, 24 Aug 2022 09:52:49 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 09:56:03 +0800
Message-ID: <61bc81bc-1b4a-3c08-6232-afc0d04decee@huawei.com>
Date:   Wed, 24 Aug 2022 09:56:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
 <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
 <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
 <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
 <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
 <dc34912b2bad1c46f249fb6e2aa2c79e26890699.camel@linux.ibm.com>
 <6cd55a0f-366f-45b7-d0e5-4116de454c10@huawei.com>
 <117476d4f35be96ddba26675b849af44a5dbd6d1.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <117476d4f35be96ddba26675b849af44a5dbd6d1.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/8/24 9:26, Mimi Zohar wrote:
> On Tue, 2022-08-23 at 21:28 +0800, Guozihua (Scott) wrote:
>> On 2022/8/23 21:21, Mimi Zohar wrote:
>>> On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
>>>>> The question is whether we're waiting for the SELinux policy to change
>>>>> from ESTALE or whether it is the number of SELinux based IMA policy
>>>>> rules or some combination of the two.  Retrying three times seems to be
>>>>> random.  If SELinux waited for ESTALE to change, then it would only be
>>>>> dependent on the time it took to update the SELinux based IMA policy
>>>>> rules.
>>>>
>>>> We are waiting for ima_lsm_update_rules() to finish re-initializing all
>>>> the LSM based rules.
>>>
>>> Fine.  Hopefully retrying a maximum of 3 times is sufficient.
>>>
>> Well, at least this should greatly reduce the chance of this issue from
>> happening.
> 
> Agreed
> 
>> This would be the best we I can think of without locking and
>> busy waiting. Maybe we can also add delays before we retry. Maybe you
>> got any other thought in mind?
> 
> Another option would be to re-introduce the equivalent of the "lazy"
> LSM update on -ESTALE, but without updating the policy rule, as the
> notifier callback will eventually get to it.
> 

For this to happen we would need a way to tell when we are able to 
continue with the retry though.

-- 
Best
GUO Zihua
