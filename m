Return-Path: <linux-integrity+bounces-7125-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA8B7D511
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E177B7AE432
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BC22BEC4E;
	Tue, 16 Sep 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bd/mz3gV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D13294EE
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060855; cv=none; b=GEGCRkQnKW39fjb9l3KobVtZkVh4C/yxZtrLy8SRB69HTNxBuOyj1RlUjzSpdY7SCwEP6xnIa/oBlVEO0HutTyfC20HwXhzgcNn1EptbevtXE9wDSIYnIjCU6C3oadIvlqGzU8CctCeFxzuyshKoYlWcrPEjLM/Ri7e2ff/z87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060855; c=relaxed/simple;
	bh=fFICmvkqK0RAossP8LI6CTiyrZgYRRbzxG5KNCWSzJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6gYWgPZBapHCcN2LGEQwkV9vsTPQFZwYUwa/I9H21Ra4dGHiGRbwE6mKv5Ee3irl8WIfUO5eDZ+8zZG/yij+zFvXK5mMrxEvxar3d4i6MFz3X89FHqoj0QWvHongxPUVfqq3f6qfZpWyecGAGhDCziNC45WRzj0+E2QVe9raRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bd/mz3gV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-77d253914d0so23477486d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060853; x=1758665653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc1v2vXM3oe4nWHKCymPStGywoPd5ZfS4qSaevt+3bc=;
        b=bd/mz3gVsZ3A8xGmxA/vFLh8DDHMQk5oHBAbXlTyZUWBkAcq95TC19a5RcxSoJKvOr
         zC9fLEF7/C+j6rilxzPC1oacyDZ0+/i7LrazZZkGSd17YtiHYOgkQCXd8qeBPatHbxAx
         cZVehbhxUyG7DbMzq0YxFlLiTwobl41P1IrvgaJq1Xrs04/lAoPJhwj0Hatr+iFJ6zy4
         EcjzKYAe5JdPwld3lFk2vEpn8N29TAGjAWqosI2j+At9ej3ZIyfUX2fpaY/UoKuCyDqP
         wGh2i84geny2LY4w49i9PGXVLiM898ASvlJvd+hrLZxObktJHdAa+cQKMWY3JHkjlCdZ
         vV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060853; x=1758665653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc1v2vXM3oe4nWHKCymPStGywoPd5ZfS4qSaevt+3bc=;
        b=vhIWUmi19sxBN6bWwLHqbGL6WJDPw+b2aVbT/GhIiihLVvEIl72QTUo6GYkT4lzWSL
         7ztOG3s15H+x3XiKPk0ow1zx43X7f/DhcPDUfRUY0T4SZhKu4vbZbNqPHr4g+orUP0pf
         1X6IqzaIf9630t4rhc1aCk3p0ADOLEVT+pcu216NnBtcXcuSEqTqVqxta3HuL3Tbz0v9
         xYl5F34dr4hvq/zlY58ut1zE2UnFYv6OHdgWx/jQCzJn2k0bpM6RVhU9aME3cXdmrEnF
         PbLebBF/9F00tvRF3DUGtDyG3fK47VwOaMEbLQTKtqYnJ7KuQQwXqztkmVEzLwfnlCz2
         HkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZF0I9dpBXzdW8svs6bitt6/AweLv439+N9sF81f9hPHmB1N2ChtOCbqS7fT2K7PtnyxvugpRlYbwNZkXktFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbQEUQCD/jGASaInRXqc9Tc6b8FRRix7Lf6FBJmPgtn8UuqXe
	nWn+PTklHst6ZHZUATtiO+u/d8lcsh81PybMGwNm1pAU9UK5Canu5d7XdETtczadvg==
X-Gm-Gg: ASbGncskIfGnDOLofSxMrYK6aHB2fpfGXytHSMnY1SeI0WJhiALJP8SlxnkpA16HB/y
	UVXOgCqLAqNSinHzKsH/pXts1CtlKFMxjnZjVLePb3LMus2uwRKVOsboZzMzzspcAU/Kgb8JuOD
	SZJpLw1aXa4FPuCl1XCDW76BjIeBN3U4qUvfiajaxcDlXptrijCkJAsUm/1TkmN8c06hakT51VW
	fWT8qLJxSz3KcUvP2kV/hSQjRJt4K+g50mcq19DepdrCDYxVKR39q0oyYd3z7uX5LLcbNRjPPtI
	at/QUo8b1Q0y2+ihiCLnbNYkWK97Jg8Y1RXGtyvW7Wo9pYi3RkzvhhXYQr0fsj2ovRo1D3K5Kzw
	LlcCGaLL0w61ju19c7tHPtM9KVWA60VaLCIRXeYK3/5thU5184pr9wqXqpfA9R9QnBtER
