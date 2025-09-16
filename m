Return-Path: <linux-integrity+bounces-7109-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCAB7D24C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ED3526269
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4F29A9E9;
	Tue, 16 Sep 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MFeoWhZH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF662C0270
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060824; cv=none; b=t9GQb6j4wTHcyx2JxkwDxaN/cNNTMFofG1QGArQ6z9z4SFF+0U52w0n1fXyCX8ppdKnLI1dkEcBx5s4NZvbGvZazYkW0iiKbDGRXiZ1ztVYTV6n3W5NQBrV4Em1Nashv+uaqBtmL9U3/1U8MKARMl/co5BI/ldndZfbEw0X649g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060824; c=relaxed/simple;
	bh=uVut6TV1PJIdwfEgkpNN77srM8Vz0L/dpZkLz41WDp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUf6Q5r/PUeiVGyV42cBCdy7J1UgnTotfLtGUi19KePnI1Kjj48pD+yPUqi8mMiBizgZ61t6SUQRoy0gCb6cVv4AidIq/zT7qZNOIeSwWVWDbYT7Rps6Mfy60nET97vRNRr98cMozgqsWslrk/qP6jIN7NYWMVDFOe26WEk/ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MFeoWhZH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7240eb21ccaso2878096d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060822; x=1758665622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVk/SEbEzznq+9S0UaU148eBB2+2tKSp40RxHPejpAI=;
        b=MFeoWhZHmmVZkuhc5GL94xvjXe8o6j2sICa8WyTV9QsNnhgYXYU8nEA0mXR9I8LPr+
         ATIGwbkCSn+faKT8dxveSnmKCYLbPrUcb9zDwgo+iDP+sl7UmsHGudAG1vBqytqW/qb7
         sWiuA1c72GBaGk+QBZuIZ32FV/T3hjqGyqCx1/fh/e/qlEHfLEccPMMLU5oSXXAiPW3H
         OZJ1WDrqms5ceoWXpsg8ed2EZU3Np4MIKdhUATGS80FHtfjSr1sk9GqmKu0TH8XdbU9C
         t2L5CEIXtkbpp6P0G6gRCzQFc+TUE8ywMnfdIMsBrtugW3GVjQe9L+xoy/s2GmXvsrre
         I2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060822; x=1758665622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVk/SEbEzznq+9S0UaU148eBB2+2tKSp40RxHPejpAI=;
        b=jWGhtaL/4oyx9x/z3S71AWwBlDMgjQCvqBIpvJwCI+E1hrXVdxLV4iZf0XtGiJO21+
         96F4UmGxLGGQY+Pg1+sd9eZGPxjNVU878b2Hka7wxjbyKmsVGVhI2qnUWmug+qbYKI8K
         LRqRWh68FUn+KrhFqybASXgbow2hygydig4y59zGbSIbD+5weATC74Xv3Dgx52N5FWPM
         69aofI3qqeGPozTjskwiRv1XQmtgCvtQYKjg5hEQr7cjMK7uTAK+dBNTEuCzg6rdE2Zi
         s84bQixcQIXVFN+BJlJSk1mIoyu3qWOhUY0T+aeqHarr+e4qxOEz6QFZgvmU14U1b+4C
         0mcA==
X-Forwarded-Encrypted: i=1; AJvYcCVIq4uxrbQFgJyjs/jCOJ5VlsKqY9ANDiIgUvRLOCrLU9a3BdYo1HgE0hyOH98oX63tCRN8CcyOJ/18bTc0Igw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHajOGt6TzmAlgZ7NhJKJnAzg9h8lL2pbt37ethbi2uHX2MRbx
	Thk71xAs/MFj+y5zEnsJTC7fXzqXw27+vm0237662YvHX8lUqn2IPo+1TmX85h9reA==
X-Gm-Gg: ASbGncssmPfYhKVpZACFWcMTcp4CPjPdzz/Nlm0C8xDbULoTxhnHUZqKWQtL/qMqg7v
	6Ex7tOtxfNW98SIeGMis4NWAV9MFVvbTPQb3hr2HeD3eLss55a5jkryPc/bRyj+wj9o8f7DL7IE
	scp6X+VH1frP0j+YUVAzuT6uYwMVZtoAXOpUJNFf00CdUXW9WFnxJKs8X8CKVnxwOFVLMUwwRzp
	sj4cs9Y8FbRKM2Xo84ZmKcQTGTOLqzfCqXzf6ufdHDm98RNDd3nmPtshtFwiCXxwih5e2ljMY+w
	mXvrhqzFTb/5tgcysydRA7CswbMj7c7jHROC3gprkjRH+dNTtz4eURsm2CCflLbe6ml5yDi+4q9
	YOvSNk2vbkHrUPX/iCf3QZJrsQEGs/wexcTSwTSo1wsZNzB0F6pc0MGiP0Ic3yIwmcJ6r
