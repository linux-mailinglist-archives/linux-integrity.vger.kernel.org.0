Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5848E99E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiANMF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 07:05:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53970 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiANMF6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 07:05:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD2D7B8243F;
        Fri, 14 Jan 2022 12:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0287C36AE5;
        Fri, 14 Jan 2022 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642161955;
        bh=SQu2q3mqwlf1E7r6zb1Cv35JGG9gEEFh1NHt6z6eIM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIk16NAK/pILB/kXfA7NioP5NfrnUayqY50hMedt/25jr6q+D/na+bczN+AuhcOWc
         bf2Bj3cXJIFaBIVP/TYEcNFg85JwU5Lc/Ql6Pqgdx3VH20UH7ROhWSThx8I0+a6cuM
         8ns6q2xyJa3115Wzu0JPpYl6yIUiCY+EC7jPI1QAiE53HO/mvZz0hjj3SDJh1aigw4
         DU66Fu2BMCO02ETtbw38moCClFwTVqHrT/3pgTjCgG3VMkbi8bQRwzfmbmpyAa5jJb
         i7P61YAbrRVUS3kfnTXXK6VmWmJAM+Zez9P2APU4ZzJgiA4Z3Dk93vWbNWq+IepMbX
         6LRcctUuC7g8Q==
Date:   Fri, 14 Jan 2022 13:05:47 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 19/19] ima: Enable IMA namespaces
Message-ID: <20220114120547.jrasikjcaahareue@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 04, 2022 at 12:04:16PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Introduce the IMA_NS in Kconfig for IMA namespace enablement.
> 
> Enable the lazy initialization of an IMA namespace when a user mounts
> SecurityFS. Now a user_namespace will get a pointer to an ima_namespace
> and therefore add an implementation of get_current_ns() that returns this
> pointer.
> 
> get_current_ns() may now return a NULL pointer for as long as the IMA
> namespace hasn't been created, yet. Therefore, return early from those
> functions that may now get a NULL pointer from this call. The NULL
> pointer can typically be treated similar to not having an IMA policy set
> and simply return early from a function.
> 
> Implement ima_ns_from_file() for SecurityFS-related files where we can
> now get the IMA namespace via the user namespace pointer associated
> with the superblock of the SecurityFS filesystem instance. Since
> the functions using ima_ns_from_file() will only be called after an
> ima_namesapce has been allocated they will never get a NULL pointer
> for the ima_namespace.
> 
> Switch access to userns->ima_ns to use acquire/release semantics to ensure
> that a newly created ima_namespace structure is fully visible upon access.
> 
> Replace usage of current_user_ns() with ima_ns_from_user_ns() that
> implements a method to derive the user_namespace from the given
> ima_namespace. It leads to the same result.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h                 |  9 ++++++-
>  init/Kconfig                        | 13 ++++++++++
>  kernel/user_namespace.c             |  2 ++
>  security/integrity/ima/ima.h        | 35 ++++++++++++++++++++++-----
>  security/integrity/ima/ima_fs.c     | 37 ++++++++++++++++++++++-------
>  security/integrity/ima/ima_main.c   | 29 ++++++++++++++++------
>  security/integrity/ima/ima_ns.c     |  3 ++-
>  security/integrity/ima/ima_policy.c | 13 +++++-----
>  8 files changed, 112 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 5354e83d1694..7b9713b290ae 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/security.h>
>  #include <linux/kexec.h>
> +#include <linux/user_namespace.h>
>  #include <crypto/hash_info.h>
>  struct linux_binprm;
>  
> @@ -71,7 +72,13 @@ static inline const char * const *arch_get_ima_policy(void)
>  static inline struct user_namespace
>  *ima_ns_to_user_ns(struct ima_namespace *ns)
>  {
> -	return current_user_ns();
> +	struct user_namespace *user_ns;
> +
> +	user_ns = current_user_ns();
> +#ifdef CONFIG_IMA_NS
> +	WARN_ON(user_ns->ima_ns != ns);
> +#endif
> +	return user_ns;
>  }
>  
>  #else
> diff --git a/init/Kconfig b/init/Kconfig
> index 4b7bac10c72d..e27155e0ddba 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1247,6 +1247,19 @@ config NET_NS
>  	  Allow user space to create what appear to be multiple instances
>  	  of the network stack.
>  
> +config IMA_NS
> +	bool "IMA namespace"
> +	depends on USER_NS
> +	depends on IMA
> +	default n
> +	help
> +	  Allow the creation of an IMA namespace for each user namespace.
> +	  Namespaced IMA enables having IMA features work separately
> +	  in each IMA namespace.
> +	  Currently, only the audit status flags are stored in the namespace,
> +	  which allows the same file to be audited each time it is accessed
> +	  in a new namespace.
> +
>  endif # NAMESPACES
>  
>  config CHECKPOINT_RESTORE
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b2e3ca7ee99..653f8fa83b69 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -20,6 +20,7 @@
>  #include <linux/fs_struct.h>
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
> +#include <linux/ima.h>
>  
>  static struct kmem_cache *user_ns_cachep __read_mostly;
>  static DEFINE_MUTEX(userns_state_mutex);
> @@ -196,6 +197,7 @@ static void free_user_ns(struct work_struct *work)
>  			kfree(ns->projid_map.forward);
>  			kfree(ns->projid_map.reverse);
>  		}
> +		free_ima_ns(ns);
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
>  		ns_free_inum(&ns->ns);
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 344c8c4bd030..d993655ec796 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -509,21 +509,20 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>  	return file_inode(filp)->i_sb->s_user_ns;
>  }
>  
> +#ifdef CONFIG_IMA_NS
> +
>  static inline struct ima_namespace
>  *ima_ns_from_user_ns(struct user_namespace *user_ns)
>  {
> -	if (user_ns == &init_user_ns)
> -		return &init_ima_ns;
> -	return NULL;
> +	/* Pairs with smp_store_releases() in create_ima_ns(). */
> +	return smp_load_acquire(&user_ns->ima_ns);
>  }
>  
>  static inline struct ima_namespace *get_current_ns(void)
>  {
> -	return &init_ima_ns;
> +	return ima_ns_from_user_ns(current_user_ns());
>  }
>  
> -#ifdef CONFIG_IMA_NS
> -
>  struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
>  
>  struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
> @@ -532,6 +531,11 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>  
>  void ima_free_ns_status_tree(struct ima_namespace *ns);
>  
> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
> +{
> +	return ima_user_ns_from_file(filp)->ima_ns;
> +}
> +
>  #define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
>  #define IMA_NS_STATUS_FLAGS     IMA_AUDITED
>  
> @@ -542,6 +546,20 @@ unsigned long set_iint_flags(struct integrity_iint_cache *iint,
>  
>  #else
>  
> +static inline struct ima_namespace
> +*ima_ns_from_user_ns(struct user_namespace *user_ns)
> +{
> +	if (user_ns == &init_user_ns)
> +		return &init_ima_ns;
> +	return NULL;
> +}
> +
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return &init_ima_ns;
> +}
> +
>  static inline struct ima_namespace *
>  create_ima_ns(struct user_namespace *user_ns)
>  {
> @@ -572,6 +590,11 @@ static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
>  	return flags;
>  }
>  
> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
> +{
> +	return &init_ima_ns;
> +}
> +
>  #endif /* CONFIG_IMA_NS */
>  
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 468508f6a7e8..ee3af81d1c3e 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -49,7 +49,7 @@ static ssize_t ima_show_htable_violations(struct file *filp,
>  					  char __user *buf,
>  					  size_t count, loff_t *ppos)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>  
>  	return ima_show_htable_value(buf, count, ppos,
>  				     &ns->ima_htable.violations);
> @@ -64,7 +64,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>  					   char __user *buf,
>  					   size_t count, loff_t *ppos)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>  
>  	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
>  }
> @@ -77,7 +77,7 @@ static const struct file_operations ima_measurements_count_ops = {
>  /* returns pointer to hlist_node */
>  static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(m->file);
>  	loff_t l = *pos;
>  	struct ima_queue_entry *qe;
>  
> @@ -95,7 +95,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>  
>  static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(m->file);
>  	struct ima_queue_entry *qe = v;
>  
>  	/* lock protects when reading beyond last element
> @@ -317,7 +317,7 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
>  static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  				size_t datalen, loff_t *ppos)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(file);
>  	char *data;
>  	ssize_t result;
>  
> @@ -379,7 +379,7 @@ static const struct seq_operations ima_policy_seqops = {
>  static int ima_open_policy(struct inode *inode, struct file *filp)
>  {
>  	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>  
>  	if (!(filp->f_flags & O_WRONLY)) {
>  #ifndef	CONFIG_IMA_READ_POLICY
> @@ -406,7 +406,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>   */
>  static int ima_release_policy(struct inode *inode, struct file *file)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns = ima_ns_from_file(file);
>  	const char *cause = ns->valid_policy ? "completed" : "failed";
>  
>  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
> @@ -459,12 +459,29 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  	struct dentry *ascii_runtime_measurements = NULL;
>  	struct dentry *runtime_measurements_count = NULL;
>  	struct dentry *violations = NULL;
> +	bool created_ns = false;
> +
> +	/*
> +	 * While multiple superblocks can exist they are keyed by userns in
> +	 * s_fs_info for securityfs. The first time a userns mounts a
> +	 * securityfs instance we lazily allocate the ima_namespace for the
> +	 * userns since that's the only way a userns can meaningfully use ima.
> +	 * The vfs ensures we're the only one to call fill_super() and hence
> +	 * ima_fs_ns_init(), so we don't need any memory barriers here, i.e.
> +	 * user_ns->ima_ns can't change while we're in here.
> +	 */
> +	if (!ns) {
> +		ns = create_ima_ns(user_ns);
> +		if (IS_ERR(ns))
> +			return PTR_ERR(ns);
> +		created_ns = true;
> +	}

Since create_ima_ns() initializes user_ns->ima_ns via
smp_store_release() the patch currently implies that concurrent access
to user_ns->ima_ns are safe once create_ima_ns() returns.

Specifically, it entails that no caller will access entries in the ima
namespace that will only be filled in past this point. Afaict, this only
relates to the ns->policy_dentry which can't be accessed until
securityfs is finished.

Nonetheless, I would recommend that you change create_ima_ns() to not
initialize user_ns->ima_ns and instead defer this until everything in
the namespace is setup. So maybe move the smp_store_release() to the end
of ima_fs_ns_init(). If ns->policy_dentry wouldn't be stashed in ima_ns
it wouldn't matter but since it is I would not publish ima_ns before
this is set. Sm like (uncompiled, untested):

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ee3af81d1c3e..64ca47671d31 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -531,6 +531,8 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
                        goto out;
        }

+       if (!user_ns->ima_ns)
+               smp_store_release(&user_ns->ima_ns, ns);
        return 0;
 out:
        securityfs_remove(ns->policy_dentry);

As a side-effect this will let you get rid of the bool created_ns and
thereby simplify the codeflow.

(Note, that obviously means that the changes I mentioned earlier in
https://lore.kernel.org/containers/20220114114321.7prnt72ukvch4wxa@wittgenstein
can't be made.)
