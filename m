Return-Path: <linux-integrity+bounces-6279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345DABF71F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763A28C1B87
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECCA18E050;
	Wed, 21 May 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="gghCdj5Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CE14F117;
	Wed, 21 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836367; cv=none; b=szS59nme9GCCKl3fdN5zaUf2F8WjBCxmxZAxWdLhtcQQvUnKH6Ztwwv8LvVsfiiJs63uoTJdLcduDwu6ytgX6Cuc0thOpVs/C/7hsHgCNBAZ+HFQyPGpk7GIyHfJ1UvANzJJeLHBFXrBE7K5FZSv0GJvDFwIaEfOX1hw5oqhVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836367; c=relaxed/simple;
	bh=MyeVzj/GXEmxs16atOqVeRYXaDAw/zJot/OanJatabA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPUJOua+dEYYJLZPpr3VEiVtLhpwPH5c6dhTR7iqw7wuF22d32tOvkGFyQsvLWcf7TxrnDPBzLEiAoKoP7lOCrKHPmaZN4k6B2w6JjDodj9cpMvPyQoyeTiLLnH67HP0JCksb4VsHY2nCp0VquYI41bb5iRa8p775AQ0bRU4ga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=gghCdj5Y; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id C5A231087A44;
	Wed, 21 May 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836107;
	bh=MyeVzj/GXEmxs16atOqVeRYXaDAw/zJot/OanJatabA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gghCdj5YCw++wEKfYgO5Uql9/Oj++b8dWdwcCkK01NftNhuFm8YkO+TfLTXfNzIp6
	 zF913WYxLh6Wp83RJuwJ9COETuxfjky77/s+T+QxYM4vePcY0zROszPOjAg6fMkJPJ
	 0Bn5QerluhD6u54HFdfnq+6WC+SCk1qne4sQRZbOnUwvbVGm+3vTx4ZblXLNudK1ij
	 0800YvdIcOfeQH7lf3zJ0MiYL9nPK2LY2BJ37It+lU11z3FO4I4oSRlidHQ2rzUzLo
	 pWLODfH6VxBsF6FlZvDyrVhDRxUNHgY+7nCS7JqAnwFRavbiyoIGlqZX6i1SIXUyii
	 tA33LcqlGwt1w==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 4/9] Loadpol LSM: add a file in securityfs to read/modify the policy
Date: Wed, 21 May 2025 16:01:08 +0200
Message-ID: <20250521140121.591482-5-git@nightmared.fr>
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

Privileged users (CAP_SYS_ADMIN in the root namespace) can read and
update the module policy.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 security/loadpol/Makefile         |   2 +-
 security/loadpol/loadpol.h        |   8 +
 security/loadpol/loadpol_fs.c     | 108 +++++++++++++
 security/loadpol/loadpol_policy.c | 244 +++++++++++++++++++++++++++++-
 4 files changed, 360 insertions(+), 2 deletions(-)
 create mode 100644 security/loadpol/loadpol_fs.c

diff --git a/security/loadpol/Makefile b/security/loadpol/Makefile
index 062215e1f831..3351a4e90c1d 100644
--- a/security/loadpol/Makefile
+++ b/security/loadpol/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o loadpol_policy.o
+obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o loadpol_policy.o loadpol_fs.o
diff --git a/security/loadpol/loadpol.h b/security/loadpol/loadpol.h
index a81d52f6d4da..e81aa322e178 100644
--- a/security/loadpol/loadpol.h
+++ b/security/loadpol/loadpol.h
@@ -4,6 +4,7 @@
 #define _SECURITY_LOADPOL_LOADPOL_H
 
 #include "linux/list.h"
+#include <linux/seq_file.h>
 
 #define LOADPOL_NAME "loadpol"
 
