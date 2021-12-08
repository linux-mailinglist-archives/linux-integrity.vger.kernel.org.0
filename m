Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8046D231
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 12:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLHLdD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhLHLdD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 06:33:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE12C061746;
        Wed,  8 Dec 2021 03:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 020D0B82015;
        Wed,  8 Dec 2021 11:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68056C00446;
        Wed,  8 Dec 2021 11:29:22 +0000 (UTC)
Date:   Wed, 8 Dec 2021 12:29:18 +0100
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
Subject: Re: [PATCH v4 01/16] ima: Add IMA namespace support
Message-ID: <20211208112918.oxyyplwbpitytyfc@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207202127.1508689-2-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 03:21:12PM -0500, Stefan Berger wrote:
> Implement an IMA namespace data structure that gets created alongside a
> user namespace with CLONE_NEWUSER. This lays down the foundation for
> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> IMA-appraisal).
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/ima.h                      | 59 +++++++++++++++++
>  include/linux/user_namespace.h           |  4 ++
>  init/Kconfig                             | 10 +++
>  kernel/user.c                            |  9 ++-
>  kernel/user_namespace.c                  | 16 +++++
>  security/integrity/ima/Makefile          |  3 +-
>  security/integrity/ima/ima.h             |  4 ++
>  security/integrity/ima/ima_init.c        |  4 ++
>  security/integrity/ima/ima_init_ima_ns.c | 32 +++++++++
>  security/integrity/ima/ima_ns.c          | 82 ++++++++++++++++++++++++
>  10 files changed, 221 insertions(+), 2 deletions(-)
>  create mode 100644 security/integrity/ima/ima_init_ima_ns.c
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b6ab66a546ae..86d126b9ff2f 100644
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
> @@ -210,6 +211,64 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
>  
> +struct ima_namespace {
> +	struct kref kref;
> +	struct user_namespace *user_ns;
> +};
> +
> +extern struct ima_namespace init_ima_ns;
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct kref *kref);
> +
> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> +{
> +	if (ns)
> +		kref_get(&ns->kref);
> +
> +	return ns;
> +}
> +
> +static inline void put_ima_ns(struct ima_namespace *ns)
> +{
> +	if (ns) {
> +		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ns, kref_read(&ns->kref));
> +		kref_put(&ns->kref, free_ima_ns);
> +	}
> +}
> +
> +struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
> +				  struct user_namespace *user_ns);
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return current_user_ns()->ima_ns;
> +}
> +
> +#else
> +
> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> +{
> +	return ns;
> +}
> +
> +static inline void put_ima_ns(struct ima_namespace *ns)
> +{
> +}
> +
> +static inline struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
> +						struct user_namespace *user_ns)
> +{
> +	return old_ns;
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
> index e2cf8c22b539..b5dc803a033d 100644
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
> @@ -55,7 +59,7 @@ struct user_namespace init_user_ns = {
>  			},
>  		},
>  	},
> -	.ns.count = REFCOUNT_INIT(3),
> +	.ns.count = REFCOUNT_INIT(4),
>  	.owner = GLOBAL_ROOT_UID,
>  	.group = GLOBAL_ROOT_GID,
>  	.ns.inum = PROC_USER_INIT_INO,
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
> index 6b2e3ca7ee99..c26885343b19 100644
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
> @@ -141,8 +142,20 @@ int create_user_ns(struct cred *new)
>  	if (!setup_userns_sysctls(ns))
>  		goto fail_keyring;
>  
> +#if CONFIG_IMA
> +	ns->ima_ns = copy_ima_ns(parent_ns->ima_ns, ns);
> +	if (IS_ERR(ns->ima_ns)) {
> +		ret = PTR_ERR(ns->ima_ns);
> +		goto fail_userns_sysctls;
> +	}
> +#endif
> +
>  	set_cred_user_ns(new, ns);
>  	return 0;
> +#if CONFIG_IMA
> +fail_userns_sysctls:
> +	retire_userns_sysctls(ns);
> +#endif
>  fail_keyring:
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  	key_put(ns->persistent_keyring_register);
> @@ -196,6 +209,9 @@ static void free_user_ns(struct work_struct *work)
>  			kfree(ns->projid_map.forward);
>  			kfree(ns->projid_map.reverse);
>  		}
> +#ifdef CONFIG_IMA
> +		put_ima_ns(ns->ima_ns);
> +#endif
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
>  		ns_free_inum(&ns->ns);
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 2499f2485c04..b86a35fbed60 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -7,13 +7,14 @@
>  obj-$(CONFIG_IMA) += ima.o
>  
>  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> -	 ima_policy.o ima_template.o ima_template_lib.o
> +	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
>  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>  ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_IMA_NS) += ima_ns.o
>  
>  ifeq ($(CONFIG_EFI),y)
>  ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index be965a8715e4..2f8adf383054 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -418,6 +418,10 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  }
>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>  
> +int ima_ns_init(void);
> +struct ima_namespace;
> +int ima_init_namespace(struct ima_namespace *ns);
> +
>  /* LSM based policy rules require audit */
>  #ifdef CONFIG_IMA_LSM_RULES
>  
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index b26fa67476b4..f6ae4557a0da 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -120,6 +120,10 @@ int __init ima_init(void)
>  {
>  	int rc;
>  
> +	rc = ima_ns_init();
> +	if (rc)
> +		return rc;
> +
>  	ima_tpm_chip = tpm_default_chip();
>  	if (!ima_tpm_chip)
>  		pr_info("No TPM chip found, activating TPM-bypass!\n");
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> new file mode 100644
> index 000000000000..12723d77fe17
> --- /dev/null
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016-2018 IBM Corporation
> + * Author:
> + *   Yuqiong Sun <suny@us.ibm.com>
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/user_namespace.h>
> +#include <linux/ima.h>
> +#include <linux/proc_ns.h>
> +
> +int ima_init_namespace(struct ima_namespace *ns)
> +{
> +	return 0;
> +}
> +
> +int __init ima_ns_init(void)
> +{
> +	return ima_init_namespace(&init_ima_ns);
> +}
> +
> +struct ima_namespace init_ima_ns = {
> +	.kref = KREF_INIT(1),
> +	.user_ns = &init_user_ns,
> +};
> +EXPORT_SYMBOL(init_ima_ns);
> diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
> new file mode 100644
> index 000000000000..9a782c08c34e
> --- /dev/null
> +++ b/security/integrity/ima/ima_ns.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016-2018 IBM Corporation
> + * Author:
> + *  Yuqiong Sun <suny@us.ibm.com>
> + *  Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <linux/ima.h>
> +#include <linux/mount.h>
> +#include <linux/proc_ns.h>
> +#include <linux/lsm_hooks.h>
> +
> +#include "ima.h"
> +
> +static struct kmem_cache *imans_cachep;
> +
> +static struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
> +{
> +	struct ima_namespace *ns;
> +	int err;
> +
> +	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
> +	if (!ns)
> +		return ERR_PTR(-ENOMEM);
> +	pr_debug("NEW     ima_ns: 0x%p\n", ns);
> +
> +	kref_init(&ns->kref);
> +	ns->user_ns = user_ns;
> +
> +	err = ima_init_namespace(ns);
> +	if (err)
> +		goto fail_free;
> +
> +	return ns;
> +
> +fail_free:
> +	kmem_cache_free(imans_cachep, ns);
> +
> +	return ERR_PTR(err);
> +}
> +
> +/**
> + * Copy an ima namespace - create a new one
> + *
> + * @old_ns: old ima namespace to clone
> + * @user_ns: User namespace
> + */
> +struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
> +				  struct user_namespace *user_ns)
> +{
> +	return create_ima_ns(user_ns);
> +}

I'd just remove copy_ima_ns() completely and just leave create_ima_ns()
if it's not used anywhere.

> +
> +static void destroy_ima_ns(struct ima_namespace *ns)
> +{
> +	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
> +	kmem_cache_free(imans_cachep, ns);
> +}
> +
> +void free_ima_ns(struct kref *kref)
> +{
> +	struct ima_namespace *ns;
> +
> +	ns = container_of(kref, struct ima_namespace, kref);
> +	BUG_ON(ns == &init_ima_ns);

I'd not do that. Either

	if (ns != &init_ima_ns)
		destroy_ima_ns(ns);

so it can be safely called on init_ima_ns or

if (WARN_ON(ns == &init_ima_ns))
	return;

> +
> +	destroy_ima_ns(ns);
> +}
> +
> +static int __init imans_cache_init(void)
> +{
> +	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
> +	return 0;
> +}
> +subsys_initcall(imans_cache_init)
> -- 
> 2.31.1
> 
> 
