Return-Path: <linux-integrity+bounces-7120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC5B7D32A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA44C1BC479A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77254323F71;
	Tue, 16 Sep 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I0VWva9X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4991305051
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060848; cv=none; b=ALDIA2QJBUtgDGhjs4D7R+M6RrEi0WCRxEx3zLdM9KHgh9mwn5fUVHB90Jw4UVU4OqxEW/ba6IuOe6sBJnxf+boomQmabBGrY6qYJIJpmq3FMis9BnPVO0zFyQttAJpi1TPO8lRp325ZhNC7a9yFFlXnhHpd5aF12X77h7Eun/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060848; c=relaxed/simple;
	bh=+OK/m5TPCbu5ekPzQ3TVu/jETD+ayC/0+g+lnRt3uPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe02QUpNvP+SBLy34BlXSiwTruFra8vFIAifMztnkqt9DXrsRsw1y0CWRasVWBfA625/uJQ2Z6covH8eDFj8mtiTWeqNGQrqt8z3nJnx/U6fYCrOk8Dqkw0KH6q1JYnPlHNYXr/XvEIRn2pYGp4VEkZF4EEgnXUeOp4pkCfUCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I0VWva9X; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b34a3a6f64so51845631cf.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060845; x=1758665645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPqm287CtBAF6u4MXa6W8BGeE5UYl4YvLckFSCAezAw=;
        b=I0VWva9XUSvjZhCrv3r9RdMSNpwWd7D9p7o8r4slAwxVDxpQFknVhjlWk9aUJDzung
         x5bMYIGhuQeKcAD4/Qn/ZNhT2VDpPVdL6xovWXiHV7krYNoZksLfjCaa8SmHml4758Be
         3vZa7zGtTiETrEDWlI5A/7eT3F87Cgi4G95aT2ozTPWBUO9ZVw95oA4pf7YzD5PgJG2k
         aTQB873u3gTYl6eY3AYd1od9z4oIal2axFHqvB4Yl8Ky+GozPbDRmSy5cgjSdhUnjXS/
         NghMmVoISw8LG/8uBnhx6K5VqcyxxT7EwOX5/NW9V2/Orn8hr9+f2RxKmo4Xy3LUC3q4
         54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060845; x=1758665645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPqm287CtBAF6u4MXa6W8BGeE5UYl4YvLckFSCAezAw=;
        b=tI0npRksF//kTf28dkx0l2zKxvddQiUThOizjSZoRgU2ps0YR2MxKuf86oovSzFm24
         Ibz8rDa449XDG8McBjHpTroB5pGxQsqfwXX824LDZdaubhXng3TBUC++Po4we7OcAWLG
         yvKLLA3vzlkK1RBubwYMO/45WC1ot2GM8j9TAFKSryO15hKIf9TSANtJa1Dyv1aGYP7b
         tgRgF+dO2r203YEf2qqvpGSlLTW99nD1mQGLaNoupwAF4e+9uQo7+6+hLzcNwkZ8a6oT
         Lp9VqD5seJSkF5OOYq8eKr1jprtV7efPe/JMetGUG8KyaY78F/Q3QUzf6hoP0kIDYR85
         f3ww==
X-Forwarded-Encrypted: i=1; AJvYcCVywa6SvYcgw4J/5pS0bQaypC8PU49y6g9LEZGBYOpa0F3kgEYKJl6Iq2i+FJmIc7Bcx57rxBOQmB9KBfT/ei0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbp7xp5+LCS6lKR0Vgtxc4QWGX21aDgHOoFsE/x0PKVRdU8aQ
	D5/9oU3Z/skLJr8gcaRgQdMb9ccuVAiUqC/CS5SvE3IQjCD5YXBCcOP9LH9pqeKQ8EUnRhngvz/
	qzbs=
