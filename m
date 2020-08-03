Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23A23A939
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgHCPP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgHCPP5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 62A301486066F016B8AA;
        Mon,  3 Aug 2020 16:15:55 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 16:15:55 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 17:15:54 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
Subject: [RFC][PATCH 2/3] ima: Add support for appraisal with digest lists
Date:   Mon, 3 Aug 2020 17:13:12 +0200
Message-ID: <20200803151313.17510-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20200803151313.17510-1-roberto.sassu@huawei.com>
References: <20200803151313.17510-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA-Appraise grants access to files with a valid signature or with actual
file digest equal to the digest included in security.ima.

This patch adds support for appraisal based on digest lists. Instead of
using the reference value from security.ima, this patch checks if the
calculated file digest is included in the uploaded digest lists.

This functionality must be explicitly enabled by providing one of the
following values for the ima_appraise_digest_list= kernel option:

- digest: this mode enables appraisal verification with digest lists until
  EVM is initialized; after that, EVM verification must be successful even
  if the file digest is found in a digest list;

- digest-nometadata: this mode enables appraisal verification with digest
  lists even after EVM has been initialized; files without security.evm are
  allowed if the digest of the content is found in the digest list, and
  security.evm is created with current values of xattrs (trust at first
  use); all files created in this way will have the new security.ima type
  EVM_IMA_XATTR_DIGEST_LIST; they can be accessed later only if this mode
  has been selected.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 security/integrity/ima/ima.h                  |  6 +-
 security/integrity/ima/ima_appraise.c         | 74 +++++++++++++++++--
 security/integrity/ima/ima_main.c             |  6 +-
 security/integrity/integrity.h                |  1 +
 5 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6a44594c10d7..b2f899233bef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1688,6 +1688,15 @@
 				  "enforce-evm" | "log-evm" }
 			default: "enforce"
 
+	ima_appraise_digest_list= [IMA]
+			Format: { "digest" | "digest-nometadata" }
+
+			digest: enables appraisal of files with digest lists
+			until EVM is initialized.
+
+			digest-nometadata: enables appraisal of files with
+			digest lists even after EVM is initialized.
+
 	ima_appraise_tcb [IMA] Deprecated.  Use ima_policy= instead.
 			The builtin appraise policy appraises all files
 			owned by uid=0.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7af7620b770a..ca1e1fcd84d2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -301,7 +301,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     struct ima_digest *found_digest);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -319,7 +320,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   struct ima_digest *found_digest)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 433d547ff773..4ea107db32e2 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -15,6 +15,7 @@
 #include <keys/system_keyring.h>
 
 #include "ima.h"
+#include "ima_digest_list.h"
 
 static bool ima_appraise_req_evm __ro_after_init;
 static int __init default_appraise_setup(char *str)
@@ -35,6 +36,22 @@ static int __init default_appraise_setup(char *str)
 
 __setup("ima_appraise=", default_appraise_setup);
 
+static bool ima_appraise_no_metadata __ro_after_init;
+#ifdef CONFIG_IMA_DIGEST_LIST
+static int __init appraise_digest_list_setup(char *str)
+{
+	if (!strncmp(str, "digest", 6)) {
+		ima_digest_list_actions |= IMA_APPRAISE;
+
+		if (!strcmp(str + 6, "-nometadata"))
+			ima_appraise_no_metadata = true;
+	}
+
+	return 1;
+}
+__setup("ima_appraise_digest_list=", appraise_digest_list_setup);
+#endif
+
 /*
  * is_ima_appraise_enabled - return appraise status
  *
@@ -74,6 +91,9 @@ static int ima_fix_xattr(struct dentry *dentry,
 	} else {
 		offset = 0;
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
+		if (test_bit(IMA_DIGEST_LIST, &iint->atomic_flags))
+			iint->ima_hash->xattr.ng.type =
+						EVM_IMA_XATTR_DIGEST_LIST;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
 	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
@@ -161,17 +181,32 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
  */
 static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
