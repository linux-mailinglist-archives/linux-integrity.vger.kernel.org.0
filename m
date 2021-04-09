Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D20359DB0
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhDILpM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:45:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2824 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDILpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:45:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGx2R5SqRz686BJ;
        Fri,  9 Apr 2021 19:37:51 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:44:55 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 6/7] evm: Allow choice of hash algorithm for HMAC
Date:   Fri, 9 Apr 2021 13:43:12 +0200
Message-ID: <20210409114313.4073-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409114313.4073-1-roberto.sassu@huawei.com>
References: <20210409114313.4073-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 5feeb61183dd ("evm: Allow non-SHA1 digital signatures") introduced
the possibility to use a different hash algorithm for signatures, but kept
the algorithm for the HMAC hard-coded (SHA1). Switching to a different
algorithm for HMAC would require to change the code in different places.

This patch introduces a new global variable called evm_hash_algo, and
consistently uses it whenever EVM performs HMAC-related operations. This
variable can be modified at kernel build time with the new configuration
option called CONFIG_EVM_DEFAULT_HASH, or at run-time with the new option
evm_hash=.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 security/integrity/evm/Kconfig                | 34 ++++++++++++
 security/integrity/evm/evm.h                  |  2 +
 security/integrity/evm/evm_crypto.c           | 55 +++++++++++++++++--
 security/integrity/evm/evm_main.c             | 13 +++--
 security/integrity/integrity.h                |  3 +-
 6 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 265f7657f59d..f61ce44c5d8e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1343,6 +1343,14 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	evm_hash=	[EVM] Hash algorithm used to calculate the HMAC.
+			Format: { md5 | sha1 | rmd160 | sha256 | sha384
+				   | sha512 | ... }
+			default: "sha256"
+
+			The list of supported hash algorithms is defined
+			in crypto/hash_info.h.
+
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index a6e19d23e700..234077b24283 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -13,6 +13,40 @@ config EVM
 
 	  If you are unsure how to answer this question, answer N.
 
+choice
+	prompt "Default EVM hash algorithm"
+	default EVM_DEFAULT_HASH_SHA256
+	depends on EVM
+	help
+	   Select the default hash algorithm used for the HMAC. The compiled
+	   default hash algorithm can be overwritten using the kernel command
+	   line 'evm_hash=' option.
+
+	config EVM_DEFAULT_HASH_SHA1
+		bool "SHA1"
+		depends on CRYPTO_SHA1=y
+
+	config EVM_DEFAULT_HASH_SHA256
+		bool "SHA256 (default)"
+		depends on CRYPTO_SHA256=y
+
+	config EVM_DEFAULT_HASH_SHA512
+		bool "SHA512"
+		depends on CRYPTO_SHA512=y
+
+	config EVM_DEFAULT_HASH_WP512
+		bool "WP512"
+		depends on CRYPTO_WP512=y
+endchoice
+
+config EVM_DEFAULT_HASH
+	string
+	depends on EVM
+	default "sha1" if EVM_DEFAULT_HASH_SHA1
+	default "sha256" if EVM_DEFAULT_HASH_SHA256
+	default "sha512" if EVM_DEFAULT_HASH_SHA512
+	default "wp512" if EVM_DEFAULT_HASH_WP512
+
 config EVM_ATTR_FSUUID
 	bool "FSUUID (version 2)"
 	default y
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f2fef2b5ed51..ae590f71ce7d 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -32,6 +32,7 @@ struct xattr_list {
 };
 
 extern int evm_initialized;
+extern enum hash_algo evm_hash_algo;
 
 #define EVM_ATTR_FSUUID		0x0001
 
@@ -49,6 +50,7 @@ struct evm_digest {
 } __packed;
 
 int evm_init_key(void);
+int __init evm_init_crypto(void);
 int evm_update_evmxattr(struct dentry *dentry,
 			const char *req_xattr_name,
 			const char *req_xattr_value,
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index d76b006cbcc4..b66264b53d5d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -33,7 +33,24 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
-static const char evm_hmac[] = "hmac(sha1)";
+enum hash_algo evm_hash_algo __ro_after_init = HASH_ALGO_SHA1;
+
+static int hash_setup_done;
+static int __init hash_setup(char *str)
+{
+	int i;
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i < 0) {
+		pr_err("invalid hash algorithm \"%s\"", str);
+		return 1;
+	}
+
+	evm_hash_algo = i;
+	hash_setup_done = 1;
+	return 1;
+}
+__setup("evm_hash=", hash_setup);
 
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
@@ -74,8 +91,12 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 	long rc;
 	const char *algo;
 	struct crypto_shash **tfm, *tmp_tfm = NULL;
