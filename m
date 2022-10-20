Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED13D606606
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTQlK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJTQlI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 12:41:08 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD3165CA5
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666284065; bh=9cYu0FllEMi47MnDxm+0Bf/bnz5qJN1+HjNFT8Wx6KQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DzelAcajZt4SXsVVoxHwZlAA5HUHNv8ZFnq88Dcm/rgP+err1sMbMf+qSCFdZ+NsR7kIXWqAAiteWfNVN0BzR6HkPag/NdamhEB3gVsZInKGP0bNjy8C6p2SZBuasPL4xHco7aOWnBUv9hDGyCv0ULYj5CnQaUEX1YOE6GN//g0AULvkRdfAQcg4+Bok8ouvXJIi5P588UVpGCi1cZ964UiL4/g7ddG1X+FlmTqTuwcIaA52zOFadfy8xU8+YK0hkN1TObSeAbnFW0SuEy1B6K+AxYAkhnWOJEFn9uFcrrZm/8y6jtgOink2o0Y4hG0ttUXcN/CmR3Ie66i9AOAAMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666284065; bh=EYYzYKMg+WudjYzspAx9Ms3NTbdzUgY7gh2zUZDRSDi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OlnnJFmDS/7zG/6QsvesAv8QSH6VenjxT+9yp5PSvG4DWNsj15X2y9yZJ4puPM9ZX/IcpgRdExbX1Oix2dgXFlwvTspqV60EA4TYmXB9l812bpH1drIq+D/R4uRTCXdtvmWDRRpYNJv6zt5hkmCLF0kd7xTLW5d9FEAlu9+ekPHUt/zdnaKjJmvj/sVBGdNr7zhOcEnDaetPnmmpQTXyQphNtyv84id8yty1tw/yh4uabhPAhfwmIFVxN3Kqv0sMIuowpIkdmgddCCQK/QeSigRuekuDldv21asQ5TWSNKbyldqMMEgHR8mFTH8aY8na23frJqwJ+SbbB452KxrXww==
X-YMail-OSG: OeJMCvcVM1k5XhqFICISauva.VyLjfhcn6PuWpy7F.mlbZ5EqRT0a__X4mQLZXw
 Cuxu0ZuyNV_F3f.GLFj6kJIbvFcycpyXEzzg_SmVNokJEjIG7p6QsGLxkPKRK_uZ6RIqT1PBuFy7
 oSOzHRB4OTudaqPCo6FWxPEUgQec3DA2WdzQMvXPpBs5N.isJgNtz0Gl7mneKSpSqOFgMu95goYZ
 _HGIT9pkWVCMFlLRwycBcgs8mIZuo1xYxCGwHFMAjiuG0w.4rp.wL2pig.Z86h5oQ3Y_3tJ8dFre
 0yNeuGqdDw7ALxy17ZQ.rRJtdWKB0fqsTFnqOkdo7V8gnFhbqS37cFuKOJwdmWudhN7198eXoXDn
 5EUoV7mkSHBajiLYc7asLXOb8V41oX3ERv_CEis3huUDRKWa47uGXxvaA2.8l7LBwrmBB38fbE6w
 FS0kwaZyYaGurkFY4yEMX3v1KxDiQ0VJuLFR739a3daqOcZTRv_U1fNDcsofz7FOdAlsiru49mol
 lAd5VZA71haLCxRxQgwJYq_re8gHDaqWhPbeFuIYGHT93UIFU1iJUf.XRGfdQ04GDe3kB8_XMXMU
 aj__mSS1CzUqaRkek1X6lm_GA.9glMhG_U0977ob0jjBOeYb52P5rmosgjwEQhbxSKyZoHG9nYsm
 s7xxZ65YnNqID4sf3CspQay0I6ugoy0qMBUcwyHxseGcX1v2FibTS5okpSRbNdjKQoJmlpF6jxN7
 dosMrZeD9SB2fq9NUEk7mnEeg85ntjGmuXE99fap2Th3snTg.k2EmElN0_bHMyUhy1ApqNC2iHjD
 SQLnIeHHKWBSwVJgZ48eoPD1Ax26ZpL_QYhA5RSMoVXyXZz4DIgbSr4hY9B4fIjUO8xrZSbWdX2i
 F2Z8r0qRVYXLTue9HlIk62.CrSmEuaZ.pibXL8Mkaeav779zqqTgeLMGoOdRPhyMmG0MMZMlp5_t
 AAcLMiUfNksQ1Vglq6uvj87dkHZwTIJIUOIE36YUe1eGbFkg.IOsDjKKbeWthdcivGQZ6CaVXa4Y
 1supfReK6y2Dv5AlNsjTjqY5SWrBjWLy3FJpelnWa4jw8XHtis4rFG6OtpFWYn3nzocID5ScJEKE
 OWhENbZojfVma5VoeHZVfwg4bymkBza9eNfR65zYhtNBsnBiX6UQdz.DRY8PtTdLhbxntPzd7suU
 S3UHtM28oVG3.iwWI3S35M7tJWNbo_pAW7_5W1YoI.Tbl84TPnxH0M.PIRTG.IAFr0lSz9Y1A_OP
 c5RqZPjFA4Y5bukpLfRhH_tGUz5WfVH9iqpjqvLORW6OYzPvIzJzdXmigotoHDYAaDBnZ.pSZW8U
 ddEHKwaPMuqW98bagxKvDY2Vpbj2ePJxgSrvHbgicMm9VANXUyxEYgm6aObou7YqneN5qgvvA3r6
 .8lnnXQIhcqeGYhi5cJ3BDasV0n.NkSbwmCRPoPOsrfqBhtJApZrlZqGpMqWk2nJtOVQzArM.5HC
 .oxRJo0E8TKhnARh9KP6AA0kE.weMGermnfxe183SnJ.LyDJdf.4tmxLuI0HhTW73gqXTHc9e4V7
 JDwAAhxCrNMFsHeCTPRwl5vAQ7DPNGT.RITfRw6np0FgWKXb9RY5LX_NbKFY4Af.OpJsRYEsBxj6
 RqhYBXxasJA5t.XPxns7zaYmF24KPGkNv2GLZFn9O3yGa6RyhOxOuhsuOQbFe3rDej67.LfUua6p
 sXLOxmRcyf_aI0K7qhb..fIeGRatScS8nS2RJYnSvDgIEswhXWKlM0_MF.BWdmEywEuAk1NZyQaW
 MGB83FG04W.t8T3n4qKyahr9618ADZ5EEVfmXgyA9oaQPUjGzLk015YAxmVX_jvguY1jneERfFcg
 Kh97TiALL1hISr.ZwaNuz9oYcMpE377CiaFAYpy3bis3hMIwmFgoO2syjU8VI4F0OfJdnNM7E2UP
 mVUFXT9gurm1TeSahImzSJk4L95zHYqHAtZGAuYAMuk8eaQB4w1_AIdPTJrdGgf9uAiPpWRqCh4S
 DdsL8i2lycY4HNVVPVfe981TEfigrGWQMVMKrK3_.O_HbkMHx9tF80Rj6OBLoY1tek972CS9QCKQ
 mgnHmy7WnxCsUV7WCTcsi0DMmPR34p2Iiwrdc17IUbSjjWzxndsl_HAPX4h6NiGUgYgCuvC_Xhkd
 Y15ckeUSvNZ67WssyostZtLpsBo0kmt7GgHoW2dcwvsPLzu2hypJcaO4LkXAS2gceATW980mDShy
 aRLK7OopFd8w5qaR.CpY6jxBaskpKwm0pGOZljEcppnoCmzRwkqGR1s4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 16:41:05 +0000
