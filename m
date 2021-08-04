Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4493E06E0
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhHDRmW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 13:42:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37786 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbhHDRmV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 13:42:21 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFBA320B36E0;
        Wed,  4 Aug 2021 10:42:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFBA320B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628098929;
        bh=tnzbINaxWUAAlYhtG6RaGP6Sqsm4U+wAGggOQ3EH38k=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KhtwPj33637PCNb8IHRK6B1PKiwfXjPUL+/5dx6RNemzEIN0LrTNQHHzdPx0CAPPS
         O1okkFo1fBrSYC6At5ZseSnSy4DQFO0wvRpLdt0yw4FcX0utLbgBv+tuEn3m/ekcdn
         Ya2Xp38XtIkaiQ9cVo9Crsv9O1PfAhMM/4nnijfc=
Subject: Re: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-4-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <da9aaf7f-b2f0-d0e8-28fd-c09f4fd646be@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 10:44:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804092010.350372-4-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2021 2:20 AM, THOBY Simon wrote:
> The kernel accepts any hash algorithm as a value for the security.ima
> xattr. Users may wish to restrict the accepted algorithms to only
> support strong cryptographic ones.
> 
> Provide the plumbing to restrict the permitted set of hash algorithms
> used for verifying file hashes and digest algorithms stored in
> security.ima xattr.
> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, where the hash from which the signature is derived (by
> signing it with the trusted private key) must obey the same
> restrictions.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima.h          |  6 +++---
>   security/integrity/ima/ima_api.c      |  6 ++++--
>   security/integrity/ima/ima_appraise.c |  5 +++--
>   security/integrity/ima/ima_main.c     | 18 +++++++++++++++---
>   security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
>   5 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 829478dabeeb..8db0238a0fd6 100644
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
> index d8e321cc6936..3dc41d997dc5 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -172,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    * @pcr: pointer filled in if matched measure policy sets pcr=
>    * @template_desc: pointer filled in if matched measure policy sets template=
>    * @func_data: func specific data, may be NULL
> + * @allowed_hashes: allowlist of hash algorithms for the IMA xattr
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
> index ed1a98f6ee19..9aa0334b8e54 100644
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
> index b70ee0125168..205138e7016d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -216,6 +216,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	int xattr_len = 0;
>   	bool violation_check;
>   	enum hash_algo hash_algo;
> +	unsigned int allowed_hashes = 0;
>   
>   	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>   		return 0;
> @@ -225,7 +226,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	 * Included is the appraise submask.
>   	 */
>   	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
> -				mask, func, &pcr, &template_desc, NULL);
> +				mask, func, &pcr, &template_desc, NULL,
> +				&allowed_hashes);
>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>   			   (ima_policy_flag & IMA_MEASURE));
>   	if (!action && !violation_check)
> @@ -362,6 +364,16 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
> +				    pathname, "collect_data",
> +				    "denied-hash-algorithm", rc, 0);
> +	}
>   out_locked:
>   	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
>   	     !(iint->flags & IMA_NEW_FILE))
> @@ -439,7 +451,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   	inode = file_inode(vma->vm_file);
>   	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
>   				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
> -				&pcr, &template, NULL);
> +				&pcr, &template, NULL, NULL);
>   
>   	/* Is the mmap'ed file in policy? */
>   	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
> @@ -897,7 +909,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>   		security_task_getsecid_subj(current, &secid);
>   		action = ima_get_action(mnt_userns, inode, current_cred(),
>   					secid, 0, func, &pcr, &template,
> -					func_data);
> +					func_data, NULL);
>   		if (!(action & IMA_MEASURE) && !digest)
>   			return -ENOENT;
>   	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd5d46e511f1..a5b6162535f3 100644
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
> + * @allowed_hashes: allowlist of hash algorithms for the IMA xattr
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
