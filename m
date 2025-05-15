Return-Path: <linux-integrity+bounces-6231-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044FAB892A
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED644E7FB0
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAE19B5B1;
	Thu, 15 May 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCbMRyZ0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87B1F0E2E
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318734; cv=none; b=aM48Iqrbw6oiwF+s9Eh3ZLz305h0dZUsB0zXAyga/D3JntUDGw2F4hBxeTI30Bd5lM608+rkfs/a8iNz64D6p0EY7+LsgcnRgQ3ZhhhFxU70SIe4aIiYe4LELC0p7IdOSvlHW3V4KqqGVlyNZE5EQgoJmCYN4+89iMy1KOXZ9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318734; c=relaxed/simple;
	bh=7RP6wYucKH7UVbjeTDkM6PaR7e4TAM0tP0XV+/ob1H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK2Bd/TQ5tUaJ2O4GlVWoc0GiABunnZK0sdNrkwQy9SShperXYz+TzhpolHOYN26ajHXBPoKmcP/Z6731oMk9USEZEYWu/ZoX69vvo7EDkJSZL0IsaLhOzEk7f91Tr5SX1LHR2HrIm5leOquWi7IqTOtw5rvnOLOuHqWIGTVk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCbMRyZ0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 May 2025 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747318727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lprUvIDml9cRgjBHOPyVJqtirYwrYrEUi6NIpGywWC4=;
	b=oCbMRyZ0lRsOVNhs/m7bKNLx4aSx3bNLZK1w1TMlvE8LJl8mZHoRacMfQPZV4ClBlkzNXO
	rCU3lk4olXDhSZxrG8m9DUWRk2xQhbccOOVRFdFXXVhcJ5/2NRf4SKgq0flxUsosLOqa24
	PxdDIHTYGogwMnbgzrtyX0tVx6oKFvE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com, linux-bcachefs@vger.kernel.org
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
Message-ID: <rbab6axciiuomrann3uwvpks2zogx3xfntk7w4p2betq3morlf@5xnl5guhnaxj>
References: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
 <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 15, 2025 at 04:06:02PM +0200, Roberto Sassu wrote:
> On Wed, 2025-05-14 at 07:54 -0700, syzbot wrote:
> > Hello,
> 
> + Kent, bcachefs mailing list
> 
> I have the feeling that this was recently fixed in one of the latest
> pull requests in bcachefs. I don't see it occurring anymore, and there
> are more commits after the one reported by syzbot.

I have no idea how any of the ima stuff works or even what it does, I'm
not even sure where I'd start...

> 
> Roberto
> 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11169670580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9dc42c34a3f5c357
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3f0b3970f154dfc95e6e
> > compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1574d768580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5ca57f5a3f77/disk-02ddfb98.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3f23cbc11e68/vmlinux-02ddfb98.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/73e63afac354/bzImage-02ddfb98.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/0afd18737aed/mount_2.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com
> > 
> > bcachefs (loop2): going read-write
> > bcachefs (loop2): done starting filesystem
> > =====================================================
> > BUG: KMSAN: uninit-value in ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inline]
> > BUG: KMSAN: uninit-value in ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.c:191
> >  ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inline]
> >  ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.c:191
> >  ima_store_template security/integrity/ima/ima_api.c:122 [inline]
> >  ima_store_measurement+0x388/0x970 security/integrity/ima/ima_api.c:383
> >  process_measurement+0x3075/0x40e0 security/integrity/ima/ima_main.c:393
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > <Zero or more stacks not recorded to save memory>
> > 
> > Uninit was stored to memory at:
> >  sha256_transform lib/crypto/sha256.c:117 [inline]
> >  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_finalize include/crypto/sha256_base.h:101 [inline]
> >  __sha256_final lib/crypto/sha256.c:142 [inline]
> >  sha256_final+0x169/0x460 lib/crypto/sha256.c:148
> >  crypto_sha256_final+0xca/0x120 crypto/sha256_generic.c:49
> >  crypto_shash_final+0x72/0xa0 crypto/shash.c:58
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  sha256_transform lib/crypto/sha256.c:117 [inline]
> >  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> >  sha256_transform lib/crypto/sha256.c:91 [inline]
> >  sha256_transform_blocks+0xded/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> >  sha256_transform lib/crypto/sha256.c:92 [inline]
> >  sha256_transform_blocks+0xe00/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> >  sha256_transform lib/crypto/sha256.c:93 [inline]
> >  sha256_transform_blocks+0xe15/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  LOAD_OP lib/crypto/sha256.c:56 [inline]
> >  sha256_transform lib/crypto/sha256.c:82 [inline]
> >  sha256_transform_blocks+0x268b/0x2880 lib/crypto/sha256.c:127
> >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was stored to memory at:
> >  memcpy_to_iter lib/iov_iter.c:65 [inline]
> >  iterate_kvec include/linux/iov_iter.h:86 [inline]
> >  iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
> >  iterate_and_advance include/linux/iov_iter.h:328 [inline]
> >  _copy_to_iter+0x176c/0x32f0 lib/iov_iter.c:185
> >  copy_page_to_iter+0x43c/0x8b0 lib/iov_iter.c:362
> >  copy_folio_to_iter include/linux/uio.h:198 [inline]
> >  filemap_read+0xced/0x2190 mm/filemap.c:2753
> >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Uninit was created at:
> >  __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:4993
> >  alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2301
> >  alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
> >  alloc_pages_noprof mm/mempolicy.c:2392 [inline]
> >  folio_alloc_noprof+0x109/0x360 mm/mempolicy.c:2402
> >  filemap_alloc_folio_noprof+0x9d/0x420 mm/filemap.c:1007
> >  ractl_alloc_folio mm/readahead.c:186 [inline]
> >  ra_alloc_folio mm/readahead.c:441 [inline]
> >  page_cache_ra_order+0x93f/0x14f0 mm/readahead.c:509
> >  page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
> >  filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
> >  filemap_read+0x5c6/0x2190 mm/filemap.c:2702
> >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >  security_file_post_open+0xbf/0x530 security/security.c:3130
> >  do_open fs/namei.c:3882 [inline]
> >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> >  do_filp_open+0x280/0x660 fs/namei.c:4066
> >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> >  do_sys_open fs/open.c:1444 [inline]
> >  __do_sys_openat fs/open.c:1460 [inline]
> >  __se_sys_openat fs/open.c:1455 [inline]
> >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > CPU: 0 UID: 0 PID: 7337 Comm: syz.2.106 Not tainted 6.15.0-rc3-syzkaller-00094-g02ddfb981de8 #0 PREEMPT(undef) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > =====================================================
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> 

