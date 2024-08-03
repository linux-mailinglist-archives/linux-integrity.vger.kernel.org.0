Return-Path: <linux-integrity+bounces-3268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32609467D6
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224C01C20F0C
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A21534EA;
	Sat,  3 Aug 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hBejS61p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697614C585;
	Sat,  3 Aug 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722665333; cv=none; b=DigRLVzaPFJJ6mJwjFg374cnDr64naTScilRciTdAy72So3ZFMwXGm72bOHT6bJm65gAHMkkJwfek6lIWuRn8ilkXMCr56HpZU8OCtC2EF2aITm5uh0hWYx5KlmgOtOj0gGvaNHofECy6a9yNIWRhYAb2SwCV3Zs7vezYhBZxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722665333; c=relaxed/simple;
	bh=hNt9YKIiYbWRGDH8Un+/3lzsbdLnePPAKMRMAJxnGRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u2M2Bis8EwzFwmjNRbueR5pd5MDGgE8JpkvsBvG9ebsuM8kYVEzkRDk64wsxuUcUfRR24GqAbLT4OQDWjA9Docf4rddGnhJ2Dd/elNuTl0SVdcuFspckZGKyjzmpX7Lb/iTAWm/7gNK+r002Mtu0V4OCeh9RaMHT+Cmdw3k1ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hBejS61p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id A325520B7400; Fri,  2 Aug 2024 23:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A325520B7400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722665320;
	bh=9UhLGDFVq6In/RiEvnlkIWofY50pprHYF0RowKYTFWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBejS61p+aY6VywE/aMg1/kRU0BMZZBhftVx8dMOYJ2cF6jNVZZ4OcVBraYJ7iUrD
	 ts4LEVB7xYWEe3mdbuc4YV4DR2+bbFyQWEC96QsdZkUKDdZPNODPIX47stE4JbeMeR
	 fcMn58unQ137zgDrJFUs1R3wC7I/84fSFq3seJyk=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v20 10/20] ipe: add permissive toggle
Date: Fri,  2 Aug 2024 23:08:24 -0700
Message-Id: <1722665314-21156-11-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

IPE, like SELinux, supports a permissive mode. This mode allows policy
authors to test and evaluate IPE policy without it affecting their
programs. When the mode is changed, a 1404 AUDIT_MAC_STATUS will
be reported.

This patch adds the following audit records:

    audit: MAC_STATUS enforcing=0 old_enforcing=1 auid=4294967295
      ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
    audit: MAC_STATUS enforcing=1 old_enforcing=0 auid=4294967295
      ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1

The audit record only emit when the value from the user input is
different from the current enforce value.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
  + Split evaluation loop, access control hooks,
    and evaluation loop from policy parser and userspace
    interface to pass mailing list character limit

v3:
  + Move ipe_load_properties to patch 04.
  + Remove useless 0-initializations
  + Prefix extern variables with ipe_
  + Remove kernel module parameters, as these are
    exposed through sysctls.
  + Add more prose to the IPE base config option
    help text.
  + Use GFP_KERNEL for audit_log_start.
  + Remove unnecessary caching system.
  + Remove comments from headers
  + Use rcu_access_pointer for rcu-pointer null check
  + Remove usage of reqprot; use prot only.
  + Move policy load and activation audit event to 03/12

v4:
  + Remove sysctls in favor of securityfs nodes
  + Re-add kernel module parameters, as these are now
    exposed through securityfs.
  + Refactor property audit loop to a separate function.

v5:
  + fix minor grammatical errors
  + do not group rule by curly-brace in audit record,
    reconstruct the exact rule.

v6:
  + No changes

v7:
  + Further split lsm creation into a separate commit from the
    evaluation loop and audit system, for easier review.
  + Propagating changes to support the new ipe_context structure in the
    evaluation loop.
  + Split out permissive functionality into a separate patch for easier
    review.
  + Remove permissive switch compile-time configuration option - this
    is trivial to add later.

