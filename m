Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8846C16E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhLGRQ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 12:16:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239881AbhLGRQy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 12:16:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FL4Wh019175;
        Tue, 7 Dec 2021 17:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=EJk7rsSrAbKDtjufCB2SG7/7otESN/ib7deTgIHHaT0=;
 b=c7r64Jnl+ro9P8jQlVNZTapoqcfPg8jaZ3ayO4kXpalIBVwzweHowWAJBsvYUYC/h+Ze
 bIt5480fNPHgb2L2gjNis74frRTQc6Wd3qXkG9ZyQsK2VJHg7Gd+SZGWhBYdo4vMC8x3
 ni+9TQ9SiCn8+73Fvo0N6FK/7kRxC/1BKqZ8lTW2SHmfZ5r/uR3tL0Rakd9Nvgdm3kG4
 j2/Qh8jbZTQurXxBs4QXN/QNiKiPA/Uh8c10/+xivZBQ255QU/jEdwYzy4wlshC3RLox
 OJBnF1N+7u/gqL2FAkw58BUI9aaKGkgkiR/4e+hwNgtqkJRv9hNbvVJH32LYBj81ic/V kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811e1xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:13:09 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7GLd7E017257;
        Tue, 7 Dec 2021 17:13:09 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811e1x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:13:09 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7H99pD011330;
        Tue, 7 Dec 2021 17:13:08 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyyax90s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:13:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7HD6eP32440982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 17:13:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9149F7806E;
        Tue,  7 Dec 2021 17:13:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7818A78060;
        Tue,  7 Dec 2021 17:13:03 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 17:13:03 +0000 (GMT)
Message-ID: <27f3aecc693bc4a423423416bbc5bf7213b59959.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Tue, 07 Dec 2021 12:13:02 -0500
In-Reply-To: <20211207145901.awiibdgdidbshsbf@wittgenstein>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
         <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
         <20211207145901.awiibdgdidbshsbf@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SGcFvSdjLIKrAOd2vS-tHvxhohNq4w10
X-Proofpoint-GUID: _MOLj7BetLe62jUJkHZOtVOg-yZ697jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112070106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-07 at 15:59 +0100, Christian Brauner wrote:
[...]
> I would propose not to use the notifier logic. While it might be
> nifty it's over-engineered in my opinion. The dentry stashing in
> struct user_namespace currently serves the purpose to make it
> retrievable in ima_fs_ns_init(). That doesn't justify its existence
> imho.

This is the incremental to Stefan's set with the notifier removed and
the root dentry threaded.

James

---

From d9322270157531f4772fe862fa1655993a0c387d Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 6 Dec 2021 20:27:00 +0000
Subject: [PATCH] Incremental for root dentry

---
 include/linux/ima.h             |  2 +
 include/linux/security.h        |  8 ----
 include/linux/user_namespace.h  |  4 --
 security/inode.c                | 71 ++++++++++-----------------------
 security/integrity/ima/ima_fs.c | 40 ++++---------------
 5 files changed, 29 insertions(+), 96 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index cab5fc6caeb3..a6e93bb5ce8a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -40,6 +40,8 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+extern int ima_fs_ns_init(struct user_namespace *ns, struct dentry *root);
+extern void ima_fs_ns_free_dentries(struct user_namespace *ns);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
diff --git a/include/linux/security.h b/include/linux/security.h
index a34109c5e3ed..bbf44a466832 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1929,14 +1929,6 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
 
