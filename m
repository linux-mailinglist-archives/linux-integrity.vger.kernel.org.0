Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA22F46D3E4
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 13:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhLHNB7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhLHNB7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 08:01:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71424C061746;
        Wed,  8 Dec 2021 04:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37CCDB81FA1;
        Wed,  8 Dec 2021 12:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907DBC00446;
        Wed,  8 Dec 2021 12:58:18 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:58:14 +0100
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
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Message-ID: <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207202127.1508689-17-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
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
>  include/linux/ima.h             | 17 ++++++++++++++++-
>  security/inode.c                | 12 +++++++++++-
>  security/integrity/ima/ima_fs.c | 33 ++++++++++++++++++++++++++-------
>  3 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index bfb978a7f8d5..a8017272d78d 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -66,6 +66,10 @@ static inline const char * const *arch_get_ima_policy(void)
>  }
>  #endif
>  
> +extern int ima_fs_ns_init(struct user_namespace *user_ns,
> +			  struct dentry *root);
> +extern void ima_fs_ns_free_dentries(struct user_namespace *user_ns);
> +
>  #else
>  static inline enum hash_algo ima_get_current_hash_algo(void)
>  {
> @@ -154,6 +158,15 @@ static inline int ima_measure_critical_data(const char *event_label,
>  	return -ENOENT;
>  }
>  
> +static inline int ima_fs_ns_init(struct user_namespace *ns, struct dentry *root)
> +{
> +	return 0;
> +}
> +
> +static inline void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
> +{
> +}
> +
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> @@ -221,7 +234,8 @@ struct ima_h_table {
>  };
>  
>  enum {
> -	IMAFS_DENTRY_DIR = 0,
> +	IMAFS_DENTRY_INTEGRITY_DIR = 0,
> +	IMAFS_DENTRY_DIR,
>  	IMAFS_DENTRY_SYMLINK,
>  	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
>  	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
> @@ -333,6 +347,7 @@ static inline struct ima_namespace *get_current_ns(void)
>  {
>  	return &init_ima_ns;
>  }
> +
>  #endif /* CONFIG_IMA_NS */
>  
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/inode.c b/security/inode.c
> index 121ac1874dde..10ee20917f42 100644
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
> @@ -41,6 +42,7 @@ static const struct super_operations securityfs_super_operations = {
>  static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	static const struct tree_descr files[] = {{""}};
> +	struct user_namespace *ns = fc->user_ns;
>  	int error;
>  
>  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> @@ -49,7 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_op = &securityfs_super_operations;
>  
> -	return 0;
> +	if (ns != &init_user_ns)
> +		error = ima_fs_ns_init(ns, sb->s_root);
> +
> +	return error;
>  }
>  
>  static int securityfs_get_tree(struct fs_context *fc)
> @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct fs_context *fc)
>  
>  static void securityfs_kill_super(struct super_block *sb)
>  {
> +	struct user_namespace *ns = sb->s_fs_info;
> +
> +	if (ns != &init_user_ns)
> +		ima_fs_ns_free_dentries(ns);

Say securityfs is unmounted. Then all the inodes and dentries become
invalid. It's not allowed to hold on to any dentries or inodes after the
super_block is shut down. So I just want to be sure that nothing in ima
can access these dentries after securityfs is unmounted.

To put it another way: why are they stored in struct ima_namespace in
the first place? If you don't pin a filesystem when creating files or
directories like you do for securityfs in init_ima_ns then you don't
need to hold on to them as they will be automatically be wiped during
umount.
