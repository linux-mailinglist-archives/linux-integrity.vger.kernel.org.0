Return-Path: <linux-integrity+bounces-6681-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA3B0CDE7
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B268617C25F
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBA243953;
	Mon, 21 Jul 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ILeR1ure"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC02459C8
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140264; cv=none; b=h2TYQyfqE/sIP3ifbdAhqkFTm9IlQkgPszAZ0QYhRgbrlPs/hOKoW1VvUyBDs6ojuLK2gfOIaT0iMIl8v0bYBWwk/FEZrviVjvIyYwagl4qFW6WzmyqUuOLS5BImowY547VMJ1Cdw7Ta+figXF71sxMxaS2LauI2boH9eQ/jMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140264; c=relaxed/simple;
	bh=jghCGzIy7p9uSqJnbjXK3vQCN8ngqa29cY7vIjFtvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE3Tbzq6AT1J+2sfZcRUbTyhCX3bcTI5AXZDgVp0UhyLeDZLO3dfcQ3SgmXEY1xpU4qSpcTZh6YmhRLYupMbHUlmP6W9MLaHwNcjumEuU1iT3e9SXvj7dNXT8ur9DqA2r304NpywiM4lwVGqXCDOwT1IcB1LogpM+szTgE7fYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ILeR1ure; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so45583396d6.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140261; x=1753745061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO0e2zu+aQJq/MmPYZDx4pcdsukyIFBubxiDqcUpUuI=;
        b=ILeR1ureTkzUAJkCuhO1lW+usZgGEk/6H41w3AnUlIcdLt2euIzHhMYbMnoaTMJMxw
         pN8kHp1/DSv46zvNy/BT15tQaI1nXNdHlDwQk7/rhnyzrddFtw4YOkN5W780THCfEwxF
         63CW9kcKdjse6UXivkFUiavR7AQiDEGOkKdT7uj8+VoEQfqyGZTmRik9ZuacGZ7Gyowz
         1nlBzK68gZvq33EBCe4J3Ro4wNdx+HVn0rUeWoVEEfhs9Yu7Os/NXD8SjjjX0VSCjIll
         WR0V0nHJAnSuzPhkIZ3thbgaxK26qOmge+HfEJuPn9njyxw/xbjAi2afo2XMEr2Vnp4m
         dFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140261; x=1753745061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO0e2zu+aQJq/MmPYZDx4pcdsukyIFBubxiDqcUpUuI=;
        b=UAr2aGetpofdcG74b7qyfRE3LmfQIAft4seug7aRb07UaTDv8xKv58o+pAZsiiram/
         z6Dad/ksx6WBRbd3SzCP0CuQOQ29FxbSquSenus6OSNI770wFhfLU4015iR8Q2M9RrBV
         f4YvjUQd7/xf8TfD2zN1Rg0xOHmPTVAdXIESCSBLX4/PAetdVBFTOclNbl6lPxhpVJFO
         dgHklhDEh6q+qjqUEfWTjFo3vGSZXMKJ/PwJrADaYTZ3KAg1QwitoXsLx80fR22BBs1F
         Ez8IAoGa1obubti2KMGkq62AOWMFpFW/CNfKFpVt4nz7NwLsNxqnh0Z3Eu8QUHSqszp8
         1ckw==
X-Forwarded-Encrypted: i=1; AJvYcCUCmlitRa03tggARWsJmS+BummMX2mWt/jb6r7kimAh9qb0/Ywh4p27gDcosYzRcsJUtgQU6A5FXpZMaMxJDpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3pnX6NT45TUDM8tDAwkCN4muWmXnJaVRIecUVUt4QDNegGwR
	sCpkYFpYXb+n4OXQfgv1B+DIkXEmBPCLFpUeAtEdKpWcdpixQj+NQBVxlJwBDAS9Mw==
X-Gm-Gg: ASbGnct5AbCnYjj3qSkg0D1G8B9k6ydvpGZ+Vqp0GVG1Lmj4C1L2dxRsfVu4IMUSdfD
	gPBr/mPQ8u6ul0aAljMO//N3BKc10w+W0/mVaID2+mZkcMrTkwe/erx+OoIPx1nh2f4UGStL6R3
	Z6P066/qYbVfs18p/tRYiBJMT7S6AYYyWHhiaYmEfjsFYPJBKHMqOtClgXCTnyB13QVdiVgb9Lr
	wQO/a23UNAziLB5+AC8VpAKkiqDC4+wQLnlPO06CwnVeAm8Rkp6CzSjfxPtDlJWxfKuuh64NWgr
	/YPy+K89dxPM6vPdFHGSJruFoiwQ/B+YdL/HJAiyX2H4zJPlhkBPPXSE+l5zy/PZSUlWaGGxfKG
	R/Jppcv1lMkJF0VAkv4wJ3xBeBxYG7p4zqFXJqllt9+KSW+vH9lOZ+hfxM14xlBVqX20=
