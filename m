Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E906358AE
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 11:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiKWKCU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 05:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbiKWKBD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 05:01:03 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4F11A704;
        Wed, 23 Nov 2022 01:53:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NHGVd4fZRz9xFXk;
        Wed, 23 Nov 2022 17:46:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH829J7X1jzDqKAA--.13162S4;
        Wed, 23 Nov 2022 10:52:40 +0100 (CET)
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
Subject: [PATCH v5 2/6] ocfs2: Switch to security_inode_init_security()
Date:   Wed, 23 Nov 2022 10:51:58 +0100
Message-Id: <20221123095202.599252-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAH829J7X1jzDqKAA--.13162S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rKFyxCF1xJw4fAr4xZwb_yoWrKryrpa
        1rtFnxtr4fJFy8Wryftr4a9a1S9rWrGrZrGrs3G34DZFn8Cr1ftry0yr1Y9Fy5XrWDJFyk
        tr4Fkrsxuws8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4HGZgAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for removing security_old_inode_init_security(), switch to
security_inode_init_security().

Extend the existing ocfs2_initxattrs() to take the
ocfs2_security_xattr_info structure from fs_info, and populate the
name/value/len triple with the first xattr provided by LSMs. Supporting
multiple xattrs is not currently supported, as it requires non-trivial
changes that can be done at a later time.

As fs_info was not used before, ocfs2_initxattrs() can now handle the case
of replicating the behavior of security_old_inode_init_security(), i.e.
just obtaining the xattr, in addition to setting all xattrs provided by
LSMs.

Finally, modify the handling of the return value from
ocfs2_init_security_get(). As security_inode_init_security() does not
return -EOPNOTSUPP, remove this case and directly handle the error if the
return value is not zero.

However, the previous case of receiving -EOPNOTSUPP should be still
taken into account, as security_inode_init_security() could return zero
without setting xattrs and ocfs2 would consider it as if the xattr was set.

Instead, if security_inode_init_security() returned zero, look at the xattr
if it was set, and behave accordingly, i.e. set si->enable to zero to
notify to the functions following ocfs2_init_security_get() that the xattr
is not available (same as if security_old_inode_init_security() returned
-EOPNOTSUPP).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/ocfs2/namei.c | 18 ++++++------------
 fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 05f32989bad6..55fba81cd2d1 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	int want_meta = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota_inode = 0;
@@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	/* get security xattr */
 	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
 	if (status) {
-		if (status == -EOPNOTSUPP)
-			si.enable = 0;
-		else {
-			mlog_errno(status);
-			goto leave;
-		}
+		mlog_errno(status);
+		goto leave;
 	}
 
 	/* calculate meta data/clusters for setting security and acl xattr */
@@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	int want_clusters = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota = 0, did_quota_inode = 0;
@@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	/* get security xattr */
 	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
 	if (status) {
-		if (status == -EOPNOTSUPP)
-			si.enable = 0;
-		else {
-			mlog_errno(status);
-			goto bail;
-		}
+		mlog_errno(status);
+		goto bail;
 	}
 
 	/* calculate meta data/clusters for setting security xattr */
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..55699c573541 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
 static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 		     void *fs_info)
 {
+	struct ocfs2_security_xattr_info *si = fs_info;
 	const struct xattr *xattr;
 	int err = 0;
 
+	if (si) {
+		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
+				    GFP_KERNEL);
+		if (!si->value)
+			return -ENOMEM;
+
+		si->name = xattr_array->name;
+		si->value_len = xattr_array->value_len;
+		return 0;
+	}
+
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
 				      xattr->name, xattr->value,
@@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
 			    const struct qstr *qstr,
 			    struct ocfs2_security_xattr_info *si)
 {
+	int ret;
+
 	/* check whether ocfs2 support feature xattr */
 	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
 		return -EOPNOTSUPP;
-	if (si)
-		return security_old_inode_init_security(inode, dir, qstr,
-							&si->name, &si->value,
-							&si->value_len);
+	if (si) {
+		ret = security_inode_init_security(inode, dir, qstr,
+						   &ocfs2_initxattrs, si);
+		/*
+		 * security_inode_init_security() does not return -EOPNOTSUPP,
+		 * we have to check the xattr ourselves.
+		 */
+		if (!ret && !si->name)
+			si->enable = 0;
+
+		return ret;
+	}
 
 	return security_inode_init_security(inode, dir, qstr,
 					    &ocfs2_initxattrs, NULL);
-- 
2.25.1

