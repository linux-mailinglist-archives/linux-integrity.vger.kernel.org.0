Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE175075B7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Apr 2022 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiDSRDv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Apr 2022 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355673AbiDSRC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Apr 2022 13:02:29 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14640A14
        for <linux-integrity@vger.kernel.org>; Tue, 19 Apr 2022 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650387051; bh=omPjprIoX5yf5MPB02rCYjbp/no/6cyQKwgZQoCzu3g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=b1T4YeYHJGCmkRwVsiXIzgwBcDdrTUqjrTJc+sxSQVeuuOfQmvb8YHi5M5bpYXW27C16KcCPRTXB+2Nr4QBDvA8yua9fNpWhKUJa4VOacJD3AJssb4ESsl5c30yTPeX6I60GQkJNq6HJwLIX+ZlbbJfaKIuBhp6NRKo16m4h+dtbbF0wkr+5QTOj4Br+AZvagG+RlVt1wmoo+FflzfNaA5VtqRA3RzO3glTDG/W/WHgxAXf4DaxmCUoNa1JROgyehdvdRJLBMAaa2qxVc1M8hvl7ZwThIFAoubtPgWefQBIz+AxbdYtMoZ/VunNkMIdAU/ymJKivBmyUoYmQLhPSXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650387051; bh=GOISVpJ/ysHWets9sbybVeizcf4zuMCK/6k7/GleTMq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BNh3xMygw865M44LA3swtCyhU/CC3fVzxfkymYxZpZnez+c5DULyzYXSq1AiYkjfzJOr72i1NY+PySC5nWZF0HQ+QM7mV5FbT79N30W0szmK03JI0oAbTK+Znh/46TCYIR8OaJzZqqiyNr41vEKs1uccyLKmM8n3qC8uDwPzNYL7ycsGgQeCG1dYPrv5VbsWrVXrpd4DlzjZZicdytyhKkRzhqHoDBBtzTNdrPw3KEz6Xx+z/kaWbKg4nrVCGYM71+FqOxVMt5O2t8hi7w/113ePNagiY6yMpPTHReQFYDiu1U7iIRdecoWCNnPlmKihFb3G9Sx1B+T2Gqy4zpkYkQ==
