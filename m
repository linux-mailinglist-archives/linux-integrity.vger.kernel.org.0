Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F263EE24
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Dec 2022 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLAKnM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Dec 2022 05:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLAKmn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Dec 2022 05:42:43 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF62ADC;
        Thu,  1 Dec 2022 02:42:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NNCC93B8dz9v7Yy;
        Thu,  1 Dec 2022 18:35:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHcm_phIhjrxuvAA--.49496S3;
        Thu, 01 Dec 2022 11:42:06 +0100 (CET)
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
Subject: [PATCH v7 1/6] reiserfs: Switch to security_inode_init_security()
Date:   Thu,  1 Dec 2022 11:41:20 +0100
Message-Id: <20221201104125.919483-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHcm_phIhjrxuvAA--.49496S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13CFWkJw1ktF48uryfWFg_yoW5Jw4rpF
        43K3W7Krs8JF1Igr1Sya13W3WfKrWfKw47JrsxKryDAanrJr1rtry0yw13u34rGrZ7Jr1I
        qw4Ivw43Cws8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-TmDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4YhwwAAsd
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for removing security_old_inode_init_security(), switch to
security_inode_init_security().

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
---
 fs/reiserfs/xattr_security.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 857a65b05726..0ba96757681d 100644
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

