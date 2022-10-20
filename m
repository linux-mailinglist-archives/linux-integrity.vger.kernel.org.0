Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84126063F3
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJTPOd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJTPOZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 11:14:25 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8B25E0
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 08:14:21 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MtWNC4FjCzMq4cB;
        Thu, 20 Oct 2022 17:14:19 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MtWN93qVkzMpprd;
        Thu, 20 Oct 2022 17:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1666278859;
        bh=BrqvyTr3uvWoG3Vzu1yMOhFqAgCddkgUqWS/8z7yDHg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eM1l7i4pDAfC3gnCmF5UXMMKlxE3+5MrCHOoJO8jQs85gDxTLhh9Z+U+4uBhxzQ3g
         KGYSkQx/uyTtJYeW0sFc/Z5nPrwqHpDRrWPTDIULLeId1JHilxjXz2zirVZc715Fzl
         8QS4l7wDLz8/C1DvvVZRPA6rqr57he83T8mFv34o=
Message-ID: <200a6140-78bc-d7df-11f3-93c1e8da969b@digikod.net>
Date:   Thu, 20 Oct 2022 17:14:16 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Content-Language: en-US
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org
References: <Y1FTSIo+1x+4X0LS@archlinux>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y1FTSIo+1x+4X0LS@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 20/10/2022 15:55, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Fixes a NULL pointer dereference occuring in the

As pointed out by checkpatch.pl, there is a typo.


> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.

Could you give more details how to trigger this bug and to test this fix?


> 
> Adds a `call_int_hook_xattr` macro that fetches and feed the
> `new_xattrs` array with every called hook xattr values.
> 
> Adds a `evm_init_hmacs` function which init the EVM hmac using every
> entry of the array contrary to `evm_init_hmac`.
> 
> Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> 
> The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room for
> SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
> 
> Changes the default return value of the `inode_init_security` hook
> definition to `-EOPNOTSUPP`.
> 
> Changes the hook documentation to match the behavior of the LSMs using
> it (only xattr->value is initialised with kmalloc and thus is the only
> one that should be kfreed by the caller).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>   include/linux/lsm_hook_defs.h       |  2 +-
>   include/linux/lsm_hooks.h           |  4 ++--
>   security/integrity/evm/evm.h        |  2 ++
>   security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
>   security/integrity/evm/evm_main.c   | 11 ++++++-----
>   security/security.c                 | 29 ++++++++++++++++++++++++++---
>   6 files changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 806448173033..e5dd0c0f6345 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>   	 unsigned int obj_type)
>   LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>   LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>   	 struct inode *dir, const struct qstr *qstr, const char **name,
>   	 void **value, size_t *len)
>   LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 84a0d7e02176..95aff9383de1 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -229,8 +229,8 @@
>    *	This hook is called by the fs code as part of the inode creation
>    *	transaction and provides for atomic labeling of the inode, unlike
>    *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> - *	is expected to allocate the name and value via kmalloc, with the caller
> - *	being responsible for calling kfree after using them.
> + *	is expected to allocate the value via kmalloc, with the caller
> + *	being responsible for calling kfree after using it.
>    *	If the security module does not use security attributes or does
>    *	not wish to put a security attribute on this particular inode,
>    *	then it should return -EOPNOTSUPP to skip this processing.
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index f8b8c5004fc7..a2f9886e924d 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -60,6 +60,8 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>   		  struct evm_digest *data);
>   int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
>   		  char *hmac_val);
> +int evm_init_hmacs(struct inode *inode, const struct xattr *xattrs,
> +		  char *hmac_val);
>   int evm_init_secfs(void);
>   
>   #endif
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 708de9656bbd..e5a34306cab6 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -347,7 +347,6 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
>   	return rc;
>   }
>   
> -

This kind of cosmetic change should not be part of this patch.


