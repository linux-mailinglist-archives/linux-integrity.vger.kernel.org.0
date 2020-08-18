Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7387F2489BA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRP0M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbgHRP0J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:09 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B0BC75F02A3A752483C0;
        Tue, 18 Aug 2020 16:26:07 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:06 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:08 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 01/30] ima: Introduce ima namespace
Date:   Tue, 18 Aug 2020 17:20:08 +0200
Message-ID: <20200818152037.11869-2-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

IMA namespace wraps global ima resources in an abstraction, to enable ima
to work with the containers. Currently, ima namespace contains no useful
data but a dummy interface. IMA resources related to different aspects of
IMA, namely IMA-audit, IMA-measurement, IMA-appraisal will be added in the
following patches.

The way how ima namespace is created is analogous to the time namespace:
unshare(CLONE_NEWIMA) system call creates a new ima namespace but doesn't
assign it to the current process. All children of the process will be born
in the new ima namespace, or a process can use setns() system call to join
the new ima namespace. Call to clone3(CLONE_NEWIMA) system call creates a
new namespace, which the new process joins instantly.

This scheme, allows to configure the new ima namespace before any process
appears in it. If user initially unshares the new ima namespace, ima can
be configured using ima entries in the securityfs. If user calls clone3()
system call directly, the new ima namespace can be configured using clone
arguments. To allow this, new securityfs entries have to be added, and
structures clone_args and kernel_clone_args have to be extended.

Early configuration is crucial. The new ima polices must apply to the
first process in the new namespace, and the appraisal key has to be loaded
beforehand.

