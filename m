Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E892D410315
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Sep 2021 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhIRCuz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 22:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhIRCuy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 22:50:54 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BA8CC061574
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 19:49:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id CD7E8AE0E23;
        Sat, 18 Sep 2021 10:49:35 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yyLQFy5_hfNF; Sat, 18 Sep 2021 10:49:16 +0800 (CST)
Received: from [172.30.18.174] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 03589AE0E14;
        Sat, 18 Sep 2021 10:49:15 +0800 (CST)
Subject: Re: [zohar-integrity:next-integrity-testing 1/1]
 security/integrity/ima/ima_policy.c:684:25: sparse: sparse: incompatible
 types in comparison expression (different address spaces):
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-integrity@vger.kernel.org,
        THOBY Simon <Simon.THOBY@viveris.fr>
References: <202109150609.vPQhnWpw-lkp@intel.com>
 <1b6c2bf0-cd29-436b-9cdc-2e2a6405601a@nfschina.com>
 <b22ad457ce54955ab160f4f48940887ebdee94d4.camel@linux.ibm.com>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <720d0a4b-220a-90d9-8fb4-d1c1069d1ebb@nfschina.com>
Date:   Sat, 18 Sep 2021 10:49:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b22ad457ce54955ab160f4f48940887ebdee94d4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

According to "Documentation/RCU/rcu_dereference":
 
	"->rcu_protected_pointer might be declared as follows:
	struct foo __rcu *rcu_protected_pointer; "

it seems only "ima_rules" should add "__rcu" annotation,
because it a "rcu_protected_pointer". "sparse" only check this
pointer. Adding ""__rcu" annotation to "ima_rules_tmp", it 
could not help to avoid the warnings.
 

在 2021年09月17日 22:27, Mimi Zohar 写道:

> On Thu, 2021-09-16 at 20:05 +0800, liqiong wrote:
>> Hi Mini,
>>
>> I got this sparse warnings, should i fix it ?
>>
>> It seems the follow patch can fix, but i don't think should do
>> this check (ima_rules_tmp == NULL).
>>
>>
>> -static struct list_head *ima_rules = &ima_default_rules;
>> +static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
>>
>> ima_rules_tmp = rcu_dereference(ima_rules);
>> +if (ima_rules_tmp == NULL)
>> +	return ;
> Agreed,  the "__rcu" annotation is missing.  Probably both ima_rules
> and ima_rules_tmp should be annotated with "__rcu".   Agreed,
> ima_rules_tmp will either point to the default or custom policy rules. 
> No need for the check.
>
> Please post a new version of the patch, with "Reported-by: kernel test
> robot <lkp@intel.com>  (Fix sparse: incompatible types in comparison
> expression)".
>
> thanks,
>
> Mimi
>
