Return-Path: <linux-integrity+bounces-7138-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FBB7F89B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6113A6262
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24F3294E4;
	Tue, 16 Sep 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A7W7I2qc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966527FD46
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060882; cv=none; b=ep8Noc3vcY/MVoxWQ0nEamHFlcaEiRixfrbzLNj+fv0grZ8XqurVr0aLOYYGvog6B9L2G1zyY3VR/NRXGP9n26hUlNJSPcOM5/uFTtP6Q1Jn3chqfZvx86YRuolECXycz3U4KjkqyvPzcHvbC7T+nvsvPDeLfck4JZMS2UFequk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060882; c=relaxed/simple;
	bh=0y4h5n+IXD8P8dnjxt869LYF6Svfv5Pqp8Njr0WLUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGFVEFsFFIQO2mqS+imCK5tW78dNl4/P3LVHy/4D2TWzJtVzmX82x5oHuW6QLg0W0Gh0GC3ANU1aVCKOSETJaHaOHdDyb4sCY3CdufOKJI4RcL7S5IPQd6AVoz8WHkGjlD35GDj4U3PFO4puBPGOPsBByfpABGyrhoSfabFpy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A7W7I2qc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-811ab6189cfso570795285a.2
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060880; x=1758665680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtegchSCa5XU9sfnXrM28NVIbfPzM314cfpYIxWWTKY=;
        b=A7W7I2qcI9lL3KAwofx7iP2XkcNSVLEgbjYxvXwywXPPt7OniwF/9cNZSLTpY9qgXP
         6kv0asdL3awvb99jnQEG1e+SfLKxh64gDUrks+tY5AvSi/zgh3xS4XxxYodCtoA4hsG2
         KC8WrRZu6+sVxj2SOvS023dakk/fhrnJyyTT/neLunDpsmaj77K2M1QSAGKiXtD0bb47
         8LKWGJbuG+67MzaeK7h1bfbS6JaL8TKld4DdwS+rw/Mvla3BnRt8nOVKHs4lxd6LvQS0
         Gbe+XbDwDx402rqY7veJ/yzP9KR2MPDDL4gQW5/hrt6avVpJ+IBJtdjBb4mYhJZyMvXQ
         SFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060880; x=1758665680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtegchSCa5XU9sfnXrM28NVIbfPzM314cfpYIxWWTKY=;
        b=O/YHWl5wEYqVkoqDNtPB531+DqCdH7YAu2pd28p9nqCJeiUZeZnnCwV/Wx0ENlWy4i
         bf1QamhVkDEaPViG/yuj82htpBfvgXooG37nb4/icF2It9bUSIxYE1UQIJq7/Lue8lx5
         Mijw56JsjcU94n2wLl5rV5aFF1bHKgJl2afbhB/T0qc0B1EIeI4VeAB4Yj1YLamp1x9a
         J9TGAAvjSePJeJzS4v3MI5wDbIj9b5rV3frmk7NtOxh9ctIhOZmWNGh1gNypQnp+1yPV
         YvRlaCZnkd11ANJIJ4IA5sKHPGMTwgz7kJEFyoHxmUMkaW6q7UdGITkWfG7yIhOCsF8y
         XthA==
X-Forwarded-Encrypted: i=1; AJvYcCWIF2V+3wl7FMyl5mOFKSuXhBF8DAveRCmHoGrfDah0OFC7J/j+sTbxH97+bkXTJza/gbV6jOXA10n/fZLI8rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WtpIs41qh1ONLQ/ICHhytXCYhDZTe3CSfYOPOuI1/3YSCQcd
	antUAE3GnZW0uw1ORHqQ4ZKy430XD0kaioTb/TgkE2G5aJDeAHCQEU99eQkdxRXpgw==
