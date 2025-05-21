Return-Path: <linux-integrity+bounces-6278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8EABF71C
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D5A189076B
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4918B492;
	Wed, 21 May 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="e9de/etJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADAA18B47C;
	Wed, 21 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836367; cv=none; b=utFEi75+w0gSumZpcZNfH2TYesuHiMnsB+/7EbFiGSU9RVb3lsVY5b9hARRnPtcMbCZfJem4W4Whg/3jsFe8kwe/Y021+f4kWGQ5ouTQ9gDeVzkMpdrRQJss9XQQDSyD84FWRPPBWLHHDVuhrsANIa5GRyTNTQF6gAsK9lrc6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836367; c=relaxed/simple;
	bh=kL5cVHptdGb+5fVliCoyBw46zJOfg3Dvr/iOiLu28KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKopQXrfNNDnmqwdKyEYMO8qOGUMXaKgYqhj58viUXk4nO+LmmCD+LB/J7danjgsVBLLYgiixFcoJ3WEpkrSC0R9I+7QsowsrtF67vIp1Y/XKm+CNhfeASz6/1m4CuazXHg8L8sEwsJ5LRKvo6ccyS+sZr7lLwiNOM/Ohygpa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=e9de/etJ; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 7B4351087A42;
	Wed, 21 May 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836107;
	bh=kL5cVHptdGb+5fVliCoyBw46zJOfg3Dvr/iOiLu28KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9de/etJN+1tS8YxLZ1BhGg2cZEL6TKSn44nHP4nbqOHVHh8WkXBtabVg14MlcaHO
	 8msZha7KS2jY2p5+rPaBa9SVTA3d6SrpswGZ2O5DpBiU54EXYgT8xnzYnK4IDbgQuJ
	 jG1qiCZQcUDkftQIdS6XZ3jDtrkZF4VuBvEgnLCFsOJQlfou8k/R5qzPLinUUSI1SS
	 z7HX5fZNZW+aUB8T+tmd8STOPwwAMi7+8gwTwG1iyvHYH9GOn6avgsGPLTjAjtBb1w
	 LzP02TYdi/mdu3cUHHdqQLGRUZTJ1LDxm06pfZsKgTZgc00yeo8pwJq0XhbRVexgSE
	 bk4XGPf2OXvAg==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 3/9] Loadpol LSM: filter kernel module request according to the policy
Date: Wed, 21 May 2025 16:01:07 +0200
Message-ID: <20250521140121.591482-4-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kernel module is loaded, the LSM accepts or rejects the demand
according to its policy.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 security/loadpol/Makefile         |  2 +-
 security/loadpol/loadpol.c        | 22 ++++++++++++
 security/loadpol/loadpol.h        | 27 ++++++++++++++
 security/loadpol/loadpol_policy.c | 59 +++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 security/loadpol/loadpol_policy.c

diff --git a/security/loadpol/Makefile b/security/loadpol/Makefile
index a794c8cfbfee..062215e1f831 100644
--- a/security/loadpol/Makefile
+++ b/security/loadpol/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o
+obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o loadpol_policy.o
diff --git a/security/loadpol/loadpol.c b/security/loadpol/loadpol.c
index 3fc29263e2f8..4d1a495a1462 100644
--- a/security/loadpol/loadpol.c
+++ b/security/loadpol/loadpol.c
@@ -6,6 +6,15 @@
 
 #include "loadpol.h"
 
