Return-Path: <linux-integrity+bounces-2208-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410218ADE43
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Apr 2024 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35E61F245BF
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Apr 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4AC46542;
	Tue, 23 Apr 2024 07:30:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45144653C;
	Tue, 23 Apr 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857453; cv=none; b=thE4lC/tF7LXh3mjz3DTfKue+KaVMRuNntUwv7VycRu2uR5vi3osr2bGpkc+cJ/wMfG3oMciNegSfxx5V3iZoSRwtjXwh9XoIfLNff2DjwyNrY6OQd+tSPLpy81B68Fuof6JBR24NwG7TXrvrlGgd+Cmb9ZV7x1ciDDXFhXBa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857453; c=relaxed/simple;
	bh=q462vC39AecMNVd/EL95VnrcK352LxnpAt6CtLncM4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YFCHpQ2QFrQ1d2O+/gCKp9qdE56eUh+zxsnvK8HEa9wnv5tflS6Qi7P/fvR8G0b0gJwqioTBOw/PtWfmchHdbNW6g5AD04Xog1yLDH/VAPZ/30FJgE+C8fnnxbPepOnwjdd0m53AHm1Z2oJ4nIfRIIe+8Mll6SnZ9kXIqZqG/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VNtxS6dGvzvQ5f;
	Tue, 23 Apr 2024 15:27:40 +0800 (CST)
Received: from dggpemm500024.china.huawei.com (unknown [7.185.36.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 2490818007D;
	Tue, 23 Apr 2024 15:30:41 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 15:30:40 +0800
Message-ID: <b972d368-81e9-c5cc-0b63-ed7f3953d446@huawei.com>
Date: Tue, 23 Apr 2024 15:30:40 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
CC: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <eric.snowberg@oracle.com>, <omosnace@redhat.com>,
	<linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>
References: <20240417074444.2834769-1-guozihua@huawei.com>
 <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
 <8b814f56-3987-5503-313d-fc3c3104e028@huawei.com>
 <CAEjxPJ7mTgOG=POD0XfSmnE-vFx5wXT2TRnx_DoTPW6QNoGAMg@mail.gmail.com>
From: "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <CAEjxPJ7mTgOG=POD0XfSmnE-vFx5wXT2TRnx_DoTPW6QNoGAMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)

On 2024/4/22 20:18, Stephen Smalley wrote:
> On Sun, Apr 21, 2024 at 9:26 PM Guozihua (Scott) <guozihua@huawei.com> wrote:
>>
>> On 2024/4/20 5:41, Stephen Smalley wrote:
>>> On Wed, Apr 17, 2024 at 12:49 AM GUO Zihua <guozihua@huawei.com> wrote:
>>>>
>>>> A panic happens in ima_match_policy:
>>>>
>>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
>>>> PGD 42f873067 P4D 0
>>>> Oops: 0000 [#1] SMP NOPTI
>>>> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>>>> RIP: 0010:ima_match_policy+0x84/0x450
>>>> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
>>>> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
>>>> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
>>>> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
>>>> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
>>>> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
>>>> FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>  ima_get_action+0x22/0x30
>>>>  process_measurement+0xb0/0x830
>>>>  ima_file_check+0x64/0x90
>>>>  path_openat+0x571/0x1720
>>>>  do_filp_open+0x9b/0x110
>>>>  do_sys_open+0x1bd/0x250
>>>>  do_syscall_64+0x5d/0x1d0
>>>>  entry_SYSCALL_64_after_hwframe+0x65/0xca
>>>>
>>>> (stack trace marked with ? is deleted)
>>>>
>>>> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
>>>> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
>>>> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
>>>> This implies a possible sleep and violates limitations of RCU read-side
>>>> critical sections on non-PREEMPT systems.
>>>>
>>>> Sleeping within RCU read-side critical section might cause
>>>> synchronize_rcu() returning early and break RCU protection, allowing a
>>>> UAF to happen.
>>>>
>>>> The root cause of this issue could be described as follows:
>>>> |       Thread A        |       Thread B        |
>>>> |                       |ima_match_policy       |
>>>> |                       |  rcu_read_lock        |
>>>> |ima_lsm_update_rule    |                       |
>>>> |  synchronize_rcu      |                       |
>>>> |                       |    kmalloc(GFP_KERNEL)|
>>>> |                       |      sleep            |
>>>> ==> synchronize_rcu returns early
>>>> |  kfree(entry)         |                       |
>>>> |                       |    entry = entry->next|
>>>> ==> UAF happens and entry now becomes NULL (or could be anything).
>>>> |                       |    entry->action      |
>>>> ==> Accessing entry might cause panic.
>>>>
>>>> To fix this issue, we are converting all kmalloc that is called within
>>>> RCU read-side critical section to use GFP_ATOMIC.
>>>>
>>>> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>>>> ---
>>>>  security/integrity/ima/ima_policy.c | 2 +-
>>>>  security/selinux/ss/services.c      | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>>>> index c0556907c2e6..c0cf9b6a01f0 100644
>>>> --- a/security/integrity/ima/ima_policy.c
>>>> +++ b/security/integrity/ima/ima_policy.c
>>>> @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>>>>          * Immutable elements are copied over as pointers and data; only
>>>>          * lsm rules can change
>>>>          */
>>>> -       nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
>>>> +       nentry = kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
>>>>         if (!nentry)
>>>>                 return NULL;
>>>>
>>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>>> index e88b1b6c4adb..b7cfad1a2964 100644
>>>> --- a/security/selinux/ss/services.c
>>>> +++ b/security/selinux/ss/services.c
>>>> @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>>>>                 return -EINVAL;
>>>>         }
>>>>
>>>> -       tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
>>>> +       tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_ATOMIC);
>>>
>>> I would suggest passing in gfp flags from the callers and only using
>>> GFP_ATOMIC for the particular call chain that requires atomic
>>> allocations, or re-factoring the caller to perform the allocating
>>> operations outside of the critical section.
>>
>> Well unfortunately the SELinux involved in this patch is called via
>> security hooks. Adding new flags would mean define macros as well as all
>> the callers and implementations would have to be changed.
> 
> That is ok if it is what is required to fix this correctly. However,
> if you can re-factor the caller to move the allocation outside of the
> RCU read lock, or eliminate the need for an allocation altogether,
> that would be better.

This does not seems to be possible for now. The RCU lock circulates the
whole list access while there might be more LSM related rules within the
list. Besides we cannot release the RCU lock before allocation, this
would trigger an UAF immediately.

Will send a v2 adding a GFP mask for security hook as well as
ima_lsm_copy_rule.
> 
>>> Sidebar: the refactoring of the SELinux policy loading logic may have
>>> made it possible to revisit the approaches here to permit holding a
>>> reference to the policy from which the rule was derived so that we
>>> don't have to return -ESTALE in this scenario.
>>
>> This would be nice if we are able to make this re-init happen in-place
>> which would spare IMA from initializing a temporary rule and the list
>> replace behavior.
> 
> Yes, that would be best if possible.

-- 
Best
GUO Zihua


