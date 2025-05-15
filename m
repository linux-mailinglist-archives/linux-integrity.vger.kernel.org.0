Return-Path: <linux-integrity+bounces-6233-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBCAB89D3
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F911BC450A
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66631FECD3;
	Thu, 15 May 2025 14:48:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2921D6DBB;
	Thu, 15 May 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320537; cv=none; b=OPn1oGqcy6joUN5CkVNTQXHXr4spOkl49yIKB0ce6gIGX319KOI/qIuX8W/41kXLWM0wOkGhggZuKTym7NtkAj79gs4OH/UG919btGUM49nIgBouULmEhcQn8mw8b8a55IYu19ZYd4nRhM8O2HT4HW25p2xYWcx00Rwvn//9ToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320537; c=relaxed/simple;
	bh=Irf9KTr91lgvDqzQQpTqY41RXszgE9NL8pJejmSkLMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gz4TFnXUW4Xwg2mdEftasYdNJtTFERMzrTdbGfaPui1I4gh7RundSPuYEzlOJqb+YMDJtl88I60cT46y59RnLwTeP874OxYFWR35i3aJKbpK2ztr6LF9r8kALzoUUW9e1z/l+IHV1si1t/TnwDJQ3dWlLS7tYBDUZg6NOj3o1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4Zyszz5c3pzpTXw;
	Thu, 15 May 2025 22:29:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E9F9C1400DD;
	Thu, 15 May 2025 22:30:27 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3e0p1+iVoC5rtBw--.45574S2;
	Thu, 15 May 2025 15:30:26 +0100 (CET)
Message-ID: <576e10238d83f725fbe23c4af63be6e83de9ce48.camel@huaweicloud.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, paul@paul-moore.com, 
 roberto.sassu@huawei.com, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com,  zohar@linux.ibm.com,
 linux-bcachefs@vger.kernel.org
Date: Thu, 15 May 2025 16:30:09 +0200
In-Reply-To: <rbab6axciiuomrann3uwvpks2zogx3xfntk7w4p2betq3morlf@5xnl5guhnaxj>
References: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
	 <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
	 <rbab6axciiuomrann3uwvpks2zogx3xfntk7w4p2betq3morlf@5xnl5guhnaxj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD3e0p1+iVoC5rtBw--.45574S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCw1rWr48GFW5CF47Jr4ktFb_yoW8ur4fWo
	Za9ws3Cr45JFW3JFW0yFsFvw4fua1rXrW3ZrWv93y5KF4av34UGryrAF1UJF43Zr43WF18
	X347tF9YqF9rKw1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY-7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07boa0PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGglkmAGWwAAst

On Thu, 2025-05-15 at 10:18 -0400, Kent Overstreet wrote:
> On Thu, May 15, 2025 at 04:06:02PM +0200, Roberto Sassu wrote:
> > On Wed, 2025-05-14 at 07:54 -0700, syzbot wrote:
> > > Hello,
> >=20
> > + Kent, bcachefs mailing list
> >=20
> > I have the feeling that this was recently fixed in one of the latest
> > pull requests in bcachefs. I don't see it occurring anymore, and there
> > are more commits after the one reported by syzbot.
>=20
> I have no idea how any of the ima stuff works or even what it does, I'm
> not even sure where I'd start...

Basically, I got a clue that bcachefs would be the cause from the
bottom of the report:

 page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
 filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
 filemap_read+0x5c6/0x2190 mm/filemap.c:2702
 bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
 __kernel_read+0x750/0xda0 fs/read_write.c:528
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28

This means that IMA is reading a file and calculating a digest over it:

 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613

syzbot is complaining that the data the digest was calculated from was
not initialized (e.g. zeroed).

There is a reproducer, we would be probably able to do a bisection and
find the commit that caused it (and maybe the one that fixed it).

Roberto

