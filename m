Return-Path: <linux-integrity+bounces-6826-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A3B2725F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA1F5E3E2B
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878828153D;
	Thu, 14 Aug 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G8/nlBIK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A257283128
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212060; cv=none; b=MAD94lZaGMGUR/cioDLJds0vPNk074F0nNXbuMGJhSYwQmPTUtQKaYcaQUYCd6T9elu24zVBXFZ4vJ5VIVEDDTbEsZKOYwq1dqMlCO+/ywKoj60neDob9nPB7KByjURoLngox295UBgXwbDiRN9u7WUHBaEzZTr5qOAr6P2P++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212060; c=relaxed/simple;
	bh=9PqBxRZ4BvmP/JbPYdnIW4bDh581Eu9ffq0X81PCcdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAQLBzYPY374I6YvGcDbC3VuLS6pcwVMMS9o3m7gCeJdUOhc4RdTCko/6+ZYLYAvNQcrFktt1HW1Q3t9x0HGhGkPtsX818GWSH2e1BSs33/6zayD+GEE6Y2c6NeLa++z8ABmkpO6lBdYqEdIpB3+vB5O1KMI9FiaECvwxeD69MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G8/nlBIK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87063d4a9so155744985a.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212056; x=1755816856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvW6ggk0NiCrXmi6d7puPCNLtTdCmim9VUzUok0ag0M=;
        b=G8/nlBIKZT8mLWCO/5cuxwF8YT6bzhQ4uX1rlMGPXCzQXTWJqnCqZxDtxTlj5a7C7e
         KZs5k1k1S0uEYyF0W5+qDvSG7bmMWoLHszKaAohO3XAbBmTEJQ4InoG1EB6G/3GEmxMC
         YJ3pYmOEpR5Zzk5mQUb/BSc5wqtXOz9M10aF74bp+cGDDm1aeaKKUorQr2QwTM9pdjEM
         dcghJXGGBU5AndwEtRNcKn3flNOZ+wmXV5dbSgskl+5xFIse+7m8BjCZB1srTAFdY+Cl
         qhybs4saotCseW/uqLm/XZwqi4BqRDfEzn2dv9G6qqpi/o0aHdX566TU/rSvBuxhWSAa
         9IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212056; x=1755816856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvW6ggk0NiCrXmi6d7puPCNLtTdCmim9VUzUok0ag0M=;
        b=JhD1LtchD/YqCvjMw6pBeWs6CqzAldhdkQ4ioiXHljUc5G3JAZcEP8VKyigj1iZbNa
         TrWnGobUENKx/0VCmeQL0sxGHNlQVzBaMfR88BFI5FRXZ6UciA0LXAQ63uiZhWr+iyTQ
         7jBG7+LAz2ngt5w872KQGH8WiafECdL+r8W429amZwH7bvjEqEOHmnSVJGjvepRmIhvf
         9M40eBIToJt1EJKAOQESfgSMj8ztY3mG7ov0zwmoevSBLAOorZqws6n/BRyJb2NKV7at
         D28S/eWX4VnQO+6R+e0/dtPdVO45BNCjx5Tqsl2hyGfgP5IqaHrjvAFx9FVAjj2kScQR
         UK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrcn4u26Hjtukcykys1fQKb2HooBlrL5u+wzrZ1dBWfMoTXwn4MG65T++dCq3lFrBJj1e++t7IXh7nvLVGCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoChhPBIv5TpM1Egk8oEZXDic2nSwVi2NrgEvTmWZi5mOewxrV
	L9EV4FBeB38lAJVPDj/m+dIVXW+Y+fpOT7BfmVRW4TQ+9UvDCIAh77cdBG0WFS2E/w==
X-Gm-Gg: ASbGnctekMb6p5HszbSW1Jh6iU6U/305/WaRtSFR09Dryr1tnf9l5y/r+kB6RR2JaHl
	ou8IVp0hmk597jaN7jnd/gY6+nctsiQF+rPV8fXGACNjtVUFrSPTWdqqs0QJ14VQVV3rpkd5tZy
	g5VS8bE56fXOCmbNSAAJNQoNzVuEIeXuEm1BtKq8MbJ0Fw7FmYfd3eoXQ/nxkthAblHxmWYislP
	flZ+dQ9Yl8PH10H+qiGdHMUiRHPyDnltsLyX8l4CpQQlgSokzGZ54Kxiqc3b/8YADdL8Gfrhh8A
	EE2vlHiIAyRCBwURiD1H6m21FI+A0EiQ3LWg7mCzjjYnr2cVZZPixIvTrlrLEgGviXadIEMdd3z
	QeHJWB3tvdHI9w8otntLu3i5tRynY4rfQVOgswiu0LE4Pd0lT/bFNKExzi0w2CrWpbOE=
