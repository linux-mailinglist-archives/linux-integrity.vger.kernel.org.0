Return-Path: <linux-integrity+bounces-7113-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCDB7D4AE
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE216F0B5
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF529A9E9;
	Tue, 16 Sep 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XdwVLxb+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3329BD9C
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060832; cv=none; b=V1dgXyswWlbecnVxRe91e2KrlGrgtJ7Byae360VaGsnW3k9/B5vlFYx+t1shBIkunwcdeLN3sML6G3Nb2MZXoWPs2ENuedjryFsySTyn2kBNrMzjWMje2hJLY8GpBFpFFpwiJlijpA/yoQ2okacRqGS7z83t9CRKpJTgocRTVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060832; c=relaxed/simple;
	bh=7td9VFjLuLiu2zFk0rJ7yO/mU9jd19mEVKP5Uv+ba1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpWOQ9ludJEY/s6Uq74EGqmaBtPOcH0QzUkEfxF0lj90qSSxmb/jsxe0n94CpQ0uxX8g/oAUnlyvPxZh2c+m98NeoKKwnTfgBa1O6EgJ0erHsvhHMxS5VJWcVqkfcsJ4U3MmLD8jkywNcQ65/QlkxTs/uWAbtyeP66OFLHeZkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XdwVLxb+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5e88d9994so58861531cf.1
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060829; x=1758665629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crtBq7rII22ilv5B6nIHR2yo5U+CH88w/Yg43w/3X8s=;
        b=XdwVLxb+6+/pRKfDdTpx1Q+NPt0H7M9bwHiXjQOQantptLERAgMn+onJokJxYaizYK
         CPlGLw6M6dNCjgWGPd+bsvoz2Pdffyjy/XaTIE0N5nHmQMXmQITu2fYlmM5yLbnfch35
         iNvMDfuJFAxGNVlfaBvFRv279O9gLlNXZCUWgZp5GORz5IGPEmd7gBX8XUMMTzGmZ2Ne
         gIzdizpGZO6XHr4WJ6v7I4sMxX3f1wn3BvXuOvvFTqkpZtC5a5+ubB9G74TG1ZWmqCGy
         E2hUo8wDddGbJv/xMOw+sPeazHee+a9zUjMQJfibXW7rlosAiJN9zNxAATSPrOzF+Sne
         ocJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060829; x=1758665629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crtBq7rII22ilv5B6nIHR2yo5U+CH88w/Yg43w/3X8s=;
        b=ptzMQl5Zd+1kHPu8bSgQcS4uPIQGelvaIAQqy7qrH77MGbloPtjMF6OkQX9aZr8unl
         1ym6hFTuynCmCXbU3M+Z9JyZZhl2nholy8UR/OoXGjshhg1oTYrQdkdmoacq2nhq9e3V
         DdoPP8xWyABoM8I0gTXx+f9w47/zAR7mWZXkyZv7EIJ/PPofoej+NRLQuAyCOGcQw2tf
         UkKSRXb3cNJb03l69TSXRvlQoZJsrqFdIs9ql2rGBaM2EV/0BhHRMOUWrK9z+yDZ2DV7
         wniooz/GrqY5MR5MEI9lst/dqABTRX/3FC2Mj095sRN2HCcJoo0kdys2kKN7Zb5p+8tx
         wNjg==
X-Forwarded-Encrypted: i=1; AJvYcCU43iC+YxmPOgQSmyPr0BHXP+4R7pH+FUYCUut9wUb5M5zkG7yVt+AZMlv6E9TnSVJXy06x0LsXTHJO5W9gTV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTMFrZhjtILAZdsGBVUfBuqAV69uEQSx4NStUoeHbcx9sZZJr
	HDEfUM4SRGf6Idr27OYJrjXjZFDe6SabdDD1v6tu5UE2mnYZYTf+67gs+uurMafRjg==