-			enum integrity_status *status, const char **cause)
+			enum integrity_status *status, const char **cause,
+			struct ima_digest *found_digest)
 {
 	int rc = -EINVAL, hash_start = 0;
 
+	if (found_digest && *status != INTEGRITY_PASS &&
+	    *status != INTEGRITY_PASS_IMMUTABLE)
+		set_bit(IMA_DIGEST_LIST, &iint->atomic_flags);
+
 	switch (xattr_value->type) {
+	case EVM_IMA_XATTR_DIGEST_LIST:
+		set_bit(IMA_DIGEST_LIST, &iint->atomic_flags);
+
+		if (!ima_appraise_no_metadata) {
+			*cause = "IMA-xattr-untrusted";
+			*status = INTEGRITY_FAIL;
+			break;
+		}
+		fallthrough;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		hash_start = 1;
 		/* fall through */
 	case IMA_XATTR_DIGEST:
-		if (*status != INTEGRITY_PASS_IMMUTABLE) {
+		if (*status != INTEGRITY_PASS_IMMUTABLE &&
+		    (!found_digest || !ima_digest_is_immutable(found_digest))) {
 			if (iint->flags & IMA_DIGSIG_REQUIRED) {
 				*cause = "IMA-signature-required";
 				*status = INTEGRITY_FAIL;
@@ -304,7 +339,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     struct ima_digest *found_digest)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -312,12 +348,23 @@ int ima_appraise_measurement(enum ima_hooks func,
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
+	char _buf[sizeof(struct evm_ima_xattr_data) + SHA512_DIGEST_SIZE];
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
 
 	/* If not appraising a modsig, we need an xattr. */
 	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
 		return INTEGRITY_UNKNOWN;
 
+	if (rc == -ENODATA && found_digest &&
+	    !(file->f_mode & FMODE_CREATED)) {
+		xattr_value = (struct evm_ima_xattr_data *)_buf;
+		xattr_value->type = IMA_XATTR_DIGEST_NG;
+		xattr_value->data[0] = found_digest->algo;
+		memcpy(&xattr_value->data[1], found_digest->digest,
+		       hash_digest_size[found_digest->algo]);
+		rc = hash_digest_size[found_digest->algo] + 2;
+	}
+
 	/* If reading the xattr failed and there's no modsig, error out. */
 	if (rc <= 0 && !try_modsig) {
 		if (rc && rc != -ENODATA)
@@ -342,7 +389,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		break;
 	case INTEGRITY_UNKNOWN:
 		if (ima_appraise_req_evm &&
-		    xattr_value->type != EVM_IMA_XATTR_DIGSIG)
+		    xattr_value->type != EVM_IMA_XATTR_DIGSIG && !found_digest)
 			goto out;
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
@@ -351,6 +398,23 @@ int ima_appraise_measurement(enum ima_hooks func,
 			break;
 		/* fall through */
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		/*
+		 * If the digest-nometadata mode is selected, allow access
+		 * without metadata check. EVM will eventually create an HMAC
+		 * based on current xattr values.
+		 */
+		if (ima_appraise_no_metadata && found_digest)
+			break;
+		/* Allow access to digest lists without metadata, only if they
+		 * are signed or found in a digest list (immutable)
+		 */
+		if (func == DIGEST_LIST_CHECK) {
+			if (xattr_value->type == EVM_IMA_XATTR_DIGSIG)
+				break;
+			if (found_digest &&
+			    ima_digest_is_immutable(found_digest))
+				break;
+		}
 		cause = "missing-HMAC";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
@@ -365,7 +429,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 
 	if (xattr_value)
 		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
-				  &cause);
+				  &cause, found_digest);
 
 	/*
 	 * If we have a modsig and either no imasig or the imasig's key isn't
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ca80e7c5b885..031d3ce44e58 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -407,8 +407,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		if (rc != -EPERM) {
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
-						      pathname, xattr_value,
-						      xattr_len, modsig);
+					      pathname, xattr_value,
+					      xattr_len, modsig,
+					      ima_digest_allow(found_digest,
+							       IMA_APPRAISE));
 			inode_unlock(inode);
 		}
 		if (!rc)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 3525f2d185b3..de68d816505d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -71,6 +71,7 @@
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_DIGEST_LIST		5
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
-- 
2.27.GIT

