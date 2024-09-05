Return-Path: <linux-integrity+bounces-3440-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8B96CC97
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33489283367
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CD138490;
	Thu,  5 Sep 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="aQbaqrF6";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="T6D9okBm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0613A25B
	for <linux-integrity@vger.kernel.org>; Thu,  5 Sep 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503044; cv=none; b=J+mU+nIjm07DZOc7A1kVq1TV1s6nxEKm5TdAPQHkBCUAv5NjvunMDVFzitxIEQQdFnJ79A19WYqZ+kwqsac5MWsybbB7bX4czq9leZGZInQiF0g6GRHnOYtQlWJklTuVjqvTxiw9o2s7ZuUEJtic696VvUZ1XgQEfaZphBWuBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503044; c=relaxed/simple;
	bh=295VJDDIx0k3aqcgTI2v6fmbPOKY7bSVOov0KJ8yeWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaxBNNtlZ8OzqBdLl/w9mMUQIHSvQJ8ukQzqI7cMoeir1TH/28fkRxfWF6LlBf6sMHZfYWOkaTCOGf1bRnUJsR3KmiaErLob/mq2MacQqMcvjryg4nwjTu8ngvfmKnihHhp0NzWTpTyiNueSWl27QpvyIkZq+3oS2xKHtm4zpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=aQbaqrF6; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=T6D9okBm; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725503044; x=1757039044;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=295VJDDIx0k3aqcgTI2v6fmbPOKY7bSVOov0KJ8yeWc=;
  b=aQbaqrF66OX02BTrP5vSwni/Ibayj4ofl+RawCDvzakjYeAQf4zPsMJR
   LJAXmJR5hP2IEYKUPJ6Ef3RSbCJKYJk8yJaB9jfoZX7ZON19fbk+a5Fd5
   X9ApFyEH9C1g51h4O/7BMxT3tVSZ+eaXiDz47w7butTqnLimOTZaTtb3K
   MC86AoUeeLBCwWh113JCQvVOIWBuQ7iCApbt3GM9t7nXJwaGbbmxCl1/0
   yzwrU4o/xEzRmtSmkk4UABRex7uwX8z0gCW/FaoGEhKiIpnAGRpc07gMx
   LftCdGSwDAVGahGl0PqHHuSVUT7mZXDvjXKb4WxSg86JBtqOn3NbkOWla
   A==;
X-CSE-ConnectionGUID: TwAZpNgzTtW6ehcVPnvIcw==
X-CSE-MsgGUID: dAnmNGpqRWyNTHizMZylxw==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 19:24:03 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a049f9738fso2150655ab.3
        for <linux-integrity@vger.kernel.org>; Wed, 04 Sep 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725503041; x=1726107841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPgu7Fm8H6SKVI7ap9QRsrXTQgW0CU8PM935vq88hkQ=;
        b=T6D9okBmiE85p/g5wMWORf38SdNCgEcY19jGrYrs3heZH4IWX8/JKjc8QgSo5xq45+
         G11N/E2TWiPdjdqLWBTK9rOIUGvzWwDXI/W5hoRVdxI6lR5ZW7tUhWmi3GCfYVXn7kZ3
         6TDBNsGaT+PcdTsOHoFHYgaVxB/mDsKn0sx74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503041; x=1726107841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPgu7Fm8H6SKVI7ap9QRsrXTQgW0CU8PM935vq88hkQ=;
        b=QCfCfA8wvfVcPmvSgtMf3F7IwPRWhcHW86GfgtzAKOumtey2TVFBRdn8Hu6kbF3QDF
         5ce7ApjDNWNG1utqSwhT3xtcYgSt9Ji2m6Cy3rss6yt7AsvzaXx36Em4JZ9vzp/fl3m6
         tBQaCC26xS0WqubG6hqarWn2/qN60Uf7hScQIjVHycskvrG5WbbakxMPv3oSOBHhQczo
         /0ygX6IAmmGOh6AO6BZZTOfok8tl7k+u7PVQjoeecFQjFmtwRAb3P2Zb8b2KXKbAMZvb
         +ZktnDfpDcn7Nr2ZSm1dgkV6+RgkAIuublG1BihTvmVeljYTx2KuIJZX4YyDm5uNXx/2
         Fefg==
