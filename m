Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF37477398
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhLPNvM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 08:51:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42544 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLPNvM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 08:51:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDE58B8245E;
        Thu, 16 Dec 2021 13:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F56C36AE0;
        Thu, 16 Dec 2021 13:51:03 +0000 (UTC)
Date:   Thu, 16 Dec 2021 14:51:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v7 14/14] ima: Setup securityfs for IMA namespace
Message-ID: <20211216135100.43suxkutyuwac7yh@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 12:43:23AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Setup securityfs with symlinks, directories, and files for IMA
> namespacing support. The same directory structure that IMA uses on the
> host is also created for the namespacing case.
> 
> The securityfs file and directory ownerships cannot be set when the
> IMA namespace is initialized. Therefore, delay the setup of the file
> system to a later point when securityfs is in securityfs_fill_super.
> 
> This filesystem can now be mounted as follows:
> 
> mount -t securityfs /sys/kernel/security/ /sys/kernel/security/
> 
> The following directories, symlinks, and files are then available.
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
> ---
>  include/linux/ima.h             | 14 ++++++++++++
>  security/inode.c                |  6 ++++-
>  security/integrity/ima/ima.h    |  1 +
>  security/integrity/ima/ima_fs.c | 40 ++++++++++++++++++++++++---------
>  4 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index f9e592bb9560..a2705aa5242a 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
>  				     const char *event_name,
>  				     const void *buf, size_t buf_len,
>  				     bool hash, u8 *digest, size_t digest_len);
> +extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
>  
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>  extern void ima_appraise_parse_cmdline(void);
> @@ -232,6 +233,12 @@ static inline struct ima_namespace *get_current_ns(void)
>  	return current_user_ns()->ima_ns;
>  }
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
> @@ -250,6 +257,13 @@ static inline struct ima_namespace *get_current_ns(void)
>  {
>  	return &init_ima_ns;
>  }
> +
> +static inline int ima_securityfs_init(struct user_namespace *ns,
> +				      struct dentry *root)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_IMA_NS */
>  
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/inode.c b/security/inode.c
> index a0d9f086e3d5..ad9395d121f2 100644
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
> @@ -77,7 +78,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
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
> index d51703290e25..9b0f6a3763f9 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -148,6 +148,7 @@ struct ima_namespace {
>  	int valid_policy;
>  
>  	struct dentry *policy_dentry;
> +	bool policy_dentry_removed;
>  } __randomize_layout;
>  
>  extern const int read_idmap[];
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 7c5a721f4f3d..3b8001ba62e3 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -431,6 +431,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>  	securityfs_remove(ns->policy_dentry);
>  	ns->policy_dentry = NULL;
> +	ns->policy_dentry_removed = true;
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
>  	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>  #elif defined(CONFIG_IMA_READ_POLICY)
> @@ -447,21 +448,31 @@ static const struct file_operations ima_measure_policy_ops = {
>  	.llseek = generic_file_llseek,
>  };
>  
> -static int __init ima_fs_ns_init(struct user_namespace *user_ns)
> +int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  {
>  	struct ima_namespace *ns = user_ns->ima_ns;
> -	struct dentry *ima_dir;
> +	struct dentry *int_dir;
> +	struct dentry *ima_dir = NULL;
>  	struct dentry *ima_symlink = NULL;
>  	struct dentry *binary_runtime_measurements = NULL;
>  	struct dentry *ascii_runtime_measurements = NULL;
>  	struct dentry *runtime_measurements_count = NULL;
>  	struct dentry *violations = NULL;
>  
> -	ima_dir = securityfs_create_dir("ima", integrity_dir);
> +	/* FIXME: update when evm and integrity are namespaced */
> +	if (user_ns != &init_user_ns) {
> +		int_dir =
> +			securityfs_create_dir("integrity", root);
> +		if (IS_ERR(int_dir))
> +			return -1;

That should probably be return PTR_ERR(int_dir)
