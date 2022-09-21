Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7695BFE07
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIUMgy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 08:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIUMgx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 08:36:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942E804BE;
        Wed, 21 Sep 2022 05:36:51 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXdCN0qm9zHpvt;
        Wed, 21 Sep 2022 20:34:40 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 20:36:49 +0800
Message-ID: <5ca4120c-1443-2b07-2f17-eb71e6ba60c2@huawei.com>
Date:   Wed, 21 Sep 2022 20:36:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
References: <20220909011516.55957-1-guozihua@huawei.com>
 <20220909011516.55957-3-guozihua@huawei.com>
 <8ed58a588b80e6bcad13fa32b4fca22cbda66f38.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <8ed58a588b80e6bcad13fa32b4fca22cbda66f38.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/9/20 5:35, Mimi Zohar wrote:
> Hi Scott,
> 
>> @@ -612,6 +614,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>>   			else
>>   				return false;
>>   		}
>> +
>> +retry:
>>   		switch (i) {
>>   		case LSM_OBJ_USER:
>>   		case LSM_OBJ_ROLE:
>> @@ -631,10 +635,28 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>>   		default:
>>   			break;
>>   		}
>> -		if (!rc)
>> -			return false;
>> +
>> +		if (rc == -ESTALE) {
>> +			rule = ima_lsm_copy_rule(rule);
> 
> Re-using rule here

I'll use another variable here.
> 
>> +			if (rule) {
> 
> and here doesn't look right.

What seems to be wrong here? ima_lsm_copy_rule() returns a shallow copy 
of the rule, and NULL if the copy fails. Only if the returned rule is 
not NULL should we proceed with the retry. I used rule_reinitialized to 
memorize whether the current rule is copied so that we should free it 
later on.
> 
>> +				rule_reinitialized = true;
>> +				goto retry;
>> +			}
>> +		}
>> +		if (!rc) {
>> +			result = false;
>> +			goto out;
>> +		}
>>   	}
>> -	return true;
>> +	result = true;
>> +
>> +out:
>> +	if (rule_reinitialized) {
>> +		for (i = 0; i < MAX_LSM_RULES; i++)
>> +			ima_filter_rule_free(rule->lsm[i].rule);
>> +		kfree(rule);
>> +	}
> 
> Shouldn't freeing the memory be immediately after the retry?
> Otherwise, only the last instance of processing -ESTALE would be freed.

ima_lsm_copy_rule() would update every member of rule->lsm, and the 
retry is within the for loop on members of rule->lsm. We'd better keep 
the copied rule till the loop ends. To avoid race condition if the LSM 
rule has been updated again during the loop, I can add a guard here.
> 
>> +	return result;
>>   }
>>   
>>   /*
> 


-- 
Best
GUO Zihua
