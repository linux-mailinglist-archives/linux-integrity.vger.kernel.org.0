Return-Path: <linux-integrity+bounces-6679-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF1B0CDE1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8923317C5A8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A71324678E;
	Mon, 21 Jul 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YwSABn0V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EE24DD0E
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140261; cv=none; b=lh/MCB3RtGogXq35l39Ww+GLsWgUVvszoFNwZ/sbB2q0zQWrrW2H4VVCNSgI6QfFtKEHlJPku94GMtJeianXLInm1n4BDkwggs4PrgKxlNp1UW1hqjQYRDj/mlmEYWQcTDrjvzx7LioAKfePweT/yfUT3vbRR3ltUjknIxBVEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140261; c=relaxed/simple;
	bh=6ENpyD2J+OSJ1E+5ZEde+VJp61EZMPHhg6gvWP8dBrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkVcUHJ/0PZQ7Alm4sPGFV4CTBTtQ16nfluHNypeQvXYITkMbP8fWJFgcAd9LpvITVsSCcOlnnWL9dWd0n872mBPwpQImI3XhxokJnlPt3ydESnfgN+cpCumUyb5EG0hSPeiNhMAndYTzsQSRfOmL+D4rek4UUVrgBFnJ2LeLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YwSABn0V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso64249216d6.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140259; x=1753745059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPybX/CH4Dd4y72nKpVRXxuOeQzwsOaiLy9rOqPeagA=;
        b=YwSABn0VrbP+7eIJtG/hFlu8h8DFH09u13Jw4iVeIQPtNRbl62QfgeLZ9i4fDcKZLy
         dhiuuJGRLBepf1Q6HAwKvS796Q8nTu1PjnCTqtKYCSNdKmdPgrh09FoVz2mm81+kxqj6
         3A6YEy6Av/jk3/nNDJF1/k2rLI7YC5hTX+siG2pimylco5ofK6dnhIl5052/LV/7kLZM
         URPfiZC/cHs8Yujsp2PV24f1sOhKTo3MYYnx7HmayeviwRDQE6hFOy8iNLZJTU8+gCQL
         q9mODd0R4P+dKFQnuqzPANiXwgEQ6nOopbmBHmhc7CmI0xIBshrTH3Bjyqmuo6pRSus3
         Q4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140259; x=1753745059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPybX/CH4Dd4y72nKpVRXxuOeQzwsOaiLy9rOqPeagA=;
        b=sPxYhN5WzdtXyn9lWp9fW7J4pI6yRmNfLy0eY2ifXvharDzwAqtT6gY74ADnq3ejgG
         u8mTDCaZlaRIRe8a7Q6pV9PbeNnk3jL3NoIxUvBlj9LKibCXBD0YgEigY0SY3F4bao0y
         4n3TXtxhMWvf+aWmGmTeG7kVMY9MoZwp2PMJM6DQNcLtNIATaEauty/qDguPJ1WSybpH
         MIHL7HmzFxCjstV4nwUbBH7O3501OXrWT78BopDjFDMQEQ+K//sfmLB/BRgwbe3+BrYX
         DrA/B3orZLxiqvurDNQEBis+zMqAKDwIbAj5lYLT7DzBSftlPVSgxqm5vDBYMVx2Hjo6
         4fJg==
X-Forwarded-Encrypted: i=1; AJvYcCWpbMST+N3yKmySC+QtlQCiKNsL4gKEurpsXv6y0Jgk/OcZKDd+f/7l9jCctw2gH+M6svBC+99YnDuRCrZZLLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXSmdHYRWmOt+5Gav3kYyqZEeZYyF6fLQLNM/nspTVzrOuTRe
	83HYEIwWRdRonIHbdh60tC6cp/6GZa4eEtLeHhsSZHzmore6XZRB5XTYSWSDiEZDXQ==
X-Gm-Gg: ASbGncu1pUVzzFZPi+UWGfKKRaz6YY++J0k0FfAXfs4AKEj3MI6yWxfGvH5725LYu46
	9QhUDV5YaC4x2PhcRBd79I89aQLhO8f9tYtKnWIGsZz2O9Q+sw4/Mt15S0dsVk1zZMmNnYsOHwh
	Tz0y+X+cWrKDmRvOITLQNmCjxof+EhoVV/UBSRHLcx4ANuu+w7LF6J8uSDM9ZcObxKuqD+9MJgw
	tcNcZu1S+c14+hCO1XbSJa/F2raFav84jf/uhulkYLWK7ptHCSN0Ochu8aWFx/7uh9kz831+u0a
	MdEo1ZCoZWBGrmgUAyDdKawfeK+jJWMsk87aWz5MZvZ6Ce21ifoWgrGBwHjnO296qnHwUKhevQB
	p47Lid7RgHzglZV6Gyo6bOOEbVF9W13Ggtri0Ustiv6RufXy9MWv3VIcYTgBLEr99A0A=
X-Google-Smtp-Source: AGHT+IGNYz7dzeLtI3P5IN3De0+876etDTavW3rmSJhisfkpRcwjcmU7bSRvY0yyMSjuYzXJ+yImbg==
X-Received: by 2002:a05:6214:c63:b0:6fa:fc4b:8ea7 with SMTP id 6a1803df08f44-706eb9484d1mr21936826d6.21.1753140258689;
        Mon, 21 Jul 2025 16:24:18 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8e1880sm44265276d6.29.2025.07.21.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/34] lsm: fold lsm_init_ordered() into security_init()
