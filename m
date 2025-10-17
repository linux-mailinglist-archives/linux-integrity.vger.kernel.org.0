Return-Path: <linux-integrity+bounces-7455-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC157BEBA61
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF1F24FF266
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318C354AD2;
	Fri, 17 Oct 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bNN/KMyG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CD354AD3
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732943; cv=none; b=AgGyL+vIXDkiCtf6T1GGJJwM8xwODQbLWm9FwR7M/pYxeDU2KxcDEgniLwgL2w/A3weap6pZ7qzuNP+FipHsUysgkk/A1V5l9lcDD6kvxrv0M3i/X1dwc0rG8U2EnLcvSvk3QMDn4jHgOqrN5aXHj/Flh4vCWUKA+lDLSX2MMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732943; c=relaxed/simple;
	bh=wJvBMeUu4esVQZzkRHpUCpYdj/0yZPW+h2I+7rFFzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUUXko84Azxb0QPpHWtC9LD6OfNjcY8cl5RGkktfZdEXOweU0NNH3yWDxkvikMRng9TgYCrZGTe4W4EfZh8tq4ulkSiaZeFzWKPaERMB2EK+yyAod6MVie9RbtQIFTu3ut9F3CMMHUaCq5qN2hbo46ONn2ZBvRoljEt5+qP8Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bNN/KMyG; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87d8fa51993so2646416d6.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732940; x=1761337740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmfQQB2dkTGs/JNOBGfYHOwKD6Yr4U7Ze9dL//nXEsE=;
        b=bNN/KMyGV3LogeoXuyK2B/9J5LAtq2uGZfGvGXvud01ICS+cqO9o7lIUOMhhsntB0q
         DPa0MWTv80/wNEspROeiYGigCSqYr/RCOeKp6bGQBkGebfp9Y5fQ3oKKy9Z5rPgYdQge
         +hRN4INzMyl+/8YrGvk53CiOhbDFhYlUb+903xXw8vkA99dh9S7x4quHh/5U8Rn5sQSz
         xvb+xW+bQwzMbkdQbte4b+BxrBJSbYZp0GZCN/jDQqypRUolibWX/iG6bL9GF1n3tqhl
         Iv8RUe8ht15PTHyxqmMhEwXXGbo/rHxmard841eEqKvngms0KMCu78a5IdNXkNGT0GFb
         8cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732940; x=1761337740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmfQQB2dkTGs/JNOBGfYHOwKD6Yr4U7Ze9dL//nXEsE=;
        b=dykVChfq8NckVEXfqwPEPmlFrZ1F0XtCKypgh4Ctr6lpNLUPlmVrHpAuP+LS3WMbaI
         XGP+DlriYjeHBfOaeQQF42G29vfO4qsHNZWQk/D/hM5cuPktYKySOV/UvlXHrAbwA3w/
         jy5yaOlzKD17rycrHs6BKTuTYN3n1pfo9KNrsDIKTQu4YAHAwpdiB6GyWV4hRn24YaMP
         k6/F5zuhyxMWQJgpcaxuGP5CzMTuMwrfLneS/URib+prS49bVVvhGabZtfFdiugsfFar
         UGiiEYeFnrwvrRfvrBw9yfnslweHlzDkfkhQsANDoOHlglLc4Ui+8s6iH/QGG1RlRA2K
         GEZA==
X-Forwarded-Encrypted: i=1; AJvYcCWwucSW5i1yF7xPZ2mYP25kT41lmwl3p/mpj7GTWBrF2HM2/kYL2F4528SxVSZ3O+g7xLXuhuFQShjc3DQ6/Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVwLpcwD1GCCAjwtAKrYys0jqxbGcw9+7ZUhVmp46ID0H9W5j
	Rmr8hMid5tHGw0CE/plhB6YVF29oqbsD9RrvgP4WEvR4QfhZ1nHE03zt3a4sYKtBxA==
