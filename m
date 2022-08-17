Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD20596A28
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Aug 2022 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiHQHRZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiHQHRY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 03:17:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C86B8D6;
        Wed, 17 Aug 2022 00:17:23 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6zlX2CP5zkWWh;
        Wed, 17 Aug 2022 15:14:00 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:17:21 +0800
Message-ID: <c9e269ce-74aa-f2f0-f21d-0d023db23739@huawei.com>
Date:   Wed, 17 Aug 2022 15:17:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Race conditioned discovered between ima_match_rules and
 ima_update_lsm_update_rules
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        <selinux@vger.kernel.org>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
 <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
 <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
 <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
 <CAHC9VhTO2YDF8paeYfPDj2aAdiNGCDxziHTY2Sa_5C=yup+P_w@mail.gmail.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <CAHC9VhTO2YDF8paeYfPDj2aAdiNGCDxziHTY2Sa_5C=yup+P_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/8/16 6:23, Paul Moore wrote:
> On Sun, Aug 14, 2022 at 2:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> Hi Scott, Paul,
>>
>> On Tue, 2022-08-09 at 12:24 -0400, Paul Moore wrote:
>>> On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott) <guozihua@huawei.com> wrote:
>>>>
>>>> On 2022/8/8 11:02, Guozihua (Scott) wrote:
>>>>> Hi Community,
>>>>>
>>>>> Recently we discovered a race condition while updating SELinux policy
>>>>> with IMA lsm rule enabled. Which would lead to extra files being measured.
>>>>>
>>>>> While SELinux policy is updated, the IDs for object types and such would
>>>>> be changed, and ima_lsm_update_rules would be called.
>>>>>
>>>>> There are no lock applied in ima_lsm_update_rules. If user accesses a
>>>>> file during this time, ima_match_rules will be matching rules based on
>>>>> old SELinux au_seqno resulting in selinux_audit_rule_match returning
>>>>> -ESTALE.
>>>>>
>>>>> However, in ima_match_rules, this error number is not handled, causing
>>>>> IMA to think the LSM rule is also a match, leading to measuring extra
>>>>> files.
>>>
>>> ...
>>>
>>>>> Is this the intended behavior? Or is it a good idea to add a lock for
>>>>> LSM rules during update?
>>>
>>> I'm not the IMA expert here, but a lot of effort has been into the
>>> SELinux code to enable lockless/RCU SELinux policy access and I
>>> *really* don't want to have to backtrack on that.
>>
>> IMA initially updated it's reference to the SELinux label ids lazily.
>> More recently IMA refreshes the LSM label ids based on
>> register_blocking_lsm_notifier().  As a result of commit 9ad6e9cb39c6
>> ("selinux: fix race between old and new sidtab"), -ESTALE is now being
>> returned.
> 
> To be clear, are you seeing this only started happening after commit
> 9ad6e9cb39c6?  If that is the case, I would suggest a retry loop
> around ima_filter_rule_match() when -ESTALE is returned.  I believe
> that should resolve the problem, if not please let us know.
> 

Hi Mimi and Paul

It seems that selinux_audit_rule_match has been returning -ESTALE for a 
very long time. It dates back to 376bd9cb357ec.

IMA used to have a retry mechanism, but it was removed by b16942455193 
("ima: use the lsm policy update notifier"). Maybe we should consider 
bring it back or just add a lock in ima_lsm_update_rules().

FYI, once ima received the notification, it starts updating all it's lsm 
rules one-by-one. During this time, calling ima_match_rules on any rule 
that is not yet updated would return -ESTALE.

-- 
Best
GUO Zihua
