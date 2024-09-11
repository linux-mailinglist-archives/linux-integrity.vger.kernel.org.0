Return-Path: <linux-integrity+bounces-3536-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE19754F1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB41C23041
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5119F102;
	Wed, 11 Sep 2024 14:05:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBE19AA75;
	Wed, 11 Sep 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063550; cv=none; b=LbzLhimTg6wYfjf0Yzm0WENKknj0c+duXSSpaLRYJP17YWj6tkmag7+UYepzpS5CXNcPm3+G4CVrsQwkl/TtiWMJ1yv8sM3zEbaU6Tl+4bLRzc8BJRRLOJMaytg/rA/mWk/hWg7p5lMIG2XcD0/mW7hdRIwo0DO5N9kLQKm8CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063550; c=relaxed/simple;
	bh=hjC5W5j5YgHC8CQISxg+bDxsDD1jp6vVxWZV/lNfSMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txEFBeSlsxED3dXbZxnj6ndtGi3+L4zmOawC0JNukX3mGYDPPO1XLcYGYwkmgTUOF/yr+BxkPZDlnVcZMmpvwACwLwFIhI1/c/dWdFnux6rCIGugycY3qLOqSgILBeSF31HRlHE6YHE0m7WMGui+fxvm6EyWZU20WQX+fBJvtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X3hgC6j6vz9v7NN;
	Wed, 11 Sep 2024 21:46:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 261AD14086A;
	Wed, 11 Sep 2024 22:05:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHqcmho+FmJTC4AA--.61324S2;
	Wed, 11 Sep 2024 15:05:32 +0100 (CET)
Message-ID: <8c64fdfbfd5e74d1253ab738df551bbba32d225f.camel@huaweicloud.com>
Subject: Re: WARNING in process_measurement
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Xingyu Li <xli399@ucr.edu>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org, Yu
 Hao <yhao016@ucr.edu>
Date: Wed, 11 Sep 2024 16:05:18 +0200
In-Reply-To: <CALAgD-6Q6rVARhuuj_6o=7sBXiaVWRmCrToHCRVffLrZmvZq2A@mail.gmail.com>
References: 
	<CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
	 <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com>
	 <3fbe1092-d0be-4e30-96a7-4ec72d65b013@huaweicloud.com>
	 <CALAgD-47U+dZuVxoq9pSSpYk=Y6H6yTwmpe6iBmFBk-xCADW_w@mail.gmail.com>
	 <70a434e017d75a94b5e246ad7a678b752fe97d30.camel@huaweicloud.com>
	 <CALAgD-6Q6rVARhuuj_6o=7sBXiaVWRmCrToHCRVffLrZmvZq2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHqcmho+FmJTC4AA--.61324S2
X-Coremail-Antispam: 1UD129KBjvAXoWfWrW8GrWkCw17tF15Xr48tFb_yoW8ZFW8Ao
	Z3J347Xr4rGa45G34xAwn8tw4UX348t3Z7Jry0kw15G3W7t3Z8Xr9rJw48Ja1rtr1UJFn8
	uw4Iyas5Cw1qkwn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBGbg-PsJWAABsU

On Wed, 2024-09-04 at 19:23 -0700, Xingyu Li wrote:
> Here is to set up the reproducing environment:
> https://github.com/TomAPU/Linux610BugReort
> It can reproduce on our end.

Thank you.

I actually reproduced the bug... but failed somewhere else.

