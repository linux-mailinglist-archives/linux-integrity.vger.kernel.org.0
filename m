Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7726B8D05
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 09:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCNIUM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCNIT0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 04:19:26 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCF1A643;
        Tue, 14 Mar 2023 01:18:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PbR5Y4Ghfz9xFfL;
        Tue, 14 Mar 2023 16:09:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnNl2zLRBkenSXAQ--.34127S3;
        Tue, 14 Mar 2023 09:18:17 +0100 (CET)
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
Subject: [PATCH v8 1/6] reiserfs: Switch to security_inode_init_security()
Date:   Tue, 14 Mar 2023 09:17:15 +0100
Message-Id: <20230314081720.4158676-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnNl2zLRBkenSXAQ--.34127S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur45GF1DJry5Wr15JFW7twb_yoW5Xw13pF
        47K3WUKr4kJF1Igr1Fya13W3WSgrWfGw47JrsxKrWDAanrJw18trW0yw13u34rGrZ7Jr1I
        qw409wsxCws8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj4qHYQAAsI
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
security_inode_init_security(). Commit 572302af1258 ("reiserfs: Add missing
calls to reiserfs_security_free()") fixed possible memory leaks and another
issue related to adding an xattr at inode creation time.

Define the initxattrs callback reiserfs_initxattrs(), to populate the
name/value/len triple in the reiserfs_security_handle() with the first
xattr provided by LSMs. Make a copy of the xattr value, as
security_inode_init_security() frees it.

After the call to security_inode_init_security(), remove the check for
returning -EOPNOTSUPP, as security_inode_init_security() changes it to
zero.

Multiple xattrs are currently not supported, as the
reiserfs_security_handle structure is exported to user space. As a
consequence, even if EVM is invoked, it will not provide an xattr (if it
is not the first to set it, its xattr will be discarded; if it is the
first, it does not have xattrs to calculate the HMAC on).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/reiserfs/xattr_security.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 41c0ea84fbf..6bffdf9a4fd 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -39,6 +39,22 @@ static bool security_list(struct dentry *dentry)
 	return !IS_PRIVATE(d_inode(dentry));
 }
 
+static int
+reiserfs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
+		    void *fs_info)
+{
+	struct reiserfs_security_handle *sec = fs_info;
+
+	sec->value = kmemdup(xattr_array->value, xattr_array->value_len,
+			     GFP_KERNEL);
+	if (!sec->value)
+		return -ENOMEM;
+
+	sec->name = xattr_array->name;
+	sec->length = xattr_array->value_len;
+	return 0;
+}
+
 /* Initializes the security context for a new inode and returns the number
  * of blocks needed for the transaction. If successful, reiserfs_security
  * must be released using reiserfs_security_free when the caller is done. */
@@ -56,12 +72,9 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
 	if (IS_PRIVATE(dir))
 		return 0;
 
-	error = security_old_inode_init_security(inode, dir, qstr, &sec->name,
-						 &sec->value, &sec->length);
+	error = security_inode_init_security(inode, dir, qstr,
+					     &reiserfs_initxattrs, sec);
 	if (error) {
-		if (error == -EOPNOTSUPP)
-			error = 0;
-
 		sec->name = NULL;
 		sec->value = NULL;
 		sec->length = 0;
-- 
2.25.1

