Return-Path: <linux-integrity+bounces-6669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A2B0CDD3
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65621188B569
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48A246BC6;
	Mon, 21 Jul 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KkJi2zUw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1291245033
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140250; cv=none; b=hTAI2Va9j1N1W5nyv2s+HqnCYTUm5R/w+uguPvNcNfYx5BN5xgYq4sbGk4S36nxw3yCaPFfEVziQdhpuM7Rt+IPYMdKrpNsjooQ4SSCTRoSSjx3gBYH2kzoN3a//OBrXrcEZA2kuwUAo+HWEqlrHT/tlrKp4Kk07d+TIW2P6pjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140250; c=relaxed/simple;
	bh=dSEzq7RpKq+y9EJ8dvNhOBryx01szd8s+l0LRfswLU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/5rJ0/4V/P6uD7alY+7EHc4NUuMBHa4sFQEeNFRhNiw2Be16v/xUo1CvCvRJXHN8vXdWAybtIDi0EI9XqAhPGXGJsF/2Cxpyp8BbtNCXcjbxjxUj67WchKQdfGJ6wmaxPTrTeCgZBZFgQAPtWGwulHQwsH/VKIzaA3ezlAEwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KkJi2zUw; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fac7147cb8so72231176d6.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140248; x=1753745048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq8qfQPfDwETd4Q96AHzHjMr3vtxOecUlxWLMJ9hgL8=;
        b=KkJi2zUwTlpO6se0uX+4PftpO7l0eQhiO9Kiye3dPfV7IILQouXPtmmz3hYl1DcC4M
         vb65VjXyenFD8/mJZGLAiIffwwhtp7VA5D8oFF3Q+0E4Z49EjQys7W7OZNDEZeiencd0
         lEw3PYfp+EyLZRptP6zQCO9mRg32giBOo2UDrMj9aY8uuKI3eFjfaewd5K5lqFS9aVLB
         A3r/rIp8UBHxCw4A81J5jA/f6sxKi5uB5PCTwFUYeRLRN9UYIN5dcN4tgyCRJZPh03IW
         5Nif8scQK21TP+uvYP0pNy+Gihx9lYA5YD0ePTUjNtEpOrW4AzJ1xY6ttsrV4I27Igrw
         Ts8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140248; x=1753745048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gq8qfQPfDwETd4Q96AHzHjMr3vtxOecUlxWLMJ9hgL8=;
        b=svslDyMM565R6iWZBbbDxa5O3pAf7pz/R1Ivh1SqsmaxXk81T70p5ovoQvaoYBMQ/y
         kUQaH38qInzWhNjEQ1vXV6EdmmhCN5+zJ6pqLXyW3kim6MB0bup6TNF9Oe8W2G2Lhdgk
         oFxdFdao8BnAHwYandoPAUkCn26Mn1yJRCwMHjGy6JDonVEbwRFPgDPnIVZm7OGBN8PP
         j0gbnrAz0M/mkdmmFv5dlybM5NKwY18czeg8tTZ0DaTxlyL6aZExUPASETxshc9dxKLo
         IgJz6KxYgyZdyx95Evr5lfgbZg48KsN7VqMEW7bdvHbXa6kZwPWz+Udu5f0Nl5Sv8LrH
         bDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzI3RVYmHwiZzBpx0AkKY4caV+axuO//SngBe2Nn4qOL2b0nGHJhnHafvbp4I99cQp4em5cDfCZht13+1hCsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARS7si1BRSK9GeE01H8DqUGelO2AWru3kjHbogebjy/yTDyEc
	NaFb7KSkfolEHkM7KXlPEOBXnxSFkI41k0x3K8+hLHrXPNDcnJ66HTTeC6Xq1sQ0Rw==
