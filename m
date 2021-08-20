Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53A3F328E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHTRzA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTRy7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 13:54:59 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28727C061575;
        Fri, 20 Aug 2021 10:54:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 6DF53AE0DB1;
        Sat, 21 Aug 2021 01:54:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BcXU23MVm0PP; Sat, 21 Aug 2021 01:54:06 +0800 (CST)
Received: from [192.168.10.13] (unknown [112.3.220.165])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id E0D9CAE0D4F;
        Sat, 21 Aug 2021 01:54:05 +0800 (CST)
Message-ID: <6d60893c-63dc-394f-d43c-9ecab7b6d06e@nfschina.com>
Date:   Sat, 21 Aug 2021 01:53:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0.1
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
Content-Language: en-US
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
 <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
 <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
From:   liqiong <liqiong@nfschina.com>
In-Reply-To: <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 2021/8/20 21:23, THOBY Simon wrote:
> Hi Liqiong,
>
> On 8/20/21 12:15 PM, 李力琼 wrote:
>> Hi, Simon:
>>
>> This solution is better then rwsem, a temp "ima_rules" variable should
>> can fix. I also have a another idea, with a little trick, default list
>> can traverse to the new list, so we don't need care about the read side.
>>
>> here is the patch:
>>
>> @@ -918,8 +918,21 @@ void ima_update_policy(void)
>>          list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
>>
>>          if (ima_rules != policy) {
>> +               struct list_head *prev_rules = ima_rules;
>> +               struct list_head *first = ima_rules->next;
>>                  ima_policy_flag = 0;
>> +
>> +               /*
>> +                * Make the previous list can traverse to new list,
>> +                * that is tricky, or there is a deadly loop whithin
>> +                * "list_for_each_entry_rcu(entry, ima_rules, list)"
>> +                *
>> +                * After update "ima_rules", restore the previous list.
>> +                */
> I think this could be rephrased to be a tad clearer, I am not quite sure
> how I must interpret the first sentence of the comment.
I got it,  how about this:
  /*
   * The previous list has to traverse to new list,
   * Or there may be a deadly loop within
   * "list_for_each_entry_rcu(entry, ima_rules, list)"
   *
   * That is tricky, after updated "ima_rules", restore the previous list.
   */
>
>
>> +               prev_rules->next = policy->next;
>>                  ima_rules = policy;
>> +               syncchronize_rcu();
> I'm a bit puzzled as you seem to imply in the mail this patch was tested,
> but there is no 'syncchronize_rcu' (with two 'c') symbol in the kernel.
> Was that a copy/paste error? Or maybe you forgot the 'not' in "This
> patch has been tested"? These errors happen, and I am myself quite an
> expert in doing them :)


Sorry for the mistake, I copy/paste the patch and delete/edit some lines,
have reviewed before sending, but not found. I have made a case to reproduce
the error, dumping "ima_rules" and every item address of list in the error
situaiton, I can watchthe "ima_rules" change, old list traversing to the 
new list.
And I have been doing a reboot test which found this bug. This patch 
seems to work fine.


>
>> +               prev_rules->next = first;
>>
>>
>> The side effect is the "ima_default_rules" will be changed a little while.
>> But it make sense, the process should be checked again by the new policy.
>>
>> This patch has been tested, if will do, I can resubmit this patch.>
>> How about this ?
>
> Correct me if I'm wrong, here is how I think I understand you patch.
> We start with a situation like that (step 0):
> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>
> Then we decide to update the policy for the first time, so
> 'ima_rules [&ima_default_rules] != policy [&ima_policy_rules]'.
> We enter the condition.
> First we copy the current value of ima_rules (&ima_default_rules)
> to a temporary variable 'prev_rules'. We also create a pointer dubbed
> 'first' to the entry 1 in the default list (step 1):
> prev_rules -------------
>                         \/
> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>                                                                     /\
> first --------------------------------------------------------------
>
>
> Then we update prev_rules->next to point to policy->next (step 2):
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>   /\
> first
> 	(notice that list entry 0 no longer points backwards to 'list entry 1',
> 	but I don't think there is any reverse iteration in IMA, so it should be
> 	safe)
>
> prev_rules -------------
>                         \/
> ima_rules --> List entry 0 (head node) = ima_default_rules
>                         |
>                         |
>                         -------------------------------------------
>                                                                   \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>
>
> We then update ima_rules to point to ima_policy_rules (step 3):
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>   /\
> first
>
> prev_rules -------------
>                         \/
> ima_rules     List entry 0 (head node) = ima_default_rules
>       |                 |
>       |                 |
>       |                 ------------------------------------------
>       ---------------                                            |
>                     \/                                           \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>                                                                     /\
> first --------------------------------------------------------------
>
> Then we run synchronize_rcu() to wait for any RCU reader to exit their loops (step 4).
>
> Finally we update prev_rules->next to point back to the ima policy and fix the loop (step 5):
>
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>   /\
> first
>
> prev_rules ---> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>                                                                       /\
>                                                                   first (now useless)
> ima_rules
>       |
>       |
>       |
>       ---------------
>                     \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>
> The goal is that readers should still be able to loop
> (forward, as we saw that backward looping is temporarily broken)
> while in steps 0-4.


Yes, It's the workflow.


> I'm not completely sure what would happen to a client that started iterating
> over ima_rules right after step 2.
>
> Wouldn't they be able to start looping through the new policy
> as 'List entry 0 (head node) = ima_default_rules' points to ima_policy_rules?
> And if they, wouldn't they loop until the write to 'ima_rule' at step 3 (admittedly
> very shortly thereafter) completed?
> And would the compiler be allowed to optimize the read to 'ima_rules' in the
> list_for_each_entry() loop, thereby never reloading the new value for
> 'ima_rules', and thus looping forever, just what we are trying to avoid?


Yes,  "ima_rules" cache not update in time, It's a risk. I am not sure 
if "WRITE_ONCE"
can do this trick. How about:
     WRITE_ONCE(prev_rules->next, policy->next);
     WRITE_ONCE(ima_rules, policy);


If can't fix the cache issue, maybe the "ima_rules_tmp" solution is the 
best way.
I will test it.


> Overall, I'm tempted to say this is perhaps a bit too complex (at least,
> my head tells me it is, but that may very well be because I'm terrible
> at concurrency issues).
>
> Honestly, in this case I think awaiting input from more experienced
> kernel devs than I is the best path forward :-)
>
>> ----------
>> Regards,
>> liqiong
>>
> Thanks,
> Simon
