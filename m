Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5398359D9D
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhDILn7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:43:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2819 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDILn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:43:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGx133MRcz687WM;
        Fri,  9 Apr 2021 19:36:39 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:43:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/7] ima: Avoid measurement and audit if access to the file will be denied
Date:   Fri, 9 Apr 2021 13:43:07 +0200
Message-ID: <20210409114313.4073-2-roberto.sassu@huawei.com>
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

Currently, IMA adds a measurement entry and an audit log even if access
to the file will be denied when appraisal is in enforce mode. This gives
the false indication to a verifier analyzing the data that file access
occurred. It also has the undesirable effect of unnecessarily revoking
access to TPM-protected objects sealed to PCRs.

Given that a potentially corrupted file will not be accessed by any user
space process, it is safe for the purpose of integrity evaluation to avoid
to record a measurement or audit log in this case.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..0faddcb8c71a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -328,16 +328,14 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
 	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
-	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
+	if (rc != 0 && rc != -EBADF && rc != -EINVAL) {
+		action &= ~(IMA_MEASURE | IMA_AUDIT);
 		goto out_locked;
+	}
 
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
@@ -351,15 +349,21 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			rc = mmap_violation_check(func, file, &pathbuf,
 						  &pathname, filename);
 	}
-	if (action & IMA_AUDIT)
-		ima_audit_measurement(iint, pathname);
-
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc = 0;
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
+	if (must_appraise)
+		if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
+			action &= ~(IMA_MEASURE | IMA_AUDIT);
+	if (action & IMA_MEASURE)
+		ima_store_measurement(iint, file, pathname,
+				      xattr_value, xattr_len, modsig, pcr,
+				      template_desc);
+	if (action & IMA_AUDIT)
+		ima_audit_measurement(iint, pathname);
 	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
-- 
2.26.2

