Return-Path: <linux-integrity+bounces-7114-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14831B7D513
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4ACF7A6784
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD246306B04;
	Tue, 16 Sep 2025 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bxt9lyAE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6132BEC53
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060834; cv=none; b=AbDOQBOzqiECJUAkGN2We9GVrLGtS75CJj5i3GeJ4EeBjYJH+DwVSIUZeUcjmSt/ePhYfdFbzq8po3+UJmNrrb/flZm3B5rTPnR4ctH7sEFSo3LmSrKWIyP9ANRLXFgH3wPYZNFgNohCUAG7VCwmP/mFcSJbKOKXcTb6ywlLRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060834; c=relaxed/simple;
	bh=IJeF3QrMHsq3gjoMx71oCxzhuwnQwF97bk5MSKfeLhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V79aqwBG5fEeCndXXWoaZokcUT1d8r29AAP3j7NF9+ytdy5NQSiGai3F++v+Z4MKThh3rHJJX9s3K6nS1cHZ1T1z/1uRXUwcm8ORPsBCukfVkoFDcYev2djI25eLtb4W6GrcpXTczNJR6Ch9F7duTekxvAM3M1iM+d45UTyHcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bxt9lyAE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-82884bb66d6so33696885a.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060832; x=1758665632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xPnzJnzJ4X3YqJuUE/FruVjCaq/bs5jkec9IRj5NRs=;
        b=bxt9lyAEvdwaG7W2qLvuLd768XjFzl1XWRYgg13AiRqNB6pBiVoXQE9eIx6382yhgK
         Gj69Y+uJntg5GeS601axWVzaD1ajqPp0Ds+e0E8v1InTeWtwRU7ngD6VrOSZQE27adrV
         fFCLLDuaGv+dsjcQcWU1DqHhDMVMrrraVDGcanC/+CaY6y1yHzYvsdbCguKH7kGUZo6N
         10sxwVue+2KRhxB71DOse2tBgKbYyOqZ/PE/UPRsXExaM0uZNOKWh9bCNpb3ucwyMIpR
         NtxXDiwgSaIwxFroQjbq9XRu6uPuXo1x2Q47UYQv/91wX+O9yuyCRpwjYCW/n1eMKjJK
         qPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060832; x=1758665632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xPnzJnzJ4X3YqJuUE/FruVjCaq/bs5jkec9IRj5NRs=;
        b=OvcYKtMkMwO/2Vh6Dy+PkjVU8oD+ZyN1N8xTko5vDvyjUf4tNxf9vz+iw0TdxJmq1x
         PVlnGRetchvDhnQPV2uxi8d8KIqg7NHVw286S9QjttG9mlQPmKFRNb8FapuS+u8IaCmW
         nKWqppP7C+5PWeXLhBjgoNS7Fccb4XoHhquZHICU/67HOZAzf5yUg/Lw/YIVQdpvJ445
         QM7FZfFlFwHX1Ewl0Mogft4Q5/6FY7Fu+LdVGIY4hFfZXuZFwFJHMhfhzh+sQIp+dIcx
         0WZfBIRqNsmLldv42qnk/kpvqeNsdXa1ARJZFwpt34eqC5tFZe7ByVNqgnM+M+9BdDWt
         y2vg==
X-Forwarded-Encrypted: i=1; AJvYcCWPA1ngPddaWDpqv0SSzmYCnhbd067z7kAHNaplh1FiBPqO7+egYC6nbrbC4q5mrto2Y3RTlv4ZGfE6gBKFWOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xBwnbyt3vZTs2ZSUDiBcvrV1eL5awBdChfoSeYbujaFaNaYT
	Yrg8SEnb9cqdaEo+sJqBA1Qx0oTSXXdCSEhT2whumEl0oVQwWEGullQs9XWzuUMyPw==
