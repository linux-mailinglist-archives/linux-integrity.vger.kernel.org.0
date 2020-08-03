Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CA23A93C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHCPP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728023AbgHCPP5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhreml723-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E7F70D021A538B952AE1;
        Mon,  3 Aug 2020 16:15:55 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml723-chm.china.huawei.com (10.201.108.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 16:15:55 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 17:15:55 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
Subject: [RFC][PATCH 3/3] evm: Add support for digest lists of metadata
Date:   Mon, 3 Aug 2020 17:13:13 +0200
Message-ID: <20200803151313.17510-4-roberto.sassu@huawei.com>
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

This patch adds support in EVM to verify file metadata digest with digest
lists. Metadata digest, calculated in the same way as for portable
signatures, is searched in the digest lists only if the file has the
security.evm xattr with type EVM_IMA_XATTR_DIGEST_LIST.

If the found digest is marked as immutable, content and xattr/attr updates
are not allowed. Otherwise, after verification, the existing security.evm
with the new type will be replaced with an HMAC, similarly to non-portable
signatures.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_crypto.c |  9 ++--
 security/integrity/evm/evm_main.c   | 82 ++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 168c3b78ac47..9b4b07811e97 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -152,7 +152,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	/* Don't include the inode or generation number in portable
 	 * signatures
 	 */
-	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
+	if (type != EVM_XATTR_PORTABLE_DIGSIG &&
+	    type != EVM_IMA_XATTR_DIGEST_LIST) {
 		hmac_misc.ino = inode->i_ino;
 		hmac_misc.generation = inode->i_generation;
 	}
@@ -169,7 +170,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.mode = inode->i_mode;
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
+	    type != EVM_XATTR_PORTABLE_DIGSIG &&
+	    type != EVM_IMA_XATTR_DIGEST_LIST)
 		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
 	crypto_shash_final(desc, digest);
 }
@@ -282,7 +284,8 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 			return 0;
 		return rc;
 	}
-	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG)
+	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG ||
+	    xattr_data->type == EVM_IMA_XATTR_DIGEST_LIST)
 		rc = 1;
 	else
 		rc = 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d4d918183094..3c5247154811 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -89,7 +89,7 @@ static bool evm_key_loaded(void)
 	return (bool)(evm_initialized & EVM_KEY_MASK);
 }
 
-static int evm_find_protected_xattrs(struct dentry *dentry)
+static int evm_find_protected_xattrs(struct dentry *dentry, int *ima_present)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct xattr_list *xattr;
@@ -106,6 +106,8 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 				continue;
 			return error;
 		}
+		if (!strcmp(xattr->name, XATTR_NAME_IMA))
+			*ima_present = 1;
 		count++;
 	}
 
@@ -134,9 +136,14 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	struct evm_ima_xattr_data *xattr_data = NULL;
 	struct signature_v2_hdr *hdr;
 	enum integrity_status evm_status = INTEGRITY_PASS;
+	enum integrity_status saved_evm_status = INTEGRITY_UNKNOWN;
 	struct evm_digest digest;
+	struct ima_digest *found_digest;
 	struct inode *inode;
-	int rc, xattr_len, evm_immutable = 0;
+	struct signature_v2_hdr evm_fake_xattr = {
+				.type = EVM_IMA_XATTR_DIGEST_LIST,
+				.version = 2, .hash_algo = HASH_ALGO_SHA256 };
+	int rc, xattr_len, evm_immutable = 0, ima_present = 0;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
@@ -150,7 +157,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	if (rc <= 0) {
 		evm_status = INTEGRITY_FAIL;
 		if (rc == -ENODATA) {
-			rc = evm_find_protected_xattrs(dentry);
+			rc = evm_find_protected_xattrs(dentry, &ima_present);
 			if (rc > 0)
 				evm_status = INTEGRITY_NOLABEL;
 			else if (rc == 0)
@@ -158,7 +165,20 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		} else if (rc == -EOPNOTSUPP) {
 			evm_status = INTEGRITY_UNKNOWN;
 		}
-		goto out;
+		/* IMA added a fake xattr, set also EVM fake xattr */
+		if (!ima_present && xattr_name &&
+		    !strcmp(xattr_name, XATTR_NAME_IMA) &&
+		    xattr_value_len >= sizeof(struct evm_ima_xattr_data)) {
+			evm_fake_xattr.hash_algo =
+			  ((struct evm_ima_xattr_data *)xattr_value)->data[0];
+			xattr_data =
+			  (struct evm_ima_xattr_data *)&evm_fake_xattr;
+			rc = sizeof(evm_fake_xattr);
+		}
+		if (xattr_data != (struct evm_ima_xattr_data *)&evm_fake_xattr)
+			goto out;
+
+		saved_evm_status = evm_status;
 	}
 
 	xattr_len = rc;
@@ -216,19 +236,66 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			}
 		}
 		break;
+	case EVM_IMA_XATTR_DIGEST_LIST:
+		if (xattr_len < offsetof(struct signature_v2_hdr, keyid)) {
+			evm_status = INTEGRITY_FAIL;
+			goto out;
+		}
+
+		hdr = (struct signature_v2_hdr *)xattr_data;
+		digest.hdr.algo = hdr->hash_algo;
+		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
+				   xattr_value_len, xattr_data->type, &digest);
+		if (rc)
+			break;
+
+		found_digest = ima_lookup_digest(digest.digest, hdr->hash_algo,
+						 COMPACT_METADATA);
+		if (!found_digest) {
+			rc = -ENOENT;
+			break;
+		}
+
+		if (!ima_digest_allow(found_digest, IMA_APPRAISE)) {
+			rc = -EACCES;
+			break;
+		}
+
+		if (ima_digest_is_immutable(found_digest)) {
+			evm_immutable = 1;
+
+			if (iint)
+				iint->flags |= EVM_IMMUTABLE_DIGSIG;
+			evm_status = INTEGRITY_PASS_IMMUTABLE;
+		} else {
+			inode = d_backing_inode(dentry);
+			if (!IS_RDONLY(inode) &&
+			    !(inode->i_sb->s_readonly_remount) &&
+			    !IS_IMMUTABLE(inode)) {
+				rc = __vfs_removexattr(dentry, XATTR_NAME_EVM);
+				if (!rc)
+					evm_update_evmxattr(dentry, xattr_name,
+							    xattr_value,
+							    xattr_value_len);
+			}
+		}
+		break;
 	default:
 		rc = -EINVAL;
 		break;
 	}
 
-	if (rc)
+	if (rc && xattr_data == (struct evm_ima_xattr_data *)&evm_fake_xattr)
+		evm_status = saved_evm_status;
+	else if (rc)
 		evm_status = (rc == -ENODATA) ?
 				INTEGRITY_NOXATTRS : evm_immutable ?
 				INTEGRITY_FAIL_IMMUTABLE : INTEGRITY_FAIL;
 out:
 	if (iint)
 		iint->evm_status = evm_status;
-	kfree(xattr_data);
+	if (xattr_data != (struct evm_ima_xattr_data *)&evm_fake_xattr)
+		kfree(xattr_data);
 	return evm_status;
 }
 
@@ -452,7 +519,8 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		if (!xattr_value_len)
 			return -EINVAL;
 		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
-		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
+		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG &&
+		    xattr_data->type != EVM_IMA_XATTR_DIGEST_LIST)
 			return -EPERM;
 	}
 	return evm_protect_xattr(dentry, xattr_name, xattr_value,
-- 
2.27.GIT