X-Forwarded-Encrypted: i=1; AJvYcCWKiFaeLx6jjEu/sCZfFVSYcwca4SkVCldIZXxA1UlHUDUvXJgxJuyZ/VMpfoSWP2B9Ewxk3tA+8Cl4DWIWHkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXe0L7DGSwf2ifVAk1xKfJD6UXTd4w82Z+qKG77C+yUv7iP1p
	5WfZB3k11G4xjDxCsVU9VOnaEwUNB2Hl60R0vfL7Y0krBaBQzARr5nbgKPVjQ1E1GQ12LGoSubc
	T9II+qoSMa7dCbGGQP32YPWGk4Lv7elGUUUy4v/XmULSkL2zGj8uYE8XC8ql+iYG3BUeuDkfREt
	nitsg8Kz4vsPz9YKpIkukEp2quRpsOzfaAAw7s9DTXJA==
X-Received: by 2002:a05:6e02:1a05:b0:39d:637f:97bc with SMTP id e9e14a558f8ab-39f4993f80emr202306385ab.0.1725503041141;
        Wed, 04 Sep 2024 19:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXRPYKbdt/Emh/HdShuuWr7cY95B3ldxQIfIHk/fIROIZMliUkkhh5VnEAeAr7sT+xXXhmcVQKS5BBwccCy7o=
X-Received: by 2002:a05:6e02:1a05:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-39f4993f80emr202306155ab.0.1725503040735; Wed, 04 Sep 2024
 19:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
 <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com>
 <3fbe1092-d0be-4e30-96a7-4ec72d65b013@huaweicloud.com> <CALAgD-47U+dZuVxoq9pSSpYk=Y6H6yTwmpe6iBmFBk-xCADW_w@mail.gmail.com>
 <70a434e017d75a94b5e246ad7a678b752fe97d30.camel@huaweicloud.com>
In-Reply-To: <70a434e017d75a94b5e246ad7a678b752fe97d30.camel@huaweicloud.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 4 Sep 2024 19:23:48 -0700
Message-ID: <CALAgD-6Q6rVARhuuj_6o=7sBXiaVWRmCrToHCRVffLrZmvZq2A@mail.gmail.com>
Subject: Re: WARNING in process_measurement
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is to set up the reproducing environment:
https://github.com/TomAPU/Linux610BugReort
It can reproduce on our end.