>   /*
>    * Calculate the hmac and update security.evm xattr
>    *
> @@ -385,6 +384,28 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>   	return rc;
>   }
>   
> +int evm_protected_xattr(const char *req_xattr_name);
> +
> +int evm_init_hmacs(struct inode *inode, const struct xattr *lsm_xattrs,
> +		  char *hmac_val)
> +{
> +	struct shash_desc *desc;
> +
> +	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
> +	if (IS_ERR(desc)) {
> +		pr_info("init_desc failed\n");
> +		return PTR_ERR(desc);
> +	}
> +
> +	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
> +		if (evm_protected_xattr(lsm_xattrs[i].name))
> +			crypto_shash_update(desc, lsm_xattrs[i].value, lsm_xattrs[i].value_len);
> +	}
> +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +	kfree(desc);
> +	return 0;
> +}
> +
>   int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
>   		  char *hmac_val)
>   {
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 2e6fb6e2ffd2..bb071c55d656 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>   	int found = 0;
>   	struct xattr_list *xattr;
>   
> +	if (!req_xattr_name)
> +		return found;
>   	namelen = strlen(req_xattr_name);
>   	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>   		if (!all_xattrs && !xattr->enabled)
> @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>   	return found;
>   }
>   
> -static int evm_protected_xattr(const char *req_xattr_name)
> +int evm_protected_xattr(const char *req_xattr_name)
>   {
>   	return evm_protected_xattr_common(req_xattr_name, false);
>   }
> @@ -835,14 +837,13 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
>    * evm_inode_init_security - initializes security.evm HMAC value
>    */
>   int evm_inode_init_security(struct inode *inode,
> -				 const struct xattr *lsm_xattr,
> +				 const struct xattr *lsm_xattrs,
>   				 struct xattr *evm_xattr)
>   {
>   	struct evm_xattr *xattr_data;
>   	int rc;
>   
> -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> -	    !evm_protected_xattr(lsm_xattr->name))
> +	if (!(evm_initialized & EVM_INIT_HMAC))
>   		return 0;
>   
>   	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> @@ -850,7 +851,7 @@ int evm_inode_init_security(struct inode *inode,
>   		return -ENOMEM;
>   
>   	xattr_data->data.type = EVM_XATTR_HMAC;
> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> +	rc = evm_init_hmacs(inode, lsm_xattrs, xattr_data->digest);
>   	if (rc < 0)
>   		goto out;
>   
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..47012c118536 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,7 +30,7 @@
>   #include <linux/msg.h>
>   #include <net/flow.h>
>   
> -#define MAX_LSM_EVM_XATTR	2
> +#define MAX_LSM_EVM_XATTR	5

I looks like AppArmor is not using the inode_init_security hook. There 
should be a comment explaining why this number is correct, and a runtime 
check (given that a static_assert call is not possible in this case) to 
make sure this is correct at boot time, maybe in security_init().


>   
>   /* How many LSMs were built into the kernel? */
>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -746,6 +746,29 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   	RC;							\
>   })
>   
> +#define call_int_hook_xattr(XATTRS, FUNC, IRC, ...) ({		\
> +	int RC = IRC;						\
> +	int i = 0;						\
> +	do {							\
> +		struct security_hook_list *P;			\
> +								\
> +		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> +			RC = P->hook.FUNC(__VA_ARGS__);		\
> +			if (RC == -EOPNOTSUPP)			\
> +				continue;			\
> +			if (RC != 0 && RC != IRC)		\
> +				break;				\
> +			if (i >= MAX_LSM_EVM_XATTR) {		\

You can use `if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))` instead.


> +				RC = -ENOMEM;			\
> +				break;				\
> +			}					\
> +			XATTRS++;				\
> +			i++;					\
> +		}						\
> +	} while (0);						\
> +	RC;							\
> +})

The content of this macro can be included in its only caller: 
security_inode_init_security().


> +
>   /* Security operations */
>   
>   int security_binder_set_context_mgr(const struct cred *mgr)
> @@ -1103,7 +1126,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>   				     dir, qstr, NULL, NULL, NULL);
>   	memset(new_xattrs, 0, sizeof(new_xattrs));
>   	lsm_xattr = new_xattrs;
> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> +	ret = call_int_hook_xattr(lsm_xattr, inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>   						&lsm_xattr->name,
>   						&lsm_xattr->value,
>   						&lsm_xattr->value_len);
> @@ -1111,7 +1134,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>   		goto out;
>   
>   	evm_xattr = lsm_xattr + 1;
> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
>   	if (ret)
>   		goto out;
>   	ret = initxattrs(inode, new_xattrs, fs_data);

This looks good overall.
