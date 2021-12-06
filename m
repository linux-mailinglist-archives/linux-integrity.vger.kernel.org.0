Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051446A2C9
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhLFRaP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:30:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240569AbhLFR34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GkXpp027708;
        Mon, 6 Dec 2021 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PM0gndEpvTn46PA3+JRUPlIWFGwWfyFTTuOLVtbS4rY=;
 b=fKO/K3MrdDZm1PB4SIyEx+FKeAXCEAoRaJSM/di42ALPXak2vHQTjfe/t+kp1Pzi6ckv
 bhe0hqp9nUjhcK83mzWnjEsQ1vkD3AOn+FPRnNrxkvQQuXerKOkkYn5gUceoqmGq0pGu
 5Oo86Csx+HD1z4n8XocoNU/q+hyTyeSxLhKbnlqxR6/kqxz08g/MbE3HcENKq7TkLS87
 9aJcJYmvKSkEHLe45oNH0w7ew7T/URzFm8l2vVkPvZVKtkdHjHVD2LXvZzGcxXtiZgIO
 +RPPPCdPFHt5lGX4WWUdiO8gkkqQWaXFy5ZDbCdLyFmQ3YDLmq57jK5jRm3ElsN6/7p0 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspb98u82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6Gnlmr008485;
        Mon, 6 Dec 2021 17:26:12 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspb98u7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HDi2R029870;
        Mon, 6 Dec 2021 17:26:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyy9tc1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ92442729750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 028B828064;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D937928059;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3 12/16] securityfs: Extend securityfs with namespacing support
Date:   Mon,  6 Dec 2021 12:25:56 -0500
Message-Id: <20211206172600.1495968-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FZ6rGAmi7e69kOK97EIyxdQZ0KctKQ2x
X-Proofpoint-ORIG-GUID: WKP_zGG8wDGTMkBFimuplVlz4CrU7OwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend 'securityfs' for support of IMA namespacing so that each
IMA (user) namespace can have its own front-end for showing the currently
active policy, the measurement list, number of violations and so on.

The filesystem can be mounted to the usual securityfs mount point like
this:

mount -t securityfs /sys/kernel/security /sys/kernel/security

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/security.h       |  8 +++++
 include/linux/user_namespace.h |  1 +
 security/inode.c               | 58 ++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7e0ba63b5dde..b5266bedef3f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1929,6 +1929,14 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
 
+enum {
+	SECURITYFS_NS_ADD,
+	SECURITYFS_NS_REMOVE,
+};
+
+extern int securityfs_register_ns_notifier(struct notifier_block *nb);
+extern int securityfs_unregister_ns_notifier(struct notifier_block *nb);
+
 #else /* CONFIG_SECURITYFS */
 
 static inline struct dentry *securityfs_create_dir(const char *name,
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 89663e6e0e85..6b8bd060d8c4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -105,6 +105,7 @@ struct user_namespace {
 #endif
 #ifdef CONFIG_SECURITYFS
 	struct vfsmount		*securityfs_mount;
+	bool			securityfs_notifier_sent;
 #endif
 } __randomize_layout;
 
diff --git a/security/inode.c b/security/inode.c
index f1006cec6ce6..45211845fc31 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -18,6 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/namei.h>
+#include <linux/notifier.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
@@ -25,6 +26,8 @@
 
 static int securityfs_mount_count;
 
+static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
+
 static void securityfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -37,6 +40,32 @@ static const struct super_operations securityfs_super_operations = {
 	.free_inode	= securityfs_free_inode,
 };
 
+static struct file_system_type fs_type;
+
+static void securityfs_free_context(struct fs_context *fc)
+{
+	struct user_namespace *ns = fc->user_ns;
+
+	if (ns == &init_user_ns ||
+	    ns->securityfs_notifier_sent)
+		return;
+
+	ns->securityfs_notifier_sent = true;
+
+	ns->securityfs_mount = vfs_kern_mount(&fs_type, SB_KERNMOUNT,
+					      fs_type.name, NULL);
+	if (IS_ERR(ns->securityfs_mount)) {
+		printk(KERN_ERR "kern mount on securityfs ERROR: %ld\n",
+		       PTR_ERR(ns->securityfs_mount));
+		ns->securityfs_mount = NULL;
+		return;
+	}
+
+	blocking_notifier_call_chain(&securityfs_ns_notifier,
+				     SECURITYFS_NS_ADD, fc->user_ns);
+	mntput(ns->securityfs_mount);
+}
+
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
@@ -53,11 +82,12 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
 	.get_tree	= securityfs_get_tree,
+	.free		= securityfs_free_context,
 };
 
 static int securityfs_init_fs_context(struct fs_context *fc)
@@ -66,13 +96,37 @@ static int securityfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void securityfs_kill_super(struct super_block *sb)
+{
+	struct user_namespace *ns = sb->s_fs_info;
+
+	if (ns != &init_user_ns)
+		blocking_notifier_call_chain(&securityfs_ns_notifier,
+					     SECURITYFS_NS_REMOVE,
+					     sb->s_fs_info);
+	ns->securityfs_notifier_sent = false;
+	ns->securityfs_mount = NULL;
+	kill_litter_super(sb);
+}
+
 static struct file_system_type fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	securityfs_kill_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
+int securityfs_register_ns_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&securityfs_ns_notifier, nb);
+}
+
+int securityfs_unregister_ns_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&securityfs_ns_notifier, nb);
+}
+
 /**
  * securityfs_create_dentry - create a dentry in the securityfs filesystem
  *
-- 
2.31.1