Add a new CONFIG_IMA_NS option to the kernel configuration, that enables
one to create a new IMA namespace. IMA namespace functionality is disabled
by default.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 fs/proc/namespaces.c              |   4 +
 include/linux/ima.h               |  57 ++++++++
 include/linux/nsproxy.h           |   3 +
 include/linux/proc_ns.h           |   5 +-
 include/linux/user_namespace.h    |   1 +
 include/uapi/linux/sched.h        |   1 +
 init/Kconfig                      |  12 ++
 kernel/fork.c                     |  24 +++-
 kernel/nsproxy.c                  |  34 ++++-
 kernel/ucount.c                   |   1 +
 security/integrity/ima/Makefile   |   1 +
 security/integrity/ima/ima.h      |  13 ++
 security/integrity/ima/ima_init.c |  13 ++
 security/integrity/ima/ima_ns.c   | 232 ++++++++++++++++++++++++++++++
 14 files changed, 392 insertions(+), 9 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..117812a59e5d 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -37,6 +37,10 @@ static const struct proc_ns_operations *ns_entries[] = {
 	&timens_operations,
 	&timens_for_children_operations,
 #endif
+#ifdef CONFIG_IMA_NS
+	&imans_operations,
+	&imans_for_children_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..4a9c29d4d056 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,6 +12,9 @@
 #include <linux/kexec.h>
 struct linux_binprm;
 
+struct nsproxy;
+struct task_struct;
+
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
@@ -167,4 +170,58 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 	return false;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+struct ima_namespace {
+	struct kref kref;
+	struct ns_common ns;
+	struct ucounts *ucounts;
+	struct user_namespace *user_ns;
+} __randomize_layout;
+
+extern struct ima_namespace init_ima_ns;
+
+#ifdef CONFIG_IMA_NS
+struct ima_namespace *copy_ima_ns(unsigned long flags,
+				  struct user_namespace *user_ns,
+				  struct ima_namespace *old_ns);
+
+void free_ima_ns(struct kref *kref);
+
+int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+
+static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
+{
+	if (ns)
+		kref_get(&ns->kref);
+	return ns;
+}
+static inline void put_ima_ns(struct ima_namespace *ns)
+{
+	if (ns)
+		kref_put(&ns->kref, free_ima_ns);
+}
+
+#else
+static inline struct ima_namespace *copy_ima_ns(unsigned long flags,
+						struct user_namespace *user_ns,
+						struct ima_namespace *old_ns)
+{
+	return old_ns;
+}
+
+static inline int imans_on_fork(struct nsproxy *nsproxy,
+				struct task_struct *tsk)
+{
+	return 0;
+}
+
+static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
+{
+	return ns;
+}
+
+static inline void put_ima_ns(struct ima_namespace *ns)
+{
+}
+#endif /* CONFIG_IMA_NS */
 #endif /* _LINUX_IMA_H */
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..56216a94009d 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -10,6 +10,7 @@ struct uts_namespace;
 struct ipc_namespace;
 struct pid_namespace;
 struct cgroup_namespace;
+struct ima_namespace;
 struct fs_struct;
 
 /*
@@ -38,6 +39,8 @@ struct nsproxy {
 	struct time_namespace *time_ns;
 	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
+	struct ima_namespace *ima_ns;
+	struct ima_namespace *ima_ns_for_children;
 };
 extern struct nsproxy init_nsproxy;
 
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..93735b7bbb65 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -16,7 +16,7 @@ struct inode;
 struct proc_ns_operations {
 	const char *name;
 	const char *real_ns_name;
-	int type;
+	unsigned long type;
 	struct ns_common *(*get)(struct task_struct *task);
 	void (*put)(struct ns_common *ns);
 	int (*install)(struct nsset *nsset, struct ns_common *ns);
@@ -34,6 +34,8 @@ extern const struct proc_ns_operations mntns_operations;
 extern const struct proc_ns_operations cgroupns_operations;
 extern const struct proc_ns_operations timens_operations;
 extern const struct proc_ns_operations timens_for_children_operations;
+extern const struct proc_ns_operations imans_operations;
+extern const struct proc_ns_operations imans_for_children_operations;
 
 /*
  * We always define these enumerators
@@ -46,6 +48,7 @@ enum {
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
 	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
+	PROC_IMA_INIT_INO	= 0xEFFFFFF9U,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..d9759c54fead 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -46,6 +46,7 @@ enum ucount_type {
 	UCOUNT_MNT_NAMESPACES,
 	UCOUNT_CGROUP_NAMESPACES,
 	UCOUNT_TIME_NAMESPACES,
+	UCOUNT_IMA_NAMESPACES,
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..b30e27efee92 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_NEWIMA 0x400000000ULL /* New IMA namespace. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..f188b33588a2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1184,6 +1184,18 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on IMA
+	default n
+	help
+	  This allows container engines to use ima namespaces to provide
+	  different IMA policy rules for different containers. Also, it allows
+	  to create what appear to be multiple instances of the IMA measurement
+	  list and other IMA related resources.
+
+	  If unsure, say N.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/fork.c b/kernel/fork.c
index 35e9894d394c..b977fd92fe3f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1876,11 +1876,24 @@ static __latent_entropy struct task_struct *copy_process(
 	}
 
 	/*
-	 * If the new process will be in a different time namespace
-	 * do not allow it to share VM or a thread group with the forking task.
+	 * If the new process will be in a different time namespace or a
+	 * different ima namespace, do not allow it to share VM or a thread
+	 * group with the forking task.
 	 */
 	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
-		if (nsp->time_ns != nsp->time_ns_for_children)
+		if ((nsp->time_ns != nsp->time_ns_for_children) ||
+		    ((clone_flags & CLONE_NEWIMA) ||
+		     (nsp->ima_ns != nsp->ima_ns_for_children)))
+			return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * If the new process will be in a different ima namespace
+	 * do not allow it to share the same file descriptor table.
+	 */
+	if (clone_flags & CLONE_FILES) {
+		if ((clone_flags & CLONE_NEWIMA) ||
+		    (nsp->ima_ns != nsp->ima_ns_for_children))
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2649,7 +2662,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS |
+	      CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP | CLONE_NEWIMA))
 		return false;
 
 	/*
@@ -2796,7 +2810,7 @@ static int check_unshare_flags(unsigned long unshare_flags)
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
 				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
-				CLONE_NEWTIME))
+				CLONE_NEWTIME|CLONE_NEWIMA))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 12dd41b39a7f..791efffd7a03 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
+#include <linux/ima.h>
 #include <linux/fs_struct.h>
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
@@ -47,6 +48,10 @@ struct nsproxy init_nsproxy = {
 	.time_ns		= &init_time_ns,
 	.time_ns_for_children	= &init_time_ns,
 #endif
+#ifdef CONFIG_IMA_NS
+	.ima_ns			= &init_ima_ns,
+	.ima_ns_for_children	= &init_ima_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -121,8 +126,19 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 	}
 	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
 
+	new_nsp->ima_ns_for_children = copy_ima_ns(flags, user_ns,
+					tsk->nsproxy->ima_ns_for_children);
+	if (IS_ERR(new_nsp->ima_ns_for_children)) {
+		err = PTR_ERR(new_nsp->ima_ns_for_children);
+		goto out_ima;
+	}
+	new_nsp->ima_ns = get_ima_ns(tsk->nsproxy->ima_ns);
+
 	return new_nsp;
 
+out_ima:
+	put_time_ns(new_nsp->time_ns);
+	put_time_ns(new_nsp->time_ns_for_children);
 out_time:
 	put_net(new_nsp->net_ns);
 out_net:
@@ -157,8 +173,10 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
-		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
+			      CLONE_NEWCGROUP | CLONE_NEWTIME |
+			      CLONE_NEWIMA)))) {
+		if (likely((old_ns->time_ns_for_children == old_ns->time_ns) &&
+			   (old_ns->ima_ns_for_children == old_ns->ima_ns))) {
 			get_nsproxy(old_ns);
 			return 0;
 		}
@@ -186,6 +204,12 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 		return ret;
 	}
 
+	ret = imans_on_fork(new_ns, tsk);
+	if (ret) {
+		free_nsproxy(new_ns);
+		return ret;
+	}
+
 	tsk->nsproxy = new_ns;
 	return 0;
 }
@@ -204,6 +228,10 @@ void free_nsproxy(struct nsproxy *ns)
 		put_time_ns(ns->time_ns);
 	if (ns->time_ns_for_children)
 		put_time_ns(ns->time_ns_for_children);
+	if (ns->ima_ns)
+		put_ima_ns(ns->ima_ns);
+	if (ns->ima_ns_for_children)
+		put_ima_ns(ns->ima_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
@@ -221,7 +249,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
-			       CLONE_NEWTIME)))
+			       CLONE_NEWTIME | CLONE_NEWIMA)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 11b1596e2542..3f4768d62b8f 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -70,6 +70,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_mnt_namespaces"),
 	UCOUNT_ENTRY("max_cgroup_namespaces"),
 	UCOUNT_ENTRY("max_time_namespaces"),
+	UCOUNT_ENTRY("max_ima_namespaces"),
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..d804d93f1a99 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,4 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38043074ce5e..603da5b2db08 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/ima.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -371,6 +372,18 @@ static inline int ima_read_xattr(struct dentry *dentry,
 
 #endif /* CONFIG_IMA_APPRAISE */
 