@@ -29,6 +30,13 @@ struct loadpol_policy_entry {
 
 extern struct list_head __rcu *loadpol_policy;
 
+void *loadpol_policy_start(struct seq_file *m, loff_t *pos);
+void *loadpol_policy_next(struct seq_file *m, void *v, loff_t *pos);
+void loadpol_policy_stop(struct seq_file *m, void *v);
+int loadpol_policy_show(struct seq_file *m, void *v);
+
+ssize_t loadpol_parse_ruleset(char *data);
+
 // evaluate if a kernel module called 'kmod' is allowed to be loaded in the kernel
 int loadpol_kernel_module_load(const char *kmod);
 
diff --git a/security/loadpol/loadpol_fs.c b/security/loadpol/loadpol_fs.c
new file mode 100644
index 000000000000..9134d11718a0
--- /dev/null
+++ b/security/loadpol/loadpol_fs.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "linux/array_size.h"
+#include <linux/security.h>
+
+#include "loadpol.h"
+
+static struct dentry *securityfs_dir;
+static struct dentry *securityfs_policy;
+
+static DEFINE_MUTEX(policy_write_mutex);
+
+static const struct seq_operations loadpol_policy_seqops = {
+	.start = loadpol_policy_start,
+	.next = loadpol_policy_next,
+	.stop = loadpol_policy_stop,
+	.show = loadpol_policy_show,
+};
+
+static int loadpol_open_policy(struct inode *inode, struct file *filp)
+{
+	// Check permissions when accessing with writable flags
+	if ((filp->f_flags & O_ACCMODE) != O_RDONLY) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+	return seq_open(filp, &loadpol_policy_seqops);
+}
+
+static ssize_t loadpol_write_policy(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	char *data;
+	ssize_t ret;
+
+	/*
+	 * arbitrary size limit (to prevent a DoS but still allow loading a policy with a few
+	 * thousands of entries)
+	 */
+	if (count >= 64 * PAGE_SIZE) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	/* Partial writes are not permitted */
+	if (*ppos != 0) {
+		ret = -ESPIPE;
+		goto out;
+	}
+
+	data = memdup_user_nul(buf, count);
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
+		goto out;
+	}
+
+	ret = mutex_lock_interruptible(&policy_write_mutex);
+	if (ret < 0) {
+		ret = -EBUSY;
+		goto out_free;
+	}
+
+	ret = loadpol_parse_ruleset(data);
+	/* the policy was injested, return the write as having been completed */
+	if (!ret)
+		ret = count;
+
+	mutex_unlock(&policy_write_mutex);
+out_free:
+	kfree(data);
+out:
+	return ret;
+}
+
+static const struct file_operations loadpol_policy_ops = {
+	.open = loadpol_open_policy,
+	.write = loadpol_write_policy,
+	.read = seq_read,
+	.llseek = seq_lseek,
+};
+
+static int __init loadpol_init_fs(void)
+{
+	int ret;
+
+	securityfs_dir = securityfs_create_dir(LOADPOL_NAME, NULL);
+	if (IS_ERR(securityfs_dir)) {
+		ret = PTR_ERR(securityfs_dir);
+		goto err;
+	}
+
+	securityfs_policy = securityfs_create_file(
+		"policy", 0600, securityfs_dir, NULL, &loadpol_policy_ops
+	);
+	if (IS_ERR(securityfs_policy)) {
+		ret = PTR_ERR(securityfs_policy);
+		goto err;
+	}
+
+	return 0;
+err:
+	securityfs_remove(securityfs_policy);
+	securityfs_remove(securityfs_dir);
+	return ret;
+}
+
+/* only create debugfs entries once the filesystem is available */
+fs_initcall(loadpol_init_fs);
diff --git a/security/loadpol/loadpol_policy.c b/security/loadpol/loadpol_policy.c
index 6ba5ab600e3e..366046f00959 100644
--- a/security/loadpol/loadpol_policy.c
+++ b/security/loadpol/loadpol_policy.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#define pr_fmt(fmt) "loadpol: " fmt
+
 #include "linux/rculist.h"
 #include <linux/sched.h>
 #include <linux/sysctl.h>
