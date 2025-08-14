Return-Path: <linux-integrity+bounces-6822-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36FB27251
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EBD5E40DD
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152A27F183;
	Thu, 14 Aug 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GMpYIeFe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB128312F
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212051; cv=none; b=ArK0ZRDpn0pKmmMXYYy+vj1m0uzd95Vikp1m8F2GeIkEQaXAooxfHyxRBSD6PSchZVeVuQMEM7+0P8GqCo559Rl3IM8PxWaCj5EJaPDjx8Yq2EiG9JxRq58X91ryi2SsXoXXOoFIQhzkA17DS7qAtZqedvgi+KRxjpe95FIlCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212051; c=relaxed/simple;
	bh=G9ize9RmkIpDIugkMvGJBv2lAINOYFmUPnZp5NR8V+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE7ljv6KhoCBpglRoyYkFs3LUkgIQeAVnt3vx9q9XMPnpA69srsfPlD/jGk101yC/m6GNytv4TTykKUBaUDT6/gBJguOiEmUPzrlkobonVXBwKGRXd4nBNCpux10KL0yMPW0LS8LC4jWlvhSNOPsk1WX0555h2DcFi80BT3xdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GMpYIeFe; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704cdc76so146580385a.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212048; x=1755816848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFw4VeFUVF/IxpUvRwOLSGd+QR+qEP0U+qDO5RI5K30=;
        b=GMpYIeFe0LeTJcdgHgNQXSwY8vRBUS3CGr9PWcKzaeEOxfZ4+bUafkWUeKW2Gtze/A
         dJazk1bV30BHxB93mr1OYpR1ceT/Z7QsYwc7yLXnLte6oa8Yzm3EqVwkoHiik2Uj5pXn
         kMNVGJsckIZ/tXbdq7kUYEWSxBtjAc4bxrZkX7ZltknQApBYi6/weMFpWCCvnb20CboH
         RvLUFHBDkN5n2Edij5okS8AtKTK6q88Q6uYadwcaQXH81X6W9locIB97X+xzcvtbLLT+
         4fUB9RhECw2hIGF2ZgCA0s2l68E3c3vRRv0VbMNV2nENJyznFjHL0fJVuXV4rdEFkpbH
         kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212048; x=1755816848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFw4VeFUVF/IxpUvRwOLSGd+QR+qEP0U+qDO5RI5K30=;
        b=N7iCcTbzD40Fi1fSy87B7y3C/L6NKUH6H/l3nHECkTShWY6BeCqAvdgI/1xX6vZDl5
         +rhb8kXEzKS57Tyxr9+PNRbuavQ+AJ6cM+qbzAVqi8wJOuZSa7W1XiXJeg0A4fSzRIzp
         qGD1pLydmOY8VNTFAjMCyYptZkBv7umLO/vq2pbMn3/jLwlsSNfZZ4PDzU5XC86TIsWy
         Of/FaaTWQSTSl5tUtnSMPHBsLFj7mmoxmrcRfSZIBCtVI8CC72qkV8cfrhV0n+z4pazK
         HpQsb1CPfo0NK++v3sCycsK0l7qMBu5HeOrzDMICl0uTNzo0uJc50vwHrj1W9JaA50Zi
         pOQg==
X-Forwarded-Encrypted: i=1; AJvYcCWigD2NSg3sfLMTcflXVrFEDiwnPxB0GHIn8HijknEyn8ek5GSsA9eh2dhl49ZbYiSaOntJLnTS0i+uIQG73IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZCnwgNZgqZWeGYKys8O7m4qjHH5GLlxjuR9guCXfrikZBiqO
	VszxinTGz2txM9a5nBAco3tBVS/77lzPRIL7xeYDfWiu6GuP5jXUc/5bM9XUdXbG8hRyP2fCetc
	8ta8=
