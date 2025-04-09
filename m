Return-Path: <linux-integrity+bounces-5724-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4188A82FBA
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675E83B9FAC
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE227817E;
	Wed,  9 Apr 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bgyjikM+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1B27CB0D
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224840; cv=none; b=Tx1o01CaFQdUS74m+xic+dtSAOM0ij4DKapbE3bEyjsnUP/Y2ntxzeZr+XrIpfj6VeuKFXau+FAT++sM2tUvge4qGJ+IKCEgCfdt/ITrI2BF6OJAJt+c/Fh5neX/V/4Fh1n4JLo7527Byb/2StjB5JCYCzSQs0vS9LBK4eD19Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224840; c=relaxed/simple;
	bh=sA9hFu6yxQ2fxu1Aay8jzwhRLhp2Y5W1l64str1QuyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juxzVeJ+R6oG46Ze7M89pRhe7yVFxsRUogefvnw3iUIJcuAeNp8b18N0LkGxfmL+rg9SaqUBshxLywjN2jvANEBi5zExiAwJWkrQg+R4HmSyonP30U0FpLi4Nw2K7uXbKMzuzwPkuPoBBdHdKoeMTo8EAo4TYcHjafQisSbL+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bgyjikM+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5a88b34a6so943085a.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224836; x=1744829636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KR59u0DidL2Cq6sqSkjIG2B+LoZiP5bmcIUOEIwRHY=;
        b=bgyjikM+OFLpE0YMQHFfu9QNy6oJeOBYGupE/r/53iq8Oeuc4Bzjk0A1cu/H2m5IrV
         4qu43tGhzcRyV1xX0zBmg7QxsrUXyAy1rQ4j5P7PoK+chyH+gegLmjd7snziF1XhMVCq
         hGP/FZ4/B8SHFSs+0+LbUsqHeNooPekHJyjxI/Zw0NAhGLii7X+CtBurJ8iNESQWsG74
         72O+XKc+UVEiTmlS4xHmUwozctVgygmS/OsQ8DKen5XmEPeWbHNxqqvnmgaIz3C5byph
         9xcUbwn04MZGT1mrhHIn9FEXRvdyUdjwYB/szI1tIAX81h8rq7mX51UdIRwpyklRywl6
         Dr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224836; x=1744829636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KR59u0DidL2Cq6sqSkjIG2B+LoZiP5bmcIUOEIwRHY=;
        b=JsvWUVtsLUhH90JU0vROfUeqlaokq+l7p09dpBC9LxYzO8iEmOZoqgAvsm16acD/WX
         w7GV+3jjslxaGiwxAPCtz0aLXlWQJUTphgVXR4LFqmgXO7gpZEz/Rh4JYNmdri3T+TaZ
         6IRasMAhVqzOFlrXhmoFtVUW99T6XUJGCtPVecyfSfokk/CQJkIlO0McgWSPtw8m8sZf
         8Z5Si3N0FYEbCQP/qUSVmvBO/hZwyCgUWxZNfrGjarkne8LNnwdWuC8OYkY1sNS7Jaca
         oujTX10lCKrKXlBKpDMoU2I9+HerneBaIBha3A+Suug8U28xC4kvShZvVtL+BEWUIu9b
         +XbA==
X-Forwarded-Encrypted: i=1; AJvYcCWXSAs5HXyaCusznK2U+oduZtXW/kTiBSZ8lGZZB+LVWdBWyeRVyqUNR3woNBrfg7WpQrfZwRdCLjTozF0MZYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoVXyUTzElUqcUTz6IuMrX7g7PHvVl7EJulITtKBNFRMRwPLj
	eCdjC2Aoeg9ULgapAPpCjuUmkh889cJdqm1jbWdAfLv/5jMr6GDVmh6NZA3niQ==
X-Gm-Gg: ASbGncvx19lradye/ESPhPGXyiv5n/58FctQW+nqAGYPtDI93zWhhDkBQzb9HmIW0CA
	Z6cANpJ1bqAYrdEhB6q/ROVUjs5/VkPU41dE0BiZwJX3vu7RWGRYA+clBYUD5hqyfAGMyuLCLH9
	s8eywWfAuO9eONEgAHfqCUo6+7kN4baPRW5R+D4gCBAjrvV9bbVRMaWFZWz6rK1HHcSSqfD/80r
	hNonOxgoUIjOxSxOFxcyLrCoNdgT8IxiAm6+//DrT9x2BKCLL4D2cSUto4tdoQHvzyYOI8peuan
	Lejg5ocHxHMjVPIGZKY59VBF3voZgIScozDTsmM08UQz8XgJCXKx04sUThfbcHwHK7IJ4VaXZj0
	j7EPVRe2HXg==
