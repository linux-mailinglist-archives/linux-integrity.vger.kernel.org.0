Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840515E88AC
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Sep 2022 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiIXGFd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Sep 2022 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiIXGFc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Sep 2022 02:05:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9421242;
        Fri, 23 Sep 2022 23:05:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZJL05Tz2zWh0d;
        Sat, 24 Sep 2022 14:01:12 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 14:05:12 +0800
Message-ID: <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
Date:   Sat, 24 Sep 2022 14:05:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
References: <20220921125804.59490-1-guozihua@huawei.com>
 <20220921125804.59490-3-guozihua@huawei.com>
 <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
 <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
 <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/9/23 19:19, Mimi Zohar wrote:
> On Fri, 2022-09-23 at 12:01 +0800, Guozihua (Scott) wrote:
>> On 2022/9/22 19:09, Mimi Zohar wrote:
>>> Hi Scott,
>>>
>>> On Wed, 2022-09-21 at 20:58 +0800, GUO Zihua wrote:
>>>>                   }
>>>> -               if (!rc)
>>>> -                       return false;
>>>> +
>>>> +               if (rc == -ESTALE && !rule_reinitialized) {
>>>
>>> Ok, this limits allocating ima_lsm_copy_rule() to the first -ESTALE,
>>>
>>>> +                       lsm_rule = ima_lsm_copy_rule(rule);
>>>> +                       if (lsm_rule) {
>>>> +                               rule_reinitialized = true;
>>>> +                               goto retry;
>>>
>>> but "retry" is also limited to the first -ESTALE.
>>
>> Technically we would only need one retry. This loop is looping on all
>> the lsm members of one rule, and ima_lsm_copy_rule would update all the
>> lsm members of this rule. The "lsm member" here refers to LSM defined
>> properties like obj_user, obj_role etc. These members are of AND
>> relation, meaning all lsm members together would form one LSM rule.
>>
>> As of the scenario you mentioned, I think it should be really rare.
>> Spending to much time and code on this might not worth it.
>>>
>>>> +                       }
>>>> +               }
> 
> Either there can be multiple LSM fields and the memory is allocated
> once and freed once at the end, as you suggested, or the memory should
> be freed here and rule_reinitialized reset, minimizing the code change.

I might have overlooked something, but if I understands the code 
correctly, we would be copying the same rule over and over again till 
the loop ends in that case. ima_lsm_update_rule() would replace the rule 
node on the rule list without updating the rule in place. Although 
synchronize_rcu() should prevent a UAF, the rule in ima_match_rules() 
would not be updated. Meaning SELinux would always return -ESTALE before 
we copy and retry as we keep passing in the outdated rule entry.
> 
>>>> +               if (!rc) {
>>>> +                       result = false;
>>>> +                       goto out;
>>>> +               }
>>>>           }
>>>> -       return true;
>>>> +       result = true;
>>>> +
>>>> +out:
>>>> +       if (rule_reinitialized) {
>>>> +               for (i = 0; i < MAX_LSM_RULES; i++)
>>>> +                       ima_filter_rule_free(lsm_rule->lsm[i].rule);
>>>> +               kfree(lsm_rule);
>>>> +       }
>>>> +       return result;
>>>>    }
> 


-- 
Best
GUO Zihua