X-YMail-OSG: AqXnYIQVM1lzmwxuLu1v.yoNNuf5FdbjIeO2yFpD_aTSLf4jcsJ4cK7uiKPodSs
 kD6wXZCxZQtts8tGD2fTUIyJICPLXaOyauPILWA19DcTH6OYZrUoL4ff9hwQUkMCYY979j_zS91I
 hh4orjzzR9hWCB72.SRD_Qvc1d1ygew6gtb2VPI6jkrSdHRMNgVOz4adZy4qK9nOeQR5mqWGaodR
 X7h2RkLEvSrNq9dqiKAyDlCHA1I9LGl2ofFx2g9Rem6dni3PV3cIJ3UXPAKcSx.7rU20BbwOpSrC
 Rg3OcrnrSyQUzkeA3GnulimKMf2Yg1ERQBeVigP9Jk1ObihckJ0iUzMoG..t28CEQsWqrtQNw_Dd
 9WjYw_ItK7tckUaZ2k2QzjFclADjpT11Nzl96pvxWSfUC99anrYFubslHARC0OjBbHOAXkLCOQ7o
 65UWlOAPqxQCqf.UflSU.jkHZtr4irOzFK0nkpogob8gN00SizGlbTVV.BEXlOuDupZHo8GPlpGo
 ponFImP.FoyTJ_PPUXaBzY95bCfIhZlqsws2e.4sKWSPn20PPRsGorcuD609fI5Ip2PW0IZrVLHl
 tApKFcuH7C7xM5NEBXZkxuX2eGIlfWe49aKBvJD_XVtjTSaa7HsA3E5tfNNL24eg_co3DPU7dbVl
 rs9JqyoGON6JaQf468V9W6UlHwOgd6LQ2z0J8ItoJ265cWtM0Vwf6l_7To3KPGPclovCVLzGwscf
 nMBT_RIugy1IEmAP41jC1bfzulh8COE7nQGC4yY1E5GaHBzc32JotcBzC_JjhHft3MFyRcniXL3I
 r_1.xJoS41yDlMzY.J8ROeYqUWpy3h.C3n7D1tumDcHVma6WtxXkq4NDUVJ4PZc1MyoRj0h4IPCj
 c.xFIlnA8ob0XXqteSIuJ0vwJaqxsraeM3dlaAFGC7jgTasK0ZfegLgqH2.jIHlh1p.ozN8CP945
 t4K_7JJEkSomH9m6Qd3ruAvnPF7n8E0ZlhKSqir4un0ZQG5kzJWBZXrA6o.e3i9caUiHm7FjI4eA
 i549zPsX1rMgRd_Rw6TohB59gen5IcG68yHN7ilezFr0dGcmvx82wGA9f7ejeS4yKmxTkWK8cRPg
 9tEgRKaBw9tlG2Kr9BrlsXgPUnDEM9QwJROM1coROe0SIOSY.GsTBmgCQlYTb_Z0Q4Ls1CAq_P9p
 QO56UlVpkGnS4rco0jYgPnBpjkRGgbKuOWHrPwGZfEnLx6TGUzsyKIMrIpq60WTQGZkdBszdZ7Nd
 .HSCYL5s69J5Nh5tk3crxYC0RfcMCiO9pJamc6KkMtPbmqC..xZ7fhMepUbCEX4KMmLmBaALPYAY
 ZSOA4DPQ3Hkij1h7MxGftJGXlBwTv4ZF_hSUeMgx3BBOWVaavqdAOtWYvI5Wk.FiOnxEZvHjykWN
 vtHABynI_ab235Sabj0GjHkIS_V0n_1DO3UV39hKnvCDvr0iLKL465DmUYdNm5XPlaDvu22zALlq
 M6Pe5Ks4dKBHvHg2t2HqR.Tpsz25pfu1j.7yB6z5c4oNfF46DuO7.28ewY3FslyLFIKJHsAeFKMi
 fnMiQhAiMJ6D5zCPnjZaR9lDDgjISpGfITzDtqnLErKY6SRtsaEIEFy_C112W8C7qbIDziunw.n4
 WqPYXeWqS_C5_zJctaGUb9wPUlQXaCuVZMgqLirbPdgkU4Xvur5KWBW69Sq7I55tQGwNB6TPE6Iu
 PozEZYpHPpzOeDgMvZIOZv4S3tXndMT7OQQhe.ExQ0lkpAsKdUxxQNvQXxEdIMIxqWTgY94aRDdN
 9z5mwxVrzfRdhp94udna_xmDUjTrWbh8njvWKGDWu1cAC1_Mir3G2bRaACeHFS.MSOTL534w_qql
 T2x.jlbozCE4eifEdW1kAtpqO42FI36iux_p1Yp.yb60V_oMEfmeAHOpzUWOwVtcBxgVyLSd6pmg
 ld3l4ovftpkXQ9cus..oli3BJGNj9YNPb5BxYCYz.4P3RIuGcFZEAkeN9f9mpCxCZAElQuQ_DyoS
 _.u.gysno5YypewXdDiG4U80wMbZs2JCUvYv.5Xg27UYZA8.n3rgPaEihcOSgqP7UmDkkexFwIuB
 IBAFPu5XYt75GoVuxQHgGhLYNWstjI1oVsMJO0m4qjTLwYOElkOjMt1tgF_FUSvgMFns_TJKRSA6
 kTXkxCCOpclnOi0K0jwE4YNWoBU654Vkm888FTZDozZhnbks4pkBG006FbWQ6zELAueHXG_jdrxf
 T8M8BSam4rePhKPtOaIVp2.EsG4mhTg.jsLBrEEXzhCE22WQGSY6VsIctjnd3qn.fcryA5Lb9
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Apr 2022 16:50:51 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-xjccz (VZM Hermes SMTP Server) with ESMTPA ID ea3ba134e5f56be0aa4d06ea497fbf71;
          Tue, 19 Apr 2022 16:50:46 +0000 (UTC)
