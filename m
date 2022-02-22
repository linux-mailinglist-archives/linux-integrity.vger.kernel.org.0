Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266D74C054A
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 00:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiBVXVF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 18:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiBVXVE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 18:21:04 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938759135B
        for <linux-integrity@vger.kernel.org>; Tue, 22 Feb 2022 15:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645572037; bh=jX9Ne/24XCMfi0KpRq8rQ8TvkCiVQiIPX4/wL8yvtH4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=S+17Hqq/wDiv/axpXNg6YoEebHONcnmql09Mst+V7BANyi1j/7NY8JQ+aLSem8ZqZClhzJC1YTkcp/WDIDiQG0+jp53qaah3w7YuYvSR3wojNENGIuhCAGtawwhXuZ0AHI35cKyAqSCPbNDRNIKSn5/JwoGHSo7RElChsMuTK3ieiOvjq3FnlnMfZe/7FdN4KZWJYjkJpOq0q2kresZY0s7L+WYZ5/NGSg9l4E7WfrSqGyRJ1yPewDegJzdRXvue2lisPKglTTMwhRNt0kv1bpcejxg5sitan/8nwratUKRLg2dfhwo9ezPISv23WVrIPjVrgOEl+6xintMVvh1zUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645572037; bh=LDbTAt8ToEJrso7dZ6BlqKK6YmuDzoiBy/N8ZRvbrD9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eE/ZPT/iqlJbdNA1688CEd1Q9K/DcLHMfDtxSJyiwlGOK1jjNyHUMG/IMPo4xamqD2atTHTzP/BWyN2nrcUPTO+pSf1KFC/jGDrXV5PY+x48yzX1CsMt5RVQkgEnRoP89kJiNcL89MGoE1Vvu3B+PhBiYeEHoFOlQz2Ro2TVK/rOr81lpbCrMrRMRy/RKLaxQD76HoXr0OiI4AMsmBj1r9SDri1WyWAQ4N7wSiqTJR95mdYhC5sk5vJ+iG3amsRnLMsqRf2X7jI8a6KZoD9NtYmDZjGpw+8zuaakoThCpdaY5w4aFq3g2jUHDFT8EXRspOMkxPPhZWe/AYqX8XquwQ==
