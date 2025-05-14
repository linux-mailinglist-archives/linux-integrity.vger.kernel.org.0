Return-Path: <linux-integrity+bounces-6214-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D6AB6E97
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EADD4A05BD
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38401B3952;
	Wed, 14 May 2025 14:54:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6218B464
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234475; cv=none; b=hTWp2kxejsLbYZvoShUCcvUP3T3AMqYBfsiel9aCA8gT4X26pA5gm+o4HSG81bJOrkhA46XC2ll7aPOjrlAFB4lWqDCLgo6lFXWv5oPcRRZHvz4CDH4pjv+NkQqJO+GWkeqggWnRD9sSqT0gnlqEjRWRYwSGKGXszrasRWivV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234475; c=relaxed/simple;
	bh=uZVwsua7TTsZE/eKl7BoqWQFLMqRe1pWhoHiPZfq5hE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uQYqbg5ehUcewbAN6JKvsXaPAzg52qU4tRMHqw2geYzQ+x+y6Bgz99mWe7NimHd4gctjnrH0GJgFTyXB2otBlUx/nHVHCKtdZkZ7ovPfqYs+miqSf0w49Z01XHEzAm360PMIXuAqx6AJPE78+Rh5EtTcANNPQWwRy17yozBnQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso727634139f.2
        for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 07:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234473; x=1747839273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcaImI2KAOkoeEjN33AzYoWsZgkP5GSWaOlmM8RyyOc=;
        b=APu3nEAOciABfIs6YvXLF8HJ2GDMgXSboRb/XSM1Vqa/2zwbrJnh/ru7kXnpfj0MJy
         jsxeeDYgW2W/0whvMpZ43Rs5JJROiIvX85j4wMUklyqlDH9SFLjF8Q1JbbqhMdMYDYUU
         09tveuTSUl7dB3I/UU8EtseALfZscUSz1yQK5hWTAKprPnoIhiVJ269QP5mbyyMTyNts
         udjFbr290UxJnms3rkTHrJEm+Kczq0Ap+oYrC6vJSIRsfALdlc7uGTWc0ZUhE17q93AO
         bMf5WOATtRvxJ+fBu+MIuiaq2acb/Gf2MkBDAZh85tP5GpTs67V2HH2HAOrYt/vYsETT
         /d3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsmJuhBBk6OPwsGFckcxearhrfr2uQwQG1K0JyKM6CvZAikKygqax1VS6ha+Djg3vVpkDPeeh9/r0CjPTx4DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQysuCGxAuXaQGePn+o/cJUwjSkOVJr39o/ZI+CCdubgG5V5Io
	lwS7k6Yz/aj7w1Q1rk3QHwY+CYNkPTgi54uNKns88fljDL6YRGJXou08Lkw5lCP+Anm3L1PrtFk
	tc7xqj6y2w5NEeWzWDhYdOgQmEGrHGT6o65dhoOYiEPcJbyZwqNRGan0=
X-Google-Smtp-Source: AGHT+IGMubNa81uA1O79pnClccBYlxGMeRHA5r+HhJSj2UUjWdfTKMl7O4hCW9xOOxbTspCRFc2GyqLXMNFuQFdqsoJCN7+6pbSS
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3814:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-86a08e4e738mr491625139f.12.1747234472675; Wed, 14 May 2025
 07:54:32 -0700 (PDT)
Date: Wed, 14 May 2025 07:54:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
Subject: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
From: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11169670580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dc42c34a3f5c357
dashboard link: https://syzkaller.appspot.com/bug?extid=3f0b3970f154dfc95e6e
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1574d768580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ca57f5a3f77/disk-02ddfb98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f23cbc11e68/vmlinux-02ddfb98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73e63afac354/bzImage-02ddfb98.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0afd18737aed/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com

bcachefs (loop2): going read-write
bcachefs (loop2): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inline]
BUG: KMSAN: uninit-value in ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.c:191
 ima_lookup_digest_entry security/integrity/ima/ima_queue.c:64 [inline]
 ima_add_template_entry+0x7a5/0x8d0 security/integrity/ima/ima_queue.c:191
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x388/0x970 security/integrity/ima/ima_api.c:383
 process_measurement+0x3075/0x40e0 security/integrity/ima/ima_main.c:393
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_finalize include/crypto/sha256_base.h:101 [inline]
 __sha256_final lib/crypto/sha256.c:142 [inline]
 sha256_final+0x169/0x460 lib/crypto/sha256.c:148
 crypto_sha256_final+0xca/0x120 crypto/sha256_generic.c:49
 crypto_shash_final+0x72/0xa0 crypto/shash.c:58
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x276d/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x392/0x410 lib/crypto/sha256.c:136
 crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:91 [inline]
 sha256_transform_blocks+0xded/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x392/0x410 lib/crypto/sha256.c:136
 crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:92 [inline]
 sha256_transform_blocks+0xe00/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x392/0x410 lib/crypto/sha256.c:136
 crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:93 [inline]
 sha256_transform_blocks+0xe15/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x392/0x410 lib/crypto/sha256.c:136
 crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 LOAD_OP lib/crypto/sha256.c:56 [inline]
 sha256_transform lib/crypto/sha256.c:82 [inline]
 sha256_transform_blocks+0x268b/0x2880 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x392/0x410 lib/crypto/sha256.c:136
 crypto_sha256_update+0x35/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x7a/0xb0 crypto/shash.c:52
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x20d7/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:86 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x176c/0x32f0 lib/iov_iter.c:185
 copy_page_to_iter+0x43c/0x8b0 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:198 [inline]
 filemap_read+0xced/0x2190 mm/filemap.c:2753
 bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
 __kernel_read+0x750/0xda0 fs/read_write.c:528
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:4993
 alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2301
 alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
 alloc_pages_noprof mm/mempolicy.c:2392 [inline]
 folio_alloc_noprof+0x109/0x360 mm/mempolicy.c:2402
 filemap_alloc_folio_noprof+0x9d/0x420 mm/filemap.c:1007
 ractl_alloc_folio mm/readahead.c:186 [inline]
 ra_alloc_folio mm/readahead.c:441 [inline]
 page_cache_ra_order+0x93f/0x14f0 mm/readahead.c:509
 page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
 filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
 filemap_read+0x5c6/0x2190 mm/filemap.c:2702
 bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
 __kernel_read+0x750/0xda0 fs/read_write.c:528
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ff9/0x3fd0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
 process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbf/0x530 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x5ac3/0x6760 fs/namei.c:4039
 do_filp_open+0x280/0x660 fs/namei.c:4066
 do_sys_openat2+0x1bb/0x2f0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1455
 x64_sys_call+0x213/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 7337 Comm: syz.2.106 Not tainted 6.15.0-rc3-syzkaller-00094-g02ddfb981de8 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
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

