Return-Path: <linux-integrity+bounces-3723-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E1798CDBA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 09:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63871C211DC
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F0839EB;
	Wed,  2 Oct 2024 07:26:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AC25771
	for <linux-integrity@vger.kernel.org>; Wed,  2 Oct 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853986; cv=none; b=QxAyj44P8SU3VnKEOXgCifEDWU0hkLaGoUVuHvcaIfN8/26kIXvzb+G1etSVbxUuQ2DCLl7yTSw5NGwdLN0T5J6EEr+nknPPIXmLnRKWOtf3RJxYH4+Wvj6AvmvqCFCFEyANBcwIa8NbkyPs+Tr46u/RWoTFXnOzkvvUHj8YoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853986; c=relaxed/simple;
	bh=IrHwWxktE1hMLlK28Z0VR+xQqHalinF3owSiDPlj+rA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y3wKpm5DM0yYLnS5AyxmgvELRZKRyJTs/5U6Z+ve8HlYEw4zvDpeOcYTbgg79SSAk6lzi7ceksmmXqxY4iOTbT/3iW86zy0UCXqqqQmw5kIP6CC8ImLN3QNzuodZAQW5kfn1UtGanLIA1Z7KOvJxvXHBIbKLIzRQZDeFI82yt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so90515195ab.1
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2024 00:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853984; x=1728458784;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmfOnKA4yWsX4usxPdfZKtdaVhLYNgvlJYK5xZzYXMs=;
        b=Me6vcOjfyG56lDiEIEfFQ2eyiaemvXdJeTryqV3AeS0IqR870z+OolcohBfb9ZZ1Rw
         QRcxTuGbtU/3qXArGUT4q0bSHKbi8WonXlzZUHGnjmuRQb9Cx6Uk9PND6GICvF5GaSaS
         31rfef45m7NATe/IbjqsEAqX9mnOw+UaHTwJNSq4c7hISXCjB+CQrNx5CxZHnu0LKQQk
         IJ63tKclIJGzuUF4bhq0hJjWJ8guhlIM8hfJSewdWVRo93qSumD3J57Mi1bbpW/+l6B+
         gudhepNL2ZG4Ad88MdCmT1+kvxy5OBsjvUckZlMfQATRC8tZb7cMcPHZEmio19R0AIgm
         e4uA==
X-Forwarded-Encrypted: i=1; AJvYcCUTsdcRDp1jM1dyJWehXD9T4FcMFO55Vxoc5HFK+z9/KPSTdUzfguqY1NLcAjSzDZ6OrP6NYPTysNesbEfG1VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/S4Ju+SQxcfjK2wV3idC1Jo0tCocJ3REH04waCr9w/I6tyWC
	AaJ8RdjsS3yere7a6UTZA+cucj9at8doMW0WE42TerTZ7l6428281hqUTpNtzW0cOMPMaXXSBeP
	jQf/zbhdpE6CHj4Xa/mvgO1jwYNb8f1VAHoVN8Ob6xtGqMi/I8OvgGn0=
X-Google-Smtp-Source: AGHT+IFKF9RvYr10okN/1f+tU+zYgN64nsHBe4pEZycM5f4Vpom45/XfDI2tQLsqQSkgsJLar+Msoj0mdCnb2inrY7dwiFmbnhVC
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cd:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a365944725mr18725245ab.18.1727853984155; Wed, 02 Oct 2024
 00:26:24 -0700 (PDT)
Date: Wed, 02 Oct 2024 00:26:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1177d507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106026a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5b5b4e4b4ff9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x36b/0x8d0 security/integrity/ima/ima_api.c:383
 process_measurement+0x2c11/0x3f30 security/integrity/ima/ima_main.c:380
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:91 [inline]
 sha256_transform_blocks+0xf33/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:92 [inline]
 sha256_transform_blocks+0xf7d/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:93 [inline]
 sha256_transform_blocks+0xfb5/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 LOAD_OP lib/crypto/sha256.c:56 [inline]
 sha256_transform lib/crypto/sha256.c:82 [inline]
 sha256_transform_blocks+0x2c35/0x2e90 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2ff/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x79/0xa0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1804/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:86 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x124a/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:189 [inline]
 filemap_read+0xc13/0x1500 mm/filemap.c:2696
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2833
 __kernel_read+0x726/0xd30 fs/read_write.c:527
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x2948/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3933
 do_filp_open+0x20e/0x590 fs/namei.c:3960
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1434
 x64_sys_call+0x15a2/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 7910 Comm: syz.2.975 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

