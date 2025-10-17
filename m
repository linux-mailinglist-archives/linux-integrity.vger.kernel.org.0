Return-Path: <linux-integrity+bounces-7459-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB33BEBAFD
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEEE7454B5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90134354AC7;
	Fri, 17 Oct 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LCIkcYoJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482D354AE3
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732952; cv=none; b=rUe+5K0bEGaVPjK7sjGK2TU3Dz1vFQo1lsdsNpSZkTl8j6P4jIbz0tq2wi+ybZC5f5bhVQHqS0BnlQiDjwU9hjR1Ci23gcT0mC09oBzHK+I+9B82Jg8vTVcXzI3f2xPjHg/YOrl4czC3J9pIIrn9NVJFlTw0bT6MyL+xs9nQqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732952; c=relaxed/simple;
	bh=93PUjMINFInA4qs+FleZm5xv6Nq2SbOhhzRHTKuw5mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oT71Jz9Pq9On+0CX8UIr7MM25VDyW0sCWJcGJ7fQ/rtfobGYI6v2uja9K5jPWc0qO7orEl0gTlZt93e5De9b79T599UqZsk00saW7r8m/rusRKGBHHLyJ/O/1kYOLxgvkgBl4nufFSlymN8BhtRGxnYfhRW9k10xHBp9P6XXzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LCIkcYoJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c1877b428so40365296d6.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732948; x=1761337748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSrmi7WO+eP4H5W0cJxn8xx23TIzgbersd3U8w5sbTQ=;
        b=LCIkcYoJ/eEI9r0Gtl3g5Vrm8uKqnFlwj/8JpKp3ibsOQsTPILl12/B9/DvXXoO8wI
         bgNZRzaiWRs0dFxyR79TFZLZlrl8hg9VikUbbXLJ+u2si9njy53vAkuuxLD3QpA3cwQC
         xBxWOme4Ww1KGl0Kwmx9qomBKfWnPA/U8r1hOP869MydKpYE06WmPyEc+3aTciNEbl07
         2fKz1eomLNtb2LFmdHtNBghxmDT1tPc4tzl0HnHDnWNsirLm5qDa36k1BtIOuhI7mA90
         xsLJ2u+JQUojoINGehQfnBw7FDcy1sQKOXbhOG3KMwJBry5xyPHlo65PU2Q7OR6Y+61Q
         JPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732948; x=1761337748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSrmi7WO+eP4H5W0cJxn8xx23TIzgbersd3U8w5sbTQ=;
        b=Y5icGqoYK53qA02SZe8IJX6cPRPf+uz1Q6Iz6Z6uE7DMsvKtjvbtt1IwSdZurAd95a
         u70ML0yiJdcJ7KGvEa1w4s/XG4upMXqySgsnV5rOhpgQIBCnErQJPNLR6eM9pCbEEUE+
         Y+mc0ZmdGFv6VqEbSqCFXmHXt2OYskT9wQvlZis1dwxze6e0iBsX7d7QbbCCyW6Pg9Fc
         G4Ur1ZPWyUdsfyngf+Qyp86dC5glXePRoPaNi1HOhMIqNByS/jDXGXUvTbB+QsvDuJlS
         GdVrchYjctp5J1O86OzswHMRQtxluDxG3LFip8iIAeOeuh6opvrxeyW1KzjoTDnvpXvQ
         ziRw==
X-Forwarded-Encrypted: i=1; AJvYcCXtmhit9dbmBe59BCoIF+DPnS9o77CDeC/14Q6XMnX7M55UlKysvF1rQohL8sKiCSqd35FuUwUar9uoYit80is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXcTEh+KjOZb3PD17JmHQLxUnnKBYGvuVlzFKsIMsoo1XeGB7
	y8YWnhX3VaK5lCzZB+bxnrRMpG9ukxE4lShVc1g7Y/NqnDW637v92QA7eGPM5nLNow==
X-Gm-Gg: ASbGncu7p8N/cr7Tiq2UExgy2flho2xniMmE5fPpS51am5mmNzw/Vu/47usMSoy8ogy
	w8RLhm5DG2ax1lTWm3xkWFITj1WkLoTtTmakCDLj0L54rpM4fCbZwvx/+cPtJyCar2HhNouRU2D
	8QmeH0I2kwsz0yJobb3+1fgk3lhUDf5+z8ce1NzPlZK0ncc/CBX1A8BK9CddgwIZG9YXrsL14EO
	mMOFbsDYPiEz8Ryj3I8pCmMj4Ajr4pUevHaROCkisv4WsVZIX8/LQTsCcuQjgKyAjBOhBqDmuzC
	DCH7nbfVbRcr9LM3x1Ktpubm3hXhHK0LUZdwLaroXeWcYq68v68LEQBCMnyQe+h5rn1Y2UXaM2H
	IEPmNEdPcfSvNi1uCGASWyjcVWf9/1/f0dyWEjCbp9EaeKSAD3F87nEurz3YHuLznRMF9em6jds
	pOnYhBHosZFwgjl/U/UKJgP4QjuXZBK7cV4H6KxLmC6y0Y4A29W+jjNZg3JTMSjFXWHS8=
