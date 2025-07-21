Return-Path: <linux-integrity+bounces-6670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55227B0CDC4
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A85D17C105
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB4243378;
	Mon, 21 Jul 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GGLi9Lbz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F31EA6F
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140251; cv=none; b=CbO4RxgDQrVwXguyz1kuRAJl9+Tjpxm+dkwal2XcO006vwKNv1xbEv21TV0T8Vjve1cdgYbgDVOGlRmmmoGMAqNRYMoDg0p2XMA2wJLX/x8mond3opGxvvc6GWW/tHx9N3E83IVEb6DaBPS4C8rD6spz/cAMMXasNEESEjiCdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140251; c=relaxed/simple;
	bh=kk5aGdiMWFOzj96dVu88jEkC4aJTR3bHu3/m2oIdYwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXQcyj/jqLeeyNWC4i7T1GEY2Y4wYpl5iBYaTbc7ekSUoaibcBg2JTS0ASt4XRIm3kNZ94GoQfpsji/8keZcVifuX36FHAuGvcdPWnNoPk3pjSDnbBYVp6eP0Fa7ig0iefonQ7927S/Lhitf2hlTksC/FfTYQIC/w0KxXmM4AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GGLi9Lbz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e32c5a174cso468168185a.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140249; x=1753745049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjhlDMyUUlhHk8O1AjfrOqCnwrgv61ssjNT2oNHdpyM=;
        b=GGLi9LbzB7vI2XlI1dcxEy564HTTzTup9e5nW1/XKgCfo1yk/tCL6P+2Svsnjx7NAt
         HxtwN5PK2Ty2VbTAThTDcjSXmxbqm0CX/mPobcNW757gUYY6SE206P6Tzo91VuDk1mUK
         LdR9qFQvPQDcHci6zT+QZ4jF6cyQYpL5pf3x2smxqd8Kr18HUfSbV0J777g8qjAOh846
         989Sw0RibXQ5Hap+dwYKHkRQwBLrFtaKlKZ60ITUu+8AKd7mS8ZvG9ffZk8Hdzu3m1dm
         9p5KOVjS2I3at4xhuMMtC9cgYdMB4EBX++qzdIoq/IP7XneIi/V71/aEt6m0wR6rLMOk
         nVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140249; x=1753745049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjhlDMyUUlhHk8O1AjfrOqCnwrgv61ssjNT2oNHdpyM=;
        b=A2KYagummYWY28EZ5ECHdrA8RGFTWoICgjmq3/wqBT6kco9yDS6GizAXx0pmqkkqaq
         K5GKmDSoI1SgKNoevjDeKG0+CUh68abZy2t4+6fg+0SFDuvVOqkx0m7SEV8lzFDNPHDz
         tKIvEL39RbQ1EcZEa9IiiJhP/ei9/INaYcTYs0BCm/uH//PCimyrR4Db3K9vGTS5OotV
         rQeUYKfdYgbvoOWme5m27UzHc8YOiIYQ+9F8QW3WVjrU4sS/KY/d/C0L8cKbfhr3tZCD
         USdNQzkpsvwae7NlCi8emV4kBGl0qBse/a0SG0mlgviqj5H4zOtXVEl+BqVD9Ta85LNB
         e6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWuP0CnhewLGzGaXugmAfz0g0TlLvIm50NgCUCpJRsN4F+YB3xI1yrRDIN7Eh+uN6uvmrYr3tC0bmxEym+/qYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGA6qSnro2DCNCcHRTXhUcYKu/yWsKS0KP57AztAqvuFIyLMrd
	qt3aOMSu+8eWk+Cla9RRNeobEG9K94IQYJsdG9zPFoMIzPW4Z2hlxCs01Us7u6xfMw==
