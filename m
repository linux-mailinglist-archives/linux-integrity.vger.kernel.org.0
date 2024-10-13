Return-Path: <linux-integrity+bounces-3800-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E199BB30
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Oct 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058B5B20F0E
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Oct 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC168148FE5;
	Sun, 13 Oct 2024 19:06:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1318148302
	for <linux-integrity@vger.kernel.org>; Sun, 13 Oct 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728846385; cv=none; b=hCwQYarK/9A7JW2dYo/SZVuRTS9NHd1v+esyZPHluwSlw+jCZ9FRggC9yqGxbowWoPr02Uz1obZkRGIxsGEi936KK6rjiOWe8l8d4pg3iRmsqI/EGbtFQiJUeIYVB8scWm+0lJYcH1BfuLEVjqh3bkAMF0wnzK9va/N/L4W1pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728846385; c=relaxed/simple;
	bh=ub1r8A4H9jI914UghPbwsnmyaeTE9ExtUT4BHKSmPvE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hlcSE/m7eiUz8kWdOz4sD3izKJu1bVOIZqER/PI8WREm8o+w+zfNKJ14M6EqwvpkVtC6i6HqrIttkpVUyavLcFycCaV4uGgdRUlltygMwcR0OJv/vCHoF3Hkf65ttkJEaixsd2VdpKCjNSqlol94CsTM2GKf0vjLsjtcvfB/t1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so3886635ab.1
        for <linux-integrity@vger.kernel.org>; Sun, 13 Oct 2024 12:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728846383; x=1729451183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUrMdKK3IupreYR7WdXRorJnS/pY347ucZ7h8blS5rE=;
        b=wgFMqUHCKl5xYC8GP/pqicKAV5R/yI3+OPcYUbFifN6hgaPtuOaeh/MNNu/NkZPdjr
         xHjIVq4z1JlnjVnSOGE62JCFB1aqdZyB9qOrCEzkKbnCYPnUs2BSFnY71SyRHSAR93aU
         Vckr7ys0FE918i93G4ebtWwjyMWuzesheTCNLmOPa+S/5xZ8FPM17lu4oa0z9wZSfeQS
         GQG96c0nIouTbqrCO0z7XT6DWL/nSADSyEcOo5ZjKVZgSKtm8uW2adiXwd6S0VY1H/4D
         yycM0mN+rMu91KIUIv5gA0cmOcJcG2tb9LXbZWMSbFzTTEzH1q6CnTPbpcMQa29tw6bb
         D3xw==
X-Forwarded-Encrypted: i=1; AJvYcCXtG9HbydFQN7dOg28YYZeWmJVG8NaRPq1kKHyjQAdCrmq1hkiqHNehQe+FO1OflxX/P2zrvyIC/UKlEYANkF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbmWiUCgxJT8W5JN1Mi+aG4z7lqHEYinPq8EV1UCSdXYtdlpc
	Qc2Zx0k0nR35QswMprNKdF+7YWH1bVL7Ab41DZtIbJogTgOo9AM3eNKxcjGLyOFwwK7hGw6OeuX
	N9vzJI1p0CA5t2Qk3pTZZDtljXXJmSG6SqvDCJMAkwKzfqpPiDIpQEPA=
X-Google-Smtp-Source: AGHT+IEPrO71zT/zPbvXHRV/PEBBoBuDOj0dAKWfIzc7LyKlGrJvgTAGaI05Eb3CA1tXgPNidLA8zSEsOaNJlpg0twmPEZ4dWsO1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:3a3:b45b:fb92 with SMTP id
 e9e14a558f8ab-3a3bce029c1mr42661405ab.23.1728846383163; Sun, 13 Oct 2024
 12:06:23 -0700 (PDT)
Date: Sun, 13 Oct 2024 12:06:23 -0700
In-Reply-To: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c1a2f.050a0220.3e960.0043.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yuezhang.mo@sony.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ba885f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10eb8727980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157e5087980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea807517ae2f/disk-36c25451.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f30861c9c3c/vmlinux-36c25451.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b5ef63bff6f/bzImage-36c25451.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5402f23c14ef/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x880 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x36b/0x8d0 security/integrity/ima/ima_api.c:383
 process_measurement+0x2c11/0x3f30 security/integrity/ima/ima_main.c:380
 ima_file_check+0xb4/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 security_file_post_open+0xc6/0x540 security/security.c:3129
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
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5186 Comm: syz-executor173 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

