Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FC46A99C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 22:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350725AbhLFVSk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 16:18:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350866AbhLFVSO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 16:18:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6KpEPh031874;
        Mon, 6 Dec 2021 21:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=ShB4uba5GUGqtY+f8M5TLlSaUG5gbp9vI+lNh9lyRLc=;
 b=NC1NtVj+3gHx+N0s4+zflOvoHTe33eb2Mhijok8HmXNyBecE7iSxsX2JmygdKunhOr6g
 8B4CkB2qXk/a/bR207GWZDZ8iWAO3BVJMfMLEfBFxlND77y5ZZI5SJX6kQyGhJciAdTg
 n1O1n32zldXGn7V+422YDp6iAOV1yt25Vd6S9ySX423tjdpxNFn4N1rpDhIEPlFn+Iy3
 bNH+Dn9gpLPyULV9PcijOJxJMolbsnclIKrrAASBh2NnsiiWKQM1PcnkkjsSxxDkV19t
 6PSvIYFVk4SUDIlygMUbIszHZvxACO++Aq+uGajbW8h+RTry9SVu5Z9CfwvbSqZRUk/0 yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csswy8d56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 21:14:23 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6KpTMN032458;
        Mon, 6 Dec 2021 21:14:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csswy8d52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 21:14:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6LDiYK015162;
        Mon, 6 Dec 2021 21:14:21 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyya7mnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 21:14:21 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6LEKgA53084512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 21:14:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 815567806E;
        Mon,  6 Dec 2021 21:14:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFF0C7805E;
        Mon,  6 Dec 2021 21:14:16 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 21:14:16 +0000 (GMT)
Message-ID: <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Mon, 06 Dec 2021 16:14:15 -0500
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5DiuQODpqbkjb6W1U0bDD77_9ZmriIw8
X-Proofpoint-GUID: 9ClYdqg6AUGKpHh4k17z3C3sxFygYh-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 12:25 -0500, Stefan Berger wrote:
[...]
> v3:
>  - Further modifications to virtualized SecurityFS following James's
> posted patch
>  - Dropping of early teardown for user_namespaces since not needed
> anymore

This is my incremental to this series that moves the namespaced
securityfs away from using a vfsmount and on to a root dentry instead,
meaning we can call the blocking notifier from fill_super as Christian
requested (and thus can remove the securityfs_notifier_sent indicator
since it's only called once).

James

---

From 07b680d5fd59f5d3cea5580be25a2c9e08a01c3b Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 6 Dec 2021 20:27:00 +0000
Subject: [PATCH] Incremental for d_root

---
 include/linux/user_namespace.h |  3 +-
 security/inode.c               | 55 +++++++++++++---------------------
 2 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6b8bd060d8c4..03a0879376a0 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -104,8 +104,7 @@ struct user_namespace {
 	struct ima_namespace	*ima_ns;
 #endif
 #ifdef CONFIG_SECURITYFS
-	struct vfsmount		*securityfs_mount;
-	bool			securityfs_notifier_sent;
+	struct dentry		*securityfs_root;
 #endif
 } __randomize_layout;
 
diff --git a/security/inode.c b/security/inode.c
index 45211845fc31..f8b6cb3dfb87 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -24,6 +24,7 @@
 #include <linux/magic.h>
 #include <linux/user_namespace.h>
 
+static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
 
 static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
@@ -40,43 +41,24 @@ static const struct super_operations securityfs_super_operations = {
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
 		return error;
 
+	ns->securityfs_root = dget(sb->s_root);
+
 	sb->s_op = &securityfs_super_operations;
 
+	if (ns != &init_user_ns)
+		blocking_notifier_call_chain(&securityfs_ns_notifier,
+					     SECURITYFS_NS_ADD, ns);
+
 	return 0;
 }
 
@@ -87,7 +69,6 @@ static int securityfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations securityfs_context_ops = {
 	.get_tree	= securityfs_get_tree,
-	.free		= securityfs_free_context,
 };
 
 static int securityfs_init_fs_context(struct fs_context *fc)
@@ -104,8 +85,10 @@ static void securityfs_kill_super(struct super_block *sb)
 		blocking_notifier_call_chain(&securityfs_ns_notifier,
 					     SECURITYFS_NS_REMOVE,
 					     sb->s_fs_info);
-	ns->securityfs_notifier_sent = false;
-	ns->securityfs_mount = NULL;
+
+	dput(ns->securityfs_root);
+	ns->securityfs_root = NULL;
+
 	kill_litter_super(sb);
 }
 
@@ -174,14 +157,18 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
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
+			parent = ns->securityfs_root;
+	}
 
 	dir = d_inode(parent);
 
@@ -227,7 +214,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 out:
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 	return dentry;
 }
@@ -371,7 +358,7 @@ void securityfs_remove(struct dentry *dentry)
 	}
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
-- 
2.33.0


