Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C4046EC1F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 16:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbhLIPut (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 10:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhLIPus (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 10:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C960C061746;
        Thu,  9 Dec 2021 07:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0204DB8251E;
        Thu,  9 Dec 2021 15:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8730FC004DD;
        Thu,  9 Dec 2021 15:47:06 +0000 (UTC)
Date:   Thu, 9 Dec 2021 16:47:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Message-ID: <20211209154703.4mprhv2rcgvgkmx5@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <20211209144109.4xkyibwsuaqkbu47@wittgenstein>
 <f0710142-0d91-d6c4-8d2c-7eac1a946969@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0710142-0d91-d6c4-8d2c-7eac1a946969@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 09, 2021 at 10:00:59AM -0500, Stefan Berger wrote:
> 
> On 12/9/21 09:41, Christian Brauner wrote:
> > On Thu, Dec 09, 2021 at 03:37:49PM +0100, Christian Brauner wrote:
> > > On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
> > > > On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
> > > > > Move the dentries into the ima_namespace for reuse by virtualized
> > > > > SecurityFS. Implement function freeing the dentries in order of
> > > > > files and symlinks before directories.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > ---
> > > > This doesn't work as implemented, I think.
> > > > 
> > > > What I would have preferred and what I tried to explain in the earlier
> > > > review was:
> > > > Keep the dentry stashing global since it is only needed for init_ima_ns.
> > > > Then struct ima_namespace becomes way smaller and simpler.
> > > > If you do that then it makes sense to remove the additional dget() in
> > > > securityfs_create_dentry() for non-init_ima_ns.
> > > > Then you can rely on auto-cleanup in .kill_sb() or on
> > > > ima_securityfs_init() failure and you only need to call
> > > > ima_fs_ns_free_dentries() if ns != init_ima_ns.
> > s/ns != init_ima_ns/ns == init_ima_ns/
> > 
> > > > IIuc, it seems you're currently doing one dput() too many since you're
> > > > calling securityfs_remove() in the error path for non-init_ima_ns which
> > > > relies on the previous increased dget() which we removed.
> 
> I thought that securityfs_remove() will now simply influence when a dentry
> is removed and freed. If we call it in the error cleanup path in
> non-init_user_ns case it would go away right there and leave nothing to do
> for .kill_sb() while an additional dget() would require the cleanup as well
> but do another cleanup then in .kill_sb() since that brings the reference
> count to 0 via the dput()s that it does. Am I wrong on this?

With your change you get one dget() from lookup_one_len() in
securityfs_create_dentry() for non-init_ima_ns. That's added to the
dcache via d_instantiate().
If you call securityfs_dentry_remove() in the error path or anywhere
else it does:

	dir = d_inode(dentry->d_parent);
	inode_lock(dir);
	if (simple_positive(dentry)) {
		if (d_is_dir(dentry))
			simple_rmdir(dir, dentry);
		else
			simple_unlink(dir, dentry);
		dput(dentry);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That dput() right there is for the additional dget() in
securityfs_create_dentry() but we didn't take that. So the dput() is one
too many now since simple_rmdir() and simple_unlink() will have consumed
one already. (You should be able to easily see this if you compile with
sanitizers on and let your init function fail somewhere in the middle.)

(What usually should happen is sm like this:

void binderfs_remove_file(struct dentry *dentry)
{
	struct inode *parent_inode;

	parent_inode = d_inode(dentry->d_parent);
	inode_lock(parent_inode);
	if (simple_positive(dentry)) {
		dget(dentry);
		simple_unlink(parent_inode, dentry);
		d_delete(dentry);
		dput(dentry);
	}
	inode_unlock(parent_inode);
})

> 
> 
> > > If you really want to move the dentry stashing into struct ima_namespace
> > > even though it's really unnecessary then you may as well not care about
> > > the auto-cleanup and keep that additional ima_fs_ns_free_dentries(ns)
> > > call in .kill_sb(). But I really think not dragging dentry stashing into
> > > struct ima_namespace is the correct way to go about this.
> 
> 
> I moved the dentries into the ima_namespace so that each namespace holds a
> pointer to the dentries it owns and isolates them. We certainly wouldn't
> want to have IMA namespaces write over the current static variables and
> create a mess with what these are pointing to ( https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L359
> ) and possible race conditions when doing parallel initialization (if that's
> possible at all). This also reduces the code size and we don't need two
> different implementations for init_user_ns and non-init_user_ns. So I don't
> quite understand whey we wouldn't want to have the dentries isolated via
> ima_namespace?

My point was this:
Afaict, nowhere in ima are the stashed dentries needed apart from
ima_policy_release() which is the .release method of the
file_operations where the policy dentry is removed.

The dentries only exist because for pre-namespaced ima if you created a
dentry going through securityfs_create_dentry() you're pinning the
super_block of init-securityfs via simple_pin_fs(). That obliges you to
call securityfs_remove() later on in order to call simple_unpin_fs() for
all dentries.

But for namespaced-ima with namespaced-securityfs there is no more call
to simple_{pin,unpin}_fs(). Consequently you don't need to stash the
dentries anywhere to have them available for removal later on. They will
be automatically cleaned up during .kill_sb().

The one exception I was unaware of reading the code before is in
ima_policy_release(). So apologies, I didn't see that. There you remove:

static int ima_release_policy(struct inode *inode, struct file *file)
{
	struct ima_namespace *ns = get_current_ns();
	const char *cause = ns->valid_policy ? "completed" : "failed";

	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
		return seq_release(inode, file);

	if (ns->valid_policy && ima_check_policy(ns) < 0) {
		cause = "failed";
		ns->valid_policy = 0;
	}

	pr_info("policy update %s\n", cause);
	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
			    "policy_update", cause, !ns->valid_policy, 0);

	if (!ns->valid_policy) {
		ima_delete_rules(ns);
		ns->valid_policy = 1;
		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
		return 0;
	}

	ima_update_policy(ns);
#if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;

^^^^^^^^^^^^^^^^^^^^^^^^^

But even so, why then stash all those dentries if the only dentry that
you ever remove while ima is active - and ima isn't a module so can't be
unloaded - is the IMAFS_DENTRY_IMA_POLICY. Simply stash the single
dentry in struct ima_namespace and forget about all the other ones and
avoid wasting memory. But maybe I'm misunderstanding something.

I'm going to get my booster shot and hopefully I'll be able to work
tomorrow and later today but I wouldn't bet on it.

Christian
