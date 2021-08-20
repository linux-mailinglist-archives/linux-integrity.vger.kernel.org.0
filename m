Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6463F29F7
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhHTKQY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 06:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhHTKQY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 06:16:24 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 088E7C061575;
        Fri, 20 Aug 2021 03:15:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id A7D22AE0DB1;
        Fri, 20 Aug 2021 18:15:55 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lDbXKbdjmBrI; Fri, 20 Aug 2021 18:15:34 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 2638CAE0DD4;
        Fri, 20 Aug 2021 18:15:34 +0800 (CST)
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
From:   =?UTF-8?B?5p2O5Yqb55C8?= <liqiong@nfschina.com>
Message-ID: <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
Date:   Fri, 20 Aug 2021 18:15:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Simon:

This solution is better then rwsem, a temp "ima_rules" variable should 
can fix. I also have a another idea, with a little trick, default list
can traverse to the new list, so we don't need care about the read side. 

here is the patch:

@@ -918,8 +918,21 @@ void ima_update_policy(void)
        list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);

        if (ima_rules != policy) {
+               struct list_head *prev_rules = ima_rules;
+               struct list_head *first = ima_rules->next;
                ima_policy_flag = 0;
+
+               /*
+                * Make the previous list can traverse to new list,
+                * that is tricky, or there is a deadly loop whithin
+                * "list_for_each_entry_rcu(entry, ima_rules, list)"
+                *
+                * After update "ima_rules", restore the previous list.
+                */
+               prev_rules->next = policy->next;
                ima_rules = policy;
+               syncchronize_rcu();
+               prev_rules->next = first;


The side effect is the "ima_default_rules" will be changed a little while.
But it make sense, the process should be checked again by the new policy.

This patch has been tested, if will do, I can resubmit this patch.

How about this ?

----------
Regards,
liqiong

在 2021年08月19日 20:58, THOBY Simon 写道:
> Hi Liqiong,
>
> On 8/19/21 12:15 PM, liqiong wrote:
>> When "ima_match_policy" is looping while "ima_update_policy" changs
>> the variable "ima_rules", then "ima_match_policy" may can't exit loop,
>> and kernel keeps printf "rcu_sched detected stall on CPU ...".
>>
>> It occurs at boot phase, systemd-services are being checked within
>> "ima_match_policy,at the same time, the variable "ima_rules"
>> is changed by a service.
> First off, thanks for finding and identifying this nasty bug.
>
>> Signed-off-by: liqiong <liqiong@nfschina.com>
>> ---
>>  security/integrity/ima/ima_policy.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fd5d46e511f1..7e71e643457c 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -217,6 +217,7 @@ static LIST_HEAD(ima_default_rules);
>>  static LIST_HEAD(ima_policy_rules);
>>  static LIST_HEAD(ima_temp_rules);
>>  static struct list_head *ima_rules = &ima_default_rules;
>> +static DECLARE_RWSEM(ima_rules_sem);
>>  
>>  static int ima_policy __initdata;
>>  
>> @@ -666,6 +667,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>>  	if (template_desc && !*template_desc)
>>  		*template_desc = ima_template_desc_current();
>>  
>> +	down_read(&ima_rules_sem);
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(entry, ima_rules, list) {
>>  
>> @@ -702,6 +704,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>>  			break;
>>  	}
>>  	rcu_read_unlock();
>> +	up_read(&ima_rules_sem);
>>  
>>  	return action;
>>  }
>> @@ -919,7 +922,9 @@ void ima_update_policy(void)
>>  
>>  	if (ima_rules != policy) {
>>  		ima_policy_flag = 0;
>> +		down_write(&ima_rules_sem);
>>  		ima_rules = policy;
>> +		up_write(&ima_rules_sem);
>>  
>>  		/*
>>  		 * IMA architecture specific policy rules are specified
>>
> Rather than introducing a new semaphore, I wonder if you couldn't have done something
> like the following?
>
> @@ -674,13 +674,15 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>                      const char *func_data, unsigned int *allowed_algos)
>  {
>         struct ima_rule_entry *entry;
> +       struct list_head *ima_rules_tmp;
>         int action = 0, actmask = flags | (flags << 1);
>
>         if (template_desc && !*template_desc)
>                 *template_desc = ima_template_desc_current();
>
>         rcu_read_lock();
> -       list_for_each_entry_rcu(entry, ima_rules, list) {
> +       ima_rules_tmp = rcu_dereference(ima_rules);
> +       list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
>
>                 if (!(entry->action & actmask))
>                         continue;
> @@ -970,7 +972,7 @@ void ima_update_policy(void)
>
>         if (ima_rules != policy) {
>                 ima_policy_flag = 0;
> -               ima_rules = policy;
> +               rcu_assign_pointer(ima_rules, policy);
>
>                 /*
>                  * IMA architecture specific policy rules are specified
>
>
> Also, ima_match_policy is not the only place where we iterate over ima_rules, maybe
> this change should be applied to every function that perform a call the like of
> "list_for_each_entry_rcu(entry, ima_rules_tmp, list)" ?
>
> All that being said, your change is quite small and I have no objection to it,
> I was just wondering whether we could achieve the same effect without locks
> with RCU.
>
> What do you think?
>
> Thanks,
> Simon

-- 
李力琼<liqiong@nfschina.com>  13524287433
上海市浦东新区海科路99号中科院上海高等研究院3号楼3楼

