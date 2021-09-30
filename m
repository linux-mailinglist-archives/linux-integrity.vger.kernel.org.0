Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D7741D936
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbhI3L6n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:58:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3900 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbhI3L6m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:58:42 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs8r5ryKz687L9;
        Thu, 30 Sep 2021 19:54:04 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:56:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 5/7] ima: Query metadata digest and retrieve info from its digest lists
Date:   Thu, 30 Sep 2021 13:55:31 +0200
Message-ID: <20210930115533.878169-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930115533.878169-1-roberto.sassu@huawei.com>
References: <20210930115533.878169-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

First, introduce the new function evm_get_hash() to obtain the EVM digest
of file metadata. The EVM digest is calculated depending on the passed
security.evm type.

Then, introduce the new function diglim_metadata_digest_lookup(), to search
the metadata digest obtained from evm_get_hash() with type
EVM_XATTR_PORTABLE_DIGSIG in the DIGLIM hash table and to obtain the
actions and modifiers (logical OR) associated to the EVM digest, taken from
the digest lists that contain that digest.

Retrieved actions and modifiers will be then processed by the corresponding
IMA submodules.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h               | 14 +++++++++
 security/integrity/evm/evm_main.c | 40 ++++++++++++++++++++++++
 security/integrity/ima/ima_main.c | 51 +++++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 4c374be70247..92856a7dbcab 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -11,6 +11,7 @@
 
 #include <linux/integrity.h>
 #include <linux/xattr.h>
+#include <crypto/hash_info.h>
 
 struct integrity_iint_cache;
 
@@ -42,6 +43,10 @@ extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 				     int buffer_size, char type,
 				     bool canonical_fmt);
+extern int evm_get_hash(struct dentry *dentry, const char *req_xattr_name,
+			const char *req_xattr_value, size_t req_xattr_value_len,
+			char type, enum hash_algo algo, u8 *digest,
+			size_t digest_len);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -129,6 +134,15 @@ static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 {
 	return -EOPNOTSUPP;
 }
+static inline int evm_get_hash(struct dentry *dentry,
+			       const char *req_xattr_name,
+			       const char *req_xattr_value,
+			       size_t req_xattr_value_len, char type,
+			       enum hash_algo algo, u8 *digest,
+			       size_t digest_len)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a8d7c761853e..3d45873f9266 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -429,6 +429,46 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(evm_verifyxattr);
 
+/**
+ * evm_get_hash - obtain the EVM digest calculated according to the passed type
+ * @dentry: object the EVM digest is calculated from
+ * @req_xattr_name: requested xattr
+ * @req_xattr_value: requested xattr value
+ * @req_xattr_value_len: requested xattr value length
+ * @type: requested security.evm type
+ * @algo: requested EVM digest algorithm
+ * @digest: the buffer the EVM digest is written to
+ * @digest_len: size of the buffer
+ *
+ * Calculate the EVM digest from metadata according to the passed security.evm
+ * type.
+ *
+ * Returns 0 if the digest has been calculated successfully, a negative value
+ * otherwise.
+ *
+ * This function requires the caller to lock the inode's i_mutex before it
+ * is executed.
+ */
+int evm_get_hash(struct dentry *dentry, const char *req_xattr_name,
+		 const char *req_xattr_value, size_t req_xattr_value_len,
+		 char type, enum hash_algo algo, u8 *digest, size_t digest_len)
+{
+	struct evm_digest evm_digest;
+	int rc;
+
+	if (digest_len < hash_digest_size[algo])
+		return -EINVAL;
+
+	evm_digest.hdr.algo = algo;
+	rc = evm_calc_hash(dentry, req_xattr_name, req_xattr_value,
+			   req_xattr_value_len, type, &evm_digest);
+	if (rc < 0)
+		return rc;
+
+	memcpy(digest, evm_digest.digest, hash_digest_size[algo]);
+	return 0;
+}
+
 /*
  * evm_verify_current_integrity - verify the dentry's metadata integrity
  * @dentry: pointer to the affected dentry
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b32c4f8d19ea..84ccb76f6c3c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
+#include <linux/evm.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
 
@@ -212,6 +213,44 @@ static void diglim_file_digest_lookup(struct file *file,
 			       COMPACT_FILE, modifiers, actions);
 }
 
+static void diglim_metadata_digest_lookup(struct file *file,
+					struct integrity_iint_cache *iint,
+					int action,
+					struct evm_ima_xattr_data *xattr_value,
+					int xattr_len, u16 *modifiers,
+					u8 *actions)
+{
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	struct evm_xattr fake_ima_xattr;
+	struct evm_ima_xattr_data *ima_xattr = xattr_value;
+	int rc;
+
+	if ((file->f_mode & FMODE_CREATED) && !i_size_read(file_inode(file)))
+		return;
+
+	if (!(iint->flags & IMA_COLLECTED))
+		return;
+
+	if (!xattr_value) {
+		fake_ima_xattr.data.type = IMA_XATTR_DIGEST_NG;
+		fake_ima_xattr.data.data[0] = iint->ima_hash->algo;
+		memcpy(&fake_ima_xattr.data.data[1], iint->ima_hash->digest,
+		       hash_digest_size[iint->ima_hash->algo]);
+		ima_xattr = &fake_ima_xattr.data;
+		xattr_len = 2 + hash_digest_size[iint->ima_hash->algo];
+	}
+
+	rc = evm_get_hash(file_dentry(file), XATTR_NAME_IMA,
+			  (const char *)ima_xattr, xattr_len,
+			  EVM_XATTR_PORTABLE_DIGSIG, iint->ima_hash->algo,
+			  digest, sizeof(digest));
+	if (rc < 0)
+		return;
+
+	diglim_digest_get_info(digest, iint->ima_hash->algo, COMPACT_METADATA,
+			       modifiers, actions);
+}
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
@@ -223,8 +262,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
 	u64 action;
-	u16 file_modifiers = 0;
-	u8 file_actions = 0;
+	u16 file_modifiers = 0, metadata_modifiers = 0;
+	u8 file_actions = 0, metadata_actions = 0;
 	int rc = 0, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
@@ -361,9 +400,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
 	if (iint->flags & IMA_USE_DIGLIM_MEASURE ||
-	    iint->flags & IMA_USE_DIGLIM_APPRAISE)
+	    iint->flags & IMA_USE_DIGLIM_APPRAISE) {
 		diglim_file_digest_lookup(file, iint, action, &file_modifiers,
 					  &file_actions);
+		inode_lock(inode);
+		diglim_metadata_digest_lookup(file, iint, action, xattr_value,
+					      xattr_len, &metadata_modifiers,
+					      &metadata_actions);
+		inode_unlock(inode);
+	}
 
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
-- 
2.32.0

