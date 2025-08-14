Return-Path: <linux-integrity+bounces-6851-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DACB272A7
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44A75E4CDD
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31E284B3B;
	Thu, 14 Aug 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EarEIKgx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AE2857F9
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212108; cv=none; b=oDCMdz8yG/q7kE92rnlbG45ofod8hjHfBjlwL/Nz9jcxLW15tqzIIW+vzqFVrHfPYkwPuyOpwTZE1XpgfhYAeXUeMBud9Rys8Ical/aL4eZnyTAkRVPCRwp/mlnZIGP2O0qZaM76C4KporVa8wJ7T8kE5Q0ptDuOUncVsm7+eVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212108; c=relaxed/simple;
	bh=ZNGqnbcpxw+Qyb3vzaiMwN66q426OyujKkcuBslEB4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJa/yt5nu+QW1UdNj5RZW5yEqiXIL24kM14NzpLcEt61fm47IKCoimVfrg2avf1s6CcTiElZr94GIeESncMO00eC6POtiB9A/5jyiIdQ53P7MdheabH/zi4Lg1m1pvL543+y6NGbbVaHigV84v6HuzRrdj/2NmIUoayHrWxYLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EarEIKgx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b1099192b0so23480571cf.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212105; x=1755816905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNqKk1mVwU32aae6NwZ/7RRnP+Q5otIyU9VRkBoLpR4=;
        b=EarEIKgx4HrYL8t8/Nv2WUQ0/Uqti37b/8ABFo7YjcDieIZUj9Sn7GOFQMmDbEvQKf
         vVEGL69o6phb7P6ry+Wpfgi1pa3JG643Rv7VUuhmdjfrEf0lQiepRABWNUr0TrFCB4Im
         mdQMEZdlSahGhmFUexDw99nYpjuYhp2nhwhtO1Jg62nEg4O8OpbiksYGwpNPE4oLNXz6
         WIiJw0S/QqAyG3SK8191FKV3ZmxWSOsbjrPAvHu1lwZxm2P/P+FxXJokXF2bkEsoUeN2
         PwgrCSQF7Ob1VBAkCK2gsq8A8S4zcD3Gwkj7w6+JRL50hLIP3BkXZdxMzEnYngvt6VoH
         k3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212105; x=1755816905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNqKk1mVwU32aae6NwZ/7RRnP+Q5otIyU9VRkBoLpR4=;
        b=aruum+amjGQ74Zg+rbokDRZM4JK3Yt7+4B7ZigQHTeF8W+IySzK/36ClZABBCBXAg6
         E4GKi/7UOhwV2NIa2sCuM9ZIvgGm+w8QoDgOe6qCfKbkLywu3adThjvSdiVKkIQkPoYA
         qyrl7qrbkn1dEMxEJvvqdrbaf3r+j9fVeAHnemTa1djR66Exv9L77P5SMssiXg7jYXdz
         +3USar62EKoMs2500XGehQ8wDKKWZsS0jfS2hP1nPrNmw5wSC+ZCKQwCEG1gimyCgwMI
         A+tAoIO/lyQDHsURP5lybWYEPN0maIuieetSx/EDeJcspK6EgpU/ZcIg5anGehWKDW6r
         Cdbg==
X-Forwarded-Encrypted: i=1; AJvYcCXQVgND+bsXXEi+KkXwFGDVzaGRfKChG4NaX0sXnnRaQB9INFXQu4DrxSb+1XIOJu63p9VCkJ8aDtl2u/DZRTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PibQ1ectsXZp5SVtASMlumu91JnQWoEkHOyzmg2vS4x1gNC6
	8/i+gRpT/Z/bp1V7oqefLj0tCi6iX0zXp/olDNhJWv/MfsMJ6fAd65e4AGiCloic6A==
