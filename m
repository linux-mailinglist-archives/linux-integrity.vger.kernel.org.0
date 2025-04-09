Return-Path: <linux-integrity+bounces-5704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B018A82F5D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7641919E6BC5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D927933D;
	Wed,  9 Apr 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="acZCaTJ9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEC278147
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224821; cv=none; b=iz4dzG3ciQxXc0xutpR/FmweLbuoaPN4OXNoHNzTWn+19rOVKikbgLjmj7vhY/kjORr1XDJkVJ33EF1Ay/LeVDPNUkZ78Wf+1BdUqNbLPSHXgtkoSlsdG5g+Xq8i0hnI/4GAsVL4SGVjn0B5YFfWqbLzCd4/0Rgyby8F3hx6H/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224821; c=relaxed/simple;
	bh=RHbnsK02hzjrS8frwf8Vo7FRCVXpRvvKMlPX+QXLt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU2SKvzlfdDsmuy64pFjc9ay3Od9lwDQ7F9AnNucHTcyHOqRsSF64NVstHEL2VnpZ09Phqselw81ZM5Wdv9ZxwRBoCYahPez3S3D2P2VXiWFGkbDsDJYkX3e444pEmwdePHCzI4vcmOZ2AueWFfgnX9mGqnqVDqINz4eLwH7geA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=acZCaTJ9; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47686580529so75205481cf.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224818; x=1744829618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpg8TLVIx5hZyl/UYe7udGyYnbaCZZ3wgmLEvSZScvA=;
        b=acZCaTJ9yNxf5ravNJ48c4d1ByncY4UhnFHx3h1mbYmmi5hHt/BUsMOw76hLLX+65F
         UrfPlZcBXrmSBVst8VIIGiog1YtusYIbu5zpgqQEMElLzNu7abXlVXWuIhy4iHDh3Wql
         zwsPC7pJOSyOJqjbqv7dYT2C/RFK09joN9qbk5i+S84MVDAuMSxWJk+7sy51zYViwd2R
         9tAgPYxUQbqiurWO/foAQSuenAZAeo7Nu134B2Yv+WIOky+lkXKN2Roy5eyU4KYYvtC/
         JBbezKD7sjw7WSgtf8OccEIOBDr8WDPz1EY5YRYRLQqhuLpdbJa6f3PHgdwDQpRsk806
         PH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224818; x=1744829618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpg8TLVIx5hZyl/UYe7udGyYnbaCZZ3wgmLEvSZScvA=;
        b=lvQadpnywltIGtR3QY+npaZJeAeTw6KTIqLsCkWYqdH+qv8nGKUwVeKDi23YEwYgu1
         TjsNaTaBjVWdchpkFn498eaA03cCHYWE9jtfz7p5Aq1BCVTJiXxFOea9Yntz+bib9Hfd
         6lekvCNUj5atLHlGK8JMp1YH7imzP/z3ZudzKkhUP99w4s2/vPMlB0/hqDjUcGz6rEt0
         MqywpjW6Y+zDBr4P6aAGyedRwjQV048f/RsxWwtyIw7VTCMpSUK55qGrEvPNDXolx/kp
         feDkzK/WUXsgLrwkb/m5FAcikldIjPe0NSOfzyKxTv5Z+dB9fuxFi+tZEyLaiSMFMhXE
         p4oA==
X-Forwarded-Encrypted: i=1; AJvYcCW8N949A6cKH2d/7ZPoE8WBL6mUcq+UiqIRuRw9LHi/xI2NwOScJMplIj0oxNTWMKmi4zTAX45TO/p422IwHWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4HJBPkUkmmMNYIwasARmd3M1ubd0KiXEt77Bfz3/MC7V2XnqP
	F7mZ5ApDAuq7c2Zj5O9pvHRn/kOQlAEXM/R2eY0esY5VRanR8bvlVIa/KsNuCw==
X-Gm-Gg: ASbGncudyg8RxTJzJeMzD53CDrkVKoUby6PRGgDxXUkl5TDYwWUYur2T6THJqeVuYeA
	xOpqmfBPCFC5eXKGpLVekihkt/VrpIxOypRRKb6XFsBuI7NYL2C9UsYruBxSj7datkaV+YhNvJ1
	KCE13TQ3ybtRRGibiDqXOvL2j84gJO46cmqgNIheGzKB3XjzSS0vncILD+Ss5kTc283SDTjX8Vq
	GqR0rtj4D/K93bHs1WsF8j4H7UiDjdJLPn8Yoqk/k7qirVpYaxcKnzV2fjZuP5JT2ItETQK5o+7
	Bti9DdBcwyA4ilm04KbkwY42VrzJP+2cHmX1n3whKySV9TriGSD/ijXSUuzIllsJLwN/LuFyjwZ
	2ugY8b8Vivg==
