Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A346A094
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358181AbhLFQGG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 11:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376994AbhLFQEA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 11:04:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8FC09B138;
        Mon,  6 Dec 2021 07:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102E7601B6;
        Mon,  6 Dec 2021 15:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AE9C34912;
        Mon,  6 Dec 2021 15:44:33 +0000 (UTC)
Date:   Mon, 6 Dec 2021 16:44:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <jejb@linux.ibm.com>
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
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206154430.jet2xysbtvtrjqgr@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
 <20211206120847.ayr3zycigld6rf4j@wittgenstein>
 <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 06, 2021 at 08:38:29AM -0500, James Bottomley wrote:
> On Mon, 2021-12-06 at 13:08 +0100, Christian Brauner wrote:
> > On Fri, Dec 03, 2021 at 11:37:14AM -0800, Casey Schaufler wrote:
> > > On 12/3/2021 10:50 AM, James Bottomley wrote:
> > > > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> > > > > On 12/3/21 12:03, James Bottomley wrote:
> > > > > > On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> > > > > > [...]
> > > > > > >    static int securityfs_init_fs_context(struct fs_context
> > > > > > > *fc)
> > > > > > >    {
> > > > > > > +	int rc;
> > > > > > > +
> > > > > > > +	if (fc->user_ns->ima_ns->late_fs_init) {
> > > > > > > +		rc = fc->user_ns->ima_ns->late_fs_init(fc-
> > > > > > > >user_ns);
> > > > > > > +		if (rc)
> > > > > > > +			return rc;
> > > > > > > +	}
> > > > > > >    	fc->ops = &securityfs_context_ops;
> > > > > > >    	return 0;
> > > > > > >    }
> > > > > > I know I suggested this, but to get this to work in general,
> > > > > > it's going to have to not be specific to IMA, so it's going
> > > > > > to have to become something generic like a notifier
> > > > > > chain.  The other problem is it's only working still by
> > > > > > accident:
> > > > >  
> > > > > I had thought about this also but the rationale was:
> > > > > 
> > > > > securityfs is compiled due to CONFIG_IMA_NS and the user
> > > > > namespace exists there and that has a pointer now to
> > > > > ima_namespace, which can have that callback. I assumed that
> > > > > other namespaced subsystems could also be  reached then via
> > > > > such a callback, but I don't know.
> > > >  
> > > > Well securityfs is supposed to exist for LSMs.  At some point
> > > > each of those is going to need to be namespaced, which may
> > > > eventually be quite a pile of callbacks, which is why I thought
> > > > of a notifier.
> > > 
> > > While AppArmor, lockdown and the integrity family use securityfs,
> > > SELinux and Smack do not. They have their own independent
> > > filesystems. Implementations of namespacing for each of SELinux and
> > > Smack have been proposed, but nothing has been adopted. It would be
> > > really handy to namespace the infrastructure rather than each
> > > individual LSM, but I fear that's a bigger project than anyone will
> > > be taking on any time soon. It's likely to encounter many of the
> > > same issues that I've been dealing with for module stacking.
> > 
> > The main thing that bothers me is that it uses simple_pin_fs() and
> > simple_unpin_fs() which I would try hard to get rid of if possible.
> > The existence of this global pinning logic makes namespacing it
> > properly more difficult then it needs to be and it creates imho wonky
> > semantics where the last unmount doesn't really destroy the
> > superblock.
> 
> So in the notifier sketch I posted, I got rid of the pinning but only
> for the non root user namespace use case ... which basically means only
> for converted consumers of securityfs.  The last unmount of securityfs
> inside the namespace now does destroy the superblock ... I checked.
> 
> The same isn't true for the last unmount of the root namespace, but
> that has to be so to keep the current semantics.
> 
> >  Instead subsequents mounts resurface the same superblock. There
> > might be an inherent design reason why this needs to be this way but
> > I would advise against these semantics for anything that wants to be
> > namespaced. Probably the first securityfs mount in init_user_ns can
> > follow these semantics but ones tied to a non-initial user namespace
> > should not as the userns can go away. In that case the pinning logic
> > seems strange as conceptually the userns pins the securityfs mount as
> > evidenced by the fact that we key by it in get_tree_keyed().
> 
> Yes, that's basically what I did: pin if ns == &init_user_ns but don't
> pin if not.  However, I'm still not sure I got the triggers right.  We
> have to trigger the notifier call (which adds the namespaced file
> entries) from context free, because that's the first place the
> superblock mount is fully set up ... I can't do it in fill_super
> because the mount isn't fully initialized (and the locking prevents
> it).  I did manage to get the notifier for teardown triggered from
> kill_super, though.

