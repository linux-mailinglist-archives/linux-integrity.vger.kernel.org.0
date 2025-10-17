Return-Path: <linux-integrity+bounces-7456-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207CBEBA67
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BFC7500F3C
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E426354ACA;
	Fri, 17 Oct 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XJ4FG6L9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750A354AC3
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732945; cv=none; b=p/qP+mZZYaeBl6ssv1lkzxcK5Z0lqD9pf+6T9ozT4IHF6uiTWFcke74Jsc8ti6bTND/ql2wnfDSQ263GqErXNjq/Z5x4XFGZ5VxIkAl0LEAwF5B3uQ5JXc31nlnbOlwfrIPGgt9UFa7tu982qNUH6DJNOOwMAfDmKiVunllUxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732945; c=relaxed/simple;
	bh=FKuOaBW8EbKRR2jAOaAhubSBWAdIh1EFBml02m1KKM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYSPZXUGQOY489a0u3/X7+KahfFIaTmt5pkPZPOLSNH+23A202VZT2kUj9HTk/w6EEvFGMnngWbcBVZ9UBP9VwV9oqyiFU7pYUqi80lyFl5UP7z+Q31RBNgiTCffnsOxxTHDClLerSGNKUvJbnNsZsDxMoNnPTsf78I8uflOges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XJ4FG6L9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89048f76ec2so272567285a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732941; x=1761337741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYMKDxqtV1ufYNAYW1WxlOdnJyhrPDJ415RwfsYa9Lc=;
        b=XJ4FG6L9VfFI3W1GoiFKehmQxg/AHiLIvYbOgCOfCZbl2HDwIVG87+vzJ49nXLDwf1
         cxPkOn2Hx1k+hTkTJlvFyIVKY61cjHU4n5DTQRtlkTyjyIAX/PpVX2eFg3JiUQtVh6ue
         q+lQkICddmPWco75Fu30gvRD8tocbisJHQEMiMn/gQGwQopMilk+Fh+zVREpzP5bNdUP
         TWsBBuen/qo4XAJ1DMi3WfUS39tW/fIGFCxuzhu/AJj5WYNOkVAFUfYk78H43jeINyr8
         y/qLgxuyhSy5RXZLzyNHs6X3r0Y8ORdb3ZlvJYl9/08eGzUIVfRjv/O+qHjOmHypy9qr
         ms2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732941; x=1761337741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYMKDxqtV1ufYNAYW1WxlOdnJyhrPDJ415RwfsYa9Lc=;
        b=VeMuBwSBE+B9kLlqvjIMPw3dBNy66RduB4ImMeXHS+CW7I7za2YBgnwye1pHdikR5d
         PnaWLJWgnw1FfrxHOvtP5d6qRRFoRHVoFVnTZDDDJPs2pYJv8M/rvQmFS9Hs8yhUaIVS
         6ziufvaA64ESOYQx1/17+auZxh+HUHbz3KpH4El1bt1sx2jTaO+0h0fuQV/tuoXqtC1g
         KPoK6td+DMHT58CHqpRSjBmbx+Ne9G8XvIToEEGEjO3/U7EVCvucz1PzOpuQOf6pfxiG
         xhyDVFUbsZU463VWlfGvAW70aZAdc/zaSqsivuBSYq4kJMC1wM54XZcTnPP5RhXQytDH
         IkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv1zOzbA2NogThl4FKdBCfXkNMa3Eft2kBJuNhH7Y0Sc1Ebhd0pVmoVoRURE+eCHCFKob0SwuUYsn8E2wZTOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fI4wIf1pDeQwjl8fxuB7Z0pjrWO/nptk60uLhBafHDcN93Rq
	IEl0g6FWQFKHYnEP0EfHp3qEweyP8Jhys4VjMY0LHV6bG9uN/xIA06xXd1BpmP6CTQ==