X-Google-Smtp-Source: AGHT+IHchO2YY71gAgidUvmq/Xh3afVnx+z5gP4ngIbh4bmt5gpkibY/BzZzfLfh5S8Zmnl+BtZthw==
X-Received: by 2002:a05:6214:e81:b0:80b:b364:8b2c with SMTP id 6a1803df08f44-87c20542f12mr71960756d6.3.1760732947632;
        Fri, 17 Oct 2025 13:29:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad4a0sm4736966d6.47.2025.10.17.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:06 -0700 (PDT)
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
Subject: [PATCH v5 12/34] lsm: rework the LSM enable/disable setter/getter functions
Date: Fri, 17 Oct 2025 16:24:40 -0400
Message-ID: <20251017202456.484010-48-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5560; i=paul@paul-moore.com; h=from:subject; bh=93PUjMINFInA4qs+FleZm5xv6Nq2SbOhhzRHTKuw5mM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY8uZKOF6pDLCG2oc6gYt+iZIbJxdu50Q2aO N+gYM0sGZiJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmPAAKCRDqIPLalzeJ c0BeEAC319SogPIRA7aP/PuQTZrM4Usrt/qZrBjpxOta2OpzXQI9rzoIaYP/DFM2vVl1++MCRda jEL/6V/wxw4LWnsONwSAaMItEoFFl+tRgSLVRLpUI5pUDisfuA/UdvRKuJcFatLPXfSdtutAqLi ZErJbcSpMgsMXdFaITCRTdI79dtmMqfzCHfLR8rKSKwFwLJACXPe1aY3c0kpJITVnrySXIHgzyv as/zK487O3VN1jyHUCXNM3p32lCM6D1nlJOHrcKm9fEnKl5BLgJuWflbK4gxAs3a+r2yhVHewpi //tjS6w3U2c0XRKEZE9YSymuTkCBes5n4rtzX88un/QRuOI/XwgemahhvJroUzYoAqczp6hojIC Z/9hQCwiFpch4ZMEQ2uzTCCpKbW5SArndTv9AEcMb9aq4MAHJ92P8cuIvc8YeAGYx2UOciwckqo KVW1NsTDz79TExb5FF+1Cf4szZ6QS/GM0Jtu/VB3VU+ZOr3RbrF1I2XSX4bOkzGIt7xg6qT+q4h phj3yfD8JoMKyms3g+T3IBQpmbM08y/UuyILMC9/W6eBBsoSxcOQWoiVyWkRkBIEdi/eVJp/Z9h eTguS9s14UN76bVQ9T6LYRJ4Ftv8fqGo2A7XonDF+HVZk1a4E9oNcR1tUR4q8fetNyEBQ+R3BVB jb6GrCehNYgYyHQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In addition to style changes, rename set_enabled() to lsm_enabled_set()
and is_enabled() to lsm_is_enabled() to better fit within the LSM
initialization code.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 574fff354d3f..9bfc35b44b63 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,6 +10,10 @@
 
 #include "lsm.h"
 
+/* LSM enabled constants. */
+static __initdata int lsm_enabled_true = 1;
+static __initdata int lsm_enabled_false = 0;
+
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
 }
 __setup("lsm.debug", lsm_debug_enable);
 
-/* Mark an LSM's enabled flag. */
-static int lsm_enabled_true __initdata = 1;
-static int lsm_enabled_false __initdata = 0;
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+/**
+ * lsm_enabled_set - Mark a LSM as enabled
+ * @lsm: LSM definition
+ * @enabled: enabled flag
+ */
+static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
 {
 	/*
 	 * When an LSM hasn't configured an enable variable, we can use
 	 * a hard-coded location for storing the default enabled state.
 	 */
-	if (!lsm->enabled) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-		else
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_true) {
-		if (!enabled)
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_false) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
+	if (!lsm->enabled ||
+	    lsm->enabled == &lsm_enabled_true ||
+	    lsm->enabled == &lsm_enabled_false) {
+		lsm->enabled = enabled ? &lsm_enabled_true : &lsm_enabled_false;
 	} else {
 		*lsm->enabled = enabled;
 	}
 }
 
-static inline bool is_enabled(struct lsm_info *lsm)
+/**
+ * lsm_is_enabled - Determine if a LSM is enabled
+ * @lsm: LSM definition
+ */
+static inline bool lsm_is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled)
-		return false;
-
-	return *lsm->enabled;
+	return (lsm->enabled ? *lsm->enabled : false);
 }
 
 /* Is an LSM already listed in the ordered LSMs list? */
@@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
+		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
 static void __init lsm_set_blob_size(int *need, int *lbs)
@@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 {
 	struct lsm_blob_sizes *blobs;
 
-	if (!is_enabled(lsm)) {
-		set_enabled(lsm, false);
+	if (!lsm_is_enabled(lsm)) {
+		lsm_enabled_set(lsm, false);
 		return;
 	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		return;
 	}
 
 	/* Mark the LSM as enabled. */
-	set_enabled(lsm, true);
+	lsm_enabled_set(lsm, true);
 	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
 		lsm_exclusive = lsm;
@@ -206,7 +206,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 /* Initialize a given LSM, if it is enabled. */
 static void __init initialize_lsm(struct lsm_info *lsm)
 {
-	if (is_enabled(lsm)) {
+	if (lsm_is_enabled(lsm)) {
 		int ret;
 
 		init_debug("initializing %s\n", lsm->id->name);
@@ -240,7 +240,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				set_enabled(major, false);
+				lsm_enabled_set(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   lsm_order_legacy, major->id->name);
 			}
@@ -286,7 +286,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
 			   origin, lsm->id->name);
 	}
@@ -319,12 +319,12 @@ static void __init lsm_init_ordered(void)
 
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
+		if (lsm_is_enabled(early))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", early->id->name);
 	}
 	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
+		if (lsm_is_enabled(*lsm))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", (*lsm)->id->name);
 	}
@@ -440,7 +440,7 @@ int __init security_init(void)
 	 */
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
+			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.51.1.dirty


