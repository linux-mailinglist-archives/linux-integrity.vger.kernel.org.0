Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9907380CFD
	for <lists+linux-integrity@lfdr.de>; Fri, 14 May 2021 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhENPag (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 May 2021 11:30:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3074 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhENPaf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 May 2021 11:30:35 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FhXNS5X9Nz6cw6p;
        Fri, 14 May 2021 23:23:20 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 17:29:22 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 06/12] evm: Allow xattr/attr operations for portable signatures
Date:   Fri, 14 May 2021 17:27:47 +0200
Message-ID: <20210514152753.982958-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514152753.982958-1-roberto.sassu@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If files with portable signatures are copied from one location to another
or are extracted from an archive, verification can temporarily fail until
all xattrs/attrs are set in the destination. Only portable signatures may
be moved or copied from one file to another, as they don't depend on
system-specific information such as the inode generation. Instead portable
signatures must include security.ima.

Unlike other security.evm types, EVM portable signatures are also
immutable. Thus, it wouldn't be a problem to allow xattr/attr operations
when verification fails, as portable signatures will never be replaced with
the HMAC on possibly corrupted xattrs/attrs.

This patch first introduces a new integrity status called
INTEGRITY_FAIL_IMMUTABLE, that allows callers of
evm_verify_current_integrity() to detect that a portable signature didn't
pass verification and then adds an exception in evm_protect_xattr() and
evm_inode_setattr() for this status and returns 0 instead of -EPERM.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/integrity.h             |  1 +
 security/integrity/evm/evm_main.c     | 33 ++++++++++++++++++++++-----
 security/integrity/ima/ima_appraise.c |  2 ++
 3 files changed, 30 insertions(+), 6 deletions(-)

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
index b263c5b8eca3..77259cc901e2 100644
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
 
@@ -155,7 +156,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct evm_digest digest;
 	struct inode *inode;
-	int rc, xattr_len;
+	int rc, xattr_len, evm_immutable = 0;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
@@ -200,8 +201,10 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
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
@@ -238,9 +241,14 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		break;
 	}
 
-	if (rc)
-		evm_status = (rc == -ENODATA) ?
-				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
+	if (rc) {
+		if (rc == -ENODATA)
+			evm_status = INTEGRITY_NOXATTRS;
+		else if (evm_immutable)
+			evm_status = INTEGRITY_FAIL_IMMUTABLE;
+		else
+			evm_status = INTEGRITY_FAIL;
+	}
 out:
 	if (iint)
 		iint->evm_status = evm_status;
@@ -379,6 +387,14 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	/* Exception if the HMAC is not going to be calculated. */
 	if (evm_hmac_disabled() && evm_status == INTEGRITY_NOLABEL)
 		return 0;
+
+	/*
+	 * Writing other xattrs is safe for portable signatures, as portable
+	 * signatures are immutable and can never be updated.
+	 */
+	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
+		return 0;
+
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -552,8 +568,13 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
+	/*
+	 * Writing attrs is safe for portable signatures, as portable signatures
+	 * are immutable and can never be updated.
+	 */
 	if ((evm_status == INTEGRITY_PASS) ||
 	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_status == INTEGRITY_FAIL_IMMUTABLE) ||
 	    (evm_hmac_disabled() && evm_status == INTEGRITY_NOLABEL))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 03894769dffa..9bb351b933fb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -416,6 +416,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
 		cause = "missing-HMAC";
 		goto out;
+	case INTEGRITY_FAIL_IMMUTABLE:
+		fallthrough;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
 		goto out;
-- 
2.25.1

