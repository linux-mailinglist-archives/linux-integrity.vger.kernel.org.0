Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE22489BD
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHRP0S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbgHRP0O (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:14 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 839E617247B5794C5F4C;
        Tue, 18 Aug 2020 16:26:12 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:10 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:13 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 03/30] ima: Bind ima namespace to the file descriptor
Date:   Tue, 18 Aug 2020 17:20:10 +0200
Message-ID: <20200818152037.11869-4-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

IMA namespace reference will be required in ima_file_free() to check
the policy and find inode integrity data for the correct ima namespace.
ima_file_free() is called on __fput(), and __fput() may be called after
releasing namespaces in exit_task_namespaces() in do_exit() and
therefore nsproxy reference cannot be used - it is already set to NULL.

This is a preparation for namespacing policy and inode integrity data.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 fs/file_table.c                   |  6 +++++-
 include/linux/fs.h                |  3 +++
 include/linux/ima.h               |  6 ++++++
 security/integrity/ima/ima_main.c | 27 +++++++++++++++++++++++++--
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..878213d8af92 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -109,6 +109,8 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 		return ERR_PTR(error);
 	}
 
+	ima_file_alloc(f);
+
 	atomic_long_set(&f->f_count, 1);
 	rwlock_init(&f->f_owner.lock);
 	spin_lock_init(&f->f_lock);
@@ -259,8 +261,10 @@ static void __fput(struct file *file)
 	struct inode *inode = file->f_inode;
 	fmode_t mode = file->f_mode;
 
-	if (unlikely(!(file->f_mode & FMODE_OPENED)))
+	if (unlikely(!(file->f_mode & FMODE_OPENED))) {
+		ima_file_free(file);
 		goto out;
+	}
 
 	might_sleep();
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 407881ebeab1..8d6264755935 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -947,6 +947,9 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+#ifdef CONFIG_IMA
+	void			*f_ima;
+#endif
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5b6235b97603..3954cef57c00 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -21,6 +21,7 @@ struct llist_node;
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
+extern int ima_file_alloc(struct file *file);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
@@ -66,6 +67,11 @@ static inline void ima_post_create_tmpfile(struct inode *inode)
 {
 }
 
+static inline int ima_file_alloc(struct file *file)
+{
+	return 0;
+}
+
 static inline void ima_file_free(struct file *file)
 {
 	return;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d800e73c8b62..c7e29277b953 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -169,6 +169,23 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 	mutex_unlock(&iint->mutex);
 }
 
+/**
+ * ima_file_alloc - called on __alloc_file()
+ * @file: pointer to file structure being created
+ *
+ * Bind IMA namespace to the file descriptor. This is necessary, because
+ * __fput can be called after exit_task_namespaces() in do_exit().
+ * In that case nsproxy is already NULL and ima ns has to be found
+ * differently in ima_file_free(). If process joins different ima ns, files
+ * opened in the old ns will point to that (old) ns.
+ */
+int ima_file_alloc(struct file *file)
+{
+	file->f_ima = get_current_ns();
+	get_ima_ns((struct ima_namespace *)file->f_ima);
+	return 0;
+}
+
 /**
  * ima_file_free - called on __fput()
  * @file: pointer to file structure being freed
@@ -179,15 +196,21 @@ void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
+	struct ima_namespace *ima_ns = (struct ima_namespace *)file->f_ima;
+
+	if (unlikely(!(file->f_mode & FMODE_OPENED)))
+		goto out;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
-		return;
+		goto out;
 
 	iint = integrity_iint_find(inode);
 	if (!iint)
-		return;
+		goto out;
 
 	ima_check_last_writer(iint, inode, file);
+out:
+	put_ima_ns(ima_ns);
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-- 
2.20.1

