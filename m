Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5189359DA3
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhDILn7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:43:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2820 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDILn6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:43:58 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGwy76S3wz685bH;
        Fri,  9 Apr 2021 19:34:07 +0800 (CST)
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
Subject: [PATCH 2/7] ima: Add meta_immutable appraisal type
Date:   Fri, 9 Apr 2021 13:43:08 +0200
Message-ID: <20210409114313.4073-3-roberto.sassu@huawei.com>
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

Currently, IMA supports the appraise_type=imasig option in the policy to
require signed file content or metadata. This patch introduces the new
option appraise_type=meta_immutable to require that file metadata is also
immutable, i.e. it cannot have been produced by the system itself but only
from a vendor whose signing key is trusted by the kernel. Currently, this
requirement can be satisfied only by portable signatures.

The main purpose of this option is to ensure a proper label transition
during binary execution, when the target label depends on the label of the
binary being executed. Without it, an administrator might obtain a
different target label by changing the label of the executable.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy  |  2 +-
 security/integrity/ima/ima_appraise.c |  9 +++++++++
 security/integrity/ima/ima_policy.c   | 13 ++++++++++---
 security/integrity/integrity.h        |  1 +
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 070779e8d836..bc6597db7c78 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -42,7 +42,7 @@ Description:
 			fowner:= decimal value
 		  lsm:  are LSM specific
 		  option:
-			appraise_type:= [imasig] [imasig|modsig]
+			appraise_type:= [imasig] [imasig|modsig] [meta_immutable]
 			appraise_flag:= [check_blacklist]
 			Currently, blacklist check is only for files signed with appended
 			signature.
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 45e244fc2ef2..5814b8cbe86c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -430,6 +430,15 @@ int ima_appraise_measurement(enum ima_hooks func,
 		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
 	}
 
+	if ((iint->flags & IMA_META_IMMUTABLE_REQUIRED) &&
+	    status != INTEGRITY_PASS_IMMUTABLE) {
+		status = INTEGRITY_FAIL;
+		cause = "metadata-modifiable";
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+				    filename, op, cause, rc, 0);
+		goto out;
+	}
+
 	if (xattr_value)
 		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
 				  &cause);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4f8cb155e4fd..33b5133645b3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1079,7 +1079,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		return false;
 
 	if (entry->action != APPRAISE &&
-	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST))
+	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+			    IMA_CHECK_BLACKLIST | IMA_META_IMMUTABLE_REQUIRED))
 		return false;
 
 	/*
@@ -1109,7 +1110,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
-				     IMA_PERMIT_DIRECTIO))
+				     IMA_PERMIT_DIRECTIO |
+				     IMA_META_IMMUTABLE_REQUIRED))
 			return false;
 
 		break;
@@ -1121,7 +1123,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST))
+				     IMA_CHECK_BLACKLIST |
+				     IMA_META_IMMUTABLE_REQUIRED))
 			return false;
 
 		break;
@@ -1495,6 +1498,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				 strcmp(args[0].from, "imasig|modsig") == 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED |
 						IMA_MODSIG_ALLOWED;
+			else if (strcmp(args[0].from, "meta_immutable") == 0)
+				entry->flags |= IMA_META_IMMUTABLE_REQUIRED;
 			else
 				result = -EINVAL;
 			break;
@@ -1850,6 +1855,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 	if (entry->flags & IMA_CHECK_BLACKLIST)
 		seq_puts(m, "appraise_flag=check_blacklist ");
+	if (entry->flags & IMA_META_IMMUTABLE_REQUIRED)
+		seq_puts(m, "appraise_type=meta_immutable ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..be501a63ae30 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -39,6 +39,7 @@
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_MODSIG_ALLOWED	0x20000000
 #define IMA_CHECK_BLACKLIST	0x40000000
+#define IMA_META_IMMUTABLE_REQUIRED	0x80000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.26.2