X-Google-Smtp-Source: AGHT+IEZYT3KxPn/C21QpjEd43lkmb7fETnxfqKpQsM10eziHnAEfcJz3e9e+zeensN/SAaRNpSbcg==
X-Received: by 2002:a05:6214:f26:b0:77c:e97b:91b3 with SMTP id 6a1803df08f44-78d5ce634bfmr31939346d6.9.1758060821493;
        Tue, 16 Sep 2025 15:13:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-783278c7ea7sm43662926d6.46.2025.09.16.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:39 -0700 (PDT)
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
Subject: [PATCH v4 04/34] lsm: introduce looping macros for the initialization code
Date: Tue, 16 Sep 2025 18:03:31 -0400
Message-ID: <20250916220355.252592-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5413; i=paul@paul-moore.com; h=from:subject; bh=uVut6TV1PJIdwfEgkpNN77srM8Vz0L/dpZkLz41WDp0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7VafqACNXqa/p4/ASVOhq0v0XoMMzzDKHq0 /e+W2F++PCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne1QAKCRDqIPLalzeJ c/tlEADewOE87v22s4u7VzfGVaWMmtlNgkBKgoIntGp0qWo5JgXxXJa5rXnXHiTFeNLFlyAvs+B 2Aab3cQ32MrzcsWGpAtDYszfrqWOiNR38Om+yMxHSnEUwweavqO9RcIyZ+XSEZeRIseDccLBQNA vVifCGuCtG/TJdz77kkIc17s87GkgURQ9+klY5V7r8VUjrzleTnX2XE96blG4xodzutIALPqKa6 Jqj6WByngipaIKYnWJi3A1Tt7EWQEH+uX0Kj81sA1mxeQ+11wWE7r8ZbGaLWciRGzWWRrTLCkDU 7DCger+DbVwVUm7N0zii/z2/BBRD/0JSVv2AtkE37MpeNVM2ebbCG3rcYAvkPshY4Wi8RtvQOtB fkyTNh/pa7msO0KqaB4B0VGYCd+ZD7LwtKzEnw4FtLf/QCW/99arI8QBPN4BWEXFLep+uz/eUGg kEX/R5wpSCuLCbZXRu9QWbqNzd3IHp/5MUyaHP/CQVylo63vKHoMCylDvNbjnk7HefKA4pyFYyY 709r09UzQs2JVYPu2jgPYYKy1sDhPw1+MMlkKav0XwiarFyBykOVcLIYgvjIWnSfI9AEvHuVEo2 +erRITaXF1cCSgNgNnq5AfFA0Avja8oRs55cO0a2oi/0lW7oe8ggH68/abf3HFkyVBK3x5tXpvH gnB+I/feDh2tQSw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There are three common for loop patterns in the LSM initialization code
to loop through the ordered LSM list and the registered "early" LSMs.
This patch implements these loop patterns as macros to help simplify the
code and reduce the chance for errors.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 6f40ab1d2f54..18828a65c364 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -32,6 +32,15 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);				\
 	} while (0)
 
+#define lsm_order_for_each(iter)					\
+	for ((iter) = ordered_lsms; *(iter); (iter)++)
+#define lsm_for_each_raw(iter)						\
+	for ((iter) = __start_lsm_info;					\
+	     (iter) < __end_lsm_info; (iter)++)
+#define lsm_early_for_each_raw(iter)					\
+	for ((iter) = __start_early_lsm_info;				\
+	     (iter) < __end_early_lsm_info; (iter)++)
+
 static int lsm_append(const char *new, char **result);
 
 /* Save user chosen LSM */
@@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
-	for (check = ordered_lsms; *check; check++)
+	lsm_order_for_each(check) {
 		if (*check == lsm)
 			return true;
+	}
 
 	return false;
 }
@@ -209,7 +219,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	char *sep, *name, *next;
 
 	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
 			append_ordered_lsm(lsm, "  first");
 	}
@@ -224,8 +234,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 * if the selected one was separately disabled: disable
 		 * all non-matching Legacy Major LSMs.
 		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
+		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->name, chosen_major_lsm) != 0) {
 				set_enabled(major, false);
@@ -241,7 +250,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	while ((name = strsep(&next, ",")) != NULL) {
 		bool found = false;
 
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
@@ -256,7 +265,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Process "security=", if given. */
 	if (chosen_major_lsm) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
 			if (strcmp(lsm->name, chosen_major_lsm) == 0)
@@ -265,13 +274,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
 			append_ordered_lsm(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
 		set_enabled(lsm, false);
@@ -290,13 +299,14 @@ static void __init report_lsm_order(void)
 	pr_info("initializing lsm=");
 
 	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
+	lsm_early_for_each_raw(early) {
 		if (is_enabled(early))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	}
+	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+	}
 
 	pr_cont("\n");
 }
@@ -343,8 +353,9 @@ static void __init ordered_lsm_init(void)
 	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
+	}
 
 	report_lsm_order();
 
@@ -382,8 +393,9 @@ static void __init ordered_lsm_init(void)
 
 	lsm_early_cred((struct cred *) current->cred);
 	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
+	}
 }
 
 static bool match_last_lsm(const char *list, const char *lsm)
@@ -485,7 +497,7 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
 		lsm_prepare(lsm);
@@ -512,7 +524,7 @@ int __init security_init(void)
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
-- 
2.51.0