X-Gm-Gg: ASbGncsmCKBxYqLAlEUDe5S7/TY7hxT26bLEz8O4/1888kfLE6m8AztjWdbvAy0tOed
	y+b6j5lKuF1hznOFPu3dOu0Wya97AwNKsvkNcR19ahly82XbGUktxmuF7GPC0TV1FHrD0vp6mMj
	40WNiYg1TMVFCIsiigawV/y+Q/pE2D5giOfp+SzOxOksrMxodJ4eGZCtVCHAM8Cl45EcwmZLL+h
	JnR82HDp/+fWYOO1beg5Q0ggxxBE0/Ed5Q49ORR6koaRZTt6Y9omKBDSB8N8/wBsNS7mZzKUY4c
	8icBZjytwpAoNUBK5VLNuqxUThJu0Uccn83X3sIPG/EMw4JMEVs7EHTj2ZbEnOh2gC3WwlnpJqN
	XnYFhukYHYroyJI37od3JzmgCcavmSGZ+g45Tbni5AXs2bVPUEnCR1FuURcmI7UcqQ33js07JFz
	VsCsiYeUzPNpOPCSyx/fhgli4qfF4mxdxad8ePPqlMswj/ptJoT213UM4x
X-Google-Smtp-Source: AGHT+IGFb8gX8RTvJqzHJm4J8kpKKpHi4SP5xxGYXwJsucUdypTYcAtyFyrmUiDN9Xl3fXXnAJtdbA==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr78290786d6.55.1760732939697;
        Fri, 17 Oct 2025 13:28:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028afad8sm4780396d6.45.2025.10.17.13.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:58 -0700 (PDT)
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
Subject: [PATCH v5 08/34] lsm: replace the name field with a pointer to the lsm_id struct
Date: Fri, 17 Oct 2025 16:24:36 -0400
Message-ID: <20251017202456.484010-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12477; i=paul@paul-moore.com; h=from:subject; bh=wJvBMeUu4esVQZzkRHpUCpYdj/0yZPW+h2I+7rFFzTQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYvwmFVB2C7ubu/PuLDmMRxCjUx/QFgQFNnX LCG660pugqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmLwAKCRDqIPLalzeJ c6vHEACNvpZKxFmpaIxsRk676oqnyi/GE/ELcAYTGXxq8BjcdWbl92VHOOabaaXC7q9Fc6c/vSA 7hG54ZBEJX9lZFsUSF8oF9ZHnKkOvdhKKsHQM9nRLdnXeSRXtyvlL7mpEhqRLSb9oLlS3YRhDtl oNxhHJkpGI/R4i31mDJFfrgywpgUXgW0OMiHKdm5SY6c9nDEemwC552O5H7TfGs2GTxB45944nN Djg/sSJfd3OeFnVOL8vw+f8+5FC7VOddz4j14nWrDYoW4YVyC5Du9tHeMO0uDnSYbNxgnZk39Gp y1LPHOmp+DlPcbIyG/HcXd/lg5yOclTaFdDRigrKn8VGLXu2Uwk+1Fxfgm00KpLK9Sv29CXxx/7 p7nMWLFS3onUnDTH9BLO33lYf5xrt2Rx+yPnX0//NG63clwp+QMzbv8i8uE99sxdTV9NnUxRVBS y/BtMRzI/4sWP6QXf/JP/fv2Pa/r8EnsUpMACvG0tPC/i/LVXNXpuGtj1qFFk/GCT7UChbpjVeC KWxvY2+qVDjqj4H34oqC1+2nlBE3D7ocIeDR+RRMJQBxhcm3cu2z+k1DTQxaqzzrge5ePOL3fgh z1Hc3t3nVL2TFpZtn9tz1MQ3pqJCvCAd9YVMKFsh0fpbeEUh43LHyy54mCZlqTnTwKlYJro/wlf RykuYQ+JsXEtsvQ==
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
index b3f7a3258a2c..f6798144234b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2555,7 +2555,7 @@ static int __init apparmor_init(void)
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
index 9249d5f37ae9..692d61a2ea10 100644
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
index dfc22da42f30..299b656ac007 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7639,7 +7639,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
-	.name = "selinux",
+	.id = &selinux_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index af986587841d..392698e41120 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5280,7 +5280,7 @@ static __init int smack_init(void)
  * all processes and objects when they are created.
  */
 DEFINE_LSM(smack) = {
-	.name = "smack",
+	.id = &smack_lsmid,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 48fc59d38ab2..cb003c460dc2 100644
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
2.51.1.dirty