I don't think you need a vfsmount at all to be honest. I think this can
all be done without much ceremony. Here's a brutalist completely
untested patch outlining one approach:

From 4fc2d88d4194e3473fd545864a8bb0759036ed5e Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 6 Dec 2021 14:08:28 +0100
Subject: [PATCH] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!

---
 include/linux/securityfs.h      |  20 +++++
 include/linux/user_namespace.h  |   1 +
 kernel/user_namespace.c         |   3 +
 security/inode.c                | 129 ++++++++++++++++++++++++++++++--
 security/integrity/ima/ima.h    |   1 +
 security/integrity/ima/ima_fs.c |  20 ++++-
 6 files changed, 165 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/securityfs.h

diff --git a/include/linux/securityfs.h b/include/linux/securityfs.h
new file mode 100644
index 000000000000..2e973be160b1
--- /dev/null
+++ b/include/linux/securityfs.h
@@ -0,0 +1,20 @@
+#ifndef __LINUX_SECURITYFS_H
+#define __LINUX_SECURITYFS_H
+
+struct vfsmount;
+
+#ifdef CONFIG_SECURITYFS
+
+/*
+ * Allocated once per user_ns the first time securityfs is mounted.  Can be
+ * used to stash securityfs relevant state that absolutely needs to survive
+ * super_block destruction on last umount.
+ */
+struct securityfs_info {
+	// pointer to relevant ima stuff or instance?
+	// pointer to relevant apparmor stuff or instance?
+	// pointer to relevant selinux stuff or instance?
+};
+#endif /* CONFIG_SECURITYFS */
+
+#endif /* ! __LINUX_SECURITYFS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6b8bd060d8c4..42676f5bcd43 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -103,6 +103,7 @@ struct user_namespace {
 #ifdef CONFIG_IMA
 	struct ima_namespace	*ima_ns;
 #endif
+	struct securityfs_info *securityfs_info;
 #ifdef CONFIG_SECURITYFS
 	struct vfsmount		*securityfs_mount;
 	bool			securityfs_notifier_sent;
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index c26885343b19..d65b20d8a90b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -211,6 +211,9 @@ static void free_user_ns(struct work_struct *work)
 		}
 #ifdef CONFIG_IMA
 		put_ima_ns(ns->ima_ns);
+#endif
+#ifdef CONFIG_SECURITYFS
+		kfree(ns->securityfs_info);
 #endif
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
diff --git a/security/inode.c b/security/inode.c
index 62ab4630dc31..1c3b2797367d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -66,18 +66,57 @@ static void securityfs_free_context(struct fs_context *fc)
 	mntput(ns->securityfs_mount);
 }
 
+
+/* 
+ * This is really just a helper we would need in case we wanted to retrieve
+ * securityfs_info independent of the super_block. If that's not needed, then
+ * you can as well remove the smp_load_acquire() and the associated
+ * smp_store_release().
+ */
+struct securitfs_info *to_securityfs_info(struct user_namespace *user_ns)
+{
+
+	return smp_load_acquire(&user_ns->securityfs_info);
+}
+
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	int err;
 	static const struct tree_descr files[] = {{""}};
