Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454EF1A00C1
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Apr 2020 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDFWOy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 18:14:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58552 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDFWOy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 18:14:54 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4EE2E2072946;
        Mon,  6 Apr 2020 15:14:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EE2E2072946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586211287;
        bh=4BSd8VHxrq/4pF1CNq4Xs4AWz4SrQ/fLyD4CcqqG3lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbdqvNTdHm2x4zp3Q2ck1ImiL8kqeUVh0BGn4VsjgUo/9Yivq2rGKReL0PcE24WnZ
         dCE7AU8gI4wuQLMD75EBtdW4dxYop2QEDfyw2Ad8K0VXxKUhuwI2WGhvaQe9WdUY3H
         GskbXZM7hix639XVDVUUFxZ+9bxZfaKprT9uHkKo=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/12] security: add ipe lsm evaluation loop and audit system
Date:   Mon,  6 Apr 2020 15:14:29 -0700
Message-Id: <20200406221439.1469862-3-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Add the core logic of the IPE LSM, the evaluation loop (engine),
the audit system, and the skeleton of the policy structure.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 MAINTAINERS                      |   1 +
 include/uapi/linux/audit.h       |   4 +
 security/Kconfig                 |  12 +-
 security/Makefile                |   2 +
 security/ipe/.gitignore          |   2 +
 security/ipe/Kconfig             |  41 ++++
 security/ipe/Makefile            |  26 +++
 security/ipe/ipe-audit.c         | 313 ++++++++++++++++++++++++++++
 security/ipe/ipe-audit.h         |  76 +++++++
 security/ipe/ipe-engine.c        | 346 +++++++++++++++++++++++++++++++
 security/ipe/ipe-engine.h        |  49 +++++
 security/ipe/ipe-hooks.c         | 151 ++++++++++++++
 security/ipe/ipe-hooks.h         | 114 ++++++++++
 security/ipe/ipe-policy.h        |  62 ++++++
 security/ipe/ipe-prop-internal.h |  43 ++++
 security/ipe/ipe-property.c      | 112 ++++++++++
 security/ipe/ipe-property.h      | 159 ++++++++++++++
 security/ipe/ipe-sysfs.c         | 115 ++++++++++
 security/ipe/ipe-sysfs.h         |  21 ++
 security/ipe/ipe.c               |  99 +++++++++
 security/ipe/ipe.h               |  20 ++
 21 files changed, 1762 insertions(+), 6 deletions(-)
 create mode 100644 security/ipe/.gitignore
 create mode 100644 security/ipe/Kconfig
 create mode 100644 security/ipe/Makefile
 create mode 100644 security/ipe/ipe-audit.c
 create mode 100644 security/ipe/ipe-audit.h
 create mode 100644 security/ipe/ipe-engine.c
 create mode 100644 security/ipe/ipe-engine.h
 create mode 100644 security/ipe/ipe-hooks.c
 create mode 100644 security/ipe/ipe-hooks.h
 create mode 100644 security/ipe/ipe-policy.h
 create mode 100644 security/ipe/ipe-prop-internal.h
 create mode 100644 security/ipe/ipe-property.c
 create mode 100644 security/ipe/ipe-property.h
 create mode 100644 security/ipe/ipe-sysfs.c
 create mode 100644 security/ipe/ipe-sysfs.h
 create mode 100644 security/ipe/ipe.c
 create mode 100644 security/ipe/ipe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0462644271aa..ab9adcd37a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8442,6 +8442,7 @@ M:	Deven Bowers <deven.desai@linux.microsoft.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 F:	scripts/ipe/
+F:	security/ipe/
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index a534d71e689a..4e0122a0ed0c 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -153,6 +153,10 @@
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
 #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_INTEGRITY_POLICY_LOAD	1808 /* IPE Policy Load */
+#define AUDIT_INTEGRITY_POLICY_ACTIVATE	1809 /* IPE Policy Activation */
+#define AUDIT_INTEGRITY_EVENT		1810 /* IPE Evaluation Event */
+#define AUDIT_INTEGRITY_MODE		1811 /* IPE Mode Switch */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/Kconfig b/security/Kconfig
index cd3cc7da3a55..94924556b637 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -238,6 +238,7 @@ source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
+source "security/ipe/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -277,11 +278,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
+	default "lockdown,yama,loadpin,ipe,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
@@ -292,4 +293,3 @@ config LSM
 source "security/Kconfig.hardening"
 
 endmenu
-
diff --git a/security/Makefile b/security/Makefile
index 22e73a3482bd..f2e1ae9ff64b 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -13,6 +13,7 @@ subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
 subdir-$(CONFIG_BPF_LSM)		+= bpf
