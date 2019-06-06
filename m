Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A883801E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFFV7O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 17:59:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbfFFV7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 17:59:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56Lv5Cs012534
        for <linux-integrity@vger.kernel.org>; Thu, 6 Jun 2019 17:59:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sya05b0m4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 17:59:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Jun 2019 22:59:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 22:59:08 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56Lx7A746923942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 21:59:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36C2C11C04C;
        Thu,  6 Jun 2019 21:59:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B3B311C050;
        Thu,  6 Jun 2019 21:59:06 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 21:59:06 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: use the lsm policy update notifier
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
        paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 06 Jun 2019 17:59:05 -0400
In-Reply-To: <20190605083606.4209-2-janne.karhunen@gmail.com>
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
         <20190605083606.4209-2-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060621-0016-0000-0000-00000286C699
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060621-0017-0000-0000-000032E3E4D1
Message-Id: <1559858345.4278.163.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Janne,

On Wed, 2019-06-05 at 11:36 +0300, Janne Karhunen wrote:
> Don't do lazy policy updates while running the rule matching,
> run the updates as they happen.
> 
> Depends on commit 2d1d5cee66d1 ("LSM: switch to blocking policy update notifiers")
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>

Thanks!  Just a couple of minor things.  Comments inline below.

> ---
>  security/integrity/ima/ima.h        |   2 +
>  security/integrity/ima/ima_main.c   |   8 ++
>  security/integrity/ima/ima_policy.c | 124 +++++++++++++++++++++++-----
>  3 files changed, 114 insertions(+), 20 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..2203451862d4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -154,6 +154,8 @@ unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
>  int __init ima_init_digests(void);
> +int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> +			  void *lsm_data);
>  
>  /*
>   * used to protect h_table and sha_table
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f16353b5097e..9e3ea8a3f2db 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -43,6 +43,10 @@ int ima_appraise;
>  int ima_hash_algo = HASH_ALGO_SHA1;
>  static int hash_setup_done;
>  
> +static struct notifier_block ima_lsm_policy_notifier = {
> +	.notifier_call = ima_lsm_policy_change,
> +};
> +
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -621,6 +625,10 @@ static int __init init_ima(void)
>  		error = ima_init();
>  	}
>  
> +	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> +	if (error)
> +		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> +
>  	if (!error)
>  		ima_update_policy_flag();
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 1cc822a59054..7129dc4cd396 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -249,31 +249,121 @@ static int __init default_appraise_policy_setup(char *str)
>  }
>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
>  
> +static void ima_lsm_free_rule(struct ima_rule_entry *entry)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_RULES; i++) {
> +		kfree(entry->lsm[i].rule);
> +		kfree(entry->lsm[i].args_p);
> +	}
> +	kfree(entry->fsname);
> +	kfree(entry);
> +}

Matthew's patch, which adds per policy template format support, adds a
"template" field to entry.  In case anyone wants to backport this
patch, it might be simpler to make the change as a separate patch.


> +
> +static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> +{
> +	struct ima_rule_entry *nentry;
> +	int i, result;
> +
> +	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
> +	if (!nentry)
> +		return NULL;
> +
> +	memcpy(nentry, entry, sizeof(*nentry));
> +	nentry->fsname = NULL;
> +	for (i = 0; i < MAX_LSM_RULES; i++) {
> +		nentry->lsm[i].rule = NULL;
> +		nentry->lsm[i].args_p = NULL;
> +	}
> +
> +	if (entry->fsname) {
> +		nentry->fsname = kstrdup(entry->fsname, GFP_KERNEL);
> +		if (!nentry->fsname)
> +			goto out_err;
> +	}
> +	for (i = 0; i < MAX_LSM_RULES; i++) {
> +		if (!entry->lsm[i].rule)
> +			continue;
> +
> +		nentry->lsm[i].type = entry->lsm[i].type;
> +		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
> +						GFP_KERNEL);
> +		if (!nentry->lsm[i].args_p)
> +			goto out_err;
> +
> +		result = security_filter_rule_init(nentry->lsm[i].type,
> +						   Audit_equal,
> +						   nentry->lsm[i].args_p,
> +						   &nentry->lsm[i].rule);
> +		if (result == -EINVAL)
> +			pr_warn("ima: rule for LSM \'%d\' is invalid\n",
> +				entry->lsm[i].type);

If LSM labels can come and go, then perhaps instead of saying
"invalid" say "undefined" or "missing".


> +
> +	}
> +	return nentry;
> +
> +out_err:
> +	ima_lsm_free_rule(nentry);
> +	return NULL;
> +}
> +
> +static int ima_lsm_update_rule(struct ima_rule_entry *entry)
> +{
> +	struct ima_rule_entry *nentry;
> +
> +	nentry = ima_lsm_copy_rule(entry);
> +	if (!nentry)
> +		return -ENOMEM;
> +
> +	list_replace_rcu(&entry->list, &nentry->list);
> +	synchronize_rcu();
> +	ima_lsm_free_rule(entry);
> +
> +	return 0;
> +}
> +
>  /*
>   * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
>   * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
> - * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
> - * they don't.
> + * the reloaded LSM policy.
>   */
>  static void ima_lsm_update_rules(void)
>  {
> -	struct ima_rule_entry *entry;
> -	int result;
> -	int i;
> +	struct ima_rule_entry *entry, *e;
> +	int i, result, needs_update;
>  
> -	list_for_each_entry(entry, &ima_policy_rules, list) {
> +	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
> +		needs_update = 0;
>  		for (i = 0; i < MAX_LSM_RULES; i++) {
> -			if (!entry->lsm[i].rule)
> -				continue;
> -			result = security_filter_rule_init(entry->lsm[i].type,
> -							   Audit_equal,
> -							   entry->lsm[i].args_p,
> -							   &entry->lsm[i].rule);
> -			BUG_ON(!entry->lsm[i].rule);
> +			if (entry->lsm[i].rule) {
> +				needs_update = 1;
> +				break;
> +			}
> +		}
> +		if (!needs_update)
> +			continue;
> +
> +		result = ima_lsm_update_rule(entry);
> +		if (result) {
> +			pr_err("ima: lsm rule update error %d\n",
> +				result);

No need for separate line.

Mimi

> +			return;
>  		}
>  	}
>  }
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
>  /**
>   * ima_match_rules - determine whether an inode matches the measure rule.
>   * @rule: a pointer to a rule
> @@ -327,11 +417,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
>  		u32 osid;
> -		int retried = 0;
>  
>  		if (!rule->lsm[i].rule)
>  			continue;
> -retry:
> +
>  		switch (i) {
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
> @@ -352,11 +441,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		default:
>  			break;
>  		}
> -		if ((rc < 0) && (!retried)) {
> -			retried = 1;
> -			ima_lsm_update_rules();
> -			goto retry;
> -		}
>  		if (!rc)
>  			return false;
>  	}