-	int error;
-
-	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
-	if (error)
-		return error;
+	struct user_namespace *user_ns = sb->s_user_ns;
+	struct securityfs_info *securityfs_info;
+
+	/*
+	 * Allocate a new securityfs_info instance for this userns.
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for user_ns. Hence, the vfs guarantees that
+	 * securityfs_fill_super() is called exactly once whenever a
+	 * securityfs superblock for a userns is created. This in turn lets us
+	 * conclude that when a securityfs superblock is created for the first
+	 * time for a userns there's no one racing us. Therefore we don't need
+	 * any barriers when we dereference securityfs_info.
+	 */
+	securityfs_info = user_ns->securityfs_info;
+	if (!securityfs_info) {
+		securityfs_info = kzalloc(sizeof(struct securityfs_info), GFP_KERNEL);
+		if (!securityfs_info)
+			return -ENOMEM;
+
+		// TODO: Initialize securityfs_info
+
+		/* 
+		 * Pairs with smp_load_acquire() in to_securityfs_info().
+		 *
+		 * Please see the commment there.
+		 */
+		smp_store_release(&user_ns->securityfs_info, securityfs_info);
+	}
 
-	sb->s_op = &securityfs_super_operations;
+	err = simple_fill_super(sb, SECURITYFS_MAGIC, files);
+	if (!err)
+		sb->s_op = &securityfs_super_operations;
 
-	return 0;
+	return ima_fs_ns_late_init(sb);
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
@@ -237,6 +276,82 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	return dentry;
 }
 
+struct dentry *securityfs_create_dentry_ns(struct super_block *sb,
+					   const char *name, umode_t mode,
+					   struct dentry *parent, void *data,
+					   const struct file_operations *fops,
+					   const struct inode_operations *iops)
+{
+	struct dentry *dentry;
+	struct inode *dir, *inode;
+	int error;
+	struct user_namespace *ns = sb->s_user_ns;
+
+	if (!(mode & S_IFMT))
+		mode = (mode & S_IALLUGO) | S_IFREG;
+
+	pr_debug("securityfs: creating file '%s', ns=%u\n",name, ns->ns.inum);
+
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &ns->securityfs_mount,
+				      &securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
+
+	/* You really just require to always pass the parent? */
+	if (!parent)
+		parent = sb->s_root;
+
+	dir = d_inode(parent);
+
+	inode_lock(dir);
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		goto out;
+
+	if (d_really_is_positive(dentry)) {
+		error = -EEXIST;
+		goto out1;
+	}
+
+	inode = new_inode(dir->i_sb);
+	if (!inode) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_private = data;
+	if (S_ISDIR(mode)) {
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		inc_nlink(inode);
+		inc_nlink(dir);
+	} else if (S_ISLNK(mode)) {
+		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
+		inode->i_link = data;
+	} else {
+		inode->i_fop = fops;
+	}
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	inode_unlock(dir);
+	return dentry;
+
+out1:
+	dput(dentry);
+	dentry = ERR_PTR(error);
+out:
+	inode_unlock(dir);
+	if (ns == &init_user_ns)
+		simple_release_fs(&ns->securityfs_mount,
+				  &securityfs_mount_count);
+	return dentry;
+}
+
 /**
  * securityfs_create_file - create a file in the securityfs filesystem
  *
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 12b7df65a5ff..806f19215052 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -140,6 +140,7 @@ struct ns_status {
 int ima_init(void);
 int ima_fs_init(void);
 void ima_fs_ns_free(void);
+int ima_fs_ns_late_init(struct super_block *sb);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 26f26e8756a8..4b25912db448 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -500,11 +500,27 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 /* Function to populeate namespace SecurityFS once user namespace
  * has been configured.
  */
-static int ima_fs_ns_late_init(struct user_namespace *user_ns)
+int ima_fs_ns_late_init(struct super_block *sb)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
+	/*
+	 * We know that s_user_ns === ima_ns->user_ns.
+	 *
+	 * In other words, here we can go from superblock to relevant
+	 * namespaces never from namespace to superblock. Ideally we try to
+	 * avoid going from namespace to superblock.
+	 */
+	struct ima_namespace *ns = sb->s_user_ns->ima_ns;
 	struct dentry *parent;
 
+
+	// TODO:
+	//
+	// Port this to use new helpers that take a super_block as argument.
+	//
+	// This allows us to get rid of any vfsmount dependencies.
+	//
+	// Probably should also be renamed to something better.
+
 	/* already initialized? */
 	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
 		return 0;
-- 
2.30.2