X-Google-Smtp-Source: AGHT+IFK+0VWf+ZKK0MMaIo+KPo8/on55ihdwoMXj5JNoJ0rui/YxohIQZhwn7RG+VeFpRt4AuHlEw==
X-Received: by 2002:ad4:5c88:0:b0:78d:8414:e4c2 with SMTP id 6a1803df08f44-78d8414e5f9mr42802816d6.50.1758060852573;
        Tue, 16 Sep 2025 15:14:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78893a58c31sm33347936d6.32.2025.09.16.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:11 -0700 (PDT)
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
Subject: [PATCH v4 20/34] lsm: cleanup the debug and console output in lsm_init.c
Date: Tue, 16 Sep 2025 18:03:47 -0400
Message-ID: <20250916220355.252592-56-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10383; i=paul@paul-moore.com; h=from:subject; bh=fFICmvkqK0RAossP8LI6CTiyrZgYRRbzxG5KNCWSzJQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8KTNt+aWN5sjz7fjN18qCzVMtIdwozORF3w 1v8S12W+eqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfCgAKCRDqIPLalzeJ c20wEADTOv9RdP5BL8GrKYC4UnAp5hXhREfHzKxBzFA6x7qYzHrrYTfSHEnwmK8ptrIbWNIY9WT E2RFCA+shTnbm0UxLHZGsfm6U5uG27Wr+e8QvK9VsOlntnwJaiRaz0Jeob74364vLOJUTw1iFQo ATEE6Sej1YvY0yxmO8T/atTLn99hCgxBWbq/z1mSAdUoiP7S8UTIvdjJ0+nB4CCcJZ/4cNa5GKm hA9Jn6EaDwp01ZwZpGU/FIgSJMoTcMvclJ/j/ljOngz6QDH2Q31s+o6FyxyXdh1Xktfjr1VT9Pv JQzhd7vYuZMSJ2TdIUoRgAn5/cDuUrCNNqhFzqOFaia7HLcY/2Jy5MRzJQqgUDtkZL6t2mTsPAo dlFPLkRrKdy5KsIcajPnQiFhe68yxIZw4de2xuIg/onvGwVfBTFEOKeXRlhMGP8spd7asKFMhCD G2waafqEE8/pko6WJe1SrMosUt1xXeIha+Z0asqNvu7MUp7WyufCeA+ZMWhE4kb17oF0rypNuNS 6798Iu/yYRQKNZ3V4phsXV7W+XOtUjJrTMROq5A8oXefoX/C34jBF2ggY0xN41EEhm84yU7Quy4 YQYjfTVMFS5j/tJK8TY9CF4s7Ygs07uMOMfvOUOW68HiW9dVWu3rcBJgqEQF0yoh4Pak9gJczaq lYDHgTxjJBo8mZw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move away from an init specific init_debug() macro to a more general
lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
both before and after init.  In the process we do a number of minor
changes to improve the LSM initialization output and cleanup the code
somewhat.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm.h      |  11 ++++
 security/lsm_init.c | 123 +++++++++++++++++++-------------------------
 security/security.c |   2 +
 3 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index dbe755c45e57..8dc267977ae0 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -6,9 +6,20 @@
 #ifndef _LSM_H_
 #define _LSM_H_
 
+#include <linux/printk.h>
 #include <linux/lsm_hooks.h>
 #include <linux/lsm_count.h>
 
+/* LSM debugging */
+extern bool lsm_debug;
+#define lsm_pr(...)		pr_info(__VA_ARGS__)
+#define lsm_pr_cont(...)	pr_cont(__VA_ARGS__)
+#define lsm_pr_dbg(...)							\
+	do {								\
+		if (lsm_debug)						\
+			pr_info(__VA_ARGS__);				\
+	} while (0)
+
 /* List of configured LSMs */
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 37593805ba9e..2f7ae26fca0f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
 static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *lsm_exclusive;
 
-static __initdata bool debug;
-#define init_debug(...)							\
-	do {								\
-		if (debug)						\
-			pr_info(__VA_ARGS__);				\
-	} while (0)
-
 #define lsm_order_for_each(iter)					\
 	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_for_each_raw(iter)						\