X-Gm-Gg: ASbGncu0Kz2ITx+eL9QERMQ6hhuFrsu0m7Gk40MRPUiLiPn2eHLbsDHvBxzASRSH+Ym
	TX8pXbpeP+29eg41056znqRQcPFWgo/TRhsu9AfG2kJXxOZm40tQ+A/s96Zbx7M8fxaay7IZZBr
	Se/yHXeFTgej/W48AcAXNcMD0ImXmsEM92HWQHKox4uENAZJnwAIlq+821WyuB93/Wf11s3eHIf
	4J30t8IWKjxTybqEwvuUrTztUCfAvaz5TBXJyRhC9hVmDRWQMuxRsMbh3ExoAZtTZ4j6n5EoE19
	ow/Myaw7yFTS7mT9k3X+v7uE9/NC2ROZ3SuMVQOPqwgv8KxlbnrC6XUgvcVBz5F57dTyKEcSxQI
	UFQJh6qFGrMrwsxmcKYul/gANsuJ0DiRO1Jutxvm5WcRXun1i7lQTyKs91Rv2lHGXwbka
X-Google-Smtp-Source: AGHT+IHzyhdwLQK4r+Al1q6koPJsj6ItHSbSn7/XNckAWZx4fa+eeOr5fZWct0V+5qsEKWS7+qvG5g==
X-Received: by 2002:a05:620a:1919:b0:814:b180:9c3a with SMTP id af79cd13be357-82b9d10f377mr408298685a.26.1758060831925;
        Tue, 16 Sep 2025 15:13:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8290e22eef4sm530187085a.49.2025.09.16.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:50 -0700 (PDT)
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
Subject: [PATCH v4 09/34] lsm: rename the lsm order variables for consistency
Date: Tue, 16 Sep 2025 18:03:36 -0400
Message-ID: <20250916220355.252592-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7523; i=paul@paul-moore.com; h=from:subject; bh=IJeF3QrMHsq3gjoMx71oCxzhuwnQwF97bk5MSKfeLhk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7me+dk3yLOfpNYgGPhmI/shLqeuW68pcqg2 xAqCzMeB6OJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne5gAKCRDqIPLalzeJ czpIEACXwzjU7jy9Iv4w1ZVhuGEtludCtr86Qqb5YmV7aewuS61DLZTQW/obzgLIbi2iNH4eCLH HOqV1VmTSuzlSKQP++sePjZs1vWbdJM5zglHm6ZZB8cE1vUBaBJeu4a5pS9m0iD+aMWO7wEdIIx k60/CdWoXfhkDq4zoUJ8JgBgpU/tqhzESIyjv1vKqHvl66jim/5F+p63YhA6GSB10r4eLjallAF I/rUWYt3wF5ao0BakJAMtOSiGh9z0cmLfWcflN+dqrZu4r3fkx2jgB7Mhh1V0NJychXKWzgsdzt r/mbfMpUZDG8LUEnAtDAylDzcDnwF0y/1i2wnAgmKSB1Z3yQKiZLqWzo9hCaevN6XEIVKyiVrj3 /FIMGa/ki2e4zhBXIdJcTW20JO1+ojIkdsOpGEo/aePKHmDep7llSdl60lfliD7w6++B/tTh369 13g62BC+3/7Uu0CR4ijYlDNbLZeHASgnSWTRSenT8f+Bn6tGvV4PzdxiferO4KMrGV/CtkcMOQ2 xc43zYN0DUptYgh0oShyWpY+zrk2u2tDQqw4g4qpMUYO8Ct5cWNWytMRwxm2Wvo25m9eooxp/j1 UtkLPmskujxKz5zTKysQWuQQcIjBCMwloL6qo8zHiLOpd3x0ug/75byUBIxy+WCZuh8cTdQsqih mbf3GCM41BRK4PA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename the builtin_lsm_order variable to lsm_order_builtin,
chosen_lsm_order to lsm_order_cmdline, chosen_major_lsm to
lsm_order_legacy, ordered_lsms[] to lsm_order[], and exclusive
to lsm_exclusive.

