Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B03F9476
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhH0GnH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 02:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhH0GnG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 02:43:06 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 047E3C061757;
        Thu, 26 Aug 2021 23:42:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id EC8AAAE0DCB;
        Fri, 27 Aug 2021 14:41:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bonB99NEQbAx; Fri, 27 Aug 2021 14:40:58 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id CFABBAE0DB0;
        Fri, 27 Aug 2021 14:40:57 +0800 (CST)
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
From:   liqiong <liqiong@nfschina.com>
Message-ID: <bd52af5b-6c69-73a1-e0b2-8d23f3d8db3a@nfschina.com>
Date:   Fri, 27 Aug 2021 14:41:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3ef6906b-ccf1-0ab8-180b-b71568e22443@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

Thanks for you help, i may got it, here is the new commit message:


The current IMA ruleset is identified by the variable "ima_rules"
that default to "&ima_default_rules". When loading a custom policy
for the first time, the variable is updated to "&ima_policy_rules"
instead. That update isn't RCU-safe, and deadlocks are possible.
Because some functions like ima_match_policy() may loop indefinitely
over traversing the "ima_default_rules" as list_for_each_entry_rcu().

When iterating over the default ruleset back to head, value of
"&entry->list" is "&ima_default_rules", and "ima_rules" may have been
updated to "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
stay alway true, traversing doesn't terminate, cause soft lockup and
RCU stalls.

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


Thanks

liqiong

在 2021年08月26日 17:01, THOBY Simon 写道:
> Hi liqiong,
>
> On 8/26/21 10:15 AM, liqiong wrote:
>> Hi Simon,
>>
>> Thanks for your help, your advice is clear, can i just use it,
>> how about this:
>>
>>
>> The current IMA ruleset is identified by the variable "ima_rules",
>> and the pointer starts pointing at the list "ima_default_rules".
> After reading it again, maybe
> "The current IMA ruleset is identified by the variable "ima_rules",
> that defaults to "&ima_default_rules".'?
>
>> When loading a custom policy for the first time, the variable is
>> updated to point to the list "ima_policy_rules" instead. That update
>> isn't RCU-safe, and deadlocks are possible.
> I think what Mimi was trying to say is that you could add the high-level
> overview above, but keep the details. Sorry if I wasn't clearer in my
> earlier messages.
>
> Consider re-adding your previous paragraph
> """
> As a consequence, when traversing the ruleset, some functions like ima_match_policy()
> may loop indefinitely over "ima_default_rules" as list_for_each_entry_rcu() doesn't
> terminate (after the update, "ima_rules" no longer points to the list head, so the
> loop condition stays always true), causing RCU stalls.
> """
> (note: I tweaked it above, feel free to fix it)
>> Introduce a temporary value for "ima_rules" when iterating over
>> the ruleset to avoid the deadlocks.
> ... while keeping this a separate paragraph.
>
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
>>
>> Thanks
>>
>> liqiong