X-Google-Smtp-Source: AGHT+IEmXwh8PMSvwNhNQdoQ5rDpIlhn0mK3qwkmY7f14ZzwIUqabp/1BQUBWzRJalPwMdRa9xnctA==
X-Received: by 2002:a05:620a:19a7:b0:7c5:5d4b:e63c with SMTP id af79cd13be357-7c79dea5a60mr531660085a.47.1744224836571;
        Wed, 09 Apr 2025 11:53:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a11e69edsm105421785a.91.2025.04.09.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:56 -0700 (PDT)
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
Subject: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support among LSMs
Date: Wed,  9 Apr 2025 14:50:14 -0400
Message-ID: <20250409185019.238841-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9758; i=paul@paul-moore.com; h=from:subject; bh=sA9hFu6yxQ2fxu1Aay8jzwhRLhp2Y5W1l64str1QuyU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sIcbMe8gohBFeR3748PsPRVkHOc/35km4sRr I+9MXZ3tJKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCHAAKCRDqIPLalzeJ c4/uD/48/3OekZ3eSzC6s+GQ38Lz8gFwBEBQXwZfWDx4Z1h9kquTi1sintb3X0IFq1CfzBBqFA6 y6eseRq9oGNJonBBx00VC2bzZZuRFX7Rg10xgqa8e0uJHZkkfkbhrfqdOyBJ8lp22q6SGlgPqAc XPs/4Xs06gaAr7X4exV5MlPZpCcF8s9Clut0U7AnKlvto8kveg7GqZGwzIuFS6PKbVR5sYcZeDM T1UCg2UFX9D2+3uE2Jw5oYiJzDZn2xADu/qUjM1PX1+qLR+uBAT78IrcQtPOTWAzOZRvwuASHXI rzTBhjBnAxsNVDbDRXjLLZdeB80DNvgPfzqR0Yat8NsV4XJw5RR8Adl2Eh0iFM8u01HM6peWT+3 PXp96C3U8l1CJ1QjSbKdm457X7WRLuG+eUi+TNjB2rMaqLx7m9zitKws6JlPEowEHfjeLyPsfx1 TNFGHId3NEb0RVu0Q3/M7W+D5mbht/dyssffxWW0cloE1QGx5YSe/Eu/theLopGUSjDpN6SXeGd 6JAFzEuI6HMP5j7AUaEuCZlcKlRuAkcyk1yGjOktAje7rDWt83sJaonWtxbDa0VznMe4LjqTU52 2bq33T5mdM9+u4ivtA194VQYHulJvdLbgDn1edrR1fA+ZVfOYk9wcgwVLhRleuX2Yri/H19wySv hd0P0WTYrfaDJEw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
count the number of lsm_prop entries for subjects and objects across all
of the enabled LSMs.  Future patches will use this to continue the
conversion towards the lsm_prop struct.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h         | 6 ++++++
 security/apparmor/lsm.c           | 1 +
 security/bpf/hooks.c              | 1 +
 security/commoncap.c              | 1 +
 security/integrity/evm/evm_main.c | 1 +
 security/integrity/ima/ima_main.c | 1 +
 security/ipe/ipe.c                | 1 +
 security/landlock/setup.c         | 1 +
 security/loadpin/loadpin.c        | 1 +
 security/lockdown/lockdown.c      | 1 +
 security/lsm.h                    | 4 ++++
 security/lsm_init.c               | 6 ++++++
 security/safesetid/lsm.c          | 1 +
 security/security.c               | 3 +++
 security/selinux/hooks.c          | 1 +
 security/smack/smack_lsm.c        | 1 +
 security/tomoyo/tomoyo.c          | 1 +
 security/yama/yama_lsm.c          | 1 +
 18 files changed, 33 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0d2c2a017ffc..5bc144c5f685 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -71,16 +71,22 @@ struct lsm_static_calls_table {
 	#undef LSM_HOOK
 } __packed __randomize_layout;
 
