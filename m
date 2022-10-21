Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2613607B88
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJUPxG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJUPxB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 11:53:01 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF42793C8
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666367576; bh=Rhk069KOBIjgswugBAhs7x+tYOgfClVZYkq2r/lu/V0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qeUaWBQZU0wvI+8Ra0pPuCNEBkcUHWT5+rWFs3P8PUV27kCHz6GYjEs+apU7QLmr96N5hCHLfB/ldASI/JKpwPQYYVnibFbQJ8MwaG5KIEi2jSI9S+IvUPHE+c3SIHQ/aAkvhqndO90S90yO5vPCQaWD4ZFIKYeu7RmTNnFY16jnNF6sV9KUQUU532hbCaxeTP6ndqdTEcCO1w+E4BL9lrqKLrhg8iFLN5twNibNe7ht/va4cJWjw/i8k0hLEM4L2hcDm4jASSWoNZ1owK+5hBByzCiyg+7cMul/iBvQLb7GachMTFBIqPtpeaZQJMp6VzEB6fehVTMvK1o2cyyUhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666367576; bh=oQBWHCAHulHvpRFZmGpEADzTqxtZS8dLQo2dt120kJP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eCpbGpwVW1FnMlcttoP3DMdFFUCe7eVENjxf7BchnwDnxbZNU9s30LuLOsewkiaSq1iW+/mnjnmhoVmWPTfpA6Od+1ZBMVsOMfuwu/u6cYrqUC/5KOHdJwCNY9a4dWye/iwi13Q2qK/SXbaw8t5QnUjdNKLFrP3O1m7HOuqX9TWt9TgsTV/tMTWPnQ4vxSIdJq3OJSQ8fJCzeUoUTKqK/KRnKNY64cbtzXQAqrsgVL5LAYLWSMWiE41Cv/L/vkaNjR44i8RLbvwdxRNdQ18Y6Ylay8NauLR2IXuaEdLaHnhV6RD3YNOzNXn4oj3TxVumCP2oUuepnF+uvZzCGqiI8A==
X-YMail-OSG: kd7yNwAVM1ns20EMfZpiB3vvfH4hTfyM4VI6oQxcTt2QOXg9PGJn57QHlrRUWfq
 aoTG2JMQ1eIYwxFjMyyoPpt0Kl5E5tSorB8U1TUHNjQKV1XliNmuFYN7pWxfxQUYFxiHUvV1d2pv
 IhYmry.rXLdbQrwpJpEEWOh24geBo9BCwssUEB0U0mYzybiBaNcdz2NJuLgecCCo71noq84yLatc
 YOef9XKaQ2BzhbyS8CFgkSV56TIw2GyZr3JEBZm1ccoWwvG7WDWZRqPAOF8FVSMzq_UTCnTpz6Sg
 r3kl_FtDKpwZzyvF1F5gn85YkMeDt_d.7BFaRgCTo4G35qVDt5FmfQaor1LiWDBTMNFmBel1UQmT
 .p9pASBTUaUktH8nD.BU2z2BIi.J6e.6.BVpL5GHNlY_B8p46iBm7sJbCQW5XXhzUWE3nm7MIWDy
 8ZpNnhOTZHG7X_WXFfY2UbIgJfaJPd3TykKaP_XgHTxGFsxvOeywqKtgvr1yPfglN578k8QtGrs_
 itHgQAhJ2BNy5gXRgU84crA0sFdMDybkT0U051HaSrP5ju_dtxTRMZy1cko_WZVgrzam0ExzAqY8
 S5L3PN1kRwGEXrDuGd8f.6IVgDpGRz8MP39f9M6aPLjvvdiOVNPvKZ6u9nHfj57_GLLpoWSP1.VM
 xoTS.OL.3ktshmMqbEDAtIDxMnlCAj81c.6FeKAPJ5HNBaBQemJkE0bmnh9dGLs4Yvnwbum_K0P4
 ceGN.gnwtsEsG32r8cNPs_6PD2ytGDLPRToc_i_tnAmDXV4WsrnDcXWMycOUGeHmK6DDmu9evVLG
 dO.3Jc6C_LDzR1x7KjwV0cMWw4ARLT7vyuRdH1qAa3V7qBIufOK9MgXdIKCVl2A2W0aMXrJhaez6
 ecaH2rEULYUS6zSuqjoQ06fiKWbkX.lGxZJDf5lefdfKmFQIyPH4BdX8tbJh9dL4fpkA1xlEh4E5
 8E50AqlRU60j8yGhCGzyhXdnlBNf8cJB1WTXVT2VMzCSl1hUHLx1Ix_kaZEA_kOx7ivJTCym6Lm2
 btflno9YmaVqY0EV0urXY0O7r6AbAGDL2u6dUwMIakut38J1bKg3.5nNOwFFoTP1GvCFNoK55s5t
 opHcMvyk2IORulunE42adsdwYbMwsHcSjcJEXT1Fg.N2LjRXlmp6sLxK_qhenQOYL1tmYZlriob9
 8Lmak05P74tyh2uxbqzkcTKjFZGLU49ZiuRkWxZZMOdSjfuzSpRz7i._wvdPnblzCdpJ02PekKpr
 7ziaxu2leDvGxSN7HxwqOdttY.bu158PrEozZ7v7sIY9AINqx1M_sxKZQhC1B_NRBiPMKxu9Ebrb
 MvsqJhYth8k.llUcbfyOJ_v5HcODFK0TPT5cqNkUVwLS8xRVC8ztsOU138ByiAtYId74BLSpMHdE
 eiZYUXfJWFJx4YWYRcRcpb.zQsu78fdh_OaqrPq_IZ2DTgsJzQ2d1AQ3DWhsgU1hefXUfZazt1qA
 Y3UHRoyQE5dCJtQuvOoCm2qmZCuvowxWpWaWpyosdNd4UatuIwB9G6_ikBVPlJC9tP9RmNFrq47t
 j8dEaDPa0oObXl3dzlWaTShdp1EVzRXmgcFB9yjKhnf1QJatSOs.NnPIMTYA9IowPvrf7xGhC6Mq
 Waf6JGgzB92XjrOMywo6AJG9NWZ_75oVRi1WcmKFJ.RIPReWZwolMJyRTLRfVpOuwzjKmU4nGQ1l
 Hc.xFNH5wqK1Da8DROF6GJFz2VApkP2wQJdCY1B535cEtuu6FTpzaepGP5HWEdZi3YjVdtmbFEYV
 SaNem7Ck5NePCZE6nXz8zKSj94.9CITB.wQ9hZpO_2oo9_Oilvad25iBcnXupmW0QOE2meUhG61i
 6JhoO0lR5U3ryssGt2po1bhB8uH6pfWJ728CZECFWKvBxUgzyaxbimu2RUKIwWB5PuKq43lNxcTe
 oBxCC6nmxK2OdJn9je8sOi4ALKrHbYvpG7M0ORfwr.07.ATWwS4zfGdKiqw.vsDLXtl5l6zHyCGB
 8lv1xoz7fAcZeecUjt8I4wQUl864GE5JizjtpKvP5ZUQ46MQc3XSLMv99ykb.aP61VIQC7zCOx7o
 bjNtExDlthMi4cuQRMBtNY5hC83zJdcSTumdIihecYidtEsANczvugfP06NoNxLbPkhRW1845VdE
 7.SgWIFfORc8veqHu3enwRlBS8rYFVknDqPHEEy8H8UqMgF9OybjM2HnXBKXBAu2ptAZQX381Ewd
 hNjWHlBGDv4x4ui8MLFBBtSTaKE8bYtnCHa90jGS9vubKaM9Aw24Z4EmEprTsMVLXrGYTWCg6J4i
 ytEymupu7.tPkxlsKVMNuZqkmZw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Oct 2022 15:52:56 +0000
