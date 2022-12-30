Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACC659596
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Dec 2022 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiL3HF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Dec 2022 02:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3HF5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Dec 2022 02:05:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629D18B2C
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 23:05:56 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Njx8L5ybQzbc8W;
        Fri, 30 Dec 2022 15:04:34 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 15:05:54 +0800
Message-ID: <a13ba825-fd4b-75ef-d279-17e0840d1135@huawei.com>
Date:   Fri, 30 Dec 2022 15:05:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ima: Handle error code from security_audit_rule_match
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>
CC:     <linux-integrity@vger.kernel.org>
References: <20221227014633.4449-1-guozihua@huawei.com>
 <537bd46f8392c031e2792ef50b5e73bf9aa2f875.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <537bd46f8392c031e2792ef50b5e73bf9aa2f875.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/12/27 19:22, Mimi Zohar wrote:
> On Tue, 2022-12-27 at 09:46 +0800, GUO Zihua wrote:
>> commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
>> ima_filter_rule_match()") introduced the handling of -ESTALE returned by
>> security_audit_rule_match(). However, security_audit_rule_match() might
>> return other error codes if some error occurred. We should handle those
>> error codes as well.
>>
>> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>  security/integrity/ima/ima_policy.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 6a68ec270822..5561e1b2c376 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -663,7 +663,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>>  			break;
>>  		}
>>  
>> -		if (rc == -ESTALE && !rule_reinitialized) {
>> +		if (rc < 0 && !rule_reinitialized) {
> 
> Which other error codes are resolved by retrying?
Well I re-checked security_audit_rule_match() and it seems that only
-ESTALE can be handled. This patch could be ignored.
> 
>>  			lsm_rule = ima_lsm_copy_rule(rule);
>>  			if (lsm_rule) {
>>  				rule_reinitialized = true;
> 

-- 
Best
GUO Zihua

