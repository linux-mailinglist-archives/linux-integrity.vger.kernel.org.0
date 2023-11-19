Return-Path: <linux-integrity+bounces-95-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD627F08E1
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 21:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCB280CD4
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078CA101DB;
	Sun, 19 Nov 2023 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLb6dVde"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C6DF4B
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 20:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B5C433C7
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 20:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700426149;
	bh=ox/Zv/pSYwrQSw17XMObIuNObHBwI5V6UZwBFwUfaik=;
	h=Date:Subject:From:To:From;
	b=nLb6dVdegiqWVDYvMnMnASyXscucP5jD/RnVPdXzR0PWx/8QXS94Sfr5Xo7wL3LZX
	 YJ/iyba7DKIupf2DdSaajk0JNIUk/86WkOagPg1FrUgZvFNb0ELhtprs4XyoZEIuJa
	 7dmq32+jNmE3MmULjbDrxQWhZ7T2CJEFKvPPZ+y7I6qvVMCW/tNCoy2z2JlIMRNtab
	 knWTkNEMl8VlzOiV5SL809y52SfH+PI9JlCDOgzkjTkQCEps8uF5/7xOiGoo7AjnuQ
	 5iU14CQ6o4H7x3iNSG60XCoZFo1zDCSduD+38FTgPf1dAn5q3fuXU8205aO5Ndi6e9
	 4zd7x0grN320Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Nov 2023 22:35:46 +0200
Message-Id: <CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org>
Subject: tpm_tis_spi_remove() triggers WARN_ON() in __flushwork (RPi3B+ and
 SLB9670)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2

Captured from serial link with Raspberry Pi 3B+ and Infineon SLB9670 TPM2 c=
hip, i.e.
triggers here:

static bool __flush_work(struct work_struct *work, bool from_cancel)
{
	struct wq_barrier barr;

	if (WARN_ON(!wq_online))
		return false;

	if (WARN_ON(!work->func)) /* <-- */
		return false;


# uname -a
Linux buildroot 6.6.1-v8 #1 SMP PREEMPT Sun Nov 19 21:46:00 EET 2023 aarch6=
4 GNU/Linux
# poweroff
# Stopping dropbear sshd: OK
Stopping network: [  246.487818] smsc95xx 3-1.1:1.0 eth0: hardware isn't ca=
pable of remote wakeup
OK
Stopping klogd: OK
Stopping syslogd: OK
Seeding 256 bits and crediting
Saving 256 bits of creditable seed for next boot
umount: devtmpfs busy - remounted read-only
[  246.623163] EXT4-fs (mmcblk0p2): re-mounted c5bb63df-c03e-4e4a-9846-0cdf=
5986edc4 ro. Quota mode: none.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to al[  248.680154] ------------[ cut here ]------------
[  248.684825] WARNING: CPU: 1 PID: 298 at kernel/workqueue.c:3400 __flush_=
work.isra.0+0x29c/0x2c4
[  248.693582] CPU: 1 PID: 298 Comm: init Tainted: G        W          6.6.=
1-v8 #1
[  248.700926] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
[  248.706780] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  248.713774] pc : __flush_work.isra.0+0x29c/0x2c4
[  248.718415] lr : __flush_work.isra.0+0x44/0x2c4
[  248.722970] sp : ffffffc0812fb910
[  248.726299] x29: ffffffc0812fb910 x28: ffffff8003e30e40 x27: 00000000000=
00000
[  248.733481] x26: fffffff0350c9c10 x25: 0000000000000000 x24: fffffff0350=
0c028
[  248.740661] x23: fffffff03500d208 x22: 0000000000000001 x21: fffffff034f=
37568
[  248.747840] x20: ffffff80064d9ac0 x19: ffffff80064d9a80 x18: fffffffffff=
fffff
[  248.755019] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc0812=
fb760
[  248.762197] x14: 0000000000000004 x13: ffffff8002808410 x12: 00000000000=
00000
[  248.769376] x11: 0000000000000040 x10: fffffff034f35a98 x9 : 00000000000=
00004
[  248.776554] x8 : ffffffc0812fb9a8 x7 : 0000000000000000 x6 : 00000000000=
003e8
[  248.783732] x5 : fffffff034e46000 x4 : 0000000000000000 x3 : 00000000000=
00000
[  248.790909] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 00000000000=
00000
[  248.798087] Call trace:
[  248.800546]  __flush_work.isra.0+0x29c/0x2c4
[  248.804841]  flush_work+0x10/0x1c
[  248.808177]  tpm_tis_remove+0x90/0xc8
[  248.811866]  tpm_tis_spi_remove+0x24/0x34
[  248.815901]  spi_remove+0x30/0x4c
[  248.819238]  device_remove+0x4c/0x80
[  248.822836]  device_release_driver_internal+0x1d4/0x228
[  248.828088]  device_release_driver+0x18/0x24
[  248.832381]  bus_remove_device+0xcc/0x10c
[  248.836421]  device_del+0x15c/0x41c
[  248.839934]  spi_unregister_device+0x48/0x98
[  248.844231]  __unregister+0x10/0x20
[  248.847742]  device_for_each_child+0x60/0xb4
[  248.852037]  spi_unregister_controller+0x48/0x15c
[  248.856768]  bcm2835_spi_remove+0x20/0x60
[  248.860804]  platform_shutdown+0x24/0x34
[  248.864751]  device_shutdown+0x150/0x258
[  248.868701]  kernel_power_off+0x38/0x7c
[  248.872563]  __do_sys_reboot+0x200/0x238
[  248.876511]  __arm64_sys_reboot+0x24/0x30
[  248.880546]  invoke_syscall+0x48/0x114
[  248.884324]  el0_svc_common.constprop.0+0x40/0xe0
[  248.889057]  do_el0_svc+0x1c/0x28
[  248.892397]  el0_svc+0x40/0xe8
[  248.895478]  el0t_64_sync_handler+0x100/0x12c
[  248.899864]  el0t_64_sync+0x190/0x194
[  248.903549] ---[ end trace 0000000000000000 ]---
[  248.910555] reboot: Power down

Just putting out. I was testing https://github.com/jarkkojs/buildroot-tpmdd=
/tree/linux-6.6.y
and this popped up. To build sdcard.img bootable with Raspberry Pi 3:

make raspberrypi3_tpmdd_64_defconfig && make

BR, Jarkko

