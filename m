Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF12C248AE9
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRQAQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:00:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgHRPpg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:36 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 545BE99586F4F7D8E732;
        Tue, 18 Aug 2020 16:45:35 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:45:33 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:45:36 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 15/30] ima: Add a reader counter to the integrity inode data
Date:   Tue, 18 Aug 2020 17:42:15 +0200
Message-ID: <20200818154230.14016-6-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
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

To detect ToMToU violations reader counter of the given inode is
checked. This is not enough, because the reader may exist in a
different ima namespace. Per inode reader counter tracks readers in all
ima namespaces, whereas the per namespace counter is necessary to avoid
false positives.

Add a new reader counter to the integrity inode cache entry.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_main.c | 71 ++++++++++++++++++++++---------
 security/integrity/integrity.h    | 18 ++++++++
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b933c7e6c8e1..6555cdf6b65e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,11 @@
 
 #include "ima.h"
 
+struct ima_file_data {
+	struct ima_namespace *ima_ns;
+	bool is_readcount;
+};
+
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
@@ -116,8 +121,8 @@ static void ima_rdwr_violation_check(struct file *file,
 				iint = integrity_iint_rb_find(ima_ns->iint_tree,
 							      inode);
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && atomic_read(&iint->readcount) &&
+			    test_bit(IMA_MUST_MEASURE, &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
@@ -171,7 +176,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 {
 	fmode_t mode = file->f_mode;
 	bool update;
-	struct ima_namespace *ima_ns = (struct ima_namespace *)file->f_ima;
+	struct ima_file_data *f_data = (struct ima_file_data *)file->f_ima;
 
 	if (!(mode & FMODE_WRITE))
 		return;
@@ -186,7 +191,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 
-			ima_check_active_ns(ima_ns, inode);
+			ima_check_active_ns(f_data->ima_ns, inode);
 
 			if (update)
 				ima_update_xattr(iint, file);
@@ -207,8 +212,18 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  */
 int ima_file_alloc(struct file *file)
 {
-	file->f_ima = get_current_ns();
-	get_ima_ns((struct ima_namespace *)file->f_ima);
+	struct ima_file_data *f_data;
+
+	f_data = kmalloc(sizeof(struct ima_file_data), GFP_KERNEL);
+	if (!f_data)
+		return -ENOMEM;
+
+	f_data->ima_ns = get_current_ns();
+	f_data->is_readcount = false;
+	get_ima_ns(f_data->ima_ns);
+
+	file->f_ima = f_data;
+
 	return 0;
 }
 
@@ -222,27 +237,33 @@ void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
-	struct ima_namespace *ima_ns = (struct ima_namespace *)file->f_ima;
+	struct ima_file_data *f_data = (struct ima_file_data *)file->f_ima;
 
 	if (unlikely(!(file->f_mode & FMODE_OPENED)))
 		goto out;
 
-	if (!ima_ns->policy_data->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!f_data->ima_ns->policy_data->ima_policy_flag ||
+	    !S_ISREG(inode->i_mode))
 		goto out;
 
-	iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
+	iint = integrity_iint_rb_find(f_data->ima_ns->iint_tree, inode);
 	if (!iint)
 		goto out;
 
 	ima_check_last_writer(iint, inode, file);
+
+	if (f_data->is_readcount)
+		iint_readcount_dec(iint);
 out:
-	put_ima_ns(ima_ns);
+	put_ima_ns(f_data->ima_ns);
+	kfree(f_data);
 }
 
 static int process_ns_measurement(struct file *file, const struct cred *cred,
 				  u32 secid, char *buf, loff_t size, int mask,
 				  enum ima_hooks func,
-				  struct ima_namespace *ima_ns)
+				  struct ima_namespace *ima_ns,
+				  bool readcount_open)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -262,6 +283,12 @@ static int process_ns_measurement(struct file *file, const struct cred *cred,
 	if (!ima_ns->policy_data->ima_policy_flag)
 		return 0;
 
+	if (ima_ns != current_ima_ns) {
+		iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
+		if (!iint)
+			return 0;
+	}
+
 	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
@@ -282,12 +309,18 @@ static int process_ns_measurement(struct file *file, const struct cred *cred,
 
 	inode_lock(inode);
 
-	if (action) {
+	if (action && !iint) {
 		iint = integrity_inode_rb_get(ima_ns->iint_tree, inode);
 		if (!iint)
 			rc = -ENOMEM;
 	}
 
+	if ((ima_ns == current_ima_ns) && iint && readcount_open &&
+	    ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)) {
+		iint_readcount_inc(iint);
+		((struct ima_file_data *)file->f_ima)->is_readcount = true;
+	}
+
 	if (!rc && violation_check)
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename, ima_ns);
@@ -429,7 +462,7 @@ static int process_ns_measurement(struct file *file, const struct cred *cred,
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       enum ima_hooks func, bool readcount_open)
 {
 	int ret;
 	struct ima_namespace *ima_ns;
@@ -444,7 +477,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			continue;
 
 		ret = process_ns_measurement(file, cred, secid, buf, size, mask,
-					     func, ima_ns);
+					     func, ima_ns, readcount_open);
 		if (ret != 0)
 			break;
 	}
@@ -471,7 +504,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, true);
 	}
 
 	return 0;
@@ -551,13 +584,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_task_getsecid(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+				  MAY_EXEC, BPRM_CHECK, false);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+				   MAY_EXEC, CREDS_CHECK, false);
 }
 
 /**
@@ -577,7 +610,7 @@ int ima_file_check(struct file *file, int mask)
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, true);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
@@ -779,7 +812,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, false);
 }
 
 /**
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 721d1850e4f9..c2981a98547e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -17,6 +17,7 @@
 #include <crypto/sha.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/atomic.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -138,6 +139,9 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+	atomic_t readcount; /* Reader counter, incremented only in FILE_CHECK or
+			     * MMAP_CHECK hooks, used for ima violation check.
+			     */
 };
 
 struct integrity_iint_tree {
@@ -294,3 +298,17 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_IMA
+static inline void iint_readcount_inc(struct integrity_iint_cache *iint)
+{
+	atomic_inc(&iint->readcount);
+}
+static inline void iint_readcount_dec(struct integrity_iint_cache *iint)
+{
+	if (WARN_ON(!atomic_read(&iint->readcount)))
+		return;
+
+	atomic_dec(&iint->readcount);
+}
+#endif
-- 
2.20.1