Received: by hermes--production-gq1-754cb59848-xxkcq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 50e592082085a6e2a196e826cec70091;
          Thu, 20 Oct 2022 16:41:03 +0000 (UTC)
Message-ID: <ca9aaf31-d90e-7bdf-a7c0-551702f097e7@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 09:41:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Content-Language: en-US
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org, casey@schaufler-ca.com
References: <Y1FTSIo+1x+4X0LS@archlinux>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1FTSIo+1x+4X0LS@archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/2022 6:55 AM, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Fixes a NULL pointer dereference occuring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.
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
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  4 ++--
>  security/integrity/evm/evm.h        |  2 ++
>  security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
>  security/integrity/evm/evm_main.c   | 11 ++++++-----
>  security/security.c                 | 29 ++++++++++++++++++++++++++---
>  6 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 806448173033..e5dd0c0f6345 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>  	 unsigned int obj_type)
>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>  	 struct inode *dir, const struct qstr *qstr, const char **name,
>  	 void **value, size_t *len)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 84a0d7e02176..95aff9383de1 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -229,8 +229,8 @@
>   *	This hook is called by the fs code as part of the inode creation
>   *	transaction and provides for atomic labeling of the inode, unlike
>   *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> - *	is expected to allocate the name and value via kmalloc, with the caller
> - *	being responsible for calling kfree after using them.
> + *	is expected to allocate the value via kmalloc, with the caller
> + *	being responsible for calling kfree after using it.
>   *	If the security module does not use security attributes or does
>   *	not wish to put a security attribute on this particular inode,
>   *	then it should return -EOPNOTSUPP to skip this processing.
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index f8b8c5004fc7..a2f9886e924d 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -60,6 +60,8 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  		  struct evm_digest *data);
>  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
>  		  char *hmac_val);
> +int evm_init_hmacs(struct inode *inode, const struct xattr *xattrs,
> +		  char *hmac_val);
>  int evm_init_secfs(void);
>  
>  #endif
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 708de9656bbd..e5a34306cab6 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -347,7 +347,6 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
>  	return rc;
>  }
>  
> -
>  /*
>   * Calculate the hmac and update security.evm xattr
>   *
> @@ -385,6 +384,28 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>  	return rc;
>  }
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
>  int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
>  		  char *hmac_val)
>  {
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 2e6fb6e2ffd2..bb071c55d656 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>  	int found = 0;
>  	struct xattr_list *xattr;
>  
> +	if (!req_xattr_name)
> +		return found;
>  	namelen = strlen(req_xattr_name);
>  	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		if (!all_xattrs && !xattr->enabled)
> @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>  	return found;
>  }
>  
> -static int evm_protected_xattr(const char *req_xattr_name)
> +int evm_protected_xattr(const char *req_xattr_name)
>  {
>  	return evm_protected_xattr_common(req_xattr_name, false);
>  }
> @@ -835,14 +837,13 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
>   * evm_inode_init_security - initializes security.evm HMAC value
>   */
>  int evm_inode_init_security(struct inode *inode,
> -				 const struct xattr *lsm_xattr,
> +				 const struct xattr *lsm_xattrs,
>  				 struct xattr *evm_xattr)
>  {
>  	struct evm_xattr *xattr_data;
>  	int rc;
>  
> -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> -	    !evm_protected_xattr(lsm_xattr->name))
> +	if (!(evm_initialized & EVM_INIT_HMAC))
>  		return 0;
>  
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> @@ -850,7 +851,7 @@ int evm_inode_init_security(struct inode *inode,
>  		return -ENOMEM;
>  
>  	xattr_data->data.type = EVM_XATTR_HMAC;
> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> +	rc = evm_init_hmacs(inode, lsm_xattrs, xattr_data->digest);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..47012c118536 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,7 +30,7 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>  
> -#define MAX_LSM_EVM_XATTR	2
> +#define MAX_LSM_EVM_XATTR	5

#define MAX_LSM_EVM_XATTR \
	2 + /* IMA and EVM */ \
	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))

>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -746,6 +746,29 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  	RC;							\
>  })
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
> +				RC = -ENOMEM;			\
> +				break;				\
> +			}					\
> +			XATTRS++;				\
> +			i++;					\
> +		}						\
> +	} while (0);						\
> +	RC;							\
> +})
> +

No. Please open code this in the one place it is used.

>  /* Security operations */
>  
>  int security_binder_set_context_mgr(const struct cred *mgr)
> @@ -1103,7 +1126,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				     dir, qstr, NULL, NULL, NULL);
>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>  	lsm_xattr = new_xattrs;
> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> +	ret = call_int_hook_xattr(lsm_xattr, inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>  						&lsm_xattr->name,
>  						&lsm_xattr->value,
>  						&lsm_xattr->value_len);
> @@ -1111,7 +1134,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  		goto out;
>  
>  	evm_xattr = lsm_xattr + 1;
> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
>  	if (ret)
>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