Date: Mon, 21 Jul 2025 19:21:21 -0400
Message-ID: <20250721232142.77224-54-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7534; i=paul@paul-moore.com; h=from:subject; bh=6ENpyD2J+OSJ1E+5ZEde+VJp61EZMPHhg6gvWP8dBrI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvI5Ppnr5jlbAevOsU9LIKkgsx8zlyZpoE6/ qnR6MIjpnaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LyAAKCRDqIPLalzeJ cxJ6D/93RMrxqxtHmvbuFe2AGZN74EH85ofYU7WbeDrlEULJK8/uCH+oHsitn+nPXmB+dvJ+c6r SdN8JFPi2AzZukPLdX3C6YvT2ssLQ3uVYPGqSwgWvIUDV/7KXQivIcrM1ffgdkejcbysYakH47F zI3FO98Ib+3uV3uQVZplLF7dkJ04uyxpFz1fk3j0//0G7KIIB/yo8QeC4pJQ9GDUPS6/qk9mO2y yOP7ZW6F5ovzQ62izz7EWPMYh9HCdBgW76CkZqJQ6iQAaK5h1GOUhknJrRLIcov25WiKKTRW9Yp CxFt620K83H/KvNpP0O6eEfVc3Y0zrZMhEFOqOmM2aaeOp4Q4KdCheyavgGkq5UZT4LnxO0XbXd JidCQxuYZR31EL5zgx82M06u7amhekeMa65anJmJbWytXwLE0O5Uvk8m5mX+30mHViSjHUN0ZEQ NTgCSsRK9PX1xkJtWt4oG+e7kSVSLKsPX1oW/d0nDd3eXNVwOJ7HSmyGzmsyOd0WaSwFevwOyvp 1eE8mOV1A/LrFEnNSnnzCe/E9T83svP5rBVHKJ0ZYQDfk8uH3B+uaO9v2agGgYXmNtVxEYvmf8D eG1/dQ2GK9X4bRxj9jWDiHv1XkSvY1fcKEuOwqxBLDRmh81zpXIdhvOebX1WAELgjjhYflUYez0 7K9oQHgzFwqvg3g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only security_init() calling lsm_init_ordered, it makes little
sense to keep lsm_init_ordered() as a standalone function.  Fold
lsm_init_ordered() into security_init().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 157 ++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 85 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 49f93383e551..25fe0c89e884 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -18,6 +18,9 @@ static __initdata int lsm_enabled_false = 0;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
+/* Number of "early" LSMs */
+static __initdata unsigned int lsm_count_early;
+
 /* Build and boot-time LSM ordering. */
 static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
 static __initdata const char *lsm_order_cmdline;
@@ -169,7 +172,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -310,78 +312,6 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
-/**
- * lsm_init_ordered - Initialize the ordered LSMs
- */
-static void __init lsm_init_ordered(void)
-{
-	unsigned int first = 0;
-	struct lsm_info **lsm;
-	struct lsm_info *early;
-
-	if (lsm_order_cmdline) {
-		if (lsm_order_legacy) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				lsm_order_legacy, lsm_order_cmdline);
-			lsm_order_legacy = NULL;
-		}
-		lsm_order_parse(lsm_order_cmdline, "cmdline");
-	} else
-		lsm_order_parse(lsm_order_builtin, "builtin");
-
-	lsm_order_for_each(lsm) {
-		lsm_prepare(*lsm);
-	}
-
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", early->id->name);
-	}
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
-
-	if (blob_sizes.lbs_file)
-		lsm_file_cache = kmem_cache_create("lsm_file_cache",
-						   blob_sizes.lbs_file, 0,
-						   SLAB_PANIC, NULL);
-	if (blob_sizes.lbs_inode)
-		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
-						    blob_sizes.lbs_inode, 0,
-						    SLAB_PANIC, NULL);
-
-	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
-	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
-
-	lsm_order_for_each(lsm) {
-		lsm_init_single(*lsm);
-	}
-}
-
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -429,35 +359,92 @@ int __init early_security_init(void)
 		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
 		lsm_init_single(lsm);
+		lsm_count_early++;
 	}
 
 	return 0;
 }
 
 /**
- * security_init - initializes the security framework
+ * security_init - Initializes the LSM framework
  *
  * This should be called early in the kernel initialization sequence.
  */
 int __init security_init(void)
 {
-	struct lsm_info *lsm;
+	unsigned int cnt;
+	struct lsm_info **lsm;
+	struct lsm_info *early;
+	unsigned int first = 0;
 
 	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
 	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
 	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
-	/*
-	 * Append the names of the early LSM modules now that kmalloc() is
-	 * available
-	 */
-	lsm_early_for_each_raw(lsm) {
-		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
-	}
+	if (lsm_order_cmdline) {
+		if (lsm_order_legacy) {
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				lsm_order_legacy, lsm_order_cmdline);
+			lsm_order_legacy = NULL;
+		}
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
+	} else
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
-	/* Load LSMs in specified order. */
-	lsm_init_ordered();
+	lsm_order_for_each(lsm)
+		lsm_prepare(*lsm);
+
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (lsm_is_enabled(early))
+			pr_cont("%s%s",
+				first++ == 0 ? "" : ",", early->id->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (lsm_is_enabled(*lsm))
+			pr_cont("%s%s",
+				first++ == 0 ? "" : ",", (*lsm)->id->name);
+	}
+	pr_cont("\n");
+
+	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
+	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
+	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
+	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
+	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
+	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_inode)
+		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
+						    blob_sizes.lbs_inode, 0,
+						    SLAB_PANIC, NULL);
+
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
+	cnt = 0;
+	lsm_order_for_each(lsm) {
+		/* skip the "early" LSMs as they have already been setup */
+		if (cnt++ < lsm_count_early)
+			continue;
+		lsm_init_single(*lsm);
+	}
 
 	return 0;
 }
-- 
2.50.1