> > Roberto
> >=20
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kern=
el.or..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D111696705=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9dc42c34a=
3f5c357
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0b3970f15=
4dfc95e6e
> > > compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef=
89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1574d76=
8580000
> > >=20
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/5ca57f5a3f77=
/disk-02ddfb98.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/3f23cbc11e68/vm=
linux-02ddfb98.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/73e63afac3=
54/bzImage-02ddfb98.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/0afd18=
737aed/mount_2.gz
> > >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com
> > >=20
> > > bcachefs (loop2): going read-write
> > > bcachefs (loop2): done starting filesystem
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > BUG: KMSAN: uninit-value in ima_lookup_digest_entry security/integrit=
y/ima/ima_queue.c:64 [inline]
> > > BUG: KMSAN: uninit-value in ima_add_template_entry+0x7a5/0x8d0 securi=
ty/integrity/ima/ima_queue.c:191
> > >  ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inlin=
e]
> > >  ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.=
c:191
> > >  ima_store_template security/integrity/ima/ima_api.c:122 [inline]
> > >  ima_store_measurement+0x388/0x970 security/integrity/ima/ima_api.c:3=
83
> > >  process_measurement+0x3075/0x40e0 security/integrity/ima/ima_main.c:=
393
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > <Zero or more stacks not recorded to save memory>
> > >=20
> > > Uninit was stored to memory at:
> > >  sha256_transform lib/crypto/sha256.c:117 [inline]
> > >  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_finalize include/crypto/sha256_base.h:101 [inline=
]
> > >  __sha256_final lib/crypto/sha256.c:142 [inline]
> > >  sha256_final+0x169/0x460 lib/crypto/sha256.c:148
> > >  crypto_sha256_final+0xca/0x120 crypto/sha256_generic.c:49
> > >  crypto_shash_final+0x72/0xa0 crypto/shash.c:58
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  sha256_transform lib/crypto/sha256.c:117 [inline]
> > >  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> > >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> > >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> > >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> > >  sha256_transform lib/crypto/sha256.c:91 [inline]
> > >  sha256_transform_blocks+0xded/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> > >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> > >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> > >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> > >  sha256_transform lib/crypto/sha256.c:92 [inline]
> > >  sha256_transform_blocks+0xe00/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> > >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> > >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> > >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  BLEND_OP lib/crypto/sha256.c:61 [inline]
> > >  sha256_transform lib/crypto/sha256.c:93 [inline]
> > >  sha256_transform_blocks+0xe15/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> > >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> > >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> > >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  LOAD_OP lib/crypto/sha256.c:56 [inline]
> > >  sha256_transform lib/crypto/sha256.c:82 [inline]
> > >  sha256_transform_blocks+0x268b/0x2880 lib/crypto/sha256.c:127
> > >  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
> > >  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
> > >  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
> > >  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was stored to memory at:
> > >  memcpy_to_iter lib/iov_iter.c:65 [inline]
> > >  iterate_kvec include/linux/iov_iter.h:86 [inline]
> > >  iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
> > >  iterate_and_advance include/linux/iov_iter.h:328 [inline]
> > >  _copy_to_iter+0x176c/0x32f0 lib/iov_iter.c:185
> > >  copy_page_to_iter+0x43c/0x8b0 lib/iov_iter.c:362
> > >  copy_folio_to_iter include/linux/uio.h:198 [inline]
> > >  filemap_read+0xced/0x2190 mm/filemap.c:2753
> > >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> > >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> > >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > Uninit was created at:
> > >  __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:4993
> > >  alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2301
> > >  alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
> > >  alloc_pages_noprof mm/mempolicy.c:2392 [inline]
> > >  folio_alloc_noprof+0x109/0x360 mm/mempolicy.c:2402
> > >  filemap_alloc_folio_noprof+0x9d/0x420 mm/filemap.c:1007
> > >  ractl_alloc_folio mm/readahead.c:186 [inline]
> > >  ra_alloc_folio mm/readahead.c:441 [inline]
> > >  page_cache_ra_order+0x93f/0x14f0 mm/readahead.c:509
> > >  page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
> > >  filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
> > >  filemap_read+0x5c6/0x2190 mm/filemap.c:2702
> > >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> > >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> > >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inli=
ne]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c=
:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c=
:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:=
385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > >  security_file_post_open+0xbf/0x530 security/security.c:3130
> > >  do_open fs/namei.c:3882 [inline]
> > >  path_openat+0x5ac3/0x6760 fs/namei.c:4039
> > >  do_filp_open+0x280/0x660 fs/namei.c:4066
> > >  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
> > >  do_sys_open fs/open.c:1444 [inline]
> > >  __do_sys_openat fs/open.c:1460 [inline]
> > >  __se_sys_openat fs/open.c:1455 [inline]
> > >  __x64_sys_openat+0x240/0x300 fs/open.c:1455
> > >  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64=
.h:258
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >=20
> > > CPU: 0 UID: 0 PID: 7337 Comm: syz.2.106 Not tainted 6.15.0-rc3-syzkal=
ler-00094-g02ddfb981de8 #0 PREEMPT(undef)=20
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 05/07/2025
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >=20
> > >=20
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >=20
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >=20
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >=20
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >=20
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >=20
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >=20
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> >=20


