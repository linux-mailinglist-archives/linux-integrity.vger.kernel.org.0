Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47B9471361
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLKKpk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 05:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhLKKpj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 05:45:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E66C061714;
        Sat, 11 Dec 2021 02:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7FEC7CE2F57;
        Sat, 11 Dec 2021 10:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CAC004DD;
        Sat, 11 Dec 2021 10:45:30 +0000 (UTC)
Date:   Sat, 11 Dec 2021 11:45:27 +0100
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
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20211211104527.7cp4mbznjpcijfqx@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
 <20211210113244.odv2ibrifz2jzft5@wittgenstein>
 <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
 <20211211095026.i2gvqjy4df3sxq42@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211095026.i2gvqjy4df3sxq42@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 11, 2021 at 10:50:26AM +0100, Christian Brauner wrote:
> On Fri, Dec 10, 2021 at 08:57:11AM -0500, Stefan Berger wrote:
> > 
> > On 12/10/21 06:32, Christian Brauner wrote:
> > > On Thu, Dec 09, 2021 at 07:57:02PM -0500, Stefan Berger wrote:
> > > > On 12/9/21 14:11, Christian Brauner wrote:
> > > > >   From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17 00:00:00 2001
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Date: Thu, 9 Dec 2021 20:07:02 +0100
> > > > > Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!
> > > > > 
> > > > > ---
> > > > >    security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++----
> > > > >    1 file changed, 38 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > > > > index 583462b29cb5..d5b302b925b8 100644
> > > > > --- a/security/integrity/ima/ima_fs.c
> > > > > +++ b/security/integrity/ima/ima_fs.c
> > > > > @@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char *path)
> > > > >    static ssize_t ima_write_policy(struct file *file, const char __user *buf,
> > > > >    				size_t datalen, loff_t *ppos)
> > > > >    {
> > > > > -	struct ima_namespace *ns = get_current_ns();
> > > > > +	struct ima_namespace *ns;
> > > > > +	struct user_namespace *user_ns;
> > > > >    	char *data;
> > > > >    	ssize_t result;
> > > > > +	user_ns = ima_filp_private(filp);
> > > > > +	ns = user_ns->ima_ns
> > > > > +
> > > > >    	if (datalen >= PAGE_SIZE)
> > > > >    		datalen = PAGE_SIZE - 1;
> > > > > @@ -373,26 +377,51 @@ static const struct seq_operations ima_policy_seqops = {
> > > > >    };
> > > > >    #endif
> > > > > +static struct user_namespace *ima_filp_private(struct file *filp)
> > > > > +{
> > > > > +	if (!(filp->f_flags & O_WRONLY)) {
> > > > > +#ifdef CONFIG_IMA_READ_POLICY
> > > > > +		struct seq_file *seq;
> > > > > +
> > > > > +		seq = filp->private_data;
> > > > > +		return seq->private;
> > > > > +#endif
> > > > > +	}
> > > > > +	return filp->private_data;
> > > > > +}
> > > > > +
> > > > >    /*
> > > > >     * ima_open_policy: sequentialize access to the policy file
> > > > >     */
> > > > >    static int ima_open_policy(struct inode *inode, struct file *filp)
> > > > >    {
> > > > > -	struct ima_namespace *ns = get_current_ns();
> > > > > +	struct user_namespace *user_ns = current_user_ns();
> > > > 
> > > > Do we have to take a reference on the user namespace assuming one can open
> > > > the file, pass the fd down the hierarchy, and then the user namespace with
> > > > the opened file goes away? Or is there anything else that keeps the user
> > > > namespace alive?
> > > No, we don't. When ima_policy_open() is called we do current_user_ns()
> > > but that will be guaranteed to be identical to filp->f_cred->user_ns.
> > > And f_cred is a reference that has been taken when the vfs allocated a
> > > struct file for this .open call so won't go away until the last fput.
> > > 
> > > My proposal is also too complicated, I think.
> > > (The booster is giving me the same side-effects as my second shot so
> > > this looks like two good days of fever and headache. So I'll use that as
> > > an excuse. :))
> > > 
> > > Your patch series as it stands has a bit of a security issue with those
> > > get_current_ns() calls across differnet file/seq_file operations.
> > > 
> > > You have to make an architectural decision, I think. I see two sensible
> > > options:
> > > 1. The relevant ima_ns that .open/.read/.write operate on is always taken
> > >     to be the ima_ns of the filesystem's userns, i.e.
> > >     sb->s_user_ns->ima_ns.
> > >     This - but I'm not an ima person - makes the most sense to me and the
> > >     semantics are straightforward. If I write to a file to alter some
> > >     policy then I expect the ima namespace of the user namespace to be
> > >     affected that the securityfs instance was mounted in.
> > > 2. The relevant ima_ns that .open/.read/.write operate on is always
> > >     taken to be the one of the opener. I don't really like that as that
> > >     gets weird if for some complicated reason the caller is not located
> > >     in the userns the filesystem was mounted in (weird mount propagation
> > >     scenario or sm). It also feels strange to operate on an ima_ns that's
> > >     different from s_user_ns->ima_ns in a securityfs instance.
> > 
> > We have this situation because one can setns() to another mount namespaces
> > but the data shown by SecurityFS lives in a user namespace, right? And now
> > we need to decide whether to affect the data in the user namespace  that did
> > the open (option 2) or to which the SecurityFS belongs to (option 1). If we
> > were to open a regular file it would be option 1, so we should probably not
> > break that existing semantic and also choose option 1 unless there one
> > wasn't allowed to choose the user namespace the SecurityFS files belonged to
> > then it should be option 2 but then we have file descriptor passing where
> > 'being allowed' can change depending on who is reading/writing a file... Is
> 
> A general remark that's always worth repeating: under no circumstances
> should the object that you're operating on change from .open to
> .read/.write. Consider the following very rough sketch:
> 
> 	pid = fork():
> 	if (pid == 0) {
> 		// create USERNS1
> 		unshare(CLONE_NEWUSER);
> 	
> 		// write an idmapping for getuid() to userns 0
> 	
> 		mount("", "/sys/kernel/security", "securityfs", [...]);
> 	
> 		int fd_ima = open("/sys/kernel/security/some_ima_file", O_WRONLY);
> 	
> 		// Send fd_ima to parent via SCM_RIGHTS
> 	}
> 	// Receive fd_ima from child.
> 	
> 	write(fd_ima, "SET_OPTION_ON_INIT_USER_NS", ...); 
> 
> That example above is an instant security issue if the ima_ns changed
> depending on the caller since it means you could open a file in an
> unprivileged userns and then funnel it to a random process in
> init_user_ns that you control via SCM_RIGHTS and have it do the write()
> and instead of USERNS1->ima_ns you'd suddenly have changed
> init_user_ns->ima_ns.
> And this is what your previous patch with these multiple
> get_current_ns() calls allowed.
> 
> So the write in the example above must operate on USERNS1->ima_ns.
> 
> Now, both option 1 and 2 will ensure that the ima_ns that is operated on
> is always the same across .open/.read/.write:
> 1. securityfs->sb->s_user_ns->ima_ns this is trivially guaranteed
>    because the filesystem's user namespace doesn't change no matter
>    where you access that filesystem from.
> 2. securityfs_file->f_cred->user_ns->ima_ns this is guaranteed because
>    f_cred stashes the openers credentials.
> 
> What I fundamentally dislike about option 2 (f_cred) is - and I tried to
> say that in my prior mail - that what ima_ns is operated on depends on
> the userns of the process that called .open, i.e. the contents in
> securityfs change depending on the opener's userns.
> 
> And I think that is fundamentally sloppy semantics. The contents of a
> filesystem should generally not depend on the caller if it can be
> avoided. We have a few instances where this is the case (e.g. some
> procfs sysctls) but especially for securityfs this does not make sense.
> 
> > there anything that would prevent us from setns()'ing to that target user
> > namespace so that we would now see that of a user namespace that we are not
> > allowed to see?
> 
> If you're really worried about someone being able to access a securityfs
> instance whose userns doesn't match the userns the securityfs instance
> was mounted in there are multiple ways to fix it. The one that I tend to
> prefer is:
> 
> From e0ff6a8dcc573763568e685dd70d1547efd68df9 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 10 Dec 2021 11:47:37 +0100
> Subject: !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
> 
> securityfs: only allow access to securityfs from within same namespace
> 
> Limit opening of securityfs files to callers located in the same namespace.
> 
> ---
>  security/inode.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index eaccba7017d9..9eaf757c08cb 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -80,6 +80,35 @@ static struct file_system_type fs_type = {
>  	.fs_flags =	FS_USERNS_MOUNT,
>  };
>  
> +static int securityfs_permission(struct user_namespace *mnt_userns,
> +				 struct inode *inode, int mask)
> +{
> +	int err;
> +
> +	err = generic_permission(&init_user_ns, inode, mask);
> +	if (!err) {
> +		if (inode->i_sb->s_user_ns != current_user_ns())
> +			err = -EACCES;
> +	}

Thinking about this a better alternative might be (on top of my
previous suggestion):

diff --git a/security/inode.c b/security/inode.c
index 0000b2bd4c0c..a540372e4c8c 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -86,15 +86,15 @@ static struct file_system_type fs_type = {
 static int securityfs_permission(struct user_namespace *mnt_userns,
                                 struct inode *inode, int mask)
 {
-       int err;
-
-       err = generic_permission(&init_user_ns, inode, mask);
-       if (!err) {
-               if (inode->i_sb->s_user_ns != current_user_ns())
-                       err = -EACCES;
-       }
-
-       return err;
+       /*
+        * Restrict access to securityfs to callers whose user
+        * namespace is the same or an ancestor of the user namespace
+        * this securityfs instance was mounted in.
+        */
+       if (!in_userns(current_user_ns(), inode->i_sb->s_user_ns))
+               return -EACCES;
+
+       return generic_permission(&init_user_ns, inode, mask);
 }

 const struct inode_operations securityfs_dir_inode_operations = {