X-Gm-Gg: ASbGncuFAmafydGtCdEh0/aoc5XYcTu+2mtFVmk8Mq7++j2TFF5uOseKoKJrB/Jmud6
	gyqWKtLUBEnoD88+1p/+iYERQ0ILsNoPwrOYfy4w1nbicY75ZpO405pxu8ZnKzG+ibcI5fD5SQl
	9uJp0sUxkw27lBQkOFrEXdcd/zynaO7pT9A1Ztbgjtp8eC3vAWafr9ZbaaEAiaQr1YsdgrfKP1O
	AHeX+izImOeOVehyu0InXQxi+1JEIgUisgeXUjYplmhC9sgebzs7yWP8U1JXtjlhu28st1INM1p
	bIa/ECSzx/MhFzyVV7z3EGh+CUtCeUydkL6kPcy1xIsTRc1IZtfLpIumrNNi6q0P1GJ2vMI6NjS
	M1BVvBikZ5PSveOdZGwkYv6oO+CMeASm606NMot5/lxgSTOp4+gi6HMUDNOrlCc5BnAifDvm+lQ
	ZHUQ==
X-Google-Smtp-Source: AGHT+IGIPjxueKog6gK2g63tC1A+ahG/XKyd75JwaZK7a14oaQYVEYjrlm9SvcIKr5NJ2HLXq3PbbA==
X-Received: by 2002:a05:6214:5192:b0:704:95c6:f5f1 with SMTP id 6a1803df08f44-7051a15125fmr247194326d6.34.1753140247905;
        Mon, 21 Jul 2025 16:24:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8e1880sm44263686d6.29.2025.07.21.16.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:07 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/34] lsm: replace the name field with a pointer to the lsm_id struct
Date: Mon, 21 Jul 2025 19:21:11 -0400
Message-ID: <20250721232142.77224-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12369; i=paul@paul-moore.com; h=from:subject; bh=dSEzq7RpKq+y9EJ8dvNhOBryx01szd8s+l0LRfswLU4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsummhly6aznFzlFc7O4WXJbo81KfVIN1OVc6 nA+xPi7Ng+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LpgAKCRDqIPLalzeJ c6CoD/4guSoPw1X6SZSkYrMCoGlqX7fw8FHQe+TqVuctX9NkoBf9HCPHtY2B4Jfw8ysNh9riQLh SzYGulwqCzaB2Z4fApKXo3lNfVbOUmxZNJl6BJkQ2bfmCnzlJq5QIvoXKKzqVYyLPpkQcgJvzEZ o3iMxdkZP4Qpg/PdH2izJGZ28DYKyBPiNqUkOE5GpdV1R3k8tZOGqy4oHUjf68atEHftKO2jGL/ mSFhhNUr2Ss11OE+f74vasszP8am1Qi2Xstj18ldiUe4K9PAHcYeqOkTUa/5XQFGtAl2z41wy41 PxYHNgy4/ldULH/K5hMPbVEoK/20AwntVOpcec0+TWAyT9AsHvIAP33zwx3dJPH18WpNqEqHyEH aTsGHMn5ImQJQqvqhkjBezDMCVFcA/hAxP25hvmEr4WUms8u/J6DHk6UsUrIUBIZioDx1VFTwjJ Hs/DjOWVzM2WP0DJk0PwY7sVKN2qoZgFW1DiTavdfHB75h0zxQWNaJ8qF1ptg0B2zRDSb5vMxnZ TssK5oMuJ6Hwu+piT3D22WVlkUmo8wEwCur85un43Y+B7cz9SzYjSvK7GBshC/r+4GfL46+R+CW JzYiSUcBcMmixqwUNxyN338E5LG58Xo8oPrQ2uuRL0Gm5TbsZ4d9PaCkrK0dSDVCaecko22Ih1q hHVjgGJ7GpYBZVA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reduce the duplication between the lsm_id struct and the DEFINE_LSM()
definition by linking the lsm_id struct directly into the individual
LSM's DEFINE_LSM() instance.