+	char evm_hmac[CRYPTO_MAX_ALG_NAME];
 	struct shash_desc *desc;
 
+	snprintf(evm_hmac, sizeof(evm_hmac), "hmac(%s)",
+		 hash_algo_name[evm_hash_algo]);
+
 	if (type == EVM_XATTR_HMAC) {
 		if (!(evm_initialized & EVM_INIT_HMAC)) {
 			pr_err_once("HMAC key is not set\n");
@@ -317,7 +338,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	if (rc)
 		return -EPERM;
 
-	data.hdr.algo = HASH_ALGO_SHA1;
+	data.hdr.algo = evm_hash_algo;
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 			   xattr_value_len, &data);
 	if (rc == 0) {
@@ -325,7 +346,8 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
 					   XATTR_NAME_EVM,
 					   &data.hdr.xattr.data[1],
-					   SHA1_DIGEST_SIZE + 1, 0);
+					   hash_digest_size[evm_hash_algo] + 1,
+					   0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
 		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
 	}
@@ -337,7 +359,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 {
 	struct shash_desc *desc;
 
-	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
+	desc = init_desc(EVM_XATTR_HMAC, evm_hash_algo);
 	if (IS_ERR(desc)) {
 		pr_info("init_desc failed\n");
 		return PTR_ERR(desc);
@@ -350,7 +372,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 }
 
 /*
- * Get the key from the TPM for the SHA1-HMAC
+ * Get the key from the TPM for the HMAC
  */
 int evm_init_key(void)
 {
@@ -373,3 +395,26 @@ int evm_init_key(void)
 	key_put(evm_key);
 	return rc;
 }
+
+/*
+ * Configure the hash algorithm for the HMAC
+ */
+int __init evm_init_crypto(void)
+{
+	int i;
+
+	if (hash_setup_done)
+		return 0;
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST,
+			 CONFIG_EVM_DEFAULT_HASH);
+	if (i < 0) {
+		pr_err("invalid hash algorithm \"%s\"",
+		       CONFIG_EVM_DEFAULT_HASH);
+		return -EINVAL;
+	}
+
+	evm_hash_algo = i;
+
+	return 0;
+}
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 8e80af97021e..cb3754e0cc60 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -187,18 +187,18 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
-		if (xattr_len != sizeof(struct evm_xattr)) {
+		if (xattr_len != hash_digest_size[evm_hash_algo] + 1) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
 
-		digest.hdr.algo = HASH_ALGO_SHA1;
+		digest.hdr.algo = evm_hash_algo;
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 				   xattr_value_len, &digest);
 		if (rc)
 			break;
 		rc = crypto_memneq(xattr_data->data, digest.digest,
-				   SHA1_DIGEST_SIZE);
+				   hash_digest_size[evm_hash_algo]);
 		if (rc)
 			rc = -EINVAL;
 		break;
@@ -722,7 +722,7 @@ int evm_inode_init_security(struct inode *inode,
 		goto out;
 
 	evm_xattr->value = xattr_data;
-	evm_xattr->value_len = sizeof(*xattr_data);
+	evm_xattr->value_len = hash_digest_size[evm_hash_algo] + 1;
 	evm_xattr->name = XATTR_EVM_SUFFIX;
 	return 0;
 out:
@@ -759,6 +759,11 @@ static int __init init_evm(void)
 		goto error;
 	}
 
+	error = evm_init_crypto();
+	if (error < 0) {
+		pr_info("Error initializing crypto\n");
+		goto error;
+	}
 error:
 	if (error != 0) {
 		if (!list_empty(&evm_config_xattrnames)) {
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index be501a63ae30..74919b638f52 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -17,6 +17,7 @@
 #include <crypto/sha1.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <crypto/hash_info.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -89,7 +90,7 @@ struct evm_ima_xattr_data {
 /* Only used in the EVM HMAC code. */
 struct evm_xattr {
 	struct evm_ima_xattr_data data;
-	u8 digest[SHA1_DIGEST_SIZE];
+	u8 digest[SHA512_DIGEST_SIZE];
 } __packed;
 
 #define IMA_MAX_DIGEST_SIZE	64
-- 
2.26.2

