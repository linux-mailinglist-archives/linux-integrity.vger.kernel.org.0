Return-Path: <linux-integrity+bounces-5699-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F4A82F80
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01EE7B096B
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0127BF83;
	Wed,  9 Apr 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="da+0JmD7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5A27932F
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224817; cv=none; b=Qr/zh+x0/73wdTGB4QuS0ZL5+w/CpYWvh5QsdpTPUpt4wqNskIExhiwRM9QKTZ/Tom02xGIUAm15GfpDxiI22tAf80vHySj4XDtKZ1QWRprKvic/o7SNx6k8YF8s5NDqeFE5bLZgB8ATCfhZqWPXUEfb9QBQLCkWovIlINSzZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224817; c=relaxed/simple;
	bh=suwgQBN2f+WUDLS5qxCVT1JfKZ1u9cWT9DOTBoIM33c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRyVDNg9xUhaa7UusXmR30fZ2ArHNobMJd846VXqmPHQKiCQcBK+dmU1gQR7Hh8itWJkhNyg9eT5UeIcVXB6rlQbqAx+Y93Njmce0hSnsn9DrRpszpuyWPtyXSJx/+3NoEv2bHMl9ThVghgh2DmjnCygfzugAEmqap30BTTSKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=da+0JmD7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so2003785a.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224814; x=1744829614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y249LSqoR+cxToQEsmQYSigHHJBjh+WrtpsqV/HUcV4=;
        b=da+0JmD7krNoqVpATVCIYHS/jf9H2/rBeM2nUpUK1R48Bsq6xf8Pr/SciTXQw99+yP
         e4uTZskyVCZNcjTEtrVQ2gLT60/i0JTuPVsHVDm2t2TGXZ5MjX9qvX6qkmgMGtRb/bww
         ZHW2htVIPLniHT/2xXSkFEiH1jywRh8zomqm2vCX2E/H9ND2mes9XdAuBIDjPRczdvNx
         zq/yNXC7QjTCFq0QhoxrO6Zys2eH3gI99EBqODIGIp0vH6baqKOcdFvVBp6GBISJD94n
         7N3JkINxzamWWUuMZKb5LD5kliPV3Mnspz/hZPININvcowra0mmgeTRB2W8KjffAT4ru
         4KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224814; x=1744829614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y249LSqoR+cxToQEsmQYSigHHJBjh+WrtpsqV/HUcV4=;
        b=JekCO3Hn85zTZF0N6wKl2k/L0Itp9I+Jfs3p8SluTrSwcxXkXxZgm3AaWO2z/xzE6b
         bezh2mpaDcUg7XrRHs9t+JduqR2u7MsfsXGhkknhibKHO1XRIrqhBYZLg7cGj3238Hcw
         JSiYgOtkrjWaikibAeTYfcBKMvAJ81vio3fdpW7uGEx5fa95V91YYJPF/RP2cZkUdLda
         zTBS6nc4a0TDNmmTmwlmPyCAmDr7UmbwM5dI+f8U/slExi+x4LQd6gCQwNh8CNC3xX13
         pnRaKTpUlXKAObwDENU+0sGZq6WqeUngxTM16jAjELP2h1QuXSMk5STdhQOjrJpL3/XK
         cDoA==
X-Forwarded-Encrypted: i=1; AJvYcCVJt7wE7Fa9PnQnQt6uvYZdFAfvd0fMz1+3b32sVfWDi9GTI1l7AWQfveFt0yDiLDTII5DFNvhqXV5u6zE9Qr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+ftH3alPB9YdDZcQtY3SZ9FtXdBvqUb/dDe8OIvuqe+Q+zK9
	cgAsrxU762sIZDjMZnpjR1dKnOrqnnRqc7aPqZ9QrwuGXkaUD/cunr3+F/SJBzBgfzZM+bgGnwM
	=
X-Gm-Gg: ASbGncv/ovEqdFNpEHcjGSnxrgT7TyiLNVDKgnZeMQd/NRSEUF6NKdWDUusnzxHkKK9
	jp4R3Sw/sBPGWG8YF5z19EniN4lJhnoCcpUePgS7yNxORHQ4Lgkz7EOTwU/GKxw/gYRFiy/ed33
	MFeIBJxsgUkJrOuslLNKh0pGfK5jDgSr/FyT7wkkmnPJ3HCwupDjzinAvFvTY0meptyGVt4O5ka
	4w/M5Ak6JVgiwG8kme5IsX2iel4/cAZyB4OoCmMEXDdxdSqkzRWPZzaDuu42uNhHhoYJY4X1XnO
	HpRTq7n5RqNLk4GuVay2u/nUOYoc/rQiG0dIbHBI/ZDCaeHrjPkit6QSIBxxar4srnsa7f/6R6R
	yGuTILRDfEw==