X-Google-Smtp-Source: AGHT+IEWW9flVyXUXnPGIW0BJZKNpSh1tUS073Aq+Pv2b2pnqwuNdrOoSEusHh+nOVELu8Hmw3aqMw==
X-Received: by 2002:a05:6214:29ed:b0:706:c5df:df7c with SMTP id 6a1803df08f44-706c5dfeb0fmr159590236d6.38.1753140261213;
        Mon, 21 Jul 2025 16:24:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba6bb3fsm45869996d6.74.2025.07.21.16.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:20 -0700 (PDT)
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
Subject: [RFC PATCH v2 20/34] lsm: cleanup the debug and console output in lsm_init.c
Date: Mon, 21 Jul 2025 19:21:23 -0400
Message-ID: <20250721232142.77224-56-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9862; i=paul@paul-moore.com; h=from:subject; bh=jghCGzIy7p9uSqJnbjXK3vQCN8ngqa29cY7vIjFtvpg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvP2JNw8BUtzldH9FzS/sMYblqsWeRxvV02Y BiLJLWzRSuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LzwAKCRDqIPLalzeJ c0ODEADJ33VEV3xdJRuD+dVjLWmSAQqe3vUY5CpVVv85eqGMTJudHsZqpfQWizw7AxCYAwzEZuf UnmNwj68Wu0K9Ni4KuBbtJYR57j1ylLWWt7nhFw0vaQu2Nq2WioSdjIUr26g5OimpudJ8eORT4e aFOf5Vx/GCgr5nmAnpSn68DA+DazQDEVM0meY4/RFCvLy65r61ifz8x/lDcT+Gn8Cu4aFnvWhSG NFK1c60WEGwbT4nQzMxJvIl0kcW28G+2R3blr/HEKUAZUaMRXz9HcGxe30NLeEmd69MAjuVYMLM L4RVBkowg11jN3zeWfDYAoUhQdRuDNlcNYj6qMHvoBT+3sdfUrhAxKLVLpOzV3MrvetFmXOQVpR MZ5HWuDmO5NZ+Ykzc8E/Q312WiUTwhjMuHmoL3iPU+StgZzQH51o0gVCVjEDf+ZmRj27S4CV6ie pguO6iwxU8IYJQZ9JP4lIenYycAqlsY2XGKtRVV6NC2VoBomlms+S08Hu8/4yW5cpzdhum1lEdw YtH7mlouslsCI99BZ8hxXJO3bMEKoP5PWsp8LrJuUTTXypvPaRzf8+LYHG7CaYD/vsf/Ozhyw+r 45Kyzqgq5t2eTpkxKeO9+NWwDdxhK94vxa1b2KKzupd+iWKJwcrN3CJgBuF0lgJ5WzUAR+tTkGG aaRObipJF1mzxxQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move away from an init specific init_debug() macro to a more general
lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
both before and after init.  In the process we do a number of minor
changes to improve the LSM initialization output and cleanup the code
somewhat.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm.h      |  11 +++++
 security/lsm_init.c | 117 +++++++++++++++++++-------------------------
 security/security.c |   2 +
 3 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index dbe755c45e57..8dc267977ae0 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -6,9 +6,20 @@
 #ifndef _LSM_H_
 #define _LSM_H_
 
+#include <linux/printk.h>
 #include <linux/lsm_hooks.h>
 #include <linux/lsm_count.h>
 
+/* LSM debugging */
+extern bool lsm_debug;
+#define lsm_pr(...)		pr_info(__VA_ARGS__)
+#define lsm_pr_cont(...)	pr_cont(__VA_ARGS__)
+#define lsm_pr_dbg(...)							\
+	do {								\
+		if (lsm_debug)						\
+			pr_info(__VA_ARGS__);				\
+	} while (0)
+
 /* List of configured LSMs */
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 75e97f6b530c..0a8e4c725055 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
 static __initdata struct lsm_info *lsm_exclusive;
 static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
-static __initdata bool debug;
-#define init_debug(...)							\
-	do {								\
-		if (debug)						\
-			pr_info(__VA_ARGS__);				\
-	} while (0)
-
 #define lsm_order_for_each(iter)					\
 	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_for_each_raw(iter)						\
