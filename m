Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D995470052
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 12:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbhLJLxV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 06:53:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhLJLxV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 06:53:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9282EB8275F;
        Fri, 10 Dec 2021 11:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A4DC00446;
        Fri, 10 Dec 2021 11:49:38 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:49:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Message-ID: <20211210114934.tacjnwryihrsx6ln@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
 <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 09, 2021 at 02:38:13PM -0500, James Bottomley wrote:
> On Thu, 2021-12-09 at 10:30 -0500, James Bottomley wrote:
> > On Thu, 2021-12-09 at 15:37 +0100, Christian Brauner wrote:
> > > On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
> > > > On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
> > > > > Move the dentries into the ima_namespace for reuse by
> > > > > virtualized
> > > > > SecurityFS. Implement function freeing the dentries in order of
> > > > > files and symlinks before directories.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > ---
> > > > 
> > > > This doesn't work as implemented, I think.
> > > > 
> > > > What I would have preferred and what I tried to explain in the
> > > > earlier review was:
> > > > Keep the dentry stashing global since it is only needed for
> > > > init_ima_ns.
> > > > Then struct ima_namespace becomes way smaller and simpler.
> > > > If you do that then it makes sense to remove the additional
> > > > dget() in securityfs_create_dentry() for non-init_ima_ns.
> > > > Then you can rely on auto-cleanup in .kill_sb() or on
> > > > ima_securityfs_init() failure and you only need to call
> > > > ima_fs_ns_free_dentries() if ns != init_ima_ns.
> > > > 
> > > > IIuc, it seems you're currently doing one dput() too many since
> > > > you're calling securityfs_remove() in the error path for non-
> > > > init_ima_ns which relies on the previous increased dget() which
> > > > we removed.
> > > 
> > > If you really want to move the dentry stashing into struct
> > > ima_namespace even though it's really unnecessary then you may as
> > > well not care about the auto-cleanup and keep that additional
> > > ima_fs_ns_free_dentries(ns) call in .kill_sb(). But I really think
> > > not dragging dentry stashing into struct ima_namespace is the
> > > correct way to go about this.
> > 
> > We, unfortunately, do have one case we can't avoid stashing for the
> > policy file.  It's this code in ima_release_policy:
> > 
> > > #if !defined(CONFIG_IMA_WRITE_POLICY) &&
> > > !defined(CONFIG_IMA_READ_POLICY)
> > > 	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
> > > 	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
> > > 
> > 
> > What it does is that in certain config options, the policy file entry
> > gets removed from the securityfs ima directory after you write to it.
> 
> This is what I have incremental to v5 that corrects all of this.  It
> actually keeps every dentry reference (including init_user_ns ones) at
> 1 so they can be reaped on unmount.  For the remove case it does
> d_delete and then puts the only reference.  This means
> securityfs_remove() works for the namespaced policy file as well.
> 
> I also got rid of the spurious initialized check in ima_securityfs_init
> because it prevents you doing a mount;umount;mount on securityfs within
> a namespace.
> 
> There's still the problem that if you write the policy, making the file
> disappear then unmount and remount securityfs it will come back.  My
> guess for fixing this is that we only stash the policy file reference,
> create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
> something and refuse to create it for that value.

Some sort of indicator that gets stashed in struct ima_ns that the file
does not get recreated on consecutive mounts. That shouldn't be hard to
fix.

> 
> James
> 
> ---
> 
> From 7de285a81ff06b6e0eb2c6db24810aeef9f6dd17 Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Thu, 9 Dec 2021 19:33:49 +0000
> Subject: [PATCH] fix dentry ref counting
> 
> ---
>  security/inode.c                | 12 ++----------
>  security/integrity/ima/ima_fs.c |  4 ----
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index eaccba7017d9..b53152f7a625 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -178,8 +178,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>  		inode->i_fop = fops;
>  	}
>  	d_instantiate(dentry, inode);
> -	if (ns == &init_user_ns)
> -		dget(dentry);
>  	inode_unlock(dir);
>  	return dentry;
>  
> @@ -317,21 +315,15 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
>  void securityfs_remove(struct dentry *dentry)
>  {
>  	struct user_namespace *ns = dentry->d_sb->s_user_ns;
> -	struct inode *dir;
>  
>  	if (!dentry || IS_ERR(dentry))
>  		return;
>  
> -	dir = d_inode(dentry->d_parent);
> -	inode_lock(dir);
>  	if (simple_positive(dentry)) {
> -		if (d_is_dir(dentry))
> -			simple_rmdir(dir, dentry);
> -		else
> -			simple_unlink(dir, dentry);
> +		d_delete(dentry);

Not, that doesn't work. You can't just call d_delete() and dput() and
even if I wouldn't advise it. And you also can't do this without taking
the inode lock on the directory.
simple_rmdir()/simple_unlink() take care to update various inode fields
in the parent dir and handle link counts. This really wants to be sm
like

	struct inode *parent_inode;

	parent_inode = d_inode(dentry->d_parent);
	inode_lock(parent_inode);
	if (simple_positive(dentry)) {
		dget(dentry);
		if (d_is_dir(dentry)
			simple_unlink(parent_inode, dentry);
		else
			simple_unlink(parent_inode, dentry);
		d_delete(dentry);
		dput(dentry);
	}
	inode_unlock(parent_inode);

>  		dput(dentry);
>  	}
> -	inode_unlock(dir);
> +
>  	if (ns == &init_user_ns)
>  		simple_release_fs(&init_securityfs_mount,
>  				  &init_securityfs_mount_count);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 778983fd9a73..077a6ff46858 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -466,10 +466,6 @@ int ima_securityfs_init(struct user_namespace *user_ns, struct dentry *root)
>  	struct ima_namespace *ns = user_ns->ima_ns;
>  	struct dentry *ima_dir;
>  
> -	/* already initialized? */
> -	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
> -		return 0;
> -
>  	/* FIXME: update when evm and integrity are namespaced */
>  	if (user_ns != &init_user_ns) {
>  		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
> -- 
> 2.33.0
> 
> 
> 