Message-ID: <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
Date:   Tue, 19 Apr 2022 09:50:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-6-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20048 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/18/2022 7:59 AM, Casey Schaufler wrote:
> Integrity measurement may filter on security module information
> and needs to be clear in the case of multiple active security
> modules which applies. Provide a boot option ima_rules_lsm= to
> allow the user to specify an active security module to apply
> filters to. If not specified, use the first registered module
> that supports the audit_rule_match() LSM hook. Allow the user
> to specify in the IMA policy an lsm= option to specify the
> security module to use for a particular rule.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: linux-integrity@vger.kernel.org

Would it be possible to get feedback on the IMA portions
of the stacking patch set? I believe that I have addressed
previous issues. I need to wrap this up before too long.
Thank you.

> ---
>   Documentation/ABI/testing/ima_policy |  8 ++++-
>   include/linux/security.h             | 14 ++++----
>   security/integrity/ima/ima_policy.c  | 51 ++++++++++++++++++++++++----
>   security/security.c                  | 35 +++++++++++++++----
>   4 files changed, 89 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 839fab811b18..64863e9d87ea 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -26,7 +26,7 @@ Description:
>   				[uid=] [euid=] [gid=] [egid=]
>   				[fowner=] [fgroup=]]
>   			lsm:	[[subj_user=] [subj_role=] [subj_type=]
> -				 [obj_user=] [obj_role=] [obj_type=]]
> +				 [obj_user=] [obj_role=] [obj_type=]] [lsm=]
>   			option:	[[appraise_type=]] [template=] [permit_directio]
>   				[appraise_flag=] [appraise_algos=] [keyrings=]
>   		  base:
> @@ -126,6 +126,12 @@ Description:
>   
>   			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
>   
> +		It is possible to explicitly specify which security
> +		module a rule applies to using lsm=.  If the security
> +		module specified is not active on the system the rule
> +		will be rejected.  If lsm= is not specified the first
> +		security module registered on the system will be assumed.
> +
>   		Example of measure rules using alternate PCRs::
>   
>   			measure func=KEXEC_KERNEL_CHECK pcr=4
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d00870d2b416..3666eddad59a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1985,25 +1985,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
>   #endif /* CONFIG_AUDIT */
>   
>   #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> -void ima_filter_rule_free(void *lsmrule);
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			 int lsmslot);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmslot);
> +void ima_filter_rule_free(void *lsmrule, int lsmslot);
>   
>   #else
>   
>   static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -					   void **lsmrule)
> +				       void **lsmrule, int lsmslot)
>   {
>   	return 0;
>   }
>   
>   static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +					void *lsmrule, int lsmslot)
>   {
>   	return 0;
>   }
>   
> -static inline void ima_filter_rule_free(void *lsmrule)
> +static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
>   { }
>   
>   #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index eea6e92500b8..97470354c8ae 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -89,6 +89,7 @@ struct ima_rule_entry {
>   	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
>   	int pcr;
>   	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
> +	int which;		/* which LSM rule applies to */
>   	struct {
>   		void *rule;	/* LSM file metadata specific */
>   		char *args_p;	/* audit value */
> @@ -285,6 +286,20 @@ static int __init default_appraise_policy_setup(char *str)
>   }
>   __setup("ima_appraise_tcb", default_appraise_policy_setup);
>   
> +static int ima_rules_lsm __ro_after_init;
> +
> +static int __init ima_rules_lsm_init(char *str)
> +{
> +	ima_rules_lsm = lsm_name_to_slot(str);
> +	if (ima_rules_lsm < 0) {
> +		ima_rules_lsm = 0;
> +		pr_err("rule lsm \"%s\" not registered", str);
> +	}
> +
> +	return 1;
> +}
> +__setup("ima_rules_lsm=", ima_rules_lsm_init);
> +
>   static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>   {
>   	struct ima_rule_opt_list *opt_list;
> @@ -356,7 +371,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>   	int i;
>   
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		ima_filter_rule_free(entry->lsm[i].rule);
> +		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
>   		kfree(entry->lsm[i].args_p);
>   	}
>   }
> @@ -407,7 +422,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>   
>   		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>   				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     entry->which);
>   		if (!nentry->lsm[i].rule)
>   			pr_warn("rule for LSM \'%s\' is undefined\n",
>   				nentry->lsm[i].args_p);
> @@ -623,14 +639,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>   			security_inode_getsecid(inode, &osid);
>   			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
>   						   Audit_equal,
> -						   rule->lsm[i].rule);
> +						   rule->lsm[i].rule,
> +						   rule->which);
>   			break;
>   		case LSM_SUBJ_USER:
>   		case LSM_SUBJ_ROLE:
>   		case LSM_SUBJ_TYPE:
>   			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>   						   Audit_equal,
> -						   rule->lsm[i].rule);
> +						   rule->lsm[i].rule,
> +						   rule->which);
>   			break;
>   		default:
>   			break;
> @@ -1025,7 +1043,7 @@ enum policy_opt {
>   	Opt_fowner_lt, Opt_fgroup_lt,
>   	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>   	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_lsm, Opt_label, Opt_err
>   };
>   
>   static const match_table_t policy_tokens = {
> @@ -1073,6 +1091,7 @@ static const match_table_t policy_tokens = {
>   	{Opt_template, "template=%s"},
>   	{Opt_keyrings, "keyrings=%s"},
>   	{Opt_label, "label=%s"},
> +	{Opt_lsm, "lsm=%s"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -1091,7 +1110,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>   	entry->lsm[lsm_rule].type = audit_type;
>   	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>   				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      entry->which);
>   	if (!entry->lsm[lsm_rule].rule) {
>   		pr_warn("rule for LSM \'%s\' is undefined\n",
>   			entry->lsm[lsm_rule].args_p);
> @@ -1780,6 +1800,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   						 &(template_desc->num_fields));
>   			entry->template = template_desc;
>   			break;
> +		case Opt_lsm:
> +			result = lsm_name_to_slot(args[0].from);
> +			if (result == LSMBLOB_INVALID) {
> +				int i;
> +
> +				for (i = 0; i < MAX_LSM_RULES; i++)
> +					entry->lsm[i].args_p = NULL;
> +				result = -EINVAL;
> +				break;
> +			}
> +			entry->which = result;
> +			result = 0;
> +			break;
>   		case Opt_err:
>   			ima_log_string(ab, "UNKNOWN", p);
>   			result = -EINVAL;
> @@ -1816,6 +1849,7 @@ ssize_t ima_parse_add_rule(char *rule)
>   	struct ima_rule_entry *entry;
>   	ssize_t result, len;
>   	int audit_info = 0;
> +	int i;
>   
>   	p = strsep(&rule, "\n");
>   	len = strlen(p) + 1;
> @@ -1833,6 +1867,9 @@ ssize_t ima_parse_add_rule(char *rule)
>   
>   	INIT_LIST_HEAD(&entry->list);
>   
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		entry->which = ima_rules_lsm;
> +
>   	result = ima_parse_rule(p, entry);
>   	if (result) {
>   		ima_free_rule(entry);
> @@ -2158,6 +2195,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>   		seq_puts(m, "appraise_flag=check_blacklist ");
>   	if (entry->flags & IMA_PERMIT_DIRECTIO)
>   		seq_puts(m, "permit_directio ");
> +	if (entry->which >= 0)
> +		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
>   	rcu_read_unlock();
>   	seq_puts(m, "\n");
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index d1ddbb857af1..9e0139b0d346 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2728,19 +2728,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
>    * The integrity subsystem uses the same hooks as
>    * the audit subsystem.
>    */
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			 int lsmslot)
>   {
> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list)
> +		if (hp->lsmid->slot == lsmslot)
> +			return hp->hook.audit_rule_init(field, op, rulestr,
> +							lsmrule);
> +
> +	return 0;
>   }
>   
> -void ima_filter_rule_free(void *lsmrule)
> +void ima_filter_rule_free(void *lsmrule, int lsmslot)
>   {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
> +		if (hp->lsmid->slot == lsmslot) {
> +			hp->hook.audit_rule_free(lsmrule);
> +			return;
> +		}
> +	}
>   }
>   
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmslot)
>   {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list)
> +		if (hp->lsmid->slot == lsmslot)
> +			return hp->hook.audit_rule_match(secid, field, op,
> +							 lsmrule);
> +
> +	return 0;
>   }
>   #endif /* CONFIG_IMA_LSM_RULES */
>   
