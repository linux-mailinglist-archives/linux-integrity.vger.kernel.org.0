Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23621C5EDD
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgEERbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 May 2020 13:31:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729199AbgEERbJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 May 2020 13:31:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045H2DC3174902;
        Tue, 5 May 2020 13:31:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1sx6e6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 13:31:05 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045HQ1gP047636;
        Tue, 5 May 2020 13:31:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1sx6e5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 13:31:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045HKTBc015153;
        Tue, 5 May 2020 17:31:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5qfa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 17:31:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045HV1kV1835350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 17:31:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04690A4062;
        Tue,  5 May 2020 17:31:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBEE3A4060;
        Tue,  5 May 2020 17:30:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.161.225])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 17:30:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1] ima: verify mprotect change is consistent with mmap policy
Date:   Tue,  5 May 2020 13:30:45 -0400
Message-Id: <1588699845-6196-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_09:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=915 bulkscore=0 clxscore=1015 suspectscore=3
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050129
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
Changelog v1:
- Reverse tests to remove code indentation. (Lakshmi Ramasubramanian)
- General code cleanup, including adding comments.

 include/linux/ima.h               |  7 ++++++
 security/integrity/ima/ima_main.c | 51 +++++++++++++++++++++++++++++++++++++++
 security/security.c               |  7 +++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

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
index f96f151294e6..800fb3bba418 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -394,6 +394,57 @@ int ima_file_mmap(struct file *file, unsigned long prot)
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
+	struct file *file = vma->vm_file;
+	char filename[NAME_MAX];
+	char *pathbuf = NULL;
+	const char *pathname = NULL;
+	struct inode *inode;
+	int result = 0;
+	int action;
+	u32 secid;
+	int pcr;
+
+	/* Is mprotect making an mmap'ed file executable? */
+	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+		return 0;
+
+	security_task_getsecid(current, &secid);
+	inode = file_inode(vma->vm_file);
+	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
+				MMAP_CHECK, &pcr, &template, 0);
+
+	/* Is the mmap'ed file in policy? */
+	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
+		return 0;
+
+	if (action & IMA_APPRAISE_SUBMASK)
+		result = -EPERM;
+
+	file = vma->vm_file;
+	pathname = ima_d_path(&file->f_path, &pathbuf, filename);
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
+			    "collect_data", "failed-mprotect", result, 0);
+	if (pathbuf)
+		__putname(pathbuf);
+
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

