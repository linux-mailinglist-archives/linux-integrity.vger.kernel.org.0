Return-Path: <linux-integrity+bounces-7463-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD381BEBA97
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C054950146E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16AF24729A;
	Fri, 17 Oct 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MZNLV0KR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9964233155
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732958; cv=none; b=m6wfnuhFiUkR0igGT2JOf4UNsBXeDk/TBLZKjS5Rv80uIa6vz/gRQ5wAZuJZTWHOTgXbqaYyLyFBTQYAXNNqPLPcm69xkx9y+uZ+ordVmfwgurMUocth7gjQRcFtjniWSyc+ViO5K3/R6b6QlTgeM8XvzvyaUUXG2+U6GBd/bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732958; c=relaxed/simple;
	bh=k+2Vw+AsX73+rR+N15cDbn1NI9YbL72JpcY66WhUB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+wS2ZL8ToVnewfhpD2P6d9Qt8G8AI/cwACP+CsZXmsLxI3HCvNrDTidy1GwANusMKelbSXHwG+lGvyUryZKssM6AXLJhZEEMcH9Q54LJap9xEniOzZQ1xo2KHqclOYMWguCSPjxCamg8rdMT9u5zu866zc6qRTF3X7jR5XzQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MZNLV0KR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88ed6837e2eso495897385a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732956; x=1761337756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UckoStmW0YYr/Brf5WzxJITTd3yRfqRpExzZEzqWyMM=;
        b=MZNLV0KRmiWQ5m9nuFvr8fGPiFoFOnjmmcuIr1veD/H5xpxRYexBFVbL49ssa6zKTG
         DlyzEv3luQwg7nVld/05RYJEqqSaYAop3xvO7d4m63nq8mvu6q3i+7NoMI2+boICu8Ij
         +k4GZVm2hEYFP6dyWdUFCrvwOsh62DImL2lsqR2nyRLR2GOPVgAc3i+q7hxzH4XOLxIv
         Z2yMxQz5VRb7jjupn9o4USDD/6Ay9PtHiCLi0HZHRtL6cYcAbUsVO2OX4vL1eUjb21ep
         nz1GoF1XGWuCKOXlLN3Uw1bE72UlFUc9J5lYo+RLYtyn8ENtvllImnCoxuFZIU/pFj4F
         MrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732956; x=1761337756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UckoStmW0YYr/Brf5WzxJITTd3yRfqRpExzZEzqWyMM=;
        b=e/FescAMwPyHHNAWE0tyFw/R+tu3wg5uOjGFDaqUEJTWp2bExdO80yWYeEUV9pqYSj
         aD955z2brubXXJY1xW4NKQwTD2xVD867iR0nFTwG/tj5zZsWb0GI5peFFsMsoBkTZjCT
         ywfms8g//Np0WflYU6d5ryaG7P3Ih8oM85oEg1kqb0Q+HLoHlsCO/DK6drIfLChbHbdM
         0uiIgFd8oy0M2VgAa0uHaj+EoFOATDvOMJG13riD7SDd87M686UEi5I4N0z0U9V1djPM
         0Y3iecmZbREDpk399Ypu5jMX1CqctQPekzxte5/vxPtEHoN+9xmFY6IfUIJpHbVv7zJR
         SC3w==
X-Forwarded-Encrypted: i=1; AJvYcCVOzq+fsEwI74Ez2NRGxcKifv8WxPW1RjleFdvALVhRmns6k3OpTwtB0Fm5554oI4pVSHGlPxSwph6CpODADhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WfKD2f+VrWqe2wO4znxuSZEWix2D+F091Glf2dQaVdBwCAja
	ryEB59sYKajIlxtIotbtp/ikZCgnEnkzpXQM0BQ10825QTxDOrEZibC4CBsDLyZCjJPBKp/AhsL
	x2opo2w==
X-Gm-Gg: ASbGncvj9rgISIVUxoCbjETArwQuTp1tpS5sKNeCI/y5H+QzZJkHy03+PEK43cKRDkP
	gsh3XVEV6l7+zeFFaHjrtHHVIA8J6R6erPtuCtV6nBxCIhMsiQQrka7cZ9LAIMgYeruc1VNo+fz
	EXiN74lfQ3WxFxeakmkVgymKRP/CWQHLNd2Fif2ILfw8UZhmvPx6B55MSlFpmset2GqyVBGtx6q
	dKTJAJlSlABzeY1lLqAAHGd7rx2vqoLHl/fqn1Hhi2r7Fxm1oteLSRCTHwCab64poOCyu6dNyWs
	vKLH7Qu9ckBsoN2CwuUwj7I3Dn/Bj4bD6ojVMv21u6LM3H204h8B1u/TAwBpFAxC0W/9UWSI4ty
	OXzcqGGiFm1zXDUgBTWwy4f4DGVeuXwPOlFDXWr15tDA/+pt6UR4IleX8Ej9qS+TkhxNP9oqWpc
	RBkEFlwgYT/kVkERrCrqiFt/lVuH3ZhqJmvEfwd3YNZCXhrKoz4bmhi6yZ
