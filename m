Return-Path: <linux-integrity+bounces-6838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DBB27281
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBEA22DD0
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173D28468C;
	Thu, 14 Aug 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SOozGnrI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB7283C8E
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212082; cv=none; b=N6C40fqcf1rCU27xWZGf5mV01YnpczjoTnZmz8kpivmONtSe4/b0lvbr+fZCBRfsIwtXQKqm5O6BI2tLLRYrjoeb/3KTlVffezSZaG7dhw4/nDLWYaDG3mmQQNMvfWDtN1Z+Ges1QzXy3JVYjpFZ+MH3Me8LaQoLkGGmF4O/3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212082; c=relaxed/simple;
	bh=F5swOGRet7z9l+XAcI7s24EH5r3ELBFHTJ0a+7rhfj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQJs+dRnWTmlU+sc/CqvuNTwoDHrVPeCJA/MWe3QcIDxxjFTBM3QLN64Xo5LXFJM4zEdZkgkXBG41o5uRksmYPrgMiuk7bvTGjtMiU3U8jr+BeaJmCbRBlXnSEHrJjr04J+ZmX/ScaYaXGplSSqNoBdWq/Cges5/icfvuauU/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SOozGnrI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70a92aec278so12382366d6.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212080; x=1755816880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n53mnST7skqOE5LPslIhQud6mZyjIMdleoyHJO4VWOU=;
        b=SOozGnrIliBZeetTau20CwKzHu45pOND4Ch4Pz/MnG4ZlqKvtnRXV0TaO9/Co87U1A
         CJni+TnfeuHFr4NzRtdkMUedjZFqxMMdvKdrHvRMWUgJ8COkRBufkb5+5zbgREj2vFZS
         Q0NTGzs1dlYp41Muy73GzBMGc2GAy2O4UrAnFT90PI8b7xF7c4Hhcayw2ueGejBKgREe
         Sxcic6HyjtFshBDGYS1CBS55QVT4NrAa1ZVdbWitkYFuRcxs4Hnnx1GXMTJHyv0wyUa8
         agBjSgrFJhm7tlufiSqp/SC+5fq2Iv9fgdjMb/f5/kEsVi+RWgMqMFmauQI5KWT92Qwc
         NF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212080; x=1755816880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n53mnST7skqOE5LPslIhQud6mZyjIMdleoyHJO4VWOU=;
        b=kLrz7IOhng/t7YPJWTdgflijyoUffzVv4orROrwVnQS7yR1EYw/tmUNQoJJX7yOcMu
         vm1fn7QDm3XxfbG0iVV9j7fPv3e7VoJTsAMiCKl0vdEwWkjn3RcSvWIdNMwyRWmOyq/r
         /F+acyqwRlTTypf1btL1Atg7Aq5f3pm6819XFukGRefl/0x1+Y+foVxX/LW82NKpduta
         IByfoNdFdAvT4/sxFYIVlQ58B6Hnx+DNOxJuq/Fi2xBQHvrCmETKAATywL1chh/D9h2o
         ISTZAzbOzFb5SPSzevbeQiha9pzEbu+6qIZYU/gesVwQV49avV7f6j0w9+AnL08mM0dR
         802Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4DMZ7eiANklwtlGZps7ypI7Q695MpTmMSfFGt3kFXlsq9N8vJ6FRaW8e89u6r/PvcRkWYLFuCOJFUBLIDI08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOvabMGJ2V0XNNX3YDk2OekixF2YSAxG7nS5xVMJ3NUoB7Y5f
	0vHS6O/uPc6iP4v4SVExUnzCXMMIpLRze/pJ/VyhGe8yKm26rAQXXWrYODKnmll/MQ==
X-Gm-Gg: ASbGncvLlrfsKbNvSivEY0FZlKSR8kRa0j6Tie1AbUmC4JW7upI3uohzdHAhLgC0LYq
	iEp582jB48IFMMuEt3ufQd9k4F5T0S/7rnCRnaBJ02QvIzYh5IZhciCoc7l75r0yscm7YRBMgFu
	htjQZ4pDEGLpL/iN2iz+oYqyE/aA4G7CuDH255gc7CMlJkdM4s/bmyCHVGsdbJeW0gqaGtKUnMi
	QbYpJkhtNdabKXB/kVINQdBqbEaAvCviXX1OmCbk7LoHCAHYPoU4kXSbB3fOm2CIbVzyQcyM5V0
	NKnrINxKA4tku4c+B1RxbUN78Yp2KSr3msmL9yjGy90UAhg9SJmtjBVvmcqDOz3/EmQjQgIE8ow
	gOT5S0t0hM9gVDOwLkG0Omlkjp+yg1uWjAxzbsodMNfyo2zDKCNXj/iVU2gq+FJRFvsI=
X-Google-Smtp-Source: AGHT+IFiEKvCOtldLotc3KkfIJ3F1gMiN8wtbg1pDcQGHgV9Os1swFOyftFjyhPfKi3OQmYQa0PZ9w==
X-Received: by 2002:a05:6214:2aa5:b0:709:7747:9ff1 with SMTP id 6a1803df08f44-70af5bd5de0mr75298406d6.2.1755212079865;
        Thu, 14 Aug 2025 15:54:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c31efcsm19291876d6.83.2025.08.14.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:38 -0700 (PDT)
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
Subject: [PATCH v3 20/34] lsm: cleanup the debug and console output in lsm_init.c
Date: Thu, 14 Aug 2025 18:50:29 -0400
Message-ID: <20250814225159.275901-56-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10324; i=paul@paul-moore.com; h=from:subject; bh=F5swOGRet7z9l+XAcI7s24EH5r3ELBFHTJ0a+7rhfj8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjNCgQNULbd67tXTAO2/2FNwPjKlvgAlRTPr YmybVWB7jSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5ozQAKCRDqIPLalzeJ c8eFD/99DcGym1U1DWsoI0E3q/YVa2c38M24wrIcwXCFAwQ2RftZoSR7V36M5WfUONnSAdKmDY7 JXzoSlhXLbe+oyM0RUAZ6V3SSrYccheJOdNoy/1NLgfWDgsHW9Uf4nxQUzUyDbFc6+bycpPRW59 KoWJ1PRMglVlPK7m2n8ALLWrez/w5po5t+9Ti3/WNvwjIIPA+mvIPdoRsib/OYV41pe0G/b4zNt OQ46rrAjJ0d6iQh2vPOmRsahyEYNtbiHi5WFESSk4/x5rD6ihNzYDzwPGbs0q1Wsx5jTbdS/03M JnuSMekcaOkZjewR3TIgFwHspDCi/ape9V+jPAxKjFSkjwSzgny6wTwWFMxDe62rSawJeQn/ZCC qh+aDkKAy+TptrPzKxiL8swRhLBkidnHX81XG2qtNaGT2Gb4a2hmhop74uBt3CiVlr7FZSfYQ+C Zi8mF5KmG/NP9WZV8nzP7YBMxVTMzIP77QCdO3pEnRnB7g2W+5xUDwriOIg1QoS9ksmqAQ7sFsg K0bornk6ytHlb/ETkFeIpmBHIpcmzlS1WnG6Hipge6fqtbKo5vroCnoy8v70orzkqktj9O/DtCu YAX32hH73RM0md5WKKUfShVxtaY0GY4vBsXE/W5O5dA/ch+3AThclJXynK92xCNqgRGUvHowPZW rm3AF+EJwVUf9Nw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move away from an init specific init_debug() macro to a more general
lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
both before and after init.  In the process we do a number of minor
changes to improve the LSM initialization output and cleanup the code
somewhat.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1


