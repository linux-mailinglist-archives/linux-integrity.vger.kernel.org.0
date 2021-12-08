Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8490946D436
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 14:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhLHNUo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 08:20:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57762 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhLHNUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 08:20:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D5EFCE2188;
        Wed,  8 Dec 2021 13:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BF4C00446;
        Wed,  8 Dec 2021 13:17:00 +0000 (UTC)
Date:   Wed, 8 Dec 2021 14:16:56 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Message-ID: <20211208131656.ozsbbotttvz3bct7@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
 <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 01:58:14PM +0100, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
> > Setup securityfs with symlinks, directories, and files for IMA
> > namespacing support. The same directory structure that IMA uses on the
> > host is also created for the namespacing case.
> > 
> > The securityfs file and directory ownerships cannot be set when the
> > IMA namespace is initialized. Therefore, delay the setup of the file
> > system to a later point when securityfs is in securityfs_fill_super.
> > 
> > This filesystem can now be mounted as follows:
> > 
> > mount -t securityfs /sys/kernel/security/ /sys/kernel/security/
> > 
> > The following directories, symlinks, and files are then available.
> > 
> > $ ls -l sys/kernel/security/
> > total 0
> > lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
> > drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity
> > 
> > $ ls -l sys/kernel/security/ima/
> > total 0
> > -r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
> > -r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
> > -rw-------. 1 root root 0 Dec  2 00:18 policy
> > -r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
> > -r--r-----. 1 root root 0 Dec  2 00:18 violations
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  include/linux/ima.h             | 17 ++++++++++++++++-
> >  security/inode.c                | 12 +++++++++++-
> >  security/integrity/ima/ima_fs.c | 33 ++++++++++++++++++++++++++-------
> >  3 files changed, 53 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index bfb978a7f8d5..a8017272d78d 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -66,6 +66,10 @@ static inline const char * const *arch_get_ima_policy(void)
> >  }
> >  #endif
> >  
> > +extern int ima_fs_ns_init(struct user_namespace *user_ns,
> > +			  struct dentry *root);
> > +extern void ima_fs_ns_free_dentries(struct user_namespace *user_ns);
> > +
> >  #else
> >  static inline enum hash_algo ima_get_current_hash_algo(void)
> >  {
> > @@ -154,6 +158,15 @@ static inline int ima_measure_critical_data(const char *event_label,
> >  	return -ENOENT;
> >  }
> >  
> > +static inline int ima_fs_ns_init(struct user_namespace *ns, struct dentry *root)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_IMA */
> >  
> >  #ifndef CONFIG_IMA_KEXEC
> > @@ -221,7 +234,8 @@ struct ima_h_table {
> >  };
> >  
> >  enum {
> > -	IMAFS_DENTRY_DIR = 0,
> > +	IMAFS_DENTRY_INTEGRITY_DIR = 0,
> > +	IMAFS_DENTRY_DIR,
> >  	IMAFS_DENTRY_SYMLINK,
> >  	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
> >  	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
> > @@ -333,6 +347,7 @@ static inline struct ima_namespace *get_current_ns(void)
> >  {
> >  	return &init_ima_ns;
> >  }
> > +
> >  #endif /* CONFIG_IMA_NS */
> >  
> >  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> > diff --git a/security/inode.c b/security/inode.c
> > index 121ac1874dde..10ee20917f42 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/fs_context.h>
> >  #include <linux/mount.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/ima.h>
> >  #include <linux/init.h>
> >  #include <linux/namei.h>
> >  #include <linux/security.h>
> > @@ -41,6 +42,7 @@ static const struct super_operations securityfs_super_operations = {
> >  static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	static const struct tree_descr files[] = {{""}};
> > +	struct user_namespace *ns = fc->user_ns;
> >  	int error;
> >  
> >  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> > @@ -49,7 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  
> >  	sb->s_op = &securityfs_super_operations;
> >  
> > -	return 0;
> > +	if (ns != &init_user_ns)
> > +		error = ima_fs_ns_init(ns, sb->s_root);
> > +
> > +	return error;
> >  }
> >  
> >  static int securityfs_get_tree(struct fs_context *fc)
> > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct fs_context *fc)
> >  
> >  static void securityfs_kill_super(struct super_block *sb)
> >  {
> > +	struct user_namespace *ns = sb->s_fs_info;
> > +
> > +	if (ns != &init_user_ns)
> > +		ima_fs_ns_free_dentries(ns);
> 
> Say securityfs is unmounted. Then all the inodes and dentries become
> invalid. It's not allowed to hold on to any dentries or inodes after the
> super_block is shut down. So I just want to be sure that nothing in ima
> can access these dentries after securityfs is unmounted.
> 
> To put it another way: why are they stored in struct ima_namespace in
> the first place? If you don't pin a filesystem when creating files or
> directories like you do for securityfs in init_ima_ns then you don't
> need to hold on to them as they will be automatically be wiped during
> umount.

The way I see it you need to do the following:
If securityfs is mounted in a userns and fill_super is called you need
to call

int ima_fs_ns_init(struct user_namespace *user_ns,

(which you really should call ima_securitfs_init()...)

and when you create those entries for non-init-securityfs you just need
sm like:

	struct dentry *dentry;

	/* XXXX useless comment XXXX:
	 * The lookup_one_len() function will always return with an
	 * increased refcount on the dentry that you need to release.
	 */
	dentry = lookup_one_len(name, parent, strlen(name));
	if (IS_ERR(dentry))
		return dentry;

	/* Return error if the file/dir already exists. */
	if (d_really_is_positive(dentry)) {

		/* 
		 * XXXX useless comment XXXX:
		 * Put the reference from lookup_one_len()
		 */
		dput(dentry);
		return ERR_PTR(-EEXIST);
	}

	inode = new_inode(dir->i_sb);
	if (!inode) {
		error = -ENOMEM;
		goto out1;
	}

	// DO A LOT OF OTHER STUFF

	d_instantiate(dentry, new_inode);

	// DON'T CALL dget() again

The point is to not increase the refcount again like
securityfs_create_dentry() does after d_instantiate which requires you
to call securityfs_remove(). That's unnecessary for the
non-init_user_ns-securityfs case and then you don't need all that
cleanup stuff in kill_super() and can just rely on d_genocide() and the
dcache shrinker to do all the required work.

Don't hold on to objects that can go away beneath you in any structs.
Stashing them in ima_namespace will just make people think that these
things can be accessed without any lifetime concerns which is imho an
invitation to disaster in the long run.