v8:
  + Remove "IPE" prefix from permissive audit record
  + align fields to the linux-audit field dictionary. This causes the
    following fields to change:
      enforce -> permissive

  + Remove duplicated information correlated with syscall record, that
    will always be present in the audit event.
  + Change audit types:
    + AUDIT_TRUST_STATUS -> AUDIT_MAC_STATUS
      + There is no significant difference in meaning between
        these types.

v9:
  + Clean up ipe_context related code

v10:
  + Change audit format to comform with the existing format selinux is
    using
  + Remove the audit record emission during init to align with selinux,
    which does not perform this action.

v11:
  + Remove redundant code

v12:
  + Remove redundant code

v13:
  + Remove audit format macro

v14:
  + No changes

v15:
  + No changes

v16:
  + No changes

v17:
  + Fix code and documentation style issues

v18:
  + No changes

v19:
  + No changes

v20:
  + No changes
---
 security/ipe/audit.c | 27 ++++++++++++++++--
 security/ipe/audit.h |  1 +
 security/ipe/eval.c  | 11 ++++++--
 security/ipe/eval.h  |  1 +
 security/ipe/fs.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 5a859f88cfb4..5af150d99d63 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -97,8 +97,8 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
 	if (!ab)
 		return;
 
-	audit_log_format(ab, "ipe_op=%s ipe_hook=%s pid=%d comm=",
-			 op, audit_hook_names[ctx->hook],
+	audit_log_format(ab, "ipe_op=%s ipe_hook=%s enforcing=%d pid=%d comm=",
+			 op, audit_hook_names[ctx->hook], READ_ONCE(enforce),
 			 task_tgid_nr(current));
 	audit_log_untrustedstring(ab, get_task_comm(comm, current));
 
@@ -225,3 +225,26 @@ void ipe_audit_policy_load(const struct ipe_policy *const p)
 
 	audit_log_end(ab);
 }
+
+/**
+ * ipe_audit_enforce() - Audit a change in IPE's enforcement state.
+ * @new_enforce: The new value enforce to be set.
+ * @old_enforce: The old value currently in enforce.
+ */
+void ipe_audit_enforce(bool new_enforce, bool old_enforce)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS);
+	if (!ab)
+		return;
+
+	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
+		  "enforcing=%d old_enforcing=%d auid=%u ses=%u"
+		  " enabled=1 old-enabled=1 lsm=ipe res=1",
+		  new_enforce, old_enforce,
+		  from_kuid(&init_user_ns, audit_get_loginuid(current)),
+		  audit_get_sessionid(current));
+
+	audit_log_end(ab);
+}
diff --git a/security/ipe/audit.h b/security/ipe/audit.h
index 3ba8b8a91541..ed2620846a79 100644
--- a/security/ipe/audit.h
+++ b/security/ipe/audit.h
@@ -14,5 +14,6 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
 void ipe_audit_policy_load(const struct ipe_policy *const p);
 void ipe_audit_policy_activation(const struct ipe_policy *const op,
 				 const struct ipe_policy *const np);
+void ipe_audit_enforce(bool new_enforce, bool old_enforce);
 
 #endif /* _IPE_AUDIT_H */
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index b99ed4bb09cf..b14c95768550 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -18,6 +18,7 @@
 
 struct ipe_policy __rcu *ipe_active_policy;
 bool success_audit;
+bool enforce = true;
 
 #define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
 
@@ -108,6 +109,7 @@ int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx)
 	enum ipe_action_type action;
 	enum ipe_match match_type;
 	bool match = false;
+	int rc = 0;
 
 	rcu_read_lock();
 
@@ -159,9 +161,12 @@ int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx)
 	rcu_read_unlock();
 
 	if (action == IPE_ACTION_DENY)
-		return -EACCES;
+		rc = -EACCES;
 
-	return 0;
+	if (!READ_ONCE(enforce))
+		rc = 0;
+
+	return rc;
 }
 
 /* Set the right module name */
@@ -172,3 +177,5 @@ int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx)
 
 module_param(success_audit, bool, 0400);
 MODULE_PARM_DESC(success_audit, "Start IPE with success auditing enabled");