X-Gm-Gg: ASbGncsIRheuUwOfzrsoe3eC78vjNXPALchZLgXVI30I/IBleRUpKtbOGX9JsbUoLUV
	uHXdzcgFqqBxkxRxwQWO99tfE+rk92yQwY/a1dnj8ZqgTU134KNpziizexaMsrCDt639rFTK2x/
	yxJD1fRboiFTAPDeutbCsB3YkkXS18RW2tUn/1DPbOnAAHZmiJ5P3Drf5dvvgbW/RF0cEduWY7J
	jmwdeK68Brkz6SQC8JrQTSehpNrCSx3jb8rsJvg1hmd+VXDtivZRW8LwEi011yywGP8SCQ318Ua
	8LjSMZbCWn/8bADoIZX+UWEmrLpsPqXd/qg0+Sw6AI2YXNg5LUop/6/MWwJZrnM7SFS3zfAZl2X
	5TGwkChkmVBwbMGhcQcf7F0NbEC+tJL+OxGQL0clc1GQiH7X+SRKOL4/wMG7VP0qZLmcD
X-Google-Smtp-Source: AGHT+IGjHQn+Vi1vhN3dnJr2P/icLtIvvASk/j4CcRUitwsQ0ckpG1aVrK+0oq4hv2hCUNPefhqTXA==
X-Received: by 2002:ac8:7d4f:0:b0:4b5:e94b:dc59 with SMTP id d75a77b69052e-4ba6a201d9fmr958291cf.46.1758060845583;
        Tue, 16 Sep 2025 15:14:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639cb584asm86888411cf.20.2025.09.16.15.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:03 -0700 (PDT)
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
Subject: [PATCH v4 16/34] lsm: cleanup the LSM blob size code
Date: Tue, 16 Sep 2025 18:03:43 -0400
Message-ID: <20250916220355.252592-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=paul@paul-moore.com; h=from:subject; bh=+OK/m5TPCbu5ekPzQ3TVu/jETD+ayC/0+g+lnRt3uPI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd792H+viH71eUp+zbBvQQjRy+veAnySYWt6i DM/1XEOYGaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne/QAKCRDqIPLalzeJ cwn1D/9mc75+O2T5c6s7H05LJSYqKKd8Bd+vaNC6XOdU5JPY8gU0LdLXVbHUsseevRXDjAykJGD tFZTs3A4cagecybTQMEm2eAAbILZk8NWOpqpIvuVSjqN52Oe/EtCV1s/YrENk+sXpKGkoHpOyNt fk8d4X3I7D3wrbW4kJcqRZfKdHC/UruGQIgJazKP83lRHwYkw/sVWyIgIV1qZYuYfd8keneW4/7 +ZM8qwOdrZvB6nfLzS63xc+/6WNon+rDSE/VLCJ/XkreqOcKkXzplikC9t+aDVaI+iBU/8NvpBe pHV/VTjhw7nFvN8R7HHOkYEnG+c4TCX+crDBN5IKrE5pd1qv6a+cNmQlKG7Kh8BSUpp3w67Jf5J Mss5RjwQAM/KBiyqw6t74L9NOuIxYz97QssbfU1ZBiYSsWC4hLs33xSaXE1xrrxMIX4ma9qq2dv aGiWzKW51PPqRpQGjCk4VIjtv72akR2Ug/f3fKHaX00OT3grRdzC8DEcqA70OyzRFhamvJPGM37 nUQWnzzynpLj9LtmL32FNHKCooUkT+D64dSa0eaYJMJ+ISM6jrLnJwvJy5f/Op/ahmlie1BRDL4 qf3gLji42hbl2D+pWWxu6zKzCuUXb5t5OSur3j+/Kh90cGbhCzNL38BZhzwSBLsnR093F2HE6Yc ICcjYZSAJSUTCzQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_blob_size fields to unsigned integers as there is no
current need for them to be negative, change "lsm_set_blob_size()" to
"lsm_blob_size_update()" to better reflect reality, and perform some
other minor cleanups to the associated code.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
index 7b2491120fc8..5249aa044d9d 100644
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
2.51.0


