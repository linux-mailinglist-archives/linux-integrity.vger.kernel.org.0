Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC82946D2C2
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 12:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhLHL6m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhLHL6m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 06:58:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92192C061746;
        Wed,  8 Dec 2021 03:55:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90AC0CE2132;
        Wed,  8 Dec 2021 11:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762EFC00446;
        Wed,  8 Dec 2021 11:55:00 +0000 (UTC)
Date:   Wed, 8 Dec 2021 12:54:56 +0100
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
Message-ID: <20211208115456.nwhhdwub6zlcmzb3@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-2-stefanb@linux.ibm.com>
 <20211208112918.oxyyplwbpitytyfc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208112918.oxyyplwbpitytyfc@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 12:29:18PM +0100, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:12PM -0500, Stefan Berger wrote:
> > Implement an IMA namespace data structure that gets created alongside a
> > user namespace with CLONE_NEWUSER. This lays down the foundation for
> > namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> > IMA-appraisal).
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  include/linux/ima.h                      | 59 +++++++++++++++++
> >  include/linux/user_namespace.h           |  4 ++
> >  init/Kconfig                             | 10 +++
> >  kernel/user.c                            |  9 ++-
> >  kernel/user_namespace.c                  | 16 +++++
> >  security/integrity/ima/Makefile          |  3 +-
> >  security/integrity/ima/ima.h             |  4 ++
> >  security/integrity/ima/ima_init.c        |  4 ++
> >  security/integrity/ima/ima_init_ima_ns.c | 32 +++++++++
> >  security/integrity/ima/ima_ns.c          | 82 ++++++++++++++++++++++++
> >  10 files changed, 221 insertions(+), 2 deletions(-)
> >  create mode 100644 security/integrity/ima/ima_init_ima_ns.c
> >  create mode 100644 security/integrity/ima/ima_ns.c
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index b6ab66a546ae..86d126b9ff2f 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/security.h>
> >  #include <linux/kexec.h>
> > +#include <linux/user_namespace.h>
> >  #include <crypto/hash_info.h>
> >  struct linux_binprm;
> >  
> > @@ -210,6 +211,64 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
> >  }
> >  #endif /* CONFIG_IMA_APPRAISE */
> >  
> > +struct ima_namespace {
> > +	struct kref kref;
> > +	struct user_namespace *user_ns;
> > +};
> > +
> > +extern struct ima_namespace init_ima_ns;
> > +
> > +#ifdef CONFIG_IMA_NS
> > +
> > +void free_ima_ns(struct kref *kref);
> > +
> > +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> > +{
> > +	if (ns)
> > +		kref_get(&ns->kref);
> > +
> > +	return ns;
> > +}
> > +
> > +static inline void put_ima_ns(struct ima_namespace *ns)
> > +{
> > +	if (ns) {
> > +		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ns, kref_read(&ns->kref));
> > +		kref_put(&ns->kref, free_ima_ns);
> > +	}
> > +}
> > +
> > +struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
> > +				  struct user_namespace *user_ns);
> > +
> > +static inline struct ima_namespace *get_current_ns(void)
> > +{
> > +	return current_user_ns()->ima_ns;
> > +}
> > +
> > +#else
> > +
> > +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
> > +{
> > +	return ns;
> > +}
> > +
> > +static inline void put_ima_ns(struct ima_namespace *ns)
> > +{
> > +}
> > +
> > +static inline struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
> > +						struct user_namespace *user_ns)
> > +{
> > +	return old_ns;
> > +}
> > +
> > +static inline struct ima_namespace *get_current_ns(void)
> > +{
> > +	return &init_ima_ns;
> > +}
> > +#endif /* CONFIG_IMA_NS */
> > +
> >  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> >  extern bool ima_appraise_signature(enum kernel_read_file_id func);
> >  #else
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > index 33a4240e6a6f..5249db04d62b 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> >  #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
> >  
> >  struct ucounts;
> > +struct ima_namespace;
> >  
> >  enum ucount_type {
> >  	UCOUNT_USER_NAMESPACES,
> > @@ -99,6 +100,9 @@ struct user_namespace {
> >  #endif
> >  	struct ucounts		*ucounts;
> >  	long ucount_max[UCOUNT_COUNTS];
> > +#ifdef CONFIG_IMA
> > +	struct ima_namespace	*ima_ns;
> > +#endif
> >  } __randomize_layout;
> >  
> >  struct ucounts {
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 11f8a845f259..27890607e8cb 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1242,6 +1242,16 @@ config NET_NS
> >  	  Allow user space to create what appear to be multiple instances
> >  	  of the network stack.
> >  
> > +config IMA_NS
> > +	bool "IMA namespace"
> > +	depends on USER_NS
> > +	depends on IMA
> > +	default y
> > +	help
> > +	  Allow the creation of IMA namespaces for each user namespace.
> > +	  Namespaced IMA enables having IMA features work separately
> > +	  in each IMA namespace.
> > +
> >  endif # NAMESPACES
> >  
> >  config CHECKPOINT_RESTORE
> > diff --git a/kernel/user.c b/kernel/user.c
> > index e2cf8c22b539..b5dc803a033d 100644
> > --- a/kernel/user.c
> > +++ b/kernel/user.c
> > @@ -20,6 +20,10 @@
> >  #include <linux/user_namespace.h>
> >  #include <linux/proc_ns.h>
> >  
> > +#ifdef CONFIG_IMA
> > +extern struct ima_namespace init_ima_ns;
> > +#endif
> > +
> >  /*
> >   * userns count is 1 for root user, 1 for init_uts_ns,
> >   * and 1 for... ?
> > @@ -55,7 +59,7 @@ struct user_namespace init_user_ns = {
> >  			},
> >  		},
> >  	},
> > -	.ns.count = REFCOUNT_INIT(3),
> > +	.ns.count = REFCOUNT_INIT(4),
> >  	.owner = GLOBAL_ROOT_UID,
> >  	.group = GLOBAL_ROOT_GID,
> >  	.ns.inum = PROC_USER_INIT_INO,
> > @@ -67,6 +71,9 @@ struct user_namespace init_user_ns = {
> >  	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
> >  	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
> >  #endif
> > +#ifdef CONFIG_IMA
> > +	.ima_ns = &init_ima_ns,
> > +#endif
> >  };
> >  EXPORT_SYMBOL_GPL(init_user_ns);
> >  
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 6b2e3ca7ee99..c26885343b19 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/fs_struct.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/sort.h>
> > +#include <linux/ima.h>
> >  
> >  static struct kmem_cache *user_ns_cachep __read_mostly;
> >  static DEFINE_MUTEX(userns_state_mutex);
> > @@ -141,8 +142,20 @@ int create_user_ns(struct cred *new)
> >  	if (!setup_userns_sysctls(ns))
> >  		goto fail_keyring;
> >  
> > +#if CONFIG_IMA
> > +	ns->ima_ns = copy_ima_ns(parent_ns->ima_ns, ns);
> > +	if (IS_ERR(ns->ima_ns)) {
> > +		ret = PTR_ERR(ns->ima_ns);
> > +		goto fail_userns_sysctls;
> > +	}
> > +#endif
> > +
> >  	set_cred_user_ns(new, ns);
> >  	return 0;
> > +#if CONFIG_IMA
> > +fail_userns_sysctls:
> > +	retire_userns_sysctls(ns);
> > +#endif

If you rewrite copy_ima_ns() put_ima_ns() a little you can remove all
the ifdefs in here and make this patch tiny.

Make copy_ima_ns() return an int. Afaict, you can remove passing the
parent ima_ns completely but if you have to pass through the
parent_userns.
Then you can initialize new_userns->ima_ns inside of copy_ima_ns() and
the ifdef will only need to be visible inside copy_ima_ns() and not in
create_user_ns(). Similar put_ima_ns() is only called in a single place
namely kernel/user_namespace.c. Make it take a user_namespace argument
and you can remove the ifdef in __put_user_ns() for put_ima_ns() too.

So something -- COMPLETELY UNTESTED -- like the below should work:

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a8017272d78d..dc4aa3027bf4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -310,16 +310,17 @@ static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
 	return ns;
 }
 
-static inline void put_ima_ns(struct ima_namespace *ns)
+static inline void put_ima_ns(struct user_namespace *ns)
 {
-	if (ns) {
-		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ns, kref_read(&ns->kref));
-		kref_put(&ns->kref, free_ima_ns);
+	struct ima_namespace *ima_ns = ns->ima_ns;
+
+	if (im_ns) {
+		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", im_ns, kref_read(&im_ns->kref));
+		kref_put(&im_ns->kref, free_ima_ns);
 	}
 }
 
-struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
-				  struct user_namespace *user_ns);
+int copy_ima_ns(struct user_namespace *user_ns);
 
 static inline struct ima_namespace *get_current_ns(void)
 {
@@ -333,14 +334,13 @@ static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
 	return ns;
 }
 
-static inline void put_ima_ns(struct ima_namespace *ns)
+static inline void put_ima_ns(struct user_namespace *ns)
 {
 }
 
-static inline struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
-						struct user_namespace *user_ns)
+static inline int copy_ima_ns(struct user_namespace *user_ns)
 {
-	return old_ns;
+	return 0;
 }
 
 static inline struct ima_namespace *get_current_ns(void)
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index c26885343b19..794f027e7677 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -138,24 +138,19 @@ int create_user_ns(struct cred *new)
 	INIT_LIST_HEAD(&ns->keyring_name_list);
 	init_rwsem(&ns->keyring_sem);
 #endif
+
 	ret = -ENOMEM;
 	if (!setup_userns_sysctls(ns))
 		goto fail_keyring;
 
-#if CONFIG_IMA
-	ns->ima_ns = copy_ima_ns(parent_ns->ima_ns, ns);
-	if (IS_ERR(ns->ima_ns)) {
-		ret = PTR_ERR(ns->ima_ns);
-		goto fail_userns_sysctls;
-	}
-#endif
+	ret = create_ima_ns(ns);
+	if (ret)
+		goto fail_sysctls;
 
 	set_cred_user_ns(new, ns);
 	return 0;
-#if CONFIG_IMA
-fail_userns_sysctls:
+fail_sysctls:
 	retire_userns_sysctls(ns);
-#endif
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
@@ -209,9 +204,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
-#ifdef CONFIG_IMA
-		put_ima_ns(ns->ima_ns);
-#endif
+		put_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index debe863364fd..2bae2c0cdce1 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -21,14 +21,14 @@
 
 static struct kmem_cache *imans_cachep;
 
-static struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
+static int create_ima_ns(struct user_namespace *user_ns)
 {
 	struct ima_namespace *ns;
 	int err;
 
 	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
 	if (!ns)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	pr_debug("NEW     ima_ns: 0x%p\n", ns);
 
 	kref_init(&ns->kref);
@@ -44,12 +44,13 @@ static struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
 	INIT_LIST_HEAD(&ns->ima_keys);
 #endif
 
-	return ns;
+	user_ns->ima_ns = user_ns;
+	return 0;
 
 fail_free:
 	kmem_cache_free(imans_cachep, ns);
 
-	return ERR_PTR(err);
+	return err;
 }
 
 /**
@@ -58,8 +59,7 @@ static struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
  * @old_ns: old ima namespace to clone
  * @user_ns: User namespace
  */
-struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
-				  struct user_namespace *user_ns)
+int copy_ima_ns(struct user_namespace *user_ns)
 {
 	return create_ima_ns(user_ns);
 }
