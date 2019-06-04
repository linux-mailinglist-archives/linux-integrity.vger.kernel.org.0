Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11B34A68
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFDO3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 10:29:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727169AbfFDO3H (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 10:29:07 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8D924273BFC9CF83C3EE;
        Tue,  4 Jun 2019 15:29:05 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Jun
 2019 15:29:03 +0100
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA template
To:     Matthew Garrett <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.vnet.ibm.com>, <prsriva02@gmail.com>,
        <bauerman@linux.ibm.com>, Matthew Garrett <mjg59@google.com>
References: <20190603201322.7443-1-matthewgarrett@google.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <56c0a4bd-3417-ce95-ecda-5b43fededcef@huawei.com>
Date:   Tue, 4 Jun 2019 16:29:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190603201322.7443-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/3/2019 10:13 PM, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Updated based on review feedback, verified that I can generate an event
> log that contains multiple different templates.
> 
>   Documentation/ABI/testing/ima_policy  |  6 ++++--
>   security/integrity/ima/ima.h          | 13 +++++++++----
>   security/integrity/ima/ima_api.c      | 24 ++++++++++++++++-------
>   security/integrity/ima/ima_appraise.c |  2 +-
>   security/integrity/ima/ima_init.c     |  2 +-
>   security/integrity/ima/ima_main.c     |  9 +++++----
>   security/integrity/ima/ima_policy.c   | 28 +++++++++++++++++++++++++--
>   security/integrity/ima/ima_template.c | 10 ++++++++--
>   8 files changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 74c6702de74e..4ded0668a22d 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -24,8 +24,7 @@ Description:
>   				[euid=] [fowner=] [fsname=]]
>   			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>   				 [obj_user=] [obj_role=] [obj_type=]]
> -			option:	[[appraise_type=]] [permit_directio]
> -
> +			option:	[[appraise_type=]] [template=] [permit_directio]
>   		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>   				[FIRMWARE_CHECK]
>   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> @@ -38,6 +37,9 @@ Description:
>   			fowner:= decimal value
>   		lsm:  	are LSM specific
>   		option:	appraise_type:= [imasig]
> +			template:= name or format of a defined IMA template
> +			type (eg,ima-ng or d-ng|n-ng). Only valid when action
> +			is "measure".
>   			pcr:= decimal value
>   
>   		default policy:
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..18b48a6d0b80 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -147,6 +147,7 @@ int ima_init_crypto(void);
>   void ima_putc(struct seq_file *m, void *data, int datalen);
>   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
>   struct ima_template_desc *ima_template_desc_current(void);
> +struct ima_template_desc *lookup_template_desc(const char *name);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> @@ -193,7 +194,8 @@ enum ima_hooks {
>   
>   /* LIM API function definitions */
>   int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr);
> +		   int mask, enum ima_hooks func, int *pcr,
> +		   struct ima_template_desc **template_desc);
>   int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>   int ima_collect_measurement(struct integrity_iint_cache *iint,
>   			    struct file *file, void *buf, loff_t size,
> @@ -201,11 +203,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>   			   const unsigned char *filename,
>   			   struct evm_ima_xattr_data *xattr_value,
> -			   int xattr_len, int pcr);
> +			   int xattr_len, int pcr,
> +			   struct ima_template_desc *template_desc);
>   void ima_audit_measurement(struct integrity_iint_cache *iint,
>   			   const unsigned char *filename);
>   int ima_alloc_init_template(struct ima_event_data *event_data,
> -			    struct ima_template_entry **entry);
> +			    struct ima_template_entry **entry,
> +			    struct ima_template_desc *template_desc);
>   int ima_store_template(struct ima_template_entry *entry, int violation,
>   		       struct inode *inode,
>   		       const unsigned char *filename, int pcr);
> @@ -214,7 +218,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
>   
>   /* IMA policy related functions */
>   int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr);
> +		     enum ima_hooks func, int mask, int flags, int *pcr,
> +		     struct ima_template_desc **template_desc);
>   void ima_init_policy(void);
>   void ima_update_policy(void);
>   void ima_update_policy_flag(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c7505fb122d4..78eb11c7ac07 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -38,11 +38,17 @@ void ima_free_template_entry(struct ima_template_entry *entry)
>    * ima_alloc_init_template - create and initialize a new template entry
>    */
>   int ima_alloc_init_template(struct ima_event_data *event_data,
> -			    struct ima_template_entry **entry)
> +			    struct ima_template_entry **entry,
> +			    struct ima_template_desc *desc)
>   {
> -	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	struct ima_template_desc *template_desc;
>   	int i, result = 0;
>   
> +	if (desc)
> +		template_desc = desc;
> +	else
> +		template_desc = ima_template_desc_current();
> +
>   	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
>   			 sizeof(struct ima_field_data), GFP_NOFS);
>   	if (!*entry)
> @@ -141,7 +147,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   	/* can overflow, only indicator */
>   	atomic_long_inc(&ima_htable.violations);
>   
> -	result = ima_alloc_init_template(&event_data, &entry);
> +	result = ima_alloc_init_template(&event_data, &entry, NULL);
>   	if (result < 0) {
>   		result = -ENOMEM;
>   		goto err_out;
> @@ -164,6 +170,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    *        MAY_APPEND)
>    * @func: caller identifier
>    * @pcr: pointer filled in if matched measure policy sets pcr=
> + * @template_desc: pointer filled in if matched measure policy sets template=
>    *
>    * The policy is defined in terms of keypairs:
>    *		subj=, obj=, type=, func=, mask=, fsmagic=
> @@ -176,13 +183,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    *
>    */
>   int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr)
> +		   int mask, enum ima_hooks func, int *pcr,
> +		   struct ima_template_desc **template_desc)
>   {
>   	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>   
>   	flags &= ima_policy_flag;
>   
> -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
> +	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
> +				template_desc);
>   }
>   
>   /*
> @@ -277,7 +286,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   void ima_store_measurement(struct integrity_iint_cache *iint,
>   			   struct file *file, const unsigned char *filename,
>   			   struct evm_ima_xattr_data *xattr_value,
> -			   int xattr_len, int pcr)
> +			   int xattr_len, int pcr,
> +			   struct ima_template_desc *template_desc)
>   {
>   	static const char op[] = "add_template_measure";
>   	static const char audit_cause[] = "ENOMEM";
> @@ -291,7 +301,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>   	if (iint->measured_pcrs & (0x1 << pcr))
>   		return;
>   
> -	result = ima_alloc_init_template(&event_data, &entry);
> +	result = ima_alloc_init_template(&event_data, &entry, template_desc);
>   	if (result < 0) {
>   		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
>   				    op, audit_cause, result, 0);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 5fb7127bbe68..2f6536ab69e8 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -57,7 +57,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>   
>   	security_task_getsecid(current, &secid);
>   	return ima_match_policy(inode, current_cred(), secid, func, mask,
> -				IMA_APPRAISE | IMA_HASH, NULL);
> +				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>   }
>   
>   static int ima_fix_xattr(struct dentry *dentry,
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 6c9295449751..993d0f1915ff 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -72,7 +72,7 @@ static int __init ima_add_boot_aggregate(void)
>   		}
>   	}
>   
> -	result = ima_alloc_init_template(&event_data, &entry);
> +	result = ima_alloc_init_template(&event_data, &entry, NULL);
>   	if (result < 0) {
>   		audit_cause = "alloc_entry";
>   		goto err_out;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..83c5dea0d939 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -174,7 +174,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   {
>   	struct inode *inode = file_inode(file);
>   	struct integrity_iint_cache *iint = NULL;
> -	struct ima_template_desc *template_desc;
> +	struct ima_template_desc *template_desc = NULL;
>   	char *pathbuf = NULL;
>   	char filename[NAME_MAX];
>   	const char *pathname = NULL;
> @@ -192,7 +192,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	 * bitmask based on the appraise/audit/measurement policy.
>   	 * Included is the appraise submask.
>   	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
> +	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
> +				&template_desc);
>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>   			   (ima_policy_flag & IMA_MEASURE));
>   	if (!action && !violation_check)
> @@ -275,7 +276,6 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   		goto out_locked;
>   	}
>   
> -	template_desc = ima_template_desc_current();
>   	if ((action & IMA_APPRAISE_SUBMASK) ||
>   		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
>   		/* read 'security.ima' */
> @@ -292,7 +292,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   
>   	if (action & IMA_MEASURE)
>   		ima_store_measurement(iint, file, pathname,
> -				      xattr_value, xattr_len, pcr);
> +				      xattr_value, xattr_len, pcr,
> +				      template_desc);
>   	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
>   		inode_lock(inode);
>   		rc = ima_appraise_measurement(func, iint, file, pathname,
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 0f6fe53cef09..cbae2a3a9c5b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -80,6 +80,7 @@ struct ima_rule_entry {
>   		int type;	/* audit type */
>   	} lsm[MAX_LSM_RULES];
>   	char *fsname;
> +	struct ima_template_desc *template;
>   };
>   
>   /*
> @@ -397,6 +398,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>    * @func: IMA hook identifier
>    * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>    * @pcr: set the pcr to extend
> + * @template_desc: the template that should be used for this rule
>    *
>    * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>    * conditions.
> @@ -406,7 +408,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>    * than writes so ima_match_policy() is classical RCU candidate.
>    */
>   int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr)
> +		     enum ima_hooks func, int mask, int flags, int *pcr,
> +		     struct ima_template_desc **template_desc)
>   {
>   	struct ima_rule_entry *entry;
>   	int action = 0, actmask = flags | (flags << 1);
> @@ -438,6 +441,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>   		if ((pcr) && (entry->flags & IMA_PCR))
>   			*pcr = entry->pcr;
>   
> +		if (template_desc && entry->template)
> +			*template_desc = entry->template;
> +		else
> +			*template_desc = ima_template_desc_current();
> +
>   		if (!actmask)
>   			break;
>   	}
> @@ -676,7 +684,7 @@ enum {
>   	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>   	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>   	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_err
> +	Opt_pcr, Opt_template, Opt_err
>   };
>   
>   static const match_table_t policy_tokens = {
> @@ -710,6 +718,7 @@ static const match_table_t policy_tokens = {
>   	{Opt_appraise_type, "appraise_type=%s"},
>   	{Opt_permit_directio, "permit_directio"},
>   	{Opt_pcr, "pcr=%s"},
> +	{Opt_template, "template=%s"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -763,6 +772,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   	char *from;
>   	char *p;
>   	bool uid_token;
> +	struct ima_template_desc *template_desc;
>   	int result = 0;
>   
>   	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
> @@ -1059,6 +1069,18 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   				entry->flags |= IMA_PCR;
>   
>   			break;
> +		case Opt_template:
> +			ima_log_string(ab, "template", args[0].from);
> +			if (entry->action != MEASURE) {
> +				result = -EINVAL;
> +				break;
> +			}
> +			template_desc = lookup_template_desc(args[0].from);
> +			if (!template_desc || entry->template)
> +				result = -EINVAL;
> +			else
> +				entry->template = template_desc;
> +			break;
>   		case Opt_err:
>   			ima_log_string(ab, "UNKNOWN", p);
>   			result = -EINVAL;
> @@ -1331,6 +1353,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>   			}
>   		}
>   	}
> +	if (entry->template)
> +		seq_printf(m, "template=%s ", entry->template->name);

Name could be empty if entry->template is the last element of the
builtin_templates array. In this case, you should print ->fmt (check
ima_measurement_show()).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
