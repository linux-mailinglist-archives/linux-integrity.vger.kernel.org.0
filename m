Return-Path: <linux-integrity+bounces-6232-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB7AB8954
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD746A05C91
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ACE1BE238;
	Thu, 15 May 2025 14:23:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25717B4EC;
	Thu, 15 May 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319020; cv=none; b=HRyLauaZhoqc0wsQzyABnvcylmOc5u0t6rCp5iVteqFXk8H/QZ0uFjOFSyLNt0agOqQTnrycAYxEuwPokMMnFAx0G9PPb5zWDlsZHm9qj9H+Kjp4JytsDA3cRjOQoksawlD6FAlIiTJXqB/e//AOT7dp0gkRegeKg72wJc2Eqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319020; c=relaxed/simple;
	bh=fe+w4ZuASKrsjB6Mk0us7ZJoFuL+FYsxcteMZ8Kq7DI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUSbab7ze8e0vr9ONHp70a876FSXjiZlCmxz7prY4xwmlzHcpMgiKYBsXQoI9wGbcIPSz2Ad/EvQUwPT9+om7eCw/Jj7eT0BWUMpZ6KGHJ8Nvhju2NlxHSgesY7icXzvTXXTcB0p1TgAjV4e/2QjC1SLmJiZXbv4azuoBC9FaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZysSC0ckyzsS7t;
	Thu, 15 May 2025 22:05:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id F16C31402ED;
	Thu, 15 May 2025 22:06:20 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHjkzN9CVoj1btBw--.64056S2;
	Thu, 15 May 2025 15:06:19 +0100 (CET)
Message-ID: <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, paul@paul-moore.com, 
 roberto.sassu@huawei.com, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com,  zohar@linux.ibm.com,
 kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org
Date: Thu, 15 May 2025 16:06:02 +0200
In-Reply-To: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
References: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHjkzN9CVoj1btBw--.64056S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw4kWw1rAr1rZrW8XF4fZrb_yoW8CrWUCo
	Za9wsxCr15JFW3JFWIyFsrZw4fuF4rXry7XrWv9rW5KF12v34DGryrAFyUJF4fXr43WF1U
	X3y2qa40qFnrK3Wfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGglkmQFUQAFsm

On Wed, 2025-05-14 at 07:54 -0700, syzbot wrote:
> Hello,

+ Kent, bcachefs mailing list

I have the feeling that this was recently fixed in one of the latest
pull requests in bcachefs. I don't see it occurring anymore, and there
are more commits after the one reported by syzbot.

Roberto

> syzbot found the following issue on:
>=20
> HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1116967058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9dc42c34a3f5c=
357
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0b3970f154dfc=
95e6e
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd=
6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1574d768580=
000
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5ca57f5a3f77/dis=
k-02ddfb98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3f23cbc11e68/vmlinu=
x-02ddfb98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/73e63afac354/b=
zImage-02ddfb98.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/0afd18737a=
ed/mount_2.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com
>=20
> bcachefs (loop2): going read-write
> bcachefs (loop2): done starting filesystem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in ima_lookup_digest_entry security/integrity/im=
a/ima_queue.c:64 [inline]
> BUG: KMSAN: uninit-value in ima_add_template_entry+0x7a5/0x8d0 security/i=
ntegrity/ima/ima_queue.c:191
>  ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inline]
>  ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.c:19=
1
>  ima_store_template security/integrity/ima/ima_api.c:122 [inline]
>  ima_store_measurement+0x388/0x970 security/integrity/ima/ima_api.c:383
>  process_measurement+0x3075/0x40e0 security/integrity/ima/ima_main.c:393
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> <Zero or more stacks not recorded to save memory>
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_finalize include/crypto/sha256_base.h:101 [inline]
>  __sha256_final lib/crypto/sha256.c:142 [inline]
>  sha256_final+0x169/0x460 lib/crypto/sha256.c:148
>  crypto_sha256_final+0xca/0x120 crypto/sha256_generic.c:49
>  crypto_shash_final+0x72/0xa0 crypto/shash.c:58
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:91 [inline]
>  sha256_transform_blocks+0xded/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:92 [inline]
>  sha256_transform_blocks+0xe00/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:93 [inline]
>  sha256_transform_blocks+0xe15/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  LOAD_OP lib/crypto/sha256.c:56 [inline]
>  sha256_transform lib/crypto/sha256.c:82 [inline]
>  sha256_transform_blocks+0x268b/0x2880 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x392/0x410 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  memcpy_to_iter lib/iov_iter.c:65 [inline]
>  iterate_kvec include/linux/iov_iter.h:86 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
>  iterate_and_advance include/linux/iov_iter.h:328 [inline]
>  _copy_to_iter+0x176c/0x32f0 lib/iov_iter.c:185
>  copy_page_to_iter+0x43c/0x8b0 lib/iov_iter.c:362
>  copy_folio_to_iter include/linux/uio.h:198 [inline]
>  filemap_read+0xced/0x2190 mm/filemap.c:2753
>  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
>  __kernel_read+0x750/0xda0 fs/read_write.c:528
>  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was created at:
>  __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:4993
>  alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2301
>  alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
>  alloc_pages_noprof mm/mempolicy.c:2392 [inline]
>  folio_alloc_noprof+0x109/0x360 mm/mempolicy.c:2402
>  filemap_alloc_folio_noprof+0x9d/0x420 mm/filemap.c:1007
>  ractl_alloc_folio mm/readahead.c:186 [inline]
>  ra_alloc_folio mm/readahead.c:441 [inline]
>  page_cache_ra_order+0x93f/0x14f0 mm/readahead.c:509
>  page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
>  filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
>  filemap_read+0x5c6/0x2190 mm/filemap.c:2702
>  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
>  __kernel_read+0x750/0xda0 fs/read_write.c:528
>  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
>  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
>  security_file_post_open+0xbf/0x530 security/security.c:3130
>  do_open fs/namei.c:3882 [inline]
>  path_openat+0x5ac3/0x6760 fs/namei.c:4039
>  do_filp_open+0x280/0x660 fs/namei.c:4066
>  do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1455
>  x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2=
58
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> CPU: 0 UID: 0 PID: 7337 Comm: syz.2.106 Not tainted 6.15.0-rc3-syzkaller-=
00094-g02ddfb981de8 #0 PREEMPT(undef)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