X-Gm-Gg: ASbGncuVYGLTulNg4TtVV+LA3JWgmYzOLcGvQ3WEfA5pcibPagORkdOVcQMqoJTvpBs
	Vj5mf4CyMMkrIxfCXuco3AIE/HX6WP5o9U7aTdt5Vho0JfXKStmfskm6SzK0q4uLLlwsjMcefWi
	pDnOhpYQaaMswVAO46XKqWs4YCGUiopObB6o3v7Mhc3LPY7umuGATjUkwCAOo7Zs1PD29VuWJZL
	Mr2B1YuBg2fnKwBcgxIjWA9XubPVPrNtLijFT3j9qrjM/qAXbt/7CtKOuwVlQRadHyH1tY6Syha
	66Qvdbsx55c8iztaSF1QBrD8GO4jBGM7eBK0T199nTb9Cw+U55BkDtgRboz9ATU80EtPVtlW2NM
	S8xQb1gRcrgPgiVbPs3mCEEYu8oYPRWxv2EApeacIRBK5evpjFkqOpufqO0OUJovjLVI=
X-Google-Smtp-Source: AGHT+IGO0+hAMpovwEegJ5B7LdaGBWgnghJCs4DO9yXhlqj3dEQsp3Utht5Pd6YvDKm4YQ0QcZQY2w==
X-Received: by 2002:a05:620a:280a:b0:7e8:63c6:2896 with SMTP id af79cd13be357-7e87057cf39mr774568985a.44.1755212048483;
        Thu, 14 Aug 2025 15:54:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b35dfdcsm44205285a.23.2025.08.14.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:06 -0700 (PDT)
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
Subject: [PATCH v3 04/34] lsm: introduce looping macros for the initialization code
Date: Thu, 14 Aug 2025 18:50:13 -0400
Message-ID: <20250814225159.275901-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5354; i=paul@paul-moore.com; h=from:subject; bh=G9ize9RmkIpDIugkMvGJBv2lAINOYFmUPnZp5NR8V+I=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmiZ0zuedfC0aSm5dcWi68zq6imIbXLSWt2cz rq/UM1ge1+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5omQAKCRDqIPLalzeJ c+N6EACFAChwhdB6yJuJjzCuL/xO4aoIAWkXrsbYDw/nA5TpwpYye5OxzF/xf5il90UybcuWCpV /zGJCWsRe7g2OOvSvZiNB3ICXoaV9nmFWDxhYW1ulSp7uaLUT0WRPVPrd/CQ2ai1FGUGHj+Pa55 ggtJyt1fgrcySlmjNzHwpPWDn/d4ftQ3EuLF78VaZ3wUc1OXjiLeDCMKO+s7hm3iqad4ZMU1jpO DB66YYhdCYY3XPj3XqiXRJK+CnrRqb6kj4qmPTE+64MoWP8OYIA09NTYyNRopcjLCPfBX8pQCzf vUyxo+o988Wsme9EdEq6qSWJrr+D55d/34ORq3xTTrBNTXL9/lVTk/CHayeuU0q9LweztvM8Us0 iHlRFVo56PAdY1LO/DEgU7WBFCP1J7fzYHoz/8Ju2U2h+qU/OJActrOTzvDe+CSyxPahefBCmnV tOvhkbyzq48N4jdj0rnoh+2lA5XCfaIEh1eHlXH7uIfP1Ca6Yo6ku5YNf+s+OvbOPB1NmxbsLrU sBj7Umo6aQ3xdjsFNTC6q66L23+DUYg1nACZqw6vUULhA4WLP24QFQkpOrP3St6Hf+J3z58Y7bk 5ygkXxxigv7SNLVTa85oixGmxG0wP6BRSR948nxLliv2CaCTUoppjH63ah3g2paU/0plzHMDyCJ YgHF0A01omCJWWw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There are three common for loop patterns in the LSM initialization code
to loop through the ordered LSM list and the registered "early" LSMs.
This patch implements these loop patterns as macros to help simplify the
code and reduce the change for errors.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1