Linking the lsm_id into the LSM definition also allows us to simplify
the security_add_hooks() function by removing the code which populates
the lsm_idlist[] array and moving it into the normal LSM startup code
where the LSM list is parsed and the individual LSMs are enabled,
making for a cleaner implementation with less overhead at boot.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h         |  2 +-
 security/apparmor/lsm.c           |  2 +-
 security/bpf/hooks.c              |  2 +-
 security/commoncap.c              |  2 +-
 security/integrity/evm/evm_main.c |  2 +-
 security/integrity/ima/ima_main.c |  2 +-
 security/ipe/ipe.c                |  2 +-
 security/landlock/setup.c         |  2 +-
 security/loadpin/loadpin.c        |  2 +-
 security/lockdown/lockdown.c      |  2 +-
 security/lsm_init.c               | 45 +++++++++++++------------------
 security/safesetid/lsm.c          |  2 +-
 security/selinux/hooks.c          |  2 +-
 security/smack/smack_lsm.c        |  2 +-
 security/tomoyo/tomoyo.c          |  2 +-
 security/yama/yama_lsm.c          |  2 +-
 16 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index eeb4bfd60b79..4cd17c9a229f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -149,7 +149,7 @@ enum lsm_order {
 };
 
 struct lsm_info {
-	const char *name;	/* Required. */
+	const struct lsm_id *id;
 	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..a7f6a3274682 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2272,7 +2272,7 @@ static int __init apparmor_init(void)
 }
 
 DEFINE_LSM(apparmor) = {
-	.name = "apparmor",
+	.id = &apparmor_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index db759025abe1..40efde233f3a 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -33,7 +33,7 @@ struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 };
 
 DEFINE_LSM(bpf) = {
-	.name = "bpf",
+	.id = &bpf_lsmid,
 	.init = bpf_lsm_init,
 	.blobs = &bpf_lsm_blob_sizes
 };
diff --git a/security/commoncap.c b/security/commoncap.c
index 28d4248bf001..e04aa4f50eaf 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1509,7 +1509,7 @@ static int __init capability_init(void)
 }
 
 DEFINE_LSM(capability) = {
-	.name = "capability",
+	.id = &capability_lsmid,
 	.order = LSM_ORDER_FIRST,
 	.init = capability_init,
 };
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0add782e73ba..db8e324ed4e6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1175,7 +1175,7 @@ struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
 };
 
 DEFINE_LSM(evm) = {
-	.name = "evm",
+	.id = &evm_lsmid,
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f99ab1a3b0f0..ded971bdeaae 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1253,7 +1253,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
 };
 
 DEFINE_LSM(ima) = {
-	.name = "ima",
+	.id = &ima_lsmid,
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 4317134cb0da..2426441181dc 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -92,7 +92,7 @@ static int __init ipe_init(void)
 }
 
 DEFINE_LSM(ipe) = {
-	.name = "ipe",
+	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
 };
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index bd53c7a56ab9..47dac1736f10 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -75,7 +75,7 @@ static int __init landlock_init(void)
 }
 
 DEFINE_LSM(LANDLOCK_NAME) = {
-	.name = LANDLOCK_NAME,
+	.id = &landlock_lsmid,
 	.init = landlock_init,
 	.blobs = &landlock_blob_sizes,
 };
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 68252452b66c..b9ddf05c5c16 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -271,7 +271,7 @@ static int __init loadpin_init(void)
 }
 
 DEFINE_LSM(loadpin) = {
-	.name = "loadpin",
+	.id = &loadpin_lsmid,
 	.init = loadpin_init,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..4813f168ff93 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -168,6 +168,6 @@ DEFINE_EARLY_LSM(lockdown) = {
 #else
 DEFINE_LSM(lockdown) = {
 #endif
-	.name = "lockdown",
+	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
 };
diff --git a/security/lsm_init.c b/security/lsm_init.c
index c8af26a6ce14..96d51e4d625b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -127,9 +127,10 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	/* Enable this LSM, if it is not already set. */
 	if (!lsm->enabled)
 		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm++] = lsm;
+	ordered_lsms[last_lsm] = lsm;
+	lsm_idlist[last_lsm++] = lsm->id;
 
-	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
+	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
 		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
@@ -157,7 +158,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		set_enabled(lsm, false);
 		return;
 	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
+		init_debug("exclusive disabled: %s\n", lsm->id->name);
 		set_enabled(lsm, false);
 		return;
 	}
