Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE059D63E
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Aug 2022 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiHWI1L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbiHWIY6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 04:24:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D126DC
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 01:13:30 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBhhv1Rdsz1N7Vd;
        Tue, 23 Aug 2022 16:09:35 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 16:12:29 +0800
Message-ID: <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
Date:   Tue, 23 Aug 2022 16:12:29 +0800
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
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/8/22 22:41, Mimi Zohar wrote:
> On Fri, 2022-08-19 at 09:50 +0800, Guozihua (Scott) wrote:
>> On 2022/8/18 21:43, Mimi Zohar wrote:
>>> Hi Scott,
>>>
>>> On Thu, 2022-08-18 at 10:05 +0800, GUO Zihua wrote:
>>>> IMA relies on lsm policy update notifier to be notified when it should
>>>> update it's lsm rules.
>>>
>>> ^IMA relies on the blocking LSM policy notifier callback to update the
>>> LSM based IMA policy rules.
>>
>> I'll fix this in the next version.
> 
> Thanks.
> 
>>>
>>>> When SELinux update it's policies, ima would be notified and starts
>>>> updating all its lsm rules one-by-one. During this time, -ESTALE would
>>>> be returned by ima_filter_rule_match() if it is called with a lsm rule
>>>> that has not yet been updated. In ima_match_rules(), -ESTALE is not
>>>> handled, and the lsm rule is considered a match, causing extra files
>>>> be measured by IMA.
>>>>
>>>> Fix it by retrying for at most three times if -ESTALE is returned by
>>>> ima_filter_rule_match().
>>>
>>> With the lazy LSM policy update, retrying only once was needed.  With
>>> the blocking LSM notifier callback, why is three times needed?  Is this
>>> really a function of how long it takes IMA to walk and update ALL the
>>> LSM based IMA policy rules?  Would having SELinux wait for the -ESTALE
>>> to change do anything?
>>
>> With lazy policy update, policy update is triggered and would be
>> finished before retrying. However, with a notifier callback, the update
>> runs in a different process which might introduce extra latency.
>> Technically if one rule has been updated, any following rules would have
>> been updated at the time they are read as well, thus the retry should
>> happen on the first rule affected by SELinux policy update only.
>> Retrying for three times here would leave some time for the notifier to
>> finish it's job on updating the rules.
> 
> The question is whether we're waiting for the SELinux policy to change
> from ESTALE or whether it is the number of SELinux based IMA policy
> rules or some combination of the two.  Retrying three times seems to be
> random.  If SELinux waited for ESTALE to change, then it would only be
> dependent on the time it took to update the SELinux based IMA policy
> rules.

We are waiting for ima_lsm_update_rules() to finish re-initializing all 
the LSM based rules.

Once new policy takes effect in SELinux, the policy sequence number 
would be incremented. During rule match, this sequence number is checked 
and if mismatched, -ESTALE is returned and the rules should be 
re-initialized. Normally during this time, ima_lsm_update_rules should 
be running already, so we are going to wait for it to finish.
> 
> thanks,
> 
> Mimi
> 
>>>>
>>>> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
>>>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> .


-- 
Best
GUO Zihua
