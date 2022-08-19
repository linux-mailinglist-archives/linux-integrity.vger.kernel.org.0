Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535DC5992CB
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Aug 2022 03:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiHSBuY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Aug 2022 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbiHSBuV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Aug 2022 21:50:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A260D7D04
        for <linux-integrity@vger.kernel.org>; Thu, 18 Aug 2022 18:50:20 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M84PC2RhRz1N7LL;
        Fri, 19 Aug 2022 09:46:55 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 09:50:18 +0800
Message-ID: <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
Date:   Fri, 19 Aug 2022 09:50:18 +0800
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
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/8/18 21:43, Mimi Zohar wrote:
> Hi Scott,
> 
> On Thu, 2022-08-18 at 10:05 +0800, GUO Zihua wrote:
>> IMA relies on lsm policy update notifier to be notified when it should
>> update it's lsm rules.
> 
> ^IMA relies on the blocking LSM policy notifier callback to update the
> LSM based IMA policy rules.

I'll fix this in the next version.
> 
>> When SELinux update it's policies, ima would be notified and starts
>> updating all its lsm rules one-by-one. During this time, -ESTALE would
>> be returned by ima_filter_rule_match() if it is called with a lsm rule
>> that has not yet been updated. In ima_match_rules(), -ESTALE is not
>> handled, and the lsm rule is considered a match, causing extra files
>> be measured by IMA.
>>
>> Fix it by retrying for at most three times if -ESTALE is returned by
>> ima_filter_rule_match().
> 
> With the lazy LSM policy update, retrying only once was needed.  With
> the blocking LSM notifier callback, why is three times needed?  Is this
> really a function of how long it takes IMA to walk and update ALL the
> LSM based IMA policy rules?  Would having SELinux wait for the -ESTALE
> to change do anything?

With lazy policy update, policy update is triggered and would be 
finished before retrying. However, with a notifier callback, the update 
runs in a different process which might introduce extra latency. 
Technically if one rule has been updated, any following rules would have 
been updated at the time they are read as well, thus the retry should 
happen on the first rule affected by SELinux policy update only. 
Retrying for three times here would leave some time for the notifier to 
finish it's job on updating the rules.
>>
>> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> thanks,
> 
> Mimi
> 
> .


-- 
Best
GUO Zihua
