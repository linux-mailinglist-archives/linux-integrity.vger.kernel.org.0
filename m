Return-Path: <linux-integrity+bounces-5722-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB247A82F86
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AF6465C37
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151C27CB16;
	Wed,  9 Apr 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EaUXia/m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09927C878
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224837; cv=none; b=jVvYORrUv03DuncvxZ/u1x9QlFREYuqgD/X3G7EVL7mMevYSzwFm06AZ3QDokedYjqBgQkDbaH9pKeYVC1W7tr1urZQP6f6Wi/c7eX16HB8p6nx0vTqj4lqMvSJh1G1y/lao/gg4CDcMinMAYpdLkqRuItGJnGEAhd+A0uhPQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224837; c=relaxed/simple;
	bh=PrN0eKET272MqYvpyKfbTsLvpxVkWcKMDEl17osJyFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+uG2Vmtn5DLuVJ1bSmUKtqD8aopFYp0DSv9GZ/n1+CnhAsIb6payyHI1U5lJ07ZpvrABrx+GUo6moYKpTNJx7kpwu0Ow4Gy176XMOZAWWTy6zo/Jz2JboLbVQDJjrgRlg7j/AQgr48L7w8yyQ6hIJUK8yzUHMkH97jsuOeoQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EaUXia/m; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so11766686d6.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224835; x=1744829635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kATB6b7rfxqvL0cXzYWVDgnxVdpmTKsX9O+BlcwUWW0=;
        b=EaUXia/mBZVBBhMbdBNZAkAPkmW7/V4qQNNoRW38C/gpwjTPI3XAjv1+eAp2pi4MCa
         crVlwFOgSI9Bfx/czxKa3I4QSdPW6BS5M1ama8uPcWQJ9yHHZvQ7745Cy59oUtBVq2O1
         /Ppqg7TnrX/i4eBahJckgJO7fBfF6aF9L4uaiJRDtUHr+ZnuJdtBYLymQ88WTEAQ1NnZ
         B4QuopTZlr+cVU6wilY9hjtVaNd6wjskpE9JyZzCU5WQEW6rVlvjxPx3hpqdAkirhz54
         hOi0DIfnLCgveSd+9YwXXhvrkHKcyTsqDc5lSEJq+/A6Eh+Edo39x5gjqyTMklAAVp9N
         y0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224835; x=1744829635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kATB6b7rfxqvL0cXzYWVDgnxVdpmTKsX9O+BlcwUWW0=;
        b=t6t3v7cnuVO50zinxPasQNNnT4FNKBmeKHvGvRGSKRprxHGi9o7DsvqlATF5OM4MCK
         4YQ7ks4juVGaTpMfn6vFMDeHhi5x/ogDh3g1gfZWZo/Fn4vqDispDLD3RlqXzmW9SEmd
         xHD99k2nAWDlIpFyhJUKHzMG9LsJdbSDpRF0zroq2uYKmTmbfyYcu4RZ1wn3PxtSWWfP
         jDtNKyvK26jlQpcfna35uIo2gMypqbZeyOop582dCfyHT5hWE2wbVZb3E9IkriOvlEDl
         uI6SnjrxWc/kF8wRQRANe4FX5v5AxwQLNZF73A/gpqz3CjwvV/5V3A0R6uycZGih7ObS
         EPgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9pm2Zy9veGUniO9S/bIra4pSiUB8qR8Qk/p1ZCXXmTOAAH+qpysWxGaqLVLX+bUdKvfEvD6YCt/DvjnllzyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHAFIfyxSX68Yb36yEz/fGDHtf/Lv/dJg6Z1i5D8DUWm+xVCw
	40CKwC0B+mWFHPKw1/W+hCrYa+bPIvbjYEk0+LOZcDax5YeRpCK2wrfA6Le3TA==
X-Gm-Gg: ASbGnctkMmYsTBc0Th881j2uy/fewwclzA4TL3P/aFO+EchG8wb1M/QqyD17SdW0mwS
	uxy1tlVQBFvdEO4qbKYA/W2CyIzpSTHXjK4ZvB6mWptyWPD7tRWNV3GdDdz9pyQn7iuCmRd3vZH
	Ypy7ey7iOYesc79Sc5A/tCv5gRX9wR/V4Oky8Q85a4gQShzJClcrzPT28AggswBFGZQNLmxRaVp
	oTMqcvF1ZssMmgqa4bRbeqj0t7Mq9aM6oGS1oJa6snr893pmnhougoB63kbe3p/bu8+amdFTmL6
	Yft5NYt/Iy46LJnktR76+/66H/2jYyBHjpuV+R7JKzY0VIT25i5r1SlVYszlFvS6PtLMvqQMTZz
	tlRg/QCm5mw==