X-Google-Smtp-Source: AGHT+IHRFngYK1xhjYhl4dd27zEOAR3SghPZJWhysiCTSYmxyNIP7v2FJsfBvOIclryoHjSinDPssg==
X-Received: by 2002:a05:6214:406:b0:707:55d3:9984 with SMTP id 6a1803df08f44-70ba4a475b0mr10731096d6.45.1755212056377;
        Thu, 14 Aug 2025 15:54:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ab37sm44028585a.8.2025.08.14.15.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:15 -0700 (PDT)
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
Subject: [PATCH v3 08/34] lsm: replace the name field with a pointer to the lsm_id struct
Date: Thu, 14 Aug 2025 18:50:17 -0400
Message-ID: <20250814225159.275901-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12424; i=paul@paul-moore.com; h=from:subject; bh=9PqBxRZ4BvmP/JbPYdnIW4bDh581Eu9ffq0X81PCcdI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmimOlFMT66hxMHi/ScAWNzANEVekaYJk/Y5r 3SQURQgmsyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5opgAKCRDqIPLalzeJ c1+tD/4zxnuTJ4K3yA3mnPU+BM1zsC8ItGMtqpk61rAtnrcw/ouLFC2dDf0jS0Pqvp9VllU3xXe hQNuBVcL/Wr5KJMIV3tUY1XBbQF6tQV1kdNMq6JMYn77WkJ9OoP1+6moeXJmgcb3P45L/n1NCIl Q/iW0KFkkjQLQzTQe9+vyroZeM1COgq+qx0NPSPp7si6gsQv/JoNKUBxbWmmOB8NlDwVt97czaH 0OuqvrikIbo95gopPxvBtvfE/h/YhHsXHbbIBukhnOvyWO1KBMGrrFavTTOZH8DY+IFvR+0HpFN qL9YJ9E1CfjQRaijKdfuhM0byboF2wUzkP4oW2D5YrnFqPxT+vNxaA0I6nTZ7OBBSQelIdovZqs ywiiQMCQ9nZjPfOfvZLXuc725f4mE2Quyv37ImFv6Ds7t6dXr8rN16OohWPBwGoSw/++13fuKR1 n9IzgYSHkueHjaGVVm/MTDRy63XXORdnjBEDPYEUglpA80acj3ItDx/vF2W02L4A0Si+09tE3wL YOdHcA+170xJ9Q8QWaF0+yvQENnD1ZQF6TpY1ccYdB1tzcRz8h1jU4H+WE/MwJXXijVt+Fmozg1 uBcDqYBDy1VqeCDaYTpjOtojF9cG5svoNyF8wyFLR3nvWNTolSxbF9fD6MuZlEiKjmZdNw9Cvo7 lgecuzN8dmqndDg==
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
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
index 0112926ed923..7343dd60b1d5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -152,7 +152,7 @@ enum lsm_order {
 };
 
 struct lsm_info {
-	const char *name;	/* Required. */
+	const struct lsm_id *id;
 	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8e1cc229b41b..45b3a304d525 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2552,7 +2552,7 @@ static int __init apparmor_init(void)
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
index 6bd4adeb4795..b50479bd0286 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1505,7 +1505,7 @@ static int __init capability_init(void)
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
index cdd225f65a62..eade8e1e3cb1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1279,7 +1279,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
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
index 4a108b03c23d..628f54790360 100644
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
 
@@ -200,9 +201,9 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	if (is_enabled(lsm)) {
 		int ret;
 
-		init_debug("initializing %s\n", lsm->name);
+		init_debug("initializing %s\n", lsm->id->name);
 		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 	}
 }
 
@@ -236,10 +237,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
@@ -251,7 +252,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
 				found = true;
@@ -268,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -285,7 +286,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			continue;
 		set_enabled(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->name);
+			   origin, lsm->id->name);
 	}
 
 	kfree(sep);
@@ -317,11 +318,13 @@ static void __init lsm_init_ordered(void)
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
 
@@ -432,18 +435,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -491,10 +482,10 @@ int __init security_init(void)
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
index 4da5e792b42e..d94b1ff316ba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7630,7 +7630,7 @@ void selinux_complete_init(void)
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


