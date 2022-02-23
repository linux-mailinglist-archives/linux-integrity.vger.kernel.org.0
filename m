Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96064C1A58
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiBWR7Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiBWR7Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 12:59:24 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 09:58:55 PST
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6323CA6A;
        Wed, 23 Feb 2022 09:58:55 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 65D2BA1C; Wed, 23 Feb 2022 11:58:54 -0600 (CST)
Date:   Wed, 23 Feb 2022 11:58:54 -0600
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
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v10 27/27] ima: Enable IMA namespaces
Message-ID: <20220223175854.GB10272@mail.hallyn.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-28-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201203735.164593-28-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 01, 2022 at 03:37:35PM -0500, Stefan Berger wrote:
> Introduce the IMA_NS in Kconfig for IMA namespace enablement.
> 
> Enable the lazy initialization of an IMA namespace when a user mounts
> SecurityFS and writes '1' into IMA's 'active' securityfs file. A
> user_namespace will now get a pointer to an ima_namespace and therefore
> implement get_current_ns() for the namespacing case that returns this
> pointer. Use get_current_ns() in those places that require access to the
> current IMA namespace. In some places, primarily those related to
> IMA-appraisal and changes to file attributes, keep the pointer to
> init_ima_ns, since there flags related to file measurements may be
> affected, which are not supported in IMA namespaces, yet.
> 
> Before using the ima_namespace pointer test it with ns_is_active()
> to check whether it is NULL and whether the ima_namespace is active.
> If it's not active, it cannot be used, yet. Therefore, return early
> from those functions that may now get either get a NULL pointer from
> this call or where ns->active is still 0. The init_ima_ns is always
> set to be active, thus passing the check.
> 
> Implement ima_ns_from_file() for SecurityFS-related files where we can
> now get the IMA namespace via the user namespace pointer associated
> with the superblock of the SecurityFS filesystem instance.
> 
> Return -EACCES to IMA's securityfs files, except for the 'active' file,
> until the IMA namespace has been set to active.
> 
> Switch access to userns->ima_ns to use acquire/release semantics to ensure
> that a newly created ima_namespace structure is fully visible upon access.
> 
> Only emit the kernel log message 'policy update completed' for the
> init_ima_ns.
> 
> When parsing an IMA policy rule use the user namespace of the opener
> to translate uid and gid values to kernel values rather than the user
> namespace of the writer.
> 
> Gate access to ima_appraise variable to init_ima_ns in ima_load_data()
> and ima_write_policy().
> 
> Gate access to temp_ima_appraise variable to init_ima_ns in
> ima_delete_rules().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v10:
>  - dropped ima_ns_to_user_ns(); using current_user_ns() instead
>  - Pass user_namespace of file opener into ima_parse_rule and propagate
>    this parameter back all the way to the initial caller in the chain
>  - Gate access to ima_appraise to init_ima_ns in ima_write_policy()
> 
> v9:
>  - ima_post_key_create_or_update: Only handle key if in init_ima_ns
>  - Removed ns == NULL checks where user_namespace is now passed
>  - Defer setting of user_ns->ima_ns until end of ima_fs_ns_init();
>    required new ima_free_imans() and new user_ns_set_ima_ns()
>  - Only emit log message 'policy update completed' for init_ima_ns
>  - Introduce get_current_ns() only in this patch
>  - Check for ns == &init_ima_ns in ima_load_data()
> ---
>  include/linux/ima.h                          |  1 +
>  init/Kconfig                                 | 13 +++
>  kernel/user_namespace.c                      |  2 +
>  security/integrity/ima/ima.h                 | 55 +++++++++++--
>  security/integrity/ima/ima_appraise.c        |  3 +
>  security/integrity/ima/ima_asymmetric_keys.c |  6 +-
>  security/integrity/ima/ima_fs.c              | 87 ++++++++++++++++----
>  security/integrity/ima/ima_init.c            |  2 +-
>  security/integrity/ima/ima_init_ima_ns.c     |  2 +
>  security/integrity/ima/ima_main.c            | 34 +++++---
>  security/integrity/ima/ima_ns.c              | 15 +++-
>  security/integrity/ima/ima_policy.c          | 43 ++++++----
>  12 files changed, 202 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index c584527c0f47..a8cb2c269f61 100644
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
> index 05e2de7697da..73df1d8a2ece 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -337,10 +337,10 @@ int ima_match_policy(struct ima_namespace *ns,
>  		     int mask, int flags, int *pcr,
>  		     struct ima_template_desc **template_desc,
>  		     const char *func_data, unsigned int *allowed_algos);
> -void ima_init_policy(struct ima_namespace *ns);
> +void ima_init_policy(struct user_namespace *user_ns);
>  void ima_update_policy(struct ima_namespace *ns);
>  void ima_update_policy_flags(struct ima_namespace *ns);
> -ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
> +ssize_t ima_parse_add_rule(struct user_namespace *user_ns, char *rule);
>  void ima_delete_rules(struct ima_namespace *ns);
>  int ima_check_policy(struct ima_namespace *ns);
>  void ima_free_policy_rules(struct ima_namespace *ns);
> @@ -538,32 +538,70 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
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
> +	/* Pairs with smp_store_releases() in user_ns_set_ima_ns(). */
> +	return smp_load_acquire(&user_ns->ima_ns);
>  }
>  
> -#ifdef CONFIG_IMA_NS
> +static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
> +				      struct ima_namespace *ns)
> +{
> +	/* Pairs with smp_load_acquire() in ima_ns_from_user_ns() */
> +	smp_store_release(&user_ns->ima_ns, ns);
> +}
> +
> +static inline struct ima_namespace *get_current_ns(void)
> +{
> +	return ima_ns_from_user_ns(current_user_ns());
> +}
>  
>  struct ima_namespace *create_ima_ns(void);
>  
> +void ima_free_ima_ns(struct ima_namespace *ns);
> +
>  struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>  				    struct inode *inode,
>  				    struct integrity_iint_cache *iint);
>  
>  void ima_free_ns_status_tree(struct ima_namespace *ns);
>  
> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
> +{

Why is it ok here to dereference userns->ima_ns without
going through ima_ns_from_user_ns() to do the smp_load_acquire()?

> +	return ima_user_ns_from_file(filp)->ima_ns;
> +}
> +
>  #else

-serge
