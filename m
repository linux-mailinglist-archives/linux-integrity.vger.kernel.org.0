Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9771C48DC
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2020 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDVSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 May 2020 17:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgEDVSL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 May 2020 17:18:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044L28Js064164;
        Mon, 4 May 2020 17:18:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s28fmsv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 17:18:10 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 044LCVvs098136;
        Mon, 4 May 2020 17:18:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s28fmstq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 17:18:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044LFwlY016853;
        Mon, 4 May 2020 21:18:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 30s0g5a8tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 21:18:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 044LI4Sf59244790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 21:18:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD6F752052;
        Mon,  4 May 2020 21:18:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.205.195])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E902252057;
        Mon,  4 May 2020 21:18:03 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ima: verify mprotect change is consistent with mmap policy
Date:   Mon,  4 May 2020 17:17:40 -0400
Message-Id: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_11:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=3
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=882
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040160
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Files can be mmap'ed read/write and later changed to execute to circumvent
IMA's mmap appraise policy rules.  Due to locking issues (mmap semaphore
would be taken prior to i_mutex), files can not be measured or appraised at
this point.  Eliminate this integrity gap, by denying the mprotect
PROT_EXECUTE change, if an mmap appraise policy rule exists.

On mprotect change success, return 0.  On failure, return -EACESS.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h               |  7 ++++++
 security/integrity/ima/ima_main.c | 50 +++++++++++++++++++++++++++++++++++++++
 security/security.c               |  7 +++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index aefe758f4466..9164e1534ec9 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,6 +18,7 @@ extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
@@ -70,6 +71,12 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
+static inline int ima_file_mprotect(struct vm_area_struct *vma,
+				    unsigned long prot)
+{
+	return 0;
+}
+
 static inline int ima_load_data(enum kernel_load_data_id id)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f96f151294e6..a8706bf7ca25 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -394,6 +394,56 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 }
 
 /**
+ * ima_file_mprotect - based on policy, limit mprotect change
+ * @prot: contains the protection that will be applied by the kernel.
+ *
+ * Files can be mmap'ed read/write and later changed to execute to circumvent
+ * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
+ * would be taken before i_mutex), files can not be measured or appraised at
+ * this point.  Eliminate this integrity gap by denying the mprotect
+ * PROT_EXECUTE change, if an mmap appraise policy rule exists.
+ *
+ * On mprotect change success, return 0.  On failure, return -EACESS.
+ */
+int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
+{
+	struct ima_template_desc *template;
+	struct inode *inode;
+	int result = 0;
+	int action;
+	u32 secid;
+	int pcr;
+
+	if (vma->vm_file && (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+		inode = file_inode(vma->vm_file);
+
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
+					MMAP_CHECK, &pcr, &template, 0);
+
+		if (action & IMA_APPRAISE_SUBMASK)
+			result = -EPERM;
+
+		if ((action & IMA_APPRAISE_SUBMASK) || (action & IMA_MEASURE)) {
+			struct file *file = vma->vm_file;
+			char *pathbuf = NULL;
+			const char *pathname;
+			char filename[NAME_MAX];
+
+			pathname = ima_d_path(&file->f_path, &pathbuf,
+					      filename);
+			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+					    pathname, "collect_data",
+					    "failed-mprotect", result, 0);
+
+			if (pathbuf)
+				__putname(pathbuf);
+		}
+	}
+	return result;
+}
+
+/**
  * ima_bprm_check - based on policy, collect/store measurement.
  * @bprm: contains the linux_binprm structure
  *
diff --git a/security/security.c b/security/security.c
index 7fed24b9d57e..dd0917c5bfe9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1512,7 +1512,12 @@ int security_mmap_addr(unsigned long addr)
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	int ret;
+
+	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	if (ret)
+		return ret;
+	return ima_file_mprotect(vma, prot);
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
-- 
2.7.5