+module_param(enforce, bool, 0400);
+MODULE_PARM_DESC(enforce, "Start IPE in enforce or permissive mode");
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index 42b74a7a7c2b..80b74f55fa69 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -16,6 +16,7 @@
 
 extern struct ipe_policy __rcu *ipe_active_policy;
 extern bool success_audit;
+extern bool enforce;
 
 struct ipe_superblock {
 	bool initramfs;
diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 9e410982b759..b52fb6023904 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -16,6 +16,7 @@ static struct dentry *np __ro_after_init;
 static struct dentry *root __ro_after_init;
 struct dentry *policy_root __ro_after_init;
 static struct dentry *audit_node __ro_after_init;
+static struct dentry *enforce_node __ro_after_init;
 
 /**
  * setaudit() - Write handler for the securityfs node, "ipe/success_audit"
@@ -65,6 +66,58 @@ static ssize_t getaudit(struct file *f, char __user *data,
 	return simple_read_from_buffer(data, len, offset, result, 1);
 }
 
+/**
+ * setenforce() - Write handler for the securityfs node, "ipe/enforce"
+ * @f: Supplies a file structure representing the securityfs node.
+ * @data: Supplies a buffer passed to the write syscall.
+ * @len: Supplies the length of @data.
+ * @offset: unused.
+ *
+ * Return:
+ * * Length of buffer written	- Success
+ * * %-EPERM			- Insufficient permission
+ */
+static ssize_t setenforce(struct file *f, const char __user *data,
+			  size_t len, loff_t *offset)
+{
+	int rc = 0;
+	bool new_value, old_value;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	old_value = READ_ONCE(enforce);
+	rc = kstrtobool_from_user(data, len, &new_value);
+	if (rc)
+		return rc;
+
+	if (new_value != old_value) {
+		ipe_audit_enforce(new_value, old_value);
+		WRITE_ONCE(enforce, new_value);
+	}
+
+	return len;
+}
+
+/**
+ * getenforce() - Read handler for the securityfs node, "ipe/enforce"
+ * @f: Supplies a file structure representing the securityfs node.
+ * @data: Supplies a buffer passed to the read syscall.
+ * @len: Supplies the length of @data.
+ * @offset: unused.
+ *
+ * Return: Length of buffer written
+ */
+static ssize_t getenforce(struct file *f, char __user *data,
+			  size_t len, loff_t *offset)
+{
+	const char *result;
+
+	result = ((READ_ONCE(enforce)) ? "1" : "0");
+
+	return simple_read_from_buffer(data, len, offset, result, 1);
+}
+
 /**
  * new_policy() - Write handler for the securityfs node, "ipe/new_policy".
  * @f: Supplies a file structure representing the securityfs node.
@@ -123,6 +176,11 @@ static const struct file_operations audit_fops = {
 	.read = getaudit,
 };
 
+static const struct file_operations enforce_fops = {
+	.write = setenforce,
+	.read = getenforce,
+};
+
 /**
  * ipe_init_securityfs() - Initialize IPE's securityfs tree at fsinit.
  *
@@ -149,6 +207,13 @@ static int __init ipe_init_securityfs(void)
 		goto err;
 	}
 
+	enforce_node = securityfs_create_file("enforce", 0600, root, NULL,
+					      &enforce_fops);
+	if (IS_ERR(enforce_node)) {
+		rc = PTR_ERR(enforce_node);
+		goto err;
+	}
+
 	policy_root = securityfs_create_dir("policies", root);
 	if (IS_ERR(policy_root)) {
 		rc = PTR_ERR(policy_root);
@@ -165,6 +230,7 @@ static int __init ipe_init_securityfs(void)
 err:
 	securityfs_remove(np);
 	securityfs_remove(policy_root);
+	securityfs_remove(enforce_node);
 	securityfs_remove(audit_node);
 	securityfs_remove(root);
 	return rc;
-- 
2.44.0