X-Google-Smtp-Source: AGHT+IGDfAkI3+t29HWPIPydcXeGCsZIfa0rc6I9oBiPd6kVatmtgLsYu3wQLVWIH/bRDTnncyRRIw==
X-Received: by 2002:a05:620a:a1d9:20b0:891:2447:9da8 with SMTP id af79cd13be357-89124479f64mr429477385a.50.1760732955546;
        Fri, 17 Oct 2025 13:29:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf85541sm5200391cf.13.2025.10.17.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:14 -0700 (PDT)
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
Subject: [PATCH v5 16/34] lsm: cleanup the LSM blob size code
Date: Fri, 17 Oct 2025 16:24:44 -0400
Message-ID: <20251017202456.484010-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5562; i=paul@paul-moore.com; h=from:subject; bh=k+2Vw+AsX73+rR+N15cDbn1NI9YbL72JpcY66WhUB5k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZJUDxf3KpfJ5N2F78hz4gkE85O3uHYkiWTF vXPG+xJGwKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmSQAKCRDqIPLalzeJ c3ZPEADhmSXtyoGty2rKZUXBqnbNS/GVQR6mZwDAri+LKKU2oT9vaqBWdVFRsfWpiQy8ovqkTuU WIDIOYB9kUkCAPWj5PDFOS6NmTM6P3Y5pOfHpMdcU5kCfGL8v4Lgk6hFnlOdEYPPPNphQ9OAOKD igfG+twucFfXUhIH9U4JHN7VSVJje3ZYocEVBiOatL6QAoFqnyYshfFvqXpF0p1Hj4/VtVr4wzI gc7SMJpA85zR1X6AokCjieZlmeuwuLMD+eVytyFOldlm397d07LfaABKJmU11/JSsfO97da4Thl 8LQ2a3C3fVKyJ682FMsqhWnIugffN2zKUejAsrx3cH4yssm0cN3GLkVi6+tEkZLeD2b6ITnb9Qg zFm1FS4dxFTXadQpAeOfEh/zz5b00ivvHrLEd1eaiazKOvgggBZUXHUPgXQzuKYk1/gXZFM/ZOy 8W3OVxSpwEq4258TNKkNNBa/ZPB7ZUUIc1oMVDAImglwOWMdV9AelUaGl6nNDGzeZq665oonLdM RWoRJNg1XC/YnRqcB4iJJbrvQ5Hb21HhXU7zduQmI7mAH516vWEEK55oi61/0MbDdOuKYcZNwmz OCINhB1liH9kQeWd63d8SYAVDUf0n4mNFpOlapCEm2c8Sjo4Tg0Hqg/mdp34MlkA6c9n8CzxviG sAnXw6ArxIsq5Sg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_blob_size fields to unsigned integers as there is no
current need for them to be negative, change "lsm_set_blob_size()" to
"lsm_blob_size_update()" to better reflect reality, and perform some
other minor cleanups to the associated code.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 34 +++++++++++------------
 security/lsm_init.c       | 57 ++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 65a8227bece7..86e457aa8809 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -102,23 +102,23 @@ struct security_hook_list {
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
-	int lbs_cred;
-	int lbs_file;
-	int lbs_ib;
-	int lbs_inode;
-	int lbs_sock;
-	int lbs_superblock;
-	int lbs_ipc;
-	int lbs_key;
-	int lbs_msg_msg;
-	int lbs_perf_event;
-	int lbs_task;
-	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
-	int lbs_tun_dev;
-	int lbs_bdev;
-	int lbs_bpf_map;
-	int lbs_bpf_prog;
-	int lbs_bpf_token;
+	unsigned int lbs_cred;
+	unsigned int lbs_file;
+	unsigned int lbs_ib;
+	unsigned int lbs_inode;
+	unsigned int lbs_sock;
+	unsigned int lbs_superblock;
+	unsigned int lbs_ipc;
+	unsigned int lbs_key;
+	unsigned int lbs_msg_msg;
+	unsigned int lbs_perf_event;
+	unsigned int lbs_task;
+	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
+	unsigned int lbs_tun_dev;
+	unsigned int lbs_bdev;
+	unsigned int lbs_bpf_map;
+	unsigned int lbs_bpf_prog;
+	unsigned int lbs_bpf_token;
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index f0066857bd1a..6b1f8f18a43c 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,16 +169,22 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-static void __init lsm_set_blob_size(int *need, int *lbs)
+/**
+ * lsm_blob_size_update - Update the LSM blob size and offset information
+ * @sz_req: the requested additional blob size
+ * @sz_cur: the existing blob size
+ */
+static void __init lsm_blob_size_update(unsigned int *sz_req,
+					unsigned int *sz_cur)
 {
-	int offset;
+	unsigned int offset;
 
-	if (*need <= 0)
+	if (*sz_req == 0)
 		return;
 
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
+	offset = ALIGN(*sz_cur, sizeof(void *));
+	*sz_cur = offset + *sz_req;
+	*sz_req = offset;
 }
 
 /**
@@ -193,27 +199,30 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		return;
 
 	/* Register the LSM blob sizes. */
-	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	blobs = lsm->blobs;
+	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&blobs->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
-	lsm_set_blob_size(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_set_blob_size(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_set_blob_size(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
+	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_perf_event,
+			     &blob_sizes.lbs_perf_event);
+	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_blob_size_update(&blobs->lbs_superblock,
+			     &blob_sizes.lbs_superblock);
+	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_blob_size_update(&blobs->lbs_xattr_count,
+			     &blob_sizes.lbs_xattr_count);
+	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
 /* Initialize a given LSM, if it is enabled. */
-- 
2.51.1.dirty


