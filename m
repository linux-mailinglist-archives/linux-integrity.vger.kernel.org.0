Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93DC1FF892
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbgFRQEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 12:04:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731811AbgFRQE1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 12:04:27 -0400
Received: from lhreml735-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1342DB8A14AFCE0680A1;
        Thu, 18 Jun 2020 17:04:26 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml735-chm.china.huawei.com (10.201.108.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 17:04:25 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 18:04:25 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 05/11] evm: Allow xattr/attr operations for portable signatures if check fails
Date:   Thu, 18 Jun 2020 18:01:27 +0200
Message-ID: <20200618160133.937-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618160133.937-1-roberto.sassu@huawei.com>
References: <20200618160133.937-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If files with portable signatures are copied from one location to another
or are extracted from an archive, verification can temporarily fail until
all xattrs/attrs are set in the destination. Portable signatures are the
only ones that can be moved to different files, as they don't depend on
system-specific information such as the inode generation.

Unlike other security.evm types, portable signatures can never be replaced
even if an xattr/attr operation is granted, as once evm_update_evmxattr()
detects this type, it returns without updating the HMAC. Thus, it wouldn't
be a problem to allow those operations so that verification passes on the
destination after all xattrs/attrs are copied.

This patch first introduces a new integrity status called
INTEGRITY_FAIL_IMMUTABLE, that allows callers of
evm_verify_current_integrity() to detect that a portable signature didn't
pass verification and then adds an exception in evm_protect_xattr() and
evm_inode_setattr() for this status and returns 0 instead of -EPERM.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/integrity.h             |  1 +
 security/integrity/evm/evm_main.c     | 25 ++++++++++++++++++++-----
 security/integrity/ima/ima_appraise.c |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2271939c5c31..2ea0f2f65ab6 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -13,6 +13,7 @@ enum integrity_status {
 	INTEGRITY_PASS = 0,
 	INTEGRITY_PASS_IMMUTABLE,
 	INTEGRITY_FAIL,
+	INTEGRITY_FAIL_IMMUTABLE,
 	INTEGRITY_NOLABEL,
 	INTEGRITY_NOXATTRS,
 	INTEGRITY_UNKNOWN,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 4e9f5e8b21d5..30072030f05d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -27,7 +27,8 @@
 int evm_initialized;
 
 static const char * const integrity_status_msg[] = {
-	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
+	"pass", "pass_immutable", "fail", "fail_immutable", "no_label",
+	"no_xattrs", "unknown"
 };
 int evm_hmac_attrs;
 
@@ -134,7 +135,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct evm_digest digest;
 	struct inode *inode;
-	int rc, xattr_len;
+	int rc, xattr_len, evm_immutable = 0;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
@@ -179,8 +180,10 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		if (rc)
 			rc = -EINVAL;
 		break;
-	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		evm_immutable = 1;
+		fallthrough;
+	case EVM_IMA_XATTR_DIGSIG:
 		/* accept xattr with non-empty signature field */
 		if (xattr_len <= sizeof(struct signature_v2_hdr)) {
 			evm_status = INTEGRITY_FAIL;
@@ -219,7 +222,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 
 	if (rc)
 		evm_status = (rc == -ENODATA) ?
-				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
+				INTEGRITY_NOXATTRS : evm_immutable ?
+				INTEGRITY_FAIL_IMMUTABLE : INTEGRITY_FAIL;
 out:
 	if (iint)
 		iint->evm_status = evm_status;
@@ -351,6 +355,12 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
+	/* It is safe to allow fail_immutable, portable signatures can never be
+	 * updated
+	 */
+	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
+		return 0;
+
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -488,9 +498,14 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
+	/* It is safe to allow fail_immutable, portable signatures can never
+	 * be updated
+	 */
 	if ((evm_status == INTEGRITY_PASS) ||
-	    (evm_status == INTEGRITY_NOXATTRS))
+	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
 		return 0;
+
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a9649b04b9f1..21bda264fc30 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -393,6 +393,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
 		cause = "missing-HMAC";
 		goto out;
+	case INTEGRITY_FAIL_IMMUTABLE:
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
 		goto out;
-- 
2.17.1