[  804.974007][ T7733] INFO: trying to register non-static key.
[  804.974702][ T7733] The code is fine but needs lockdep annotation, or ma=
ybe
[  804.975414][ T7733] you didn't initialize this object before use?
[  804.976059][ T7733] turning off the locking correctness validator.
[  804.976711][ T7733] CPU: 0 PID: 7733 Comm: systemd-journal Not tainted 6=
.10.0 #2628
[  804.977517][ T7733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.15.0-1 04/01/2014
[  804.978448][ T7733] Call Trace:
[  804.978810][ T7733]  <TASK>
[  804.979129][ T7733]  dump_stack_lvl+0x225/0x350
[  804.979674][ T7733]  ? __pfx_dump_stack_lvl+0x10/0x10
[  804.980270][ T7733]  ? __pfx__printk+0x10/0x10
[  804.980789][ T7733]  ? srso_return_thunk+0x5/0x5f
[  804.981325][ T7733]  ? __is_module_percpu_address+0x394/0x410
[  804.981976][ T7733]  ? __module_address+0x2e/0x500
[  804.982519][ T7733]  assign_lock_key+0x238/0x270
[  804.983042][ T7733]  ? __pfx_assign_lock_key+0x10/0x10
[  804.983623][ T7733]  register_lock_class+0x1c4/0x960
[  804.984188][ T7733]  ? __pfx___lock_acquire+0x10/0x10
[  804.984753][ T7733]  ? __pfx_register_lock_class+0x10/0x10
[  804.985363][ T7733]  ? __pfx___lock_acquire+0x10/0x10
[  804.985930][ T7733]  __lock_acquire+0x193/0x7ac0
[  804.986457][ T7733]  ? srso_return_thunk+0x5/0x5f
[  804.987000][ T7733]  ? srso_return_thunk+0x5/0x5f
[  804.987538][ T7733]  ? mark_lock+0x97/0x320
[  804.988023][ T7733]  ? srso_return_thunk+0x5/0x5f
[  804.988556][ T7733]  ? __pfx___lock_acquire+0x10/0x10
[  804.989125][ T7733]  ? __might_fault+0xac/0x120
[  804.989648][ T7733]  ? _copy_to_iter+0x26e/0x1bf0
[  804.990191][ T7733]  ? timerfd_read_iter+0x840/0x9f0
[  804.990756][ T7733]  ? __pfx___lock_acquire+0x10/0x10
[  804.991316][ T7733]  ? lockdep_hardirqs_on_prepare+0x440/0x7a0
[  804.991955][ T7733]  ? __pfx__copy_to_iter+0x10/0x10
[  804.992504][ T7733]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  804.993157][ T7733]  ? _raw_spin_lock_irq+0xdb/0x120
[  804.993701][ T7733]  lock_acquire+0x1f2/0x580
[  804.994181][ T7733]  ? __set_current_blocked+0x122/0x360
[  804.994758][ T7733]  ? lockdep_hardirqs_on+0x95/0x140
[  804.995319][ T7733]  ? __pfx_lock_acquire+0x10/0x10
[  804.995862][ T7733]  ? end_current_label_crit_section+0x147/0x170
[  804.996525][ T7733]  ? srso_return_thunk+0x5/0x5f
[  804.997050][ T7733]  _raw_spin_lock_irq+0xcf/0x120
[  804.997577][ T7733]  ? __set_current_blocked+0x122/0x360
[  804.998144][ T7733]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  804.998726][ T7733]  ? __might_fault+0xac/0x120
[  804.999228][ T7733]  __set_current_blocked+0x122/0x360
[  804.999807][ T7733]  ? __pfx___set_current_blocked+0x10/0x10
[  805.000418][ T7733]  ? __might_fault+0xac/0x120
[  805.000918][ T7733]  ? __might_fault+0xc8/0x120
[  805.001427][ T7733]  ? __might_fault+0xac/0x120
[  805.001941][ T7733]  __se_sys_rt_sigprocmask+0x2ed/0x3b0
[  805.002521][ T7733]  ? __pfx___se_sys_rt_sigprocmask+0x10/0x10
[  805.003143][ T7733]  ? lockdep_hardirqs_on_prepare+0x440/0x7a0
[  805.003788][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.004302][ T7733]  ? __secure_computing+0x110/0x2f0
[  805.004865][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.005386][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.005914][ T7733]  do_syscall_64+0x7b/0x150
[  805.006399][ T7733]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  805.007022][ T7733] RIP: 0033:0x7f7734e529b8
[  805.007492][ T7733] Code: 48 85 f6 74 15 48 b9 00 00 00 80 01 00 00 00 4=
8 8b 06 48 85 c8 75 3b 48 89 f0 48 89 c6 41 ba 08 00 00 00 b8 0e 00 00 00 0=
f 05 <89> c2 f7 da 3d 00 f0 ff ff b8 00 00 00 00 0f 47 c2 48 8b 55 f8 64
[  805.009399][ T7733] RSP: 002b:00007ffea0fab1b0 EFLAGS: 00000246 ORIG_RAX=
: 000000000000000e
[  805.010272][ T7733] RAX: ffffffffffffffda RBX: 000055fca9860590 RCX: 000=
07f7734e529b8
[  805.011083][ T7733] RDX: 00007ffea0fab250 RSI: 00007ffea0fab2d0 RDI: 000=
0000000000000
[  805.011892][ T7733] RBP: 00007ffea0fab240 R08: 000055fca986d40c R09: 000=
055fca9861eec
[  805.012691][ T7733] R10: 0000000000000008 R11: 0000000000000246 R12: 000=
07ffea0fab2d0
[  805.013499][ T7733] R13: 00007ffea0fab250 R14: 00007ffea0fab438 R15: 000=
07ffea0fab440
[  805.014318][ T7733]  </TASK>
[  805.019958][ T7733] ------------[ cut here ]------------
[  805.020530][ T7733] refcount_t: addition on 0; use-after-free.
[  805.021779][ T7733] WARNING: CPU: 0 PID: 7733 at lib/refcount.c:25 refco=
unt_warn_saturate+0x130/0x1b0
[  805.022754][ T7733] Modules linked in:
[  805.023160][ T7733] CPU: 0 PID: 7733 Comm: systemd-journal Not tainted 6=
.10.0 #2628
[  805.023963][ T7733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.15.0-1 04/01/2014
[  805.024862][ T7733] RIP: 0010:refcount_warn_saturate+0x130/0x1b0
[  805.025532][ T7733] Code: 0a 01 48 c7 c7 40 a0 db 8b e8 9c 89 ec fc 0f 0=
b eb bf e8 e3 fe 29 fd c6 05 05 b3 e3 0a 01 48 c7 c7 a0 a0 db 8b e8 80 89 e=
c fc <0f> 0b eb a3 e8 c7 fe 29 fd c6 05 ea b2 e3 0a 01 48 c7 c7 00 a1 db
[  805.027498][ T7733] RSP: 0018:ffffc9000aaf7a50 EFLAGS: 00010246
[  805.028153][ T7733] RAX: 1c6d5d6d27f73700 RBX: 0000000000000002 RCX: fff=
f88807f069e00
[  805.028983][ T7733] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[  805.029803][ T7733] RBP: 0000000000000000 R08: ffff888061a28cd3 R09: 1ff=
ff1100c34519a
[  805.030637][ T7733] R10: dffffc0000000000 R11: ffffed100c34519b R12: dff=
ffc0000000000
[  805.031504][ T7733] R13: ffff88801f1ed0d0 R14: ffff88801ce9ca40 R15: fff=
f88801f1ebc00
[  805.032342][ T7733] FS:  00007f7734588940(0000) GS:ffff888061a00000(0000=
) knlGS:0000000000000000
[  805.033274][ T7733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  805.033960][ T7733] CR2: 00007f77339da000 CR3: 000000007f8c0000 CR4: 000=
0000000350ef0
[  805.034797][ T7733] Call Trace:
[  805.035156][ T7733]  <TASK>
[  805.035477][ T7733]  ? __warn+0x160/0x4d0
[  805.035938][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.036547][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.037160][ T7733]  ? report_bug+0x2bd/0x500
[  805.037662][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.038277][ T7733]  ? handle_bug+0x3d/0x80
[  805.038749][ T7733]  ? exc_invalid_op+0x16/0x50
[  805.039262][ T7733]  ? asm_exc_invalid_op+0x16/0x20
[  805.039837][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.040450][ T7733]  copy_sighand+0x213/0x240
[  805.040958][ T7733]  copy_process+0x1780/0x3e30
[  805.041518][ T7733]  ? copy_process+0xa3d/0x3e30
[  805.042052][ T7733]  ? __pfx___cant_migrate+0x10/0x10
[  805.042626][ T7733]  ? __pfx_copy_process+0x10/0x10
[  805.043181][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.043719][ T7733]  ? migrate_disable+0xc9/0x180
[  805.044254][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.044794][ T7733]  ? __seccomp_filter+0x96a/0x21e0
[  805.045358][ T7733]  kernel_clone+0x21e/0x8e0
[  805.045860][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.046395][ T7733]  ? __pfx_kernel_clone+0x10/0x10
[  805.046957][ T7733]  ? __set_current_blocked+0x2f7/0x360
[  805.047558][ T7733]  __x64_sys_clone+0x289/0x300
[  805.048096][ T7733]  ? __pfx___x64_sys_clone+0x10/0x10
[  805.048692][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.049228][ T7733]  ? syscall_trace_enter+0xa8/0x150
[  805.049800][ T7733]  do_syscall_64+0x7b/0x150
[  805.050293][ T7733]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  805.050934][ T7733] RIP: 0033:0x7f7734ed1866
[  805.051447][ T7733] Code: 85 ff 74 3e 48 83 e6 f0 74 38 48 89 4e f8 48 8=
3 ee 10 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0=
f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00
[  805.053459][ T7733] RSP: 002b:00007ffea0faaff8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000038
[  805.054344][ T7733] RAX: ffffffffffffffda RBX: 00007f7734e4b650 RCX: 000=
07f7734ed1866
[  805.055175][ T7733] RDX: 00007f7733200990 RSI: 00007f77331ffd70 RDI: 000=
00000003d0f00
[  805.056014][ T7733] RBP: 00007ffea0fab040 R08: 00007f77332006c0 R09: 000=
07f77332006c0
[  805.056846][ T7733] R10: 00007f7733200990 R11: 0000000000000202 R12: 000=
07f77332006c0
[  805.057669][ T7733] R13: fffffffffffffda8 R14: 0000000000000002 R15: 000=
07ffea0fab060
[  805.058514][ T7733]  </TASK>
[  805.058854][ T7733] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[  805.059619][ T7733] CPU: 0 PID: 7733 Comm: systemd-journal Not tainted 6=
.10.0 #2628
[  805.060444][ T7733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.15.0-1 04/01/2014
[  805.061394][ T7733] Call Trace:
[  805.061755][ T7733]  <TASK>
[  805.062077][ T7733]  dump_stack_lvl+0x225/0x350
[  805.062594][ T7733]  ? __pfx_dump_stack_lvl+0x10/0x10
[  805.063160][ T7733]  ? __pfx__printk+0x10/0x10
[  805.063680][ T7733]  ? _printk+0xcc/0x120
[  805.064171][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.064711][ T7733]  panic+0x346/0x850
[  805.065158][ T7733]  ? __pfx_panic+0x10/0x10
[  805.065662][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.066216][ T7733]  __warn+0x342/0x4d0
[  805.066652][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.067264][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.067888][ T7733]  report_bug+0x2bd/0x500
[  805.068374][ T7733]  ? refcount_warn_saturate+0x130/0x1b0
[  805.068990][ T7733]  handle_bug+0x3d/0x80
[  805.069477][ T7733]  exc_invalid_op+0x16/0x50
[  805.069979][ T7733]  asm_exc_invalid_op+0x16/0x20
[  805.070518][ T7733] RIP: 0010:refcount_warn_saturate+0x130/0x1b0
[  805.071196][ T7733] Code: 0a 01 48 c7 c7 40 a0 db 8b e8 9c 89 ec fc 0f 0=
b eb bf e8 e3 fe 29 fd c6 05 05 b3 e3 0a 01 48 c7 c7 a0 a0 db 8b e8 80 89 e=
c fc <0f> 0b eb a3 e8 c7 fe 29 fd c6 05 ea b2 e3 0a 01 48 c7 c7 00 a1 db
[  805.073233][ T7733] RSP: 0018:ffffc9000aaf7a50 EFLAGS: 00010246
[  805.073887][ T7733] RAX: 1c6d5d6d27f73700 RBX: 0000000000000002 RCX: fff=
f88807f069e00
[  805.074711][ T7733] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[  805.075528][ T7733] RBP: 0000000000000000 R08: ffff888061a28cd3 R09: 1ff=
ff1100c34519a
[  805.076388][ T7733] R10: dffffc0000000000 R11: ffffed100c34519b R12: dff=
ffc0000000000
[  805.077211][ T7733] R13: ffff88801f1ed0d0 R14: ffff88801ce9ca40 R15: fff=
f88801f1ebc00
[  805.078058][ T7733]  copy_sighand+0x213/0x240
[  805.078560][ T7733]  copy_process+0x1780/0x3e30
[  805.079110][ T7733]  ? copy_process+0xa3d/0x3e30
[  805.079640][ T7733]  ? __pfx___cant_migrate+0x10/0x10
[  805.080208][ T7733]  ? __pfx_copy_process+0x10/0x10
[  805.080754][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.081285][ T7733]  ? migrate_disable+0xc9/0x180
[  805.081810][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.082340][ T7733]  ? __seccomp_filter+0x96a/0x21e0
[  805.082897][ T7733]  kernel_clone+0x21e/0x8e0
[  805.083392][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.083936][ T7733]  ? __pfx_kernel_clone+0x10/0x10
[  805.084491][ T7733]  ? __set_current_blocked+0x2f7/0x360
[  805.085082][ T7733]  __x64_sys_clone+0x289/0x300
[  805.085616][ T7733]  ? __pfx___x64_sys_clone+0x10/0x10
[  805.086208][ T7733]  ? srso_return_thunk+0x5/0x5f
[  805.086733][ T7733]  ? syscall_trace_enter+0xa8/0x150
[  805.087300][ T7733]  do_syscall_64+0x7b/0x150
[  805.087798][ T7733]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  805.088430][ T7733] RIP: 0033:0x7f7734ed1866
[  805.088902][ T7733] Code: 85 ff 74 3e 48 83 e6 f0 74 38 48 89 4e f8 48 8=
3 ee 10 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0=
f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00
[  805.090857][ T7733] RSP: 002b:00007ffea0faaff8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000038
[  805.091726][ T7733] RAX: ffffffffffffffda RBX: 00007f7734e4b650 RCX: 000=
07f7734ed1866
[  805.092553][ T7733] RDX: 00007f7733200990 RSI: 00007f77331ffd70 RDI: 000=
00000003d0f00
[  805.093370][ T7733] RBP: 00007ffea0fab040 R08: 00007f77332006c0 R09: 000=
07f77332006c0
[  805.094187][ T7733] R10: 00007f7733200990 R11: 0000000000000202 R12: 000=
07f77332006c0
[  805.095009][ T7733] R13: fffffffffffffda8 R14: 0000000000000002 R15: 000=
07ffea0fab060
[  805.095853][ T7733]  </TASK>
[  805.096265][ T7733] Kernel Offset: disabled
[  805.096726][ T7733] Rebooting in 86400 seconds..