@@ -12,6 +14,244 @@ static LIST_HEAD(loadpol_policy_a);
 static LIST_HEAD(loadpol_policy_b);
 struct list_head __rcu *loadpol_policy = (struct list_head __rcu *)(&loadpol_policy_a);
 
+enum loadpol_options {
+	Opt_action,
+	Opt_allowed,
+	Opt_denied,
+	Opt_kernel,
+	Opt_module,
+	Opt_origin,
+	Opt_userspace,
+	Opt_err,
+};
+
+static const match_table_t policy_options = {
+	{Opt_action, "action=%s"},
+	{Opt_allowed, "allow"},
+	{Opt_denied, "deny"},
+	{Opt_kernel, "kernel"},
+	{Opt_module, "module==%s"},
+	{Opt_origin, "origin==%s"},
+	{Opt_userspace, "user"},
+	{Opt_err, NULL},
+};
+
+#define opt(o) policy_options[o].pattern
+
+static void loadpol_free_entry(struct loadpol_policy_entry *entry)
+{
+	kfree(entry->module_name);
+	kfree(entry);
+}
+
+static void loadpol_free_ruleset(struct list_head *policy)
+{
+	struct loadpol_policy_entry *entry, *next_entry;
+
+	list_for_each_entry_safe(entry, next_entry, policy, list) {
+		list_del(&entry->list);
+		loadpol_free_entry(entry);
+	}
+}
+
+void *loadpol_policy_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *entry_list;
+
+	rcu_read_lock();
+	entry_list = seq_list_start_rcu(rcu_dereference(loadpol_policy), *pos);
+	rcu_read_unlock();
+
+	if (!entry_list)
+		return NULL;
+
+	return container_of(entry_list, struct loadpol_policy_entry, list);
+}
+
+void *loadpol_policy_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *entry_list;
+
+	rcu_read_lock();
+	entry_list = seq_list_next_rcu(v, rcu_dereference(loadpol_policy), pos);
+	rcu_read_unlock();
+
+	if (!entry_list)
+		return NULL;
+
+	return container_of(entry_list, struct loadpol_policy_entry, list);
+}
+
+void loadpol_policy_stop(struct seq_file *m, void *v)
+{
+}
+
+int loadpol_policy_show(struct seq_file *m, void *v)
+{
+	struct loadpol_policy_entry *entry = v;
+
+	seq_printf(m, opt(Opt_origin), "");
+	if (entry->origin & ORIGIN_KERNEL)
+		seq_puts(m, opt(Opt_kernel));
+	if (entry->origin & ORIGIN_KERNEL && entry->origin & ORIGIN_USERSPACE)
+		seq_puts(m, ",");
+	if (entry->origin & ORIGIN_USERSPACE)
+		seq_puts(m, opt(Opt_userspace));
+
+	seq_puts(m, " ");
+
+	if (entry->module_name) {
+		seq_printf(m, opt(Opt_module), entry->module_name);
+		seq_puts(m, " ");
+	}
+
+	seq_printf(m, opt(Opt_action),
+		   (entry->action == ACTION_ALLOW) ? opt(Opt_allowed) : opt(Opt_denied));
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static struct loadpol_policy_entry *process_policy_rule(char *line)
+{
+	char *token, *subtoken;
+	struct loadpol_policy_entry *entry;
+	int ret = -EINVAL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	// not strictly necessary since we zero-initialize entry, but explicitness is good
+	entry->module_name = NULL;
+	entry->origin = ORIGIN_KERNEL | ORIGIN_USERSPACE;
+	entry->action = ACTION_UNDEFINED;
+
+	while ((token = strsep(&line, " \t"))) {
+		int token_id;
+		substring_t args[MAX_OPT_ARGS];
+
+		if (!strlen(token))
+			continue;
+
+		token_id = match_token(token, policy_options, args);
+		switch (token_id) {
+		case Opt_module:
+			if (entry->module_name) {
+				pr_warn("cannot define two names in the same entry: '%s'", line);
+				goto err;
+			}
+
+			if (!strlen(args[0].from)) {
+				pr_warn("empty module names are not supported: '%s'", line);
+				goto err;
+			}
+
+			entry->module_name = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->module_name) {
+				ret = -ENOMEM;
+				goto err;
+			}
+
+			break;
+		case Opt_origin:
+			entry->origin = 0;
+
+			while ((subtoken = strsep(&args[0].from, ","))) {
+				if (!strcmp(subtoken, opt(Opt_kernel))) {
+					entry->origin |= ORIGIN_KERNEL;
+					continue;
+				}
+
+				if (!strcmp(subtoken, opt(Opt_userspace))) {
+					entry->origin |= ORIGIN_USERSPACE;
+					continue;
+				}
+
+				pr_warn("Unsupported origin '%s'", subtoken);
+				goto err;
+			}
+			break;
+		case Opt_action:
+			if (entry->action != ACTION_UNDEFINED) {
+				pr_warn("cannot define two action in the same entry: '%s'", line);
+				goto err;
+			}
+
+			if (!strcmp(args[0].from, opt(Opt_denied))) {
+				entry->action = ACTION_DENY;
+				continue;
+			}
+
+			if (!strcmp(args[0].from, opt(Opt_allowed))) {
+				entry->action = ACTION_ALLOW;
+				continue;
+			}
+
+			pr_warn("Loadpol: Unsupported action '%s'", args[0].from);
+			goto err;
+		case Opt_err:
+			pr_warn("Unsupported token %d: %s\n", token_id, token);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return entry;
+err:
+	loadpol_free_entry(entry);
+
+	return ERR_PTR(ret);
+}
+
+ssize_t loadpol_parse_ruleset(char *data)
+{
+	struct list_head *new_policy_list;
+	struct loadpol_policy_entry *entry;
+	char *sep_ptr, *line;
+
+	rcu_read_lock();
+	new_policy_list = (rcu_dereference(loadpol_policy) == &loadpol_policy_a) ?
+			   &loadpol_policy_b : &loadpol_policy_a;
+	rcu_read_unlock();
+
+	/* wait for the RCU previous critical section to be over */
+	synchronize_rcu();
+
+	/*
+	 * At this point, we know that nobody else is iterating over new_policy_list: we are
+	 * inside a lock so we have no concurrent writer, and we called synchronize_rcu which ensure
+	 * that current readers are reading the other policy list
+	 * (policy_a if we operate on policy_b, or vice-versa).
+	 */
+
+	/* free the old policy entries */
+	loadpol_free_ruleset(new_policy_list);
+
+	sep_ptr = data;
+	while ((line = strsep(&sep_ptr, "\n"))) {
+		// ignore empty lines
+		if (!strlen(line))
+			continue;
+
+		entry = process_policy_rule(line);
+		if (IS_ERR(entry))
+			goto err;
+
+		list_add_tail(&entry->list, new_policy_list);
+	}
+
+	/* switch to policy */
+	rcu_assign_pointer(loadpol_policy, new_policy_list);
+
+	return 0;
+
+err:
+	/* free the newly created entries */
+	loadpol_free_ruleset(new_policy_list);
+
+	return -EINVAL;
+}
+
 int loadpol_kernel_module_load(const char *kmod)
 {
 	struct task_struct *parent_task;
@@ -53,7 +293,9 @@ int loadpol_kernel_module_load(const char *kmod)
 unlock_and_exit:
 	rcu_read_unlock();
 
-	pr_debug("Loadpol: load of module '%s' %s", kmod, allowed ? "allowed" : "blocked");
+	pr_debug("Loadpol: load of module '%s' %s",
+		 kmod,
+		 allowed ? "allowed" : "blocked");
 
 	return allowed ? 0 : -EPERM;
 }
-- 
2.49.0


