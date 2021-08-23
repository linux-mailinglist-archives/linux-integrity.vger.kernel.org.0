Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC40B3F4B2D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhHWM5y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhHWM5y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 08:57:54 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5B57C061575;
        Mon, 23 Aug 2021 05:57:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id B9F30AE0DA2;
        Mon, 23 Aug 2021 20:56:51 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TjcJYbOzOmnU; Mon, 23 Aug 2021 20:56:33 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id B7245AE0DBF;
        Mon, 23 Aug 2021 20:56:32 +0800 (CST)
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
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
 <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
 <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
 <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
 <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
 <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
 <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
 <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <0a30bfdf-4f51-fd2a-d32c-bb9f8c2de72c@nfschina.com>
Date:   Mon, 23 Aug 2021 20:56:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon :

在 2021年08月23日 16:14, THOBY Simon 写道:
> Hi Liqiong,
>
> On 8/23/21 10:06 AM, liqiong wrote:
>> Hi Simon :
>>
>> Using a temporary ima_rules variable is not working for "ima_policy_next". 
>>
>>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
>>  {
>>  	struct ima_rule_entry *entry = v;
>> -
>> +	struct list_head *ima_rules_tmp = rcu_dereference(ima_rules);
>>  	rcu_read_lock();
>>  	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
>>  	rcu_read_unlock();
>>  	(*pos)++;
>>  
>> -	return (&entry->list == ima_rules) ? NULL : entry;
>> +	return (&entry->list == ima_rules_tmp) ? NULL : entry;
>>  }
>>
>> It seems no way to fix "ima_rules" change within this function, it will alway
>> return a entry if "ima_rules" being changed.
> - I think rcu_dereference() should be called inside the RCU read lock
> - Maybe we could cheat with:
> 	return (&entry->list == &ima_policy_rules || &entry->list == &ima_default_rules) ? NULL : entry;
>   as that's the only two rulesets IMA ever use?
>   Admittedly, this is not as clean as previously, but it should work too.
>
> The way I see it, the semaphore solution would not work here either,
> as ima_policy_next() is called repeatedly as a seq_file
> (it is set up in ima_fs.c) and we can't control the locking there:
> we cannot lock across the seq_read() call (that cure could end up be
> worse than the disease, deadlock-wise), so I fear we cannot protect
> against a list update while a user is iterating with a lock.
>
> So in both cases a cheat like "&entry->list == &ima_policy_rules || &entry->list == &ima_default_rules"
> maybe need to be considered.
>
> What do you think?

Yes,  semaphore solution not work here,  splicing two list is a little complex.
This solution is  simple and clear,  should  work.  I will work on that, test and 
confirm  the patch. 

"rcu_dereference() should be called inside the RCU read lock", I will correct this.

Thanks for your help.


Regrads,

liqiong

>
>
>> Regrads,
>>
>> liqiong
> Thanks,
> Simon