This patch also renames the associated kernel command line parsing
functions and adds some basic function comment blocks.  The parsing
function choose_major_lsm() was renamed to lsm_choose_security(),
choose_lsm_order() to lsm_choose_lsm(), and enable_debug() to
lsm_debug_enable().

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 628f54790360..2e76cefb1585 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -16,14 +16,14 @@ char *lsm_names;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
-/* Boot-time LSM user choice */
-static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
-static __initdata const char *chosen_lsm_order;
-static __initdata const char *chosen_major_lsm;
+/* Build and boot-time LSM ordering. */
+static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
+static __initdata const char *lsm_order_cmdline;
+static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
-static __initdata struct lsm_info *exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
+static __initdata struct lsm_info *lsm_exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -33,7 +33,7 @@ static __initdata bool debug;
 	} while (0)
 
 #define lsm_order_for_each(iter)					\
-	for ((iter) = ordered_lsms; *(iter); (iter)++)
+	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_for_each_raw(iter)						\
 	for ((iter) = __start_lsm_info;					\
 	     (iter) < __end_lsm_info; (iter)++)
@@ -41,31 +41,41 @@ static __initdata bool debug;
 	for ((iter) = __start_early_lsm_info;				\
 	     (iter) < __end_early_lsm_info; (iter)++)
 
-static int lsm_append(const char *new, char **result);
-
-/* Save user chosen LSM */
-static int __init choose_major_lsm(char *str)
+/**
+ * lsm_choose_security - Legacy "major" LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_security(char *str)
 {
-	chosen_major_lsm = str;
+	lsm_order_legacy = str;
 	return 1;
 }
-__setup("security=", choose_major_lsm);
+__setup("security=", lsm_choose_security);
 
-/* Explicitly choose LSM initialization order. */
-static int __init choose_lsm_order(char *str)
+/**
+ * lsm_choose_lsm - Modern LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_lsm(char *str)
 {
-	chosen_lsm_order = str;
+	lsm_order_cmdline = str;
 	return 1;
 }
-__setup("lsm=", choose_lsm_order);
+__setup("lsm=", lsm_choose_lsm);
 
-/* Enable LSM order debugging. */
-static int __init enable_debug(char *str)
+/**
+ * lsm_debug_enable - Enable LSM framework debugging
+ * @str: kernel command line parameter
+ *
+ * Currently we only provide debug info during LSM initialization, but we may
+ * want to expand this in the future.
+ */
+static int __init lsm_debug_enable(char *str)
 {
 	debug = true;
 	return 1;
 }
-__setup("lsm.debug", enable_debug);
+__setup("lsm.debug", lsm_debug_enable);
 
 /* Mark an LSM's enabled flag. */
 static int lsm_enabled_true __initdata = 1;
@@ -127,7 +137,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	/* Enable this LSM, if it is not already set. */
 	if (!lsm->enabled)
 		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm] = lsm;
+	lsm_order[last_lsm] = lsm;
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
@@ -157,7 +167,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	if (!is_enabled(lsm)) {
 		set_enabled(lsm, false);
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
 		set_enabled(lsm, false);
 		return;
@@ -165,9 +175,9 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 
 	/* Mark the LSM as enabled. */
 	set_enabled(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		exclusive = lsm;
+		lsm_exclusive = lsm;
 	}
 
 	/* Register the LSM blob sizes. */
@@ -226,7 +236,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		struct lsm_info *major;
 
 		/*
@@ -237,10 +247,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 */
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, chosen_major_lsm) != 0) {
+			    strcmp(major->id->name, lsm_order_legacy) != 0) {
 				set_enabled(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->id->name);
+					   lsm_order_legacy, major->id->name);
 			}
 		}
 	}
@@ -265,11 +275,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -301,15 +311,15 @@ static void __init lsm_init_ordered(void)
 	struct lsm_info **lsm;
 	struct lsm_info *early;
 
-	if (chosen_lsm_order) {
-		if (chosen_major_lsm) {
+	if (lsm_order_cmdline) {
+		if (lsm_order_legacy) {
 			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				chosen_major_lsm, chosen_lsm_order);
-			chosen_major_lsm = NULL;
+				lsm_order_legacy, lsm_order_cmdline);
+			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
+		ordered_lsm_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
@@ -473,9 +483,9 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
+	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
+	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
-- 
2.51.0


