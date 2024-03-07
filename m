Return-Path: <linux-integrity+bounces-1648-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1F875763
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 20:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D9A1F220A4
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1A1EB56;
	Thu,  7 Mar 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLlje8YZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDD1DA2F;
	Thu,  7 Mar 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840547; cv=none; b=PxTqM7/CJCGB8n5Ua8zhfsHOoXbHNfoujMbUUkgF+o39UlzMLiwPIlMEf/kLQJCUjSAq1WqSix4EyTdL3DWcxu3NoJ2EJYOgy/GNqs8Pf8JuMu3GqDrspUJM1D4ZqGbPUq/vlVjrAheLgu+kr/26wj8BCSm5hqjLtYwwKrGiKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840547; c=relaxed/simple;
	bh=qz91IfpR2khWQBdc4b04wK10c+KwvPUkD0bnN50FDT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eob6Zy12NWyHb3PRUOZCnhvNGzPvPnmZjL2QHl5OcN0V9WZnfASzJWlQ/5YiG015c71Q8yx4XC2JQqM7mIkiqFo6w84hqyxG9xkG1SIQrqhXwhgb7zbBC7sFNs49NhD8o6XjZOxC2VIYaT24ermN0qqv8ZXlk1QUjd3a2N3lAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLlje8YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D198C433F1;
	Thu,  7 Mar 2024 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709840547;
	bh=qz91IfpR2khWQBdc4b04wK10c+KwvPUkD0bnN50FDT0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fLlje8YZKtbGPHjwWDZ8F+0QtG16vVPKZM+9izTtVCN9RGYOXEwFAC89LFl2fDU5P
	 ugUYDhfGkN4C73l5a8pG9oExc+0hj2/ErZKk3XdVazzVWpKiJcgO6UtfmMJeRdYpY3
	 d08hb9aCmofJvQAd4Y8AVPm+9rY4MhN+l22J+MpSQdI3IysZmKNL+Z5q0cZXTlVSTJ
	 XLlzid2gQghZYuYFL1+rP5pwdsnTy/7tKILx8zznXAaIPetlUwL8Ihk4ML54V+fNO5
	 eM2SV7wX3GLixfGmvVswCu7lYx24MtbyAdnE4U/zzOpXM+xOSQorE9HiQ+9HEUx2kI
	 Iw1fbuGoIJwUQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:42:24 +0200
Message-Id: <CZNRVY6T40AO.KP9YRYGKIP9Q@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, <linux-integrity@vger.kernel.org>,
 <regressions@lists.linux.dev>
Subject: Re: tpm_tis_remove: `WARNING: CPU: 6 PID: 265 at
 kernel/workqueue.c:3397 __flush_work.isra.0+0x29f/0x2c0`
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.17.0
References: <e2e17227-9e8f-430b-80fc-9ca9eac1f69a@molgen.mpg.de>
 <CYU446SNXUK4.23H8L9VRKXEFV@suppilovahvero>
 <ef39fcc6-a9a2-4662-9ee1-686539547252@molgen.mpg.de>
In-Reply-To: <ef39fcc6-a9a2-4662-9ee1-686539547252@molgen.mpg.de>