@@ -165,7 +166,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	/* Mark the LSM as enabled. */
 	set_enabled(lsm, true);
 	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->name);
+		init_debug("exclusive chosen:   %s\n", lsm->id->name);
 		exclusive = lsm;
 	}
 
@@ -197,9 +198,9 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	if (is_enabled(lsm)) {
 		int ret;
 
-		init_debug("initializing %s\n", lsm->name);
+		init_debug("initializing %s\n", lsm->id->name);
 		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 	}
 }
 
@@ -233,10 +234,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 */
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->name, chosen_major_lsm) != 0) {
+			    strcmp(major->id->name, chosen_major_lsm) != 0) {
 				set_enabled(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->name);
+					   chosen_major_lsm, major->id->name);
 			}
 		}
 	}
@@ -248,7 +249,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
 				found = true;
@@ -265,7 +266,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -282,7 +283,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			continue;
 		set_enabled(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->name);
+			   origin, lsm->id->name);
 	}
 
 	kfree(sep);
@@ -314,11 +315,13 @@ static void __init lsm_init_ordered(void)
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
 		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+			pr_cont("%s%s",
+				first++ == 0 ? "" : ",", early->id->name);
 	}
 	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+			pr_cont("%s%s",
+				first++ == 0 ? "" : ",", (*lsm)->id->name);
 	}
 	pr_cont("\n");
 
@@ -426,18 +429,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
-	/*
-	 * A security module may call security_add_hooks() more
-	 * than once during initialization, and LSM initialization
-	 * is serialized. Landlock is one such case.
-	 * Look at the previous entry, if there is one, for duplication.
-	 */
-	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
-		if (lsm_active_cnt >= MAX_LSM_COUNT)
-			panic("%s Too many LSMs registered.\n", __func__);
-		lsm_idlist[lsm_active_cnt++] = lsmid;
-	}
-
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		lsm_static_call_init(&hooks[i]);
@@ -485,10 +476,10 @@ int __init security_init(void)
 	 * available
 	 */
 	lsm_early_for_each_raw(lsm) {
-		init_debug("  early started: %s (%s)\n", lsm->name,
+		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
-			lsm_append(lsm->name, &lsm_names);
+			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 1ba564f097f5..9a7c68d4e642 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -287,6 +287,6 @@ static int __init safesetid_security_init(void)
 }
 
 DEFINE_LSM(safesetid_security_init) = {
+	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
-	.name = "safesetid",
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..d7ec6bc6168b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7640,7 +7640,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
-	.name = "selinux",
+	.id = &selinux_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..e09490c75f59 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5275,7 +5275,7 @@ static __init int smack_init(void)
  * all processes and objects when they are created.
  */
 DEFINE_LSM(smack) = {
-	.name = "smack",
+	.id = &smack_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index d6ebcd9db80a..ed0f7b052a85 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -612,7 +612,7 @@ static int __init tomoyo_init(void)
 }
 
 DEFINE_LSM(tomoyo) = {
-	.name = "tomoyo",
+	.id = &tomoyo_lsmid,
 	.enabled = &tomoyo_enabled,
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..38b21ee0c560 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -476,6 +476,6 @@ static int __init yama_init(void)
 }
 
 DEFINE_LSM(yama) = {
-	.name = "yama",
+	.id = &yama_lsmid,
 	.init = yama_init,
 };
-- 
2.50.1


