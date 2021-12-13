Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251AA472B4B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhLMLZg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 06:25:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59362 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhLMLZf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 06:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01B99CE100F;
        Mon, 13 Dec 2021 11:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0196CC34603;
        Mon, 13 Dec 2021 11:25:24 +0000 (UTC)
Date:   Mon, 13 Dec 2021 12:25:20 +0100
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
Message-ID: <20211213112520.q7oc5hnjqh7yzgdq@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
 <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
 <20211210114934.tacjnwryihrsx6ln@wittgenstein>
 <e72104c480c2c7f5c29f80b72d2a597a50ef9fae.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e72104c480c2c7f5c29f80b72d2a597a50ef9fae.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 12, 2021 at 09:13:12AM -0500, James Bottomley wrote:
> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> > On Thu, Dec 09, 2021 at 02:38:13PM -0500, James Bottomley wrote:
> [...]
> > > @@ -317,21 +315,15 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
> > >  void securityfs_remove(struct dentry *dentry)
> > >  {
> > >  	struct user_namespace *ns = dentry->d_sb->s_user_ns;
> > > -	struct inode *dir;
> > >  
> > >  	if (!dentry || IS_ERR(dentry))
> > >  		return;
> > >  
> > > -	dir = d_inode(dentry->d_parent);
> > > -	inode_lock(dir);
> > >  	if (simple_positive(dentry)) {
> > > -		if (d_is_dir(dentry))
> > > -			simple_rmdir(dir, dentry);
> > > -		else
> > > -			simple_unlink(dir, dentry);
> > > +		d_delete(dentry);
> > 
> > Not, that doesn't work. You can't just call d_delete() and dput() and
> > even if I wouldn't advise it. And you also can't do this without
> > taking the inode lock on the directory.
> 
> Agreed on that
> 
> > simple_rmdir()/simple_unlink() take care to update various inode
> > fields in the parent dir and handle link counts. This really wants to
> > be sm like
> > 
> > 	struct inode *parent_inode;
> > 
> > 	parent_inode = d_inode(dentry->d_parent);
> > 	inode_lock(parent_inode);
> > 	if (simple_positive(dentry)) {
> > 		dget(dentry);
> > 		if (d_is_dir(dentry)
> > 			simple_unlink(parent_inode, dentry);
> > 		else
> > 			simple_unlink(parent_inode, dentry);
> > 		d_delete(dentry);
> > 		dput(dentry);
> > 	}
> > 	inode_unlock(parent_inode);
> 
> It just slightly annoys me how the simple_ functions change fields in
> an inode that is about to be evicted ... it seems redundant; plus we
> shouldn't care if the object we're deleting is a directory or file.  I
> also don't think we need the additional dget because the only consumer
> is policy file removal and the opener of that file will have done a
> dget.  The inode lock now prevents us racing with another remove in the
> case of two simultaneous writes.
> 
> How about
> 
>         struct inode *parent_inode;
> 
>         parent_inode = d_inode(dentry->d_parent);
>         inode_lock(parent_inode);
>         if (simple_positive(dentry)) {
> 		drop_nlink(parent_inode);
>                 d_delete(dentry);
>                 dput(dentry);
>         }
>         inode_unlock(parent_inode);

It doesn't just change fields in an inode that is about to be evicted.
It changes fields in the parent inode.
If you're deleting any file or directory your function currently fails
to update mtime and ctime for the parent directory.

What you're doing below also isn't all that future proof or safe for
callers other than ima.

Consider a future caller that might want to call securityfs_remove() with

.open   = first_file()

.relase = first_release(
	securityfs_remove(second_file)
)

.open    = second_file()

If your securityfs_remove() is called from the first file's release
function while the second_file is still open and thus holds a reference
and won't go way during first_release()'s securityfs_remove() call you
have just failed to update relevant inode fields of a file that can
still be queried via stat* functions and can be used to create other
files below it.

In addition, if someone accidently calls your securityfs_remove() on a
directory that is not-empty you're effectively deleting the directory
without deleting the files in that directory first whereas
simple_rmdir() would tell you to go away.

If a user later needs an .unlink/.rmdir method for securityfs or allows
calls of securityfs_remove() on the same dentry from concurrent
locations you need the dget() in securityfs_remove() even if the
inode_lock() is exclusive otherwise you can end up doing a dput() too
many, iirc.

I would recommened to not turn this into a nih exercise for simple vfs
functionality. Your version isn't even significantly simpler. The
securityfs_remove() function doesn't need to be reinvented.

void securityfs_remove(struct dentry *dentry)
{
	struct inode *dir;

	if (WARN_ON(!dentry || IS_ERR(dentry)))
		return;

	dir = d_inode(dentry->d_parent);
	inode_lock(dir);
	if (simple_positive(dentry)) {
		dget(dentry);
		if (d_is_dir(dentry))
			simple_rmdir(dir, dentry);
		else
			simple_unlink(dir, dentry);
		d_delete(dentry);
		dput(dentry);
	}
	inode_unlock(dir);
}

I'm not claiming or trying to make this the most minimal version of
securityfs_remove() that we could possibly get but I'm making it one
where we don't have to worry that there's a subtle corner case that'll
bite us in the future just because we tried to hand-massage a function
that isn't in any hotpath.
