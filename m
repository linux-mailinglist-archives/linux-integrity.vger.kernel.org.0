Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C475304D1
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiEVRGq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 13:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiEVRGq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 13:06:46 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A203A73D;
        Sun, 22 May 2022 10:06:43 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7B8C23F4; Sun, 22 May 2022 12:06:41 -0500 (CDT)
Date:   Sun, 22 May 2022 12:06:41 -0500
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
Subject: Re: [PATCH v12 10/26] ima: Switch to lazy lsm policy updates for
 better performance
Message-ID: <20220522170641.GA24041@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-11-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-11-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:17AM -0400, Stefan Berger wrote:
> Instead of calling ima_lsm_update_rules() for every namespace upon
> invocation of the ima_lsm_policy_change() notification function,
> only set a flag in a namespace and defer the call to
> ima_lsm_update_rules() to before the policy is accessed the next time,
> which is either in ima_policy_start(), when displaying the policy via
> the policy file in securityfs, or when calling ima_match_policy().
> 
> The performance numbers before this change for a test enabling
> and disabling an SELinux module was as follows with a given number
> of IMA namespaces that each a have a policy containing 2 rules
> with SELinux labels:
> 
> 2: ~9s
> 192: ~11s
> 1920: ~80s
> 
> With this change:
> 
> 2: ~6.5s
> 192: ~7s
> 1920: ~8.3s
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/ima/ima.h        |  4 ++++
>  security/integrity/ima/ima_policy.c | 15 ++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c68b5117d034..5bf7f080c2be 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -123,6 +123,10 @@ struct ima_h_table {
>  };
>  
>  struct ima_namespace {
> +	unsigned long ima_ns_flags;
> +/* Bit numbers for above flags; use BIT() to get flag */
> +#define IMA_NS_LSM_UPDATE_RULES		0
> +
>  	/* policy rules */
>  	struct list_head ima_default_rules; /* Kconfig, builtin & arch rules */
>  	struct list_head ima_policy_rules;  /* arch & custom rules */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 23c559c8fae9..59e4ae5a6361 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -228,6 +228,14 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
>  	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
>  };
>  
> +static void ima_lsm_update_rules(struct ima_namespace *ns);
> +
> +static inline void ima_lazy_lsm_update_rules(struct ima_namespace *ns)
> +{
> +	if (test_and_clear_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags))
> +		ima_lsm_update_rules(ns);
> +}
> +
>  static int ima_policy __initdata;
>  
>  static int __init default_measure_policy_setup(char *str)
> @@ -478,7 +486,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  		return NOTIFY_DONE;
>  
>  	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
> -	ima_lsm_update_rules(ns);
> +
> +	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
>  
>  	return NOTIFY_OK;
>  }
> @@ -705,6 +714,8 @@ int ima_match_policy(struct ima_namespace *ns,
>  	if (template_desc && !*template_desc)
>  		*template_desc = ima_template_desc_current();
>  
> +	ima_lazy_lsm_update_rules(ns);
> +
>  	rcu_read_lock();
>  	ima_rules_tmp = rcu_dereference(ns->ima_rules);
>  	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
> @@ -1907,6 +1918,8 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
>  	struct ima_rule_entry *entry;
>  	struct list_head *ima_rules_tmp;
>  
> +	ima_lazy_lsm_update_rules(ns);
> +
>  	rcu_read_lock();
>  	ima_rules_tmp = rcu_dereference(ns->ima_rules);
>  	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
> -- 
> 2.34.1