+subdir-$(CONFIG_SECURITY_IPE)		+= ipe
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
+obj-$(CONFIG_SECURITY_IPE)		+= ipe/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 
diff --git a/security/ipe/.gitignore b/security/ipe/.gitignore
new file mode 100644
index 000000000000..bbf824e665d7
--- /dev/null
+++ b/security/ipe/.gitignore
@@ -0,0 +1,2 @@
+# Generated Boot Policy
+ipe-bp.c
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
new file mode 100644
index 000000000000..0c67cd049d0c
--- /dev/null
+++ b/security/ipe/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Integrity Policy Enforcement (IPE) configuration
+#
+
+menuconfig SECURITY_IPE
+	bool "Integrity Policy Enforcement (IPE)"
+	depends on SECURITY && AUDIT
+	select SYSTEM_DATA_VERIFICATION
+	help
+	  This option enables the Integrity Policy Enforcement subsystem,
+	  allowing systems to enforce integrity requirements on various
+	  aspects of user-mode applications. These requirements are
+	  controlled by a policy.
+
+	  If unsure, answer N.
+
+if SECURITY_IPE
+
+config SECURITY_IPE_BOOT_POLICY
+	string "Integrity policy to apply on system startup"
+	help
+	  This option specifies a filepath to a IPE policy that is compiled
+	  into the kernel. This policy will be enforced until a policy update
+	  is deployed via the "ipe.policy" sysctl.
+
+	  If unsure, leave blank.
+
+config SECURITY_IPE_PERMISSIVE_SWITCH
+	bool "Enable the ability to switch IPE to permissive mode"
+	default y
+	help
+	  This option enables two ways of switching IPE to permissive mode,
+	  a sysctl (if enabled), `ipe.enforce`, or a kernel command line
+	  parameter, `ipe.enforce`. If either of these are set to 0, files
+	  will be subject to IPE's policy, audit messages will be logged, but
+	  the policy will not be enforced.
+
+	  If unsure, answer Y.
+
+endif
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
new file mode 100644
index 000000000000..aaa2e2c0b2f4
--- /dev/null
+++ b/security/ipe/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Microsoft Corporation. All rights reserved.
+#
+# Makefile for building the IPE module as part of the kernel tree.
+#
+
+quiet_cmd_polgen  = IPE_POL $(patsubst "%",%,$(2))
+      cmd_polgen  = scripts/ipe/polgen/polgen security/ipe/ipe-bp.c $(2)
+
+$(eval $(call config_filename,SECURITY_IPE_BOOT_POLICY))
+
+targets += ipe-bp.c
+$(obj)/ipe-bp.c: scripts/ipe/polgen/polgen $(SECURITY_IPE_BOOT_POLICY_FILENAME) FORCE
+	$(call if_changed,polgen,$(SECURITY_IPE_BOOT_POLICY_FILENAME))
+
+obj-$(CONFIG_SECURITY_IPE) += \
+	ipe.o \
+	ipe-audit.o \
+	ipe-bp.o \
+	ipe-engine.o \
+	ipe-property.o \
+	ipe-hooks.o \
+	ipe-sysfs.o \
+
+clean-files := ipe-bp.c
diff --git a/security/ipe/ipe-audit.c b/security/ipe/ipe-audit.c
new file mode 100644
index 000000000000..f83beff1054f
--- /dev/null
+++ b/security/ipe/ipe-audit.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-audit.h"
+#include "ipe-engine.h"
+#include "ipe-prop-internal.h"
+
+#include <linux/types.h>
+#include <linux/audit.h>
+#include <linux/rcupdate.h>
+#include <linux/lsm_audit.h>
+#include <linux/rbtree.h>
+#include <crypto/hash.h>
+#include <crypto/sha1_base.h>
+
+#define ACTION_STR(a) ((a) == ipe_action_allow ? "ALLOW" : "DENY")
+
+#define POLICY_LOAD_FSTR	"IPE policy_name=\"%s\" policy_version=%hu.%hu.%hu sha1="
+#define POLICY_ACTIVATE_STR	"IPE policy_name=\"%s\" policy_version=%hu.%hu.%hu"
+#define IPE_UNKNOWN		"UNKNOWN"
+
+/* Keep in sync with ipe_op in ipe-hooks.h */
+const char *audit_op_names[] = {
+	IPE_OP_EXECUTE,
+	IPE_OP_FIRMWARE,
+	IPE_OP_KEXEC_IMAGE,
+	IPE_OP_KEXEC_INITRAMFS,
+	IPE_OP_X509_CERTIFICATE,
+	IPE_OP_POLICY,
+	IPE_OP_KMODULE,
+	IPE_OP_KERNEL_READ,
+	IPE_UNKNOWN,
+};
+
+/* Keep in sync with ipe_hook in ipe-hooks.h */
+const char *audit_hook_names[] = {
+	IPE_HOOK_EXEC,
+	IPE_HOOK_MMAP,
+	IPE_HOOK_MPROTECT,
+	IPE_HOOK_KERNEL_READ,
+	IPE_HOOK_KERNEL_LOAD,
+	IPE_UNKNOWN,
+};
+
+/**
+ * ipe_audit_mode: Emit an audit event indicating what mode IPE is currently
+ *		   in.
+ *
+ * This event is of form "IPE mode=(enforce|audit)"
+ */
+void ipe_audit_mode(void)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_INTEGRITY_MODE);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "IPE mode=%s", (enforce) ? IPE_MODE_ENFORCE :
+							IPE_MODE_PERMISSIVE);
+
+	audit_log_end(ab);
+}
+
+/**
+ * audit_engine_ctx: Add the string representation of ipe_engine_ctx to the
+ *		     end of an audit buffer.
+ * @ab: the audit buffer to append the string representation of @ctx
+ * @ctx: the ipe_engine_ctx structure to transform into a string
+ *	 representation
+ *
+ * This string representation is of form:
+ * "ctx_pid=%d ctx_op=%s ctx_hook=%s ctx_comm=%s ctx_audit_pathname=%s ctx_ino=%ld ctx_dev=%s"
+ *
+ * Certain fields may be omitted or replaced with ERR(%d).
+ *
+ */
+static void audit_engine_ctx(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx)
+{
+	audit_log_format(ab, "ctx_pid=%d ctx_op=%s ctx_hook=%s ctx_comm=",
+			 task_tgid_nr(current),
+			 audit_op_names[ctx->op],
+			 audit_hook_names[ctx->hook]);
+
+	audit_log_untrustedstring(ab, current->comm);
+
+	if (ctx->file) {
+		if (IS_ERR(ctx->audit_pathname)) {
+			audit_log_format(ab, " ctx_audit_pathname=ERR(%ld) ",
+					 PTR_ERR(ctx->audit_pathname));
+		} else {
+			audit_log_format(ab, " ctx_audit_pathname=\"%s\" ",
+					 ctx->audit_pathname);
+		}
+
+		audit_log_format(ab, "ctx_ino=%ld ctx_dev=%s",
+				 ctx->file->f_inode->i_ino,
+				 ctx->file->f_inode->i_sb->s_id);
+	}
+}
+
+/**
+ * audit_eval_properties: Append the string representation of evaluated
+ *			  properties to an audit buffer.
+ * @ab: the audit buffer to append the string representation of the evaluated
+ *	properties.
+ * @ctx: the ipe_engine_ctx structure to pass to property audit function.
+ * @vals: The root of the red-black tree that is the per-evaluation
+ *	  cache for IPE's properties.
+ *
+ * This string representation is of form:
+ * "prop_key1=value1 prop_key2=value2 ... "
+ *
+ * Certain values may be replaced with ERR(%d). Prop may also be empty,
+ * and thus omitted entirely.
+ *
+ */
+static void audit_eval_properties(struct audit_buffer *ab,
+				  const struct ipe_engine_ctx *ctx,
+				  const struct rb_root *vals)
+{
+	struct rb_node *node;
+	struct ipe_prop_cache *val;
+
+	for (node = rb_first(vals); node; node = rb_next(node)) {
+		val = container_of(node, struct ipe_prop_cache, node);
+
+		audit_log_format(ab, "prop_%s=", val->prop->property_name);
+
+		val->prop->ctx_audit(ab, ctx, val->storage);
+
+		audit_log_format(ab, " ");
+	}
+}
+
+/**
+ * audit_rule: Add the string representation of a non-default IPE rule to the
+ *	       end of an audit buffer.
+ * @ab: the audit buffer to append the string representation of a rule.
+ * @rule: the ipe_rule structure to transform into a string representation.
+ *
+ * This string representation is of form:
+ * "rule={op=%s key1=value1 key2=value2 ... action=%s}"
+ *
+ * Certain values may be replaced with ERR(%d). Prop may also be empty.
+ *
+ */
+static void audit_rule(struct audit_buffer *ab,
+		       const struct ipe_rule *rule)
+{
+	struct ipe_prop_container *ptr;
+
+	audit_log_format(ab, "rule=\"op=%s ", audit_op_names[rule->op]);
+
+	list_for_each_entry(ptr, &rule->props, next) {
+		audit_log_format(ab, "%s=", ptr->prop->property_name);
+
+		ptr->prop->rule_audit(ab, ptr->value);
+
+		audit_log_format(ab, " ");
+	}
+
+	audit_log_format(ab, "action=%s\"", ACTION_STR(rule->action));
+}
+
+/**
+ * ipe_audit_match: Emit an audit event indicating that the IPE engine has
+ *		    determined a match to a rule in IPE policy.
+ * @ctx: the engine context structure to audit
+ * @vals: The root of the red-black tree that is the per-evaluation
+ *	  cache for IPE's properties.
+ * @rule: The rule that was matched. If NULL, then assumed to be a default
+ *	  either operation specific, indicated by table, or global.
+ * @table: the operation-specific rule table. If NULL, then it assumed
+ *	   that the global default is matched.
+ * @match_type: The type of match that the engine used during evaluation
+ * @action: The action that the engine decided to take
+ * @rule: The rule that was matched. Must be set if @match_type is
+ *	  ipe_match_rule and NULL otherwise.
+ */
+void ipe_audit_match(const struct ipe_engine_ctx *ctx,
+		     const struct rb_root *vals, enum ipe_match match_type,
+		     enum ipe_action action, const struct ipe_rule *rule)
+{
+	struct audit_buffer *ab;
+
+	if (!success_audit && action == ipe_action_allow)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_INTEGRITY_EVENT);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "IPE ");
+
+	audit_engine_ctx(ab, ctx);
+
+	audit_log_format(ab, " ");
+
+	audit_eval_properties(ab, ctx, vals);
+
+	if (match_type == ipe_match_rule)
+		audit_rule(ab, rule);
+	else if (match_type == ipe_match_table)
+		audit_log_format(ab, "rule=\"DEFAULT op=%s action=%s\"",
+				 audit_op_names[ctx->op], ACTION_STR(action));
+	else if (match_type == ipe_match_global)
+		audit_log_format(ab, "rule=\"DEFAULT action=%s\"",
+				 ACTION_STR(action));
+
+	audit_log_end(ab);
+}
+
+/**
+ * ipe_audit_policy_load: Emit an audit event that an IPE policy has been
+ *			  loaded, with the name of the policy, the policy
+ *			  version triple, and a flat hash of the content.
+ * @pol: The parsed policy to derive the policy_name and policy_version
+ *	 triple.
+ * @raw: The raw content that was passed to the ipe.policy sysctl to derive
+ *	 the sha1 hash.
+ * @raw_size: the length of @raw.
+ * @tfm: shash structure allocated by the caller, used to fingerprint the
+ *	 policy being deployed
+ */
+void ipe_audit_policy_load(const struct ipe_policy *pol, const uint8_t *raw,
+			   size_t raw_size, struct crypto_shash *tfm)
+{
+	int rc = 0;
+	struct audit_buffer *ab;
+	u8 digest[SHA1_DIGEST_SIZE];
+	SHASH_DESC_ON_STACK(desc, tfm);
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_INTEGRITY_POLICY_LOAD);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, POLICY_LOAD_FSTR, pol->policy_name,
+			 pol->policy_version.major, pol->policy_version.minor,
+			 pol->policy_version.rev);
+
+	desc->tfm = tfm;
+
+	if (crypto_shash_init(desc) != 0)
+		goto err;
+
+	if (crypto_shash_update(desc, raw, raw_size) != 0)
+		goto err;
+
+	if (crypto_shash_final(desc, digest) != 0)
+		goto err;
+
+	audit_log_n_hex(ab, digest, crypto_shash_digestsize(tfm));
+
+err:
+	if (rc != 0)
+		audit_log_format(ab, "ERR(%d)", rc);
+
+	audit_log_end(ab);
+}
+
+/**
+ * ipe_audit_unset_remap: Emit an warning indicating that the operation
+ *			  represented by @op is unset and will implicitly
+ *			  allow everything under that op.
+ * @op: the operation to emit an audit message for.
+ */
+void ipe_audit_unset_remap(enum ipe_op op)
+{
+	pr_warn("op=%s default was unset, remapping to \"DEFAULT op=%s action=ALLOW\" for compatibility",
+		audit_op_names[op],
+		audit_op_names[op]);
+}
+
+/**
+ * ipe_audit_ignore_line: Emit a warning that the line was not understood by
+ *			  IPE's parser and the line will be ignored and not
+ *			  parsed.
+ * @line_num: line number that is being ignored.
+ */
+void ipe_audit_ignore_line(size_t i)
+{
+	pr_warn("failed to parse line number %zu, ignoring", i);
+}
+
+/**
+ * ipe_audit_policy_activation: Emit an audit event that a specific policy
+ *				was activated as the active policy.
+ * @pol: policy that is being activated
+ */
+void ipe_audit_policy_activation(const struct ipe_policy *pol)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_INTEGRITY_POLICY_ACTIVATE);
+
+	if (!ab)
+		return;
+
+	audit_log_format(ab, POLICY_ACTIVATE_STR, pol->policy_name,
+			 pol->policy_version.major, pol->policy_version.minor,
+			 pol->policy_version.rev);
+
+	audit_log_end(ab);
+}
diff --git a/security/ipe/ipe-audit.h b/security/ipe/ipe-audit.h
new file mode 100644
index 000000000000..adb427e0e027
--- /dev/null
+++ b/security/ipe/ipe-audit.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-engine.h"
+#include "ipe-policy.h"
+
+#ifndef IPE_AUDIT_H
+#define IPE_AUDIT_H
+
+/**
+ * ipe_audit_mode: Emit an audit event indicating what mode IPE is current in.
+ *
+ * This event is of form "IPE mode=(enforce|audit)"
+ */
+void ipe_audit_mode(void);
+
+/**
+ * ipe_audit_match: Emit an audit event indicating that the IPE engine has
+ *		    determined a match to a rule in IPE policy.
+ * @ctx: the engine context structure to audit
+ * @vals: The root of the red-black tree that is the per-evaluation
+ *	  cache for IPE's properties.
+ * @rule: The rule that was matched. If NULL, then assumed to be a default
+ *	  either operation specific, indicated by table, or global.
+ * @table: the operation-specific rule table. If NULL, then it assumed
+ *	   that the global default is matched.
+ * @match_type: The type of match that the engine used during evaluation
+ * @action: The action that the engine decided to take
+ * @rule: The rule that was matched. Must be set if @match_type is
+ *	  ipe_match_rule and NULL otherwise.
+ */
+void ipe_audit_match(const struct ipe_engine_ctx *ctx,
+		     const struct rb_root *vals, enum ipe_match match_type,
+		     enum ipe_action action, const struct ipe_rule *rule);
+
+/**
+ * ipe_audit_policy_load: Emit an audit event that an IPE policy has been
+ *			  loaded, with the name of the policy, the policy
+ *			  version triple, and a flat hash of the content.
+ * @pol: The parsed policy to derive the policy_name and policy_version
+ *	 triple.
+ * @raw: The raw content that was passed to the ipe.policy sysctl to derive
+ *	 the sha1 hash.
+ * @raw_size: the length of @raw.
+ * @tfm: shash structure allocated by the caller, used to fingerprint the
+ *	 policy being deployed
+ */
+void ipe_audit_policy_load(const struct ipe_policy *pol, const uint8_t *raw,
+			   size_t raw_size, struct crypto_shash *tfm);
+
+/**
+ * ipe_audit_unset_remap: Emit an warning indicating that the operation
+ *			  represented by @op is unset and will implicitly
+ *			  allow everything under that op.
+ * @op: the operation to emit an audit message for.
+ */
+void ipe_audit_unset_remap(enum ipe_op op);
+
+/**
+ * ipe_audit_ignore_line: Emit a warning that the line was not understood by
+ *			  IPE's parser and the line will be ignored and not
+ *			  parsed.
+ * @line_num: line number that is being ignored.
+ */
+void ipe_audit_ignore_line(size_t line_num);
+
+/**
+ * ipe_audit_policy_activation: Emit an audit event that a specific policy
+ *				was activated as the active policy.
+ * @pol: policy that is being activated
+ */
+void ipe_audit_policy_activation(const struct ipe_policy *pol);
+
+#endif /* IPE_AUDIT_H */
diff --git a/security/ipe/ipe-engine.c b/security/ipe/ipe-engine.c
new file mode 100644
index 000000000000..9df17ebc1a01
--- /dev/null
+++ b/security/ipe/ipe-engine.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-property.h"
+#include "ipe-prop-internal.h"
+#include "ipe-policy.h"
+#include "ipe-engine.h"
+#include "ipe-audit.h"
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/rcupdate.h>
+#include <linux/security.h>
+
+const struct ipe_policy *ipe_active_policy;
+
+/**
+ * get_audit_pathname: Return the absolute path of the file struct passed in
+ * @file: file to derive an absolute path from.
+ *
+ * This function walks past chroots and mount points.
+ *
+ * Return:
+ * !NULL - OK
+ * ERR_PTR(-ENOENT) - No File
+ * ERR_PTR(-ENOMEM) - No Memory
+ * ERR_PTR(-ENAMETOOLONG) - Path Exceeds PATH_MAX
+ */
+static char *get_audit_pathname(const struct file *file)
+{
+	int rc = 0;
+	char *pos = NULL;
+	char *pathbuf = NULL;
+	struct super_block *sb;
+	char *temp_path = NULL;
+
+	/* No File to get Path From */
+	if (!file) {
+		rc = -ENOENT;
+		goto err;
+	}
+
+	sb = file->f_path.dentry->d_sb;
+
+	pathbuf = __getname();
+	if (!pathbuf) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	pos = d_absolute_path(&file->f_path, pathbuf, PATH_MAX);
+	if (IS_ERR(pos)) {
+		rc = PTR_ERR(pos);
+		goto err;
+	}
+
+	temp_path = __getname();
+	if (!temp_path) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	strlcpy(temp_path, pos, PATH_MAX);
+
+	if (pathbuf)
+		__putname(pathbuf);
+
+	return temp_path;
+err:
+	if (pathbuf)
+		__putname(pathbuf);
+	if (temp_path)
+		__putname(temp_path);
+
+	return ERR_PTR(rc);
+}
+
+/**
+ * free_ctx: free a previously allocated ipe_engine_ctx struct
+ * @ctx: structure to allocate.
+ *
+ * The caller is required to free @ctx, if previously allocated.
+ */
+static void free_ctx(struct ipe_engine_ctx *ctx)
+{
+	if (IS_ERR_OR_NULL(ctx))
+		return;
+
+	if (!IS_ERR_OR_NULL(ctx->audit_pathname))
+		__putname(ctx->audit_pathname);
+
+	kfree(ctx);
+}
+
+/**
+ * build_ctx: allocate a new ipe_engine_ctx structure
+ * @file: File that is being evaluated against IPE policy.
+ * @op: Operation that the file is being evaluated against.
+ * @hook: Specific hook that the file is being evaluated through.
+ *
+ * Return:
+ * !NULL - OK
+ * ERR_PTR(-ENOMEM) - no memory
+ */
+static struct ipe_engine_ctx *build_ctx(const struct file *file,
+					enum ipe_op op, enum ipe_hook hook)
+{
+	struct ipe_engine_ctx *local;
+
+	local = kzalloc(sizeof(*local), GFP_KERNEL);
+	if (!local)
+		return ERR_PTR(-ENOMEM);
+
+	/* if there's an error here, it's O.K. */
+	local->audit_pathname = get_audit_pathname(file);
+	local->file = file;
+	local->op = op;
+	local->hook = hook;
+
+	return local;
+}
+
+/**
+ * insert_or_find_cache: Create a node in a for a property if it does not exist,
+ *			 If it does exist, then return that node.
+ * @cache: the red-black tree root to create a tree around.
+ * @prop: the property to create a node for.
+ * @rv: ERR_PTR or the ipe_prop_cache structure that was inserted into the
+ *	tree.
+ *
+ * These nodes are used to be as a cache for properties to store expensive
+ * evaluation results
+ *
+ * Return:
+ * -ENOMEM: (No Memory)
+ */
+static
+struct ipe_prop_cache *insert_or_find_cache(struct rb_root *cache,
+					    const struct ipe_property *prop)
+{
+	struct rb_node *parent = NULL;
+	struct rb_node **new = &cache->rb_node;
+	struct ipe_prop_cache *new_data = NULL;
+
+	while (*new) {
+		int r;
+		struct ipe_prop_cache *n =
+			container_of(*new, struct ipe_prop_cache, node);
+
+		parent = *new;
+
+		r = strcmp(prop->property_name, n->prop->property_name);
+		if (r == 0)
+			return n;
+		else if (r > 0)
+			new = &((*new)->rb_right);
+		else
+			new = &((*new)->rb_left);
+	}
+
+	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
+	if (!new_data)
+		return ERR_PTR(-ENOMEM);
+
+	new_data->prop = prop;
+
+	rb_link_node(&new_data->node, parent, new);
+	rb_insert_color(&new_data->node, cache);
+
+	return new_data;
+}
+
+/**
+ * destroy_cache: dellocate an entire cache tree, where each node was
+ *		  created via `insert_or_find_cache`.
+ * @cache: the red-black tree root containing the structure to destroy.
+ *
+ * This function invalidates @cache, as the nodes are not removed from
+ * the tree.
+ */
+static void destroy_cache(struct rb_root *cache)
+{
+	struct ipe_prop_cache *ptr, *n;
+
+	rbtree_postorder_for_each_entry_safe(ptr, n, cache, node) {
+		if (ptr->prop->free_storage)
+			ptr->prop->free_storage(&ptr->storage);
+		kfree(ptr);
+	}
+}
+
+/**
+ * prealloc_cache: preallocate the cache tree for all ipe properties, so
+ *		   that this data maybe used later in the read side critical
+ *		   section.
+ * @ctx: Ipe engine context structure passed to the property prealloc function.
+ * @cache: Root of the cache tree to insert nodes under.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - Out of memory
+ * Other - See individual property preallocator functions.
+ */
+static int prealloc_cache(struct ipe_engine_ctx *ctx,
+			  struct rb_root *cache)
+{
+	int rc = 0;
+	struct rb_node *node;
+	struct ipe_prop_reg *reg;
+	struct ipe_prop_cache *storage;
+
+	for (node = rb_first(&ipe_registry_root); node; node = rb_next(node)) {
+		reg = container_of(node, struct ipe_prop_reg, node);
+
+		storage = insert_or_find_cache(cache, reg->prop);
+		if (IS_ERR(storage))
+			return PTR_ERR(storage);
+
+		if (reg->prop->prealloc) {
+			rc = reg->prop->prealloc(ctx, &storage->storage);
+			if (rc != 0)
+				return rc;
+		}
+	}
+
+	return rc;
+}
+
+/**
+ * evaluate: Process an @ctx against IPE's current active policy.
+ * @ctx: the engine ctx to perform an evaluation on.
+ * @cache: the red-black tree root that is used for cache storage.
+ *
+ * This uses a preallocated @cache as storage for the properties to avoid
+ * re-evaulation.
+ *
+ * Return:
+ * -EACCES - A match occurred against a "action=DENY" rule
+ * -ENOMEM - Out of memory
+ */
+static int evaluate(struct ipe_engine_ctx *ctx, struct rb_root *cache)
+{
+	int rc = 0;
+	bool match = false;
+	enum ipe_action action;
+	struct ipe_prop_cache *c;
+	enum ipe_match match_type;
+	const struct ipe_rule *rule;
+	const struct ipe_policy *pol;
+	const struct ipe_rule_table *rules;
+	const struct ipe_prop_container *prop;
+
+	if (!ipe_active_policy)
+		return rc;
+
+	rcu_read_lock();
+
+	pol = rcu_dereference(ipe_active_policy);
+
+	rules = &pol->ops[ctx->op];
+
+	list_for_each_entry(rule, &rules->rules, next) {
+		match = true;
+
+		list_for_each_entry(prop, &rule->props, next) {
+			void *cache = NULL;
+
+			if (prop->prop->prealloc) {
+				c = insert_or_find_cache(cache, prop->prop);
+				if (IS_ERR(c))
+					return PTR_ERR(c);
+
+				cache = c->storage;
+			}
+
+			match = match && prop->prop->eval(ctx, prop->value,
+							  &cache);
+		}
+
+		if (match)
+			break;
+	}
+
+	if (match) {
+		match_type = ipe_match_rule;
+		action = rule->action;
+	} else if (rules->def != ipe_action_unset) {
+		match_type = ipe_match_table;
+		action = rules->def;
+		rule = NULL;
+	} else {
+		match_type = ipe_match_global;
+		action = pol->def;
+		rule = NULL;
+	}
+
+	ipe_audit_match(ctx, cache, match_type, action, rule);
+
+	if (action == ipe_action_deny)
+		rc = -EACCES;
+
+	if (enforce == 0)
+		rc = 0;
+
+	rcu_read_unlock();
+	return rc;
+}
+
+/**
+ * ipe_process_event: Perform an evaluation of @file, @op, and @hook against
+ *		      IPE's current active policy.
+ * @file: File that is being evaluated against IPE policy.
+ * @op: Operation that the file is being evaluated against.
+ * @hook: Specific hook that the file is being evaluated through.
+ *
+ * Return:
+ * -ENOMEM: (No Memory)
+ * -EACCES: (A match occurred against a "action=DENY" rule)
+ */
+int ipe_process_event(const struct file *file, enum ipe_op op,
+		      enum ipe_hook hook)
+{
+	int rc = 0;
+	struct ipe_engine_ctx *ctx;
+	struct rb_root cache = RB_ROOT;
+
+	ctx = build_ctx(file, op, hook);
+	if (IS_ERR(ctx))
+		goto cleanup;
+
+	rc = prealloc_cache(ctx, &cache);
+	if (rc != 0)
+		goto cleanup;
+
+	rc = evaluate(ctx, &cache);
+
+cleanup:
+	free_ctx(ctx);
+	destroy_cache(&cache);
+	return rc;
+}
diff --git a/security/ipe/ipe-engine.h b/security/ipe/ipe-engine.h
new file mode 100644
index 000000000000..3f7c471929e2
--- /dev/null
+++ b/security/ipe/ipe-engine.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-hooks.h"
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/fs.h>
+
+#ifndef IPE_ENGINE_H
+#define IPE_ENGINE_H
+
+struct ipe_engine_ctx {
+	enum ipe_op op;
+	enum ipe_hook hook;
+	const struct file *file;
+	const char *audit_pathname;
+};
+
+struct ipe_prop_cache {
+	struct rb_node node;
+	void *storage;
+	const struct ipe_property *prop;
+};
+
+enum ipe_match {
+	ipe_match_rule = 0,
+	ipe_match_table,
+	ipe_match_global
+};
+
+/**
+ * ipe_process_event: Perform an evaluation of @file, @op, and @hook against
+ *		      IPE's current active policy.
+ *
+ * @ctx: the engine ctx to perform an evaluation on.
+ * @cache: the red-black tree root that is used for cache storage.
+ * @rv: standard return code.
+ *
+ * Return:
+ * -ENOMEM: (No Memory)
+ * -EACCES: (A match occurred against a "action=DENY" rule)
+ */
+int ipe_process_event(const struct file *file, enum ipe_op op,
+		      enum ipe_hook hook);
+
+#endif /* IPE_ENGINE_H */
diff --git a/security/ipe/ipe-hooks.c b/security/ipe/ipe-hooks.c
new file mode 100644
index 000000000000..a5d37b87c0cd
--- /dev/null
+++ b/security/ipe/ipe-hooks.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-hooks.h"
+#include "ipe-engine.h"
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/binfmts.h>
+#include <linux/mount.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/security.h>
+
+#define HAS_EXEC(_p, _rp) (((_rp) & PROT_EXEC) || ((_p) & PROT_EXEC))
+
+/**
+ * ipe_on_exec: LSM hook called on the exec family of system calls.
+ * @bprm: A structure to hold arguments that are used when loading binaries,
+ *	  used to extract the file being executed.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_exec(struct linux_binprm *bprm)
+{
+	return ipe_process_event(bprm->file, ipe_op_execute, ipe_hook_exec);
+}
+
+/**
+ * ipe_on_mmap: LSM hook called on the mmap system call.
+ * @file: File being mapped into memory.
+ * @reqprot: Usermode requested protections on the memory region.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ * @flags: Unused.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mmap(struct file *file, unsigned long reqprot, unsigned long prot,
+		unsigned long flags)
+{
+	if (HAS_EXEC(reqprot, prot))
+		return ipe_process_event(file, ipe_op_execute, ipe_hook_mmap);
+
+	return 0;
+}
+
+/**
+ * ipe_on_mprotect: LSM hook called on the mprotect system call
+ * @vma: A structure representing the existing memory region.
+ * @reqprot: Usermode requested protections on the memory region.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		    unsigned long prot)
+{
+	if (HAS_EXEC(reqprot, prot) && !(vma->vm_flags & VM_EXEC))
+		return ipe_process_event(vma->vm_file, ipe_op_execute,
+					 ipe_hook_mprotect);
+
+	return 0;
+}
+
+/**
+ * ipe_on_kernel_read: LSM hook called on kernel_read_file.
+ * @file: File being read by the hook kernel_read_file.
+ * @id: Enumeration indicating the type of file being read.
+ *
+ * For more information, see the LSM hook, kernel_read_file.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_read(struct file *file, enum kernel_read_file_id id)
+{
+	switch (id) {
+	case READING_FIRMWARE:
+	case READING_FIRMWARE_PREALLOC_BUFFER:
+		return ipe_process_event(file, ipe_op_firmware,
+					 ipe_hook_kernel_read);
+	case READING_MODULE:
+		return ipe_process_event(file, ipe_op_kmodule,
+					 ipe_hook_kernel_read);
+	case READING_KEXEC_INITRAMFS:
+		return ipe_process_event(file, ipe_op_kexec_initramfs,
+					 ipe_hook_kernel_read);
+	case READING_KEXEC_IMAGE:
+		return ipe_process_event(file, ipe_op_kexec_image,
+					 ipe_hook_kernel_read);
+	case READING_POLICY:
+		return ipe_process_event(file, ipe_op_policy,
+					 ipe_hook_kernel_read);
+	case READING_X509_CERTIFICATE:
+		return ipe_process_event(file, ipe_op_x509,
+					 ipe_hook_kernel_read);
+	default:
+		return ipe_process_event(file, ipe_op_kernel_read,
+					 ipe_hook_kernel_read);
+	}
+}
+
+/**
+ * ipe_on_kernel_load_data: LSM hook called on kernel_load_data.
+ * @id: Enumeration indicating what type of data is being loaded.
+ *
+ * For more information, see the LSM hook, kernel_load_data.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_load_data(enum kernel_load_data_id id)
+{
+	switch (id) {
+	case LOADING_FIRMWARE:
+	case LOADING_FIRMWARE_PREALLOC_BUFFER:
+		return ipe_process_event(NULL, ipe_op_firmware,
+					 ipe_hook_kernel_load);
+	case LOADING_MODULE:
+		return ipe_process_event(NULL, ipe_op_kmodule,
+					 ipe_hook_kernel_load);
+	case LOADING_KEXEC_INITRAMFS:
+		return ipe_process_event(NULL, ipe_op_kexec_initramfs,
+					 ipe_hook_kernel_load);
+	case LOADING_KEXEC_IMAGE:
+		return ipe_process_event(NULL, ipe_op_kexec_image,
+					 ipe_hook_kernel_load);
+	case LOADING_POLICY:
+		return ipe_process_event(NULL, ipe_op_policy,
+					 ipe_hook_kernel_load);
+	case LOADING_X509_CERTIFICATE:
+		return ipe_process_event(NULL, ipe_op_x509,
+					 ipe_hook_kernel_load);
+	default:
+		return ipe_process_event(NULL, ipe_op_kernel_read,
+					 ipe_hook_kernel_load);
+	}
+}
diff --git a/security/ipe/ipe-hooks.h b/security/ipe/ipe-hooks.h
new file mode 100644
index 000000000000..6af706a130ce
--- /dev/null
+++ b/security/ipe/ipe-hooks.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/binfmts.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/security.h>
+
+#ifndef IPE_HOOK_H
+#define IPE_HOOK_H
+
+#define IPE_HOOK_EXEC		"EXEC"
+#define IPE_HOOK_MMAP		"MMAP"
+#define IPE_HOOK_MPROTECT	"MPROTECT"
+#define IPE_HOOK_KERNEL_READ	"KERNEL_READ"
+#define IPE_HOOK_KERNEL_LOAD	"KERNEL_LOAD"
+
+enum ipe_hook {
+	ipe_hook_exec = 0,
+	ipe_hook_mmap,
+	ipe_hook_mprotect,
+	ipe_hook_kernel_read,
+	ipe_hook_kernel_load,
+	ipe_hook_max
+};
+
+/*
+ * The sequence between ipe_op_firmware and ipe_op_kmodule
+ * must remain the same for ipe_op_kernel read to function
+ * appropriately.
+ */
+enum ipe_op {
+	ipe_op_execute = 0,
+	ipe_op_firmware,
+	ipe_op_kexec_image,
+	ipe_op_kexec_initramfs,
+	ipe_op_x509,
+	ipe_op_policy,
+	ipe_op_kmodule,
+	ipe_op_kernel_read,
+	ipe_op_max
+};
+
+/**
+ * ipe_on_exec: LSM hook called on the exec family of system calls.
+ * @bprm: A structure to hold arguments that are used when loading binaries,
+ *	  used to extract the file being executed.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_exec(struct linux_binprm *bprm);
+
+/**
+ * ipe_on_mmap: LSM hook called on the mmap system call
+ * @file: File being mapped into memory.
+ * @reqprot: Usermode requested protections on the memory region.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ * @flags: unused.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mmap(struct file *file, unsigned long reqprot, unsigned long prot,
+		unsigned long flags);
+
+/**
+ * ipe_on_mprotect: LSM hook called on the mprotect system call
+ * @vma: A structure representing the existing memory region.
+ * @reqprot: Usermode requested protections on the memory region.
+ * @prot: A protection mapping of the memory region, calculated based on
+ *	  @reqprot, and the system configuration.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		    unsigned long prot);
+
+/**
+ * ipe_on_kernel_read: LSM hook called on kernel_read_file.
+ * @file: File being read by the hook kernel_read_file.
+ * @id: Enumeration indicating the type of file being read.
+ *
+ * For more information, see the LSM hook, kernel_read_file.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_read(struct file *file, enum kernel_read_file_id id);
+
+/**
+ * ipe_on_kernel_load_data: LSM hook called on kernel_load_data.
+ * @id: Enumeration indicating what type of data is being loaded.
+ *
+ * For more information, see the LSM hook, kernel_load_data.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - see ipe_process_event
+ */
+int ipe_on_kernel_load_data(enum kernel_load_data_id id);
+
+#endif /* IPE_HOOK_H */
diff --git a/security/ipe/ipe-policy.h b/security/ipe/ipe-policy.h
new file mode 100644
index 000000000000..c0c9f2962c92
--- /dev/null
+++ b/security/ipe/ipe-policy.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-hooks.h"
+#include "ipe-property.h"
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+
+#ifndef IPE_POLICY_H
+#define IPE_POLICY_H
+
+#define IPE_HEADER_POLICY_NAME		"policy_name"
+#define IPE_HEADER_POLICY_VERSION	"policy_version"
+
+extern const char *const ipe_boot_policy;
+extern const struct ipe_policy *ipe_active_policy;
+
+enum ipe_action {
+	ipe_action_unset = 0,
+	ipe_action_allow,
+	ipe_action_deny
+};
+
+struct ipe_prop_container {
+	struct list_head next;
+	void *value;
+	const struct ipe_property *prop;
+};
+
+struct ipe_rule {
+	struct list_head props;
+	struct list_head next;
+	enum ipe_action action;
+	enum ipe_op op;
+};
+
+struct ipe_rule_table {
+	struct list_head rules;
+	enum ipe_action def;
+};
+
+struct ipe_pol_ver {
+	u16 major;
+	u16 minor;
+	u16 rev;
+};
+
+struct ipe_policy {
+	char *policy_name;
+	struct ipe_pol_ver policy_version;
+	enum ipe_action def;
+
+	/* KERNEL_READ stores no data itself */
+	struct ipe_rule_table ops[ipe_op_max - 1];
+};
+
+#endif /* IPE_POLICY_H */
diff --git a/security/ipe/ipe-prop-internal.h b/security/ipe/ipe-prop-internal.h
new file mode 100644
index 000000000000..238d31a40169
--- /dev/null
+++ b/security/ipe/ipe-prop-internal.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-property.h"
+
+#include <linux/types.h>
+
+#ifndef IPE_PROPERTY_INTERNAL_H
+#define IPE_PROPERTY_INTERNAL_H
+
+#define IPE_PROPERTY_OPERATION	"op"
+#define IPE_PROPERTY_DEFAULT	"DEFAULT"
+#define IPE_PROPERTY_ACTION	"action"
+
+#define IPE_OP_EXECUTE		"EXECUTE"
+#define IPE_OP_FIRMWARE		"FIRMWARE"
+#define IPE_OP_KEXEC_IMAGE	"KEXEC_IMAGE"
+#define IPE_OP_KEXEC_INITRAMFS	"KEXEC_INITRAMFS"
+#define IPE_OP_X509_CERTIFICATE	"X509_CERT"
+#define IPE_OP_POLICY		"POLICY"
+#define IPE_OP_KMODULE		"KMODULE"
+#define IPE_OP_KERNEL_READ	"KERNEL_READ"
+
+struct ipe_prop_reg {
+	struct rb_node node;
+	const struct ipe_property *prop;
+};
+
+extern struct rb_root ipe_registry_root;
+
+/**
+ * ipe_lookup_prop: Attempt to find a ipe_property structure by name @key.
+ * @key: The property_name to look for in the tree.
+ *
+ * Return:
+ * ipe_property structure - OK
+ * NULL - No property exists under @key
+ */
+const struct ipe_property *ipe_lookup_prop(const char *key);
+
+#endif /* IPE_PROPERTY_INTERNAL_H */
diff --git a/security/ipe/ipe-property.c b/security/ipe/ipe-property.c
new file mode 100644
index 000000000000..675265a70327
--- /dev/null
+++ b/security/ipe/ipe-property.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-prop-internal.h"
+#include "ipe-property.h"
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+/* global root containing all registered properties */
+struct rb_root ipe_registry_root = RB_ROOT;
+
+/**
+ * reg_lookup: Attempt to find a `prop_reg` structure with property_name @key.
+ * @key: The property_name to look for in the tree.
+ *
+ * Return:
+ * ipe_prop_reg structure - OK
+ * NULL - No such property exists
+ */
+static struct ipe_prop_reg *reg_lookup(const char *key)
+{
+	struct rb_node *n = ipe_registry_root.rb_node;
+
+	while (n) {
+		int r;
+		struct ipe_prop_reg *reg =
+			container_of(n, struct ipe_prop_reg, node);
+
+		r = strcmp(reg->prop->property_name, key);
+		if (r == 0)
+			return reg;
+		else if (r > 0)
+			n = n->rb_right;
+		else
+			n = n->rb_left;
+	}
+
+	return NULL;
+}
+
+/**
+ * ipe_lookup_prop: Attempt to find a ipe_property structure by name @key.
+ * @key: The property_name to look for in the tree.
+ *
+ * Return:
+ * ipe_property structure - OK
+ * NULL - No property exists under @key
+ */
+const struct ipe_property *ipe_lookup_prop(const char *key)
+{
+	struct ipe_prop_reg *reg = reg_lookup(key);
+
+	if (!reg)
+		return NULL;
+
+	return reg->prop;
+}
+
+/**
+ * ipe_register_property: Insert a property into the registration system.
+ * @prop: Read-only property structure containing the property_name, as well
+ *	  as the necessary function pointers for a property.
+ *
+ * The caller needs to maintain the lifetime of @prop throughout the life of
+ * the system, after calling ipe_register_property.
+ *
+ * All necessary properties need to be loaded via this method before
+ * loading a policy, otherwise the properties will be ignored as unknown.
+ *
+ * Return:
+ * 0 - OK
+ * -EEXIST - A key exists with the name @prop->property_name
+ * -ENOMEM - Out of Memory
+ */
+int ipe_register_property(const struct ipe_property *prop)
+{
+	struct rb_node *parent = NULL;
+	struct ipe_prop_reg *new_data = NULL;
+	struct rb_node **new = &ipe_registry_root.rb_node;
+
+	while (*new) {
+		int r;
+		struct ipe_prop_reg *reg =
+			container_of(*new, struct ipe_prop_reg, node);
+
+		parent = *new;
+
+		r = strcmp(reg->prop->property_name, prop->property_name);
+		if (r == 0)
+			return -EEXIST;
+		else if (r > 0)
+			new = &((*new)->rb_right);
+		else
+			new = &((*new)->rb_left);
+	}
+
+	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
+	if (!new_data)
+		return -ENOMEM;
+
+	new_data->prop = prop;
+
+	rb_link_node(&new_data->node, parent, new);
+	rb_insert_color(&new_data->node, &ipe_registry_root);
+
+	return 0;
+}
diff --git a/security/ipe/ipe-property.h b/security/ipe/ipe-property.h
new file mode 100644
index 000000000000..c9462d219d43
--- /dev/null
+++ b/security/ipe/ipe-property.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-engine.h"
+
+#include <linux/types.h>
+#include <linux/lsm_audit.h>
+
+#ifndef IPE_PROPERTY_H
+#define IPE_PROPERTY_H
+
+/**
+ * ipe_property_alloc_storage: Function used to define cache allocations for
+ *			       individual properties.
+ * @ctx: Context structure of the engine for deriving potential information
+ *	 to be stored.
+ * @storage: Valid address to space for persistent storage for a
+ *	     distinct file structure. For the same file structure, this will
+ *	     be provided to ipe_property_evaluator, ipe_ctx_audit and
+ *	     ipe_free_storage.
+ *
+ * This is called prior to any evaluation of property, allowing
+ * individual properties to allocate a structure, and potentially
+ * populate a storage space to use during the evaluation.
+ *
+ * An potential example, would be storing the result of a hash or
+ * signature verification operation, such that it does not need to
+ * be done more than once.
+ *
+ * Optional, can be NULL - in which case, this will not be called.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - ERR, use Standard Return Codes
+ */
+typedef int (*ipe_property_alloc_storage)(const struct ipe_engine_ctx *ctx,
+					  void **storage);
+
+/**
+ * ipe_property_evaluator: Determines whether a file subject matches the
+ *			   property.
+ * @value: Value to compare against for a match
+ * @storage: Valid address to space for persistent storage for a
+ *	     distinct file object.
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited. See ipe_property_alloc_storage
+ *	 if allocations are required.
+ *
+ * Return:
+ * true - The property matches evaluation
+ * false - The property does not match evaluation
+ */
+typedef bool (*ipe_property_evaluator)(const struct ipe_engine_ctx *ctx,
+				       const void *value, void **storage);
+
+/**
+ * ipe_property_audit: Transform a rule value into a string representation.
+ * @ab: Audit buffer to add the string representation of @value to.
+ * @value: Value to transform into a string representation.
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited.
+ */
+typedef void (*ipe_property_audit)(struct audit_buffer *ab, const void *value);
+
+/**
+ * ipe_ctx_audit: Called by the auditing to provide the values
+ *	that were evaluated about the subject, @ctx->file, to determine how
+ *	a value was evaluated.
+ *
+ * NOTE: This is done in an rcu read critical section - sleeping
+ *	 allocations are prohibited.
+ *
+ * @ab: Audit buffer to add the string representation of @value to.
+ * @value: Value to transform into a string representation.
+ * @storage: Value that was placed in @storage of the evaluator.
+ *
+ */
+typedef void (*ipe_ctx_audit)(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx,
+			     const void *storage);
+
+/**
+ * ipe_parse_value: Transform a string representation of a rule into an
+ *		    internal ipe data-structure, opaque to the engine.
+ * @val_str: String-value parsed by the policy parser.
+ * @value: Valid-pointer indicating address to store parsed value.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - ERR, use Standard Return Codes
+ */
+typedef int(*ipe_parse_value)(const char *val_str, void **value);
+
+/**
+ * ipe_dup_val: Called by the policy parser to make duplicate properties for
+ *		pseudo-properties like "KERNEL_READ".
+ * @src:  Value to copy.
+ * @dest: Pointer to the destination where the value should be copied.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - ERR, use Standard Return Codes
+ */
+typedef int (*ipe_dup_val)(const void *src, void **dest);
+
+/**
+ * ipe_free_value: Free a policy value, created by ipe_parse_value.
+ * @value: Valid-pointer to the value to be interpreted and
+ *	   freed by the property.
+ *
+ * Optional, can be NULL - in which case, this will not be called.
+ */
+typedef void (*ipe_free_value)(void **value);
+
+/**
+ * ipe_free_storage: Free the storage allocated by
+ *		     ipe_property_prealloc_storage
+ * @storage: Valid-pointer to the value to be interpreted and
+ *	freed by the property.
+ *
+ * Optional, can be NULL - in which case, this will not be called.
+ */
+typedef void (*ipe_free_storage)(void **storage);
+
+struct ipe_property {
+	const char			*const property_name;
+	ipe_property_alloc_storage	prealloc;
+	ipe_property_evaluator		eval;
+	ipe_property_audit		rule_audit;
+	ipe_ctx_audit			ctx_audit;
+	ipe_parse_value			parse;
+	ipe_dup_val			dup;
+	ipe_free_value			free_val;
+	ipe_free_storage		free_storage;
+};
+
+/**
+ * ipe_register_property: Insert a property into the registration system.
+ * @prop: Read-only property structure containing the property_name, as well
+ *	  as the necessary function pointers for a property.
+ *
+ * The caller needs to maintain the lifetime of @prop throughout the life of
+ * the system, after calling ipe_register_property.
+ *
+ * All necessary properties need to be loaded via this method before
+ * loading a policy, otherwise the properties will be ignored as unknown.
+ *
+ * Return:
+ * 0 - OK
+ * -EEXIST - A key exists with the name @prop->property_name
+ * -ENOMEM - Out of memory
+ */
+int ipe_register_property(const struct ipe_property *prop);
+
+#endif /* IPE_PROPERTY_H */
diff --git a/security/ipe/ipe-sysfs.c b/security/ipe/ipe-sysfs.c
new file mode 100644
index 000000000000..c97685a25b6a
--- /dev/null
+++ b/security/ipe/ipe-sysfs.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-audit.h"
+
+#include <linux/sysctl.h>
+#include <linux/fs.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_SYSCTL
+
+#ifdef CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH
+
+/**
+ * ipe_switch_mode: Handler to switch IPE's modes between permissive
+ *		    and enforce.
+ * @table: Sysctl table entry from the variable, sysctl_table.
+ * @write: Integer indicating whether this is a write or a read.
+ * @buffer: Data passed to sysctl, this should be 1 or 0 for this function.
+ * @lenp: Pointer to the size of @buffer.
+ * @ppos: Offset into @buffer.
+ *
+ * This wraps proc_dointvec_minmax, and if there's a change, emits an
+ * audit event.
+ *
+ * Return:
+ * 0 - OK
+ * Other - See proc_dointvec_minmax
+ */
+static int ipe_switch_mode(struct ctl_table *table, int write,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int old = enforce;
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret == 0 && old != enforce)
+		ipe_audit_mode();
+
+	return ret;
+}
+
+#endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
+
+static struct ctl_table_header *sysctl_header;
+
+static const struct ctl_path sysctl_path[] = {
+	{
+		.procname = "ipe",
+	},
+	{}
+};
+
+static struct ctl_table sysctl_table[] = {
+#ifdef CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH
+	{
+		.procname = "enforce",
+		.data = &enforce,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = ipe_switch_mode,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	},
+#endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
+	{
+		.procname = "success_audit",
+		.data = &success_audit,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_minmax,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	},
+	{}
+	/* TODO: Active Policy Selector */
+};
+
+/**
+ * ipe_sysctl_init: Initialize IPE's sysfs entries.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - Sysctl registration failed
+ */
+int __init ipe_sysctl_init(void)
+{
+	sysctl_header = register_sysctl_paths(sysctl_path, sysctl_table);
+
+	if (!sysctl_header) {
+		pr_err("sysctl registration failed");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#else /* !CONFIG_SYSCTL */
+
+/**
+ * ipe_sysctl_init: Initialize IPE's sysfs entries.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - Sysctl registration failed
+ */
+inline int __init ipe_sysctl_init(void)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_SYSCTL */
diff --git a/security/ipe/ipe-sysfs.h b/security/ipe/ipe-sysfs.h
new file mode 100644
index 000000000000..7afd92e8220d
--- /dev/null
+++ b/security/ipe/ipe-sysfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+#include <linux/types.h>
+
+#include "ipe.h"
+
+#ifndef IPE_SYSFS_H
+#define IPE_SYSFS_H
+
+/**
+ * ipe_sysctl_init: Initialize IPE's sysfs entries.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - Sysctl registration failed
+ */
+int __init ipe_sysctl_init(void);
+
+#endif /* IPE_SYSFS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
new file mode 100644
index 000000000000..0c30d7c629c9
--- /dev/null
+++ b/security/ipe/ipe.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-policy.h"
+#include "ipe-hooks.h"
+#include "ipe-sysfs.h"
+
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+#include <linux/sysctl.h>
+#include <linux/rcupdate.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+
+static struct security_hook_list ipe_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, ipe_on_exec),
+	LSM_HOOK_INIT(mmap_file, ipe_on_mmap),
+	LSM_HOOK_INIT(kernel_read_file, ipe_on_kernel_read),
+	LSM_HOOK_INIT(kernel_load_data, ipe_on_kernel_load_data),
+	LSM_HOOK_INIT(file_mprotect, ipe_on_mprotect),
+};
+
+/**
+ * ipe_load_properties: Call the property entry points for all the IPE modules
+ *			that were selected at kernel build-time.
+ *
+ * Return:
+ * 0 - OK
+ */
+static int __init ipe_load_properties(void)
+{
+	return 0;
+}
+
+/**
+ * ipe_init: Entry point of IPE.
+ *
+ * This is called at LSM init, which happens occurs early during kernel
+ * start up. During this phase, IPE initializes the sysctls, loads the
+ * properties compiled into the kernel, and register's IPE's hooks.
+ * The boot policy is loaded later, during securityfs init, at which point
+ * IPE will start enforcing its policy.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - sysctl registration failed.
+ */
+static int __init ipe_init(void)
+{
+	int rc = 0;
+
+	rc = ipe_sysctl_init();
+	if (rc != 0)
+		pr_err("failed to configure sysctl: %d", -rc);
+
+	pr_info("mode=%s", (enforce == 1) ? IPE_MODE_ENFORCE :
+					    IPE_MODE_PERMISSIVE);
+
+	RCU_INIT_POINTER(ipe_active_policy, NULL);
+
+	security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), "IPE");
+
+	return rc;
+}
+
+DEFINE_LSM(ipe) = {
+	.name = "ipe",
+	.init = ipe_init,
+};
+
+int enforce = 1;
+
+#ifdef CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH
+
+/**
+ * enforce: Kernel command line parameter to set the permissive mode for IPE
+ *	    at system startup. By default, this will always be in enforce mode.
+ *
+ * This is also controlled by the sysctl, "ipe.enforce".
+ */
+module_param(enforce, int, 0644);
+MODULE_PARM_DESC(enforce, "enforce/permissive mode switch");
+
+#endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
+
+/**
+ * success_audit: Kernel command line parameter to enable success auditing
+ *		  (emit an audit event when a file is allowed) at system
+ *		  startup. By default, this will be off.
+ *
+ * This is also controlled by the sysctl, "ipe.success_audit".
+ */
+int success_audit;
+module_param(success_audit, int, 0644);
+MODULE_PARM_DESC(success_audit, "audit message on allow");
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
new file mode 100644
index 000000000000..52e5ea0ccaef
--- /dev/null
+++ b/security/ipe/ipe.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef IPE_H
+#define IPE_H
+
+#define pr_fmt(fmt) "IPE " fmt
+
+#include <linux/types.h>
+#include <linux/fs.h>
+
+#define IPE_MODE_ENFORCE	"enforce"
+#define IPE_MODE_PERMISSIVE	"permissive"
+
+extern int enforce;
+extern int success_audit;
+
+#endif /* IPE_H */
-- 
2.26.0

