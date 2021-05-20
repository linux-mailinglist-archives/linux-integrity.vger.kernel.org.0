Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C238A069
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhETI75 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:59:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3088 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhETI74 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:59:56 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Qb251gz6dtFb;
        Thu, 20 May 2021 16:52:23 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:58:33 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 5/7] evm: Verify portable signatures against all protected xattrs
Date:   Thu, 20 May 2021 10:56:59 +0200
Message-ID: <20210520085701.465369-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520085701.465369-1-roberto.sassu@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, the evm_config_default_xattrnames array contains xattr names
only related to LSMs which are enabled in the kernel configuration.
However, EVM portable signatures do not depend on local information and a
vendor might include in the signature calculation xattrs that are not
enabled in the target platform.

Just including all xattrs names in evm_config_default_xattrnames is not a
safe approach, because a target system might have already calculated
signatures or HMACs based only on the enabled xattrs. After applying this
patch, EVM would verify those signatures and HMACs with all xattrs instead.
The non-enabled ones, which could possibly exist, would cause a
verification error.

Thus, this patch adds a new field named enabled to the xattr_list
structure, which is set to true if the LSM associated to a given xattr name
is enabled in the kernel configuration. The non-enabled xattrs are taken
into account in only evm_calc_hmac_or_hash(), if the passed security.evm
type is EVM_XATTR_PORTABLE_DIGSIG.

The new function evm_protected_xattr_if_enabled() has been defined so that
IMA can include all protected xattrs and not only the enabled ones in the
measurement list, if the new template field evmxattrs has been included in
the template format.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h                 |  6 ++++
 security/integrity/evm/evm.h        |  1 +
 security/integrity/evm/evm_crypto.c |  7 ++++
 security/integrity/evm/evm_main.c   | 56 +++++++++++++++++++++++------
 security/integrity/evm/evm_secfs.c  | 16 +++++++--
 5 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 31ef1dbbb3ac..5011a299c251 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -38,6 +38,7 @@ extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
 extern bool evm_revalidate_status(const char *xattr_name);
+extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -114,5 +115,10 @@ static inline bool evm_revalidate_status(const char *xattr_name)
 	return false;
 }
 
+static inline int evm_protected_xattr_if_enabled(const char *req_xattr_name)
+{
+	return false;
+}
+
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f2fef2b5ed51..0d44f41d16f8 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -29,6 +29,7 @@
 struct xattr_list {
 	struct list_head list;
 	char *name;
+	bool enabled;
 };
 
 extern int evm_initialized;
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index d76b006cbcc4..1628e2ca9862 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -216,6 +216,13 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
 			is_ima = true;
 