X-Gm-Gg: ASbGncuf4kdmCj5u0/hT4KbD2jw9tcBj9WCb02MorJCy0QZeNIzQQSdblpPTBDHcmvs
	pbW0TbdHk4QDZQOHeIOSwPqbHmZQMcdlRmaFNufZS/QY2Zb70W6FdfekSZNHAv1oMCcltoVmzEV
	2xI8PxUA8w9Jp5xb16nS4dbil8jqDpEys9NHdtdu2/ZlRp8jnrm+uPYrMd5urKpr2BRGa45u1Uc
	2AxsLu/ix3DJ5TEwiaz8LZoFcYESmoRhTEpMkRSEvbZupq2cFRtZv/4Ijf/Cyw4dJBy9nZPlwli
	A/qynxMX1KFtZF6TCVcbTAEXd9ANB/D8YPi5a9bk7rP+Uyz0SMFnYz5gCImuV0VKYs/DSRVJCUs
	QyegTeUwzVkPHxgvWlPxAMXTAEU5mOlCRm+rjUNYE+rIApdPUtgGF6Bm+UPNiQ5JZwYWS
X-Google-Smtp-Source: AGHT+IFBtJoFWsD0o2rGOm6j2VPEIcQiahP/vCa+JcOsqMi+fAhg74Q8MM/WTVraL4VOLSQGVZ/TDg==
X-Received: by 2002:a05:620a:1a12:b0:818:463c:bf63 with SMTP id af79cd13be357-823fbde8d90mr2110093485a.4.1758060880374;
        Tue, 16 Sep 2025 15:14:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639cb584asm86892091cf.20.2025.09.16.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:39 -0700 (PDT)
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
Subject: [PATCH v4 33/34] lsm: consolidate all of the LSM framework initcalls
Date: Tue, 16 Sep 2025 18:04:00 -0400
Message-ID: <20250916220355.252592-69-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=paul@paul-moore.com; h=from:subject; bh=0y4h5n+IXD8P8dnjxt869LYF6Svfv5Pqp8Njr0WLUEY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd81ZhVt7iE4Za3r+URKe/epHxYCGMGTDuGkp avlUSAzOGqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfNQAKCRDqIPLalzeJ cw0tD/9BFUsIKvRX5fs73F0UWNfQKM3Yw+hkk1u4hvhqZt5/6ST62mBpj+TFZhsKwuKNJiaDsRs NZkQOsEqYpzJ+gxs6pd4vY93wsOafq+RJct85LegCq4EWPpNlfOtJdL+K79z9YXsHrnNxQPtHiz fkehJ2goI55e3HRMe5yKku3+Qs8rkuF9IsDOwNjlTtMKhzLkDqREAFnOGBj0KK41mXZyrcI6R0u 1pTM6arSnmrhrUHWXmDHBysY2MSEWeuUAfLGy5zfObEo1v1N90enx8zi1SK7T77hSkRng/ZL1ST /P1FnKPsFyAd20H5tICrkSrR7MwHma8Aun4AMsYk9z2Az85n7KULkz2GGmFQ2hlaYPyUZRSQLJF H5Y14IugRkHOBA6/WmbPIeSz5dUuZHUrI+lJwRuX7K1Yua+AcChVO4ShpKJEaQZrBJNQHbcKiFU EEwiINlAOk+RXCABfS5o/xAYc+F/NuZLNOQoo6p/nYLnmLwBTL0RQaehYgv7v5VHyBxM82G6IQh Mk7YS/ySUpFZLXOVUu1gjeoZ8w6hRkFobMbB5/7WQqk2UsDC/WYYv7+4n7JpkbSO6wivqGpBFab vRB+PVoWww+FcQNbSrcWNR/G1DR/I43ubhffOjCMdKTLqBKwaupJMvO83lqHimoOshdsvX/usgA g4t89VNedo7LzMw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6620c3e42af2..ab8d6a2acadb 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -368,7 +368,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -387,4 +387,3 @@ static int __init securityfs_init(void)
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
index c55bb84b8632..0fde5ec9abc8 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -5,6 +5,8 @@
 #include <linux/sysctl.h>
 #include <linux/minmax.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -52,11 +54,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
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
2.51.0