+#define LSM_ID_FLG_NONE			0x00000000
+#define LSM_ID_FLG_PROP_SUBJ		0x00000001
+#define LSM_ID_FLG_PROP_OBJ		0x00000002
+
 /**
  * struct lsm_id - Identify a Linux Security Module.
  * @lsm: name of the LSM, must be approved by the LSM maintainers
  * @id: LSM ID number from uapi/linux/lsm.h
+ * @flags: LSM flags, see LSM_ID_FLG_XXX
  *
  * Contains the information that identifies the LSM.
  */
 struct lsm_id {
 	const char *name;
 	u64 id;
+	u32 flags;
 };
 
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2fefaab6349f..db8592bed189 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1428,6 +1428,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 static const struct lsm_id apparmor_lsmid = {
 	.name = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.flags = LSM_ID_FLG_PROP_SUBJ,
 };
 
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..c72df6ff69f7 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 static const struct lsm_id bpf_lsmid = {
 	.name = "bpf",
 	.id = LSM_ID_BPF,
+	.flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/commoncap.c b/security/commoncap.c
index e04aa4f50eaf..fab692104c87 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1479,6 +1479,7 @@ int cap_mmap_addr(unsigned long addr)
 static const struct lsm_id capability_lsmid = {
 	.name = "capability",
 	.id = LSM_ID_CAPABILITY,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static struct security_hook_list capability_hooks[] __ro_after_init = {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 770d0411da2b..b3a3324f48b1 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1162,6 +1162,7 @@ static struct security_hook_list evm_hooks[] __ro_after_init = {
 static const struct lsm_id evm_lsmid = {
 	.name = "evm",
 	.id = LSM_ID_EVM,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static int __init init_evm_lsm(void)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1687badafb48..d98e7815175b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1237,6 +1237,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 static const struct lsm_id ima_lsmid = {
 	.name = "ima",
 	.id = LSM_ID_IMA,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static int __init init_ima_lsm(void)
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 71644748ed56..7d9cdbc3d23a 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -24,6 +24,7 @@ static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
 static const struct lsm_id ipe_lsmid = {
 	.name = "ipe",
 	.id = LSM_ID_IPE,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 struct ipe_superblock *ipe_sb(const struct super_block *sb)
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 47dac1736f10..5c8d5693c4c7 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -25,6 +25,7 @@ bool landlock_initialized __ro_after_init = false;
 const struct lsm_id landlock_lsmid = {
 	.name = LANDLOCK_NAME,
 	.id = LSM_ID_LANDLOCK,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 273ffbd6defe..05a842c36fd8 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -211,6 +211,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 static const struct lsm_id loadpin_lsmid = {
 	.name = "loadpin",
 	.id = LSM_ID_LOADPIN,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static struct security_hook_list loadpin_hooks[] __ro_after_init = {
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8d46886d2cca..a2396b67bfe4 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -79,6 +79,7 @@ static struct security_hook_list lockdown_hooks[] __ro_after_init = {
 static const struct lsm_id lockdown_lsmid = {
 	.name = "lockdown",
 	.id = LSM_ID_LOCKDOWN,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static int __init lockdown_lsm_init(void)
diff --git a/security/lsm.h b/security/lsm.h
index c432dc0c5e30..d1d54540da98 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -24,6 +24,10 @@ extern bool lsm_debug;
 extern unsigned int lsm_count;
 extern const struct lsm_id *lsm_idlist[];
 
+/* LSM property configuration */
+extern unsigned int lsm_count_prop_subj;
+extern unsigned int lsm_count_prop_obj;
+
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
 
diff --git a/security/lsm_init.c b/security/lsm_init.c
index cad6d243a2a6..c2ef4db055db 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) "LSM: " fmt
 
 #include <linux/init.h>
+#include <linux/lsm_count.h>
 #include <linux/lsm_hooks.h>
 
 #include "lsm.h"
@@ -189,6 +190,11 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_count] = lsm;
 	lsm_idlist[lsm_count++] = lsm->id;
 
+	if (lsm->id->flags & LSM_ID_FLG_PROP_SUBJ)
+		lsm_count_prop_subj++;
+	if (lsm->id->flags & LSM_ID_FLG_PROP_OBJ)
+		lsm_count_prop_obj++;
+
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index d5fb949050dd..ac25674376fe 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -265,6 +265,7 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 static const struct lsm_id safesetid_lsmid = {
 	.name = "safesetid",
 	.id = LSM_ID_SAFESETID,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static struct security_hook_list safesetid_security_hooks[] = {
diff --git a/security/security.c b/security/security.c
index cbd544d71093..2b9dde02f4de 100644
--- a/security/security.c
+++ b/security/security.c
@@ -78,6 +78,9 @@ bool lsm_debug __ro_after_init;
 unsigned int lsm_count __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
+unsigned int lsm_count_prop_subj __ro_after_init;
+unsigned int lsm_count_prop_obj __ro_after_init;
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 95b2399b1f4d..1dc4b3987af4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7200,6 +7200,7 @@ static int selinux_uring_allowed(void)
 static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
+	.flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 80b129a0c92c..d04667a42f91 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5042,6 +5042,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
+	.flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a015cf0c4a00..0a030cbdf424 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -547,6 +547,7 @@ static void tomoyo_task_free(struct task_struct *task)
 static const struct lsm_id tomoyo_lsmid = {
 	.name = "tomoyo",
 	.id = LSM_ID_TOMOYO,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 /* tomoyo_hooks is used for registering TOMOYO. */
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 38b21ee0c560..e4a6cf663177 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -419,6 +419,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 static const struct lsm_id yama_lsmid = {
 	.name = "yama",
 	.id = LSM_ID_YAMA,
+	.flags = LSM_ID_FLG_NONE,
 };
 
 static struct security_hook_list yama_hooks[] __ro_after_init = {
-- 
2.49.0


