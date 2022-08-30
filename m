Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4F5A5E5D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiH3ImC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiH3ImA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 04:42:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BAB72AB
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 01:41:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH1155xw3zlWXV;
        Tue, 30 Aug 2022 16:38:33 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 16:41:56 +0800
Message-ID: <2ad8179d-9ed6-b0f4-7b8d-e47b3de70b26@huawei.com>
Date:   Tue, 30 Aug 2022 16:41:56 +0800
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
 <61bc81bc-1b4a-3c08-6232-afc0d04decee@huawei.com>
 <886d4588b9b6ab4e7dd903addf9809898defd6d9.camel@linux.ibm.com>
 <d967a934-ba41-1a6d-4dcb-26d715b941b2@huawei.com>
 <9da1b1ab4a0e75f717c78ff44d985318a955ccd7.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <9da1b1ab4a0e75f717c78ff44d985318a955ccd7.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/8/30 9:20, Mimi Zohar wrote:
> On Sat, 2022-08-27 at 17:57 +0800, Guozihua (Scott) wrote:
>> On 2022/8/25 21:02, Mimi Zohar wrote:
>>> On Wed, 2022-08-24 at 09:56 +0800, Guozihua (Scott) wrote:
>>>> On 2022/8/24 9:26, Mimi Zohar wrote:
>>>>> On Tue, 2022-08-23 at 21:28 +0800, Guozihua (Scott) wrote:
>>>>>> On 2022/8/23 21:21, Mimi Zohar wrote:
>>>>>>> On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
>>>>>>>>> The question is whether we're waiting for the SELinux policy to change
>>>>>>>>> from ESTALE or whether it is the number of SELinux based IMA policy
>>>>>>>>> rules or some combination of the two.  Retrying three times seems to be
>>>>>>>>> random.  If SELinux waited for ESTALE to change, then it would only be
>>>>>>>>> dependent on the time it took to update the SELinux based IMA policy
>>>>>>>>> rules.
>>>>>>>>
>>>>>>>> We are waiting for ima_lsm_update_rules() to finish re-initializing all
>>>>>>>> the LSM based rules.
>>>>>>>
>>>>>>> Fine.  Hopefully retrying a maximum of 3 times is sufficient.
>>>>>>>
>>>>>> Well, at least this should greatly reduce the chance of this issue from
>>>>>> happening.
>>>>>
>>>>> Agreed
>>>>>
>>>>>> This would be the best we I can think of without locking and
>>>>>> busy waiting. Maybe we can also add delays before we retry. Maybe you
>>>>>> got any other thought in mind?
>>>>>
>>>>> Another option would be to re-introduce the equivalent of the "lazy"
>>>>> LSM update on -ESTALE, but without updating the policy rule, as the
>>>>> notifier callback will eventually get to it.
>>>>>
>>>>
>>>> For this to happen we would need a way to tell when we are able to
>>>> continue with the retry though.
>>>
>>> Previously with the lazy update, on failure security_filter_rule_init()
>>> was called before the retry.  To avoid locking or detecting when to
>>> continue, another option would be to call to
>>> security_filter_rule_init() with a local copy of the rule.  The retry
>>> would be based on a local copy of the rule.
>>>
>>> Eventually the registered callback will complete, so we don't need to
>>> be concerned about updating the actual rules.
>>
>> Is it possible to cause race condition though? With this, the notifier
>> path seems to be unnecessary.
> 
> I don't see how there would be a race condition.  The notifier callback
> is the normal method of updating the policy rules.  Hopefully -ESTALE
> isn't something that happens frequently.

The notifier callback uses RCU to update rules, I think we should mimic 
that behavior if we are to update individual rules in the matching logic.

-- 
Best
GUO Zihua