X-Google-Smtp-Source: AGHT+IHWWKmhAUAD5QZyMIWCZm1PyBDKbfkAzPSqMi9p8Qt07R79gPO9Hc6qmLm5WdmO1UV6EXv2Eg==
X-Received: by 2002:a05:620a:9607:b0:7c7:a537:7ce2 with SMTP id af79cd13be357-7c7a5377ceemr231947385a.32.1744224814412;
        Wed, 09 Apr 2025 11:53:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a10ba65esm106413385a.28.2025.04.09.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:33 -0700 (PDT)
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
Subject: [RFC PATCH 05/29] lsm: replace the name field with a pointer to the lsm_id struct
Date: Wed,  9 Apr 2025 14:49:50 -0400
Message-ID: <20250409185019.238841-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12306; i=paul@paul-moore.com; h=from:subject; bh=suwgQBN2f+WUDLS5qxCVT1JfKZ1u9cWT9DOTBoIM33c=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGHCEiDm6qt+zIbiQXuhA+Nk1W29JbXEhzUY KE+ZHTqXQCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBhwAKCRDqIPLalzeJ c/TEEAC8Bpb96EjP7814bYL1nDv3LdIYXy3idkVr6RcbUuvqqAO7X8XTw7gTLJyg+J2tcfMndd+ 9KIvK0nsMBU7w4prrFU5W34e/CrIUS7bnLVVDiMMOO84D4ZWTbW5iPdCxYOAK2wAWm+hOCq1BTR 2TtMLBArrR1ZeVwyi3fXBnnASZdnEtS6yj9Cy8RymK21yx9uXjCp0EelagPG0acfS/M0++c/EfI AXxnYpyiNu2csojc1CApxp/DRSMPJ6EZOGFApz/ROloIsJFiJBbKPWzbFNu1GnX+yprbY/rn+JP OMnLu+oUdNfCxSlvcLRprG/3YWZ4UtV8g/bmsD4oJyUXrKU9YR1SzREM5ofiztEh6VMHlabQE1K c6wzsr6fmLg9CeTiHKRn1v3hri2oTMPfMehB9R93v1A1Ja66wBXpy2dQeo8mcMczJoZyn+xsJVK GtW0nTzhm6uRpkMjdQLn4uF+LcX3JanAJxAVhnZf83NwrzXx9bqofJUGUQyqTLB5UaW+Qe08FM3 hTC6tOnH4OaXS97Oz3GBhiJPG8iZegKnbY4rY6zP/Los9IrZAwQmquY+g4UJyShxJZ6IChvC0pc nxKGyn2KD4rwrvtvrIjYmXsBFw5ZfWxxJe/FpxCCAa2IPkYYu5vy5w6KC15Hrn6GzeggdWBSynM C2T3SoJZqTosa9w==
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
 security/lsm_init.c               | 43 ++++++++++++-------------------
 security/safesetid/lsm.c          |  2 +-
 security/selinux/hooks.c          |  2 +-
 security/smack/smack_lsm.c        |  2 +-
 security/tomoyo/tomoyo.c          |  2 +-
 security/yama/yama_lsm.c          |  2 +-
 16 files changed, 31 insertions(+), 42 deletions(-)

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
index f3e7ac513db3..55a4f08a2565 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1251,7 +1251,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
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
index 407429688f1b..d458a365b0d5 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -124,9 +124,10 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
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
 
@@ -154,7 +155,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 		set_enabled(lsm, false);
 		return;
 	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
+		init_debug("exclusive disabled: %s\n", lsm->id->name);
 		set_enabled(lsm, false);
 		return;
 	}
@@ -162,7 +163,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	/* Mark the LSM as enabled. */
 	set_enabled(lsm, true);
 	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->name);
+		init_debug("exclusive chosen:   %s\n", lsm->id->name);
 		exclusive = lsm;
 	}
 
@@ -194,9 +195,9 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	if (is_enabled(lsm)) {
 		int ret;
 
-		init_debug("initializing %s\n", lsm->name);
+		init_debug("initializing %s\n", lsm->id->name);
 		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 	}
 }
 
@@ -231,10 +232,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		for (major = __start_lsm_info; major < __end_lsm_info;
 		     major++) {
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
@@ -246,7 +247,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
 				found = true;
@@ -263,7 +264,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -280,7 +281,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			continue;
 		set_enabled(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->name);
+			   origin, lsm->id->name);
 	}
 
 	kfree(sep);
@@ -313,12 +314,12 @@ static void __init lsm_init_ordered(void)
 		if (is_enabled(early))
 			pr_cont("%s%s",
 				early == __start_early_lsm_info ? "" : ",",
-				early->name);
+				early->id->name);
 	}
 	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
 			pr_cont("%s%s",
-				lsm == ordered_lsms ? "" : ",", (*lsm)->name);
+				lsm == ordered_lsms ? "" : ",", (*lsm)->id->name);
 	}
 	pr_cont("\n");
 
@@ -426,18 +427,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -485,10 +474,10 @@ int __init security_init(void)
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
index e7a7dcab81db..f28a12a0a1c8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7562,7 +7562,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
-	.name = "selinux",
+	.id = &selinux_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..e09b33fed5f0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5282,7 +5282,7 @@ static __init int smack_init(void)
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
2.49.0


