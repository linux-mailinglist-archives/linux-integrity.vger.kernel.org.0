Return-Path: <linux-integrity+bounces-5700-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8412A82F56
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F2119E73AF
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128D27BF8E;
	Wed,  9 Apr 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ttqwv9Hn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD27279330
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224818; cv=none; b=O4i1BfTt7XMYvVUiw5ny5FPEqYanhMHb/RXyLmG61nDX2KdUqiJxBXmEBSRGtOuFNnJdFVq3J8vnM1N323OxNhj2sfzQGg0NvIIZzmDYJMVcuAJ+CRBt/lHUdmmt9+8hsH1W3k5CNN6I0NhyHle0x4K3sak4tnEI/Rzl1GHgq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224818; c=relaxed/simple;
	bh=gpr7tsGitQIMbEcgCwGbviHAdreY0TOHnQ6cCKZK2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF1RxaAKJkp8ILYZmHVJBHkMUJihLCankkaZytfQGRUIdtEv2LaY4sRbO0oLgG7R08FkstDSLF9BCNBy2cEPoXXoTktE6KvXhJS8xetg2X4+kiJj0RAKYIKqZReFS32m6czfHFhxY/7yhY4tDlhajXLpd36OcugC9okzDdEjXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ttqwv9Hn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774193fdffso101582171cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224813; x=1744829613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyW2hd3CPeNluq5Deagk7Gz7AJbC3npegLBwPU6mSOs=;
        b=Ttqwv9HnniNCvdqkCDQW/KwY6vqkqcxNEIlFt65C/BZ63tR1xYfmlta9X+kIOajLji
         337B1zDcDlylm0cNnfhj79GZu1xScHYmz5twUMVpBqgcCFj2UFua3aw96YwSnKRpAAcc
         H4X8OYkZ4wCVQceBVN6dEDP0KRhJBvQwAhYQlW0Fm+F78T5AYdN7lkI2vpwLnfN14TK3
         x/oJJIrufXimYi0ZpNYiYHYvttit1KtelEL5eOtWG3XNnW5fCfi6UOVPT4nvL2apGHfK
         ZaiMMcAcwwNRZHbA6cX3iwoPqQZSCk8QcAZ7zcF8+WNEqWF69wuJbcK4BtNKLgp3O9fP
         wKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224813; x=1744829613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyW2hd3CPeNluq5Deagk7Gz7AJbC3npegLBwPU6mSOs=;
        b=sOO6R6ZhziFFD8cpCjZfBdUuAMTlJrS7ANpXduDXkbsPQizeiWgamv28hZvMJmAsA6
         ur7pwCF5EAalC8pIbSoz84gUv6aYsbF2HsNTTg9tTnZG+AKFiOOLW7QYLxk41hU5wKun
         FgZHXvP55G82k9y4w9Tn1Dx89AWyfpRFdbOULhlsQS2sttzAN1zXeZd5ximSlLpmT+KU
         RUoBjlLXEubPKBs9GchYQGALXLg7vIndFECcAHifzqKxhIXN8oFyXNqNpgSzIgTobmk7
         WVdQb+aJXej+reZ0YZxSBomdfh63d91LnIbkasYRgA+fdsxPT9huUBZ9U6e3cXcvrpzr
         oC/w==
X-Forwarded-Encrypted: i=1; AJvYcCWwAoWp7/xsc52f397h4jgZgqpxc/1U++w1MJZ/DmEijPuCSOQjPz0KB4ADOYNk60mgblE+HEhAXSio/Zn98QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5p7f3bJGI5BZKZvpXg4Bm+SpjoX6Jz+bvZlCFpDUMY+lYPVY
	SPpsVD3B6i09PYARE+UerdBQn/PIlgvZGfkwsMNLOWHcKbdaDEDR2EOuPz+thA==
X-Gm-Gg: ASbGnctXySyI/5DNB1aMaZfp61ZHhMAZuGOBGc21YxH5IjWFi3oeoWmhyNVK5pg1ptm
	w+NylY5sHHUyZgC53rfyE1SLu4EXnd1ga4WVaKOwbA+dbJpwF58ozGs7AHGPspFl+fkfm4jIn7U
	WdShmrP0I+JwMUO/r10KzSDxmGzVzmTHSL3RWIyzha7FnQmk8CMOvohrAehl3v6ngYrvje+1LZk
	JyNJ3irV7T6nfqojIpXS5H5UOIaNJxrYP9QpKnUmLHYXesvWsJmajqy+O8eEe/v/BBaHUp57E0K
	hDRXatA4MQZtfX39FJlibnbQfY7g0hJfmax481ZF0oy2HJDlyJ+XeS86mALlkvSOq69EeA8zm62
	lO6P2P3xWSQ==
