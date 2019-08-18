Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25A91A5E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 01:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfHRX6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Aug 2019 19:58:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHRX6x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Aug 2019 19:58:53 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 833D31AE68B57A94B2A5;
        Mon, 19 Aug 2019 00:58:51 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.36) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 19 Aug 2019 00:58:42 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@huawei.com>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [WIP][RFC][PATCH 3/3] security: add infoflow LSM
Date:   Mon, 19 Aug 2019 01:57:45 +0200
Message-ID: <20190818235745.1417-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818235745.1417-1-roberto.sassu@huawei.com>
References: <20190818235745.1417-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new security module called Infoflow LSM to enforce the Clark-Wilson
integrity policy on top of existing label-based LSMs, such as SELinux and
SMACK.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  23 +
 include/linux/lsm_audit.h                     |   3 +
 include/uapi/linux/xattr.h                    |   2 +
 security/Kconfig                              |   1 +
 security/Makefile                             |   2 +
 security/infoflow/Kconfig                     |   6 +
 security/infoflow/Makefile                    |   7 +
 security/infoflow/infoflow.h                  | 173 ++++
 security/infoflow/infoflow_access.c           | 182 ++++
 security/infoflow/infoflow_ctx.c              | 342 ++++++++
 security/infoflow/infoflow_fs.c               | 479 +++++++++++
 security/infoflow/infoflow_lsm.c              | 778 ++++++++++++++++++
 security/integrity/evm/evm_main.c             |   1 +
 13 files changed, 1999 insertions(+)
 create mode 100644 security/infoflow/Kconfig
 create mode 100644 security/infoflow/Makefile
 create mode 100644 security/infoflow/infoflow.h
 create mode 100644 security/infoflow/infoflow_access.c
 create mode 100644 security/infoflow/infoflow_ctx.c
 create mode 100644 security/infoflow/infoflow_fs.c
 create mode 100644 security/infoflow/infoflow_lsm.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 47311cdf63d9..011b092f667a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1673,6 +1673,29 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	infoflow=	[INFOFLOW] Disable or enable Infoflow LSM at boot time.
+			Format: { "0" | "1" }
+			0 -- disable.
+			1 -- enable.
+
+	infoflow_mode=  [INFOFLOW] Set Infoflow LSM mode.
+			Format: { "disabled" | "discover" | "enforce" |
+				  "enforce-audit" };
+			disabled      -- LSM disabled.
+			discover      -- record operations and labels set by
+					 a parent LSM (e.g. SELinux, SMACK).
+			enforce       -- enforce Clark-Wilson integrity policy.
+			enforce-audit -- enforce Clark-Wilson integrity policy
+					 and record denied operations.
+			permissive    -- check Clark-Wilson integrity policy
+					 but don't enforce decision.
+			permissive-audit  -- check Clark-Wilson integrity policy
+					     and record decision.
+
+	infoflow_promote  [INFOFLOW] Promote low integrity objects that would
+				     cause a read-down violation of the
+				     Clark-Wilson integrity policy.
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..a955087c2283 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -104,6 +104,9 @@ struct common_audit_data {
 #endif
 #ifdef CONFIG_SECURITY_APPARMOR
 		struct apparmor_audit_data *apparmor_audit_data;
+#endif
+#ifdef CONFIG_SECURITY_INFOFLOW
+		struct infoflow_audit_data *infoflow_audit_data;
 #endif
 	}; /* per LSM data pointer union */
 };
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index c1395b5bd432..ccdacb5f6e2c 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -77,5 +77,7 @@
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
 #define XATTR_NAME_POSIX_ACL_DEFAULT XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_DEFAULT
 
+#define XATTR_INFOFLOW_SUFFIX "infoflow"
+#define XATTR_NAME_INFOFLOW XATTR_SECURITY_PREFIX XATTR_INFOFLOW_SUFFIX
 
 #endif /* _UAPI_LINUX_XATTR_H */