X-Google-Smtp-Source: AGHT+IEemC50KA/WyRHDEgLiWRsHI0RRXRXGr8ZGg4VJ6LThazDHrCCsoVbGLWt+McOXildVKh51Lw==
X-Received: by 2002:ad4:504c:0:b0:6e2:383f:4acd with SMTP id 6a1803df08f44-6f0e4c7f873mr9893526d6.7.1744224834852;
        Wed, 09 Apr 2025 11:53:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a10ba74bsm106575785a.30.2025.04.09.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:54 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework initcalls
Date: Wed,  9 Apr 2025 14:50:12 -0400
Message-ID: <20250409185019.238841-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=paul@paul-moore.com; h=from:subject; bh=PrN0eKET272MqYvpyKfbTsLvpxVkWcKMDEl17osJyFs=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sIPi3POvhOt2pY5xdpdJT2VBGb5TQ6QlFVu1 pjLw27Jb26JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCDwAKCRDqIPLalzeJ c7h1D/9bnJjmcuDTeSIQESIabJvH4KNhWLg4YzqOI/sU8P+OAvAW7fF2SD4n390qfH0v9MO3hli 830/HKjpk5NAZv2hVj2JqZWrnBR0zYcanselNm5d7k1Bc0p3bmN7R4fnZm0Nyoy5JkKWCvjjMtZ TGFshBhE5jvFEqb9W7Szs8A+qM4Nt9B2NqZkSfwN5+AsJvxesBoqg7675a3tDgXSHw8BzpuSun3 uRl7gIkgxptSXQzt9+KSnFCCwUF71Lz/MiaHFlLKo99amklfPsB83bArpDtCWInojRVEIk/f2v4 gpXAlIlW+WyPiSlGXevb1fXcV9GAQTpQfAsK+vaf2nH3S6o7yfPz6c1wC8nZHCRWbxQUooli1r0 Ica4Iby3EtavtMxdvz0tcCnkaw/dgUyXG/L1dQkKzSwVLzQOwaiw2NuoQUk7YMcC0CpCE9s6K9H EtqUPxUSowPjKd3YIbUuAwcV9EX2BfeVv7SPz+GsYA0uZ73K2zfargaKf3YgQ/1azVOWz4aXVRl kaW+5shHpKmTm77tcclL4NbryLowtMgXKah6v7HwzRZ4IevAtF9khPYVTvRzed29qxS+LYLtiFA LFS4LZ2BIlUEAxZEuumoYSH8Jvo5/q8V5MTHiME/8vf0lTZkEKsZKU3oKPY/UfEDr9TW3gTxZf8 N5K4JluwMBddtow==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index f687e22e6809..671c66c147bc 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -375,7 +375,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -394,4 +394,3 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-core_initcall(securityfs_init);
diff --git a/security/lsm.h b/security/lsm.h
index 8ecb66896646..c432dc0c5e30 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
 int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 int lsm_task_alloc(struct task_struct *task);
 
+/* LSM framework initializers */
+int securityfs_init(void);
+int min_addr_init(void);
+
 #endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 75eb0cc82869..c0881407ca3f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -485,7 +485,12 @@ int __init security_init(void)
  */
 static int __init security_initcall_pure(void)
 {
-	return lsm_initcall(pure);
+	int rc_adr, rc_lsm;
+
+	rc_adr = min_addr_init();
+	rc_lsm = lsm_initcall(pure);
+
+	return (rc_adr ? rc_adr : rc_lsm);
 }
 pure_initcall(security_initcall_pure);
 
@@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
  */
 static int __init security_initcall_core(void)
 {
-	return lsm_initcall(core);
+	int rc_sfs, rc_lsm;
+
+	rc_sfs = securityfs_init();
+	rc_lsm = lsm_initcall(core);
+
+	return (rc_sfs ? rc_sfs : rc_lsm);
 }
 core_initcall(security_initcall_core);
 
diff --git a/security/min_addr.c b/security/min_addr.c
index df1bc643d886..40714bdeefbe 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -4,6 +4,8 @@
 #include <linux/security.h>
 #include <linux/sysctl.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
 	},
 };
 
-static int __init init_mmap_min_addr(void)
+int __init min_addr_init(void)
 {
 	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
 }
-pure_initcall(init_mmap_min_addr);
-- 
2.49.0


