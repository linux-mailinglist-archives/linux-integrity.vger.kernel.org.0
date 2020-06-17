Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37D1FD647
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFQUon (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 16:44:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55572 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFQUom (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 16:44:42 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 682C020B7192;
        Wed, 17 Jun 2020 13:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 682C020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592426681;
        bh=FRjnd7LzSpMwTJfbQgmfF6wTlowj4c4FlZqqooRPOZw=;
        h=From:To:Cc:Subject:Date:From;
        b=AhZzI1uo2qTNlEeTeEHm+zXRk94Bf5ivB9RgYOv/HTgtRTYPEb3pwRDgtSPsjyz7W
         phKXTQfCBPQqwj0DLleE6Ce02H1fDJjlfqr+ZlX3Tapaf5S9QPhb3eSGqDVK3RlUrh
         VSTxFUii3BPoUy+bfaocSOB/QBJOfVtwvZbLKKt0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, nayna@linux.ibm.com,
        sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] IMA: pass error code in result parameter to integrity_audit_msg()
Date:   Wed, 17 Jun 2020 13:44:35 -0700
Message-Id: <20200617204436.2226-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The value passed in "result" parameter to integrity_audit_msg() is
not an error code in some instances. Update these instances so that
"result" parameter always contains an error code.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_appraise.c | 20 ++++++++++++--------
 security/integrity/ima/ima_fs.c       |  8 +++++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a9649b04b9f1..253dcb331249 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -226,7 +226,7 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 		}
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+				iint->ima_hash->length) {
 			/*
 			 * xattr length may be longer. md5 hash in previous
 			 * version occupied 20 bytes in xattr, instead of 16
@@ -234,6 +234,9 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 			rc = memcmp(&xattr_value->data[hash_start],
 				    iint->ima_hash->digest,
 				    iint->ima_hash->length);
+			if (rc)
+				rc = -EINVAL;
+		}
 		else
 			rc = -EINVAL;
 		if (rc) {
@@ -355,7 +358,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
-	int rc = xattr_len;
+	int rc = -EACCES;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
 
 	/* If not appraising a modsig, we need an xattr. */
@@ -363,10 +366,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		return INTEGRITY_UNKNOWN;
 
 	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
-		if (rc && rc != -ENODATA)
-			goto out;
-
+	if (xattr_len <= 0 && !try_modsig) {
 		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
 				"IMA-signature-required" : "missing-hash";
 		status = INTEGRITY_NOLABEL;
@@ -379,7 +379,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		goto out;
 	}
 
-	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
+	status = evm_verifyxattr(dentry, XATTR_NAME_IMA,
+				 xattr_value, xattr_len, iint);
 	switch (status) {
 	case INTEGRITY_PASS:
 	case INTEGRITY_PASS_IMMUTABLE:
@@ -432,14 +433,17 @@ int ima_appraise_measurement(enum ima_hooks func,
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
-			if (!ima_fix_xattr(dentry, iint))
+			if (!ima_fix_xattr(dentry, iint)) {
 				status = INTEGRITY_PASS;
+				rc = 0;
+			}
 		}
 
 		/* Permit new files with file signatures, but without data. */
 		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
 		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
+			rc = 0;
 		}
 
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..a3a270cff94f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -335,10 +335,10 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		result = ima_read_policy(data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
+		result = -EACCES;
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
-				    1, 0);
-		result = -EACCES;
+				    result, 0);
 	} else {
 		result = ima_parse_add_rule(data);
 	}
@@ -406,6 +406,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
+	int result = 0;
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
@@ -413,11 +414,12 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	if (valid_policy && ima_check_policy() < 0) {
 		cause = "failed";
 		valid_policy = 0;
+		result = -EINVAL;
 	}
 
 	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+			    "policy_update", cause, result, 0);
 
 	if (!valid_policy) {
 		ima_delete_rules();
-- 
2.27.0