diff --git a/security/Kconfig b/security/Kconfig
index 466cc1f8ffed..7c5f0dc80b7b 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -237,6 +237,7 @@ source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
+source "security/infoflow/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index c598b904938f..1f33df7966dd 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,6 +11,7 @@ subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
+subdir-$(CONFIG_SECURITY_INFOFLOW)	+= infoflow
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -27,6 +28,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
+obj-$(CONFIG_SECURITY_INFOFLOW)		+= infoflow/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/infoflow/Kconfig b/security/infoflow/Kconfig
new file mode 100644
index 000000000000..744a28436e34
--- /dev/null
+++ b/security/infoflow/Kconfig
@@ -0,0 +1,6 @@
+config SECURITY_INFOFLOW
+	bool "Infoflow LSM"
+	select SECURITYFS
+	help
+	  Infoflow LSM enforces the Clark-Wilson policy on top of existing LSMs,
+	  such as SELinux and SMACK.
diff --git a/security/infoflow/Makefile b/security/infoflow/Makefile
new file mode 100644
index 000000000000..521a3c0a79bb
--- /dev/null
+++ b/security/infoflow/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Infoflow LSM
+#
+
+obj-$(CONFIG_SECURITY_INFOFLOW) := infoflow.o
+
+infoflow-y := infoflow_lsm.o infoflow_ctx.o infoflow_access.o infoflow_fs.o
diff --git a/security/infoflow/infoflow.h b/security/infoflow/infoflow.h
new file mode 100644
index 000000000000..26d35718e777
--- /dev/null
+++ b/security/infoflow/infoflow.h
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018,2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: infoflow.h
+ *      Header file.
+ */
+
+#ifndef __INFOFLOW_H
+#define __INFOFLOW_H
+
+#include <linux/lsm_hooks.h>
+#include <linux/lsm_audit.h>
+#include <linux/msg.h>
+#include <net/flow.h>
+#include <net/sock.h>
+
+enum infoflow_class {CLASS_LNK_FILE, CLASS_REG_FILE, CLASS_DIR,
+		     CLASS_CHR_FILE, CLASS_BLK_FILE, CLASS_FIFO_FILE,
+		     CLASS_SOCK_FILE, CLASS_IPC, CLASS_MSGQ, CLASS_SHM,
+		     CLASS_SEM, CLASS_SOCKET, CLASS_KEY, CLASS_PROCESS,
+		     CLASS_KERNEL, CLASS_MODULE, CLASS_UNDEFINED, CLASS__LAST};
+
+struct infoflow_class_desc {
+	const char *name;
+	u8 excluded;
+};
+
+extern struct infoflow_class_desc infoflow_class_array[CLASS__LAST];
+
+extern struct list_head contexts;
+
+#define INFOFLOW_PARENT_LSM_INIT	0x1
+#define INFOFLOW_POLICY_INIT		0x2
+#define INFOFLOW_PROMOTE		0x4
+extern int infoflow_init_flags;
+
+enum infoflow_modes { INFOFLOW_DISABLED, INFOFLOW_DISCOVER, INFOFLOW_ENFORCE,
+		      INFOFLOW_ENFORCE_AUDIT, INFOFLOW_PERMISSIVE,
+		      INFOFLOW_PERMISSIVE_AUDIT, INFOFLOW_MODE__LAST };
+
+extern const char *infoflow_modes_str[INFOFLOW_MODE__LAST];
+extern int infoflow_mode;
+
+#define CTX_FLAG_TCB		0x01
+#define CTX_FLAG_FILTER		0x02
+#define CTX_FLAG_INITIALIZED	0x04
+#define CTX_FLAG_CANNOT_PROMOTE	0x08
+struct infoflow_ctx {
+	struct rb_node rb_node;
+	struct list_head access_subjs;
+	struct list_head filter_subjs;
+	struct list_head context_list;
+	spinlock_t ctx_lock;
+	u32 sid;
+	u8 flags;
+	enum infoflow_class class;
+	char *label;
+	int label_len;
+};
+
+#define TYPE_RULE		0
+#define TYPE_FILTER		1
+struct infoflow_subj_desc {
+	struct list_head list;
+	struct infoflow_ctx *ctx;
+	int mask;
+	u8 denied;
+	const char *cause;
+};
+
+struct infoflow_audit_data {
+	struct infoflow_ctx *subj;
+	struct infoflow_ctx *obj;
+	int request;
+	int result;
+	char *cause;
+};
+
+static inline u16 infoflow_inode_class(umode_t mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFSOCK:
+		return CLASS_SOCK_FILE;
+	case S_IFLNK:
+		return CLASS_LNK_FILE;
+	case S_IFREG:
+		return CLASS_REG_FILE;
+	case S_IFBLK:
+		return CLASS_BLK_FILE;
+	case S_IFDIR:
+		return CLASS_DIR;
+	case S_IFCHR:
+		return CLASS_CHR_FILE;
+	case S_IFIFO:
+		return CLASS_FIFO_FILE;
+	}
+
+	return CLASS_UNDEFINED;
+}
+
+static inline u32 infoflow_file_f_mode_to_mask(struct file *file)
+{
+	int mask = 0;
+
+	if (file->f_mode & FMODE_READ)
+		mask |= MAY_READ;
+	if (file->f_mode & FMODE_WRITE)
+		mask |= MAY_WRITE;
+
+	return mask;
+}
+
+static inline enum infoflow_class infoflow_lookup_class(char *class)
+{
+	int i;
+
+	for (i = 0; i < CLASS__LAST; i++) {
+		if (!strcmp(infoflow_class_array[i].name, class))
+			break;
+	}
+
+	return i;
+}
+
+struct file_security_struct {
+	u32 sid;
+	u32 isid;
+	int pseqno;
+};
+
+extern struct lsm_blob_sizes infoflow_blob_sizes;
+
+static inline u8 *infoflow_inode(const struct inode *inode)
+{
+	return inode->i_security + infoflow_blob_sizes.lbs_inode;
+}
+
+static inline struct file_security_struct *infoflow_file(
+						const struct file *file)
+{
+	return file->f_security + infoflow_blob_sizes.lbs_file;
+}
+
+struct infoflow_ctx *infoflow_ctx_find_sid(enum infoflow_class class,
+					   u32 sid);
+struct infoflow_ctx *infoflow_ctx_insert_sid(enum infoflow_class class, u32 sid,
+					     u8 flags);
+struct infoflow_ctx *infoflow_ctx_insert_label(enum infoflow_class class,
+					       char *label, int label_len,
+					       u8 flags);
+void infoflow_ctx_delete(void);
+void infoflow_ctx_update_sid(void);
+int infoflow_ctx_find_add_subj(enum infoflow_class sclass, u32 ssid,
+			       struct infoflow_ctx **sctx, u8 sflags,
+			       enum infoflow_class oclass, u32 osid,
+			       struct infoflow_ctx **octx, u8 oflags,
+			       int mask, u8 denied, const char *cause,
+			       int type);
+
+int infoflow_allow_access(enum infoflow_class sclass, u32 ssid,
+			  enum infoflow_class oclass, u32 osid,
+			  u8 *inode_flags, int mask,
+			  struct common_audit_data *a);
+
+#endif /*__INFOFLOW_H*/
diff --git a/security/infoflow/infoflow_access.c b/security/infoflow/infoflow_access.c
new file mode 100644
index 000000000000..de81f0bfaad7
--- /dev/null
+++ b/security/infoflow/infoflow_access.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018,2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: infoflow_access.c
+ *      Functions to enforce Clark-Wilson policy and log decisions.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/cred.h>
+#include <linux/magic.h>
+#include <linux/audit.h>
+#include <linux/xattr.h>
+
+#include "infoflow.h"
+
+struct infoflow_ctx unknown_ctx = { .class = CLASS_UNDEFINED,
+				    .label = "unknown_label" };
+
+static void infoflow_log_callback(struct audit_buffer *ab, void *a)
+{
+	struct common_audit_data *ad = a;
+	struct infoflow_audit_data *sad = ad->infoflow_audit_data;
+
+	audit_log_format(ab, "lsm=infoflow request=%d action=%s cause=%s",
+			 sad->request, sad->result ? "denied" : "granted",
+			 sad->cause);
+	audit_log_format(ab, " subject=%s object=%s oclass=%s",
+			 sad->subj->label, sad->obj->label,
+			 infoflow_class_array[sad->obj->class].name);
+}
+
+static void infoflow_log(struct infoflow_ctx *subj, struct infoflow_ctx *obj,
+			 int request, int result, char *cause,
+			 struct common_audit_data *a)
+{
+	struct infoflow_audit_data sad;
+
+	memset(&sad, 0, sizeof(sad));
+
+	sad.subj = subj;
+	if (!sad.subj)
+		sad.subj = &unknown_ctx;
+	sad.obj = obj;
+	if (!sad.obj)
+		sad.obj = &unknown_ctx;
+	sad.request = request;
+	sad.result = result;
+	sad.cause = cause;
+
+	a->infoflow_audit_data = &sad;
+
+	common_lsm_audit(a, infoflow_log_callback, NULL);
+}
+
+/**
+ * infoflow_allow_access - enforce Clark-Wilson policy
+ * @sclass: subject class
+ * @ssid: subject's security identifier
+ * @oclass: object class
+ * @osid: object's security identifier
+ * @inode_flags: inode's flags
+ * @mask: operations requested
+ * @a: audit structure
+ *
+ * Return 0 on success, a negative value on failure.
+ */
+int infoflow_allow_access(enum infoflow_class sclass, u32 ssid,
+			  enum infoflow_class oclass, u32 osid,
+			  u8 *inode_flags, int mask,
+			  struct common_audit_data *a)
+{
+	struct infoflow_subj_desc *desc, *found_desc = NULL;
+	struct infoflow_ctx *sctx = NULL, *octx = NULL;
+	u8 sflags = 0, oflags = inode_flags ? *inode_flags : 0;
+	bool denied = false;
+	char *cause = "unknown";
+	int result;
+
+	if (infoflow_class_array[oclass].excluded)
+		return 0;
+
+	if (!(infoflow_init_flags & INFOFLOW_PARENT_LSM_INIT))
+		return 0;
+
+	if (infoflow_mode == INFOFLOW_DISCOVER) {
+		result = infoflow_ctx_find_add_subj(sclass, ssid, &sctx, 0,
+						    oclass, osid, &octx, 0,
+						    mask, 0, NULL, TYPE_RULE);
+		if (result < 0)
+			pr_err("Cannot add rule for sclass %d, ssid %d, "
+			       "oclass %d, osid %d\n", sclass, ssid, oclass,
+			       osid);
+
+		return 0;
+	}
+
+	if (!(infoflow_init_flags & INFOFLOW_POLICY_INIT))
+		return 0;
+
+	sctx = infoflow_ctx_find_sid(sclass, ssid);
+	if (sctx)
+		sflags |= sctx->flags;
+
+	octx = infoflow_ctx_find_sid(oclass, osid);
+	if (octx)
+		oflags |= octx->flags;
+
+	if (mask & MAY_WRITE && !(sflags & CTX_FLAG_TCB) &&
+	    !(oflags & CTX_FLAG_TCB) && inode_flags)
+		*inode_flags |= CTX_FLAG_CANNOT_PROMOTE;
+
+	if ((mask & MAY_WRITE) && !(sflags & CTX_FLAG_TCB) &&
+	    (oflags & CTX_FLAG_TCB) && !(oflags & CTX_FLAG_FILTER)) {
+		denied = true;
+		cause = "biba-write-up";
+	}
+
+	if ((mask & (MAY_READ | MAY_EXEC)) && (sflags & CTX_FLAG_TCB) &&
+	    !(oflags & CTX_FLAG_TCB) && !(oflags & CTX_FLAG_FILTER)) {
+		if ((infoflow_init_flags & INFOFLOW_PROMOTE) &&
+		    !(mask & MAY_WRITE) &&
+		    !(oflags & CTX_FLAG_CANNOT_PROMOTE) && inode_flags) {
+			*inode_flags |= CTX_FLAG_TCB;
+		} else {
+			denied = true;
+			cause = "biba-read-down";
+		}
+	}
+
+	if ((mask & (MAY_READ | MAY_EXEC)) && (sflags & CTX_FLAG_TCB) &&
+	    !(oflags & CTX_FLAG_TCB) && (oflags & CTX_FLAG_FILTER)) {
+		if (list_empty(&octx->filter_subjs)) {
+			found_desc = (void *)1;
+		} else {
+			list_for_each_entry(desc, &octx->filter_subjs, list)
+				if (desc->ctx == sctx) {
+					found_desc = desc;
+					break;
+				}
+		}
+
+		if (!found_desc) {
+			denied = true;
+			cause = "filtering-subj-not-found";
+		}
+	}
+
+	if (!denied)
+		return 0;
+
+	if (infoflow_mode == INFOFLOW_ENFORCE_AUDIT ||
+	    infoflow_mode == INFOFLOW_PERMISSIVE_AUDIT) {
+		result = infoflow_ctx_find_add_subj(sclass, ssid, &sctx, 0,
+						    oclass, osid, &octx, 0,
+						    mask, denied, cause,
+						    TYPE_RULE);
+		if (result < 0)
+			pr_err("Cannot add rule for sclass %d, ssid %d,"
+			       "oclass %d, osid %d\n", sclass, ssid,
+			       oclass, osid);
+	}
+
+	result = 0;
+
+	if (infoflow_mode == INFOFLOW_ENFORCE ||
+	    infoflow_mode == INFOFLOW_ENFORCE_AUDIT)
+		result = -EACCES;
+
+	if (a)
+		infoflow_log(sctx, octx, mask, result, cause, a);
+
+	return result;
+}
diff --git a/security/infoflow/infoflow_ctx.c b/security/infoflow/infoflow_ctx.c
new file mode 100644
index 000000000000..debec9268100
--- /dev/null
+++ b/security/infoflow/infoflow_ctx.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2008 IBM Corporation
+ * Copyright (C) 2018,2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Authors: Roberto Sassu <roberto.sassu@huawei.com>
+ *          Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: infoflow_ctx.c
+ *      Functions to manage security contexts.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/rbtree.h>
+
+#include "infoflow.h"
+
+static struct rb_root infoflow_ctx_tree[CLASS__LAST] = { RB_ROOT };
+static DEFINE_RWLOCK(infoflow_ctx_lock);
+LIST_HEAD(contexts);
+
+static struct infoflow_ctx *__infoflow_ctx_find_sid(enum infoflow_class class,
+						    u32 sid)
+{
+	struct infoflow_ctx *ctx;
+	struct rb_node *n = infoflow_ctx_tree[class].rb_node;
+
+	while (n) {
+		ctx = rb_entry(n, struct infoflow_ctx, rb_node);
+
+		if (sid < ctx->sid)
+			n = n->rb_left;
+		else if (sid > ctx->sid)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return ctx;
+}
+
+/*
+ * infoflow_ctx_find_sid - return the ctx associated with the class and sid
+ * @class: object class
+ * @sid: object's security identifier
+ *
+ * Return infoflow_ctx if found, NULL otherwise.
+ */
+struct infoflow_ctx *infoflow_ctx_find_sid(enum infoflow_class class, u32 sid)
+{
+	struct infoflow_ctx *ctx;
+
+	read_lock(&infoflow_ctx_lock);
+	ctx = __infoflow_ctx_find_sid(class, sid);
+	read_unlock(&infoflow_ctx_lock);
+
+	return ctx;
+}
+
+static struct infoflow_ctx *__infoflow_ctx_find_label(enum infoflow_class class,
+						      char *label,
+						      int label_len)
+{
+	struct infoflow_ctx *ctx;
+
+	list_for_each_entry(ctx, &contexts, context_list)
+		if (ctx->class == class && ctx->label_len == label_len &&
+		    !strncmp(ctx->label, label, label_len))
+			return ctx;
+
+	return NULL;
+}
+
+static struct infoflow_ctx *infoflow_ctx_find_label(enum infoflow_class class,
+						    char *label, int label_len)
+{
+	struct infoflow_ctx *ctx;
+
+	read_lock(&infoflow_ctx_lock);
+	ctx = __infoflow_ctx_find_label(class, label, label_len);
+	read_unlock(&infoflow_ctx_lock);
+
+	return ctx;
+}
+
+static void infoflow_ctx_insert_to_rbtree(struct infoflow_ctx *ctx)
+{
+	struct rb_node **p;
+	struct rb_node *node, *parent = NULL;
+	struct infoflow_ctx *test_ctx;
+
+	p = &infoflow_ctx_tree[ctx->class].rb_node;
+	while (*p) {
+		parent = *p;
+		test_ctx = rb_entry(parent, struct infoflow_ctx, rb_node);
+		if (ctx->sid < test_ctx->sid)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	node = &ctx->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &infoflow_ctx_tree[ctx->class]);
+}
+
+static struct infoflow_ctx *infoflow_ctx_insert(enum infoflow_class class,
+						u32 sid, u8 flags, char *label,
+						int label_len)
+{
+	struct infoflow_ctx *ctx;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC | __GFP_NOWARN);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->sid = sid;
+	ctx->flags = flags;
+	ctx->class = class;
+	ctx->label = kmemdup_nul(label, label_len, GFP_ATOMIC | __GFP_NOWARN);
+	if (!ctx->label) {
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->label_len = label_len;
+
+	INIT_LIST_HEAD(&ctx->access_subjs);
+	INIT_LIST_HEAD(&ctx->filter_subjs);
+	spin_lock_init(&ctx->ctx_lock);
+
+	write_lock(&infoflow_ctx_lock);
+	infoflow_ctx_insert_to_rbtree(ctx);
+	list_add_tail_rcu(&ctx->context_list, &contexts);
+	write_unlock(&infoflow_ctx_lock);
+
+	return ctx;
+}
+
+/**
+ * infoflow_ctx_insert_sid - insert ctx from sid
+ * @class: object class
+ * @sid: object's security identifier
+ * @flags: flags associated to the sid
+ *
+ * Return new infoflow_ctx on success, NULL on error.
+ */
+struct infoflow_ctx *infoflow_ctx_insert_sid(enum infoflow_class class, u32 sid,
+					     u8 flags)
+{
+	char *label;
+	int label_len;
+	int result;
+	struct infoflow_ctx *ctx;
+
+	ctx = infoflow_ctx_find_sid(class, sid);
+	if (ctx) {
+		ctx->flags |= flags;
+		return ctx;
+	}
+
+	result = security_secid_to_secctx(sid, &label, &label_len);
+	if (result < 0) {
+		pr_err("Cannot retrieve label for sid %d\n", sid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctx = infoflow_ctx_insert(class, sid, flags, label, label_len);
+
+	security_release_secctx(label, label_len);
+	return ctx;
+}
+
+/**
+ * infoflow_ctx_insert_label - insert ctx from label
+ * @class: object class
+ * @label: label associated to the sid
+ * @label_len: label length
+ * @flags: flags associated to the sid
+ *
+ * Return new infoflow_ctx on success, NULL on error.
+ */
+struct infoflow_ctx *infoflow_ctx_insert_label(enum infoflow_class class,
+					       char *label, int label_len,
+					       u8 flags)
+{
+	struct infoflow_ctx *ctx;
+	u32 sid = 0;
+	int result;
+
+	ctx = infoflow_ctx_find_label(class, label, label_len);
+	if (ctx) {
+		ctx->flags |= flags;
+		return ctx;
+	}
+
+	if (!(infoflow_init_flags & INFOFLOW_PARENT_LSM_INIT))
+		goto out;
+
+	result = security_secctx_to_secid(label, label_len, &sid);
+	if (result < 0) {
+		pr_err("Cannot retrieve sid for label %s\n", label);
+		return ERR_PTR(-EINVAL);
+	}
+out:
+	return infoflow_ctx_insert(class, sid, flags, label, label_len);
+}
+
+/**
+ * infoflow_ctx_delete - delete all contexts
+ *
+ */
+void infoflow_ctx_delete(void)
+{
+	struct infoflow_ctx *ctx, *tmp_ctx;
+	int i;
+
+	write_lock(&infoflow_ctx_lock);
+	list_for_each_entry_safe(ctx, tmp_ctx, &contexts, context_list) {
+		list_del(&ctx->context_list);
+		kfree(ctx->label);
+		kfree(ctx);
+	}
+
+	for (i = 0; i < CLASS__LAST; i++)
+		infoflow_ctx_tree[i] = RB_ROOT;
+
+	write_unlock(&infoflow_ctx_lock);
+}
+
+/**
+ * infoflow_ctx_update_sid - update infoflow_ctx SID after policy change
+ *
+ */
+void infoflow_ctx_update_sid(void)
+{
+	struct infoflow_ctx *ctx;
+	u32 new_sid;
+	int result;
+
+	list_for_each_entry(ctx, &contexts, context_list) {
+		result = security_secctx_to_secid(ctx->label,
+						  strlen(ctx->label),
+						  &new_sid);
+		if (result < 0) {
+			pr_err("Cannot obtain SID for context %s\n",
+			       ctx->label);
+			continue;
+		}
+
+		if (ctx->sid == new_sid)
+			continue;
+
+		write_lock(&infoflow_ctx_lock);
+		rb_erase(&ctx->rb_node, &infoflow_ctx_tree[ctx->class]);
+
+		ctx->sid = new_sid;
+		infoflow_ctx_insert_to_rbtree(ctx);
+		write_unlock(&infoflow_ctx_lock);
+	}
+}
+
+/**
+ * infoflow_ctx_find_add_subj - add discovered interaction or filtering subj
+ * @sclass: subject class
+ * @ssid: subject's security identifier
+ * @sctx: subject's infoflow_ctx
+ * @sflags: subject's flags
+ * @oclass: object class
+ * @osid: object's security identifier
+ * @octx: object's infoflow_ctx
+ * @oflags: object's flags
+ * @mask: operations requested
+ * @denied: whether access is denied
+ * @cause: reason if access is denied
+ * @type: type of information (rule, filtering subj)
+ *
+ * Return 0 on success, a negative value on failure.
+ */
+int infoflow_ctx_find_add_subj(enum infoflow_class sclass, u32 ssid,
+			       struct infoflow_ctx **sctx, u8 sflags,
+			       enum infoflow_class oclass, u32 osid,
+			       struct infoflow_ctx **octx, u8 oflags,
+			       int mask, u8 denied, const char *cause,
+			       int type)
+{
+	struct infoflow_subj_desc *desc, *found_desc = NULL;
+	struct list_head *head;
+
+	if (!*sctx) {
+		*sctx = infoflow_ctx_insert_sid(sclass, ssid, sflags);
+		if (IS_ERR(*sctx))
+			return PTR_ERR(*sctx);
+	}
+
+	if (!*octx) {
+		*octx = infoflow_ctx_insert_sid(oclass, osid, oflags);
+		if (IS_ERR(*octx))
+			return PTR_ERR(*octx);
+	}
+
+	head = &(*octx)->access_subjs;
+	if (type == TYPE_FILTER)
+		head = &(*octx)->filter_subjs;
+
+	list_for_each_entry(desc, head, list) {
+		if (desc->ctx == *sctx) {
+			found_desc = desc;
+			break;
+		}
+	}
+
+	if (!found_desc) {
+		desc = kmalloc(sizeof(*desc), GFP_ATOMIC | __GFP_NOWARN);
+		if (!desc) {
+			pr_err("Cannot allocate memory for subject desc\n");
+			return -ENOMEM;
+		}
+
+		desc->ctx = *sctx;
+		desc->mask = 0;
+		desc->denied = 0;
+		desc->cause = cause;
+
+		spin_lock(&(*octx)->ctx_lock);
+		list_add_tail_rcu(&desc->list, head);
+		spin_unlock(&(*octx)->ctx_lock);
+	}
+
+	desc->mask |= mask;
+	desc->denied |= denied;
+	return 0;
+}
diff --git a/security/infoflow/infoflow_fs.c b/security/infoflow/infoflow_fs.c
new file mode 100644
index 000000000000..52be308d0358
--- /dev/null
+++ b/security/infoflow/infoflow_fs.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2008 IBM Corporation
+ * Copyright (C) 2018,2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Authors: Roberto Sassu <roberto.sassu@huawei.com>
+ *          Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: infoflow_fs.c
+ *      Functions implementing methods for securityfs.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/security.h>
+#include <linux/parser.h>
+
+#include "infoflow.h"
+
+static struct dentry *infoflow_dir;
+static struct dentry *infoflow_rules;
+static struct dentry *infoflow_policy;
+static struct dentry *infoflow_enforce;
+
+static void *infoflow_ctx_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t l = *pos;
+	struct infoflow_ctx *ctx;
+
+	if (m->file->f_path.dentry == infoflow_policy &&
+	    !(infoflow_init_flags & INFOFLOW_POLICY_INIT))
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ctx, &contexts, context_list) {
+		if (!l--) {
+			rcu_read_unlock();
+			return ctx;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+static void *infoflow_ctx_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct infoflow_ctx *ctx = v;
+
+	rcu_read_lock();
+	ctx = list_entry_rcu(ctx->context_list.next, struct infoflow_ctx,
+			     context_list);
+	rcu_read_unlock();
+	(*pos)++;
+
+	return (&ctx->context_list == &contexts) ? NULL : ctx;
+}
+
+static void infoflow_ctx_stop(struct seq_file *m, void *v)
+{
+}
+
+int infoflow_rules_show(struct seq_file *m, void *v)
+{
+	struct infoflow_ctx *ctx = v;
+	struct infoflow_subj_desc *desc;
+
+	list_for_each_entry(desc, &ctx->access_subjs, list) {
+		seq_printf(m, "allow %s %s:%s {", desc->ctx->label, ctx->label,
+			   infoflow_class_array[ctx->class].name);
+
+		if (desc->mask & MAY_READ || desc->mask & MAY_EXEC)
+			seq_printf(m, " read");
+		if (desc->mask & MAY_WRITE || desc->mask & MAY_APPEND)
+			seq_printf(m, " write");
+
+		seq_printf(m, " };");
+
+		if (desc->denied)
+			seq_printf(m, " [denied:%s]", desc->cause);
+
+		seq_printf(m, "\n");
+	}
+
+	return 0;
+}
+
+static const struct seq_operations infoflow_rules_seqops = {
+	.start = infoflow_ctx_start,
+	.next = infoflow_ctx_next,
+	.stop = infoflow_ctx_stop,
+	.show = infoflow_rules_show,
+};
+
+static int infoflow_rules_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &infoflow_rules_seqops);
+}
+
+static const struct file_operations infoflow_rules_ops = {
+	.open = infoflow_rules_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+int infoflow_policy_show(struct seq_file *m, void *v)
+{
+	struct infoflow_ctx *ctx = v;
+	struct infoflow_subj_desc *desc;
+
+	if (ctx->flags & CTX_FLAG_FILTER)
+		seq_printf(m, "filter");
+	else if (ctx->flags & CTX_FLAG_TCB)
+		seq_printf(m, "tcb");
+	else
+		return 0;
+
+	if (ctx->class == CLASS_PROCESS)
+		seq_printf(m, " subj=");
+	else
+		seq_printf(m, " obj=");
+
+	seq_printf(m, "%s:%s", ctx->label,
+		   infoflow_class_array[ctx->class].name);
+
+	list_for_each_entry(desc, &ctx->filter_subjs, list)
+		seq_printf(m, " subj=%s:%s", desc->ctx->label,
+			   infoflow_class_array[desc->ctx->class].name);
+
+	seq_printf(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations policy_seq_ops = {
+	.start = infoflow_ctx_start,
+	.next  = infoflow_ctx_next,
+	.stop  = infoflow_ctx_stop,
+	.show  = infoflow_policy_show,
+};
+
+enum {
+	Opt_err = -1, Opt_tcb = 1, Opt_filter, Opt_subj, Opt_obj,
+};
+
+static match_table_t policy_tokens = {
+	{Opt_tcb, "tcb"},
+	{Opt_filter, "filter"},
+	{Opt_subj, "subj=%s"},
+	{Opt_obj, "obj=%s"},
+};
+
+int valid_policy;
+
+static int infoflow_open_policy(struct inode *inode, struct file *file)
+{
+	if ((infoflow_init_flags & INFOFLOW_POLICY_INIT) &&
+	    (file->f_mode & FMODE_WRITE))
+		return -EPERM;
+
+	valid_policy = 1;
+
+	return seq_open(file, &policy_seq_ops);
+}
+
+static struct infoflow_ctx *infoflow_add_ctx(char *label, u8 flags, bool obj)
+{
+	enum infoflow_class class = CLASS_PROCESS;
+	char *class_ptr;
+
+	if (!obj)
+		goto out;
+
+	class_ptr = strrchr(label, ':');
+	if (!class_ptr)
+		return ERR_PTR(-EINVAL);
+
+	*class_ptr++ = '\0';
+
+	class = infoflow_lookup_class(class_ptr);
+	if (class == CLASS__LAST) {
+		pr_err("Invalid class %s\n", class_ptr);
+		return ERR_PTR(-EINVAL);
+	}
+out:
+	return infoflow_ctx_insert_label(class, label, strlen(label), flags);
+}
+
+static int infoflow_parse_rule(char *rule)
+{
+	struct infoflow_ctx *subj = NULL, *obj = NULL;
+	LIST_HEAD(filtering_subjects);
+	struct infoflow_subj_desc *desc, *tmp_desc;
+	char *p;
+	u8 flags = 0;
+	int result = 0;
+
+	while ((p = strsep(&rule, " \t")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		if (result < 0)
+			break;
+		if ((*p == '\0') || (*p == ' ') || (*p == '\t'))
+			continue;
+		token = match_token(p, policy_tokens, args);
+		switch (token) {
+		case Opt_tcb:
+			if (flags) {
+				pr_err("Rule type already specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			flags |= CTX_FLAG_TCB;
+			break;
+		case Opt_filter:
+			if (flags) {
+				pr_err("Rule type already specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			flags |= CTX_FLAG_FILTER;
+			break;
+		case Opt_subj:
+			if (!flags) {
+				pr_err("Rule type not specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			if (!(flags & CTX_FLAG_FILTER) && subj) {
+				pr_err("Subject already specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			if ((flags & CTX_FLAG_FILTER) && !obj) {
+				pr_err("Object not specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			subj = infoflow_add_ctx(args[0].from,
+					(flags & CTX_FLAG_FILTER) ?
+					0 : flags, false);
+			if (IS_ERR(subj)) {
+				result = PTR_ERR(subj);
+				break;
+			}
+
+			if (flags & CTX_FLAG_FILTER) {
+				result = infoflow_ctx_find_add_subj(0, 0, &subj,
+						0, 0, 0, &obj, 0, 0, 0, NULL,
+						TYPE_FILTER);
+				if (result < 0)
+					break;
+			}
+
+			desc = kmalloc(sizeof(*desc), GFP_KERNEL);
+			if (!desc) {
+				result = -ENOMEM;
+				break;
+			}
+			desc->ctx = subj;
+			list_add_tail(&desc->list, &filtering_subjects);
+			break;
+		case Opt_obj:
+			if (!flags || obj) {
+				pr_err("Rule type not specified or "
+				       "object specified\n");
+				result = -EINVAL;
+				break;
+			}
+
+			obj = infoflow_add_ctx(args[0].from, flags, true);
+			if (IS_ERR(obj)) {
+				result = -ENOMEM;
+				break;
+			}
+			break;
+		case Opt_err:
+			result = -EINVAL;
+			break;
+		}
+	}
+
+	if (!result && !flags) {
+		pr_err("Rule type not specified\n");
+		result = -EINVAL;
+	}
+
+	list_for_each_entry_safe(desc, tmp_desc, &filtering_subjects, list) {
+		if (!(desc->ctx->flags & CTX_FLAG_TCB)) {
+			pr_err("Filtering subject %s not added to TCB\n",
+			       desc->ctx->label);
+			list_del(&desc->list);
+			kfree(desc);
+			result = -EINVAL;
+		}
+	}
+
+	if (result < 0)
+		infoflow_ctx_delete();
+
+	return result;
+}
+
+static ssize_t infoflow_write_policy(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	char *data, *data_ptr, *newline_ptr;
+	int rc = 0;
+
+	if (cap_capable(current_cred(), &init_user_ns, CAP_MAC_ADMIN,
+			CAP_OPT_NONE))
+		return -EACCES;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	if (count >= PAGE_SIZE)
+		count = PAGE_SIZE - 1;
+
+	data_ptr = data = memdup_user_nul(buf, count);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	while (*(newline_ptr = strchrnul(data_ptr, '\n')) == '\n') {
+		*newline_ptr = '\0';
+
+		rc = infoflow_parse_rule(data_ptr);
+		if (rc < 0)
+			break;
+
+		data_ptr = newline_ptr + 1;
+	}
+
+	kfree(data);
+
+	if (rc < 0) {
+		valid_policy = 0;
+		return rc;
+	}
+
+	return data_ptr - data;
+}
+
+static int infoflow_release_policy(struct inode *inode, struct file *file)
+{
+	if (!(file->f_mode & FMODE_WRITE))
+		return 0;
+
+	if (!valid_policy) {
+		pr_err("Cannot load infoflow policy\n");
+		return 0;
+	}
+
+	infoflow_init_flags |= INFOFLOW_POLICY_INIT;
+
+	pr_info("Successfully loaded Infoflow LSM policy\n");
+
+	return 0;
+}
+
+static const struct file_operations infoflow_policy_ops = {
+	.open		= infoflow_open_policy,
+	.read		= seq_read,
+	.llseek         = seq_lseek,
+	.write		= infoflow_write_policy,
+	.release	= infoflow_release_policy,
+};
+
+
+static int infoflow_open_mode(struct inode *inode, struct file *file)
+{
+	if ((file->f_mode & FMODE_WRITE) &&
+	    cap_capable(current_cred(), &init_user_ns, CAP_MAC_ADMIN,
+			CAP_OPT_NONE))
+		return -EACCES;
+
+	return 0;
+}
+
+#define TMPBUFLEN	32
+static ssize_t infoflow_read_mode(struct file *filp, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, sizeof(tmpbuf), "%s",
+			   infoflow_modes_str[infoflow_mode]);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t infoflow_write_mode(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+
+{
+	char *new_mode = NULL;
+	ssize_t length;
+	int i;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	new_mode = memdup_user_nul(buf, count);
+	if (IS_ERR(new_mode))
+		return PTR_ERR(new_mode);
+
+	for (i = 0; i < INFOFLOW_MODE__LAST; i++) {
+		if (!strcmp(new_mode, infoflow_modes_str[i])) {
+			infoflow_mode = i;
+			break;
+		}
+	}
+
+	if (i == INFOFLOW_MODE__LAST) {
+		length = -EINVAL;
+		goto out;
+	}
+
+	length = count;
+out:
+	kfree(new_mode);
+	return length;
+}
+
+static const struct file_operations infoflow_enforce_ops = {
+	.open		= infoflow_open_mode,
+	.read		= infoflow_read_mode,
+	.write		= infoflow_write_mode,
+	.llseek		= generic_file_llseek,
+};
+
+static int __init init_infoflow_fs(void)
+{
+	infoflow_dir = securityfs_create_dir("infoflow", NULL);
+	if (IS_ERR(infoflow_dir))
+		goto out;
+
+	infoflow_rules = securityfs_create_file("rules", S_IRUGO,
+				infoflow_dir, NULL, &infoflow_rules_ops);
+	if (IS_ERR(infoflow_rules))
+		goto out;
+
+	infoflow_policy = securityfs_create_file("policy", S_IRUGO | S_IWUSR,
+				infoflow_dir, NULL, &infoflow_policy_ops);
+	if (IS_ERR(infoflow_policy))
+		goto out;
+
+	infoflow_enforce = securityfs_create_file("enforce",
+					S_IRUGO | S_IWUSR, infoflow_dir, NULL,
+					&infoflow_enforce_ops);
+	if (IS_ERR(infoflow_enforce))
+		goto out;
+
+	return 0;
+out:
+	securityfs_remove(infoflow_enforce);
+	securityfs_remove(infoflow_policy);
+	securityfs_remove(infoflow_rules);
+	securityfs_remove(infoflow_dir);
+	return -1;
+}
+
+__initcall(init_infoflow_fs);
diff --git a/security/infoflow/infoflow_lsm.c b/security/infoflow/infoflow_lsm.c
new file mode 100644
index 000000000000..0737b8e07c47
--- /dev/null
+++ b/security/infoflow/infoflow_lsm.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018,2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: infoflow_lsm.c
+ *      Function implementing LSM hooks.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/cred.h>
+#include <linux/magic.h>
+#include <linux/audit.h>
+#include <linux/xattr.h>
+
+#include "infoflow.h"
+
+struct infoflow_class_desc infoflow_class_array[CLASS__LAST] = {
+	[CLASS_LNK_FILE] = { .name = "lnk_file", .excluded = 1 },
+	[CLASS_REG_FILE] = { .name = "file" },
+	[CLASS_DIR] = { .name = "dir", .excluded = 1 },
+	[CLASS_CHR_FILE] = { .name = "chr_file" },
+	[CLASS_BLK_FILE] = { .name = "blk_file" },
+	[CLASS_FIFO_FILE] = { .name = "fifo_file" },
+	[CLASS_SOCK_FILE] = { .name = "sock_file", .excluded = 1 },
+	[CLASS_IPC] = { .name = "ipc" },
+	[CLASS_MSGQ] = { .name = "msgq" },
+	[CLASS_SHM] = { .name = "shm" },
+	[CLASS_SEM] = { .name = "sem" },
+	[CLASS_SOCKET] = { .name = "socket" },
+	[CLASS_KEY] = { .name = "key" },
+	[CLASS_PROCESS] = { .name = "process" },
+	[CLASS_KERNEL] = { .name = "kernel" },
+	[CLASS_MODULE] = { .name = "module" },
+	[CLASS_UNDEFINED] = { .name = "undefined" },
+};
+
+const char *infoflow_modes_str[INFOFLOW_MODE__LAST] = {
+	[INFOFLOW_DISABLED] = "disabled",
+	[INFOFLOW_DISCOVER] = "discover",
+	[INFOFLOW_ENFORCE] = "enforce",
+	[INFOFLOW_ENFORCE_AUDIT] = "enforce-audit",
+	[INFOFLOW_PERMISSIVE] = "permissive",
+	[INFOFLOW_PERMISSIVE_AUDIT] = "permissive-audit",
+};
+
+int infoflow_mode __lsm_ro_after_init = INFOFLOW_ENFORCE;
+static int __init infoflow_mode_setup(char *str)
+{
+	int i;
+
+	for (i = 0; i < INFOFLOW_MODE__LAST; i++) {
+		if (!strcmp(str, infoflow_modes_str[i])) {
+			infoflow_mode = i;
+			break;
+		}
+	}
+
+	if (i == INFOFLOW_MODE__LAST)
+		pr_err("Unknown mode %s\n", str);
+
+	return 1;
+}
+__setup("infoflow_mode=", infoflow_mode_setup);
+
+int infoflow_enabled __lsm_ro_after_init = 1;
+static int __init infoflow_enabled_setup(char *str)
+{
+	unsigned long enabled;
+
+	if (!kstrtoul(str, 0, &enabled))
+		infoflow_enabled = enabled ? 1 : 0;
+	return 1;
+}
+__setup("infoflow=", infoflow_enabled_setup);
+
+int infoflow_init_flags;
+static int __init infoflow_promote_setup(char *str)
+{
+	infoflow_init_flags |= INFOFLOW_PROMOTE;
+	return 1;
+}
+__setup("infoflow_promote", infoflow_promote_setup);
+
+static int infoflow_seqno;
+
+static int infoflow_security_change(struct notifier_block *nb,
+				    unsigned long event, void *lsm_data)
+{
+	if (event != LSM_POLICY_CHANGE)
+		return NOTIFY_DONE;
+
+	infoflow_seqno++;
+	infoflow_ctx_update_sid();
+	infoflow_init_flags |= INFOFLOW_PARENT_LSM_INIT;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block infoflow_lsm_nb = {
+	.notifier_call = infoflow_security_change,
+};
+
+static int infoflow_inode_init_security(struct inode *inode, struct inode *dir,
+					const struct qstr *qstr,
+					const char **name, void **value,
+					size_t *len)
+{
+	const struct cred *cred = current_cred();
+	u8 *iflags = infoflow_inode(inode);
+	u16 class = infoflow_inode_class(inode->i_mode);
+	struct infoflow_ctx *sctx;
+	u8 flags = CTX_FLAG_TCB;
+	u32 sid;
+
+	if (name)
+		*name = XATTR_INFOFLOW_SUFFIX;
+
+	if (infoflow_class_array[class].excluded)
+		return 0;
+
+	if (!(infoflow_init_flags & INFOFLOW_POLICY_INIT))
+		return -EOPNOTSUPP;
+
+	validate_creds(cred);
+
+	security_cred_getsecid(cred, &sid);
+	sctx = infoflow_ctx_find_sid(CLASS_PROCESS, sid);
+
+	if (!sctx || !(sctx->flags & CTX_FLAG_TCB))
+		return 0;
+
+	*iflags |= (flags | CTX_FLAG_INITIALIZED);
+
+	if (value && len) {
+		*value = kmemdup(&flags, sizeof(flags), GFP_NOFS);
+		if (!*value)
+			return -ENOMEM;
+
+		*len = sizeof(flags);
+	}
+
+	return 0;
+}
+
+int infoflow_check_fs(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	switch (sb->s_magic) {
+	case PROC_SUPER_MAGIC:
+	case SYSFS_MAGIC:
+	case DEBUGFS_MAGIC:
+	case RAMFS_MAGIC:
+	case DEVPTS_SUPER_MAGIC:
+	case BINFMTFS_MAGIC:
+	case SECURITYFS_MAGIC:
+	case SELINUX_MAGIC:
+	case SMACK_MAGIC:
+	case NSFS_MAGIC:
+	case CGROUP_SUPER_MAGIC:
+	case CGROUP2_SUPER_MAGIC:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static int infoflow_inode_init(struct dentry *opt_dentry, struct inode *inode,
+			       bool may_sleep)
+{
+	u8 *iflags = infoflow_inode(inode);
+	u16 class = infoflow_inode_class(inode->i_mode);
+	struct dentry *dentry = NULL;
+	u8 flags = 0;
+	int rc;
+
+	might_sleep_if(may_sleep);
+
+	if (infoflow_class_array[class].excluded)
+		return 0;
+
+	if (!(infoflow_init_flags & INFOFLOW_POLICY_INIT))
+		return 0;
+
+	if (!may_sleep)
+		return -ECHILD;
+
+	if (*iflags & CTX_FLAG_INITIALIZED)
+		return 0;
+
+	if (!infoflow_check_fs(inode) || !(inode->i_opflags & IOP_XATTR)) {
+		*iflags |= CTX_FLAG_INITIALIZED;
+		return 0;
+	}
+
+	if (!opt_dentry) {
+		dentry = d_find_alias(inode);
+		if (!dentry)
+			dentry = d_find_any_alias(inode);
+	} else {
+		dentry = dget(opt_dentry);
+	}
+
+	if (!dentry)
+		return 0;
+
+	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_INFOFLOW, &flags,
+			    sizeof(flags));
+	if (rc == sizeof(flags))
+		*iflags |= (flags & CTX_FLAG_TCB);
+
+	*iflags |= CTX_FLAG_INITIALIZED;
+
+	if (dentry)
+		dput(dentry);
+
+	return 0;
+}
+
+static void infoflow_d_instantiate(struct dentry *opt_dentry,
+				   struct inode *inode)
+{
+	infoflow_inode_init(opt_dentry, inode, true);
+}
+
+static int inode_has_perm(const struct cred *cred,
+			  struct inode *inode,
+			  int mask,
+			  struct common_audit_data *adp)
+{
+	u8 *iflags = infoflow_inode(inode);
+	u32 ssid, isid;
+
+	if (!infoflow_check_fs(inode))
+		return 0;
+
+	validate_creds(cred);
+
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
+	security_cred_getsecid(cred, &ssid);
+	security_inode_getsecid(inode, &isid);
+
+	return infoflow_allow_access(CLASS_PROCESS, ssid,
+				     infoflow_inode_class(inode->i_mode), isid,
+				     iflags, mask, adp);
+}
+
+static int infoflow_inode_permission(struct inode *inode, int mask)
+{
+	const struct cred *cred = current_cred();
+	struct common_audit_data ad;
+
+	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
+
+	/* No permission to check.  Existence test. */
+	if (!mask)
+		return 0;
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return inode_has_perm(cred, inode, mask, &ad);
+}
+
+static int infoflow_inode_setxattr(struct dentry *dentry, const char *name,
+				   const void *value, size_t size, int flags)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	const struct cred *cred = current_cred();
+
+	if (strcmp(name, XATTR_NAME_INFOFLOW))
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return inode_has_perm(cred, inode, MAY_WRITE, NULL);
+}
+
+static void infoflow_inode_post_setxattr(struct dentry *dentry,
+					 const char *name, const void *value,
+					 size_t size, int flags)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	u8 *iflags = infoflow_inode(inode);
+
+	if (strcmp(name, XATTR_NAME_INFOFLOW) != 0)
+		return;
+
+	if (size != 1)
+		return;
+
+	*iflags = *(u8 *)value;
+}
+
+static int infoflow_inode_removexattr(struct dentry *dentry, const char *name)
+{
+	if (strcmp(name, XATTR_NAME_INFOFLOW))
+		return 0;
+
+	/* There is no inode_post_removexattr() hook, we cannot clear
+	 * the inode flags.
+	 */
+	return -EACCES;
+}
+
+static int infoflow_inode_setsecurity(struct inode *inode, const char *name,
+				      const void *value, size_t size, int flags)
+{
+	u8 *iflags = infoflow_inode(inode);
+
+	if (strcmp(name, XATTR_INFOFLOW_SUFFIX))
+		return -EOPNOTSUPP;
+
+	if (!value || !size)
+		return -EACCES;
+
+	if (size != 1)
+		return -EINVAL;
+
+	*iflags = *(u8 *)value;
+
+	return 0;
+}
+
+static int file_has_perm(const struct cred *cred,
+			 struct file *file,
+			 int mask)
+{
+	struct inode *inode = file_inode(file);
+	struct common_audit_data ad;
+	int rc;
+
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+
+	/* av is zero if only checking access to the descriptor. */
+	rc = 0;
+	if (mask)
+		rc = inode_has_perm(cred, inode, mask, &ad);
+
+	return rc;
+}
+
+/* Same as path_has_perm, but uses the inode from the file struct. */
+static inline int file_path_has_perm(const struct cred *cred,
+				     struct file *file,
+				     int mask)
+{
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+
+	return inode_has_perm(cred, file_inode(file), mask, &ad);
+}
+
+static int infoflow_revalidate_file_permission(struct file *file, int mask)
+{
+	const struct cred *cred = current_cred();
+
+	return file_has_perm(cred, file, mask);
+}
+
+static int infoflow_file_permission(struct file *file, int mask)
+{
+	const struct cred *cred = current_cred();
+	struct inode *inode = file_inode(file);
+	struct file_security_struct *fsec = infoflow_file(file);
+	u32 ssid, isid;
+
+	if (!mask)
+		/* No permission to check.  Existence test. */
+		return 0;
+
+	validate_creds(cred);
+	security_cred_getsecid(cred, &ssid);
+
+	security_inode_getsecid(inode, &isid);
+
+	if (ssid == fsec->sid && fsec->isid == isid &&
+	    fsec->pseqno == infoflow_seqno)
+		/* No change since file_open check. */
+		return 0;
+
+	return infoflow_revalidate_file_permission(file, mask);
+}
+
+static int infoflow_file_receive(struct file *file)
+{
+	const struct cred *cred = current_cred();
+
+	return file_has_perm(cred, file, infoflow_file_f_mode_to_mask(file));
+}
+
+static int infoflow_file_open(struct file *file)
+{
+	struct file_security_struct *fsec;
+	u32 isid;
+
+	fsec = infoflow_file(file);
+
+	security_inode_getsecid(file_inode(file), &isid);
+
+	fsec->isid = isid;
+	fsec->pseqno = infoflow_seqno;
+
+	return file_path_has_perm(file->f_cred, file,
+				  infoflow_file_f_mode_to_mask(file));
+}
+
+static int infoflow_kernel_module_from_file(struct file *file, bool module)
+{
+	struct common_audit_data ad;
+	const struct cred *cred = current_cred();
+	enum infoflow_class class = CLASS_MODULE;
+	struct inode *inode;
+	u32 ssid, isid;
+	u8 *iflags;
+
+	validate_creds(cred);
+	security_cred_getsecid(cred, &ssid);
+
+	/* init_module */
+	if (file == NULL) {
+		if (!module)
+			class = CLASS_UNDEFINED;
+
+		return infoflow_allow_access(CLASS_KERNEL, ssid, class, ssid,
+					     NULL, MAY_READ, NULL);
+	}
+
+	/* finit_module */
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+
+	inode = file_inode(file);
+	security_inode_getsecid(inode, &isid);
+	iflags = infoflow_inode(inode);
+
+	if (!module)
+		class = infoflow_inode_class(inode->i_mode);
+
+	return infoflow_allow_access(CLASS_KERNEL, ssid, class, isid, iflags,
+				     MAY_READ, &ad);
+}
+
+static int infoflow_kernel_read_file(struct file *file,
+				     enum kernel_read_file_id id)
+{
+	return infoflow_kernel_module_from_file(file, id == READING_MODULE);
+}
+
+static int infoflow_kernel_load_data(enum kernel_load_data_id id)
+{
+	return infoflow_kernel_module_from_file(NULL, id == LOADING_MODULE);
+}
+
+static int infoflow_setprocattr(const char *name, void *value, size_t size)
+{
+	const struct cred *cred = current_cred();
+	struct infoflow_ctx *old_ctx, *new_ctx;
+	u32 old_ssid, new_ssid;
+	int rc;
+
+	if (strcmp(name, "current"))
+		return 0;
+
+	validate_creds(cred);
+	security_cred_getsecid(cred, &old_ssid);
+
+	old_ctx = infoflow_ctx_find_sid(CLASS_PROCESS, old_ssid);
+
+	rc = security_secctx_to_secid((char *)value, size, &new_ssid);
+	if (rc < 0)
+		return -EPERM;
+
+	new_ctx = infoflow_ctx_find_sid(CLASS_PROCESS, new_ssid);
+
+	/* We cannot let a non-TCB process go inside the TCB, because
+	 * load-time integrity of non-TCB processes cannot be determined.
+	 */
+	if ((!old_ctx || !(old_ctx->flags & CTX_FLAG_TCB)) &&
+	    new_ctx && (new_ctx->flags & CTX_FLAG_TCB))
+		return -EPERM;
+
+	return 0;
+}
+
+static int ipc_has_perm(const struct cred *cred, u32 sid,
+			enum infoflow_class oclass,
+			struct kern_ipc_perm *ipc_perms, int mask)
+{
+	struct common_audit_data ad;
+	u32 ssid, isid;
+
+	if (cred) {
+		validate_creds(cred);
+		security_cred_getsecid(cred, &ssid);
+	} else {
+		ssid = sid;
+	}
+
+	security_ipc_getsecid(ipc_perms, &isid);
+
+	ad.type = LSM_AUDIT_DATA_IPC;
+	ad.u.ipc_id = ipc_perms->key;
+
+	return infoflow_allow_access(CLASS_PROCESS, ssid, oclass, isid, NULL,
+				     mask, &ad);
+}
+
+static int infoflow_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
+{
+	const struct cred *cred = current_cred();
+	int mask = 0;
+
+	if (flag & S_IRUGO)
+		mask |= MAY_READ;
+	if (flag & S_IWUGO)
+		mask |= MAY_WRITE;
+
+	if (mask == 0)
+		return 0;
+
+	return ipc_has_perm(cred, 0, CLASS_IPC, ipcp, mask);
+}
+
+static int infoflow_msg_queue_msgsnd(struct kern_ipc_perm *msq,
+				     struct msg_msg *msg, int msqflg)
+{
+	const struct cred *cred = current_cred();
+
+	return ipc_has_perm(cred, 0, CLASS_MSGQ, msq, MAY_WRITE);
+}
+
+static int infoflow_msg_queue_msgrcv(struct kern_ipc_perm *msq,
+				     struct msg_msg *msg,
+				     struct task_struct *target,
+				     long type, int mode)
+{
+	u32 ssid;
+
+	security_task_getsecid(target, &ssid);
+
+	return ipc_has_perm(NULL, ssid, CLASS_MSGQ, msq, MAY_READ);
+}
+
+static int infoflow_shm_shmat(struct kern_ipc_perm *shp,
+			      char __user *shmaddr, int shmflg)
+{
+	const struct cred *cred = current_cred();
+	int mask;
+
+	if (shmflg & SHM_RDONLY)
+		mask = MAY_READ;
+	else
+		mask = MAY_READ | MAY_WRITE;
+
+	return ipc_has_perm(cred, 0, CLASS_SHM, shp, mask);
+}
+
+/* Note, at this point, sma is locked down */
+static int infoflow_sem_semctl(struct kern_ipc_perm *sma, int cmd)
+{
+	const struct cred *cred = current_cred();
+	int mask;
+
+	switch (cmd) {
+	case GETVAL:
+	case GETALL:
+		mask = MAY_READ;
+		break;
+	case SETVAL:
+	case SETALL:
+		mask = MAY_WRITE;
+		break;
+	default:
+		return 0;
+	}
+
+	return ipc_has_perm(cred, 0, CLASS_SEM, sma, mask);
+}
+
+static int infoflow_sem_semop(struct kern_ipc_perm *sma,
+			      struct sembuf *sops, unsigned nsops, int alter)
+{
+	const struct cred *cred = current_cred();
+	int mask;
+
+	if (alter)
+		mask = MAY_READ | MAY_WRITE;
+	else
+		mask = MAY_READ;
+
+	return ipc_has_perm(cred, 0, CLASS_SEM, sma, mask);
+}
+
+static int infoflow_socket_unix_may_send(struct socket *sock,
+					 struct socket *other)
+{
+	struct common_audit_data ad;
+	struct lsm_network_audit net = {0,};
+	struct flowi fl_sock, fl_other;
+
+	ad.type = LSM_AUDIT_DATA_NET;
+	ad.u.net = &net;
+	ad.u.net->sk = other->sk;
+
+	security_sk_classify_flow(sock->sk, &fl_sock);
+	security_sk_classify_flow(other->sk, &fl_other);
+
+	return infoflow_allow_access(CLASS_PROCESS, fl_sock.flowi_secid,
+				     CLASS_SOCKET, fl_other.flowi_secid,
+				     NULL, MAY_WRITE, &ad);
+}
+
+static int sock_has_perm(struct sock *sk, int mask)
+{
+	const struct cred *cred = current_cred();
+	struct common_audit_data ad;
+	struct lsm_network_audit net = {0,};
+	struct flowi fl_sk;
+	u32 ssid;
+
+	ad.type = LSM_AUDIT_DATA_NET;
+	ad.u.net = &net;
+	ad.u.net->sk = sk;
+
+	validate_creds(cred);
+	security_cred_getsecid(cred, &ssid);
+
+	security_sk_classify_flow(sk, &fl_sk);
+
+	return infoflow_allow_access(CLASS_PROCESS, ssid, CLASS_SOCKET,
+				     fl_sk.flowi_secid, NULL, mask, &ad);
+}
+
+static int infoflow_socket_sendmsg(struct socket *sock, struct msghdr *msg,
+				   int size)
+{
+	return sock_has_perm(sock->sk, MAY_WRITE);
+}
+
+static int infoflow_socket_recvmsg(struct socket *sock, struct msghdr *msg,
+				   int size, int flags)
+{
+	return sock_has_perm(sock->sk, MAY_READ);
+}
+
+static int infoflow_audit_rule_init(u32 field, u32 op, char *rulestr,
+				    void **vrule)
+{
+	if (field != AUDIT_SUBJ_USER)
+		return -EINVAL;
+
+	if (op != Audit_equal && op != Audit_not_equal)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int infoflow_audit_rule_known(struct audit_krule *krule)
+{
+	struct audit_field *f;
+	int i;
+
+	for (i = 0; i < krule->field_count; i++) {
+		f = &krule->fields[i];
+
+		if (f->type == AUDIT_SUBJ_USER)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int infoflow_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+{
+	struct infoflow_ctx *ctx;
+
+	if (field != AUDIT_SUBJ_USER)
+		return 0;
+
+	if (!(infoflow_init_flags & INFOFLOW_PARENT_LSM_INIT))
+		return (op == Audit_equal) ? true : false;
+
+	ctx = infoflow_ctx_find_sid(CLASS_PROCESS, sid);
+
+	if (op == Audit_equal)
+		return (ctx && (ctx->flags & CTX_FLAG_TCB));
+	if (op == Audit_not_equal)
+		return (!ctx || !(ctx->flags & CTX_FLAG_TCB));
+
+	return 0;
+}
+
+struct lsm_blob_sizes infoflow_blob_sizes = {
+	.lbs_inode = sizeof(u8),
+	.lbs_file = sizeof(struct file_security_struct),
+};
+
+static struct security_hook_list infoflow_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(inode_init_security, infoflow_inode_init_security),
+
+	LSM_HOOK_INIT(d_instantiate, infoflow_d_instantiate),
+
+	LSM_HOOK_INIT(inode_permission, infoflow_inode_permission),
+	LSM_HOOK_INIT(inode_setxattr, infoflow_inode_setxattr),
+	LSM_HOOK_INIT(inode_post_setxattr, infoflow_inode_post_setxattr),
+	LSM_HOOK_INIT(inode_removexattr, infoflow_inode_removexattr),
+	LSM_HOOK_INIT(inode_setsecurity, infoflow_inode_setsecurity),
+
+	LSM_HOOK_INIT(file_permission, infoflow_file_permission),
+	LSM_HOOK_INIT(file_receive, infoflow_file_receive),
+	LSM_HOOK_INIT(file_open, infoflow_file_open),
+
+	LSM_HOOK_INIT(kernel_read_file, infoflow_kernel_read_file),
+	LSM_HOOK_INIT(kernel_load_data, infoflow_kernel_load_data),
+
+	LSM_HOOK_INIT(setprocattr, infoflow_setprocattr),
+
+	LSM_HOOK_INIT(ipc_permission, infoflow_ipc_permission),
+
+	LSM_HOOK_INIT(msg_queue_msgsnd, infoflow_msg_queue_msgsnd),
+	LSM_HOOK_INIT(msg_queue_msgrcv, infoflow_msg_queue_msgrcv),
+
+	LSM_HOOK_INIT(shm_shmat, infoflow_shm_shmat),
+
+	LSM_HOOK_INIT(sem_semctl, infoflow_sem_semctl),
+	LSM_HOOK_INIT(sem_semop, infoflow_sem_semop),
+
+	LSM_HOOK_INIT(unix_may_send, infoflow_socket_unix_may_send),
+	LSM_HOOK_INIT(socket_sendmsg, infoflow_socket_sendmsg),
+	LSM_HOOK_INIT(socket_recvmsg, infoflow_socket_recvmsg),
+
+#ifdef CONFIG_AUDIT
+	LSM_HOOK_INIT(audit_rule_init, infoflow_audit_rule_init),
+	LSM_HOOK_INIT(audit_rule_known, infoflow_audit_rule_known),
+	LSM_HOOK_INIT(audit_rule_match, infoflow_audit_rule_match),
+#endif
+
+};
+
+static __init int infoflow_init(void)
+{
+	int rc;
+
+	if (!infoflow_enabled)
+		return 0;
+
+	rc = register_blocking_lsm_notifier(&infoflow_lsm_nb);
+	if (rc) {
+		pr_warn("Couldn't register LSM notifier. rc %d\n", rc);
+		return rc;
+	}
+
+	security_add_hooks(infoflow_hooks, ARRAY_SIZE(infoflow_hooks),
+			   "infoflow");
+	return 0;
+}
+
+DEFINE_LSM(infoflow) = {
+	.name = "infoflow",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.blobs = &infoflow_blob_sizes,
+	.init = infoflow_init,
+};
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index fbe0bb5cd7c4..0a54e488409c 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -51,6 +51,7 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 #ifdef CONFIG_IMA_APPRAISE
 	{.name = XATTR_NAME_IMA},
 #endif
+	{.name = XATTR_NAME_INFOFLOW},
 	{.name = XATTR_NAME_CAPS},
 };
 
-- 
2.17.1

