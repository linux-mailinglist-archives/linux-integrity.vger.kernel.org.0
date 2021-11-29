Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65629460E43
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 06:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhK2FDx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 00:03:53 -0500
Received: from mail.hallyn.com ([178.63.66.53]:55408 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhK2FBx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 00:01:53 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 12406A17; Sun, 28 Nov 2021 22:58:35 -0600 (CST)
Date:   Sun, 28 Nov 2021 22:58:35 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Message-ID: <20211129045834.GB20606@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
> Currently we get one entry in the IMA log per unique file event.  So,
> if you have a measurement policy and it measures a particular binary
> it will not get measured again if it is subsequently executed. For
> Namespaced IMA, the correct behaviour seems to be to log once per
> inode per namespace (so every unique execution in a namespace gets a
> separate log entry).  Since logging once per inode per namespace is

I suspect I'll need to do a more in depth reading of the existing
code, but I'll ask the lazy question anyway (since you say "the
correct behavior seems to be") - is it actually important that
files which were appraised under a parent namespace's policy already
should be logged again?  Since you used the word "log" I'm assuming
this isn't building a running hash like a tpm pcr where skipping one
would invalidate rmeote attestation?

> different from current behaviour, it is only activated if the
> namespace appears in the log template (so there's no behaviour change
> for any of the original templates).
> 
> Expand the iint cache to have a list of namespaces, per iint entry,
> the inode has been seen in by moving the action flags and the
> measured_pcrs into a per-namespace structure.  The lifetime of these
> additional list entries is tied to the lifetime of the iint entry and
> the namespace, so if either is deleted, the new entry is.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/ima.h                       |  13 ++-
>  include/linux/user_namespace.h            |   5 +
>  kernel/user.c                             |   1 +
>  kernel/user_namespace.c                   |   6 ++
>  security/integrity/iint.c                 |   4 +-
>  security/integrity/ima/Makefile           |   2 +-
>  security/integrity/ima/ima.h              |  21 +++-
>  security/integrity/ima/ima_api.c          |   7 +-
>  security/integrity/ima/ima_main.c         |  21 ++--
>  security/integrity/ima/ima_ns.c           | 115 ++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c       |   2 +-
>  security/integrity/ima/ima_template_lib.c |   2 +
>  security/integrity/integrity.h            |  11 ++-
>  13 files changed, 192 insertions(+), 18 deletions(-)
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 09b14b73889e..dbbc0257d065 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -40,7 +40,8 @@ extern int ima_measure_critical_data(const char *event_label,
>  				     const char *event_name,
>  				     const void *buf, size_t buf_len,
>  				     bool hash, u8 *digest, size_t digest_len);
> -
> +extern void ima_init_user_ns(struct user_namespace *ns);
> +extern void ima_free_user_ns(struct user_namespace *ns);
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>  extern void ima_appraise_parse_cmdline(void);
>  #else
> @@ -154,6 +155,16 @@ static inline int ima_measure_critical_data(const char *event_label,
>  	return -ENOENT;
>  }
>  
> +static inline void ima_init_user_ns(struct user_namespace *ns)
> +{
> +	return;
> +}
> +
> +static inline void ima_free_user_ns(struct user_namespace *ns)
> +{
> +	return;
> +}
> +
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index d155788abdc1..52968764b195 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -8,6 +8,7 @@
>  #include <linux/sched.h>
>  #include <linux/workqueue.h>
>  #include <linux/rwsem.h>
> +#include <linux/rwlock.h>
>  #include <linux/sysctl.h>
>  #include <linux/err.h>
>  #include <linux/uuid.h>
> @@ -101,6 +102,10 @@ struct user_namespace {
>  	struct ucounts		*ucounts;
>  	long ucount_max[UCOUNT_COUNTS];
>  	uuid_t			uuid;
> +#ifdef CONFIG_IMA
> +	struct list_head	ima_inode_list;
> +	rwlock_t		ima_inode_list_lock;
> +#endif
>  } __randomize_layout;
>  
>  struct ucounts {
> diff --git a/kernel/user.c b/kernel/user.c
> index bf9ae1d0b670..670d3c41c817 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -68,6 +68,7 @@ struct user_namespace init_user_ns = {
>  	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
>  #endif
>  	/* .uuid is initialized in user_namespaces_init() */
> +	/* all IMA fields are initialized by ima_init_user_ns() */
>  };
>  EXPORT_SYMBOL_GPL(init_user_ns);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 8ce57c16ddd3..8afa5dc0b992 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/export.h>
> +#include <linux/ima.h>
>  #include <linux/nsproxy.h>
>  #include <linux/slab.h>
>  #include <linux/sched/signal.h>
> @@ -144,6 +145,9 @@ int create_user_ns(struct cred *new)
>  	uuid_gen(&ns->uuid);
>  
>  	set_cred_user_ns(new, ns);
> +
> +	ima_init_user_ns(ns);
> +
>  	return 0;
>  fail_keyring:
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
> @@ -200,6 +204,7 @@ static void free_user_ns(struct work_struct *work)
>  		}
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
> +		ima_free_user_ns(ns);
>  		ns_free_inum(&ns->ns);
>  		kmem_cache_free(user_ns_cachep, ns);
>  		dec_user_namespaces(ucounts);
> @@ -1389,6 +1394,7 @@ static __init int user_namespaces_init(void)
>  {
>  	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC | SLAB_ACCOUNT);
>  	uuid_gen(&init_user_ns.uuid);
> +	ima_init_user_ns(&init_user_ns);
>  	return 0;
>  }
>  subsys_initcall(user_namespaces_init);
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 8638976f7990..f714532feb7d 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -71,6 +71,7 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
>  static void iint_free(struct integrity_iint_cache *iint)
>  {
>  	kfree(iint->ima_hash);
> +	ima_ns_iint_list_free(iint);
>  	iint->ima_hash = NULL;
>  	iint->version = 0;
>  	iint->flags = 0UL;
> @@ -81,7 +82,7 @@ static void iint_free(struct integrity_iint_cache *iint)
>  	iint->ima_read_status = INTEGRITY_UNKNOWN;
>  	iint->ima_creds_status = INTEGRITY_UNKNOWN;
>  	iint->evm_status = INTEGRITY_UNKNOWN;
> -	iint->measured_pcrs = 0;
> +	INIT_LIST_HEAD(&iint->ns_list);
>  	kmem_cache_free(iint_cache, iint);
>  }
>  
> @@ -170,6 +171,7 @@ static void init_once(void *foo)
>  	iint->ima_creds_status = INTEGRITY_UNKNOWN;
>  	iint->evm_status = INTEGRITY_UNKNOWN;
>  	mutex_init(&iint->mutex);
> +	INIT_LIST_HEAD(&iint->ns_list);
>  }
>  
>  static int __init integrity_iintcache_init(void)
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 2499f2485c04..1741aa5d97bc 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -7,7 +7,7 @@
>  obj-$(CONFIG_IMA) += ima.o
>  
>  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> -	 ima_policy.o ima_template.o ima_template_lib.o
> +	 ima_policy.o ima_template.o ima_template_lib.o ima_ns.o
>  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>  ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index be965a8715e4..047256be7195 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -119,6 +119,16 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
>  
> +/* IMA cache of per-user-namespace flags */
> +struct ima_ns_cache {
> +	struct user_namespace *ns;
> +	struct integrity_iint_cache *iint;
> +	struct list_head ns_list;
> +	struct list_head iint_list;
> +	unsigned long measured_pcrs;
> +	unsigned long flags;
> +};
> +
>  extern const int read_idmap[];
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> @@ -263,7 +273,8 @@ int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
>  			    enum hash_algo algo, struct modsig *modsig);
> -void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
> +void ima_store_measurement(struct integrity_iint_cache *iint,
> +			   struct ima_ns_cache *nsc, struct file *file,
>  			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -301,6 +312,14 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
>  
> +/* IMA Namespace related functions */
> +extern bool ima_ns_in_template;
> +struct ima_ns_cache *ima_ns_cache_get(struct integrity_iint_cache *iint,
> +				      struct user_namespace *ns);
> +void ima_ns_cache_clear(struct integrity_iint_cache *iint);
> +void ima_init_ns(void);
> +
> +
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
>  #define IMA_APPRAISE_FIX	0x02
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index a64fb0130b01..d613ea1ee378 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -298,6 +298,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   * Must be called with iint->mutex held.
>   */
>  void ima_store_measurement(struct integrity_iint_cache *iint,
> +			   struct ima_ns_cache *nsc,
>  			   struct file *file, const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -322,7 +323,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  	 * appraisal, but a file measurement from earlier might already exist in
>  	 * the measurement list.
>  	 */
> -	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
> +	if (nsc->measured_pcrs & (0x1 << pcr) && !modsig)
>  		return;
>  
>  	result = ima_alloc_init_template(&event_data, &entry, template_desc);
> @@ -334,8 +335,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  
>  	result = ima_store_template(entry, violation, inode, filename, pcr);
>  	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
> -		iint->flags |= IMA_MEASURED;
> -		iint->measured_pcrs |= (0x1 << pcr);
> +		nsc->flags |= IMA_MEASURED;
> +		nsc->measured_pcrs |= (0x1 << pcr);
>  	}
>  	if (result < 0)
>  		ima_free_template_entry(entry);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 465865412100..049710203fac 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -168,8 +168,8 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>  		if (!IS_I_VERSION(inode) ||
>  		    !inode_eq_iversion(inode, iint->version) ||
>  		    (iint->flags & IMA_NEW_FILE)) {
> -			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> -			iint->measured_pcrs = 0;
> +			iint->flags &= ~IMA_NEW_FILE;
> +			ima_ns_cache_clear(iint);
>  			if (update)
>  				ima_update_xattr(iint, file);
>  		}
> @@ -204,6 +204,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> +	struct ima_ns_cache *nsc = NULL;
>  	struct ima_template_desc *template_desc = NULL;
>  	char *pathbuf = NULL;
>  	char filename[NAME_MAX];
> @@ -274,20 +275,20 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
>  	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
>  	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> -		iint->flags &= ~IMA_DONE_MASK;
> -		iint->measured_pcrs = 0;
> +		ima_ns_cache_clear(iint);
>  	}
> +	nsc = ima_ns_cache_get(iint, current_user_ns());
>  
>  	/* Determine if already appraised/measured based on bitmask
>  	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
>  	 *  IMA_AUDIT, IMA_AUDITED)
>  	 */
> -	iint->flags |= action;
> +	nsc->flags |= action;
>  	action &= IMA_DO_MASK;
> -	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
> +	action &= ~((nsc->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
>  
>  	/* If target pcr is already measured, unset IMA_MEASURE action */
> -	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
> +	if ((action & IMA_MEASURE) && (nsc->measured_pcrs & (0x1 << pcr)))
>  		action ^= IMA_MEASURE;
>  
>  	/* HASH sets the digital signature and update flags, nothing else */
> @@ -297,7 +298,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		if ((xattr_value && xattr_len > 2) &&
>  		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
>  			set_bit(IMA_DIGSIG, &iint->atomic_flags);
> -		iint->flags |= IMA_HASHED;
> +		nsc->flags |= IMA_HASHED;
>  		action ^= IMA_HASH;
>  		set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
>  	}
> @@ -342,7 +343,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
>  
>  	if (action & IMA_MEASURE)
> -		ima_store_measurement(iint, file, pathname,
> +		ima_store_measurement(iint, nsc, file, pathname,
>  				      xattr_value, xattr_len, modsig, pcr,
>  				      template_desc);
>  	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
> @@ -1047,6 +1048,8 @@ static int __init init_ima(void)
>  	if (error)
>  		return error;
>  
> +	ima_init_ns();
> +
>  	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
>  	if (error)
>  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
> new file mode 100644
> index 000000000000..7134ba7f3544
> --- /dev/null
> +++ b/security/integrity/ima/ima_ns.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * IMA Namespace Support routines
> + */
> +
> +#include <linux/ima.h>
> +#include <linux/user_namespace.h>
> +
> +#include "ima.h"
> +
> +static struct kmem_cache *ns_cache __read_mostly;
> +bool ima_ns_in_template __read_mostly;
> +
> +void __init ima_init_ns(void)
> +{
> +	ns_cache = KMEM_CACHE(ima_ns_cache, SLAB_PANIC);
> +}
> +
> +void ima_init_user_ns(struct user_namespace *ns)
> +{
> +	INIT_LIST_HEAD(&ns->ima_inode_list);
> +}
> +
> +void ima_free_user_ns(struct user_namespace *ns)
> +{
> +	struct ima_ns_cache *entry;
> +
> +	/* no refs to ns left, so no need to lock */
> +	while (!list_empty(&ns->ima_inode_list)) {
> +		entry = list_entry(ns->ima_inode_list.next, struct ima_ns_cache,
> +				   ns_list);
> +
> +		/* iint cache entry is still active to lock to delete */
> +		write_lock(&entry->iint->ns_list_lock);
> +		list_del(&entry->iint_list);
> +		write_unlock(&entry->iint->ns_list_lock);
> +
> +		list_del(&entry->ns_list);
> +		kmem_cache_free(ns_cache, entry);
> +	}
> +}
> +
> +struct ima_ns_cache *ima_ns_cache_get(struct integrity_iint_cache *iint,
> +				      struct user_namespace *ns)
> +{
> +	struct ima_ns_cache *entry = NULL;
> +
> +	if (!ima_ns_in_template)
> +		/*
> +		 * if we're not logging the namespace, don't separate the
> +		 * iint cache per namespace.  This preserves original
> +		 * behaviour for the non-ns case.
> +		 */
> +		ns = &init_user_ns;
> +
> +	read_lock(&iint->ns_list_lock);
> +	list_for_each_entry(entry, &iint->ns_list, ns_list)
> +		if (entry->ns == ns)
> +			break;
> +	read_unlock(&iint->ns_list_lock);
> +
> +	if (entry && entry->ns == ns)
> +		return entry;
> +
> +	entry = kmem_cache_zalloc(ns_cache, GFP_NOFS);
> +	if (!entry)
> +		return NULL;
> +
> +	/* no refs taken: entry is freed on either ns delete or iint delete */
> +	entry->ns = ns;
> +	entry->iint = iint;
> +
> +	write_lock(&iint->ns_list_lock);
> +	list_add_tail(&entry->iint_list, &iint->ns_list);
> +	write_unlock(&iint->ns_list_lock);
> +
> +	write_lock(&ns->ima_inode_list_lock);
> +	list_add_tail(&entry->ns_list, &ns->ima_inode_list);
> +	write_unlock(&ns->ima_inode_list_lock);
> +
> +	return entry;
> +}
> +
> +/* clear the flags and measured PCR for every entry in the iint  */
> +void ima_ns_cache_clear(struct integrity_iint_cache *iint)
> +{
> +	struct ima_ns_cache *entry;
> +
> +	read_lock(&iint->ns_list_lock);
> +	list_for_each_entry(entry, &iint->ns_list, ns_list) {
> +		entry->flags = 0;
> +		entry->measured_pcrs = 0;
> +	}
> +	read_unlock(&iint->ns_list_lock);
> +}
> +
> +void ima_ns_iint_list_free(struct integrity_iint_cache *iint)
> +{
> +	struct ima_ns_cache *entry;
> +
> +	/* iint locking unnecessary; no-one should have acces to the list */
> +	while (!list_empty(&iint->ns_list)) {
> +		entry = list_entry(iint->ns_list.next, struct ima_ns_cache,
> +				   iint_list);
> +
> +		/* namespace is still active to lock to delete */
> +		write_lock(&entry->ns->ima_inode_list_lock);
> +		list_del(&entry->ns_list);
> +		write_unlock(&entry->ns->ima_inode_list_lock);
> +
> +		list_del(&entry->iint_list);
> +		kmem_cache_free(ns_cache, entry);
> +	}
> +}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 320ca80aacab..9434a1064da6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -50,7 +50,7 @@
>  #define DONT_HASH	0x0200
>  
>  #define INVALID_PCR(a) (((a) < 0) || \
> -	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
> +	(a) >= (sizeof_field(struct ima_ns_cache, measured_pcrs) * 8))
>  
>  int ima_policy_flag;
>  static int temp_ima_appraise;
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index ebd54c1b5206..d1a381add127 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -703,6 +703,8 @@ int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
>  int ima_ns_init(struct ima_event_data *event_data,
>  		struct ima_field_data *field_data)
>  {
> +	if (unlikely(!ima_ns_in_template))
> +		ima_ns_in_template = true;
>  	return ima_write_template_field_data(&current_user_ns()->uuid,
>  					     UUID_SIZE, DATA_FMT_UUID,
>  					     field_data);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..8755635da3ff 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -129,7 +129,6 @@ struct integrity_iint_cache {
>  	struct inode *inode;	/* back pointer to inode in question */
>  	u64 version;		/* track inode changes */
>  	unsigned long flags;
> -	unsigned long measured_pcrs;
>  	unsigned long atomic_flags;
>  	enum integrity_status ima_file_status:4;
>  	enum integrity_status ima_mmap_status:4;
> @@ -138,6 +137,8 @@ struct integrity_iint_cache {
>  	enum integrity_status ima_creds_status:4;
>  	enum integrity_status evm_status:4;
>  	struct ima_digest_data *ima_hash;
> +	struct list_head ns_list; /* list of namespaces inode seen in */
> +	rwlock_t ns_list_lock;
>  };
>  
>  /* rbtree tree calls to lookup, insert, delete
> @@ -225,6 +226,14 @@ static inline void ima_load_x509(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_IMA
> +void ima_ns_iint_list_free(struct integrity_iint_cache *iint);
> +#else
> +void ima_ns_iint_list_free(struct integrity_iint_cache *iint)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_EVM_LOAD_X509
>  void __init evm_load_x509(void);
>  #else
> -- 
> 2.33.0
