Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816393F839C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhHZIRC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHZIRC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 04:17:02 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF2F4C061757;
        Thu, 26 Aug 2021 01:16:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 8D16BAE0DC7;
        Thu, 26 Aug 2021 16:15:23 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PqZdW8WS1aF3; Thu, 26 Aug 2021 16:15:03 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 7B218AE0DB6;
        Thu, 26 Aug 2021 16:15:03 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
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
Message-ID: <1e464ae0-28e1-6511-ab89-52b5cd1a0841@nfschina.com>
Date:   Thu, 26 Aug 2021 16:15:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <eb9921ff-2d4b-136f-b7a7-924e61a0651b@viveris.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

Thanks for your help, your advice is clear, can i just use it,
how about this:


The current IMA ruleset is identified by the variable "ima_rules",
and the pointer starts pointing at the list "ima_default_rules".
When loading a custom policy for the first time, the variable is
updated to point to the list "ima_policy_rules" instead. That update
isn't RCU-safe, and deadlocks are possible.

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

在 2021年08月25日 20:03, THOBY Simon 写道:
> Hi Liqiong,
>
> On 8/25/21 1:45 PM, liqiong wrote:
>> Hi Mimi,
>>
>> This copy may be better.
>>
>>
>> subject: ima: fix deadlock when iterating over the init "ima_rules" list.
>>
>>
> As Mimi said, consider adding an introducing paragraph, like:
> 'The current IMA ruleset is identified by the variable "ima_rules",
> and the pointer starts pointing at the list "ima_default_rules". When
> loading a custom policy for the first time, the variable is
> updated to point to the list "ima_policy_rules" instead. That update
> isn't RCU-safe, and deadlocks are possible.'
>
>> When traversing back to head, the init "ima_rules" list can't exit
>> iterating if "ima_rules" has been updated to "ima_policy_rules".
>> It causes soft lockup and RCU stalls. So we can introduce a duplicate
>> of "ima_rules" for each "ima_rules" list loop.
> Per the process (see 'Documentation/process/submitting-patches.rst'),
> please prefer an imperative style (written in another paragraph):
> 'Introduce a temporary value for "ima_rules" when iterating over the ruleset.'
>
>
> Thanks,
> Simon

