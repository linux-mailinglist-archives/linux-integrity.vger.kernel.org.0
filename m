Return-Path: <linux-integrity+bounces-6663-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0CB0CDBC
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41954188A488
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177424635E;
	Mon, 21 Jul 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R8+JZ9tC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840082459C8
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140245; cv=none; b=EuxkvQAmMBISOt1+a0XEglEhDEpKJyYOKuS7bCtvyqB4spDebWuCrryKqXXJLXfhkqN6CpyTXI2AW3cPU6YX8jEFAKLo1ECCZU+pk9ZTxx3E1pGr9Zbe1MmGhLI6MrYrg6MsidjCNGvMADTR3LGIchC2TdWhZsR1d2GaDsT7nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140245; c=relaxed/simple;
	bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDcPb1UHARN3ERQnutpvkQ1RhRsqtVnbrdf/a+uJsKyO21SRW2dIk0AFBKhphkuBBOOP6i/jvq2/3h99Ctz0Wd/nkZW7NvZgruC5UO2QvEt3VuwIrpc2C5AoDkEaBpniyhhxicFPb3K636lcdEfuGW9fRdbda9QXgSC/5T/l77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R8+JZ9tC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6facacf521eso45062026d6.3
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140242; x=1753745042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=R8+JZ9tCpQ5PtyF4XlFZY0cGuFEGWBKsYDzHDBe5h9bbQYcLl5U4NV5S5CRglpEJTh
         O4N11IzGfHkaBQSYePiXFxr0VyFdxXYsQA8NbhzxPT0k58fMB6BeEI523c03RWY84oh+
         ZvD+ibRg2kzFbGLGkFgCpiaLjac0ExFH976gpb9hRnGtLptsZyZFgtQks1MfOe78e8/M
         vlp/nKE4pm40PT0nnANQ1KFG+x+GrDCZQtfpdCRQ3H8yPzTq0OcLrbnB0uRWGTScZoSy
         xh7nu7a9xXZafhdOAbtazPrY5xkOjohJemqaRYoDF59w5tB1dBz/y3fr9r5/xrqr6KQD
         xhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140242; x=1753745042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=PqY40w0I6DHRi3N35en1EqkuiEWe605rXD8O2cRag3z8QTscu0zOj6oFoFEa6+W4lF
         7DqmMP+Pjg5hkeK9xTwFt2E5k3UpxhG4OeoWo8ld7XhyyTRAkTSW+o7ZD4FWJh4nUB1Y
         5a5bZpr7me+WtzKbqCf5sGrBbc69VlUHhjluHaiPVF3dkrc6IOvsBNWiP40LoI22d8Bk
         j720ujTOhdxWoUXVm4mzJkHa0sHBPW46mwWVImaw02Pm5A7PcRLIXbj0NuChwTh/0u5q
         fqAfxhG6M0duKe3fgKQoVayoqACoW6gzZOBROwbmGeLehvQqjoj/gicAAoZZE0PeP6It
         0CMA==
X-Forwarded-Encrypted: i=1; AJvYcCWB51W+QxMg/1ziNSuWc1x/UULIwJzCFEy1Yxfz8OaskuPRvlTUitbvg3Xhsm9l8GQuyws8sumCMkTf5nlJGcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47c0h3XhMxlIfVAn55KQ7VdVErIOgN0P7sCVUVjzf7e4NIVBv
	c6WQgWqrwkLNtw+3b7VJtSWfFQE5GgmmhEIc/bH+0egY7rA/icHgYkd+cwR8ClwS/wun4yBtqg5
	MJEQ=