@@ -77,7 +70,7 @@ __setup("lsm=", lsm_choose_lsm);
  */
 static int __init lsm_debug_enable(char *str)
 {
-	debug = true;
+	lsm_debug = true;
 	return 1;
 }
 __setup("lsm.debug", lsm_debug_enable);
@@ -143,22 +136,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 
 	/* Skip explicitly disabled LSMs. */
-	if (lsm->enabled && !lsm_is_enabled(lsm))
-		goto out;
+	if (lsm->enabled && !lsm_is_enabled(lsm)) {
+		lsm_pr_dbg("skip previously disabled LSM %s:%s\n",
+			   src, lsm->id->name);
+		return;
+	}
 
-	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
-		 "%s: out of LSM static calls!?\n", src)) {
+	if (lsm_active_cnt == MAX_LSM_COUNT) {
+		pr_warn("exceeded maximum LSM count on %s:%s\n",
+			src, lsm->id->name);
 		lsm_enabled_set(lsm, false);
-		goto out;
+		return;
 	}
 
 	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
 		if (lsm_exclusive) {
-			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
+				   src, lsm->id->name);
 			lsm_enabled_set(lsm, false);
-			goto out;
+			return;
 		} else {
-			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_pr_dbg("select exclusive LSM %s:%s\n",
+				   src, lsm->id->name);
 			lsm_exclusive = lsm;
 		}
 	}
@@ -167,9 +166,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_active_cnt] = lsm;
 	lsm_idlist[lsm_active_cnt++] = lsm->id;
 
-out:
-	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
-		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
+	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
 /**
@@ -236,7 +233,7 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	if (!lsm_is_enabled(lsm))
 		return;
 
-	init_debug("initializing %s\n", lsm->id->name);
+	lsm_pr_dbg("initializing %s\n", lsm->id->name);
 	ret = lsm->init();
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
@@ -263,8 +260,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
 			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			     strcmp(lsm->id->name, lsm_order_legacy)) {
 				lsm_enabled_set(lsm, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, lsm->id->name);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
 			}
 		}
 	}
@@ -307,8 +304,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   src, lsm->id->name);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
 	}
 }
 
@@ -316,7 +312,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
  */
-static void __init lsm_static_call_init(struct security_hook_list *hl)
+static int __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
 	int i;
@@ -328,11 +324,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 					     hl->hook.lsm_func_addr);
 			scall->hl = hl;
 			static_branch_enable(scall->active);
-			return;
+			return 0;
 		}
 		scall++;
 	}
-	panic("%s - Ran out of static slots.\n", __func__);
+
+	return -ENOSPC;
 }
 
 /**
@@ -350,7 +347,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
+		if (lsm_static_call_init(&hooks[i]))
+			panic("exhausted LSM callback slots with LSM %s\n",
+			      lsmid->name);
 	}
 }
 
@@ -381,19 +380,16 @@ int __init security_init(void)
 {
 	unsigned int cnt;
 	struct lsm_info **lsm;
-	struct lsm_info *early;
-	unsigned int first = 0;
 
-	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
-	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
+	if (lsm_debug) {
+		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
+		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+	}
 
 	if (lsm_order_cmdline) {
-		if (lsm_order_legacy) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				lsm_order_legacy, lsm_order_cmdline);
+		if (lsm_order_legacy)
 			lsm_order_legacy = NULL;
-		}
 		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
 		lsm_order_parse(lsm_order_builtin, "builtin");
@@ -401,35 +397,22 @@ int __init security_init(void)
 	lsm_order_for_each(lsm)
 		lsm_prepare(*lsm);
 
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", early->id->name);
+	if (lsm_debug) {
+		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
+		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
+		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
+		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
+		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
+		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
+		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
+		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
+		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
+		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
+		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
+		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
+		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
+		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
 	}
-	lsm_order_for_each(lsm) {
-		if (lsm_is_enabled(*lsm))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", (*lsm)->id->name);
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
 
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
@@ -441,9 +424,9 @@ int __init security_init(void)
 						    SLAB_PANIC, NULL);
 
 	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
+		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
+		panic("early LSM task alloc failed\n");
 
 	cnt = 0;
 	lsm_order_for_each(lsm) {
diff --git a/security/security.c b/security/security.c
index 106f225f4a80..9dd1435f9965 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+bool lsm_debug __ro_after_init;
+
 unsigned int lsm_active_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
-- 
2.50.1


