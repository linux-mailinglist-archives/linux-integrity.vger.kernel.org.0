Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD452FD90
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiEUPJM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 May 2022 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbiEUPJL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 May 2022 11:09:11 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9D9344F;
        Sat, 21 May 2022 08:09:08 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 058E266D; Sat, 21 May 2022 10:09:06 -0500 (CDT)
Date:   Sat, 21 May 2022 10:09:06 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v12 02/26] securityfs: Extend securityfs with namespacing
 support
Message-ID: <20220521150906.GA13961@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-3-stefanb@linux.ibm.com>
 <20220521022302.GA8575@mail.hallyn.com>
 <20220521093839.3srwejkeqthgk2fq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521093839.3srwejkeqthgk2fq@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 21, 2022 at 11:38:39AM +0200, Christian Brauner wrote:
> On Fri, May 20, 2022 at 09:23:02PM -0500, Serge Hallyn wrote:
> > On Wed, Apr 20, 2022 at 10:06:09AM -0400, Stefan Berger wrote:
> > > Enable multiple instances of securityfs by keying each instance with a
> > > pointer to the user namespace it belongs to.
> > > 
> > > Since we do not need the pinning of the filesystem for the virtualization
> > > case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
> > > case when the init_user_ns is active. This simplifies the cleanup for the
> > > virtualization case where usage of securityfs_remove() to free dentries
> > > is therefore not needed anymore.
> > > 
> > > For the initial securityfs, i.e. the one mounted in the host userns mount,
> > > nothing changes. The rules for securityfs_remove() are as before and it is
> > > still paired with securityfs_create(). Specifically, a file created via
> > > securityfs_create_dentry() in the initial securityfs mount still needs to
> > > be removed by a call to securityfs_remove(). Creating a new dentry in the
> > > initial securityfs mount still pins the filesystem like it always did.
> > > Consequently, the initial securityfs mount is not destroyed on
> > > umount/shutdown as long as at least one user of it still has dentries that
> > > it hasn't removed with a call to securityfs_remove().
> > > 
> > > Prevent mounting of an instance of securityfs in another user namespace
> > > than it belongs to. Also, prevent accesses to files and directories by
> > > a user namespace that is neither the user namespace it belongs to
> > > nor an ancestor of the user namespace that the instance of securityfs
> > > belongs to. Do not prevent access if securityfs was bind-mounted and
> > > therefore the init_user_ns is the owning user namespace.
> > > 
> > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > 
> > > ---
> > > v11:
> > >  - Formatted comment's first line to be '/*'
> > > ---
> > >  security/inode.c | 73 ++++++++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 62 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/security/inode.c b/security/inode.c
> > > index 13e6780c4444..84c9396792a9 100644
> > > --- a/security/inode.c
> > > +++ b/security/inode.c
> > > @@ -21,9 +21,38 @@
> > >  #include <linux/security.h>
> > >  #include <linux/lsm_hooks.h>
> > >  #include <linux/magic.h>
> > > +#include <linux/user_namespace.h>
> > >  
> > > -static struct vfsmount *mount;
> > > -static int mount_count;
> > > +static struct vfsmount *init_securityfs_mount;
> > > +static int init_securityfs_mount_count;
> > > +
> > > +static int securityfs_permission(struct user_namespace *mnt_userns,
> > > +				 struct inode *inode, int mask)
> > > +{
> > > +	int err;
> > > +
> > > +	err = generic_permission(&init_user_ns, inode, mask);
> > > +	if (!err) {
> > > +		/*
> > > +		 * Unless bind-mounted, deny access if current_user_ns() is not
> > > +		 * ancestor.
> > 
> > This comment has confused me the last few times I looked at this.  I see
> > now you're using "bind-mounted" as a shortcut for saying "bind mounted from
> > the init_user_ns into a child_user_ns container".  I do think that needs
> > to be made clearer in this comment.
> > 
> > Should the init_user_ns really be special here?  What if I'm running a
> > first level container with uptodate userspace that mounts its own
> > securityfs, but in that i want to run a nested older userspace that
> > bind mounts the parent securityfs?  Is there a good reason to deny that?
> > 
> > It would seem to me the better check would be
> > 
> > 	if (!is_original_mounter_of(current_user_ns, inode->i_sb->s_user_ns) &&
> > 	     !in_userns(current_user_ns(), inode->i_sb->s_user_ns))
> > 		err = -EACCESS;
> > 
> > the is_original_mounter_of() would require the user_ns to cache first
> > its parent securityfs userns, and, when a task in the user_ns mounts
> > securityfs, then cache its own userns.  (without a reference).
> > If current_user_ns() has mounted a securityfs for a user_ns other than
> > inode->i_sb->s_user_ns (or init_user_ns), then reject the mount.
> > Otherwise check current_user_ns()->parent, etc, until init_user_ns.
> > If you reach init_user_ns, or an ns which mounted inode->i_sb->s_user_ns,
> > then allow, else deny.
> > 
> > It's the kind of special casing we've worked hard to avoid in other
> > namespaces.
> > 
> > > +		 */
> > > +		if (inode->i_sb->s_user_ns != &init_user_ns &&
> > > +		    !in_userns(current_user_ns(), inode->i_sb->s_user_ns))
> > > +			err = -EACCES;
> > > +	}
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static const struct inode_operations securityfs_dir_inode_operations = {
> > > +	.permission	= securityfs_permission,
> > > +	.lookup		= simple_lookup,
> > > +};
> > > +
> > > +static const struct inode_operations securityfs_file_inode_operations = {
> > > +	.permission	= securityfs_permission,
> > > +};
> > >  
> > >  static void securityfs_free_inode(struct inode *inode)
> > >  {
> > > @@ -40,20 +69,25 @@ static const struct super_operations securityfs_super_operations = {
> > >  static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >  {
> > >  	static const struct tree_descr files[] = {{""}};
> > > +	struct user_namespace *ns = fc->user_ns;
> > >  	int error;
> > >  
> > > +	if (WARN_ON(ns != current_user_ns()))
> > > +		return -EINVAL;
> > > +
> > >  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> > >  	if (error)
> > >  		return error;
> > >  
> > >  	sb->s_op = &securityfs_super_operations;
> > > +	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
> > >  
> > >  	return 0;
> > >  }
> > >  
> > >  static int securityfs_get_tree(struct fs_context *fc)
> > >  {
> > > -	return get_tree_single(fc, securityfs_fill_super);
> > > +	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
> > >  }
> > >  
> > >  static const struct fs_context_operations securityfs_context_ops = {
> > > @@ -71,6 +105,7 @@ static struct file_system_type fs_type = {
> > >  	.name =		"securityfs",
> > >  	.init_fs_context = securityfs_init_fs_context,
> > >  	.kill_sb =	kill_litter_super,
> > > +	.fs_flags =	FS_USERNS_MOUNT,
> > >  };
> > >  
> > >  /**
> > > @@ -109,6 +144,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> > >  					const struct file_operations *fops,
> > >  					const struct inode_operations *iops)
> > >  {
> > > +	struct user_namespace *ns = current_user_ns();
> > >  	struct dentry *dentry;
> > >  	struct inode *dir, *inode;
> > >  	int error;
> > > @@ -118,12 +154,19 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> > >  
> > >  	pr_debug("securityfs: creating file '%s'\n",name);
> > >  
> > > -	error = simple_pin_fs(&fs_type, &mount, &mount_count);
> > > -	if (error)
> > > -		return ERR_PTR(error);
> > > +	if (ns == &init_user_ns) {
> > > +		error = simple_pin_fs(&fs_type, &init_securityfs_mount,
> > > +				      &init_securityfs_mount_count);
> > 
> > So ...  it's less work for the kernel to skip the simple_pin_fs()
> > here, but it's more code, and more confusing code, to skip it.
> > 
> > So I just want to ask, to make sure:  is it worth it?  Or should
> > it just be done for all namespaces here (and below and for release),
> > for shorter, simpler, easier to read and grok code?
> 
> I think you might've skipped a few version of the thread.

I sure did :)

> It would be more code and a lot more confusing to try and keep the
> simple_pin_fs(). You will need a per-userns vfsmount pointer and you

Ah, yes, and here you can just use &init_securityfs_mount.

> still need to change securityfs_create_dentry and securityfs_remove. For
> more context see [1] and [2].
> 
> [1]: https://lore.kernel.org/lkml/20211206172600.1495968-12-stefanb@linux.ibm.com
> [2]: https://lore.kernel.org/lkml/20211206172600.1495968-13-stefanb@linux.ibm.com
> 
> The fs pinning logic is most suited for single-superblock, almost
> system-lifetime bound pseudo filesystems such as debugfs or configfs.
> It becomes a rather huge burden when a pseudo fs is supposed to
> support multiple superblocks (in this case keyed by userns).

Thanks!

Acked-by: Serge Hallyn <serge@hallyn.com>

