Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D707D9274
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbjJ0Iod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJ0IoQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 04:44:16 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985719A2;
        Fri, 27 Oct 2023 01:43:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGwlT2rj0z9xGYP;
        Fri, 27 Oct 2023 16:27:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnP5EaeDtl3AMCAw--.27269S2;
        Fri, 27 Oct 2023 09:43:19 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 20/23] ima: Move IMA-Appraisal to LSM infrastructure
Date:   Fri, 27 Oct 2023 10:42:31 +0200
Message-Id: <20231027084234.485243-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDnP5EaeDtl3AMCAw--.27269S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4UGFyxCF1kKrW8AF1xuFg_yoWDJw4DpF
        s5K3WkC34rXFy7Wry0yFWDuwsa9ryYgry7X3y0g3ZayFn3Jr1jqFyftFy2yry5CrW0gF1v
        qF4qqrnxCr15tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5WUdwABsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Do the registration of IMA-Appraisal functions separately from the rest of
IMA functions, as appraisal is a separate feature not necessarily enabled
in the kernel configuration.

Reuse the same approach as for other IMA functions, move hardcoded calls
from various places in the kernel to the LSM infrastructure. Declare the
functions as static and register them as hook implementations in
init_ima_appraise_lsm(), called by init_ima_lsm().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/attr.c                             |  2 -
 include/linux/ima.h                   | 55 ---------------------------
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
 security/integrity/ima/ima_main.c     |  1 +
 security/security.c                   | 13 -------
 6 files changed, 35 insertions(+), 79 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index ebd8d61a3b8b..20c144874076 100644
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
index f923ff5c6524..9aabbc37916c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1161,6 +1161,7 @@ const struct lsm_id *ima_get_lsm_id(void)
 void __init init_ima_lsm(void)
 {
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
+	init_ima_appraise_lsm(&ima_lsmid);
 }
 
 /* Introduce a dummy function as 'ima' init method (it cannot be NULL). */
diff --git a/security/security.c b/security/security.c
index d962c2eaf2a2..99224de42ce0 100644
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
@@ -2301,9 +2300,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
@@ -2331,9 +2327,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
-	if (ret)
-		return ret;
-	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
@@ -2394,9 +2387,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
-	if (ret)
-		return ret;
-	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
 	if (ret)
 		return ret;
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
@@ -2496,9 +2486,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
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