@@ -77,7 +70,7 @@ __setup("lsm=", lsm_choose_lsm);
  */
 static int __init lsm_debug_enable(char *str)
 {
-	debug = true;
+	lsm_debug = true;
 	return 1;
 }
 __setup("lsm.debug", lsm_debug_enable);
@@ -143,22 +136,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 
 	/* Skip explicitly disabled LSMs. */
-	if (lsm->enabled && !lsm_is_enabled(lsm))
-		goto out;
+	if (lsm->enabled && !lsm_is_enabled(lsm)) {
+		lsm_pr_dbg("skip previously disabled LSM %s:%s\n",
+			   src, lsm->id->name);
+		return;
+	}
 
-	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
-		 "%s: out of LSM static calls!?\n", src)) {
+	if (lsm_active_cnt == MAX_LSM_COUNT) {
+		pr_warn("exceeded maximum LSM count on %s:%s\n",
+			src, lsm->id->name);
 		lsm_enabled_set(lsm, false);
-		goto out;
+		return;
 	}
 
 	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
 		if (lsm_exclusive) {
-			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
+				   src, lsm->id->name);
 			lsm_enabled_set(lsm, false);
-			goto out;
+			return;
 		} else {
-			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_pr_dbg("select exclusive LSM %s:%s\n",
+				   src, lsm->id->name);
 			lsm_exclusive = lsm;
 		}
 	}
@@ -167,9 +166,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_active_cnt] = lsm;
 	lsm_idlist[lsm_active_cnt++] = lsm->id;
 
-out:
-	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
-		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
+	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
 /**
@@ -239,7 +236,7 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	if (!lsm_is_enabled(lsm))
 		return;
 
-	init_debug("initializing %s\n", lsm->id->name);
+	lsm_pr_dbg("initializing %s\n", lsm->id->name);
 	ret = lsm->init();
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
@@ -266,8 +263,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
 			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			     strcmp(lsm->id->name, lsm_order_legacy)) {
 				lsm_enabled_set(lsm, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, lsm->id->name);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
 			}
 		}
 	}
@@ -310,8 +307,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   src, lsm->id->name);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
 	}
 }
 
@@ -319,7 +315,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
  */
-static void __init lsm_static_call_init(struct security_hook_list *hl)
+static int __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
 	int i;
@@ -331,11 +327,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 					     hl->hook.lsm_func_addr);
 			scall->hl = hl;
 			static_branch_enable(scall->active);
-			return;
+			return 0;
 		}
 		scall++;
 	}
-	panic("%s - Ran out of static slots.\n", __func__);
+
+	return -ENOSPC;
 }
 
 /**
@@ -353,7 +350,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
+		if (lsm_static_call_init(&hooks[i]))
+			panic("exhausted LSM callback slots with LSM %s\n",
+			      lsmid->name);
 	}
 }
 
@@ -384,19 +383,16 @@ int __init security_init(void)
 {
 	unsigned int cnt;
 	struct lsm_info **lsm;
-	struct lsm_info *early;
-	unsigned int first = 0;
 
-	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
-	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
+	if (lsm_debug) {
+		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
+		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+	}
 
 	if (lsm_order_cmdline) {
-		if (lsm_order_legacy) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				lsm_order_legacy, lsm_order_cmdline);
+		if (lsm_order_legacy)
 			lsm_order_legacy = NULL;
-		}
 		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
 		lsm_order_parse(lsm_order_builtin, "builtin");
@@ -404,38 +400,25 @@ int __init security_init(void)
 	lsm_order_for_each(lsm)
 		lsm_prepare(*lsm);
 
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", early->id->name);
+	if (lsm_debug) {
+		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
+		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
+		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
+		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
+		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
+		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
+		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
+		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
+		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
+		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
+		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
+		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
+		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
+		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
+		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
+		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
+		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
 	}
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
-	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
-	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
-	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
@@ -447,9 +430,9 @@ int __init security_init(void)
 						    SLAB_PANIC, NULL);
 
 	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
+		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
+		panic("early LSM task alloc failed\n");
 
 	cnt = 0;
 	lsm_order_for_each(lsm) {
diff --git a/security/security.c b/security/security.c
index add46073af0c..c9642020755e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+bool lsm_debug __ro_after_init;
+
 unsigned int lsm_active_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
-- 
2.51.0


