Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756D43DF2EE
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhHCQkU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 12:40:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47722 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhHCQkF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 12:40:05 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 64FF320B36E0;
        Tue,  3 Aug 2021 09:39:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64FF320B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628008793;
        bh=beC0JVlejuVzUAFF+9/9jg5J6LbG8CqqUZ5j5KcsxiM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=nMoXJqTb3+dd/JQE3jNFaiwrN4ktwHD036V7D+J04GaCjjPZz0hgdZr9mfCqV3ia0
         vavK9XFYVVdEGTIc1c98oVuJtGQja7/UffK1yXtkGEcPsZ5lVpUEkbjKth0vAAAyA5
         kkFZ1ZjlJndJFQe7/iYtlLv1BQn9uspt/hfi9b/Q=
Subject: Re: [PATCH v5 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
 <20210728132112.258606-4-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d7a695da-f72b-1a4d-02d6-acb819cfcbee@linux.microsoft.com>
Date:   Tue, 3 Aug 2021 09:41:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728132112.258606-4-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 7/28/2021 6:21 AM, THOBY Simon wrote:
> The kernel accepts any hash algorithm as a value for the security.ima
> xattr. Users may wish to restrict the accepted algorithms to only
> support strong cryptographic ones.
> 
> Provide the plumbing to restrict the permitted set of hash algorithms
> used for verifying file hashes and digest algorithms stored in
> security.ima xattr.
> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, in which case it checks that the hash (which was then
> signed by the trusted private key) have been generated with one of
> the algortihms whitelisted for this specific rule.
typo: algortihms => algorithms

Also, suggest using "allowed list" (for digest algorithms allowed)

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima.h          |  6 +++---
>   security/integrity/ima/ima_api.c      |  6 ++++--
>   security/integrity/ima/ima_appraise.c |  5 +++--
>   security/integrity/ima/ima_main.c     | 17 ++++++++++++++---
>   security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
>   5 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f0e448ed1f9f..7ef1b214d358 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -47,7 +47,7 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>   extern int ima_policy_flag;
>   
>   /* set during initialization */
> -extern int ima_hash_algo;
> +extern int ima_hash_algo __ro_after_init;
>   extern int ima_sha1_idx __ro_after_init;
>   extern int ima_hash_algo_idx __ro_after_init;
>   extern int ima_extra_slots __ro_after_init;
> @@ -254,7 +254,7 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
>   		   const struct cred *cred, u32 secid, int mask,
>   		   enum ima_hooks func, int *pcr,
>   		   struct ima_template_desc **template_desc,
> -		   const char *func_data);
> +		   const char *func_data, unsigned int *allowed_hashes);
>   int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>   int ima_collect_measurement(struct integrity_iint_cache *iint,
>   			    struct file *file, void *buf, loff_t size,
> @@ -285,7 +285,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>   		     const struct cred *cred, u32 secid, enum ima_hooks func,
>   		     int mask, int flags, int *pcr,
>   		     struct ima_template_desc **template_desc,
> -		     const char *func_data);
> +		     const char *func_data, unsigned int *allowed_hashes);
>   void ima_init_policy(void);
>   void ima_update_policy(void);
>   void ima_update_policy_flag(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index d8e321cc6936..c91c2c402498 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -172,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    * @pcr: pointer filled in if matched measure policy sets pcr=
>    * @template_desc: pointer filled in if matched measure policy sets template=
>    * @func_data: func specific data, may be NULL
> + * @allowed_hashes: whitelist of hash algorithms allowed for the IMA xattr
"@allowed_hashes: allowed list of hash algorithms for the IMA xattr"

>    *
>    * The policy is defined in terms of keypairs:
>    *		subj=, obj=, type=, func=, mask=, fsmagic=
> @@ -188,14 +189,15 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
>   		   const struct cred *cred, u32 secid, int mask,
>   		   enum ima_hooks func, int *pcr,
>   		   struct ima_template_desc **template_desc,
> -		   const char *func_data)
> +		   const char *func_data, unsigned int *allowed_hashes)
>   {
>   	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>   
>   	flags &= ima_policy_flag;
>   
>   	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
> -				flags, pcr, template_desc, func_data);
> +				flags, pcr, template_desc, func_data,
> +				allowed_hashes);
>   }
>   
>   /*
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a5e0d3400bd1..12d406b5ab35 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -77,8 +77,9 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
>   		return 0;
>   
>   	security_task_getsecid_subj(current, &secid);
> -	return ima_match_policy(mnt_userns, inode, current_cred(), secid, func,
> -				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
> +	return ima_match_policy(mnt_userns, inode, current_cred(), secid,
> +				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
> +				NULL, NULL, NULL);
>   }
>   
>   static int ima_fix_xattr(struct dentry *dentry,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 7f2310f29789..85b079c1a19b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -210,6 +210,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	int xattr_len = 0;
>   	bool violation_check;
>   	enum hash_algo hash_algo;
> +	unsigned int allowed_hashes = 0;
>   
>   	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>   		return 0;
> @@ -219,7 +220,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	 * Included is the appraise submask.
>   	 */
>   	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
> -				mask, func, &pcr, &template_desc, NULL);
> +				mask, func, &pcr, &template_desc, NULL,
> +				&allowed_hashes);
>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>   			   (ima_policy_flag & IMA_MEASURE));
>   	if (!action && !violation_check)
> @@ -356,6 +358,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   
>   	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
>   		rc = 0;
> +
> +	/* Ensure the digest was generated using an allowed algorithm */
> +	if (rc == 0 && must_appraise && allowed_hashes != 0 &&
> +	    (allowed_hashes & (1U << hash_algo)) == 0) {
> +		rc = -EACCES;
> +
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
> +			pathname, "collect_data", "forbidden-hash-algorithm", rc, 0);
> +	}
>   out_locked:
>   	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
>   	     !(iint->flags & IMA_NEW_FILE))
> @@ -433,7 +444,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   	inode = file_inode(vma->vm_file);
>   	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
>   				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
> -				&pcr, &template, NULL);
> +				&pcr, &template, NULL, NULL);
>   
>   	/* Is the mmap'ed file in policy? */
>   	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
> @@ -882,7 +893,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
>   		security_task_getsecid_subj(current, &secid);
>   		action = ima_get_action(mnt_userns, inode, current_cred(),
>   					secid, 0, func, &pcr, &template,
> -					func_data);
> +					func_data, NULL);
>   		if (!(action & IMA_MEASURE))
>   			return;
>   	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd5d46e511f1..344b5b0dc1a1 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -35,6 +35,7 @@
>   #define IMA_FSNAME	0x0200
>   #define IMA_KEYRINGS	0x0400
>   #define IMA_LABEL	0x0800
> +#define IMA_VALIDATE_HASH	0x1000
>   
>   #define UNKNOWN		0
>   #define MEASURE		0x0001	/* same as IMA_MEASURE */
> @@ -79,6 +80,7 @@ struct ima_rule_entry {
>   	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
>   	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
>   	int pcr;
> +	unsigned int allowed_hashes;
>   	struct {
>   		void *rule;	/* LSM file metadata specific */
>   		char *args_p;	/* audit value */
> @@ -90,6 +92,14 @@ struct ima_rule_entry {
>   	struct ima_template_desc *template;
>   };
>   
> +/*
> + * sanity check in case the kernels gains more hash algorithms that can
> + * fit in an unsigned int
> + */
> +static_assert(
> +	8 * sizeof(unsigned int) >= HASH_ALGO__LAST,
> +	"The bitfield allowed_hashes in ima_rule_entry is too small to contain all the supported hash algorithms, consider using a bigger type");
> +
>   /*
>    * Without LSM specific knowledge, the default policy can only be
>    * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
> @@ -646,6 +656,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>    * @pcr: set the pcr to extend
>    * @template_desc: the template that should be used for this rule
>    * @func_data: func specific data, may be NULL
> + * @allowed_hashes: whitelist of hash algorithms allowed for the IMA xattr
"@allowed_hashes: allowed list of hash algorithms for the IMA xattr"

  -lakshmi

>    *
>    * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>    * conditions.
> @@ -658,7 +669,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>   		     const struct cred *cred, u32 secid, enum ima_hooks func,
>   		     int mask, int flags, int *pcr,
>   		     struct ima_template_desc **template_desc,
> -		     const char *func_data)
> +		     const char *func_data, unsigned int *allowed_hashes)
>   {
>   	struct ima_rule_entry *entry;
>   	int action = 0, actmask = flags | (flags << 1);
> @@ -684,8 +695,11 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>   			action &= ~IMA_HASH;
>   			if (ima_fail_unverifiable_sigs)
>   				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
> -		}
>   
> +			if (allowed_hashes &&
> +			    entry->flags & IMA_VALIDATE_HASH)
> +				*allowed_hashes = entry->allowed_hashes;
> +		}
>   
>   		if (entry->action & IMA_DO_MASK)
>   			actmask &= ~(entry->action | entry->action << 1);
> 
