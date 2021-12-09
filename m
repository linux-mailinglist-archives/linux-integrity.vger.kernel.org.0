Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9939E46EA22
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhLIOle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 09:41:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41736 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbhLIOle (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 09:41:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 134FBB823B8;
        Thu,  9 Dec 2021 14:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE0C341C3;
        Thu,  9 Dec 2021 14:37:52 +0000 (UTC)
Date:   Thu, 9 Dec 2021 15:37:49 +0100
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
Message-ID: <20211209143749.wk4agkynfqdzftbl@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
> On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
> > Move the dentries into the ima_namespace for reuse by virtualized
> > SecurityFS. Implement function freeing the dentries in order of
> > files and symlinks before directories.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> 
> This doesn't work as implemented, I think.
> 
> What I would have preferred and what I tried to explain in the earlier
> review was:
> Keep the dentry stashing global since it is only needed for init_ima_ns.
> Then struct ima_namespace becomes way smaller and simpler.
> If you do that then it makes sense to remove the additional dget() in
> securityfs_create_dentry() for non-init_ima_ns.
> Then you can rely on auto-cleanup in .kill_sb() or on
> ima_securityfs_init() failure and you only need to call
> ima_fs_ns_free_dentries() if ns != init_ima_ns.
> 
> IIuc, it seems you're currently doing one dput() too many since you're
> calling securityfs_remove() in the error path for non-init_ima_ns which
> relies on the previous increased dget() which we removed.

If you really want to move the dentry stashing into struct ima_namespace
even though it's really unnecessary then you may as well not care about
the auto-cleanup and keep that additional ima_fs_ns_free_dentries(ns)
call in .kill_sb(). But I really think not dragging dentry stashing into
struct ima_namespace is the correct way to go about this.

> 
> >  include/linux/ima.h             | 13 ++++++
> >  security/integrity/ima/ima_fs.c | 72 ++++++++++++++++++---------------
> >  2 files changed, 52 insertions(+), 33 deletions(-)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 3aaf6e806db4..4dd64e318b15 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -220,6 +220,17 @@ struct ima_h_table {
> >  	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
> >  };
> >  
> > +enum {
> > +	IMAFS_DENTRY_DIR = 0,
> > +	IMAFS_DENTRY_SYMLINK,
> > +	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
> > +	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
> > +	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
> > +	IMAFS_DENTRY_VIOLATIONS,
> > +	IMAFS_DENTRY_IMA_POLICY,
> > +	IMAFS_DENTRY_LAST
> > +};
> > +
> >  struct ima_namespace {
> >  	struct kref kref;
> >  	struct user_namespace *user_ns;
> > @@ -266,6 +277,8 @@ struct ima_namespace {
> >  	struct mutex ima_write_mutex;
> >  	unsigned long ima_fs_flags;
> >  	int valid_policy;
> > +
> > +	struct dentry *dentry[IMAFS_DENTRY_LAST];
> >  };
> >  
> >  extern struct ima_namespace init_ima_ns;
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > index a749a3e79304..3810d11fb463 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -360,14 +360,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
> >  	return result;
> >  }
> >  
> > -static struct dentry *ima_dir;
> > -static struct dentry *ima_symlink;
> > -static struct dentry *binary_runtime_measurements;
> > -static struct dentry *ascii_runtime_measurements;
> > -static struct dentry *runtime_measurements_count;
> > -static struct dentry *violations;
> > -static struct dentry *ima_policy;
> > -
> >  enum ima_fs_flags {
> >  	IMA_FS_BUSY,
> >  };
> > @@ -437,8 +429,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
> >  
> >  	ima_update_policy(ns);
> >  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
> > -	securityfs_remove(ima_policy);
> > -	ima_policy = NULL;
> > +	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
> > +	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
> >  #elif defined(CONFIG_IMA_WRITE_POLICY)
> >  	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
> >  #elif defined(CONFIG_IMA_READ_POLICY)
> > @@ -455,58 +447,72 @@ static const struct file_operations ima_measure_policy_ops = {
> >  	.llseek = generic_file_llseek,
> >  };
> >  
> > -int __init ima_fs_init(void)
> > +static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
> >  {
> > -	ima_dir = securityfs_create_dir("ima", integrity_dir);
> > -	if (IS_ERR(ima_dir))
> > +	int i;
> > +
> > +	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
> > +		securityfs_remove(ns->dentry[i]);
> > +
> > +	memset(ns->dentry, 0, sizeof(ns->dentry));
> > +}
> > +
> > +static int __init ima_securityfs_init(struct user_namespace *user_ns)
> > +{
> > +	struct ima_namespace *ns = user_ns->ima_ns;
> > +	struct dentry *ima_dir;
> > +
> > +	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
> >  		return -1;
> > +	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
> >  
> > -	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
> > -						NULL);
> > -	if (IS_ERR(ima_symlink))
> > +	ns->dentry[IMAFS_DENTRY_SYMLINK] =
> > +	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
> >  		goto out;
> >  
> > -	binary_runtime_measurements =
> > +	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
> >  	    securityfs_create_file("binary_runtime_measurements",
> >  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >  				   &ima_measurements_ops);
> > -	if (IS_ERR(binary_runtime_measurements))
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS]))
> >  		goto out;
> >  
> > -	ascii_runtime_measurements =
> > +	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
> >  	    securityfs_create_file("ascii_runtime_measurements",
> >  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >  				   &ima_ascii_measurements_ops);
> > -	if (IS_ERR(ascii_runtime_measurements))
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS]))
> >  		goto out;
> >  
> > -	runtime_measurements_count =
> > +	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
> >  	    securityfs_create_file("runtime_measurements_count",
> >  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >  				   &ima_measurements_count_ops);
> > -	if (IS_ERR(runtime_measurements_count))
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT]))
> >  		goto out;
> >  
> > -	violations =
> > +	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
> >  	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
> >  				   ima_dir, NULL, &ima_htable_violations_ops);
> > -	if (IS_ERR(violations))
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS]))
> >  		goto out;
> >  
> > -	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
> > +	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
> > +	    securityfs_create_file("policy", POLICY_FILE_FLAGS,
> >  					    ima_dir, NULL,
> >  					    &ima_measure_policy_ops);
> > -	if (IS_ERR(ima_policy))
> > +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY]))
> >  		goto out;
> >  
> >  	return 0;
> >  out:
> > -	securityfs_remove(violations);
> > -	securityfs_remove(runtime_measurements_count);
> > -	securityfs_remove(ascii_runtime_measurements);
> > -	securityfs_remove(binary_runtime_measurements);
> > -	securityfs_remove(ima_symlink);
> > -	securityfs_remove(ima_dir);
> > -	securityfs_remove(ima_policy);
> > +	ima_fs_ns_free_dentries(ns);
> >  	return -1;
> >  }
> > +
> > +int __init ima_fs_init(void)
> > +{
> > +	return ima_securityfs_init(&init_user_ns);
> > +}
> > -- 
> > 2.31.1
> > 
> > 
> 