Roberto

> On Tue, Sep 3, 2024 at 2:06=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > On Thu, 2024-08-29 at 16:28 -0700, Xingyu Li wrote:
> > > Here is the config file:
> > > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> >=20
> > Thanks, still cannot reproduce:
> >=20
> > 13151 ioctl(5, SIOCGIFINDEX, {ifr_name=3D"wpan0", ifr_ifindex=3D11}) =
=3D 0
> > 13151 close(5)                          =3D 0
> > 13151 sendto(4, [{nlmsg_len=3D36, nlmsg_type=3Dnl802154, nlmsg_flags=3D=
NLM_F_REQUEST|NLM_F_ACK, nlmsg_seq=3D0, nlmsg_pid=3D0}, "\x0b\x00\x00\x00\x=
08\x00\x03\x00\x0b\x00\x00\x00\x06\x00\x0a\x00\xa0\xaa\x00\x00"], 36, 0, {s=
a_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D00000000}, 12) =3D 36
> > 13151 recvfrom(4, [{nlmsg_len=3D56, nlmsg_type=3DNLMSG_ERROR, nlmsg_fla=
gs=3D0, nlmsg_seq=3D0, nlmsg_pid=3D13151}, {error=3D-EBUSY, msg=3D[{nlmsg_l=
en=3D36, nlmsg_type=3Dnl802154, nlmsg_flags=3DNLM_F_REQUEST|NLM_F_ACK, nlms=
g_seq=3D0, nlmsg_pid=3D0}, "\x0b\x00\x00\x00\x08\x00\x03\x00\x0b\x00\x00\x0=
0\x06\x00\x0a\x00\xa0\xaa\x00\x00"]}], 4096, 0, NULL, NULL) =3D 56
> >=20
> > I also get:
> >=20
> > [  824.654761] ieee802154 phy0 wpan0: encryption failed: -22
> > [  824.655606] ieee802154 phy1 wpan1: encryption failed: -22
> >=20
> > Roberto
> >=20
> > > On Thu, Aug 29, 2024 at 5:56=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > On 8/29/2024 12:53 PM, Xingyu Li wrote:
> > > > > The above syzkaller reproducer needs additional support. And here=
 is
> > > > > the C reproducer:
> > > > > https://gist.github.com/freexxxyyy/c3d1ccb8104af6b0d51ed50c29b363=
d3
> > > >=20
> > > > Hi Xingyu
> > > >=20
> > > > do you have a .config for testing?
> > > >=20
> > > > Thanks
> > > >=20
> > > > Roberto
> > > >=20
> > > > > On Sat, Aug 24, 2024 at 10:23=E2=80=AFPM Xingyu Li <xli399@ucr.ed=
u> wrote:
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > We found a bug in Linux 6.10. This is likely a mutex corruption=
 bug,
> > > > > > where the mutex's internal state has been compromised, leading =
to an
> > > > > > integrity check failure. The bug occurs in
> > > > > > https://elixir.bootlin.com/linux/v6.10/source/security/integrit=
y/ima/ima_main.c#L269.
> > > > > >=20
> > > > > > The bug report and syzkaller reproducer are as follows:
> > > > > >=20
> > > > > > Bug report:
> > > > > >=20
> > > > > > DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > > > > > WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> > > > > > __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> > > > > > WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> > > > > > __mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> > > > > > Modules linked in:
> > > > > > CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
> > > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.1=
5.0-1 04/01/2014
> > > > > > RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inlin=
e]
> > > > > > RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> > > > > > Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 =
e9 f4
> > > > > > ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 =
<0f> 0b
> > > > > > e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
> > > > > > RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
> > > > > > RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a=
00
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00
> > > > > > RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c7451=
9a
> > > > > > R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc00000000=
00
> > > > > > R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154ee=
b8
> > > > > > FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350e=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > >   <TASK>
> > > > > >   process_measurement+0x536/0x1ff0 security/integrity/ima/ima_m=
ain.c:269
> > > > > >   ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:5=
72
> > > > > >   security_file_post_open+0x51/0xb0 security/security.c:2982
> > > > > >   do_open fs/namei.c:3656 [inline]
> > > > > >   path_openat+0x2c0b/0x3580 fs/namei.c:3813
> > > > > >   do_filp_open+0x22d/0x480 fs/namei.c:3840
> > > > > >   do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
> > > > > >   do_sys_open fs/open.c:1428 [inline]
> > > > > >   __do_sys_openat fs/open.c:1444 [inline]
> > > > > >   __se_sys_openat fs/open.c:1439 [inline]
> > > > > >   __x64_sys_openat+0x243/0x290 fs/open.c:1439
> > > > > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
> > > > > >   entry_SYSCALL_64_after_hwframe+0x67/0x6f
> > > > > > RIP: 0033:0x7f903019a167
> > > > > > Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 =
00 85
> > > > > > c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 =
<48> 3d
> > > > > > 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
> > > > > > RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000101
> > > > > > RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a1=
67
> > > > > > RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff=
9c
> > > > > > RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 00000000000000=
01
> > > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000000=
00
> > > > > > R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 00000000000000=
00
> > > > > >   </TASK>
> > > > > >=20
> > > > > >=20
> > > > > > Syzkaller reproducer:
> > > > > > # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> > > > > > Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:=
false
> > > > > > NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> > > > > > KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjectio=
n:false
> > > > > > Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:tru=
e
> > > > > > HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:=
false
> > > > > > FaultCall:0 FaultNth:0}}
> > > > > > r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
> > > > > > ioctl$TIOCSETD(r0, 0x5423, 0x0)
> > > > > > mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000,=
 0x2,
> > > > > > 0x20031, 0xffffffffffffffff, 0x8000000)
> > > > > > mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000,=
 0xe,
> > > > > > 0x12, 0xffffffffffffffff, 0x0)
> > > > > > openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
> > > > > > write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
> > > > > > &(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d6=
58026b81bf264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca=
0233a0772b12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2=
ebeb2a6be6a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637=
f6bf58c53bc414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed=
9be400",
> > > > > > 0xb4)
> > > > > > r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
> > > > > > ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x=
0, 0x2,
> > > > > > [0x85, 0x8, 0x15, 0xd]})
> > > > > > ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)
> > > > > >=20
> > > > > >=20
> > > > > > --
> > > > > > Yours sincerely,
> > > > > > Xingyu
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20


