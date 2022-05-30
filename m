Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FB53733A
	for <lists+linux-integrity@lfdr.de>; Mon, 30 May 2022 03:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiE3BQP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 May 2022 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiE3BQO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 May 2022 21:16:14 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8E72225;
        Sun, 29 May 2022 18:16:11 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6052266E; Sun, 29 May 2022 20:16:10 -0500 (CDT)
Date:   Sun, 29 May 2022 20:16:10 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 21/26] ima: Setup securityfs for IMA namespace
Message-ID: <20220530011610.GA7909@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-22-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-22-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:28AM -0400, Stefan Berger wrote:
> Setup securityfs with symlinks, directories, and files for IMA
> namespacing support. The same directory structure that IMA uses on the
> host is also created for the namespacing case.
> 
> The securityfs file and directory ownerships cannot be set when the
> IMA namespace is initialized. Therefore, delay the setup of the file
> system to a later point when securityfs is in securityfs_fill_super.
> 
> Introduce a variable ima_policy_removed in ima_namespace that is used to
> remember whether the policy file has previously been removed and thus
> should not be created again in case of unmounting and again mounting
> securityfs inside an IMA namespace.
> 
> This filesystem can now be mounted as follows:
> 
> mount -t securityfs /sys/kernel/security/ /sys/kernel/security/
> 
> The following directories, symlinks, and files are available
> when IMA namespacing is enabled, otherwise it will be empty:
> 
> $ ls -l sys/kernel/security/
> total 0
> lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
> drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity
> 
> $ ls -l sys/kernel/security/ima/
> total 0
> -r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
> -r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
> -rw-------. 1 root root 0 Dec  2 00:18 policy
> -r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
> -r--r-----. 1 root root 0 Dec  2 00:18 violations
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

but a nit below

> 
> ---
> 
> v9:
>  - rename policy_dentry_removed to ima_policy_removed
> ---
>  include/linux/ima.h             | 13 ++++++++++
>  security/inode.c                |  6 ++++-
>  security/integrity/ima/ima.h    |  1 +
>  security/integrity/ima/ima_fs.c | 46 +++++++++++++++++++++++----------
>  4 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b9301e2aaa8b..0cbf0434bc93 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -41,6 +41,7 @@ extern int ima_measure_critical_data(const char *event_label,
>  				     const char *event_name,
>  				     const void *buf, size_t buf_len,
>  				     bool hash, u8 *digest, size_t digest_len);
> +extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
>  
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>  extern void ima_appraise_parse_cmdline(void);
> @@ -227,6 +228,12 @@ void free_ima_ns(struct user_namespace *ns);
>  
>  void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock);
>  
> +static inline int ima_securityfs_init(struct user_namespace *user_ns,
> +				      struct dentry *root)
> +{
> +	return ima_fs_ns_init(user_ns, root);
> +}
> +
>  #else
>  
>  static inline void free_ima_ns(struct user_namespace *user_ns)
> @@ -238,6 +245,12 @@ static inline void ima_free_ns_status_list(struct list_head *head,
>  {
>  }
>  
> +static inline int ima_securityfs_init(struct user_namespace *ns,
> +				      struct dentry *root)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_IMA_NS */
>  
>  #endif /* _LINUX_IMA_H */
> diff --git a/security/inode.c b/security/inode.c
> index 84c9396792a9..e81f55f054dc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/mount.h>
>  #include <linux/pagemap.h>
> +#include <linux/ima.h>
>  #include <linux/init.h>
>  #include <linux/namei.h>
>  #include <linux/security.h>
> @@ -82,7 +83,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_op = &securityfs_super_operations;
>  	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
>  
> -	return 0;
> +	if (ns != &init_user_ns)
> +		error = ima_securityfs_init(ns, sb->s_root);
> +
> +	return error;
>  }
>  
>  static int securityfs_get_tree(struct fs_context *fc)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cb48fc1d5b80..801dc3c8bfde 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -152,6 +152,7 @@ struct ima_namespace {
>  	int valid_policy;
>  
>  	struct dentry *ima_policy;
> +	bool ima_policy_removed;
>  
>  	struct notifier_block ima_lsm_policy_notifier;
>  } __randomize_layout;
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index c41aa61b7393..84cd02a9e19b 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -21,6 +21,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/parser.h>
>  #include <linux/vmalloc.h>
> +#include <linux/ima.h>
>  
>  #include "ima.h"
>  
> @@ -433,6 +434,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>  	securityfs_remove(ns->ima_policy);
>  	ns->ima_policy = NULL;
> +	ns->ima_policy_removed = true;
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
>  	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>  #elif defined(CONFIG_IMA_READ_POLICY)
> @@ -449,9 +451,11 @@ static const struct file_operations ima_measure_policy_ops = {
>  	.llseek = generic_file_llseek,
>  };
>  
> -static int __init ima_fs_ns_init(struct ima_namespace *ns)
> +int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  {
> -	struct dentry *ima_dir;
> +	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
> +	struct dentry *int_dir;
> +	struct dentry *ima_dir = NULL;
>  	struct dentry *ima_symlink = NULL;
>  	struct dentry *binary_runtime_measurements = NULL;
>  	struct dentry *ascii_runtime_measurements = NULL;
> @@ -459,11 +463,22 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>  	struct dentry *violations = NULL;
>  	int ret;
>  
> -	ima_dir = securityfs_create_dir("ima", integrity_dir);
> -	if (IS_ERR(ima_dir))
> -		return PTR_ERR(ima_dir);
> +	/* FIXME: update when evm and integrity are namespaced */
> +	if (user_ns != &init_user_ns) {
> +		int_dir = securityfs_create_dir("integrity", root);
> +		if (IS_ERR(int_dir))
> +			return PTR_ERR(int_dir);
> +	} else {
> +		int_dir = integrity_dir;
> +	}
>  
> -	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
> +	ima_dir = securityfs_create_dir("ima", int_dir);
> +	if (IS_ERR(ima_dir)) {
> +		ret = PTR_ERR(ima_dir);
> +		goto out;
> +	}
> +
> +	ima_symlink = securityfs_create_symlink("ima", root, "integrity/ima",
>  						NULL);
>  	if (IS_ERR(ima_symlink)) {
>  		ret = PTR_ERR(ima_symlink);
> @@ -505,12 +520,15 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>  		goto out;
>  	}
>  
> -	ns->ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
> -						ima_dir, NULL,
> -						&ima_measure_policy_ops);
> -	if (IS_ERR(ns->ima_policy)) {
> -		ret = PTR_ERR(ns->ima_policy);
> -		goto out;
> +	if (!ns->ima_policy_removed) {

It would be nicer to avoid this indent level by just doing

	if (ns->ima_policy_removed)
		return 0;

above the securityfs_create_file().

> +		ns->ima_policy =
> +		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
> +					   ima_dir, NULL,
> +					   &ima_measure_policy_ops);
> +		if (IS_ERR(ns->ima_policy)) {
> +			ret = PTR_ERR(ns->ima_policy);
> +			goto out;
> +		}
>  	}
>  
>  	return 0;
> @@ -522,11 +540,13 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>  	securityfs_remove(binary_runtime_measurements);
>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
> +	if (user_ns != &init_user_ns)
> +		securityfs_remove(int_dir);
>  
>  	return ret;
>  }
>  
>  int __init ima_fs_init(void)
>  {
> -	return ima_fs_ns_init(&init_ima_ns);
> +	return ima_fs_ns_init(&init_user_ns, NULL);
>  }
> -- 
> 2.34.1
> 