X-Gm-Gg: ASbGnct4hfC5fkBeLofR4SKtnFMhYVySYOHU+DOUmca2qcyeza7lnSId03d/atyRjsi
	IuAH3yRMlhWy2aJMhIV58wXr+wxXYPxDatLHqpQbXP1hWhUDcpZsRykmTDc2J3S1FCfry5OvEEc
	VrfhyA8X3lWprVmqRAR9ZK9pkEZ54Ru28M9Adc9Pcje3sSfwYfE5EKYdlhSqHTA2TUK2+hhEpt8
	DZgl3Wn3mAsWwWeG0MhN6NHO40SuyiXzu0vs8RfNRTEsiZGS/+u0nT70FLItkkPtfSGISgz/aOV
	ufz9KTrcIWjnhqtFDaD9a6TSSYAuJQQ9ki6aCKjK0G7UIfAAHn3Qk/OIKG6pSc4ryLOOWL6RpHH
	bsBnX+GLSOYE/xJSJtmokPHF2EEQGxv7UJenTgZkB0KGqRqHI2bmyPBiCAn7Zfwwpznk=
X-Google-Smtp-Source: AGHT+IG040ezfwkH740S6YajZYWPmpi9wI8uXgRxyuNMWS6eUKgzMyr07cwK8w8Hcl+18TnbvenK7A==
X-Received: by 2002:a05:6214:6210:b0:706:dcab:a94d with SMTP id 6a1803df08f44-706dcaba9cdmr54588646d6.51.1753140242451;
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb49a0ab8sm48263971cf.28.2025.07.21.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Mon, 21 Jul 2025 19:21:06 -0400
Message-ID: <20250721232142.77224-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5285; i=paul@paul-moore.com; h=from:subject; bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuUN1OiYz/phHW1CqOrrQTMeI3wlWIXLLOFl SZUTAcY18yJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LlAAKCRDqIPLalzeJ c7UZEADK1oQVGOe0u59nB01nyMZFTfMAw84CF8dD7SzdYZZ3VQRkXZYddjqEvsxFsxiHr3zKe3k Omvy4my+ZYuMtAIBWwwKO8L6CJGJ/UkD7GLHm3GgjFTWrteK5JfyvgkMeKH2mbhai3gEXddPFl5 48anD2L2jcchKhdapgaikeO9DXq34c0FJBMvtRyrlfnIWc/JwmWj7CME7wrVF3cSHDpoY2xVfUv FTqfD53ev7jeBY6KPDIQbowtb9P5tmnVQHjh9oPTv3LUGaCTdWgnicOOuDTqcmJ06RRZ/ePifZk ZaMKkh1l4y1jwaGIVwY31BJPp9jL/r5B7mlRp/wL4DxhmZzqGgrqVfbXysFBuRhaEUgYDHNR4MA 0BHyAtyCsAwCZ0+Uh2i5mkjyZuAnmK5NwQzHzOnR8VhpBIFQQizPq8im+PBBXod/wzNg/geobiJ 6m8MyAWnuQUAqsb3xIKGICMMED2us82/gQ1I6Dr8ibkmF860YyGO31OSJwdfRP6Vy0Kmsom4Vd5 ghK0gW0eWTEf69x0kZMqOmG4TbTlHOXIc7FLALTT4FZqozTZb301JRuuGmJUgayIs5SNZib2cLe gFKx24jljj5491WcLJucN7AAvRMpLoRPFkpHmMKVN0oSX3xFAdjs7McwLPSV2kjlLOkY23oG91Z DAJOUKYuURS3emQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 103 ++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 70e7d4207dae..7beb028a507b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
 static void __init lsm_set_blob_size(int *need, int *lbs)
 {
 	int offset;
@@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
 	*need = offset;
 }
 
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+/**
+ * lsm_prepare - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	if (!needed)
+	struct lsm_blob_sizes *blobs;
+
+	if (!is_enabled(lsm)) {
+		set_enabled(lsm, false);
+		return;
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		set_enabled(lsm, false);
 		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
 	}
+
+	/* Mark the LSM as enabled. */
+	set_enabled(lsm, true);
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+		init_debug("exclusive chosen:   %s\n", lsm->name);
+		exclusive = lsm;
+	}
+
+	/* Register the LSM blob sizes. */
+	blobs = lsm->blobs;
+	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&blobs->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Initialize a given LSM, if it is enabled. */
@@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
+		lsm_prepare(*lsm);
 
 	report_lsm_order();
 
@@ -499,7 +482,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.50.1