X-Gm-Gg: ASbGncu2NZUyN4mzN18u03eMmGqm74G2rvgQGG/iMkg9v29miuWxUVNq57+lGomolis
	JwLmclwwUKe/jb0bs4JRTa6fDCuHdSrupJyRhSypZCGbTtKdQcOSDDbWOazMLVSs48bfJXZ6EXM
	q7R1UwEiV5PXvs7oM3IyA9P5ihl5qRanafparIroXBdpbP0zPFo6UU8/24OeGrruetYYnADqviS
	+9PGaf2di3p9cB6jXuASAxUXg+fAX/fsrTOYcRUoOgvqORtMRX8lMIddW0I8FDMaqkrGe2XHs3Y
	lcMeVJshgaheddTxTjAYeWMU+72Q5gfX1iWnEdrAv3Z3gyUOGcABa0gTwYC511sQadBf4eWVW0o
	Tz0ZG9ycfbhS5ORSwoEieqibSd5SXk/Pn9z/uTJJJQUkR+e9gC3Y8aO2JUTikF4CQi/A=
X-Google-Smtp-Source: AGHT+IFMgBU6ZY9RthRMwEdK0kJZf4J+Y/lR2kGJuuVj5aEwR1TeX5pmswC8RhbzFyUnF+aFv35CrA==
X-Received: by 2002:a05:620a:1127:b0:7e3:487b:2a74 with SMTP id af79cd13be357-7e34d9d1edemr2084956885a.42.1753140248897;
        Mon, 21 Jul 2025 16:24:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c4840dsm459262685a.67.2025.07.21.16.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/34] lsm: rename the lsm order variables for consistency
Date: Mon, 21 Jul 2025 19:21:12 -0400
Message-ID: <20250721232142.77224-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7468; i=paul@paul-moore.com; h=from:subject; bh=kk5aGdiMWFOzj96dVu88jEkC4aJTR3bHu3/m2oIdYwU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsupH9cuXuP8vWUlpw4JccNwJUN8H7P/YaZwI L6wdDi43NeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LqQAKCRDqIPLalzeJ c6XPD/9BBdlhXVOrzwIPYAfOsQYbyAJWGRZKPysqSq0zJwBVe83dDCVM2QODH4P4tJQli9rI/rC aNLLx+jRECbHjrs6+EmaUwNwSHtgUR/6RwKzGl5fIl6e3dwXfCjw+AuGJb4b4Mqxe1GicIkxy0S tAQGMwHp9sTnTuEZ4HJHqRvzOp+mZ6ooC2ot272+vaU5SvNzSgf+yvoXRXnykIJg18nX/lcwr4X X0y64yKJc1pXbUiGjcwqMqKmYH4hUY6+zEorP9n89n0rUnf7FzUMs3cfyz5mzvIkf0+Pw09RPno lXGcGakPT8DB892PIPHlRSWrCQBSuEDil2sDBv8Qm8KZ6JhlnCnDm1DPZLzrZR4Eh2XIOB5Wt+z LX+UtKq26BHro4lE0jaWIMCwPJ2s5PstiaaX8mEDIE5SuCQre4N8YWz+JkwTt3BmZmPtiIsFIBv 1UhBke8D2exCJ21Fukeb1k+Ru5PzkFR1AUCmvCbjWabz34ckW+FKHdlI+chKmDQdQGFDKhDU2GW L9c9mA60Gm1tv1NFOj2C4kZH0HrF/DLsECax4m1iBHh3rlop0g2NzkNxAVNDHQcQxXFyU5a5+xT mAAvbm/n0qOUOygS1DJwcqugqf5neELRYdm5dyrTt0HotHTsEWDt0gMuZk4xKMTvCSRZrV1Iy5m ocqmOSPw1/YTxoQ==
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
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 96d51e4d625b..cbdfac31ede4 100644
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
@@ -223,7 +233,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		struct lsm_info *major;
 
 		/*
@@ -234,10 +244,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
@@ -262,11 +272,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
@@ -298,15 +308,15 @@ static void __init lsm_init_ordered(void)
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
@@ -467,9 +477,9 @@ int __init security_init(void)
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
2.50.1