+#ifdef CONFIG_IMA_NS
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return current->nsproxy->ima_ns;
+}
+#else
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+#endif /* CONFIG_IMA_NS */
+
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4902fe7bd570..013bbec16849 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -15,6 +15,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/kref.h>
+#include <linux/proc_ns.h>
+#include <linux/user_namespace.h>
 
 #include "ima.h"
 
@@ -22,6 +25,16 @@
 const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
 
+struct ima_namespace init_ima_ns = {
+	.kref = KREF_INIT(2),
+	.user_ns = &init_user_ns,
+	.ns.inum = PROC_IMA_INIT_INO,
+#ifdef CONFIG_IMA_NS
+	.ns.ops = &imans_operations,
+#endif
+};
+EXPORT_SYMBOL(init_ima_ns);
+
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
  *
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..8f5f301406a2
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2020 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_ns.c
+ *      Functions to manage the IMA namespace.
+ */
+
+#include <linux/export.h>
+#include <linux/ima.h>
+#include <linux/kref.h>
+#include <linux/proc_ns.h>
+#include <linux/slab.h>
+#include <linux/user_namespace.h>
+#include <linux/nsproxy.h>
+#include <linux/sched.h>
+
+#include "ima.h"
+
+static struct ucounts *inc_ima_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_IMA_NAMESPACES);
+}
+
+static void dec_ima_namespaces(struct ucounts *ucounts)
+{
+	return dec_ucount(ucounts, UCOUNT_IMA_NAMESPACES);
+}
+
+static struct ima_namespace *ima_ns_alloc(void)
+{
+	struct ima_namespace *ima_ns;
+
+	ima_ns = kzalloc(sizeof(*ima_ns), GFP_KERNEL);
+	if (!ima_ns)
+		return NULL;
+
+	return ima_ns;
+}
+
+/**
+ * Clone a new ns copying an original ima namespace, setting refcount to 1
+ *
+ * @user_ns:	User namespace that current task runs in
+ * @old_ns:	Old ima namespace to clone
+ * Return:	ERR_PTR(-ENOMEM) on error (failure to kmalloc), new ns otherwise
+ */
+static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
+					   struct ima_namespace *old_ns)
+{
+	struct ima_namespace *ns;
+	struct ucounts *ucounts;
+	int err;
+
+	err = -ENOSPC;
+	ucounts = inc_ima_namespaces(user_ns);
+	if (!ucounts)
+		goto fail;
+
+	err = -ENOMEM;
+	ns = ima_ns_alloc();
+	if (!ns)
+		goto fail_dec;
+
+	kref_init(&ns->kref);
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto fail_free;
+
+	ns->ns.ops = &imans_operations;
+	ns->user_ns = get_user_ns(user_ns);
+	ns->ucounts = ucounts;
+
+	return ns;
+
+fail_free:
+	kfree(ns);
+fail_dec:
+	dec_ima_namespaces(ucounts);
+fail:
+	return ERR_PTR(err);
+}
+
+/**
+ * Copy task's ima namespace, or clone it if flags specifies CLONE_NEWNS.
+ *
+ * @flags:      Cloning flags
+ * @user_ns:	User namespace that current task runs in
+ * @old_ns:	Old ima namespace to clone
+ *
+ * Return: IMA namespace or ERR_PTR.
+ */
+
+struct ima_namespace *copy_ima_ns(unsigned long flags,
+				  struct user_namespace *user_ns,
+				  struct ima_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWIMA))
+		return get_ima_ns(old_ns);
+
+	return clone_ima_ns(user_ns, old_ns);
+}
+
+static void destroy_ima_ns(struct ima_namespace *ns)
+{
+	dec_ima_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+	ns_free_inum(&ns->ns);
+	kfree(ns);
+}
+
+void free_ima_ns(struct kref *kref)
+{
+	struct ima_namespace *ns;
+
+	ns = container_of(kref, struct ima_namespace, kref);
+
+	destroy_ima_ns(ns);
+}
+
+static inline struct ima_namespace *to_ima_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct ima_namespace, ns);
+}
+
+static struct ns_common *imans_get(struct task_struct *task)
+{
+	struct ima_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->ima_ns;
+		get_ima_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static struct ns_common *imans_for_children_get(struct task_struct *task)
+{
+	struct ima_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->ima_ns_for_children;
+		get_ima_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static void imans_put(struct ns_common *ns)
+{
+	put_ima_ns(to_ima_ns(ns));
+}
+
+static int imans_install(struct nsset *nsset, struct ns_common *new)
+{
+	struct nsproxy *nsproxy = nsset->nsproxy;
+	struct ima_namespace *ns = to_ima_ns(new);
+
+	if (!current_is_single_threaded())
+		return -EUSERS;
+
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
+	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	get_ima_ns(ns);
+	put_ima_ns(nsproxy->ima_ns);
+	nsproxy->ima_ns = ns;
+
+	get_ima_ns(ns);
+	put_ima_ns(nsproxy->ima_ns_for_children);
+	nsproxy->ima_ns_for_children = ns;
+
+	return 0;
+}
+
+int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+{
+	struct ns_common *nsc = &nsproxy->ima_ns_for_children->ns;
+	struct ima_namespace *ns = to_ima_ns(nsc);
+
+	/* create_new_namespaces() already incremented the ref counter */
+	if (nsproxy->ima_ns == nsproxy->ima_ns_for_children)
+		return 0;
+
+	get_ima_ns(ns);
+	put_ima_ns(nsproxy->ima_ns);
+	nsproxy->ima_ns = ns;
+
+	return 0;
+}
+
+static struct user_namespace *imans_owner(struct ns_common *ns)
+{
+	return to_ima_ns(ns)->user_ns;
+}
+
+const struct proc_ns_operations imans_operations = {
+	.name = "ima",
+	.type = CLONE_NEWIMA,
+	.get = imans_get,
+	.put = imans_put,
+	.install = imans_install,
+	.owner = imans_owner,
+};
+
+const struct proc_ns_operations imans_for_children_operations = {
+	.name = "ima_for_children",
+	.type = CLONE_NEWIMA,
+	.get = imans_for_children_get,
+	.put = imans_put,
+	.install = imans_install,
+	.owner = imans_owner,
+};
+
-- 
2.20.1

