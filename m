Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA7537332
	for <lists+linux-integrity@lfdr.de>; Mon, 30 May 2022 03:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiE3BHQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 May 2022 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiE3BHP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 May 2022 21:07:15 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE549F34;
        Sun, 29 May 2022 18:07:12 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7F00B66E; Sun, 29 May 2022 20:07:10 -0500 (CDT)
Date:   Sun, 29 May 2022 20:07:10 -0500
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
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 16/26] ima: Add functions for creating and freeing of
 an ima_namespace
Message-ID: <20220530010710.GA7790@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-17-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-17-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:23AM -0400, Stefan Berger wrote:
> Implement create_ima_ns() to create an empty ima_namespace. Defer its
> initialization to a later point outside this function. Implement
> free_ima_ns() to free it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> 
> ---
> v9:
>  - Set user_ns->ims_ns = NULL in free_ima_ns()
>  - Refactored create_ima_ns() to defer initialization
>  - Removed pr_debug functions
> ---
>  include/linux/ima.h                      | 13 ++++++
>  security/integrity/ima/Makefile          |  1 +
>  security/integrity/ima/ima.h             | 15 +++++++
>  security/integrity/ima/ima_init_ima_ns.c |  2 +-
>  security/integrity/ima/ima_ns.c          | 53 ++++++++++++++++++++++++
>  5 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index fcb60a44e05f..76d19995ab89 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -220,4 +220,17 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
>  	return false;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct user_namespace *ns);
> +
> +#else
> +
> +static inline void free_ima_ns(struct user_namespace *user_ns)
> +{
> +}
> +
> +#endif /* CONFIG_IMA_NS */
> +
>  #endif /* _LINUX_IMA_H */
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index f8a5e5f3975d..b86a35fbed60 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_IMA_NS) += ima_ns.o
>  
>  ifeq ($(CONFIG_EFI),y)
>  ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 054b8f67be04..3e77738aec2c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -171,6 +171,7 @@ extern bool ima_canonical_fmt;
>  int ima_init(void);
>  int ima_fs_init(void);
>  int ima_ns_init(void);
> +int ima_init_namespace(struct ima_namespace *ns);
>  int ima_add_template_entry(struct ima_namespace *ns,
>  			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> @@ -506,4 +507,18 @@ static inline struct ima_namespace
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_IMA_NS
> +
> +struct ima_namespace *create_ima_ns(void);
> +
> +#else
> +
> +static inline struct ima_namespace *create_ima_ns(void)
> +{
> +	WARN(1, "Cannot create an IMA namespace\n");
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +#endif /* CONFIG_IMA_NS */
> +
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index c4fe8f3e9a73..b497062090cf 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -8,7 +8,7 @@
>  
>  #include "ima.h"
>  
> -static int ima_init_namespace(struct ima_namespace *ns)
> +int ima_init_namespace(struct ima_namespace *ns)
>  {
>  	int ret;
>  
> diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
> new file mode 100644
> index 000000000000..b3b81a1e313e
> --- /dev/null
> +++ b/security/integrity/ima/ima_ns.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016-2021 IBM Corporation
> + * Author:
> + *  Yuqiong Sun <suny@us.ibm.com>
> + *  Stefan Berger <stefanb@linux.vnet.ibm.com>
> + */
> +
> +#include <linux/ima.h>
> +
> +#include "ima.h"
> +
> +static struct kmem_cache *imans_cachep;
> +
> +struct ima_namespace *create_ima_ns(void)
> +{
> +	struct ima_namespace *ns;
> +
> +	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
> +	if (!ns)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return ns;
> +}
> +
> +/* destroy_ima_ns() must only be called after ima_init_namespace() was called */
> +static void destroy_ima_ns(struct ima_namespace *ns)
> +{
> +	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
> +	kfree(ns->arch_policy_entry);
> +	ima_free_policy_rules(ns);
> +}
> +
> +void free_ima_ns(struct user_namespace *user_ns)
> +{
> +	struct ima_namespace *ns = user_ns->ima_ns;
> +
> +	if (!ns || WARN_ON(ns == &init_ima_ns))
> +		return;
> +
> +	destroy_ima_ns(ns);
> +
> +	kmem_cache_free(imans_cachep, ns);
> +
> +	user_ns->ima_ns = NULL;
> +}
> +
> +static int __init imans_cache_init(void)
> +{
> +	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
> +	return 0;
> +}
> +subsys_initcall(imans_cache_init)
> -- 
> 2.34.1
> 
