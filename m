Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0746D2DA
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhLHMCf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 07:02:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54112 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhLHMCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 07:02:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E4FDCE2033;
        Wed,  8 Dec 2021 11:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD41C341C3;
        Wed,  8 Dec 2021 11:58:53 +0000 (UTC)
Date:   Wed, 8 Dec 2021 12:58:50 +0100
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
Subject: Re: [PATCH v4 11/16] securityfs: Only use
 simple_pin_fs/simple_release_fs for init_user_ns
Message-ID: <20211208115850.wu65ghalpbrjnkfe@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-12-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207202127.1508689-12-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 03:21:22PM -0500, Stefan Berger wrote:
> To prepare for virtualization of SecurityFS, use simple_pin_fs and
> simpe_release_fs only when init_user_ns is active.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  security/inode.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..1a720b2c566d 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -21,9 +21,10 @@
>  #include <linux/security.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
> +#include <linux/user_namespace.h>
>  
> -static struct vfsmount *mount;
> -static int mount_count;
> +static struct vfsmount *securityfs_mount;
> +static int securityfs_mount_count;
>  
>  static void securityfs_free_inode(struct inode *inode)
>  {
> @@ -109,6 +110,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>  					const struct file_operations *fops,
>  					const struct inode_operations *iops)
>  {
> +	struct user_namespace *ns = current_user_ns();
>  	struct dentry *dentry;
>  	struct inode *dir, *inode;
>  	int error;
> @@ -118,12 +120,17 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>  
>  	pr_debug("securityfs: creating file '%s'\n",name);
>  
> -	error = simple_pin_fs(&fs_type, &mount, &mount_count);
> -	if (error)
> -		return ERR_PTR(error);
> +	if (ns == &init_user_ns) {
> +		error = simple_pin_fs(&fs_type, &securityfs_mount,
> +				      &securityfs_mount_count);
> +		if (error)
> +			return ERR_PTR(error);
> +	}
>  
> -	if (!parent)
> -		parent = mount->mnt_root;
> +	if (!parent) {
> +		if (ns == &init_user_ns)
> +			parent = securityfs_mount->mnt_root;

Wouldn't you want an

		else
			return ERR_PTR(-EINVAL);

in here already?

> +	}
>  
>  	dir = d_inode(parent);
>  
> @@ -168,7 +175,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>  	dentry = ERR_PTR(error);
>  out:
>  	inode_unlock(dir);
> -	simple_release_fs(&mount, &mount_count);
> +	if (ns == &init_user_ns)
> +		simple_release_fs(&securityfs_mount,
> +				  &securityfs_mount_count);
>  	return dentry;
>  }
>  
> @@ -294,6 +303,7 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
>   */
>  void securityfs_remove(struct dentry *dentry)
>  {
> +	struct user_namespace *ns = dentry->d_sb->s_user_ns;
>  	struct inode *dir;
>  
>  	if (!dentry || IS_ERR(dentry))
> @@ -309,7 +319,9 @@ void securityfs_remove(struct dentry *dentry)
>  		dput(dentry);
>  	}
>  	inode_unlock(dir);
> -	simple_release_fs(&mount, &mount_count);
> +	if (ns == &init_user_ns)
> +		simple_release_fs(&securityfs_mount,
> +				  &securityfs_mount_count);
>  }
>  EXPORT_SYMBOL_GPL(securityfs_remove);
>  
> -- 
> 2.31.1
> 
> 