+// default policy: allow all modules
+static struct loadpol_policy_entry default_policy_entries[] __ro_after_init = {
+	{
+		.origin = (ORIGIN_KERNEL | ORIGIN_USERSPACE),
+		.action = ACTION_ALLOW,
+		.module_name = NULL,
+	},
+};
+
 static int __init loadpol_init(void);
 
 static const struct lsm_id loadpol_lsmid = {
@@ -14,6 +23,7 @@ static const struct lsm_id loadpol_lsmid = {
 };
 
 static struct security_hook_list loadpol_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(kernel_module_load, loadpol_kernel_module_load),
 };
 
 DEFINE_LSM(LOADPOL_NAME) = {
@@ -23,6 +33,18 @@ DEFINE_LSM(LOADPOL_NAME) = {
 
 static int __init loadpol_init(void)
 {
+	for (int i = 0; i < ARRAY_SIZE(default_policy_entries); i++) {
+		struct loadpol_policy_entry *entry = kmemdup(
+			&default_policy_entries[i],
+			sizeof(struct loadpol_policy_entry),
+			GFP_KERNEL
+		);
+		if (!entry)
+			return -ENOMEM;
+
+		list_add_tail(&entry->list, loadpol_policy);
+	}
+
 	security_add_hooks(loadpol_hooks, ARRAY_SIZE(loadpol_hooks), &loadpol_lsmid);
 	pr_info("Loadpol started.\n");
 	return 0;
diff --git a/security/loadpol/loadpol.h b/security/loadpol/loadpol.h
index 5e11474191f0..a81d52f6d4da 100644
--- a/security/loadpol/loadpol.h
+++ b/security/loadpol/loadpol.h
@@ -3,6 +3,33 @@
 #ifndef _SECURITY_LOADPOL_LOADPOL_H
 #define _SECURITY_LOADPOL_LOADPOL_H
 
+#include "linux/list.h"
+
 #define LOADPOL_NAME "loadpol"
 
+enum policy_entry_origin {
+	ORIGIN_KERNEL = 1 << 0,
+	ORIGIN_USERSPACE = 1 << 1,
+};
+
+enum __packed policy_entry_action {
+	ACTION_UNDEFINED,
+	ACTION_ALLOW,
+	ACTION_DENY
+};
+
+struct loadpol_policy_entry {
+	struct list_head list;
+	// bitfield of policy_entry_origin
+	u8 origin;
+	enum policy_entry_action action;
+	// when NULL, the policy apply to every module
+	char *module_name;
+};
+
+extern struct list_head __rcu *loadpol_policy;
+
+// evaluate if a kernel module called 'kmod' is allowed to be loaded in the kernel
+int loadpol_kernel_module_load(const char *kmod);
+
 #endif /* _SECURITY_LOADPOL_LOADPOL_H */
diff --git a/security/loadpol/loadpol_policy.c b/security/loadpol/loadpol_policy.c
new file mode 100644
index 000000000000..6ba5ab600e3e
--- /dev/null
+++ b/security/loadpol/loadpol_policy.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "linux/rculist.h"
+#include <linux/sched.h>
+#include <linux/sysctl.h>
+#include <linux/parser.h>
+
+#include "loadpol.h"
+
+/*  use A/B policy entries: switch from one to the next every time the policy get overwritten */
+static LIST_HEAD(loadpol_policy_a);
+static LIST_HEAD(loadpol_policy_b);
+struct list_head __rcu *loadpol_policy = (struct list_head __rcu *)(&loadpol_policy_a);
+
+int loadpol_kernel_module_load(const char *kmod)
+{
+	struct task_struct *parent_task;
+	struct loadpol_policy_entry *entry;
+	struct list_head *policy_list_tmp;
+	enum policy_entry_origin orig = ORIGIN_USERSPACE;
+	bool allowed = false;
+
+	rcu_read_lock();
+	parent_task = rcu_dereference(current->parent);
+	/* the parent of the current task is a workqueue -> the request comes from the kernel */
+	if (parent_task && (parent_task->flags & PF_WQ_WORKER))
+		orig = ORIGIN_KERNEL;
+	rcu_read_unlock();
+
+	pr_debug("Loadpol: trying to load '%s' (asked by %s)",
+		 kmod,
+		 orig == ORIGIN_KERNEL ? "kernel" : "userspace");
+
+	rcu_read_lock();
+	policy_list_tmp = rcu_dereference(loadpol_policy);
+	list_for_each_entry_rcu(entry, policy_list_tmp, list) {
+		/* the requestor does not match */
+		if ((orig & entry->origin) == 0)
+			continue;
+
+		allowed = entry->action == ACTION_ALLOW;
+
+		if (!entry->module_name)
+			goto unlock_and_exit;
+
+		if (entry->module_name && match_wildcard(entry->module_name, kmod))
+			goto unlock_and_exit;
+	}
+
+	/* No match -> reject the demand */
+	allowed = false;
+
+unlock_and_exit:
+	rcu_read_unlock();
+
+	pr_debug("Loadpol: load of module '%s' %s", kmod, allowed ? "allowed" : "blocked");
+
+	return allowed ? 0 : -EPERM;
+}
-- 
2.49.0


