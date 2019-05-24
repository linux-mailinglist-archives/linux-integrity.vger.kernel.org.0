Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D89294A9
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfEXJ3q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 05:29:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32967 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389724AbfEXJ3q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 05:29:46 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7B55D28B25AF3AA6A472;
        Fri, 24 May 2019 10:29:44 +0100 (IST)
Received: from [10.204.65.201] (10.204.65.201) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 24 May
 2019 10:29:43 +0100
Subject: Re: [PATCH V2] IMA: Allow profiles to define the desired IMA template
To:     Matthew Garrett <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.vnet.ibm.com>, <prsriva02@gmail.com>,
        <bauerman@linux.ibm.com>, Matthew Garrett <mjg59@google.com>
References: <20190523181827.207274-1-matthewgarrett@google.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <25aa67c9-ac11-b6b3-7f94-142dd71d3df5@huawei.com>
Date:   Fri, 24 May 2019 11:29:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190523181827.207274-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.201]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/23/2019 8:18 PM, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Rebased on next-integrity without relying on any other patches.
> 
>   Documentation/ABI/testing/ima_policy  |  4 ++--
>   security/integrity/ima/ima.h          |  7 +++++--
>   security/integrity/ima/ima_api.c      |  7 +++++--
>   security/integrity/ima/ima_appraise.c |  2 +-
>   security/integrity/ima/ima_main.c     |  9 ++++++---
>   security/integrity/ima/ima_policy.c   | 24 ++++++++++++++++++++++--
>   security/integrity/ima/ima_template.c | 15 +++++++++++----
>   security/integrity/integrity.h        |  1 +
>   8 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 74c6702de74e..e1a6996e4516 100644
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
> @@ -38,6 +37,7 @@ Description:
>   			fowner:= decimal value
>   		lsm:  	are LSM specific
>   		option:	appraise_type:= [imasig]
> +			template:= name of an IMA template type (eg, d-ng)

IMA template name or custom format (if specified in the kernel command
line, see below).


>   			pcr:= decimal value
>   
>   		default policy:
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..fa4a807bae93 100644
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
> @@ -214,7 +216,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
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
> index c7505fb122d4..fce8f83c436c 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -164,6 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    *        MAY_APPEND)
>    * @func: caller identifier
>    * @pcr: pointer filled in if matched measure policy sets pcr=
> + * @template_desc: pointer filled in if matched measure policy sets template=
>    *
>    * The policy is defined in terms of keypairs:
>    *		subj=, obj=, type=, func=, mask=, fsmagic=
> @@ -176,13 +177,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
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
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..f23069d9e43d 100644
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
> @@ -275,7 +276,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   		goto out_locked;
>   	}
>   
> -	template_desc = ima_template_desc_current();
> +	if (!template_desc)
> +		template_desc = ima_template_desc_current();
> +
>   	if ((action & IMA_APPRAISE_SUBMASK) ||
>   		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
>   		/* read 'security.ima' */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 0f6fe53cef09..643490f9f0ad 100644
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
> @@ -438,6 +441,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>   		if ((pcr) && (entry->flags & IMA_PCR))
>   			*pcr = entry->pcr;
>   
> +		if (template_desc && entry->flags & IMA_TEMPLATE)
> +			*template_desc = entry->template;
> +

I would simply return the template, without checking the flags.


>   		if (!actmask)
>   			break;
>   	}
> @@ -676,7 +682,7 @@ enum {
>   	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>   	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>   	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_err
> +	Opt_pcr, Opt_template, Opt_err
>   };
>   
>   static const match_table_t policy_tokens = {
> @@ -710,6 +716,7 @@ static const match_table_t policy_tokens = {
>   	{Opt_appraise_type, "appraise_type=%s"},
>   	{Opt_permit_directio, "permit_directio"},
>   	{Opt_pcr, "pcr=%s"},
> +	{Opt_template, "template=%s"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -763,6 +770,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   	char *from;
>   	char *p;
>   	bool uid_token;
> +	struct ima_template_desc *template_desc;
>   	int result = 0;
>   
>   	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
> @@ -1058,6 +1066,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   			else
>   				entry->flags |= IMA_PCR;
>   
> +			break;
> +		case Opt_template:
> +			ima_log_string(ab, "template", args[0].from);

Please add:

if (entry->template)
	return -EINVAL;


> +			template_desc = lookup_template_desc(args[0].from);

You assume that the template is already known, while users can specify
in the policy a combination of template fields that is not in the list.


> +			if (!template_desc) {
> +				result = -EINVAL;
> +			} else {
> +				entry->template = template_desc;
> +				entry->flags |= IMA_TEMPLATE;
> +			}
>   			break;
>   		case Opt_err:
>   			ima_log_string(ab, "UNKNOWN", p);
> @@ -1331,6 +1349,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>   			}
>   		}
>   	}
> +	if (entry->flags & IMA_TEMPLATE)
> +		seq_printf(m, "template=%s ", entry->template->name);
>   	if (entry->flags & IMA_DIGSIG_REQUIRED)
>   		seq_puts(m, "appraise_type=imasig ");
>   	if (entry->flags & IMA_PERMIT_DIRECTIO)
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index b631b8bc7624..34f23db2f985 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -47,7 +47,6 @@ static const struct ima_template_field supported_fields[] = {
>   #define MAX_TEMPLATE_NAME_LEN 15
>   
>   static struct ima_template_desc *ima_template;
> -static struct ima_template_desc *lookup_template_desc(const char *name);
>   static int template_desc_init_fields(const char *template_fmt,
>   				     const struct ima_template_field ***fields,
>   				     int *num_fields);
> @@ -108,16 +107,24 @@ static int __init ima_template_fmt_setup(char *str)
>   }
>   __setup("ima_template_fmt=", ima_template_fmt_setup);
>   
> -static struct ima_template_desc *lookup_template_desc(const char *name)
> +struct ima_template_desc *lookup_template_desc(const char *name)
>   {
>   	struct ima_template_desc *template_desc;
> -	int found = 0;
> +	int result, found = 0;
>   
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
>   		if ((strcmp(template_desc->name, name) == 0) ||
>   		    (strcmp(template_desc->fmt, name) == 0)) {
> -			found = 1;
> +			/*
> +			 * template_desc_init_fields() will return immediately
> +			 * if the template is already initialised
> +			 */
> +			result = template_desc_init_fields(template_desc->fmt,
> +						 &(template_desc->fields),
> +						 &(template_desc->num_fields));
> +			if (!result)
> +				found = 1;
>   			break;
>   		}
>   	}
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7de59f44cba3..b3e3c58691ea 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -36,6 +36,7 @@
>   #define IMA_NEW_FILE		0x04000000
>   #define EVM_IMMUTABLE_DIGSIG	0x08000000
>   #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> +#define IMA_TEMPLATE		0x20000000

I think it is not necessary to define a new flag here. It should be
sufficient to check entry->template.

Roberto


>   #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>   				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
