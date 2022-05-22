Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13A953004C
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 04:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiEVCfK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 May 2022 22:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEVCfJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 May 2022 22:35:09 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A63D34647;
        Sat, 21 May 2022 19:35:07 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id B17D1666; Sat, 21 May 2022 21:35:05 -0500 (CDT)
Date:   Sat, 21 May 2022 21:35:05 -0500
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
        jpenumak@redhat.com
Subject: Re: [PATCH v12 09/26] ima: Move ima_lsm_policy_notifier into
 ima_namespace
Message-ID: <20220522023505.GA18987@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-10-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-10-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:16AM -0400, Stefan Berger wrote:
> Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
> namespace can now register its own LSM policy change notifier callback.
> The policy change notifier for the init_ima_ns still remains in init_ima()
> and therefore handle the registration of the callback for all other
> namespaces in init_ima_namespace().
> 
> Rate-limit the kernel warning 'rule for LSM <label> is undefined` for
> IMA namespace to avoid flooding the kernel log with this type of message.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> 
> ---
> v11:
>  - Renamed 'rc' to 'ret'
>  - Use pr_warn_ratelimited('rule for LSM...') for IMA namespaces
> 
> v10:
>  - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
> ---
>  security/integrity/ima/ima.h             |  2 ++
>  security/integrity/ima/ima_init_ima_ns.c | 14 +++++++++++++
>  security/integrity/ima/ima_main.c        |  6 +-----
>  security/integrity/ima/ima_policy.c      | 26 ++++++++++++++++--------
>  4 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b35c8504ef87..c68b5117d034 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -144,6 +144,8 @@ struct ima_namespace {
>  	int valid_policy;
>  
>  	struct dentry *ima_policy;
> +
> +	struct notifier_block ima_lsm_policy_notifier;
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 425eed1c6838..c4fe8f3e9a73 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -10,6 +10,8 @@
>  
>  static int ima_init_namespace(struct ima_namespace *ns)
>  {
> +	int ret;
> +
>  	INIT_LIST_HEAD(&ns->ima_default_rules);
>  	INIT_LIST_HEAD(&ns->ima_policy_rules);
>  	INIT_LIST_HEAD(&ns->ima_temp_rules);
> @@ -30,6 +32,15 @@ static int ima_init_namespace(struct ima_namespace *ns)
>  	ns->valid_policy = 1;
>  	ns->ima_fs_flags = 0;
>  
> +	if (ns != &init_ima_ns) {
> +		ns->ima_lsm_policy_notifier.notifier_call =
> +						ima_lsm_policy_change;
> +		ret = register_blocking_lsm_notifier
> +						(&ns->ima_lsm_policy_notifier);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -39,5 +50,8 @@ int __init ima_ns_init(void)
>  }
>  
>  struct ima_namespace init_ima_ns = {
> +	.ima_lsm_policy_notifier = {
> +		.notifier_call = ima_lsm_policy_change,
> +	},
>  };
>  EXPORT_SYMBOL(init_ima_ns);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 005f9e784e7b..d44faf1c065d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,10 +38,6 @@ int ima_appraise;
>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>  static int hash_setup_done;
>  
> -static struct notifier_block ima_lsm_policy_notifier = {
> -	.notifier_call = ima_lsm_policy_change,
> -};
> -
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -1089,7 +1085,7 @@ static int __init init_ima(void)
>  	if (error)
>  		return error;
>  
> -	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> +	error = register_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
>  	if (error)
>  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 0a7c61ca3265..23c559c8fae9 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -368,7 +368,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
>  	kfree(entry);
>  }
>  
> -static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> +static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
> +						struct ima_rule_entry *entry)
>  {
>  	struct ima_rule_entry *nentry;
>  	int i;
> @@ -399,18 +400,25 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
>  				     &nentry->lsm[i].rule);
> -		if (!nentry->lsm[i].rule)
> -			pr_warn("rule for LSM \'%s\' is undefined\n",
> -				nentry->lsm[i].args_p);
> +		if (!nentry->lsm[i].rule) {
> +			if (ns == &init_ima_ns)
> +				pr_warn("rule for LSM \'%s\' is undefined\n",
> +					nentry->lsm[i].args_p);
> +			else
> +				pr_warn_ratelimited
> +					("rule for LSM \'%s\' is undefined\n",
> +					 nentry->lsm[i].args_p);
> +		}
>  	}
>  	return nentry;
>  }
>  
> -static int ima_lsm_update_rule(struct ima_rule_entry *entry)
> +static int ima_lsm_update_rule(struct ima_namespace *ns,
> +			       struct ima_rule_entry *entry)
>  {
>  	struct ima_rule_entry *nentry;
>  
> -	nentry = ima_lsm_copy_rule(entry);
> +	nentry = ima_lsm_copy_rule(ns, entry);
>  	if (!nentry)
>  		return -ENOMEM;
>  
> @@ -453,7 +461,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
>  		if (!ima_rule_contains_lsm_cond(entry))
>  			continue;
>  
> -		result = ima_lsm_update_rule(entry);
> +		result = ima_lsm_update_rule(ns, entry);
>  		if (result) {
>  			pr_err("lsm rule update error %d\n", result);
>  			return;
> @@ -464,12 +472,14 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  			  void *lsm_data)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct ima_namespace *ns;
>  
>  	if (event != LSM_POLICY_CHANGE)
>  		return NOTIFY_DONE;
>  
> +	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
>  	ima_lsm_update_rules(ns);
> +
>  	return NOTIFY_OK;
>  }
>  
> -- 
> 2.34.1
