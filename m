Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8532F3F7482
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHYLqq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYLqq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 07:46:46 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E505BC061757;
        Wed, 25 Aug 2021 04:45:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 9AD0AAE0DC7;
        Wed, 25 Aug 2021 19:45:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bZVhb-isVgmc; Wed, 25 Aug 2021 19:44:56 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 6768FAE0D1B;
        Wed, 25 Aug 2021 19:44:56 +0800 (CST)
Subject: Re: [PATCH] ima: fix deadlock within RCU list of ima_rules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
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
From:   liqiong <liqiong@nfschina.com>
Message-ID: <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
Date:   Wed, 25 Aug 2021 19:45:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d502623a-7a49-04f8-1672-6521ceef260b@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

This copy may be better.


subject: ima: fix deadlock when iterating over the init "ima_rules" list.



When traversing back to head, the init "ima_rules" list can't exit
iterating if "ima_rules" has been updated to "ima_policy_rules".
It causes soft lockup and RCU stalls. So we can introduce a duplicate
of "ima_rules" for each "ima_rules" list loop.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 This problem can happen in practice: updating the IMA policy
 in the boot process while systemd-services are being checked.

 security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..e92b197bfd3c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c


Regards,

liqiong



在 2021年08月25日 15:05, liqiong 写道:
> Hi Mimi,
>
> Thanks for the advice，maybe i should trim the message,
> here is a new copy:
>
>
> subject: ima: fix deadlock when iterating over the init "ima_rules" list.
>
> The init "ima_rules" list can't traverse back to head, if "ima_rules"
> is being updated to "ima_policy_rules". It causes soft lockup and RCU stalls.
> So we can introduce a duplicate of "ima_rules" for each "ima_rules" list loop.
>
> Signed-off-by: liqiong <liqiong@nfschina.com>
> ---
>  This problem can happen in practice: updating the IMA policy
>  in the boot process while systemd-services are being checked.
>
>  security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd5d46e511f1..e92b197bfd3c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
>
>
> Regards,
>
> liqiong
>
> 在 2021年08月24日 20:38, Mimi Zohar 写道:
>> On Tue, 2021-08-24 at 20:09 +0800, liqiong wrote:
>>> Hi Simon :
>>>
>>> ima: fix deadlock within RCU list of ima_rules.
>>>
>> Before the following paragraph, an introductory sentence is needed. 
>> Try adding a sentence to the affect that "ima_rules" initially points
>> to the "ima_default_rules", but after loading a custom policy points to
>> the "ima_policy_rules".   Then describe the bug at a high level,
>> something like - transitioning to the "ima_policy_rules" isn't being
>> done safely.
>>
>> Followed by the details.
>>
>>> ima_match_policy() is looping on the policy ruleset while
>>> ima_update_policy() updates the variable "ima_rules". This can
>>> lead to a situation where ima_match_policy() can't exit the
>>> 'list_for_each_entry_rcu' loop, causing RCU stalls
>>> ("rcu_sched detected stall on CPU ...").
>>>
>>> This problem can happen in practice: updating the IMA policy
>>> in the boot process while systemd-services are being checked.
>>>
>>> In addition to ima_match_policy(), other function with 
>>> "list_for_each_entry_rcu" should happen too. Fix locking by 
>>> introducing a duplicate of "ima_rules" for each 
>>> "list_for_each_entry_rcu".
>>>
>>>
>>> How about this commit message ?
>>>
>>> I have tested this patch in lab, we can reproduced this error case, 
>>> have done reboot test many times. This patch should work. 
>> The above comment doesn't belong in the commit message, but is a
>> message to the reviewers/maintainers and goes after the patch
>> descriptions three dashes line.
>>
>> thanks,
>>
>> Mimi
>>
>>
>