X-Google-Smtp-Source: AGHT+IF+jktutGM7t2K+70yLjoc776B9uVK4nz254ga9W22nLte35+XJhIJhJpyDgwBbmzKgTLjp4A==
X-Received: by 2002:a05:622a:13c8:b0:478:f00f:4440 with SMTP id d75a77b69052e-4795f34f0f5mr52136721cf.40.1744224818137;
        Wed, 09 Apr 2025 11:53:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964eb988fsm10333751cf.60.2025.04.09.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:37 -0700 (PDT)
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
Subject: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
Date: Wed,  9 Apr 2025 14:49:54 -0400
Message-ID: <20250409185019.238841-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9182; i=paul@paul-moore.com; h=from:subject; bh=RHbnsK02hzjrS8frwf8Vo7FRCVXpRvvKMlPX+QXLt6M=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGfwTR1SK0PvWqEBfx60PrYjUF0cBqKxzDE+ PrI3Nb38tqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBnwAKCRDqIPLalzeJ c/KpD/4hO3JmUeVA6LFf3hLgioz+bafp/oGEWTCboLa61p4Fuoi4G9pPzhOlnPFUNJkd1cWP4lS w7VcFoKiePdVuCB2QAEy/5Vy+s3zEP8SD0ShNZTS+JaRSGeVU8dGuKqEDTbaXnixXxdETFKu33k 8oUZOomO0R4mXf6xMhAmER9hY7LHTQ7HvMhdA1b46TwN3kK0dWfJdgBIS+6/YF+yy41/yh8wpmt +iZTmSuXVh3kzjcQklbKPtMw8MmoxUHYh4KxhmSC8DGpbdW0j6Iy4DxaGMJQaQZ2IhM0D99EOKS tAiN3j0Hyd/0snBkAUXd0XWPlAPT0L9dxw4NE1xPiCtc0dhdWCVi9lZeaKVuAwssgl9u13qufXb oNwW5tVeU3/Wra+DEHKjIlxE+NspE3Vzqt3dGnr5nSMNTBMIFxpQRlenwJ0r4BxEFI2YPEDAfXX mOTcvx0Jz5S12+wPDzUD5mGbBAOkUI+VAQMNqnkUKZii2xQbhT59LgxjkcB24zlF5Lg+52LLJ2p gAAxUeDPZOO15lcDvX83GbIOoMnK428d87kNKrng/Gd7VdfS8VBDRepy317d13SQzSWC3nMOzJW lPZuKMg0qeB+UriRzBht5n3oU6l9K6Yq3/hxxSSNYiXN59P7Zz6nrOuf0bmmUrhgmzYf5oLEtqm 2i3UO8Baupu59gQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |   9 ++--
 security/lsm_init.c | 110 ++++++++++++++++++++++++--------------------
 2 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 49bc3578bd23..f687e22e6809 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -351,18 +351,17 @@ static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 
 	for (i = 0; i < lsm_count; i++)
 		/* the '+ 1' accounts for either a comma or a NUL terminator */
-		len += strlen(lsm_order[i]->id->name) + 1;
+		len += strlen(lsm_idlist[i]->name) + 1;
 
 	str = kmalloc(len, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 	str[0] = '\0';
 
-	i = 0;
-	while (i < lsm_count) {
-		strcat(str, lsm_order[i]->id->name);
-		if (++i < lsm_count)
+	for (i = 0; i < lsm_count; i++) {
+		if (i > 0)
 			strcat(str, ",");
+		strcat(str, lsm_idlist[i]->name);
 	}
 
 	rc = simple_read_from_buffer(buf, count, ppos, str, len);
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 978bb81b58fa..7f2bc8c22ce9 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,6 +10,10 @@
 
 #include "lsm.h"
 
+/* LSM enabled constants. */
+int lsm_enabled_true = 1;
+int lsm_enabled_false = 0;
+
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -72,41 +76,42 @@ static int __init lsm_debug_enable(char *str)
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
 	if (!lsm->enabled)
 		return false;
-
 	return *lsm->enabled;
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -118,25 +123,29 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 	return false;
 }
 
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+/**
+ * lsm_order_append - Append a LSM to the ordered list
+ * @lsm: LSM definition
+ * @src: source of the addition
+ */
+static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
+	/* Skip explicitly disabled LSMs. */
+	if (lsm->enabled && !lsm_is_enabled(lsm)) {
+		if (WARN(lsm_count == MAX_LSM_COUNT,
+			 "%s: out of LSM static calls!?\n", src))
+			return;
+		lsm_enabled_set(lsm, true);
+		lsm_order[lsm_count] = lsm;
+		lsm_idlist[lsm_count++] = lsm->id;
+	}
 
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	lsm_order[last_lsm] = lsm;
-	lsm_idlist[last_lsm++] = lsm->id;
-
-	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
+	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
+		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
 static void __init lsm_set_blob_size(int *need, int *lbs)
@@ -159,17 +168,17 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
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
@@ -200,7 +209,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 /* Initialize a given LSM, if it is enabled. */
 static void __init initialize_lsm(struct lsm_info *lsm)
 {
-	if (is_enabled(lsm)) {
+	if (lsm_is_enabled(lsm)) {
 		int ret;
 
 		init_debug("initializing %s\n", lsm->id->name);
@@ -218,7 +227,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
+			lsm_order_append(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -235,7 +244,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		     major++) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				set_enabled(major, false);
+				lsm_enabled_set(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   lsm_order_legacy, major->id->name);
 			}
@@ -251,7 +260,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
+					lsm_order_append(lsm, origin);
 				found = true;
 			}
 		}
@@ -264,24 +273,24 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				append_ordered_lsm(lsm, "security=");
+				lsm_order_append(lsm, "security=");
 		}
 	}
 
 	/* LSM_ORDER_LAST is always last. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
+			lsm_order_append(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
 			   origin, lsm->id->name);
 	}
@@ -313,13 +322,13 @@ static void __init lsm_init_ordered(void)
 
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
+		if (lsm_is_enabled(early))
 			pr_cont("%s%s",
 				early == __start_early_lsm_info ? "" : ",",
 				early->id->name);
 	}
 	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
+		if (lsm_is_enabled(*lsm))
 			pr_cont("%s%s",
 				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
 	}
@@ -404,8 +413,7 @@ int __init early_security_init(void)
 	struct lsm_info *lsm;
 
 	lsm_early_for_each_raw(lsm) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
+		lsm_enabled_set(lsm, true);
 		lsm_prep_single(lsm);
 		initialize_lsm(lsm);
 	}
@@ -432,7 +440,7 @@ int __init security_init(void)
 	 */
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
+			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.49.0


