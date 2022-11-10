Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22164623F00
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKJJrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiKJJrq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 04:47:46 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D926AEF3;
        Thu, 10 Nov 2022 01:47:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4N7Gzx6w8Dz9xFHR;
        Thu, 10 Nov 2022 17:41:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHc3CNyGxjO3hSAA--.1123S4;
        Thu, 10 Nov 2022 10:47:18 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 2/5] security: Rewrite security_old_inode_init_security()
Date:   Thu, 10 Nov 2022 10:46:36 +0100
Message-Id: <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHc3CNyGxjO3hSAA--.1123S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr47uw45CrW5tFyfWF1Utrb_yoWrWr47pF
        43K3WUCr1rJF97WrWfta17u3WSkFWrGrsrAws3C3sFyF1DCr1xtryFyF15Cr15XrW8Jr1v
        qw4avr15Gwn8J3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4FHEgAAsv
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Rewrite security_old_inode_init_security() to call
security_inode_init_security() before making changes to support multiple
LSMs providing xattrs. Do it so that the required changes are done only in
one place.

Define the security_initxattrs() callback and pass it to
security_inode_init_security() as argument, to obtain the first xattr
provided by LSMs.

This behavior is a bit different from the current one. Before this patch
calling call_int_hook() could cause multiple LSMs to provide an xattr,
since call_int_hook() does not stop when an LSM returns zero. The caller of
security_old_inode_init_security() receives the last xattr set. The pointer
of the xattr value of previous LSMs is lost, causing memory leaks.

However, in practice, this scenario does not happen as the only in-tree
LSMs providing an xattr at inode creation time are SELinux and Smack, which
are mutually exclusive.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 58 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..a0e9b4ce2341 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1089,20 +1089,34 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
 
+static int security_initxattrs(struct inode *inode, const struct xattr *xattrs,
+			       void *fs_info)
+{
+	struct xattr *dest = (struct xattr *)fs_info;
+
+	dest->name = xattrs->name;
+	dest->value = xattrs->value;
+	dest->value_len = xattrs->value_len;
+	return 0;
+}
+
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	int ret = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
+		goto out_exit;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs ||
+	    (initxattrs == &security_initxattrs && !fs_data)) {
+		ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
+				    dir, qstr, NULL, NULL, NULL);
+		goto out_exit;
+	}
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
 	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
@@ -1118,8 +1132,19 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
+	for (xattr = new_xattrs; xattr->value != NULL; xattr++) {
+		/*
+		 * Xattr value freed by the caller of
+		 * security_old_inode_init_security().
+		 */
+		if (xattr == new_xattrs && initxattrs == &security_initxattrs &&
+		    !ret)
+			continue;
 		kfree(xattr->value);
+	}
+out_exit:
+	if (initxattrs == &security_initxattrs)
+		return ret;
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
@@ -1136,10 +1161,23 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	if (unlikely(IS_PRIVATE(inode)))
-		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
+	struct xattr xattr = {};
+	struct xattr *lsm_xattr = (value) ? &xattr : NULL;
+	int ret;
+
+	ret = security_inode_init_security(inode, dir, qstr,
+					   security_initxattrs, lsm_xattr);
+	if (ret)
+		return ret;
+
+	if (name)
+		*name = lsm_xattr->name;
+	if (value)
+		*value = lsm_xattr->value;
+	if (len)
+		*len = lsm_xattr->value_len;
+
+	return 0;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
-- 
2.25.1

