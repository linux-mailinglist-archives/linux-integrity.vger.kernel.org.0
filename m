Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C324773F2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 15:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhLPOIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 09:08:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49704 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbhLPOIT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 09:08:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3044B8241A;
        Thu, 16 Dec 2021 14:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88048C36AE4;
        Thu, 16 Dec 2021 14:08:10 +0000 (UTC)
Date:   Thu, 16 Dec 2021 15:08:06 +0100
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
Subject: Re: [PATCH v7 01/14] ima: Add IMA namespace support
Message-ID: <20211216140806.hi4jxw54yvbu5cox@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-2-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 12:43:10AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement an IMA namespace data structure that gets created alongside a
> user namespace with CLONE_NEWUSER. This lays down the foundation for
> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> IMA-appraisal).
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/ima.h                      | 33 ++++++++++++
>  include/linux/user_namespace.h           |  4 ++
>  init/Kconfig                             | 10 ++++
>  kernel/user.c                            |  7 +++
>  kernel/user_namespace.c                  |  8 +++
>  security/integrity/ima/Makefile          |  3 +-
>  security/integrity/ima/ima.h             |  8 +++
>  security/integrity/ima/ima_init.c        |  4 ++
>  security/integrity/ima/ima_init_ima_ns.c | 28 ++++++++++
>  security/integrity/ima/ima_ns.c          | 65 ++++++++++++++++++++++++
>  10 files changed, 169 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/ima/ima_init_ima_ns.c
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b6ab66a546ae..61461ee5b208 100644
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
> @@ -210,6 +211,38 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
>  
> +extern struct ima_namespace init_ima_ns;
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct user_namespace *ns);
> +int create_ima_ns(struct user_namespace *user_ns);
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return current_user_ns()->ima_ns;
> +}
> +
> +#else
> +
> +static inline void free_ima_ns(struct user_namespace *user_ns)
> +{
> +}
> +
> +static inline int create_ima_ns(struct user_namespace *user_ns)
> +{
> +#ifdef CONFIG_IMA
> +	user_ns->ima_ns = &init_ima_ns;
> +#endif
> +	return 0;
> +}
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return &init_ima_ns;
> +}
> +#endif /* CONFIG_IMA_NS */
> +
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
>  extern bool ima_appraise_signature(enum kernel_read_file_id func);
>  #else
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 33a4240e6a6f..5249db04d62b 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>  #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
>  
>  struct ucounts;
> +struct ima_namespace;
>  
>  enum ucount_type {
>  	UCOUNT_USER_NAMESPACES,
> @@ -99,6 +100,9 @@ struct user_namespace {
>  #endif
>  	struct ucounts		*ucounts;
>  	long ucount_max[UCOUNT_COUNTS];
> +#ifdef CONFIG_IMA
> +	struct ima_namespace	*ima_ns;
> +#endif
>  } __randomize_layout;
>  
>  struct ucounts {
> diff --git a/init/Kconfig b/init/Kconfig
> index 11f8a845f259..27890607e8cb 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1242,6 +1242,16 @@ config NET_NS
>  	  Allow user space to create what appear to be multiple instances
>  	  of the network stack.
>  
> +config IMA_NS
> +	bool "IMA namespace"
> +	depends on USER_NS
> +	depends on IMA
> +	default y
> +	help
> +	  Allow the creation of IMA namespaces for each user namespace.
> +	  Namespaced IMA enables having IMA features work separately
> +	  in each IMA namespace.
> +
>  endif # NAMESPACES
>  
>  config CHECKPOINT_RESTORE
> diff --git a/kernel/user.c b/kernel/user.c
> index e2cf8c22b539..287751d89b44 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -20,6 +20,10 @@
>  #include <linux/user_namespace.h>
>  #include <linux/proc_ns.h>
>  
> +#ifdef CONFIG_IMA
> +extern struct ima_namespace init_ima_ns;
> +#endif
> +
>  /*
>   * userns count is 1 for root user, 1 for init_uts_ns,
>   * and 1 for... ?
> @@ -67,6 +71,9 @@ struct user_namespace init_user_ns = {
>  	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
>  	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
>  #endif
> +#ifdef CONFIG_IMA
> +	.ima_ns = &init_ima_ns,
> +#endif
>  };
>  EXPORT_SYMBOL_GPL(init_user_ns);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b2e3ca7ee99..6fa01323aac9 100644
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
> @@ -141,8 +142,14 @@ int create_user_ns(struct cred *new)
>  	if (!setup_userns_sysctls(ns))
>  		goto fail_keyring;
>  
> +	ret = create_ima_ns(ns);

Instead of greedily allocating a new ima namespace for each new user
namespace creation and wasting memory that is likely wasted since most
containers won't use ima (for a long time at least) have you considered
lazily allocating it like I suggested in one of my first reviews?

So under the assumption that the only way for a container to get its own
ima policy it needs to have mounted a new securityfs instance you can
move the ima namespace allocation into fill_super/ima_fs_ns_init():

From 46fd4f19e1360bee167fccb11e793a3a3331ccc2 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 16 Dec 2021 14:57:30 +0100
Subject: [PATCH] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!

Lazily initialize ima_ns. This avoids pointlessly wasting memory that is never
needed or used which I think will be the case for most containers.
---
 include/linux/ima.h               |  2 +-
 kernel/user_namespace.c           |  6 ------
 security/integrity/ima/ima_fs.c   | 20 ++++++++++++++++++--
 security/integrity/ima/ima_main.c |  5 ++++-
 security/integrity/ima/ima_ns.c   |  7 ++++++-
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a2705aa5242a..cb1b94df11a1 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -230,7 +230,7 @@ int create_ima_ns(struct user_namespace *user_ns);
 
 static inline struct ima_namespace *get_current_ns(void)
 {
-	return current_user_ns()->ima_ns;
+	return smp_load_acquire(&current_user_ns()->ima_ns);
 }
 
 static inline int ima_securityfs_init(struct user_namespace *user_ns,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6fa01323aac9..653f8fa83b69 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -142,14 +142,8 @@ int create_user_ns(struct cred *new)
 	if (!setup_userns_sysctls(ns))
 		goto fail_keyring;
 
-	ret = create_ima_ns(ns);
-	if (ret)
-		goto fail_sysctls;
-
 	set_cred_user_ns(new, ns);
 	return 0;
-fail_sysctls:
-	retire_userns_sysctls(ns);
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3b8001ba62e3..971620a22dab 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -378,7 +378,7 @@ static const struct seq_operations ima_policy_seqops = {
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
 	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
-	struct ima_namespace *ns = user_ns->ima_ns;
+	struct ima_namespace *ns = user_ns->ima_ns; /* no need to use acquire semantics it's guaranteed to be initialized */
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -450,7 +450,8 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
+	int ret;
+	struct ima_namespace *ns = user_ns->ima_ns; /* no need to use acquire semantics it's guaranteed to be initialized */
 	struct dentry *int_dir;
 	struct dentry *ima_dir = NULL;
 	struct dentry *ima_symlink = NULL;
@@ -459,6 +460,21 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 
+	/*
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for securityfs. The first time a userns mounts a
+	 * securityfs instance we lazily allocate the ima_namespace for the
+	 * userns since that's the only way a userns can meaningfully use ima.
+	 * The vfs ensure we're the only one to call fill_super() and hence
+	 * ima_fs_ns_init() so we don't need any memory barriers here, i.e.
+	 * user_ns->ima_ns can't change while we're in here.
+	 */
+	if (!ns) {
+		ret =  create_ima_ns(user_ns);
+		if (ret)
+			return ret;
+	}
+
 	/* FIXME: update when evm and integrity are namespaced */
 	if (user_ns != &init_user_ns) {
 		int_dir =
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4c85a8df3c86..a0e71416561d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -414,7 +414,10 @@ static int process_measurement(struct ima_namespace *ns,
 	int ret = 0;
 
 	while (user_ns) {
-		ns = user_ns->ima_ns;
+		/* the container has not loaded a separate policy (yet) */
+		ns = smp_load_acquire(&user_ns->ima_ns);
+		if (!ns)
+			continue;
 
 		ret = __process_measurement(ns, file, cred, secid, buf, size,
 					    mask, func);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index d192a80c927f..5c7177b07344 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -31,7 +31,8 @@ int create_ima_ns(struct user_namespace *user_ns)
 	if (err)
 		goto fail_free;
 
-	user_ns->ima_ns = ns;
+	/* Pairs with smp_load_acquire() in get_current_ns() and process_measurement(). */
+	smp_store_release(&user_ns->ima_ns, ns);
 
 	return 0;
 
@@ -52,6 +53,10 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 
 void free_ima_ns(struct user_namespace *user_ns)
 {
+	/* No need to use acquire semantics as the userns can't be reached
+	 * anymore from userspace so either ima_ns has been initialized or it
+	 * never has.
+	 */
 	struct ima_namespace *ns = user_ns->ima_ns;
 
 	if (WARN_ON(ns == &init_ima_ns))
-- 
2.30.2