-enum {
-	SECURITYFS_NS_ADD,
-	SECURITYFS_NS_REMOVE,
-};
-
-extern int securityfs_register_ns_notifier(struct notifier_block *nb);
-extern int securityfs_unregister_ns_notifier(struct notifier_block *nb);
-
 #else /* CONFIG_SECURITYFS */
 
 static inline struct dentry *securityfs_create_dir(const char *name,
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6b8bd060d8c4..5249db04d62b 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -103,10 +103,6 @@ struct user_namespace {
 #ifdef CONFIG_IMA
 	struct ima_namespace	*ima_ns;
 #endif
-#ifdef CONFIG_SECURITYFS
-	struct vfsmount		*securityfs_mount;
-	bool			securityfs_notifier_sent;
-#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/security/inode.c b/security/inode.c
index 45211845fc31..0b173792fbd3 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -16,18 +16,17 @@
 #include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/ima.h>
 #include <linux/init.h>
 #include <linux/namei.h>
-#include <linux/notifier.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 #include <linux/user_namespace.h>
 
+static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
 
-static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
-
 static void securityfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -40,36 +39,11 @@ static const struct super_operations securityfs_super_operations = {
 	.free_inode	= securityfs_free_inode,
 };
 
-static struct file_system_type fs_type;
-
-static void securityfs_free_context(struct fs_context *fc)
-{
-	struct user_namespace *ns = fc->user_ns;
-
-	if (ns == &init_user_ns ||
-	    ns->securityfs_notifier_sent)
-		return;
-
-	ns->securityfs_notifier_sent = true;
-
-	ns->securityfs_mount = vfs_kern_mount(&fs_type, SB_KERNMOUNT,
-					      fs_type.name, NULL);
-	if (IS_ERR(ns->securityfs_mount)) {
-		printk(KERN_ERR "kern mount on securityfs ERROR: %ld\n",
-		       PTR_ERR(ns->securityfs_mount));
-		ns->securityfs_mount = NULL;
-		return;
-	}
-
-	blocking_notifier_call_chain(&securityfs_ns_notifier,
-				     SECURITYFS_NS_ADD, fc->user_ns);
-	mntput(ns->securityfs_mount);
-}
-
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
 	int error;
+	struct user_namespace *ns = fc->user_ns;
 
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
 	if (error)
@@ -77,6 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_op = &securityfs_super_operations;
 
+	if (ns != &init_user_ns) {
+		ima_fs_ns_init(ns, sb->s_root);
+	}
+
 	return 0;
 }
 
@@ -87,7 +65,6 @@ static int securityfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations securityfs_context_ops = {
 	.get_tree	= securityfs_get_tree,
-	.free		= securityfs_free_context,
 };
 
 static int securityfs_init_fs_context(struct fs_context *fc)
@@ -100,12 +77,10 @@ static void securityfs_kill_super(struct super_block *sb)
 {
 	struct user_namespace *ns = sb->s_fs_info;
 
-	if (ns != &init_user_ns)
-		blocking_notifier_call_chain(&securityfs_ns_notifier,
-					     SECURITYFS_NS_REMOVE,
-					     sb->s_fs_info);
-	ns->securityfs_notifier_sent = false;
-	ns->securityfs_mount = NULL;
+	if (ns != &init_user_ns) {
+		ima_fs_ns_free_dentries(ns);
+	}
+
 	kill_litter_super(sb);
 }
 
@@ -117,16 +92,6 @@ static struct file_system_type fs_type = {
 	.fs_flags =	FS_USERNS_MOUNT,
 };
 
-int securityfs_register_ns_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&securityfs_ns_notifier, nb);
-}
-
-int securityfs_unregister_ns_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&securityfs_ns_notifier, nb);
-}
-
 /**
  * securityfs_create_dentry - create a dentry in the securityfs filesystem
  *
@@ -174,14 +139,18 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	pr_debug("securityfs: creating file '%s'\n",name);
 
 	if (ns == &init_user_ns) {
-		error = simple_pin_fs(&fs_type, &ns->securityfs_mount,
+		error = simple_pin_fs(&fs_type, &securityfs_mount,
 				      &securityfs_mount_count);
 		if (error)
 			return ERR_PTR(error);
 	}
 
-	if (!parent)
-		parent = ns->securityfs_mount->mnt_root;
+	if (!parent) {
+		if (ns == &init_user_ns)
+			parent = securityfs_mount->mnt_root;
+		else
+			return ERR_PTR(-EINVAL);
+	}
 
 	dir = d_inode(parent);
 
@@ -227,7 +196,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 out:
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 	return dentry;
 }
@@ -371,7 +340,7 @@ void securityfs_remove(struct dentry *dentry)
 	}
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c17a6b7eeb95..fb29cb7b0384 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -446,9 +446,10 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
+void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
 {
 	int i;
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
 		securityfs_remove(ns->dentry[i]);
@@ -456,7 +457,7 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 	memset(ns->dentry, 0, sizeof(ns->dentry));
 }
 
-static int ima_fs_ns_init(struct user_namespace *user_ns)
+int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = user_ns->ima_ns;
 	struct dentry *ima_dir;
@@ -468,7 +469,7 @@ static int ima_fs_ns_init(struct user_namespace *user_ns)
 	/* FIXME: update when evm and integrity are namespaced */
 	if (user_ns != &init_user_ns)
 		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
-			securityfs_create_dir("integrity", NULL);
+			securityfs_create_dir("integrity", root);
 	else
 		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = integrity_dir;
 
@@ -480,7 +481,7 @@ static int ima_fs_ns_init(struct user_namespace *user_ns)
 	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
 
 	ns->dentry[IMAFS_DENTRY_SYMLINK] =
-	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
+	    securityfs_create_symlink("ima", root, "integrity/ima", NULL);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
 		goto out;
 
@@ -520,38 +521,11 @@ static int ima_fs_ns_init(struct user_namespace *user_ns)
 
 	return 0;
 out:
-	ima_fs_ns_free_dentries(ns);
+	ima_fs_ns_free_dentries(user_ns);
 	return -1;
 }
 
-static int ima_ns_notify(struct notifier_block *this, unsigned long msg,
-			    void *data)
-{
-	int rc = 0;
-	struct user_namespace *user_ns = data;
-
-	switch (msg) {
-	case SECURITYFS_NS_ADD:
-		rc = ima_fs_ns_init(user_ns);
-		break;
-	case SECURITYFS_NS_REMOVE:
-		ima_fs_ns_free_dentries(user_ns->ima_ns);
-		break;
-	}
-	return rc;
-}
-
-static struct notifier_block ima_ns_notifier = {
-	.notifier_call = ima_ns_notify,
-};
-
 int ima_fs_init()
 {
-	int rc;
-
-	rc = securityfs_register_ns_notifier(&ima_ns_notifier);
-	if (rc)
-		return rc;
-
-	return ima_fs_ns_init(&init_user_ns);
+	return ima_fs_ns_init(&init_user_ns, NULL);
 }
-- 
2.33.0


