Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABC46E8D8
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhLINPJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 08:15:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53094 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhLINPJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 08:15:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B01BB8243C;
        Thu,  9 Dec 2021 13:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C828C004DD;
        Thu,  9 Dec 2021 13:11:27 +0000 (UTC)
Date:   Thu, 9 Dec 2021 14:11:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 04/16] ima: Move delayed work queue and variables into
 ima_namespace
Message-ID: <20211209131122.ur4ngp6vi5g6oayc@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208221818.1519628-5-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 05:18:06PM -0500, Stefan Berger wrote:
> Move the delayed work queue and associated variables to the
> ima_namespace and initialize them.
> 
> Since keys queued up for measurement currently are only relevant in the
> init_ima_ns, call ima_init_key_queue() only when the init_ima_ns is
> initialized.
> 
> Protect the ima_namespace when scheduling the delayed work by taking an
> additional reference to its user namespace. Put the reference when either
> the delayed work has completed or when it was cancelled but hadn't run.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h                      | 11 +++++++
>  security/integrity/ima/ima.h             | 12 ++++---
>  security/integrity/ima/ima_fs.c          |  4 ++-
>  security/integrity/ima/ima_init.c        |  2 --
>  security/integrity/ima/ima_init_ima_ns.c |  8 +++++
>  security/integrity/ima/ima_policy.c      |  4 +--
>  security/integrity/ima/ima_queue_keys.c  | 42 +++++++++++++-----------
>  7 files changed, 53 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 9f6de36240b0..529defe4d272 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -217,6 +217,17 @@ struct ima_namespace {
>  	struct rb_root ns_status_tree;
>  	rwlock_t ns_status_lock;
>  	struct kmem_cache *ns_status_cache;
> +
> +#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
> +	/*
> +	 * If custom IMA policy is not loaded then keys queued up
> +	 * for measurement should be freed. This worker is used
> +	 * for handling this scenario.
> +	 */
> +	struct delayed_work ima_keys_delayed_work;
> +	long ima_key_queue_timeout;
> +	bool timer_expired;
> +#endif
>  };
>  
>  extern struct ima_namespace init_ima_ns;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index dd06e16c4e1c..9edab9050dc7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -77,6 +77,8 @@ struct ima_field_data {
>  	u32 len;
>  };
>  
> +struct ima_namespace;
> +
>  /* IMA template field definition */
>  struct ima_template_field {
>  	const char field_id[IMA_TEMPLATE_FIELD_ID_MAX_LEN];
> @@ -247,18 +249,18 @@ struct ima_key_entry {
>  	size_t payload_len;
>  	char *keyring_name;
>  };
> -void ima_init_key_queue(void);
> +void ima_init_key_queue(struct ima_namespace *ns);
>  bool ima_should_queue_key(void);
>  bool ima_queue_key(struct key *keyring, const void *payload,
>  		   size_t payload_len);
> -void ima_process_queued_keys(void);
> +void ima_process_queued_keys(struct ima_namespace *ns);
> +void ima_keys_handler(struct work_struct *work);
>  #else
> -static inline void ima_init_key_queue(void) {}
>  static inline bool ima_should_queue_key(void) { return false; }
>  static inline bool ima_queue_key(struct key *keyring,
>  				 const void *payload,
>  				 size_t payload_len) { return false; }
> -static inline void ima_process_queued_keys(void) {}
> +static inline void ima_process_queued_keys(struct ima_namespace *ns) {}
>  #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
>  
>  /* LIM API function definitions */
> @@ -300,7 +302,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>  		     struct ima_template_desc **template_desc,
>  		     const char *func_data, unsigned int *allowed_algos);
>  void ima_init_policy(void);
> -void ima_update_policy(void);
> +void ima_update_policy(struct ima_namespace *ns);
>  void ima_update_policy_flags(void);
>  ssize_t ima_parse_add_rule(char *);
>  void ima_delete_rules(void);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 3d8e9d5db5aa..5cff3d6c3dc7 100644
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
> @@ -410,6 +411,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>  static int ima_release_policy(struct inode *inode, struct file *file)
>  {
>  	const char *cause = valid_policy ? "completed" : "failed";
> +	struct ima_namespace *ns = get_current_ns();
>  
>  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
>  		return seq_release(inode, file);
> @@ -430,7 +432,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  		return 0;
>  	}
>  
> -	ima_update_policy();
> +	ima_update_policy(ns);
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>  	securityfs_remove(ima_policy);
>  	ima_policy = NULL;
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index f6ae4557a0da..24848373a061 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -155,8 +155,6 @@ int __init ima_init(void)
>  	if (rc != 0)
>  		return rc;
>  
> -	ima_init_key_queue();
> -
>  	ima_measure_critical_data("kernel_info", "kernel_version",
>  				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>  				  NULL, 0);
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 64777377664b..75ef17d52b5b 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -26,6 +26,14 @@ int ima_init_namespace(struct ima_namespace *ns)
>  	if (!ns->ns_status_cache)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
> +	INIT_DELAYED_WORK(&ns->ima_keys_delayed_work, ima_keys_handler);
> +	ns->ima_key_queue_timeout = 300000;
> +	ns->timer_expired = false;
> +	if (ns == &init_ima_ns)
> +		ima_init_key_queue(ns);