X-Gm-Gg: ASbGncvxxuom+EQBD+Kiks9pUrH3UFFSCOgwA8kASNFb2QckcvmxjaLtPOl9MQzpCFo
	36cKYw/IPBxpZ/04jnIt3hxXntbLJ2SJcfNORudivJ0g39kPZ4MqomZ6D/gIJx8lwJ5r47WBorw
	ktRMM8gt5axh45TCIQGt1GlwfLsFTmhyxKvPPEzFg2me0yy7JpSbAiU8uE3Whwd0a9g4iTOH03c
	6te10nG5a4kr3vG2wjIpr9z6tMjf978OD5ghzmYQMEj4+DLTLnLD+jRPpseZdhFbNSBhESG8m8T
	logWobweU1560ZYhFIGlISaBXBa4UeD9GQOiN7GdYGyzySbEB/pnU05aYQTVYw6bTp8tox9Ej5g
	A8QdeMcxkZg9RqkhNqiMQ6r0SwUuNsJynF8Tcx1pIdFEnQNIe4uT1TqXFLqna4/sF5PoQ9Sq6+k
	x0n0s=
X-Google-Smtp-Source: AGHT+IENXqmncI665MhonGqpfSGNLIw67m/eeRXDP2g64wbiTnPudEHa4k8q1yBN6QbgCNnzrUqFAA==
X-Received: by 2002:a05:622a:5c8c:b0:4b5:e808:c5ee with SMTP id d75a77b69052e-4ba6c1e7cdemr1020221cf.58.1758060829559;
        Tue, 16 Sep 2025 15:13:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639decd84sm90575701cf.50.2025.09.16.15.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:48 -0700 (PDT)
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
Subject: [PATCH v4 08/34] lsm: replace the name field with a pointer to the lsm_id struct
Date: Tue, 16 Sep 2025 18:03:35 -0400
Message-ID: <20250916220355.252592-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12424; i=paul@paul-moore.com; h=from:subject; bh=7td9VFjLuLiu2zFk0rJ7yO/mU9jd19mEVKP5Uv+ba1Q=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7iIzSOb6iXeqT26isVy3TnRZAQCSuOpGM7V JoDYRLqbLiJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne4gAKCRDqIPLalzeJ c83UD/4hgO9iDg1fK+3cNXiqpoOK4Nx6yS4SudkSjQ59Y/08tMUCJkNRC6SRcTXwu3QWhTM/FA8 cRCZzR+0nCcL0G5VVMbb/9joAha7bSkpaeMJvsxJ+iVAuDSguwHXbcTsOYCnPGYom4/0/5MR3v3 k6V/mSgKJtBB7bM3+U0dUZIsOMXFtDDDSu62A+iGSbwD/3Sj3SeUi2X6YKDux817ekdznZfideY rDlsu03IpdE97J9/e3mCiwtcxV+Mlj41fa+SRp6tu/DGJmEmpd/3jk73vMy3Ra/ChjYI/Lz4sfS 8rOpDLPN+78HdXel0+aLiinVn1DtNEWk6uarDZePXdwp9sQ03Tw6ahv+8UZnKMsnLdwKPf2tyQT tek7iOQkp5dC7+X0Qa6FbTLkHO0/pOqWSIQFNDtzbHtrTbVuOyv3reDYh2vVwrxAdmKQuTFCbUJ Vw2Tq7A+fhojzMQ4ds9xn6G+3klrlzwxf6ZXvEyeWBsci2zjmSreR2jjCszVu0WgMCw3PGlGSY6 GCz6RmwZwuXg2gTVEaZRdTX8GqDD/pFVpT3YgfSGE3ys8bFn53oi2Msmzub/cfQa7Ot01aRhHr9 uH7Y6Z07nomdZZSLzVbRG4MgzaILjvz1Ljkx6LC6dErt0ML5Qcm7p8LBFlUX70R+JoPVeNnV0KX WhkQbBv3RCN7VRA==
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
2.51.0


