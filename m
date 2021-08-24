Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9573F5DAC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhHXMLC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXMLB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 08:11:01 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B76CC061757;
        Tue, 24 Aug 2021 05:10:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 559C1AE0DBF;
        Tue, 24 Aug 2021 20:09:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bc1O8ZkHRKm7; Tue, 24 Aug 2021 20:09:24 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 8F3EDAE058B;
        Tue, 24 Aug 2021 20:09:23 +0800 (CST)
Subject: Re: [PATCH] ima: fix deadlock within "ima_match_policy" function.
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
 <20210824085747.23604-1-liqiong@nfschina.com>
 <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
Date:   Tue, 24 Aug 2021 20:09:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon :

ima: fix deadlock within RCU list of ima_rules.

ima_match_policy() is looping on the policy ruleset while
ima_update_policy() updates the variable "ima_rules". This can
lead to a situation where ima_match_policy() can't exit the
'list_for_each_entry_rcu' loop, causing RCU stalls
("rcu_sched detected stall on CPU ...").

This problem can happen in practice: updating the IMA policy
in the boot process while systemd-services are being checked.

In addition to ima_match_policy(), other function with 
"list_for_each_entry_rcu" should happen too. Fix locking by 
introducing a duplicate of "ima_rules" for each 
"list_for_each_entry_rcu".


How about this commit message ?

I have tested this patch in lab, we can reproduced this error case, 
have done reboot test many times. This patch should work. 


在 2021年08月24日 17:50, THOBY Simon 写道:
> Hi liqiong,
>
> On 8/24/21 10:57 AM, liqiong wrote:
>> When "ima_match_policy" is looping while "ima_update_policy" changs
> Small typo: "changes"/"updates"
>
>> the variable "ima_rules", then "ima_match_policy" may can't exit
>> loop, Finally cause RCU CPU Stall Warnings: "rcu_sched detected
>> stall on CPU ...".
> This could perhaps be rephrased to something like:
> """
> ima_match_policy() can loop on the policy ruleset while
> ima_update_policy() updates the variable "ima_rules".
> This can lead to a situation where ima_match_policy()
> can't exit the 'list_for_each_entry_rcu' loop, causing
> RCU stalls ("rcu_sched detected stall on CPU ...").
> """
>
>
>> The problem is limited to transitioning from the builtin policy to
>> the custom policy. Eg. At boot time, systemd-services are being
>> checked within "ima_match_policy", at the same time, the variable
>> "ima_rules" is changed by another service.
> For the second sentence, consider something in the likes of:
> "This problem can happen in practice: updating the IMA policy
> in the boot process while systemd-services are being checked
> have been observed to trigger this issue.".
>
>
> Your commit message is also supposed to explain what you are doing,
> using the imperative form ((see 'Documentation/process/submitting-patches.rst'):
> """
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.
> """
>
> Maybe add a paragraph with something like "Fix locking by introducing ...."?
>
>
>> Signed-off-by: liqiong <liqiong@nfschina.com>
>> ---
>>  security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fd5d46e511f1..e92b197bfd3c 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -662,12 +662,14 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>>  {
>>  	struct ima_rule_entry *entry;
>>  	int action = 0, actmask = flags | (flags << 1);
>> +	struct list_head *ima_rules_tmp;
>>  
>>  	if (template_desc && !*template_desc)
>>  		*template_desc = ima_template_desc_current();
>>  
>>  	rcu_read_lock();
>> -	list_for_each_entry_rcu(entry, ima_rules, list) {
>> +	ima_rules_tmp = rcu_dereference(ima_rules);
>> +	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
>>  
>>  		if (!(entry->action & actmask))
>>  			continue;
>> @@ -919,8 +921,8 @@ void ima_update_policy(void)
>>  
>>  	if (ima_rules != policy) {
>>  		ima_policy_flag = 0;
>> -		ima_rules = policy;
>>  
>> +		rcu_assign_pointer(ima_rules, policy);
>>  		/*
>>  		 * IMA architecture specific policy rules are specified
>>  		 * as strings and converted to an array of ima_entry_rules
>> @@ -1649,9 +1651,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
>>  {
>>  	loff_t l = *pos;
>>  	struct ima_rule_entry *entry;
>> +	struct list_head *ima_rules_tmp;
>>  
>>  	rcu_read_lock();
>> -	list_for_each_entry_rcu(entry, ima_rules, list) {
>> +	ima_rules_tmp = rcu_dereference(ima_rules);
>> +	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
>>  		if (!l--) {
>>  			rcu_read_unlock();
>>  			return entry;
>> @@ -1670,7 +1674,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
>>  	rcu_read_unlock();
>>  	(*pos)++;
>>  
>> -	return (&entry->list == ima_rules) ? NULL : entry;
>> +	return (&entry->list == &ima_default_rules ||
>> +		&entry->list == &ima_policy_rules) ? NULL : entry;
>>  }
>>  
>>  void ima_policy_stop(struct seq_file *m, void *v)
>> @@ -1872,6 +1877,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
>>  	struct ima_rule_entry *entry;
>>  	bool found = false;
>>  	enum ima_hooks func;
>> +	struct list_head *ima_rules_tmp;
>>  
>>  	if (id >= READING_MAX_ID)
>>  		return false;
>> @@ -1879,7 +1885,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
>>  	func = read_idmap[id] ?: FILE_CHECK;
>>  
>>  	rcu_read_lock();
>> -	list_for_each_entry_rcu(entry, ima_rules, list) {
>> +	ima_rules_tmp = rcu_dereference(ima_rules);
>> +	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
>>  		if (entry->action != APPRAISE)
>>  			continue;
>>  
>>
> I haven't tested the patch myself, but the code diff looks fine to me.
>
> Thanks,
> Simon