On Tue Mar 5, 2024 at 5:52 PM EET, Paul Menzel wrote:
> #regzbot fixed-by: d6fb14208e22c7bb6f54cb9df960bfc21e4663e3
>
> Dear Jarkko,
>
>
> Am 02.02.24 um 00:02 schrieb Jarkko Sakkinen:
> > On Tue Jan 16, 2024 at 4:44 PM EET, Paul Menzel wrote:
> >> #regzbot introduced: v5.15.131..v6.6.11
>
> >> On a Dell OptiPlex 5055 with an AMD Ryzen, Linux always logged the err=
or
> >>       tpm_tis: probe of MSFT0101:00 failed with error -1
> >>
> >> but upgrading from 5.15.131 to 6.6.11, the warning below is also logge=
d:
> >>
> >> ```
> >> [    0.000000] Linux version 6.6.11.mx64.460 (root@theinternet.molgen.=
mpg.de) (gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAM=
IC Thu Jan 11 16:15:43 CET 2024
> >> [    0.000000] Command line: BOOT_IMAGE=3D/boot/bzImage-6.6.11.mx64.46=
0 root=3DLABEL=3Droot ro crashkernel=3D64G-:256M console=3DttyS0,115200n8 c=
onsole=3Dtty0 init=3D/bin/systemd audit=3D0 random.trust_cpu=3Don systemd.u=
nified_cgroup_hierarchy
> >> [=E2=80=A6]
> >> [    0.000000] DMI: Dell Inc. OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1=
.20 05/31/2019
> >> [=E2=80=A6]
> >> [   12.092264] WARNING: CPU: 6 PID: 265 at kernel/workqueue.c:3397 __f=
lush_work.isra.0+0x29f/0x2c0
> >> [   12.103259] Modules linked in: snd_hda_intel(+) tg3(+) kvm(+) snd_i=
ntel_dspcfg snd_hda_codec snd_hda_core snd_pcm snd_timer libphy drm_ttm_hel=
per ttm snd video k10temp soundcore i2c_piix4 irqbypass tpm_tis(+) tpm_tis_=
core efi_pstore tpm wmi_bmof rng_core wmi crc32c_intel pstore acpi_cpufreq =
nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc efivarfs ip_tables=
 x_tables ipv6 autofs4
> >> [   12.143539] CPU: 6 PID: 265 Comm: systemd-udevd Not tainted 6.6.11.=
mx64.460 #1
> >> [   12.152698] Hardware name: Dell Inc. OptiPlex 5055 Ryzen CPU/0P03DX=
, BIOS 1.1.20 05/31/2019
> >> [   12.162512] RIP: 0010:__flush_work.isra.0+0x29f/0x2c0
> >> [   12.168674] Code: 8b 04 25 80 cf 02 00 48 89 44 24 40 48 8b 53 40 8=
b 43 30 e9 b3 fe ff ff 40 30 f6 4c 8b 36 e9 f2 fd ff ff 0f 0b e9 3b ff ff f=
f <0f> 0b e9 34 ff ff ff 0f 0b e9 d8 fe ff ff 0f 0b e9 a9 fe ff ff e8
> >> [   12.188375] RSP: 0018:ffffc90000ab7a10 EFLAGS: 00010246
> >> [   12.194699] RAX: 0000000000000000 RBX: ffff888108f79b28 RCX: 000000=
0000000000
> >> [   12.202894] RDX: ffffc90000ab7a10 RSI: ffffc90000b10008 RDI: ffffc9=
0000ab7a58
> >> [   12.211107] RBP: ffff888108f79b68 R08: 0000000000000002 R09: 000000=
0000000000
> >> [   12.219305] R10: 0000000000000001 R11: 0000000000000000 R12: 000000=
0000000001
> >> [   12.227499] R13: ffff888108f79b38 R14: 00000000ffffffff R15: 000000=
0000fe1050
> >> [   12.235706] FS:  00007f2cf22c2800(0000) GS:ffff88840eb80000(0000) k=
nlGS:0000000000000000
> >> [   12.244871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   12.251670] CR2: 00000000006878e8 CR3: 000000010ca66000 CR4: 000000=
00003506e0
> >> [   12.259901] Call Trace:
> >> [   12.263395]  <TASK>
> >> [   12.266521]  ? __warn+0x81/0x140
> >> [   12.270776]  ? __flush_work.isra.0+0x29f/0x2c0
> >> [   12.276235]  ? report_bug+0x171/0x1a0
> >> [   12.280803]  ? handle_bug+0x3c/0x70
> >> [   12.285352]  ? exc_invalid_op+0x17/0x70
> >> [   12.290203]  ? asm_exc_invalid_op+0x1a/0x20
> >> [   12.295397]  ? __flush_work.isra.0+0x29f/0x2c0
> >> [   12.300807]  tpm_tis_remove+0xaa/0x100 [tpm_tis_core]
> >> [   12.306872]  tpm_tis_core_init+0x234/0xfa0 [tpm_tis_core]
> >> [   12.313280]  tpm_tis_plat_probe+0xd0/0x110 [tpm_tis]
> >> [   12.319139]  platform_probe+0x44/0xa0
> >> [   12.323796]  really_probe+0xd0/0x3e0
> >> [   12.328384]  ? __pfx___driver_attach+0x10/0x10
> >> [   12.334129]  __driver_probe_device+0x80/0x160
> >> [   12.339803]  driver_probe_device+0x1f/0x90
> >> [   12.344831]  __driver_attach+0xf8/0x1c0
> >> [   12.349568]  bus_for_each_dev+0x88/0xd0
> >> [   12.354298]  bus_add_driver+0xf9/0x220
> >> [   12.358919]  driver_register+0x59/0x100
> >> [   12.363623]  ? __pfx_init_tis+0x10/0x10 [tpm_tis]
> >> [   12.369198]  init_tis+0x39/0xff0 [tpm_tis]
> >> [   12.374172]  ? srso_return_thunk+0x5/0x10
> >> [   12.379044]  do_one_initcall+0x66/0x240
> >> [   12.383751]  do_init_module+0x60/0x230
> >> [   12.388357]  init_module_from_file+0x86/0xc0
> >> [   12.393483]  idempotent_init_module+0x120/0x2b0
> >> [   12.398869]  __x64_sys_finit_module+0x65/0xc0
> >> [   12.404082]  do_syscall_64+0x46/0x90
> >> [   12.408506]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> >> [   12.414411] RIP: 0033:0x7f2cf1d1ed09
> >> [   12.418831] Code: 08 44 89 e0 5b 41 5c c3 66 0f 1f 84 00 00 00 00 0=
0 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 0=
5 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 20 0d 00 f7 d8 64 89 01 48
> >> [   12.438506] RSP: 002b:00007ffc335d02f8 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000139
> >> [   12.446965] RAX: ffffffffffffffda RBX: 0000000000674390 RCX: 00007f=
2cf1d1ed09
> >> [   12.454993] RDX: 0000000000000000 RSI: 00007f2cf1a0f54b RDI: 000000=
0000000010
> >> [   12.463013] RBP: 00007f2cf1a0f54b R08: 0000000000000000 R09: 000000=
0000000002
> >> [   12.471025] R10: 0000000000000010 R11: 0000000000000246 R12: 000000=
0000000000
> >> [   12.479059] R13: 00000000007700f0 R14: 0000000000020000 R15: 000000=
0000679d90
> >> [   12.487092]  </TASK>
> >> [   12.490162] ---[ end trace 0000000000000000 ]---
> >> [   12.498048] tpm_tis: probe of MSFT0101:00 failed with error -1
> >> ```
> >>
> >> ```
> >> $ scripts/decodecode < /scratch/tmp/linux-6.6.11-schokokeks.txt
> >> [ 12.418831] Code: 08 44 89 e0 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 =
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 =
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 20 0d 00 f7 d8 64 89 01 48
> >> All code
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>      0:	08 44 89 e0          	or     %al,-0x20(%rcx,%rcx,4)
> >>      4:	5b                   	pop    %rbx
> >>      5:	41 5c                	pop    %r12
> >>      7:	c3                   	ret
> >>      8:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
> >>      f:	00 00
> >>     11:	48 89 f8             	mov    %rdi,%rax
> >>     14:	48 89 f7             	mov    %rsi,%rdi
> >>     17:	48 89 d6             	mov    %rdx,%rsi
> >>     1a:	48 89 ca             	mov    %rcx,%rdx
> >>     1d:	4d 89 c2             	mov    %r8,%r10
> >>     20:	4d 89 c8             	mov    %r9,%r8
> >>     23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
> >>     28:	0f 05                	syscall
> >>     2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- tr=
apping instruction
> >=20
> > There's something odd in this disassembly given the "syscall" opcode.
> >=20
> >>     30:	73 01                	jae    0x33
> >>     32:	c3                   	ret
> >>     33:	48 8b 0d c7 20 0d 00 	mov    0xd20c7(%rip),%rcx        # 0xd21=
01
> >>     3a:	f7 d8                	neg    %eax
> >>     3c:	64 89 01             	mov    %eax,%fs:(%rcx)
> >>     3f:	48                   	rex.W
> >>
> >> Code starting with the faulting instruction
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>      0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
> >>      6:	73 01                	jae    0x9
> >>      8:	c3                   	ret
> >>      9:	48 8b 0d c7 20 0d 00 	mov    0xd20c7(%rip),%rcx        # 0xd20=
d7
> >>     10:	f7 d8                	neg    %eax
> >>     12:	64 89 01             	mov    %eax,%fs:(%rcx)
> >>     15:	48                   	rex.W
> >> ```
> >>
> >> Please find all the Linux messages attached. Bisecting is unfortunatel=
y
> >> not easily doable.
>
> > I reported a workqueue flush issue while ago but had forgotten it:
> >=20
> > https://lore.kernel.org/all/CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org/f
> >=20
> > However, Lino sent a fix for it:
> >=20
> > https://lore.kernel.org/linux-integrity/20240201113646.31734-1-l.sanfil=
ippo@kunbus.com/
> >=20
> > Would be useful to know if that is the same wq issue also here.
>
> Yes, commit d6fb14208e22 (tpm,tpm_tis: Avoid warning splat at shutdown)=
=20
> on top of Linux 6.8-rc7+ (also a unrelated USB patch) fixed it on the=20
> Dell OptiPlex 5055.

OK, good to hear and thank you for reporting this!

BR, Jarkko

