Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C56466468
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346770AbhLBNVy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 08:21:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43604 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbhLBNVx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 08:21:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EBB5BCE1ED3;
        Thu,  2 Dec 2021 13:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEA2C00446;
        Thu,  2 Dec 2021 13:18:21 +0000 (UTC)
Date:   Thu, 2 Dec 2021 14:18:18 +0100
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
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
Message-ID: <20211202131818.ygzsywwfu4rfcbuy@wittgenstein>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-21-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130160654.1418231-21-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 30, 2021 at 11:06:54AM -0500, Stefan Berger wrote:
> Setup securityfs_ns with symlinks, directories, and files for IMA
> namespacing support. The same directory structure that IMA uses on the
> host is also created for the namespacing case.
> 
> Increment the user namespace's refcount_teardown value by '1' once
> securityfs_ns has been successfully setup since the initialization of the
> filesystem causes an additional reference to the user namespace to be
> taken. The early teardown function will delete the file system and release
> the additional reference.
> 
> The securityfs_ns file and directory ownerships cannot be set when the
> filesystem is setup since at this point the user namespace has not been
> configured yet by the user and therefore the ownership mappings are not
> available, yet. Therefore, adjust the file and directory ownerships when
> an inode's function for determining the permissions of a file or directory
> is accessed.
> 
> This filesystem can now be mounted as follows:
> 
> mount -t securityfs_ns /sys/kernel/security/ /sys/kernel/security/
> 
> The following directories, symlinks, and files are then available.
> 
> $ ls -l sys/kernel/security/
> total 0
> lr--r--r--. 1 nobody nobody 0 Nov 27 06:44 ima -> integrity/ima
> drwxr-xr-x. 3 nobody nobody 0 Nov 27 06:44 integrity
> 
> $ ls -l sys/kernel/security/ima/
> total 0
> -r--r-----. 1 root root 0 Nov 27 06:44 ascii_runtime_measurements
> -r--r-----. 1 root root 0 Nov 27 06:44 binary_runtime_measurements
> -rw-------. 1 root root 0 Nov 27 06:44 policy
> -r--r-----. 1 root root 0 Nov 27 06:44 runtime_measurements_count
> -r--r-----. 1 root root 0 Nov 27 06:44 violations
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h                      |  17 +++
>  security/integrity/ima/ima.h             |   2 +
>  security/integrity/ima/ima_fs.c          | 178 ++++++++++++++++++++++-
>  security/integrity/ima/ima_init_ima_ns.c |   6 +-
>  security/integrity/ima/ima_ns.c          |   4 +-
>  5 files changed, 203 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index fe08919df326..a2c5e516f706 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -221,6 +221,18 @@ struct ima_h_table {
>  	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
>  };
>  
> +enum {
> +	IMAFS_DENTRY_INTEGRITY_DIR = 0,
> +	IMAFS_DENTRY_DIR,
> +	IMAFS_DENTRY_SYMLINK,
> +	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
> +	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
> +	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
> +	IMAFS_DENTRY_VIOLATIONS,
> +	IMAFS_DENTRY_IMA_POLICY,
> +	IMAFS_DENTRY_LAST
> +};
> +
>  struct ima_namespace {
>  	struct kref kref;
>  	struct user_namespace *user_ns;
> @@ -267,6 +279,11 @@ struct ima_namespace {
>  	struct mutex ima_write_mutex;
>  	unsigned long ima_fs_flags;
>  	int valid_policy;
> +
> +	struct dentry *dentry[IMAFS_DENTRY_LAST];
> +	struct vfsmount *mount;
> +	int mount_count;
> +	bool file_ownership_fixes_done;
>  };
>  
>  extern struct ima_namespace init_ima_ns;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index bb9763cd5fb1..9bcd71bb716c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -139,6 +139,8 @@ struct ns_status {
>  /* Internal IMA function definitions */
>  int ima_init(void);
>  int ima_fs_init(void);
> +int ima_fs_ns_init(struct ima_namespace *ns);
> +void ima_fs_ns_free(struct ima_namespace *ns);
>  int ima_add_template_entry(struct ima_namespace *ns,
>  			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 6766bb8262f2..9a14be520268 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -22,6 +22,7 @@
>  #include <linux/parser.h>
>  #include <linux/vmalloc.h>
>  #include <linux/ima.h>
> +#include <linux/namei.h>
>  
>  #include "ima.h"
>  
> @@ -436,8 +437,13 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  
>  	ima_update_policy(ns);
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
> -	securityfs_remove(ima_policy);
> -	ima_policy = NULL;
> +	if (ns == &init_ima_ns) {
> +		securityfs_remove(ima_policy);
> +		ima_policy = NULL;
> +	} else {
> +		securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_POLICY]);
> +		ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
> +	}
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
>  	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>  #elif defined(CONFIG_IMA_READ_POLICY)
> @@ -509,3 +515,171 @@ int __init ima_fs_init(void)
>  	securityfs_remove(ima_policy);
>  	return -1;
>  }
> +
> +/*
> + * Fix the ownership (uid/gid) of the dentry's that couldn't be set at the
> + * time of their creation because the user namespace wasn't configured, yet.
> + */
> +static void ima_fs_ns_fixup_uid_gid(struct ima_namespace *ns)
> +{
> +	struct inode *inode;
> +	size_t i;
> +
> +	if (ns->file_ownership_fixes_done ||
> +	    ns->user_ns->uid_map.nr_extents == 0)
> +		return;
> +
> +	ns->file_ownership_fixes_done = true;
> +	for (i = 0; i < IMAFS_DENTRY_LAST; i++) {
> +		if (!ns->dentry[i])
> +			continue;
> +		inode = ns->dentry[i]->d_inode;
> +		inode->i_uid = make_kuid(ns->user_ns, 0);
> +		inode->i_gid = make_kgid(ns->user_ns, 0);
> +	}
> +}
> +
> +/* Fix the permissions when a file is opened */
> +int ima_fs_ns_permission(struct user_namespace *mnt_userns, struct inode *inode,
> +			 int mask)
> +{
> +	ima_fs_ns_fixup_uid_gid(get_current_ns());

As noted later in the thread if this is required it means something is
buggy in the current code. That shouldn't be needed.

I think there's a more fundamental issue here. The correct way to do all
this would be to restructure securityfs at least how it works inside of
user namespaces. Currently, securityfs works like debugfs: a single
shared superblock that is pinned by each new inode that is created via:

	simple_pin_fs(&fs_type, &mount, &mount_count);
	simple_release_fs(&mount, &mount_count);

and each mount surfaces the same superblock. Ideally making securityfs
mountable inside of user namespaces should get you a new superblock.
Functions that create files for the ima ns would then be called inside
->fill_super etc.
