Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6815223
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfEFQ54 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 12:57:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727036AbfEFQ54 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 12:57:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46Gs5PK113574
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 12:57:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2saqwntrhv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 12:57:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 17:57:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 17:57:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46Gvnvl52756698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 16:57:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C92DA404D;
        Mon,  6 May 2019 16:57:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47DDBA4051;
        Mon,  6 May 2019 16:57:48 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.95.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 16:57:48 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 3/3] ima: prevent a file already mmap'ed read|execute to be mmap'ed write
Date:   Mon,  6 May 2019 12:57:04 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
References: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050616-0012-0000-0000-00000318E37A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050616-0013-0000-0000-000021515D84
Message-Id: <1557161824-6623-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel calls deny_write_access() to prevent a file already opened
for write from being executed and also prevents files being executed
from being opened for write.  For some reason this does not extend to
files being mmap'ed execute.

This patch prevents allowing a file in policy, already mmap'ed
read|execute or read, from being mmap'ed shared write.  It should
differentiate between read|execute and read.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h               |  6 ++++--
 security/integrity/ima/ima_main.c | 21 ++++++++++++++++++++-
 security/security.c               |  4 ++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..04444895b4f2 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -20,7 +20,8 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
-extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_file_mmap(struct file *file, unsigned long prot,
+		unsigned long flags);
 extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
@@ -66,7 +67,8 @@ static inline void ima_file_free(struct file *file)
 	return;
 }
 
-static inline int ima_file_mmap(struct file *file, unsigned long prot)
+static inline int ima_file_mmap(struct file *file, unsigned long prot,
+		unsigned long flags)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ae77d13cb43c..d13e4efa8599 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -354,6 +354,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
  * @prot: contains the protection that will be applied by the kernel.
+ * @flags:
  *
  * Measure files being mmapped executable based on the ima_must_measure()
  * policy decision.
@@ -361,8 +362,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_mmap(struct file *file, unsigned long prot)
+int ima_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
 {
+	struct inode *inode;
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
@@ -371,6 +373,23 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 					   0, MAY_EXEC, MMAP_CHECK);
 	}
 
+	/*
+	 * Prevent a file, in policy, mapped read|execute, from being mapped
+	 * write shared. (Should differentiate between read and read|execute.)
+	 */
+	if (file && (prot & PROT_WRITE) && ((flags & MAP_TYPE) == MAP_SHARED) &&
+	    mapping_mapped(file->f_mapping) &&
+	    !mapping_writably_mapped(file->f_mapping)) {
+		inode = file_inode(file);
+
+		if (!ima_must_appraise(inode, MAY_ACCESS, MMAP_CHECK))
+			return 0;
+
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+				    file_dentry(file)->d_iname,
+				    "mmap_file", "mmapped_readers", -EACCES, 0);
+		return -EACCES;
+	}
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index 98ce27933e72..e64d9c5b2e1a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1400,7 +1400,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 					mmap_prot(file, prot), flags);
 	if (ret)
 		return ret;
-	return ima_file_mmap(file, prot);
+	return ima_file_mmap(file, prot, flags);
 }
 
 int security_mmap_addr(unsigned long addr)
@@ -1416,7 +1416,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
 	if (ret)
 		return ret;
-	return ima_file_mmap(vma->vm_file, prot);
+	return ima_file_mmap(vma->vm_file, prot, 0);
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
-- 
2.7.5

