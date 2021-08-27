Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F33F96AE
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbhH0JMJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbhH0JL7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 05:11:59 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45C02C061757;
        Fri, 27 Aug 2021 02:11:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 2CA2FAE0DE1;
        Fri, 27 Aug 2021 17:10:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I55RfApHpAp4; Fri, 27 Aug 2021 17:09:49 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id D5F44AE0DB0;
        Fri, 27 Aug 2021 17:09:48 +0800 (CST)
Subject: Re: [PATCH] ima: fix deadlock within RCU list of ima_rules
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Mimi Zohar <zohar@linux.ibm.com>
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
 <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
 <2c4f61ff68544b2627fc4a38ad1e4109184ec68a.camel@linux.ibm.com>
 <d502623a-7a49-04f8-1672-6521ceef260b@nfschina.com>
 <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
 <eb9921ff-2d4b-136f-b7a7-924e61a0651b@viveris.fr>
 <1e464ae0-28e1-6511-ab89-52b5cd1a0841@nfschina.com>
 <3ef6906b-ccf1-0ab8-180b-b71568e22443@viveris.fr>
 <bd52af5b-6c69-73a1-e0b2-8d23f3d8db3a@nfschina.com>
 <caa4955e-04d9-d3f8-cccb-5f78bd554c55@viveris.fr>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <266c50d0-1efd-dc45-d11f-e8c91bfc8490@nfschina.com>
Date:   Fri, 27 Aug 2021 17:10:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <caa4955e-04d9-d3f8-cccb-5f78bd554c55@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

Thanks for your patient, i learn a lot. If the commit message
does work, i would resubmit the patch.  Here is the whole patch:


The current IMA ruleset is identified by the variable "ima_rules"
that default to "&ima_default_rules". When loading a custom policy
for the first time, the variable is updated to "&ima_policy_rules"
instead. That update isn't RCU-safe, and deadlocks are possible.
Indeed, some functions like ima_match_policy() may loop indefinitely
when traversing "ima_default_rules" with list_for_each_entry_rcu().

When iterating over the default ruleset back to head, if the list
head is "ima_default_rules", and "ima_rules" have been updated to
"&ima_policy_rules", the loop condition (&entry->list != ima_rules)
stays always true, traversing won't terminate, causing a soft lockup
and RCU stalls.

Introduce a temporary value for "ima_rules" when iterating over
the ruleset to avoid the deadlocks.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..e92b197bfd3c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -662,12 +662,14 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
+	struct list_head *ima_rules_tmp;
 
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
 			continue;
@@ -919,8 +921,8 @@ void ima_update_policy(void)
 
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
-		ima_rules = policy;
 
+		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -1649,9 +1651,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (!l--) {
 			rcu_read_unlock();
 			return entry;
@@ -1670,7 +1674,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == &ima_default_rules ||
+		&entry->list == &ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -1872,6 +1877,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
+	struct list_head *ima_rules_tmp;
 
 	if (id >= READING_MAX_ID)
 		return false;
@@ -1879,7 +1885,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
 

-- 
2.11.0


在 2021年08月27日 15:30, THOBY Simon 写道:

> Hi liqiong,
>
> a few nits but nothing significant. This is getting in good shape!
>
> On 8/27/21 8:41 AM, liqiong wrote:
>> Hi Simon,
>>
>> Thanks for you help, i may got it, here is the new commit message:
>>
>>
>> The current IMA ruleset is identified by the variable "ima_rules"
>> that default to "&ima_default_rules". When loading a custom policy
>> for the first time, the variable is updated to "&ima_policy_rules"
>> instead. That update isn't RCU-safe, and deadlocks are possible.
>> Because some functions like ima_match_policy() may loop indefinitely
> s/Because/Indeed,/ (in english, sentences with a subordinating conjunction
> like 'because' are usually written in two parts, and a dependent clause
> standing by itself is rarely used except for stylistic effect)
>
>> over traversing the "ima_default_rules" as list_for_each_entry_rcu().
> s/over traversing the "ima_default_rules" as list_for_each_entry_rcu()/when traversing "ima_default_rules" with list_for_each_entry_rcu()./
>
>> When iterating over the default ruleset back to head, value of
>> "&entry->list" is "&ima_default_rules", and "ima_rules" may have been
> s/value of "&entry->list" is "&ima_default_rules"/if the list head is "ima_default_rules"/
> s/may have been/have been/
>
>> updated to "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
>> stay alway true, traversing doesn't terminate, cause soft lockup and
> Don't forget the 's' in "stays" (or "remains")
> Ditto for "always"
> s/traversing doesn't/traversing won't/
> Also: s/cause/causing a/
>
>> RCU stalls.
>>
>> Introduce a temporary value for "ima_rules" when iterating over
>> the ruleset to avoid the deadlocks.
>>
>>
>> Signed-off-by: liqiong <liqiong@nfschina.com>
>> ---
>>  security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fd5d46e511f1..e92b197bfd3c 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>>
>>
>> Thanks
>>
>> liqiong
>>
> Thanks,
> Simon

