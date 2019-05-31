Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F85314CF
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2019 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEaSfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 May 2019 14:35:42 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:13818 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaSfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 May 2019 14:35:42 -0400
X-EEMSG-check-017: 715932761|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,535,1549929600"; 
   d="scan'208";a="715932761"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 May 2019 18:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559327735; x=1590863735;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XzrECMSP8bwC0iBuwzVg1F660/PAKKUITgaxu97FBxE=;
  b=P+eFS8eviQ+T27cFx+BrxTZnYZIJWOvZdVe8g91PAxwTL1Y/LBf4DOgj
   0/8va15xQ69z7nv1goLpcO7r/IlcgSVsDwa9sLu3r4iv9l6edvt0+VlKW
   bnhp1fJz5OzZzysUHjwgZYlqC+L/X0FMmORAeM3d6CbqN87YWQV+6QprM
   YGp+J+hNnVPxR2YjhBBeHa1AmgArv3YSKuSLwj2TZO/qBC+j+EDPqUiQ8
   pJ4EjZttS2x7VVd+nBI7lPxjoDN9SqfDVWou8d/elTGFf4Yn3wi952sTR
   jIdCgvAMuRDTDC98I0pUu6AmjT/91Hs/3NDOD1jEeGK6DQKJ7TxtmboAn
   w==;
X-IronPort-AV: E=Sophos;i="5.60,535,1549929600"; 
   d="scan'208";a="28415683"
IronPort-PHdr: =?us-ascii?q?9a23=3AaqWslR2PpBtJGKl7smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUKvXxwZ3uMQTl6Ol3ixeRBMOHsqsC0rGP+Pm6CSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oAvMusUZnIduNKU8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDkq3ufb?=
 =?us-ascii?q?B760FC0gYzzspQ54hUCrEcJvL8REnxucfXDh88KQO0wuLnBM9h2YMZXGKFGr?=
 =?us-ascii?q?WZP7/KsV+U+uIvJPGBZY4SuDb9Mfcl/eXjjXs4mV8bYKmo0oEbaHGjEfRjOU?=
 =?us-ascii?q?mWfX3sgtIZG2cQogU+VPDqiEGFUTNLf3a9Rb885jUgBYK+F4jDW4StjKWE3C?=
 =?us-ascii?q?e8GZ1WfH5JBkqQHnfvcoWOQ+0MZz6KIs99jjwEUqCsS4sg1RGoqQ/7xKNrLu?=
 =?us-ascii?q?vS+i0Eq53j28J15+zPlRAy7jF0Ecud3H+XT21unWMHWSU23KZhrkx50FuD1r?=
 =?us-ascii?q?J4g/NAH9xJ+/xJShs6NYLbz+FiD9DyWwTBfsqGSVq/WdWpHy0+Ts8rw98Pf0?=
 =?us-ascii?q?Z8G8yujhXE3yW3Hr8Vk6KECYcq8qLTwXfxPdxxy3XY26k7iVkpXM9POXehhq?=
 =?us-ascii?q?5l+AiAT7LOxmeQkaCnPYcVxi7Q8mqFhT6MtUdeXUhzWL/FQHYSYGPZqN344g?=
 =?us-ascii?q?XJSLr4Tfw1NQtI0+aGK61Xepvoh1AAT/DmfJzGan+1s3+5GBLNw7SLdoescG?=
 =?us-ascii?q?IYmG3ZCU4Zg0US+2qLOhI/GjaJvW3TFnptGEjpbkeq9vNx7Du/T0kp30SRYk?=
 =?us-ascii?q?Z8zbup61sQgvCBT/47wL0JomEipi9yEVL72MjZWPSaoA80R7lRedMw5h980G?=
 =?us-ascii?q?vdswFsdsi7I7tKmk8VcwMxuVjnkRpwFNMTwoARsHo2wV8qeuqj21RbembdhM?=
 =?us-ascii?q?uhNw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BBBwAfc/Fc/wHyM5BlHQEBBQEHBQGBZYFnKoFtKIQUk?=
 =?us-ascii?q?wdMAQEBAQEBBoEQJYlCDpEICQEBAQEBAQEBATQBAgEBhEACgwQjOBMBAwEBA?=
 =?us-ascii?q?QQBAQEBAwEBbCiCOikBgmcBBSMEEVELGAICJgICITYGAQwGAgEBglMMP4FrA?=
 =?us-ascii?q?wkUq0Z8M4VHgjwNXYFGgQwoi1gXeIEHgTgMgl8+ghqFNIJYBJNtlEc+CYIPg?=
 =?us-ascii?q?heNL4NiBhuCIZRGjHqBKYc/jz0hgVgrCAIYCCEPO4JsghsXjjwjAzCBBgEBj?=
 =?us-ascii?q?XYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 31 May 2019 18:35:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4VIZYEl003437;
        Fri, 31 May 2019 14:35:34 -0400
Subject: Re: [PATCH 2/2] ima: use the lsm policy update notifier
To:     Janne Karhunen <janne.karhunen@gmail.com>, zohar@linux.ibm.com,
        paul@paul-moore.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20190531140237.9199-1-janne.karhunen@gmail.com>
 <20190531140237.9199-2-janne.karhunen@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7a0f17c6-5332-fd48-2727-1f1e2649d356@tycho.nsa.gov>
