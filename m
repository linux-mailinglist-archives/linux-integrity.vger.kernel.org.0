Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBB675FD
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfGLUlr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 16:41:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbfGLUlr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 16:41:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CKb6eL028446
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 16:41:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpyga466q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 16:41:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 12 Jul 2019 21:41:43 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 21:41:41 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CKfe4N31392126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 20:41:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D98E42045;
        Fri, 12 Jul 2019 20:41:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C973D42042;
        Fri, 12 Jul 2019 20:41:39 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 20:41:39 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH] ima: fix ima_file_mmap circular locking dependency
Date:   Fri, 12 Jul 2019 16:41:37 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19071220-0016-0000-0000-000002922858
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071220-0017-0000-0000-000032EFEE4F
Message-Id: <1562964097-8578-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=809 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120210
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The LSM security_mmap_file hook is called before the mmap_sem is taken.
This results in IMA taking the i_mutex before the mmap_sem, yet the
normal locking order is mmap_sem, i_mutex.

To resolve this problem, rename and call ima_mmap_file() after taking
the mmap_sem.

Reported-by: syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h               | 4 ++--
 ipc/shm.c                         | 5 +++++
 mm/util.c                         | 8 ++++++++
 security/integrity/ima/ima_main.c | 2 +-
 security/security.c               | 8 ++------
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 71796a0959d9..10adb38e0e43 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -17,7 +17,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
-extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_mmap_file(struct file *file, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
@@ -65,7 +65,7 @@ static inline void ima_file_free(struct file *file)
 	return;
 }
 
-static inline int ima_file_mmap(struct file *file, unsigned long prot)
+static inline int ima_mmap_file(struct file *file, unsigned long prot)
 {
 	return 0;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..a712c7d426f0 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -34,6 +34,7 @@
 #include <linux/mman.h>
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
+#include <linux/ima.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
 #include <linux/capability.h>
@@ -1549,6 +1550,10 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		goto out_fput;
 	}
 
+	err = ima_mmap_file(file, prot);
+	if (err)
+		goto out_fput;
+
 	if (addr && !(shmflg & SHM_REMAP)) {
 		err = -EINVAL;
 		if (addr + size < addr)
diff --git a/mm/util.c b/mm/util.c
index 9834c4ab7d8e..dbf2c15caacd 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -9,6 +9,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mman.h>
@@ -360,6 +361,13 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	if (!ret) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+
+		ret = ima_mmap_file(file, prot);
+		if (ret) {
+			up_write(&mm->mmap_sem);
+			return ret;
+		}
+
 		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
 				    &populate, &uf);
 		up_write(&mm->mmap_sem);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 45d9ece88668..14678665cdc8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -380,7 +380,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_mmap(struct file *file, unsigned long prot)
+int ima_mmap_file(struct file *file, unsigned long prot)
 {
 	u32 secid;
 
diff --git a/security/security.c b/security/security.c
index a749d884faec..e324c425e466 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1410,12 +1410,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
-	int ret;
-	ret = call_int_hook(mmap_file, 0, file, prot,
-					mmap_prot(file, prot), flags);
-	if (ret)
-		return ret;
-	return ima_file_mmap(file, prot);
+	return call_int_hook(mmap_file, 0, file, prot,
+			     mmap_prot(file, prot), flags);
 }
 
 int security_mmap_addr(unsigned long addr)
-- 
2.7.5

