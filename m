Return-Path: <linux-integrity+bounces-5708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D908A82FA8
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CCA8A3E99
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112627933B;
	Wed,  9 Apr 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gMqVmyvM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0627BF78
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224824; cv=none; b=q58QEXlO1sJkYLDBGs3bO8eYPwTlgAcbCxQBjhFf7v1sfTitjCR+bgcW8T6D/v4q4hdGIMtwNHwM5L7asW5/h//bMIaLwn77Siou79gtEbklGL6IptKAxkq1uL8mNVwgDIYkWAad4hADaxNIWnORuMBqxuK4/0I+meg1VdMcGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224824; c=relaxed/simple;
	bh=qzEYkjSSQT7SHN2iFHggJ9MMMBNBLcrzRuKDbw9m2Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEP9fb0QpGyOD3eeTipLgChUIAtG8tRIKrJv1nlg9tvTUFYMuesQFiTvJBSeS7Rf/2tmBkKo+wZL1Nx1nmtOEOuH+EtL3gxgzmES4Uzc3wouNm9m+dLeVSFBF8V+vytB9eZLjZD/Y+zTKylGd819qULvFrK8XFj7Eil6Fvt39wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gMqVmyvM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5b8d13f73so4314585a.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224822; x=1744829622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3N2ly/yeq8SeKiTDDeeS8aDfdMzPtTEEqExSghx5EU=;
        b=gMqVmyvM4DXkIPGGRU82hYDab0Yi041It/Q1TIZX3G7gAK97uZoM5OnNKGCkwXrOGJ
         UU4yk5OpwKzhla2TIJeZguiPu1HhhtbXi061NXE4Y3VYtMof84BScIBrlfWL4VRweVHT
         vcxascZ3AglsAFlnxPtRISCpMDUO7l+pdYCn/4HG4Od4iE7aRtrH6YjwAyjJjdR41wQx
         +Nzb1C0IBqQ6zdgmROnPcPcUQcyVHvsX6ecf4FhF1ND1RLnZ6TIUbCsm/ManTA2Q3BlK
         x0CmD/j8Slu4Vu3a3+eh35aXZZ80cLGQaADAeRPAVPsdrgAorciNDXYjbeCH+uRBZA9C
         8xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224822; x=1744829622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3N2ly/yeq8SeKiTDDeeS8aDfdMzPtTEEqExSghx5EU=;
        b=QbIlZJJPI7CMImKrO4E4jWbcdt+PbNnk7ygEAZvl0XrSaL4i0ley4Ghj1zTd9SRumZ
         hI4AB8edHWmrRpONj4kMAtr2NiRoru4sqmihhobiz+p2kaXz1kfZGlRtzahZrwXzW2UG
         IN2DrSwG19ArXK4IOwL4ZcNHwyqGVf1IWHtzB7GEP7I1zee7cIbtSDjhQjt+6e0KxAJK
         BtL1Sx3KRSeqdCdhp4Jr41MHlVkjjNgZz25LK9ARSeG5Y3uBFnvvA7Mi2a1d3ylpNCZ0
         SOJZHQwkHaoqyRKMBVX72rOK5o+lxM0jd7hJJNc2pivSP6NYEF4rTng40ZLWDoYk9IOc
         PjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4HncsHmk3F/co+pBqxRv957GUFrjlegmZCXbR74+CsmPUZokOJXgvwvcGEKL7V/HM2uRSn3zeXb2UKVTu7O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0yCWyMJkQjushHfJ+Yivk8MpseRBlZET92IaGAYZxwNO9p5c
	D2cRh1kgykRiN/2hgNrhVY3XpSQp64aOlIHAc5zT67omllyxXfg81pUafCW2pA==
X-Gm-Gg: ASbGncsiHjkIea0S3YOw5gWwObgXUb6QL88ATzdflArBaF/tJ1PJjVh9VBBLIvZOhtR
	/VxIB0ZmbsqdH7ir8YLrdTwvSPzFzB91NBT6D77unMWeVL0PkybYyZWu0sg/ha0luNVhrU0ZJXs
	xX97rHkwt6tZMAMXAS8jSOkSPz7muyOi5HUAKv39m82N1Bmsvp7vwxDe92PAyutfgCbl8pgcIHV
	1qC0S7hYT6jZs8briaWqXUcOJTXpgLZzrfYlrwTfpuUuxTNvNTewWc0vqcSGyt09f6W+kVF1eN0
	lH4AlcRJKMEpn4uhjHoJs7KLNVt/Mxykzkq/VLUWsAURfECFWpnZwWllcP7hALozoIzFBJwq77Q
	GpAqnra1q1w==