Date:   Fri, 31 May 2019 14:35:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531140237.9199-2-janne.karhunen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/31/19 10:02 AM, Janne Karhunen wrote:
> Don't do lazy policy updates while running the rule matching,
> run the updates as they happen.
> 
> Depends on commit cda44589be1c ("LSM: switch to blocking policy update notifiers")
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>   security/integrity/ima/ima.h        |  2 ++
>   security/integrity/ima/ima_main.c   |  8 ++++++
>   security/integrity/ima/ima_policy.c | 44 +++++++++++++++++++++--------
>   3 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..2203451862d4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -154,6 +154,8 @@ unsigned long ima_get_binary_runtime_size(void);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
>   int __init ima_init_digests(void);
> +int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> +			  void *lsm_data);
>   
>   /*
>    * used to protect h_table and sha_table
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..f9629c5e1aee 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -43,6 +43,10 @@ int ima_appraise;
>   int ima_hash_algo = HASH_ALGO_SHA1;
>   static int hash_setup_done;
>   
> +static struct notifier_block ima_lsm_policy_notifier = {
> +	.notifier_call = ima_lsm_policy_change,
> +};
> +
>   static int __init hash_setup(char *str)
>   {
>   	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -593,6 +597,10 @@ static int __init init_ima(void)
>   		error = ima_init();
>   	}
>   
> +	error = register_lsm_notifier(&ima_lsm_policy_notifier);
> +	if (error)
> +		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> +
>   	if (!error)
>   		ima_update_policy_flag();
>   
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..4201a21ff42f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -252,12 +252,14 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
>   /*
>    * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
>    * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
> - * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
> - * they don't.
> + * the reloaded LSM policy.
>    */
>   static void ima_lsm_update_rules(void)
>   {
>   	struct ima_rule_entry *entry;
> +	void *rule_new;
> +	char *lsm_new;
> +	char *lsm_old;
>   	int result;
>   	int i;
>   
> @@ -265,15 +267,39 @@ static void ima_lsm_update_rules(void)
>   		for (i = 0; i < MAX_LSM_RULES; i++) {
>   			if (!entry->lsm[i].rule)
>   				continue;
> +
> +			lsm_old = entry->lsm[i].args_p;
> +			lsm_new = kstrdup(lsm_old, GFP_KERNEL);
> +			if (unlikely(!lsm_new))
> +				return;
> +
>   			result = security_filter_rule_init(entry->lsm[i].type,
>   							   Audit_equal,
> -							   entry->lsm[i].args_p,
> -							   &entry->lsm[i].rule);
> -			BUG_ON(!entry->lsm[i].rule);
> +							   lsm_new,
> +							   &rule_new);
> +			if (result == -EINVAL)
> +				pr_warn("ima: rule for LSM \'%d\' is invalid\n",
> +					entry->lsm[i].type);
> +
> +			entry->lsm[i].rule = rule_new;

Doesn't this still leak the old entry->lsm[i].rule?

Also, I don't think you can just mutate entry like this under RCU. 
Don't you need to deep copy the entire entry, initialize the lsm rule in 
the new entry, switch the new entry for the old in the list via the 
appropriate rcu interface e.g. list_replace_rcu, and then free the old 
entry via call_rcu() or after synchronize_rcu()?  Consider how 
audit_update_lsm_rules() works; it takes a mutex to synchronize with 
other writers to the list and calls update_lsm_rule() on every rule. 
update_lsm_rule() checks whether the rule contains a lsm filter via 
security_audit_rule_known(), and if so, deep copies the rule via 
audit_dupe_rule(), replaces the old with the new via list_replace_rcu(), 
and then performs a delayed free of the old rule via call_rcu(). 
audit_dupe_rule() ultimately calls audit_dupe_lsm_field() to "duplicate" 
the LSM field information, which consists of copying the string and then 
calling security_audit_rule_init() aka security_filter_rule_init() to 
create the internal structure representation of the lsm rule from the 
string.  I could be wrong but I don't think you can short-circuit the 
copying or mutate entry in place like this.

> +			entry->lsm[i].args_p = lsm_new;
> +			synchronize_rcu();
> +
> +			kfree(lsm_old);
>   		}
>   	}
>   }
>   
> +int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> +			  void *lsm_data)
> +{
> +	if (event != LSM_POLICY_CHANGE)
> +		return NOTIFY_DONE;
> +
> +	ima_lsm_update_rules();
> +	return NOTIFY_OK;
> +}
> +
>   /**
>    * ima_match_rules - determine whether an inode matches the measure rule.
>    * @rule: a pointer to a rule
> @@ -327,11 +353,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
>   		int rc = 0;
>   		u32 osid;
> -		int retried = 0;
>   
>   		if (!rule->lsm[i].rule)
>   			continue;
> -retry:
> +
>   		switch (i) {
>   		case LSM_OBJ_USER:
>   		case LSM_OBJ_ROLE:
> @@ -352,11 +377,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		default:
>   			break;
>   		}
> -		if ((rc < 0) && (!retried)) {
> -			retried = 1;
> -			ima_lsm_update_rules();
> -			goto retry;
> -		}
>   		if (!rc)
>   			return false;
>   	}
> 

