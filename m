Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72463589E
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiKWKCT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 05:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiKWKBF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 05:01:05 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AD11A73F;
        Wed, 23 Nov 2022 01:53:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHGV71T9lz9xFQc;
        Wed, 23 Nov 2022 17:46:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH829J7X1jzDqKAA--.13162S5;
        Wed, 23 Nov 2022 10:52:50 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 3/6] security: Remove security_old_inode_init_security()
Date:   Wed, 23 Nov 2022 10:51:59 +0100
Message-Id: <20221123095202.599252-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAH829J7X1jzDqKAA--.13162S5
X-Coremail-Antispam: 1UD129KBjvJXoW7urWftw1rZw4rtr4rJrW5KFg_yoW5JFyrpF
        47t3WUGr1rJFyjgF10yF47u3WfKFWrGrZrJrs3C3sxJFn3Ar18tF1Fyr17CFyrJrW8Ww1I
        qw4a9r43Gr4DtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jxCztUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4HGZgABsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

As the remaining two users reiserfs and ocfs2 switched to
security_inode_init_security(), security_old_inode_init_security() can be
now removed.

Out-of-tree kernel modules should switch to security_inode_init_security()
too.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/security.h | 12 ------------
 security/security.c      | 11 -----------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..c682fc96ed61 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -336,9 +336,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
-int security_old_inode_init_security(struct inode *inode, struct inode *dir,
-				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry);
@@ -771,15 +768,6 @@ static inline int security_inode_init_security_anon(struct inode *inode,
 	return 0;
 }
 
-static inline int security_old_inode_init_security(struct inode *inode,
-						   struct inode *dir,
-						   const struct qstr *qstr,
-						   const char **name,
-						   void **value, size_t *len)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int security_inode_create(struct inode *dir,
 					 struct dentry *dentry,
 					 umode_t mode)
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..e2857446fd32 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1132,17 +1132,6 @@ int security_inode_init_security_anon(struct inode *inode,
 			     context_inode);
 }
 
-int security_old_inode_init_security(struct inode *inode, struct inode *dir,
-				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len)
-{
-	if (unlikely(IS_PRIVATE(inode)))
-		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
-}
-EXPORT_SYMBOL(security_old_inode_init_security);
-
 #ifdef CONFIG_SECURITY_PATH
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
-- 
2.25.1