X-Google-Smtp-Source: AGHT+IH2R1QFDpJ7IptoJ8jPAKU/tn1nZ/FDrssLMBR+YD+UL7EcoRrRp+nWz6yXMBxXlwv1SSRk4A==
X-Received: by 2002:a05:620a:c53:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7c79cc31d04mr606759985a.37.1744224821849;
        Wed, 09 Apr 2025 11:53:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a10a397fsm107455785a.7.2025.04.09.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:41 -0700 (PDT)
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
Subject: [RFC PATCH 13/29] lsm: fold lsm_init_ordered() into security_init()
Date: Wed,  9 Apr 2025 14:49:58 -0400
Message-ID: <20250409185019.238841-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7193; i=paul@paul-moore.com; h=from:subject; bh=qzEYkjSSQT7SHN2iFHggJ9MMMBNBLcrzRuKDbw9m2Yk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sG4q+YU4s8gjBcl3GN/lIHlWvocxD6euCzjT hCONllu/a+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBuAAKCRDqIPLalzeJ c3dlD/0chaUT7KCW3OldpGtsj631H9sbdm9c6Jl/Go6QPIDvEvIqS8JpyLn1KdSI7gHoRjtfeTP EbtFPoX5kAieLNO0Zcl+r8Hz4QcOrncDYuV/gWSkVwMwlVaNEaFP98c0Il8I5nBu5ftlkYstgRo xtSjjAa1yeKQaJyqtBL1mnuYrMoDPMkOXoLyhn1W/UnUZ/jAw7wvljRUDl1g1q+viIlbLOV/ONS zBdCYfTmoi+SCNcbJOiLKvXi5IR6SCRucZVPmKEiPbzW9SEnX48lUhRk9u+AKTYKhmivnmxAarr g+arbliy3WvMmrs0qFY7T6eHfIoD0dAfCgkXHGE4fMkaE56vgvpIlHfxL2RIADhzYoddJ0pxnNb /TMbY+rQ9s1SKgLtGOsuav2pI3VTX4axxToxrXxFE8CmNG6Ny3XkFkt6YKK8bU+BIX0AZh21dQW SgqW4FjT05GDBoWTn4VwZLo3CAWts1d5M5EEwlPMxLcGc5yrh5imMjPnUuB42l4am8ZfzTdIhmo 1gv00uK6F4BS5NYYw5nGQQh/eHHpneZ06pZZih9WTka3cm2YRp/szd8pyazOYVqqq190/5HxtI1 7QNz6a+BpWx7C5CkIDAnu6wQBc+g1HJm5jJTuyR+3i/R8O2B+jUwPTlfb7t8ko0I+/h6bfTIgGC oxUqkZPOnqiVklA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 156 ++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 84 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index e07fd4d2a16a..55b3fa82db76 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -18,6 +18,9 @@ int lsm_enabled_false = 0;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
+/* Number of "early" LSMs */
+static __initdata unsigned int lsm_count_early;
+
 /* Build and boot-time LSM ordering. */
 static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
 static __initdata const char *lsm_order_cmdline;
@@ -310,78 +313,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/**
- * lsm_init_ordered - Initialize the ordered LSMs
- */
-static void __init lsm_init_ordered(void)
-{
-	struct lsm_info **lsm;
-	struct lsm_info *early;
-
-	if (lsm_order_cmdline) {
-		if (lsm_order_legacy) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				lsm_order_legacy, lsm_order_cmdline);
-			lsm_order_legacy = NULL;
-		}
-		lsm_order_parse(lsm_order_cmdline, "cmdline");
-	} else
-		lsm_order_parse(lsm_order_builtin, "builtin");
-
-	lsm_order_for_each(lsm) {
-		lsm_prep_single(*lsm);
-	}
-
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				early == __start_early_lsm_info ? "" : ",",
-				early->id->name);
-	}
-	lsm_order_for_each(lsm) {
-		if (lsm_is_enabled(*lsm))
-			pr_cont("%s%s",
-				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
-	}
-	pr_cont("\n");
-
-	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
-	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
-	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
-	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
-#ifdef CONFIG_KEYS
-	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
-#endif /* CONFIG_KEYS */
-	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
-	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
-	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
-	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
-	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
-	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
-	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
-	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
-
-	if (blob_sizes.lbs_file)
-		lsm_file_cache = kmem_cache_create("lsm_file_cache",
-						   blob_sizes.lbs_file, 0,
-						   SLAB_PANIC, NULL);
-	if (blob_sizes.lbs_inode)
-		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
-						    blob_sizes.lbs_inode, 0,
-						    SLAB_PANIC, NULL);
-
-	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
-	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
-
-	lsm_order_for_each(lsm) {
-		lsm_init_single(*lsm);
-	}
-}
-
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -429,35 +360,92 @@ int __init early_security_init(void)
 		lsm_order_append(lsm, "early");
 		lsm_prep_single(lsm);
 		lsm_init_single(lsm);
+		lsm_count_early++;
 	}
 
 	return 0;
 }
 
 /**
- * security_init - initializes the security framework
+ * security_init - Initializes the LSM framework
  *
  * This should be called early in the kernel initialization sequence.
  */
 int __init security_init(void)
 {
-	struct lsm_info *lsm;
+	unsigned int cnt;
+	struct lsm_info **lsm;
+	struct lsm_info *early;
 
 	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
 	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
 	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
-	/*
-	 * Append the names of the early LSM modules now that kmalloc() is
-	 * available
-	 */
-	lsm_early_for_each_raw(lsm) {
-		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
-	}
+	if (lsm_order_cmdline) {
+		if (lsm_order_legacy) {
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				lsm_order_legacy, lsm_order_cmdline);
+			lsm_order_legacy = NULL;
+		}
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
+	} else
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
-	/* Load LSMs in specified order. */
-	lsm_init_ordered();
+	lsm_order_for_each(lsm)
+		lsm_prep_single(*lsm);
+
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (lsm_is_enabled(early))
+			pr_cont("%s%s",
+				early == __start_early_lsm_info ? "" : ",",
+				early->id->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (lsm_is_enabled(*lsm))
+			pr_cont("%s%s",
+				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
+	}
+	pr_cont("\n");
+
+	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
+	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
+	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
+	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
+	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
+	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_inode)
+		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
+						    blob_sizes.lbs_inode, 0,
+						    SLAB_PANIC, NULL);
+
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
+	cnt = 0;
+	lsm_order_for_each(lsm) {
+		/* skip the "early" LSMs as they have already been setup */
+		if (cnt++ < lsm_count_early)
+			continue;
+		lsm_init_single(*lsm);
+	}
 
 	return 0;
 }
-- 
2.49.0


