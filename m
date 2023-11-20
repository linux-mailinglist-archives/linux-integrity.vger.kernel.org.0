Return-Path: <linux-integrity+bounces-122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27C7F1B03
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Nov 2023 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC261F2481C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Nov 2023 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C720B16;
	Mon, 20 Nov 2023 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C810DE;
	Mon, 20 Nov 2023 09:40:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvW76Nygz9xrpL;
	Tue, 21 Nov 2023 01:24:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXXxmVtlIZIKAQ--.7181S2;
	Mon, 20 Nov 2023 18:40:16 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 20/25] ima: Move IMA-Appraisal to LSM infrastructure
Date: Mon, 20 Nov 2023 18:33:13 +0100
Message-Id: <20231120173318.1132868-21-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXBXXxmVtlIZIKAQ--.7181S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryDJrWDGr13KFWrJF1rXrb_yoWfKw4fpF
	s5K3WkCw1rXFy7Wry0yFWDuwsa9ryjgry7X3y0g3ZayFn3Jr1jqFyftFy2yry5Cry0gF1v
	qF4qqrsxCr15tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26rxl6s0DMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvj
	xUIUUUUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apggAAsO
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Do the registration of IMA-Appraisal only functions separately from the
rest of IMA functions, as appraisal is a separate feature not necessarily
enabled in the kernel configuration.

Reuse the same approach as for other IMA functions, move hardcoded calls
from various places in the kernel to the LSM infrastructure. Declare the
functions as static and register them as hook implementations in
init_ima_appraise_lsm(), called by init_ima_lsm().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/attr.c                             |  2 -
 include/linux/ima.h                   | 55 ---------------------------
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
 security/integrity/ima/ima_main.c     |  1 +
 security/security.c                   | 13 -------
 6 files changed, 35 insertions(+), 79 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 221d2bb0a906..38841f3ebbcb 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,7 +17,6 @@
 #include <linux/filelock.h>
 #include <linux/security.h>
 #include <linux/evm.h>
-#include <linux/ima.h>
 
 #include "internal.h"
 
@@ -503,7 +502,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
-		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 23ae24b60ecf..0bae61a15b60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -92,66 +92,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry, int ia_valid);
-extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			      const char *xattr_name, const void *xattr_value,
-			      size_t xattr_value_len, int flags);
-extern int ima_inode_set_acl(struct mnt_idmap *idmap,
-			     struct dentry *dentry, const char *acl_name,
-			     struct posix_acl *kacl);
-static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
-}
-
-extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-				 const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
 	return 0;
 }
-
-static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
-					  struct dentry *dentry, int ia_valid)
-{
-	return;
-}
-
-static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
-				     struct dentry *dentry,
-				     const char *xattr_name,
-				     const void *xattr_value,
-				     size_t xattr_value_len,
-				     int flags)
-{
-	return 0;
-}
-
-static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
-				    struct dentry *dentry, const char *acl_name,
-				    struct posix_acl *kacl)
-{
-
-	return 0;
-}
-
-static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
-					struct dentry *dentry,
-					const char *xattr_name)
-{
-	return 0;
-}
-
-static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return 0;
-}
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c0412100023e..a27fc10f84f7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
+void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
 
 #else
 static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
@@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
+{
+}
+
 #endif /* CONFIG_IMA_APPRAISE */
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 36abc84ba299..076451109637 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -636,8 +636,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void ima_inode_post_setattr(struct mnt_idmap *idmap,
-			    struct dentry *dentry, int ia_valid)
+static void ima_inode_post_setattr(struct mnt_idmap *idmap,
+				   struct dentry *dentry, int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
@@ -750,9 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
 	return -EACCES;
 }
 
-int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len, int flags)
+static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const char *xattr_name, const void *xattr_value,
+			      size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
 	int digsig = 0;
@@ -781,8 +781,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return result;
 }
 
-int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const char *acl_name, struct posix_acl *kacl)
+static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
@@ -790,8 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
-int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			  const char *xattr_name)
+static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 const char *xattr_name)
 {
 	int result;
 
@@ -803,3 +803,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 	return result;
 }
+
+static int ima_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+				const char *acl_name)
+{
+	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
+}
+
+static struct security_hook_list ima_appraise_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_post_setattr, ima_inode_post_setattr),
+	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
+	LSM_HOOK_INIT(inode_set_acl, ima_inode_set_acl),
+	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
+	LSM_HOOK_INIT(inode_remove_acl, ima_inode_remove_acl),
+};
+
+void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
+{
+	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
+			   lsmid);
+}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index af213bece9b8..3b5d53a7f755 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1181,6 +1181,7 @@ static const struct lsm_id ima_lsmid = {
 int __init init_ima_lsm(void)
 {
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
+	init_ima_appraise_lsm(&ima_lsmid);
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index e18953ee4a97..d4ead59fb91f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -20,7 +20,6 @@
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
-#include <linux/ima.h>
 #include <linux/evm.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
@@ -2308,9 +2307,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
@@ -2338,9 +2334,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
-	if (ret)
-		return ret;
-	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
@@ -2401,9 +2394,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
-	if (ret)
-		return ret;
-	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
 	if (ret)
 		return ret;
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
@@ -2503,9 +2493,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(idmap, dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(idmap, dentry, name);
-- 
2.34.1