On Tue, Sep 3, 2024 at 2:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Thu, 2024-08-29 at 16:28 -0700, Xingyu Li wrote:
> > Here is the config file:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
>
> Thanks, still cannot reproduce:
>
> 13151 ioctl(5, SIOCGIFINDEX, {ifr_name=3D"wpan0", ifr_ifindex=3D11}) =3D =
0
> 13151 close(5)                          =3D 0
> 13151 sendto(4, [{nlmsg_len=3D36, nlmsg_type=3Dnl802154, nlmsg_flags=3DNL=
M_F_REQUEST|NLM_F_ACK, nlmsg_seq=3D0, nlmsg_pid=3D0}, "\x0b\x00\x00\x00\x08=
\x00\x03\x00\x0b\x00\x00\x00\x06\x00\x0a\x00\xa0\xaa\x00\x00"], 36, 0, {sa_=
family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D00000000}, 12) =3D 36
> 13151 recvfrom(4, [{nlmsg_len=3D56, nlmsg_type=3DNLMSG_ERROR, nlmsg_flags=
=3D0, nlmsg_seq=3D0, nlmsg_pid=3D13151}, {error=3D-EBUSY, msg=3D[{nlmsg_len=
=3D36, nlmsg_type=3Dnl802154, nlmsg_flags=3DNLM_F_REQUEST|NLM_F_ACK, nlmsg_=
seq=3D0, nlmsg_pid=3D0}, "\x0b\x00\x00\x00\x08\x00\x03\x00\x0b\x00\x00\x00\=
x06\x00\x0a\x00\xa0\xaa\x00\x00"]}], 4096, 0, NULL, NULL) =3D 56
>
> I also get:
>
> [  824.654761] ieee802154 phy0 wpan0: encryption failed: -22
> [  824.655606] ieee802154 phy1 wpan1: encryption failed: -22
>
> Roberto
>
> > On Thu, Aug 29, 2024 at 5:56=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > On 8/29/2024 12:53 PM, Xingyu Li wrote:
> > > > The above syzkaller reproducer needs additional support. And here i=
s
> > > > the C reproducer:
> > > > https://gist.github.com/freexxxyyy/c3d1ccb8104af6b0d51ed50c29b363d3
> > >
> > > Hi Xingyu
> > >
> > > do you have a .config for testing?
> > >
> > > Thanks
> > >
> > > Roberto
> > >
> > > > On Sat, Aug 24, 2024 at 10:23=E2=80=AFPM Xingyu Li <xli399@ucr.edu>=
 wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > We found a bug in Linux 6.10. This is likely a mutex corruption b=
ug,
> > > > > where the mutex's internal state has been compromised, leading to=
 an
> > > > > integrity check failure. The bug occurs in
> > > > > https://elixir.bootlin.com/linux/v6.10/source/security/integrity/=
ima/ima_main.c#L269.
> > > > >
> > > > > The bug report and syzkaller reproducer are as follows:
> > > > >
> > > > > Bug report:
> > > > >
> > > > > DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > > > > WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> > > > > __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> > > > > WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> > > > > __mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> > > > > Modules linked in:
> > > > > CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.=
0-1 04/01/2014
> > > > > RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
> > > > > RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> > > > > Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9=
 f4
> > > > > ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0=
f> 0b
> > > > > e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
> > > > > RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
> > > > > RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
> > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > > RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> > > > > R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
> > > > > R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
> > > > > FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >   <TASK>
> > > > >   process_measurement+0x536/0x1ff0 security/integrity/ima/ima_mai=
n.c:269
> > > > >   ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
> > > > >   security_file_post_open+0x51/0xb0 security/security.c:2982
> > > > >   do_open fs/namei.c:3656 [inline]
> > > > >   path_openat+0x2c0b/0x3580 fs/namei.c:3813
> > > > >   do_filp_open+0x22d/0x480 fs/namei.c:3840
> > > > >   do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
> > > > >   do_sys_open fs/open.c:1428 [inline]
> > > > >   __do_sys_openat fs/open.c:1444 [inline]
> > > > >   __se_sys_openat fs/open.c:1439 [inline]
> > > > >   __x64_sys_openat+0x243/0x290 fs/open.c:1439
> > > > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > >   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
> > > > >   entry_SYSCALL_64_after_hwframe+0x67/0x6f
> > > > > RIP: 0033:0x7f903019a167
> > > > > Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00=
 85
> > > > > c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <4=
8> 3d
> > > > > 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
> > > > > RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00101
> > > > > RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
> > > > > RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
> > > > > RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > > R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
> > > > >   </TASK>
> > > > >
> > > > >
> > > > > Syzkaller reproducer:
> > > > > # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> > > > > Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:fa=
lse
> > > > > NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> > > > > KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:=
false
> > > > > Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
> > > > > HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:fa=
lse
> > > > > FaultCall:0 FaultNth:0}}
> > > > > r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
> > > > > ioctl$TIOCSETD(r0, 0x5423, 0x0)
> > > > > mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0=
x2,
> > > > > 0x20031, 0xffffffffffffffff, 0x8000000)
> > > > > mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000, 0=
xe,
> > > > > 0x12, 0xffffffffffffffff, 0x0)
> > > > > openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
> > > > > write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
> > > > > &(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658=
026b81bf264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca02=
33a0772b12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2eb=
eb2a6be6a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6=
bf58c53bc414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9b=
e400",
> > > > > 0xb4)
> > > > > r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
> > > > > ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x0,=
 0x2,
> > > > > [0x85, 0x8, 0x15, 0xd]})
> > > > > ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)
> > > > >
> > > > >
> > > > > --
> > > > > Yours sincerely,
> > > > > Xingyu
> > > >
> > > >
> > > >
> > >
> >
> >
>


--=20
Yours sincerely,
Xingyu

