Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1C3F4662
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhHWIHr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhHWIHo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 04:07:44 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FB54C061756;
        Mon, 23 Aug 2021 01:07:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 68F21AE0DBF;
        Mon, 23 Aug 2021 16:06:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CqDcqiuiH_Vo; Mon, 23 Aug 2021 16:06:24 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 33F56AE0DA2;
        Mon, 23 Aug 2021 16:06:24 +0800 (CST)
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   liqiong <liqiong@nfschina.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
 <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
 <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
 <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
 <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
Message-ID: <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
Date:   Mon, 23 Aug 2021 16:06:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon :

Using a temporary ima_rules variable is not working for "ima_policy_next". 

 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ima_rule_entry *entry = v;
-
+	struct list_head *ima_rules_tmp = rcu_dereference(ima_rules);
 	rcu_read_lock();
 	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == ima_rules_tmp) ? NULL : entry;
 }

It seems no way to fix "ima_rules" change within this function, it will alway
return a entry if "ima_rules" being changed.

Regrads,

liqiong



在 2021年08月23日 11:04, 李力琼 写道:
> Hi Mimi :
>
> The situation is a little different,'list_splice_init_rcu'
> don't change the list head. If "ima_rules" being changed,
> readers may can't reload the new value in time for cpu cache
> or compiler optimization. Defining "ima_rules" as a volatile 
> variable can fix, but It is inefficient.
>
> Maybe using a temporary ima_rules variable for every 
> "list_for_each_entry_rcu(entry, ima_rules, list)" loop is 
> a better solution to fix the "endless loop" bug. 
>
> Regards,
>
> liqiong
>
> 在 2021年08月20日 23:48, Mimi Zohar 写道:
>> On Fri, 2021-08-20 at 13:23 +0000, THOBY Simon wrote:
>>> Hi Liqiong,
>>>
>>> On 8/20/21 12:15 PM, 李力琼 wrote:
>>>> Hi, Simon:
>>>>
>>>> This solution is better then rwsem, a temp "ima_rules" variable should 
>>>> can fix. I also have a another idea, with a little trick, default list
>>>> can traverse to the new list, so we don't need care about the read side. 
>>>>
>>>> here is the patch:
>>>>
>>>> @@ -918,8 +918,21 @@ void ima_update_policy(void)
>>>>         list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
>>>>
>>>>         if (ima_rules != policy) {
>>>> +               struct list_head *prev_rules = ima_rules;
>>>> +               struct list_head *first = ima_rules->next;
>>>>                 ima_policy_flag = 0;
>>>> +
>>>> +               /*
>>>> +                * Make the previous list can traverse to new list,
>>>> +                * that is tricky, or there is a deadly loop whithin
>>>> +                * "list_for_each_entry_rcu(entry, ima_rules, list)"
>>>> +                *
>>>> +                * After update "ima_rules", restore the previous list.
>>>> +                */
>>> I think this could be rephrased to be a tad clearer, I am not quite sure
>>> how I must interpret the first sentence of the comment.
>>>
>>>
>>>> +               prev_rules->next = policy->next;
>>>>                 ima_rules = policy;
>>>> +               syncchronize_rcu();
>>> I'm a bit puzzled as you seem to imply in the mail this patch was tested,
>>> but there is no 'syncchronize_rcu' (with two 'c') symbol in the kernel.
>>> Was that a copy/paste error? Or maybe you forgot the 'not' in "This
>>> patch has been tested"? These errors happen, and I am myself quite an
>>> expert in doing them :)
>>>
>>>> +               prev_rules->next = first;
>>>>
>>>>
>>>> The side effect is the "ima_default_rules" will be changed a little while.
>>>> But it make sense, the process should be checked again by the new policy.
>>>>
>>>> This patch has been tested, if will do, I can resubmit this patch.> 
>>>> How about this ?
>>> least
>>>
>>> Correct me if I'm wrong, here is how I think I understand you patch.
>>> We start with a situation like that (step 0):
>>> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>>>
>>> Then we decide to update the policy for the first time, so
>>> 'ima_rules [&ima_default_rules] != policy [&ima_policy_rules]'.
>>> We enter the condition.
>>> First we copy the current value of ima_rules (&ima_default_rules)
>>> to a temporary variable 'prev_rules'. We also create a pointer dubbed
>>> 'first' to the entry 1 in the default list (step 1):
>>> prev_rules -------------
>>>                        \/
>>> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>>>                                                                    /\
>>> first --------------------------------------------------------------
>>>
>>>
>>> Then we update prev_rules->next to point to policy->next (step 2):
>>> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>>>  /\
>>> first
>>> 	(notice that list entry 0 no longer points backwards to 'list entry 1',
>>> 	but I don't think there is any reverse iteration in IMA, so it should be
>>> 	safe)
>>>
>>> prev_rules -------------
>>>                        \/
>>> ima_rules --> List entry 0 (head node) = ima_default_rules   
>>>                        |
>>>                        |
>>>                        -------------------------------------------
>>>                                                                  \/
>>> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>>>
>>>
>>> We then update ima_rules to point to ima_policy_rules (step 3):
>>> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>>>  /\
>>> first
>>>
>>> prev_rules -------------
>>>                        \/
>>> ima_rules     List entry 0 (head node) = ima_default_rules   
>>>      |                 |
>>>      |                 |
>>>      |                 ------------------------------------------
>>>      ---------------                                            |
>>>                    \/                                           \/
>>> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>>>                                                   synchronize_rcu                 /\
>>> first --------------------------------------------------------------
>>>
>>> Then we run synchronize_rcu() to wait for any RCU reader to exit their loops (step 4).
>>>
>>> Finally we update prev_rules->next to point back to the ima policy and fix the loop (step 5):
>>>
>>> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>>>  /\
>>> first
>>>
>>> prev_rules ---> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>>>                                                                      /\
>>>                                                                  first (now useless)
>>> ima_rules        
>>>      |
>>>      |
>>>      |
>>>      ---------------
>>>                    \/
>>> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>>>
>>> The goal is that readers should still be able to loop
>>> (forward, as we saw that backward looping is temporarily broken)
>>> while in steps 0-4.
>>>
>>> I'm not completely sure what would happen to a client that started iterating
>>> over ima_rules right after step 2.
>>>
>>> Wouldn't they be able to start looping through the new policy
>>> as 'List entry 0 (head node) = ima_default_rules' points to ima_policy_rules?
>>> And if they, wouldn't they loop until the write to 'ima_rule' at step 3 (admittedly
>>> very shortly thereafter) completed?
>>> And would the compiler be allowed to optimize the read to 'ima_rules' in the
>>> list_for_each_entry() loop, thereby never reloading the new value for
>>> 'ima_rules', and thus looping forever, just what we are trying to avoid?
>>>
>>> Overall, I'm tempted to say this is perhaps a bit too complex (at least,
>>> my head tells me it is, but that may very well be because I'm terrible
>>> at concurrency issues).
>>>
>>> Honestly, in this case I think awaiting input from more experienced
>>> kernel devs than I is the best path forward :-)
>> I'm far from an expert on RCU locking, but __list_splice_init_rcu()
>> provides an example of how to make sure there aren't any readers
>> traversing the list, before two lists are spliced together.   In our
>> case, after there aren't any readers, instead of splicing two lists
>> together, it should be safe to point to the new list.
>>
>> thanks,
>>
>> Mimi
>>