Received: by hermes--production-gq1-754cb59848-dxw7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bd0feab9a77a8fbe86fddaca2a3a9e2b;
          Fri, 21 Oct 2022 15:42:21 +0000 (UTC)
Message-ID: <3336d699-a73d-5112-4bf7-95a92f0fcc28@schaufler-ca.com>
Date:   Fri, 21 Oct 2022 08:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] evm: Correct inode_init_security hooks behaviors
Content-Language: en-US
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
References: <Y1K3bf+dtNnVe7DG@archlinux>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1K3bf+dtNnVe7DG@archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/21/2022 8:14 AM, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Fixes a NULL pointer dereference occurring in the
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

This does not match the code, which sets the value based on the
security modules compiled in rather than the constant 5.

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
>
> Changes since v1:
> https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> * The `call_int_hook_xattr` macro has been inlined into the
>   `security_inode_init_security` hook (as suggested by Paul Moor,
>   Mickaël Salaün and Casey Schaufler).
> * The MAX_LSM_EVM_XATTR value is processed based on compiled LSMs (as
>   proposed by Casey Schaufler).
> * Various typos and cosmetic changes has been fixed (as suggested by
>   Mickaël Salaün)
> * A MAX_LSM_EVM_XATTR test has been wrapped in a WAN_ON_ONCE macro (as
>   suggested by Mickaël Salaün).
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  4 ++--
>  security/integrity/evm/evm.h        |  2 ++
>  security/integrity/evm/evm_crypto.c | 22 ++++++++++++++++++++++
>  security/integrity/evm/evm_main.c   |  9 +++++----
>  security/security.c                 | 28 +++++++++++++++++++++-------
>  6 files changed, 53 insertions(+), 14 deletions(-)
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
> index 708de9656bbd..db6868875e09 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -385,6 +385,28 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
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
> index 2e6fb6e2ffd2..4f89b9eaf028 100644
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
> @@ -841,8 +843,7 @@ int evm_inode_init_security(struct inode *inode,
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
> +	rc = evm_init_hmacs(inode, lsm_xattr, xattr_data->digest);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..cf11bd7d6a1b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,7 +30,11 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>  
> -#define MAX_LSM_EVM_XATTR	2
> +#define MAX_LSM_EVM_XATTR                                \
> +	((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
> +	 (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	 (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
> +	 (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -1091,9 +1095,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> +	int i = 0;
> +	int ret = -EOPNOTSUPP;
>  	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>  	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -	int ret;
> +	struct security_hook_list *hook_ptr;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> @@ -1103,15 +1109,23 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				     dir, qstr, NULL, NULL, NULL);
>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>  	lsm_xattr = new_xattrs;
> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> -						&lsm_xattr->name,
> -						&lsm_xattr->value,
> -						&lsm_xattr->value_len);
> +	hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security, list) {
> +		ret = hook_ptr->hook.inode_init_security(inode, dir, qstr, &lsm_xattr->name,
> +				&lsm_xattr->value, &lsm_xattr->value_len);
> +		if (ret == -EOPNOTSUPP)
> +			continue;
> +		if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))
> +			ret = -ENOMEM;
> +		if (ret != 0)
> +			break;
> +		lsm_xattr++;
> +		i++;
> +	}
>  	if (ret)
>  		goto out;
>  
>  	evm_xattr = lsm_xattr + 1;
> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
>  	if (ret)
>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