X-YMail-OSG: ZQFh82kVM1mp3ilF4MPFyWGzeXc1AXYCeCPv4xIiFMPYIsgvE1qklo3ri1i9peG
 4V_tLP5MuhjxxAb5opYvZlRwISFossJkEjgs1BKnpxC2c6OFlbFy2L6vGo1Qn.CTeG6kcwRxOZF9
 Ko6z8NSye0A7_yOVIv98DYvTUFC1E1eVGBxVhRTxTme70UXJXStDU6AEa0rJnQaLXChvfqlrDnt5
 cAEDtLv1WsCs8mtRBOk0FmwRcrMNF4bhm1meGuNWZ6QdoObe92GjWCFm_H0wqRyKi0WRf.OOwZ2z
 x9dpbRMEsk1D7MLtGQOEfzlzMOtOtT2eYKVuj2g41yjYUYLC6tORhLsHxTArQhIz7J9e8tq11s6N
 n5xu3Xc5LGkQMXIS0oz4xsc5JdmJ94SS0DSWQmWR53pyCWvgBVtACJblZ3ybJC5hWEwhlxnlX4r.
 SiIWbPoPL5mKjBknV4ytEEfS3_fAatxyV0HRELL1RzHHxTa7wzZ6ly8ypiY1B6V.6kt4EaAB1UEl
 JCGHH9LjyFp2gNX7h60pEnAfEg85GTNxCqmGLxSOUVFJvU4STITMY8euuRrswuC3Xd5zmdqT9M13
 0P_N7kERZI9sJ3uNhktMbFPe4.1WhtluIeAJZVboLkNJzsarQWvV8uEbzhL6oJ86DW_kftiBy43Q
 VV7hxY17UbTBZqf4DzriJr9UzImClKPmHNCv9qQEIzLrcPkryDo57Ji70X.P7upgih8XzvY8GBth
 fzBhS6HGu.nv6w4vEtXX_3kEwj5iO3ZEZMVTLwdjjloNx1YNI8ViQpqOMzPAFs1XWL3by3hxmJbG
 7uSn0c0u8Yy3OmZhlhQoJlwe.YQghIxocTxZhE4L3WgVmRJGCDirEgCX65H3btIidUqvDhtn8K9n
 hhrrAvSR7FR7RKNJ9ibRNotb4wZh7_NmKN8SB0s1JmslZQHV4lSWMfGl3U8hvt5Z1ZOFNkeeVtTR
 nEaGVpVoqrVN0n3QW3ebaBt5GwterZKIwCzHSzxG_CJm.u2k6oR.f2.aUFYsBX17el1Q1svQttvv
 Zp0ihcrpQSQB_aR0YYENFYTOo5x8Meje5dzB5csl1dqVO24LS6bbll.mni0uP8Vs0xUyy36.GW3w
 OAwJ8G.WfI71eF4oNhhQ3r53l50hwQP9FBS3DX5dZpFa8q632YDIfDIZecrK6tWWB2T6nrxUdNC7
 8knTrxA9FPM2NmPFVdMepw7hhb5MEICVGtW3etVHhGnDjV1XZ47I0R_9vnHWn6MJDQBjakfoZ_1e
 LkcrAumYDx69iXxfpnAZCwFAog4xaWkSl0pqIA_G1j_qxRdjq.F3X6usfi5fieObJixxWzBVy1ye
 F11eB.eoagEZSjl8vTjZ5BAtC4PjJQFIsCvI5nqYXE7F3OG7PzHUS08hbEozz.rgLRQTCeGi3.R9
 vr8.Xz6KXGo3SlDJFkBIf_B4ou5fIX9pVJ4OXl43FMpqMie2.D2ugzQ4h33BmTQj60yu3Ieem6eP
 vPV0V1J0CaBoX1grtV6F_Xs6jr82qD18cZHB0SDFmK6TnCcqcjdimMutgTUB8HY35sd7hiLLR8qM
 ycq9ccIscxl6.jhktVDwFk1dmYCTgHregkd4Giyx_UhTt8U0DzJRgltsltU3Li5di55oMFgzCuYE
 iDzc0TQTHidYUUSSDILLICpQ.l9cFXh2go9cq57OKBftDRl0BDZqjxEnnI4C6UffWNbtTszIYzdJ
 fqAO.4UI0KLbi4brdoI8CTS0_W6yqPAWjWBnN.Hhbx_mgTbbs79BBjlcbf0DfkK3es8X.TrfGoJd
 1um1AvEG8A9zNBwDTFP7LeEyLva9lAvep7VWftaUDlYnDpRT7pOsUdKvb19Dpiwz0ICv9eHKhYAe
 Zv2TgML_lNG0EHZLA8ZY0kpDInVIb.wghTkY1XazT_nC3L6c7zUISvHhJxc0DLkTrFflr0v2bkl4
 OhuEsnEUS0i85FtKeH8WdY_UhMG_GobEmRy1VjfThSxLxhqmHtaxyjc6np0eBDpSnkwWNqqZRRZY
 _K.PDSvqsJsJFORyhXcym0.l4PKB_LuSx.cpy5QGNhLio7VyAurpVAQnTwaXeJ1OvzP7YyT3lQT6
 7MqAsqqmrz.kG8b.ghUUlAUHyH_xrqdTdpzgilCeCEgI48xqJWl9GKIcrnGpUtYT1A.Fz8V3OZhI
 dj7q6eH3J6J290NkCFBA1nNjn8RM49ZOG8Qro7J8JPAGyGYQaPAOI9SfwEpU9RO4Lha7TFi83ISI
 NO7c99QwZbDoDgZEVcIJV9V601E3CruAgVdLIngY8HaOZaxPV7wA0tVLY8toEUwSb7O8deNvK5uo
 E05.91bMTXMgR0h3uLGI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 22 Feb 2022 23:20:37 +0000
Received: by kubenode517.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c1b5881b50d366b9760fbab12c25b3c5;
          Tue, 22 Feb 2022 23:20:31 +0000 (UTC)