X-Gm-Gg: ASbGncu1xcj+LhXCP4pZvOa6T0N3NSrxH/pNJWQs34ZQiicNpsk06+KGmGiVTnOq9l5
	LttX6/S9IjiZl7Fi5khYD0skbL6XiVWHvJERY6xe3O2uzd2+88vyWSvGCCBPlq7fAVS1AlxObWU
	Vt324c2dwSrBOBIB0gzaMpMCKSE1DOYrl430PbtcBBEN2G7qHcqxz/BQOSI6wZk2Vyc6TPu9NtV
	jVuFe6pG3xAhkEydmSJWFYoOKd1YLouIkCtd0XqRB3pifn9DcPFb/sc8+Zub8mev7pacSds2QoT
	aogfje0gEjix8fiv0dWeb1FOD31QB1JvW3sx8W3JR+M+JeeUaem2oz/UFk33NVYqXwDksnJMxso
	T5vqcErQSwWTnYi+qPME8WOLQpshPPxugitDTskQHS2ncFm8vuuDxt6kcPbsnhMwDqEk=
X-Google-Smtp-Source: AGHT+IEhNo5bP3G767gsZ2PXckXKtKjXcR6IoIFcD6DO9ZP7/kz3XAhleshf19NoPjHj5zYXdNN3Rg==
X-Received: by 2002:a05:622a:5e17:b0:4b0:a9ac:1921 with SMTP id d75a77b69052e-4b10a95e43emr67541261cf.18.1755212105420;
        Thu, 14 Aug 2025 15:55:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11a8816casm2506891cf.8.2025.08.14.15.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:55:04 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 33/34] lsm: consolidate all of the LSM framework initcalls
Date: Thu, 14 Aug 2025 18:50:42 -0400
Message-ID: <20250814225159.275901-69-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2853; i=paul@paul-moore.com; h=from:subject; bh=ZNGqnbcpxw+Qyb3vzaiMwN66q426OyujKkcuBslEB4E=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmj4zbOQZY+5YTQdWUF3zwJBY2fPmk3HxIfOd x7wHdTdlWmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o+AAKCRDqIPLalzeJ c/82D/9kMFjlTnnSJmAZOla0WLykiozGQ8BcKl4l4+SVnNwnJy+3Y4Ncv1ZxyrkB9tdYWoGKI/G sNY2qPvYHi6R8aSPWFlWfC+vRbpAIAW5AWNYmIuHL22grzBxQp4VbXyIwZihvvXuimK/yHs+amd V4pvhI3prRKJ+wM8skCPLPtOFsTx9lVyoZ4Tuq/Dk2PZVx66xgOBPUwflG9GRmP2yn9Sbzk+tbq 5x7CSC3zrHHAye01CKPstl6v2d4x73EvSTMX3zBIfheCOePgMx+LJM2bGJ1LyKQmXHv+f6q0SSV 7K+Zl3qu2hZFGO1eVaQpWxVl+LboyC/oqcgSW1d6s52O7JRf60pRVIXXJw8Z/w/2q0CpEH45j1W P3fWs/D2K7ypCUGebX1UbVSNvXI7M1M16sWACvTMOwRV3dhcbYeblGvIgPhBGZ+va8qkDGgLzhl qlX26q8zHYaVxV2pYshH06xUJDgb+YZGLrIHG33Rg9WNcQkXPGoBHjen5Q6W8wmbbO+qCPMti22 26Y61HaelRo3Ll6GQKo4/ARoFB5aZbpz3nGLR73mK1oJLBZ41MaJHpxWLN9GMZ2aT7EZxD+wWMg aUpuID8HQX28rlISmrJrGbak0P0cH9E985jYFOIy0M7VfR5/i7NbRQPROGsLO5Tr6GuaG+w+G4J 1ggR9cTY+vU9A7g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index a5e7a073e672..21b1f9b4d396 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -384,7 +384,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -403,4 +403,3 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-core_initcall(securityfs_init);
diff --git a/security/lsm.h b/security/lsm.h
index 8dc267977ae0..436219260376 100644
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
index 697482a22a02..2bd705836df8 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -488,7 +488,12 @@ int __init security_init(void)
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
 
@@ -506,7 +511,12 @@ early_initcall(security_initcall_early);
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
2.50.1