The refcounting seems wrong?
ima_init_key_queue() only takes a reference for init_ima_ns and
consequently on init_user_ns (which is a bit pointless since it can't go
away and so can't init_ima_ns).

In contrast non-init_ima_ns will not take a reference on their user_ns.
But ima_keys_handler() always puts the refcount for user_ns for both
non-init_ima_ns and init_ima_ns alike.

Maybe I'm misreading this.

In your earlier mail in [1] you said:

> > The only problem that I see where we are accessing the IMA namespace outside a
> > process context is in 4/16 'ima: Move delayed work queue and variables into
> > ima_namespace' where a delayed work queue is used. I fixed this now by getting

So we seem to know that ima always accesses ima_ns from
current_user_ns() and only in the workqueue case will it delay key
processing for a specific ima namespace without walking a userns
hierarchy.

If that's the case we should remove the user_ns member from ima_ns and
enforce that ima_ns is always accessed from current_user_ns().

Since the workqueue case luckily doesn't need access to user_ns anywhere
we can add a workqueue specific refcount that only keeps it alive for
the workqueue case. We just need to enforce that when the refcount is
bumped for the workqeue it must be done from process context so we're
guaranteed that when we bump the reference the user_ns and consequently
the ima_ns is still alive.

This should solve your lifetime issues (once you fixed the problem I
pointed out above).

(Btw, the kref member was unused before my patch. It didn't really do
any lifetime management for ima_ns afaict.)

[1]: https://lore.kernel.org/lkml/60fa585b-984e-fa13-e76f-56083a726259@linux.ibm.com

Here's a sketch neither compile nor runtime tested and without the
refcount issues I pointed out above fixed:

From 130e8d3faaad42820040587eff8695027fcf062a Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 9 Dec 2021 13:15:49 +0100
Subject: [PATCH] !!!! HERE BE DRAGONS - UNFIXED REFCOUNT ISSUES FROM PREVIOUS
 PATCH AND ALL UNTESTED !!!!

ima: get rid of user_ns member in struct ima_namespace
---
 include/linux/ima.h                      | 40 +++++++++---------------
 security/integrity/ima/ima_fs.c          |  2 +-
 security/integrity/ima/ima_init_ima_ns.c |  3 +-
 security/integrity/ima/ima_main.c        |  2 +-
 security/integrity/ima/ima_ns.c          |  9 ++----
 security/integrity/ima/ima_queue_keys.c  | 22 +++++++++----
 6 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 32bf98092143..73cdfbf3f9d4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
+#include <linux/refcount.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -241,8 +242,6 @@ enum {
 };
 
 struct ima_namespace {
-	struct kref kref;
-	struct user_namespace *user_ns;
 	struct rb_root ns_status_tree;
 	rwlock_t ns_status_lock;
 	struct kmem_cache *ns_status_cache;
@@ -264,6 +263,7 @@ struct ima_namespace {
 	 * for measurement should be freed. This worker is used
 	 * for handling this scenario.
 	 */
+	refcount_t ima_keys_delayed_ref;
 	struct delayed_work ima_keys_delayed_work;
 	long ima_key_queue_timeout;
 	bool timer_expired;
@@ -295,24 +295,12 @@ extern struct list_head ima_default_rules;
 
 #ifdef CONFIG_IMA_NS
 
-void free_ima_ns(struct kref *kref);
-
-static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
-{
-	if (ns)
-		kref_get(&ns->kref);
-
-	return ns;
-}
+void free_ima_ns(struct ima_namespace *ns);
+void __put_delayed_ima_ns(struct ima_namespace *ns);
 
 static inline void put_ima_ns(struct user_namespace *user_ns)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
-
-	if (ns) {
-		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ns, kref_read(&ns->kref));
-		kref_put(&ns->kref, free_ima_ns);
-	}
+	__put_delayed_ima_ns(user_ns->ima_ns);
 }
 
 int create_ima_ns(struct user_namespace *user_ns);
@@ -322,21 +310,20 @@ static inline struct ima_namespace *get_current_ns(void)
 	return current_user_ns()->ima_ns;
 }
 
-#else
-
-static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
+static inline struct user_namespace *ima_user_ns(const struct ima_namespace *ima_ns)
 {
-	return ns;
+	struct user_namespace *user_ns;
+	user_ns = current_user_ns();
+	WARN_ON(user_ns->ima_ns != ima_ns);
+	return user_ns;
 }
 