Message-ID: <086b7e0c-132b-bcb9-9d15-ee467c1676ee@schaufler-ca.com>
Date:   Tue, 22 Feb 2022 15:20:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 05/28] IMA: avoid label collisions with stacked LSMs
Content-Language: en-US
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-6-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220202235323.23929-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/2/2022 3:53 PM, Casey Schaufler wrote:
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

Is there a chance that someone from the integrity team
could have a review off this patch in particular and the
set in general? Please?

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
> index 6da0c12c9170..1edbb362ee72 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1977,25 +1977,27 @@ static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
>   
>   #ifdef CONFIG_IMA_LSM_RULES
>   #ifdef CONFIG_SECURITY
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
> +					   void **lsmrule, int lsmslot)
>   {
>   	return 0;
>   }
>   
>   static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +					    void *lsmrule, int lsmslot)
>   {
>   	return 0;
>   }
>   
> -static inline void ima_filter_rule_free(void *lsmrule)
> +static inline void ima_filter_rule_free(void *lsmrule, int lsmslot)
>   { }
>   
>   #endif /* CONFIG_SECURITY */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 320ca80aacab..22952efcc0b0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -90,6 +90,7 @@ struct ima_rule_entry {
>   	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
>   	int pcr;
>   	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
> +	int which;		/* which LSM rule applies to */
>   	struct {
>   		void *rule;	/* LSM file metadata specific */
>   		char *args_p;	/* audit value */
> @@ -286,6 +287,20 @@ static int __init default_appraise_policy_setup(char *str)
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
> @@ -357,7 +372,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>   	int i;
>   
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		ima_filter_rule_free(entry->lsm[i].rule);
> +		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
>   		kfree(entry->lsm[i].args_p);
>   	}
>   }
> @@ -408,7 +423,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>   
>   		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>   				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     entry->which);
>   		if (!nentry->lsm[i].rule)
>   			pr_warn("rule for LSM \'%s\' is undefined\n",
>   				nentry->lsm[i].args_p);
> @@ -624,14 +640,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
> @@ -1026,7 +1044,7 @@ enum policy_opt {
>   	Opt_fowner_lt, Opt_fgroup_lt,
>   	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>   	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_lsm, Opt_label, Opt_err
>   };
>   
>   static const match_table_t policy_tokens = {
> @@ -1074,6 +1092,7 @@ static const match_table_t policy_tokens = {
>   	{Opt_template, "template=%s"},
>   	{Opt_keyrings, "keyrings=%s"},
>   	{Opt_label, "label=%s"},
> +	{Opt_lsm, "lsm=%s"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -1092,7 +1111,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>   	entry->lsm[lsm_rule].type = audit_type;
>   	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>   				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      entry->which);
>   	if (!entry->lsm[lsm_rule].rule) {
>   		pr_warn("rule for LSM \'%s\' is undefined\n",
>   			entry->lsm[lsm_rule].args_p);
> @@ -1781,6 +1801,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
> @@ -1817,6 +1850,7 @@ ssize_t ima_parse_add_rule(char *rule)
>   	struct ima_rule_entry *entry;
>   	ssize_t result, len;
>   	int audit_info = 0;
> +	int i;
>   
>   	p = strsep(&rule, "\n");
>   	len = strlen(p) + 1;
> @@ -1834,6 +1868,9 @@ ssize_t ima_parse_add_rule(char *rule)
>   
>   	INIT_LIST_HEAD(&entry->list);
>   
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		entry->which = ima_rules_lsm;
> +
>   	result = ima_parse_rule(p, entry);
>   	if (result) {
>   		ima_free_rule(entry);
> @@ -2151,6 +2188,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>   		seq_puts(m, "appraise_flag=check_blacklist ");
>   	if (entry->flags & IMA_PERMIT_DIRECTIO)
>   		seq_puts(m, "permit_directio ");
> +	if (entry->which >= 0)
> +		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));
>   	rcu_read_unlock();
>   	seq_puts(m, "\n");
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index 03a0af7e9e81..29fc50322b1f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2708,19 +2708,42 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op,
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
