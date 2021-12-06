Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF04B46A148
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbhLFQ27 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 11:28:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239044AbhLFQ26 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 11:28:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GHnv9005940;
        Mon, 6 Dec 2021 16:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=DLKyHiV+KNG9V2QveWolt+N9E6nDAcq+PbrP/y1TqsY=;
 b=YymX0+0rEP1n7w1PmZWE90N5IG3H+mOSOtj5oe5de85hORa/vB8SfBrp6XhK/OjSHAlE
 CTiOPDobPlsQ0Xui9NWLRLeaZOFJBbriY35XIdY/056iyVuNsrQyCbdB12e64PdudvDg
 qbVnBkifO2RO2vQ91OriXN9ZcaHsWi12H8Pl6ko0lwmiGSnLQ4aMGfRyZGpGYAtiGMLR
 zZqQeFHaYvv7HjsSwFNPTjIyN5Sl0FGVwTx+8XFyMrrVg0wji1/5ksULPuDXDvLt+UiO
 P5RlPZsL09SGR5I0xQ96xtM83fBQoNhnyFUOuTrpbOcBjOcAifVHO3wdbAEvi3pxlHY5 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csnwqr42w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:25:14 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6GJXwg013265;
        Mon, 6 Dec 2021 16:25:14 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csnwqr42f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:25:14 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GIGCP006172;
        Mon, 6 Dec 2021 16:25:13 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy719m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:25:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6GPCiw32244074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 16:25:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F403778083;
        Mon,  6 Dec 2021 16:25:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98995780B2;
        Mon,  6 Dec 2021 16:25:09 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 16:25:09 +0000 (GMT)
Message-ID: <7cc68f5519a218da54560bffe76d2d88c3573def.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Mon, 06 Dec 2021 11:25:08 -0500
In-Reply-To: <20211206154430.jet2xysbtvtrjqgr@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
         <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
         <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
         <20211206120847.ayr3zycigld6rf4j@wittgenstein>
         <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
         <20211206154430.jet2xysbtvtrjqgr@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HrpS5lOeN59Am9S21NtG9U122lTUPG7F
X-Proofpoint-ORIG-GUID: zD3zOk7j41n_2U7oUE8RAtRz-pGEdGSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 16:44 +0100, Christian Brauner wrote:
> On Mon, Dec 06, 2021 at 08:38:29AM -0500, James Bottomley wrote:
> > On Mon, 2021-12-06 at 13:08 +0100, Christian Brauner wrote:
[...]
> > >  Instead subsequents mounts resurface the same superblock. There
> > > might be an inherent design reason why this needs to be this way
> > > but I would advise against these semantics for anything that
> > > wants to be namespaced. Probably the first securityfs mount in
> > > init_user_ns can follow these semantics but ones tied to a non-
> > > initial user namespace should not as the userns can go away. In
> > > that case the pinning logic seems strange as conceptually the
> > > userns pins the securityfs mount as evidenced by the fact that we
> > > key by it in get_tree_keyed().
> > 
> > Yes, that's basically what I did: pin if ns == &init_user_ns but
> > don't pin if not.  However, I'm still not sure I got the triggers
> > right.  We have to trigger the notifier call (which adds the
> > namespaced file entries) from context free, because that's the
> > first place the superblock mount is fully set up ... I can't do it
> > in fill_super because the mount isn't fully initialized (and the
> > locking prevents it).  I did manage to get the notifier for
> > teardown triggered from kill_super, though.
> 
> I don't think you need a vfsmount at all to be honest. I think this
> can all be done without much ceremony. Here's a brutalist completely
> untested patch outlining one approach:

This is what I did (incremental to Stefan's series + my previous
patch): it avoids superblock threading by switching to a root dentry in
the securityfs user namespace area ... or am I being too simple again
... ?

I'm still a bit unhappy about triggering a blocking notifier under the
umount semaphore ...

James

---
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
index 62ab4630dc31..863fccfd3687 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -25,6 +25,7 @@
 #include <linux/user_namespace.h>
 #include <linux/ima.h>
 
+static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
 
 static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
@@ -41,42 +42,22 @@ static const struct super_operations securityfs_super_operations = {
 	.free_inode	= securityfs_free_inode,
 };
 
-static struct file_system_type fs_type;
-
-static void securityfs_free_context(struct fs_context *fc)
-{
-	struct user_namespace *ns = fc->user_ns;
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
 
+	ns->securityfs_root = sb->s_root;
+
 	sb->s_op = &securityfs_super_operations;
 
+	blocking_notifier_call_chain(&securityfs_ns_notifier,
+				     SECURITYFS_NS_ADD, ns);
 	return 0;
 }
 
@@ -87,7 +68,6 @@ static int securityfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations securityfs_context_ops = {
 	.get_tree	= securityfs_get_tree,
-	.free		= securityfs_free_context,
 };
 
 static int securityfs_init_fs_context(struct fs_context *fc)
@@ -104,8 +84,7 @@ static void securityfs_kill_super(struct super_block *sb)
 		blocking_notifier_call_chain(&securityfs_ns_notifier,
 					     SECURITYFS_NS_REMOVE,
 					     sb->s_fs_info);
-	ns->securityfs_notifier_sent = false;
-	ns->securityfs_mount = NULL;
+	ns->securityfs_root = NULL;
 	kill_litter_super(sb);
 }
 
@@ -179,14 +158,18 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	pr_debug("securityfs: creating file '%s', ns=%u\n",name, ns->ns.inum);
 
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
 
@@ -232,7 +215,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 out:
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 	return dentry;
 }
@@ -376,7 +359,7 @@ void securityfs_remove(struct dentry *dentry)
 	}
 	inode_unlock(dir);
 	if (ns == &init_user_ns)
-		simple_release_fs(&ns->securityfs_mount,
+		simple_release_fs(&securityfs_mount,
 				  &securityfs_mount_count);
 }
 EXPORT_SYMBOL(securityfs_remove);
@@ -405,8 +388,6 @@ static int __init securityfs_init(void)
 	if (retval)
 		return retval;
 
-	init_user_ns.securityfs_mount = NULL;
-
 	retval = register_filesystem(&fs_type);
 	if (retval) {
 		sysfs_remove_mount_point(kernel_kobj, "security");