-static inline void put_ima_ns(struct user_namespace *user_ns)
-{
-}
+#else
 
 static inline int create_ima_ns(struct user_namespace *user_ns)
 {
 #if CONFIG_IMA
-	user_ns->ima_ns = get_ima_ns(&init_ima_ns);
+	user_ns->ima_ns = &init_ima_ns;
 #endif
 	return 0;
 }
@@ -346,6 +333,9 @@ static inline struct ima_namespace *get_current_ns(void)
 	return &init_ima_ns;
 }
 
+static inline void put_ima_ns(struct user_namespace *user_ns)
+{
+}
 #endif /* CONFIG_IMA_NS */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 778983fd9a73..583462b29cb5 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -386,7 +386,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!mac_admin_ns_capable(ns->user_ns))
+		if (!mac_admin_ns_capable(ima_user_ns(ns)))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 162c94e06d13..6ae6df037f03 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -62,12 +62,11 @@ int __init ima_ns_init(void)
 }
 
 struct ima_namespace init_ima_ns = {
-	.kref = KREF_INIT(1),
-	.user_ns = &init_user_ns,
 #ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
 	.ima_process_keys = false,
 	.ima_keys_lock = __MUTEX_INITIALIZER(init_ima_ns.ima_keys_lock),
 	.ima_keys = LIST_HEAD_INIT(init_ima_ns.ima_keys),
 #endif
+	.ima_keys_delayed_ref = REFCOUNT_INIT(1),
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 70fa26b7bd3f..6ebc57cd91d3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -410,7 +410,7 @@ static int process_measurement(struct ima_namespace *ns,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct user_namespace *user_ns = ns->user_ns;
+	struct user_namespace *user_ns = ima_user_ns(ns);
 	int ret = 0;
 
 	while (user_ns) {
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 6a0632806cdb..f96286ad0da8 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -31,9 +31,6 @@ int create_ima_ns(struct user_namespace *user_ns)
 		return -ENOMEM;
 	pr_debug("NEW     ima_ns: 0x%p\n", ns);
 
-	kref_init(&ns->kref);
-	ns->user_ns = user_ns;
-
 	err = ima_init_namespace(ns);
 	if (err)
 		goto fail_free;
@@ -44,6 +41,7 @@ int create_ima_ns(struct user_namespace *user_ns)
 	INIT_LIST_HEAD(&ns->ima_keys);
 #endif
 
+	refcount_set(&ns->ima_keys_delayed_ref, 1);
 	user_ns->ima_ns = ns;
 
 	return 0;
@@ -63,11 +61,8 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	kmem_cache_free(imans_cachep, ns);
 }
 
-void free_ima_ns(struct kref *kref)
+void free_ima_ns(struct ima_namespace *ns)
 {
-	struct ima_namespace *ns;
-
-	ns = container_of(kref, struct ima_namespace, kref);
 	if (WARN_ON(ns == &init_ima_ns))
 		return;
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index a6eb802e5ae4..d7c43e592e2c 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -14,6 +14,19 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+static inline void __get_delayed_ima_ns(struct ima_namespace *ima_ns)
+{
+	refcount_inc(&ima_ns->ima_keys_delayed_ref);
+}
+
+void __put_delayed_ima_ns(struct ima_namespace *ima_ns)
+{
+	if (ima_ns && refcount_dec_and_test(&ima_ns->ima_keys_delayed_ref)) {
+		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ima_ns,
+			 refcount_read(&ima_ns->ima_keys_delayed_ref));
+		free_ima_ns(ima_ns);
+	}
+}
 
 /*
  * This worker function frees keys that may still be
@@ -26,8 +39,7 @@ void ima_keys_handler(struct work_struct *work)
 	ns = container_of(work, struct ima_namespace, ima_keys_delayed_work.work);
 	ns->timer_expired = true;
 	ima_process_queued_keys(ns);
-
-	put_user_ns(ns->user_ns);
+	__put_delayed_ima_ns(ns);
 }
 
 /*
@@ -36,9 +48,7 @@ void ima_keys_handler(struct work_struct *work)
  */
 void ima_init_key_queue(struct ima_namespace *ns)
 {
-	/* keep IMA namespace until delayed work is done */
-	get_user_ns(ns->user_ns);
-
+	__get_delayed_ima_ns(ns);
 	schedule_delayed_work(&ns->ima_keys_delayed_work,
 			      msecs_to_jiffies(ns->ima_key_queue_timeout));
 }
@@ -145,7 +155,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	if (!ns->timer_expired) {
 		if (cancel_delayed_work_sync(&ns->ima_keys_delayed_work))
 			/* undo reference from ima_init_key_queue */
-			put_user_ns(ns->user_ns);
+			__put_delayed_ima_ns(ns);
 	}
 
 	list_for_each_entry_safe(entry, tmp, &ns->ima_keys, list) {
-- 
2.30.2

