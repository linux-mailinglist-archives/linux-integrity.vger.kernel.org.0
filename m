Return-Path: <linux-integrity+bounces-3431-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB196536C
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF28284478
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20D18E779;
	Thu, 29 Aug 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Py56t9NR";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="gMX8FMpF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98818E776
	for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974141; cv=none; b=thduJt0xPOOd9BT6HjYsVLMrZ851ckPQNu7HWJazNS3NM9spVHKSdvHex5a7vP0YjIXlbj7PbEbPNljlSmZunvdTN+FNWQG5gnwfUjEPiArCPQJRUvaxZbWIPltBDH18qsdtu+VKoqnVHNSbFQRqHUILn4uizfAVRmkV485hRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974141; c=relaxed/simple;
	bh=o7TxbGOuYb6+2NV9KDNCzI2PYElkRPUUbRTEqJkS/w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1YUCL9msyaD7Q/tjnFPWvSOPWn3EDvOwhKX07ttApcMOEK+KtYcHCryEnNYDnUb1SePpu4wnUUC9CNj7Kt5B68SNb2L9AnetgciEXTZM7/3cALmqyQqaj67JiokRLLpu5jYcFF3mvYxiuKkrDIDZHq5DetLSK/rDaqvqO8uWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Py56t9NR; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=gMX8FMpF; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724974138; x=1756510138;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=o7TxbGOuYb6+2NV9KDNCzI2PYElkRPUUbRTEqJkS/w4=;
  b=Py56t9NRJkW4IM1X63m+99hBeZbU9HI5o9CKoC9FtJ7IsSjw+9AygFMI
   6jEZRSPAc8PXF40NDhvRlyUZLWTwu6HN2LWWgQuLf2jWI3PXD0uPiU7mQ
   xqjeyNukPNGwUsRYiLWygl440vkh2XMVzrpsK//yS7ymuD87xA4wL6Ktk
   G87Jio5+H+BRUiTFs1pwcaQKlsxaL2OkyBddmaPnt2OJSV6FQPfigBnQC
   ffHrO0fmM4bdk6PgAzrHQzwxUqjUNoBibraKDDwo5JWYRVLkHK+w1/lbo
   xitnj71TST0z6sIuh9yM7w9XZHFKUOxNXVfxrDkydG8XfHAwZm1UDqhHK
   w==;
X-CSE-ConnectionGUID: uhiD69sDQcaC11ciyG6U8w==
X-CSE-MsgGUID: S0RUsURATM6aDrkn9IQAzA==
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 16:28:51 -0700
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7cd9604169eso1179196a12.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2024 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724974131; x=1725578931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eXCCEcvkF/OtTcfqtjGA5y/ytVcRP5BmWe5mmszibo=;
        b=gMX8FMpFGetRD+LatlMP3jP+Zqov62BgnL0ClQMYTOvSx/Kt31zFSJqklW+CSQU1T7
         76QRwW5Mtwv0qn5aQMkBLEbGrCj7b1aFPfRQQgSAbB3TOpXcJdbrjyTZbEBNlFGf0bhs
         4fuC1PPl1+IKJwvxMra8YewEOxdpO9vuCsvAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974131; x=1725578931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eXCCEcvkF/OtTcfqtjGA5y/ytVcRP5BmWe5mmszibo=;
        b=flNrgr06Epto2zSsBSG2TFQ82I9wrDaJ9kUe5HORimEdZVKkgPUWd36aN08Bn5ULox
         t9uBnNhW+qGO65fwziTQ9IEoE5RXdO+mVySh55POquLfRZZ1wHFjcCKHW9FnPL2q1rJW
         ZMTIqHXmF2j6SZGNWTyUoNBEACb0W/tIrfS93KuTM5FocrXp/aGlIiMayNv9qMaSfZaN
         4J0HOqXSgTmmIpGx/EiEha3jZKcqa+iQQPVhP2Q0eMMAoyVUL0sl8qiqnkAKe4/cQg4f
         zr0Af2tUbxJxfR6TYEs0xpbNMzgK505WEw6mymeopf3mGfTzgXyk5G0xdRaF2StBjJuY
         h/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKUWUA+syPuJNYxafC62cXXmzzVio3SqHIOTvBqmgjzpaKO18Ed4Ne3vEvUr0rVe+QvW2UnudAWxkmp20A7Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMyLlslFyNZ8dsUFgP4LG6cLuE591L+F7uzOuVPNi+qYwcYg7
	hdajAP5CtxweN/UaX8IF/L9FtShSnnk9et+IgBhPSQeZ53fFMJ7A4eILOXq98zucnX+8gIrTz+P
	gIuKP12ISWYbMMgHVnOdAdSdskMYwgciNfBIg8lPcwYwJrPZIDR6wSuJBh3Y4OO6oHiM4EP4nBn
	26p6UJ936ZFhJOqyt/FrFWrVbnMSOLZXgD2TIMVOhqWFeRTy/z5evcrdY=