X-Google-Smtp-Source: AGHT+IElE6XZTnvc8PwrZp+Tvpsb+oUBi9puAZOOHhxs0inLj4RSOmzkhtSEd80tUBKIzcruBlRftA==
X-Received: by 2002:a05:622a:1115:b0:476:6b20:2cef with SMTP id d75a77b69052e-47960134f73mr58523681cf.41.1744224813280;
        Wed, 09 Apr 2025 11:53:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ec504asm10336751cf.62.2025.04.09.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:32 -0700 (PDT)
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
Subject: [RFC PATCH 04/29] lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
Date: Wed,  9 Apr 2025 14:49:49 -0400
Message-ID: <20250409185019.238841-35-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5284; i=paul@paul-moore.com; h=from:subject; bh=gpr7tsGitQIMbEcgCwGbviHAdreY0TOHnQ6cCKZK2UY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGBx4wuIYQqbtw+d/oiQz36dPSuSfB0GAmp4 QzeVymGZF+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBgQAKCRDqIPLalzeJ c8YTD/45zC/x50mbnS+rmFfYNWP9G7OQcwdN2nOZ7WlXXy/epOxNYO9oqUAgfdTzFclLzS6Cx+q JexaE0/dKwgqBmq2/vsiE3r/sVjTKUrVSi2mvqjV51Geb0hAuDMqWaK7eKvfgtNSesynf5tTqT/ lPk4H7BQUeSa97Fkz/Re2+QYIlwCZJkv31vSfm3+qPCk+OerKWhY8VZu51pBC3CLtgNfxyNSljc g3VsZvrWiU/P3TRj41DhNh/VUgqiKVhg1exx4JwxUBmbLRZbgYhaUqW0LHu/WgXW457mPO3udHR jVSiSfQlYR9vvXVhQW2GsXrWG9p6rRCtBrab6nLdRYB0gcWo6WOG4j2ARZ0tq+iu2EUDn0dMZwm mcoV/4DlyCQGlmXSskfG61bAiexiAZk/B4omodClDjdvIKpTOpl5chS2QxM5hbtPnh0sNsYgY0S wMRjIw2dp1yCDaxBAzHHNrAaCbX4GsKPoshHc9bVzaQS4kWd18EblGK+xlDd+rHYOZklSWgeRT5 miwOSwpsajR0EUTPZge4ZD10xkpSK3YhI/lTH8ctR3cKBhcB7p0CdCl7RSivVwDRYyE1iVaibCl RhAe83ZgFLjc4DBqaXDAHX00Y1WEnIyA9PIr1B81EJF9wzWLKrQpe6cM8eFitRA21hLUmGEETFX oAqDnf61MsjtA3w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 94 +++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 58 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index dffa8dc2da36..407429688f1b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -32,6 +32,12 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);				\
 	} while (0)
 
+#define lsm_order_for_each(iter)					\
+	for ((iter) = ordered_lsms; *(iter); (iter)++)
+#define lsm_early_for_each_raw(iter)					\
+	for ((iter) = __start_early_lsm_info;				\
+	     (iter) < __end_early_lsm_info; (iter)++)
+
 static int lsm_append(const char *new, char **result);
 
 /* Save user chosen LSM */
@@ -96,9 +102,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
-	for (check = ordered_lsms; *check; check++)
+	lsm_order_for_each(check) {
 		if (*check == lsm)
 			return true;
+	}
 
 	return false;
 }
@@ -279,56 +286,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-
-	pr_cont("\n");
-}
-
 /**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
+ * lsm_init_ordered - Initialize the ordered LSMs
  */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
-static void __init ordered_lsm_init(void)
+static void __init lsm_init_ordered(void)
 {
 	struct lsm_info **lsm;
+	struct lsm_info *early;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
@@ -340,10 +304,23 @@ static void __init ordered_lsm_init(void)
 	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		lsm_prep_single(*lsm);
+	}
 
-	report_lsm_order();
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (is_enabled(early))
+			pr_cont("%s%s",
+				early == __start_early_lsm_info ? "" : ",",
+				early->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (is_enabled(*lsm))
+			pr_cont("%s%s",
+				lsm == ordered_lsms ? "" : ",", (*lsm)->name);
+	}
+	pr_cont("\n");
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
@@ -362,9 +339,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -374,10 +348,14 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
+	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
+	}
 }
 
 static bool match_last_lsm(const char *list, const char *lsm)
@@ -479,7 +457,7 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
 		lsm_prep_single(lsm);
@@ -506,7 +484,7 @@ int __init security_init(void)
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
@@ -514,7 +492,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.49.0


