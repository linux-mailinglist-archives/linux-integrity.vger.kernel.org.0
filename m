Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3876072AA1C
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Jun 2023 09:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjFJH7H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 10 Jun 2023 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjFJH7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Jun 2023 03:59:02 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38323A8C;
        Sat, 10 Jun 2023 00:58:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdVS42nkqz9xqcr;
        Sat, 10 Jun 2023 15:48:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBH0AsGLYRklC8oAw--.4566S4;
        Sat, 10 Jun 2023 08:58:28 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 2/4] smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()
Date:   Sat, 10 Jun 2023 09:57:36 +0200
Message-Id: <20230610075738.3273764-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
References: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBH0AsGLYRklC8oAw--.4566S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4UCr17KFyDurW8Kw43GFg_yoWruF1DpF
        WUK3ZxKrs5tF1DWrWFyF4UWw4aka1rGrWUWr9xWrZav3ZrXw1xKFWkXr1YkF17Xrykur9Y
        qF4jqry5XFn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4qCJAAAsf
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

With the newly added ability of LSMs to supply multiple xattrs, set
SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
lsm_get_xattr_slot() a second time, if the transmuting conditions are met.

The LSM infrastructure passes all xattrs provided by LSMs to the
filesystems through the initxattrs() callback, so that filesystems can
store xattrs in the disk.

After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
call.

Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
adding a new xattr without checking and updating the existing HMAC.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack.h     |  2 +-
 security/smack/smack_lsm.c | 45 ++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index aa15ff56ed6..041688e5a77 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -128,7 +128,7 @@ struct task_smack {
 
 #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
 #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
-#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
+#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
 #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 25ade3819af..679156601a1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -52,7 +52,14 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
-#define SMACK_INODE_INIT_XATTRS 1
+/*
+ * Smack uses multiple xattrs.
+ * SMACK64 - for access control,
+ * SMACK64TRANSMUTE - label initialization,
+ * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
+ * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
+ */
+#define SMACK_INODE_INIT_XATTRS 2
 
 #ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
@@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     struct xattr *xattrs, int *xattr_count)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if ((tsp->smk_task == tsp->smk_transmuted) ||
 		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
 		     smk_inode_transmutable(dir))) {
+			struct xattr *xattr_transmute;
+
 			/*
 			 * The caller of smack_dentry_create_files_as()
 			 * should have overridden the current cred, so the
@@ -971,7 +979,18 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 			 */
 			if (tsp->smk_task != tsp->smk_transmuted)
 				isp = dsp;
-			issp->smk_flags |= SMK_INODE_CHANGED;
+			xattr_transmute = lsm_get_xattr_slot(xattrs,
+							     xattr_count);
+			if (xattr_transmute) {
+				xattr_transmute->value = kmemdup(TRANS_TRUE,
+								 TRANS_TRUE_SIZE,
+								 GFP_NOFS);
+				if (!xattr_transmute->value)
+					return -ENOMEM;
+
+				xattr_transmute->value_len = TRANS_TRUE_SIZE;
+				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
+			}
 		}
 
 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
@@ -3518,20 +3537,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			 * If there is a transmute attribute on the
 			 * directory mark the inode.
 			 */
-			if (isp->smk_flags & SMK_INODE_CHANGED) {
-				isp->smk_flags &= ~SMK_INODE_CHANGED;
-				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
-					XATTR_NAME_SMACKTRANSMUTE,
-					TRANS_TRUE, TRANS_TRUE_SIZE,
-					0);
-			} else {
-				rc = __vfs_getxattr(dp, inode,
-					XATTR_NAME_SMACKTRANSMUTE, trattr,
-					TRANS_TRUE_SIZE);
-				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
-						       TRANS_TRUE_SIZE) != 0)
-					rc = -EINVAL;
-			}
+			rc = __vfs_getxattr(dp, inode,
+					    XATTR_NAME_SMACKTRANSMUTE, trattr,
+					    TRANS_TRUE_SIZE);
+			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
+					       TRANS_TRUE_SIZE) != 0)
+				rc = -EINVAL;
 			if (rc >= 0)
 				transflag = SMK_INODE_TRANSMUTE;
 		}
-- 
2.25.1

