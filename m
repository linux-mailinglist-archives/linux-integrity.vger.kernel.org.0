Return-Path: <linux-integrity+bounces-3376-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF295E216
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 07:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC12B2811CC
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 05:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0472BB0D;
	Sun, 25 Aug 2024 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qIGEKuyJ";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QKxExIX2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F001D69E
	for <linux-integrity@vger.kernel.org>; Sun, 25 Aug 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724563409; cv=none; b=kqF/+lghTJdUiqitPyH3l5mm4YfcWZxd7zy1RI3rvt0Tvs2EyQKp08mJDsuf6HCRD5jwvT/LVhUfl9Vp7R1D7cDqre6aBFJHKZOjH7w9ExHMxklpEnD+VzU0qxjV0ivw4qA4hDwMnwkweCE8UTfYhdaYjimZ7zYAbyKJof5bXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724563409; c=relaxed/simple;
	bh=5bRKrr+T/+bhtWSuhnwGY6n4BSJoLjmfHeNbXUOCK9A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=URiArnijlAETwOAw6wxzIfFw87OFpobpywT8e6NEcUi4b3iPmHUttU3EM7b+aC3f91nbWDEerACENpb29xUcus7ZR3Um5YjqWz1snb2sTKbnyHsQ2+ZL/2Lk0zzXpAWwpBeVgc06bwJoP+pdV7aUd7cFcxszGuhy/kQB4zKodqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=qIGEKuyJ; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QKxExIX2; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724563409; x=1756099409;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=5bRKrr+T/+bhtWSuhnwGY6n4BSJoLjmfHeNbXUOCK9A=;
  b=qIGEKuyJKM+gHDDyFicaSataHIs0J9Df23pDxjRhTaCPE1gxJHCtRH9e
   R3GeCMdbX47MefxT64kPnDih5bxkd7Yht/hYNW3Q09Va81HghuN/RnJsn
   ZQSedLK1U4TTCNcNHh5AopdXR7PztZkMXaMw2SA+sJxE0bh+nohCztsmS
   A/ZGNMoINc25+RGYYFHJUCddI7X96d4VJIGxondzploG1n/ePbPIC7/ls
   rVQmlFGfLCwpJ6iCxYuXr0+7BB8ZZbLFhg98xSmUr+jdWGHpIFpWGi0dY
   8brejMLILpqSxODt/54vl0iBVpB5oCbRRZGqoFrUAyhQm5yW59G4ERAD1
   g==;
X-CSE-ConnectionGUID: tkhiTIIvRnWYYwOMqQ4XcQ==
X-CSE-MsgGUID: QzC50qfjRxums73k5lfnNQ==
Received: from mail-ot1-f71.google.com ([209.85.210.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:23:28 -0700
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7092fa5079eso3538117a34.2
        for <linux-integrity@vger.kernel.org>; Sat, 24 Aug 2024 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724563407; x=1725168207; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx/YNFW2qlZwtm15Rp0Dif01ECRBK53Yl/ExQSV8X9c=;
        b=QKxExIX2yweeZk9skpXHW8ez3QUcaMGaSXNSd/To60byA86Gjci3fYEJM9boK1uX57
         wDkJVUqiEx9FoNC+XB7vFs2pCVtiXWX8Wf/H+LbSdZXsB4S2Y47QKqlWiG7ybsfJYA6n
         BNrXwg6jPZGC3wEDVQY82ZkMPT+MW9FdYJp0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724563407; x=1725168207;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx/YNFW2qlZwtm15Rp0Dif01ECRBK53Yl/ExQSV8X9c=;
        b=oksZIizFFx6vayz2iLCzyldqpmj/seMWv4sxFdr0OTTXB7bzVPXGp3qfceBuJtseUn
         FQ72j3E0pjD0POEiop9MDAiAVAI7PRxAWAjdv3Eo0U1LevkG2OQXQZ25UK9qqnZ2ygFu
         Dv3JmKzlqsWaZgvULrG1odakaCYeeabJ6LhGJ4rLI2f2xr+JKfwJY57USBIExz5WRNsA
         eixoStbNAreKrIEdlif1sxNWVWtf/63AK4aol6RQrOtx5xJNiiIA1H73WEWqf5Oiqi0U
         aFW8EEkVoDORkoMPPtSLgvQFLWWgrVYq3GyRp29aEj1dM5wX3d3MnOVpBi3rfg8Y4LWf
         eh2g==
X-Forwarded-Encrypted: i=1; AJvYcCUEzs4vtfDaBkme8B6wp3rfvPHE3hUuYv89X7Ma8IypzwkIOuZsOCMKDg2HJC52NQbJtx8SH+/WiZ+Q3Yfk1z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeS8TOlEEWxA0NImnPYT3FCYb/0hhcaSZy2P0Kkz1m1op10STG
	INyYQ2m8TTPDVs/AikpOcVj++dYR5sovWrGQS1J+bQTvw580LrczgfsHtaD+8QsUtbN0uZJS4a/
	dd9W9z6obq9Kk+99ja0DPQbq6nuhQFrpAoPp3vNx1USI8ogvYr/3EhjAj/UCF1dolk2vRSujte1
	xFwQYMrqh53LnkKIuaNtkwvRJtTpCVKRiA6Ck6x4lT6g==
X-Received: by 2002:a05:6830:d8b:b0:709:3fb0:3bee with SMTP id 46e09a7af769-70e0ec110e4mr9872726a34.27.1724563406750;
        Sat, 24 Aug 2024 22:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBiMSgpHxK06kD9SbKkHv+QsYVEql8gZ8Qo1CNJ+QEw5jIlBgYUTA/WOvCzDBatR/JWP2fjNfem28jbFF+WCg=
X-Received: by 2002:a05:6830:d8b:b0:709:3fb0:3bee with SMTP id
 46e09a7af769-70e0ec110e4mr9872711a34.27.1724563406431; Sat, 24 Aug 2024
 22:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:23:16 -0700
Message-ID: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
Subject: WARNING in process_measurement
To: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10. This is likely a mutex corruption bug,
where the mutex's internal state has been compromised, leading to an
integrity check failure. The bug occurs in
https://elixir.bootlin.com/linux/v6.10/source/security/integrity/ima/ima_ma=
in.c#L269.

The bug report and syzkaller reproducer are as follows:

Bug report:

DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
__mutex_lock_common kernel/locking/mutex.c:587 [inline]
WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
Modules linked in:
CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9 f4
ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0f> 0b
e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_measurement+0x536/0x1ff0 security/integrity/ima/ima_main.c:269
 ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x51/0xb0 security/security.c:2982
 do_open fs/namei.c:3656 [inline]
 path_openat+0x2c0b/0x3580 fs/namei.c:3813
 do_filp_open+0x22d/0x480 fs/namei.c:3840
 do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f903019a167
Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85
c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
 </TASK>


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false
FaultCall:0 FaultNth:0}}
r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
ioctl$TIOCSETD(r0, 0x5423, 0x0)
mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0x2,
0x20031, 0xffffffffffffffff, 0x8000000)
mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000, 0xe,
0x12, 0xffffffffffffffff, 0x0)
openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})
ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)


--=20
Yours sincerely,
Xingyu