X-Received: by 2002:a17:90b:17d2:b0:2d3:ce96:eb62 with SMTP id 98e67ed59e1d1-2d8564ad328mr4710858a91.38.1724974130739;
        Thu, 29 Aug 2024 16:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ftCTWqvGu2AgybuH2oVhw2/tz7HkoHLaFXJSqIW4v/qhGsDpQ+9aZhRhxQLQqyKX/2caJqmY3w718JAC2pQ=
X-Received: by 2002:a17:90b:17d2:b0:2d3:ce96:eb62 with SMTP id
 98e67ed59e1d1-2d8564ad328mr4710844a91.38.1724974130377; Thu, 29 Aug 2024
 16:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
 <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com> <3fbe1092-d0be-4e30-96a7-4ec72d65b013@huaweicloud.com>
In-Reply-To: <3fbe1092-d0be-4e30-96a7-4ec72d65b013@huaweicloud.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 16:28:39 -0700
Message-ID: <CALAgD-47U+dZuVxoq9pSSpYk=Y6H6yTwmpe6iBmFBk-xCADW_w@mail.gmail.com>
Subject: Re: WARNING in process_measurement
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

On Thu, Aug 29, 2024 at 5:56=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On 8/29/2024 12:53 PM, Xingyu Li wrote:
> > The above syzkaller reproducer needs additional support. And here is
> > the C reproducer:
> > https://gist.github.com/freexxxyyy/c3d1ccb8104af6b0d51ed50c29b363d3
>
> Hi Xingyu
>
> do you have a .config for testing?
>
> Thanks
>
> Roberto
>
> > On Sat, Aug 24, 2024 at 10:23=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wro=
te:
> >>
> >> Hi,
> >>
> >> We found a bug in Linux 6.10. This is likely a mutex corruption bug,
> >> where the mutex's internal state has been compromised, leading to an
> >> integrity check failure. The bug occurs in
> >> https://elixir.bootlin.com/linux/v6.10/source/security/integrity/ima/i=
ma_main.c#L269.
> >>
> >> The bug report and syzkaller reproducer are as follows:
> >>
> >> Bug report:
> >>
> >> DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> >> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> >> __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> >> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> >> __mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> >> Modules linked in:
> >> CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 0=
4/01/2014
> >> RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
> >> RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> >> Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9 f4
> >> ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0f> 0b
> >> e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
> >> RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
> >> RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> >> R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
> >> R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
> >> FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   <TASK>
> >>   process_measurement+0x536/0x1ff0 security/integrity/ima/ima_main.c:2=
69
> >>   ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
> >>   security_file_post_open+0x51/0xb0 security/security.c:2982
> >>   do_open fs/namei.c:3656 [inline]
> >>   path_openat+0x2c0b/0x3580 fs/namei.c:3813
> >>   do_filp_open+0x22d/0x480 fs/namei.c:3840
> >>   do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
> >>   do_sys_open fs/open.c:1428 [inline]
> >>   __do_sys_openat fs/open.c:1444 [inline]
> >>   __se_sys_openat fs/open.c:1439 [inline]
> >>   __x64_sys_openat+0x243/0x290 fs/open.c:1439
> >>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
> >>   entry_SYSCALL_64_after_hwframe+0x67/0x6f
> >> RIP: 0033:0x7f903019a167
> >> Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85
> >> c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> >> 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
> >> RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> >> RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
> >> RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
> >> RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
> >>   </TASK>
> >>
> >>
> >> Syzkaller reproducer:
> >> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> >> Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
> >> NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> >> KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
> >> Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
> >> HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false
> >> FaultCall:0 FaultNth:0}}
> >> r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
> >> ioctl$TIOCSETD(r0, 0x5423, 0x0)
> >> mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0x2,
> >> 0x20031, 0xffffffffffffffff, 0x8000000)
> >> mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000, 0xe,
> >> 0x12, 0xffffffffffffffff, 0x0)
> >> openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
> >> write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
> >> &(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b8=
1bf264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a07=
72b12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6=
be6a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c=
53bc414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400"=
,
> >> 0xb4)
> >> r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
> >> ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
> >> [0x85, 0x8, 0x15, 0xd]})
> >> ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)
> >>
> >>
> >> --
> >> Yours sincerely,
> >> Xingyu
> >
> >
> >
>


--=20
Yours sincerely,
Xingyu

