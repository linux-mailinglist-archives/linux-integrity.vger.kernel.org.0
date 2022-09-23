Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584355E729E
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 06:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIWECA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIWEB7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 00:01:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E3ADCDD;
        Thu, 22 Sep 2022 21:01:56 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYdgX3Sp1zpVFS;
        Fri, 23 Sep 2022 11:59:04 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:01:55 +0800
Message-ID: <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
Date:   Fri, 23 Sep 2022 12:01:54 +0800
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
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/9/22 19:09, Mimi Zohar wrote:
> Hi Scott,
> 
> On Wed, 2022-09-21 at 20:58 +0800, GUO Zihua wrote:
>>                  }
>> -               if (!rc)
>> -                       return false;
>> +
>> +               if (rc == -ESTALE && !rule_reinitialized) {
> 
> Ok, this limits allocating ima_lsm_copy_rule() to the first -ESTALE,
> 
>> +                       lsm_rule = ima_lsm_copy_rule(rule);
>> +                       if (lsm_rule) {
>> +                               rule_reinitialized = true;
>> +                               goto retry;
> 
> but "retry" is also limited to the first -ESTALE.

Technically we would only need one retry. This loop is looping on all 
the lsm members of one rule, and ima_lsm_copy_rule would update all the 
lsm members of this rule. The "lsm member" here refers to LSM defined 
properties like obj_user, obj_role etc. These members are of AND 
relation, meaning all lsm members together would form one LSM rule.

As of the scenario you mentioned, I think it should be really rare. 
Spending to much time and code on this might not worth it.
> 
>> +                       }
>> +               }
>> +               if (!rc) {
>> +                       result = false;
>> +                       goto out;
>> +               }
>>          }
>> -       return true;
>> +       result = true;
>> +
>> +out:
>> +       if (rule_reinitialized) {
>> +               for (i = 0; i < MAX_LSM_RULES; i++)
>> +                       ima_filter_rule_free(lsm_rule->lsm[i].rule);
>> +               kfree(lsm_rule);
>> +       }
>> +       return result;
>>   }
> 


-- 
Best
GUO Zihua
