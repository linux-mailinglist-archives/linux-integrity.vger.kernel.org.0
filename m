Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA86D206A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Mar 2023 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCaMdr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Mar 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjCaMdg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Mar 2023 08:33:36 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5942061F;
        Fri, 31 Mar 2023 05:33:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pnzx83xBfz9xHvZ;
        Fri, 31 Mar 2023 20:24:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnumHa0iZkr6ziAQ--.5882S5;
        Fri, 31 Mar 2023 13:33:02 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10 3/4] evm: Align evm_inode_init_security() definition with LSM infrastructure
Date:   Fri, 31 Mar 2023 14:32:20 +0200
Message-Id: <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnumHa0iZkr6ziAQ--.5882S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43tw1kKw15Kr1kGF4xtFb_yoWrCrWfpF
        Zxt3WUCr1rJFyUWryFyF47u3WSgFWrGr4UtrZ3G34jyFnxtr1xtFWFyr15uFyrXrW8Jrna
        qw429r1rWrn0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j4T5LUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4dsJQAAs0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change the evm_inode_init_security() definition to align with the LSM
infrastructure. Keep the existing behavior of including in the HMAC
calculation only the first xattr provided by LSMs.

Changing the evm_inode_init_security() definition requires passing the
xattr array allocated by security_inode_init_security(), and the number of
xattrs filled by previously invoked LSMs.

Use the newly introduced lsm_get_xattr_slot() to position EVM correctly in
the xattrs array, like a regular LSM, and to increment the number of filled
slots. For now, the LSM infrastructure allocates enough xattrs slots to
store the EVM xattr, without using the reservation mechanism.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h               | 13 +++++++------
 security/integrity/evm/evm_main.c | 16 ++++++++++------
 security/security.c               |  6 +++---
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 7dc1ee74169..597632c71c7 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -56,9 +56,9 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 {
 	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
 }
-extern int evm_inode_init_security(struct inode *inode,
-				   const struct xattr *xattr_array,
-				   struct xattr *evm);
+extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
+				   const struct qstr *qstr,
+				   struct xattr *xattrs, int *xattr_count);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -157,9 +157,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_init_security(struct inode *inode,
-					  const struct xattr *xattr_array,
-					  struct xattr *evm)
+static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
+					  const struct qstr *qstr,
+					  struct xattr *xattrs,
+					  int *xattr_count)
 {
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cf24c525558..475196ce712 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -21,6 +21,7 @@
 #include <linux/evm.h>
 #include <linux/magic.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/lsm_hooks.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 /*
  * evm_inode_init_security - initializes security.evm HMAC value
  */
-int evm_inode_init_security(struct inode *inode,
-				 const struct xattr *lsm_xattr,
-				 struct xattr *evm_xattr)
+int evm_inode_init_security(struct inode *inode, struct inode *dir,
+			    const struct qstr *qstr, struct xattr *xattrs,
+			    int *xattr_count)
 {
 	struct evm_xattr *xattr_data;
+	struct xattr *evm_xattr;
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattr->name))
+	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
+	    !evm_protected_xattr(xattrs->name))
 		return 0;
 
+	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
 	if (!xattr_data)
 		return -ENOMEM;
 
 	xattr_data->data.type = EVM_XATTR_HMAC;
-	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
+	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
 	if (rc < 0)
 		goto out;
 
diff --git a/security/security.c b/security/security.c
index 1aeaa8ce449..ef7779ec8b2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1645,9 +1645,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!xattr_count)
 		goto out;
 
-	ret = evm_inode_init_security(inode, new_xattrs,
-				      new_xattrs + xattr_count);
-	if (ret)
+	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
+				      &xattr_count);
+	if (ret && ret != -EOPNOTSUPP)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
-- 
2.25.1