+		/*
+		 * Skip non-enabled xattrs for locally calculated
+		 * signatures/HMACs.
+		 */
+		if (type != EVM_XATTR_PORTABLE_DIGSIG && !xattr->enabled)
+			continue;
+
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(xattr->name, req_xattr_name)) {
 			error = 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0196168aeb7d..ee4e17a790fb 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -34,24 +34,44 @@ static const char * const integrity_status_msg[] = {
 int evm_hmac_attrs;
 
 static struct xattr_list evm_config_default_xattrnames[] = {
+	{.name = XATTR_NAME_SELINUX,
 #ifdef CONFIG_SECURITY_SELINUX
-	{.name = XATTR_NAME_SELINUX},
+	 .enabled = true
 #endif
+	},
+	{.name = XATTR_NAME_SMACK,
 #ifdef CONFIG_SECURITY_SMACK
-	{.name = XATTR_NAME_SMACK},
+	 .enabled = true
+#endif
+	},
+	{.name = XATTR_NAME_SMACKEXEC,
+#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
+	 .enabled = true
+#endif
+	},
+	{.name = XATTR_NAME_SMACKTRANSMUTE,
 #ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
-	{.name = XATTR_NAME_SMACKEXEC},
-	{.name = XATTR_NAME_SMACKTRANSMUTE},
-	{.name = XATTR_NAME_SMACKMMAP},
+	 .enabled = true
 #endif
+	},
+	{.name = XATTR_NAME_SMACKMMAP,
+#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
+	 .enabled = true
 #endif
+	},
+	{.name = XATTR_NAME_APPARMOR,
 #ifdef CONFIG_SECURITY_APPARMOR
-	{.name = XATTR_NAME_APPARMOR},
+	 .enabled = true
 #endif
+	},
+	{.name = XATTR_NAME_IMA,
 #ifdef CONFIG_IMA_APPRAISE
-	{.name = XATTR_NAME_IMA},
+	 .enabled = true
 #endif
-	{.name = XATTR_NAME_CAPS},
+	},
+	{.name = XATTR_NAME_CAPS,
+	 .enabled = true
+	},
 };
 
 LIST_HEAD(evm_config_xattrnames);
@@ -76,7 +96,9 @@ static void __init evm_init_config(void)
 
 	pr_info("Initialising EVM extended attributes:\n");
 	for (i = 0; i < xattrs; i++) {
-		pr_info("%s\n", evm_config_default_xattrnames[i].name);
+		pr_info("%s%s\n", evm_config_default_xattrnames[i].name,
+			!evm_config_default_xattrnames[i].enabled ?
+			" (disabled)" : "");
 		list_add_tail(&evm_config_default_xattrnames[i].list,
 			      &evm_config_xattrnames);
 	}
@@ -257,7 +279,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	return evm_status;
 }
 
-static int evm_protected_xattr(const char *req_xattr_name)
+static int evm_protected_xattr_common(const char *req_xattr_name,
+				      bool all_xattrs)
 {
 	int namelen;
 	int found = 0;
@@ -265,6 +288,9 @@ static int evm_protected_xattr(const char *req_xattr_name)
 
 	namelen = strlen(req_xattr_name);
 	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
+		if (!all_xattrs && !xattr->enabled)
+			continue;
+
 		if ((strlen(xattr->name) == namelen)
 		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
 			found = 1;
@@ -281,6 +307,16 @@ static int evm_protected_xattr(const char *req_xattr_name)
 	return found;
 }
 
+static int evm_protected_xattr(const char *req_xattr_name)
+{
+	return evm_protected_xattr_common(req_xattr_name, false);
+}
+
+int evm_protected_xattr_if_enabled(const char *req_xattr_name)
+{
+	return evm_protected_xattr_common(req_xattr_name, true);
+}
+
 /**
  * evm_verifyxattr - verify the integrity of the requested xattr
  * @dentry: object of the verify xattr
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index c175e2b659e4..ec3ed75a347d 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -138,8 +138,12 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 	if (rc)
 		return -ERESTARTSYS;
 
-	list_for_each_entry(xattr, &evm_config_xattrnames, list)
+	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+		if (!xattr->enabled)
+			continue;
+
 		size += strlen(xattr->name) + 1;
+	}
 
 	temp = kmalloc(size + 1, GFP_KERNEL);
 	if (!temp) {
@@ -148,6 +152,9 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 	}
 
 	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+		if (!xattr->enabled)
+			continue;
+
 		sprintf(temp + offset, "%s\n", xattr->name);
 		offset += strlen(xattr->name) + 1;
 	}
@@ -198,6 +205,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		goto out;
 	}
 
+	xattr->enabled = true;
 	xattr->name = memdup_user_nul(buf, count);
 	if (IS_ERR(xattr->name)) {
 		err = PTR_ERR(xattr->name);
@@ -244,6 +252,10 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
 		if (strcmp(xattr->name, tmp->name) == 0) {
 			err = -EEXIST;
+			if (!tmp->enabled) {
+				tmp->enabled = true;
+				err = count;
+			}
 			mutex_unlock(&xattr_list_mutex);
 			goto out;
 		}
@@ -255,7 +267,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 	audit_log_end(ab);
 	return count;
 out:
-	audit_log_format(ab, " res=%d", err);
+	audit_log_format(ab, " res=%d", (err < 0) ? err : 0);
 	audit_log_end(ab);
 	if (xattr) {
 		kfree(xattr->name);
-- 
2.25.1

