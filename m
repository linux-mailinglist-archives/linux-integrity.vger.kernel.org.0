Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146ED41D93C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbhI3L6o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:58:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3902 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350691AbhI3L6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:58:43 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs8X2nRYz685Yr;
        Thu, 30 Sep 2021 19:53:48 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:56:59 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 7/7] ima: Add support for appraisal with digest lists
Date:   Thu, 30 Sep 2021 13:55:33 +0200
Message-ID: <20210930115533.878169-8-roberto.sassu@huawei.com>
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

Introduce a new appraisal method based on the lookup of the file and
metadata digest in the DIGLIM hash table, enabled with the use_diglim
directive.

First pass to ima_appraise_measurement() the actions performed on the
digest lists containing the found digests.

Then, consider the metadata verification as successful if EVM returned the
status INTEGRITY_NOLABEL (no security.evm), if the metadata digest was
found in the DIGLIM hash table and at least one digest list containing it
was succefully appraised with a signature.

Finally, consider the file content verification as successful if there is
no security.ima or appended signature, if the file or metadata digest
(calculated with the actual file digest) were found in the DIGLIM hash
table and at least one digest list containing it has a valid signature.

Furthermore, mark the file as immutable if the COMPACT_MOD_IMMUTABLE
modifier was set in the header of the digest lists containing the found
digests.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  4 ++-
 security/integrity/ima/ima_appraise.c | 37 +++++++++++++++++++++++----
 security/integrity/ima/ima_main.c     |  6 ++++-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 550805b79984..631e9e4c343b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -319,7 +319,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     u16 file_modifiers, u8 file_actions,
+			     u16 metadata_modifiers, u8 metadata_actions);
 int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index e1b9a5bc4252..a0885272411e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -377,7 +377,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     u16 file_modifiers, u8 file_actions,
+			     u16 metadata_modifiers, u8 metadata_actions)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -387,12 +389,26 @@ int ima_appraise_measurement(enum ima_hooks func,
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/* We are interested only in appraisal-related flags. */
+	file_actions &= COMPACT_ACTION_IMA_APPRAISED_DIGSIG;
+	metadata_actions &= COMPACT_ACTION_IMA_APPRAISED_DIGSIG;
+
+	/* Disable DIGLIM method for appraisal if not enabled in the policy. */
+	if (!(iint->flags & IMA_USE_DIGLIM_APPRAISE)) {
+		file_actions = 0;
+		metadata_actions = 0;
+	}
+
+	/* If not appraising a modsig or using DIGLIM, we need an xattr. */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig &&
+	    !file_actions && !metadata_actions)
 		return INTEGRITY_UNKNOWN;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/*
+	 * If reading the xattr failed, there's no modsig and the DIGLIM
+	 * appraisal method is not available, error out.
+	 */
+	if (rc <= 0 && !try_modsig && !file_actions && !metadata_actions) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -420,6 +436,10 @@ int ima_appraise_measurement(enum ima_hooks func,
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		if (metadata_actions) {
+			status = INTEGRITY_PASS_IMMUTABLE;
+			break;
+		}
 		cause = "missing-HMAC";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
@@ -455,6 +475,13 @@ int ima_appraise_measurement(enum ima_hooks func,
 	     rc == -ENOKEY))
 		rc = modsig_verify(func, modsig, &status, &cause);
 
+	if (!xattr_value && !try_modsig && (file_actions || metadata_actions)) {
+		status = INTEGRITY_PASS;
+
+		if ((file_modifiers & (1 << COMPACT_MOD_IMMUTABLE)) ||
+		    (metadata_modifiers & (1 << COMPACT_MOD_IMMUTABLE)))
+			set_bit(IMA_DIGSIG, &iint->atomic_flags);
+	}
 out:
 	/*
 	 * File signatures on some filesystems can not be properly verified.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7add0e70f67a..7a9a2392d49c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -416,7 +416,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      file_modifiers,
+						      file_actions,
+						      metadata_modifiers,
+						      metadata_actions);
 			inode_unlock(inode);
 		}
 		if (!rc)
-- 
2.32.0