X-Gm-Gg: ASbGnctlDbwGf6LY8S42OtCePUeSrbcAtjUQf0R799WO3IsqSsWIimcOajJVEwfktZ0
	f946virH/34wxY2G2VDar6PQJ0PZNK1T9EKWfIA5f0kL9DUbxDdHsFn2Vt960U2aFIw0ctlukUz
	MG2xZbIFiYmGKOtXHP6FxHvov80wsO8zw4cLfuqoV0f/XPE78mOCjpPYcnH0b+wx5DkQJZKA5Tf
	REo9cDXPky1NaamDHAfHrjzgSCWUJD/pprmxssB8/j/glEv0wFkCzv+8NjevIC1bNNfFSulRvOP
	gAKgJsZ1Jo89hr5VtXT4zakMFIzZnB3YjZUNtEnRe+xbFM9+1OA29oH1In0vVmSXVg3roIn/M5g
	FS5dtfRAtdSIRyvSyVo0aFj0W/oUkRMD2M7gUXSNAqP/KTxFqGjujO6v2y3r+0qpgHTLUY0uQLG
	8VjfEuSA2GicQRzXDHZ+sGPbK+H/0/Dly7Zjv+BOu/6GIhMbzNY6AN+v/E
X-Google-Smtp-Source: AGHT+IFiDMBz3vJg/OLmLrFGuXmmYJAAyjEZ3jkr4dWkOUQFjt28Xm0Sotj38bBZr0iYd6+wwaqNpg==
X-Received: by 2002:a05:620a:838c:b0:890:9e92:bed8 with SMTP id af79cd13be357-8909ea207a1mr542561485a.90.1760732941455;
        Fri, 17 Oct 2025 13:29:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba8f0sm39572785a.40.2025.10.17.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:00 -0700 (PDT)
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
Subject: [PATCH v5 09/34] lsm: rename the lsm order variables for consistency
Date: Fri, 17 Oct 2025 16:24:37 -0400
Message-ID: <20251017202456.484010-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7576; i=paul@paul-moore.com; h=from:subject; bh=FKuOaBW8EbKRR2jAOaAhubSBWAdIh1EFBml02m1KKM0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYyyws4eXbGZDvXFqqCNbXCerM5hC/uzgVGK cyBwghXCt2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmMgAKCRDqIPLalzeJ c/1UD/wNQhKxCoGXqj2uLWGu1R5y0uNeoSMG4xE3PWHvJM1RsND+xm34dYCqbDBdIIHfEaOuX21 iIfYu44qDws6rOizGfIF+IASWMO85FLHzuu5fbt7EPDSUyrrB/CSea3aEKdkkifEczU+KI3hs6A 4xBxSEhkJ8gPSzrO4uPN+gA4BUyp5Kz7XHH0oCG0A6FScGkC4fe8sYiAfYjFO1eFql0ST8sEOIM e6AD/D+U22yM/JgBKgVIxyYX+aaQjUg1vWrY0kts79drrlTUw7U8B+nMSg75K/ao8eCiMyGN0zi E9n8Q0K/OSasYokYSOVnEiLVfclDwe3k6jMy/PaSs+PE8TVveMQv4m6Ewy5I+U0IWKWj3+Nzcog y7xaWRBJhRKaGxP2rFpA+RvAkoaGBoHhWm7fFO9rDjrIkhtm/JOEtzbxyTknkIOK4yY8DGdY4bK GppkkiIlniHnpiLX7lZ0G8Isw/ByPecN5ojjVnVIJ8jDpqlxBVF4vzWgK/AqjxZrHMjjtWgceBA XV+xRGLUoDSq4fMFMw/nd+r/zzSdsueUAuOGhbHksIhkVIR4gmNKJb65rn5COYuW7d8ef0YNPRG Nopp1hq7W+7dfGYKWs8wqMTRSwOW4zMXwE1n23YPOg+9L0P2YVDe2MwCLPxIaq+srTEjbIEGYEh UD/Oj/nZKiMLZUQ==
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 692d61a2ea10..a0785ca081c7 100644
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
2.51.1.dirty


