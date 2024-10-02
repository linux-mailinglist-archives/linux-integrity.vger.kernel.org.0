Return-Path: <linux-integrity+bounces-3724-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C798CE3C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EBF1C209B9
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C91194151;
	Wed,  2 Oct 2024 07:57:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113131946B1;
	Wed,  2 Oct 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855840; cv=none; b=kL9rMUuKUh79QNmzACix4D0k76iuAWPu8zeAnMgJgYTb+IGEGpB5LQASyJvhqtDt28feVr1ylPV0lujnseKocKvN1VNKSBqmYABTRhPRLnq1701TIIkkoVk4GPA62/Nq6zlDT+4NLXkelAHEWRXhUGPXnfTgNdI7WAlRotw5yGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855840; c=relaxed/simple;
	bh=V5ppnchON8zgdqWRnwg8xUPo1iSV2UM39OC3rvwPQlc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHdK3UonupVXT1U2FkZRPi4a10Fxrp7ItADNYp7SDXZ3hMKDYjGHH3kupJ0PSz1JaEsm0mpq9xPCIFHUHkfC/Te/pBdBH/Hjg7vXXzIyVmzq69Xte4N+PBXZg1QrdrHo/ELzROzAEHBd7Ndw4RuYfPBNCNfBvyHbeVEaMGokV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XJRTj4jQlz9v7Hs;
	Wed,  2 Oct 2024 15:37:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 65F491402CA;
	Wed,  2 Oct 2024 15:57:08 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3psfI_Pxm2DYRAg--.19744S2;
	Wed, 02 Oct 2024 08:57:07 +0100 (CET)
Message-ID: <ea9222df2c7beb4fe846128833d7eeb82b0a0398.camel@huaweicloud.com>
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, paul@paul-moore.com, 
 roberto.sassu@huawei.com, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com,  zohar@linux.ibm.com, willy@infradead.org,
 Yuezhang.Mo@sony.com
Date: Wed, 02 Oct 2024 09:56:52 +0200
In-Reply-To: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
References: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3psfI_Pxm2DYRAg--.19744S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tF1fKF4xJr1ktw4xAr1UKFg_yoW8AF15Ko
	Za9wsIkF15JFZxtFWIyFs7A3yfWFWrXry7XrW09rW5tF13Z34jkrW8Aa4jyan7Xr43WF4U
	W3sFqFySqFnFgr1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY-7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07boa0PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGb8rH0DEQABsa

On Wed, 2024-10-02 at 00:26 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1177d50798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D85d8f50d88ddf=
2a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D91ae49e1c1a2634=
d20c0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D106026a9980=
000

At a first look, it seems that IMA is measuring an uninitialized buffer
from exfat.

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226

I saw there are some relevant commits in this area from the latest PRs.

Matthew, Yuezhang, could you please have a look?

Thanks!

Roberto

> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/dis=
k-ad46e8f9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinu=
x-ad46e8f9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/b=
zImage-ad46e8f9.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/5b5b4e4b4f=
f9/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x880 security/i=
ntegrity/ima/ima_queue.c:172
>  ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:17=
2
>  ima_store_template security/integrity/ima/ima_api.c:122 [inline]
>  ima_store_measurement+0x36b/0x8d0 security/integrity/ima/ima_api.c:383
>  process_measurement+0x2c11/0x3f30 security/integrity/ima/ima_main.c:380
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> <Zero or more stacks not recorded to save memory>
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:91 [inline]
>  sha256_transform_blocks+0xf33/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:92 [inline]
>  sha256_transform_blocks+0xf7d/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:93 [inline]
>  sha256_transform_blocks+0xfb5/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  LOAD_OP lib/crypto/sha256.c:56 [inline]
>  sha256_transform lib/crypto/sha256.c:82 [inline]
>  sha256_transform_blocks+0x2c35/0x2e90 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x79/0xa0 crypto/shash.c:52
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was stored to memory at:
>  memcpy_to_iter lib/iov_iter.c:65 [inline]
>  iterate_kvec include/linux/iov_iter.h:86 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
>  iterate_and_advance include/linux/iov_iter.h:328 [inline]
>  _copy_to_iter+0x124a/0x2b30 lib/iov_iter.c:185
>  copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
>  copy_folio_to_iter include/linux/uio.h:189 [inline]
>  filemap_read+0xc13/0x1500 mm/filemap.c:2696
>  generic_file_read_iter+0x136/0xad0 mm/filemap.c:2833
>  __kernel_read+0x726/0xd30 fs/read_write.c:527
>  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0xc6/0x540 security/security.c:3127
>  do_open fs/namei.c:3776 [inline]
>  path_openat+0x58cc/0x6200 fs/namei.c:3933
>  do_filp_open+0x20e/0x590 fs/namei.c:3960
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1434
>  x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
3
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Uninit was created at:
>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
>  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
>  alloc_pages_noprof mm/mempolicy.c:2345 [inline]
>  folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
>  filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
>  __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
>  block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
>  exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
>  exfat_extend_valid_size fs/exfat/file.c:553 [inline]
>  exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0xb28/0x1540 fs/read_write.c:683
>  ksys_write+0x24f/0x4c0 fs/read_write.c:736
>  __do_sys_write fs/read_write.c:748 [inline]
>  __se_sys_write fs/read_write.c:745 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:745
>  x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> CPU: 1 UID: 0 PID: 7910 Comm: syz.2.975 Not tainted 6.11.0-syzkaller-1172=
8-gad46e8f95e93 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
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


