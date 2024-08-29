Return-Path: <linux-integrity+bounces-3425-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066E96461A
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2024 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F201C24179
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5D1A4B81;
	Thu, 29 Aug 2024 13:14:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A71AC429;
	Thu, 29 Aug 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937299; cv=none; b=Wchnb51scD9doYH+nPFLKIE32wQ+kzorylN2ggXfHmuaBpePvHibavKTGcZobxgrwWd0cg0nVE0nV3EBlNpIpNqwo/jSG3UeIMcwFZqERR041Bx5ksweqyKo+65flYPhJ/ZzYGDm/3usNoyQyYHr8K40L5dzGPqJV4G7p2/waQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937299; c=relaxed/simple;
	bh=3U1uR4RuV3esL0UNoYBOSSQTnZHiAlsJQXfvRBLuWtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HFMOA0suhgs23DKOFejyGSwaIrHd8l4+1ZwmDbGXOzymRukjCg8OzdgW/lQye3ECcZlg1Yb9vnqTq6hj1btSEaM8/BX/+grnQ5WhdOUlBJJ46b2+WNT8mZR6exV1UPZTzhzUl/gPnxMA6nLyu9x0VyptANtGaLoiF3xtQxsXQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvglM1GZxz9v7Hm;
	Thu, 29 Aug 2024 20:37:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 33E3F140B3E;
	Thu, 29 Aug 2024 20:56:13 +0800 (CST)
Received: from [10.48.41.179] (unknown [10.48.41.179])
	by APP2 (Coremail) with SMTP id GxC2BwDntcLkb9Bmo_4oAg--.14990S2;
	Thu, 29 Aug 2024 13:56:12 +0100 (CET)
Message-ID: <3fbe1092-d0be-4e30-96a7-4ec72d65b013@huaweicloud.com>
Date: Thu, 29 Aug 2024 20:56:02 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in process_measurement
To: Xingyu Li <xli399@ucr.edu>, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yu Hao <yhao016@ucr.edu>
References: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
 <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDntcLkb9Bmo_4oAg--.14990S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1kCw1kKw13CrW3JrWrXwb_yoW7CF4rpF
	10gFyUGr4vqr1xZr1DJr15Ar4UKw4Yya1UXws7Gry8AFy5W3WDXF18JrW7Gr98Jr15ZFy3
	tFn8Xw48tw1UGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5lksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBGbP2XkFlQACsX

On 8/29/2024 12:53 PM, Xingyu Li wrote:
> The above syzkaller reproducer needs additional support. And here is
> the C reproducer:
> https://gist.github.com/freexxxyyy/c3d1ccb8104af6b0d51ed50c29b363d3

Hi Xingyu

do you have a .config for testing?

Thanks

Roberto

> On Sat, Aug 24, 2024 at 10:23 PM Xingyu Li <xli399@ucr.edu> wrote:
>>
>> Hi,
>>
>> We found a bug in Linux 6.10. This is likely a mutex corruption bug,
>> where the mutex's internal state has been compromised, leading to an
>> integrity check failure. The bug occurs in
>> https://elixir.bootlin.com/linux/v6.10/source/security/integrity/ima/ima_main.c#L269.
>>
>> The bug report and syzkaller reproducer are as follows:
>>
>> Bug report:
>>
>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
>> __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
>> __mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
>> Modules linked in:
>> CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
>> RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
>> Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9 f4
>> ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0f> 0b
>> e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
>> RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
>> RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
>> R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
>> R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
>> FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   process_measurement+0x536/0x1ff0 security/integrity/ima/ima_main.c:269
>>   ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
>>   security_file_post_open+0x51/0xb0 security/security.c:2982
>>   do_open fs/namei.c:3656 [inline]
>>   path_openat+0x2c0b/0x3580 fs/namei.c:3813
>>   do_filp_open+0x22d/0x480 fs/namei.c:3840
>>   do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
>>   do_sys_open fs/open.c:1428 [inline]
>>   __do_sys_openat fs/open.c:1444 [inline]
>>   __se_sys_openat fs/open.c:1439 [inline]
>>   __x64_sys_openat+0x243/0x290 fs/open.c:1439
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x67/0x6f
>> RIP: 0033:0x7f903019a167
>> Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85
>> c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
>> 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
>> RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
>> RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
>> RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
>> RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
>>   </TASK>
>>
>>
>> Syzkaller reproducer:
>> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
>> Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
>> NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
>> KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
>> Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
>> HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false
>> FaultCall:0 FaultNth:0}}
>> r0 = openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
>> ioctl$TIOCSETD(r0, 0x5423, 0x0)
>> mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=nil, 0x4000, 0x2,
>> 0x20031, 0xffffffffffffffff, 0x8000000)
>> mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=nil, 0xc000, 0xe,
>> 0x12, 0xffffffffffffffff, 0x0)
>> openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
>> write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
>> &(0x7f0000000000)="2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
>> 0xb4)
>> r1 = syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
>> ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)={0x0, 0x2,
>> [0x85, 0x8, 0x15, 0xd]})
>> ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)
>>
>>
>> --
>> Yours sincerely,
>> Xingyu
> 
> 
> 


