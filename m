Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419EC3E0835
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhHDSs2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 14:48:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbhHDSsL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 14:48:11 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id B9D7820B36E0;
        Wed,  4 Aug 2021 11:47:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9D7820B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628102878;
        bh=hsHzVDNC4I8WHa8vUvD1iQxky7M8Es3Wh8tkZ8OvIJA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jpCDFndawugX18Ax8V+nPG54ToVW28N6wgnt0N0y2qqa56h7nXh939v7yNWMWLtAb
         aI4v4IA1nQHPMKuaz37uEO02qWVwKOCF2SoK8RwdvmuTz5P0NGEjf3SSKb79rQiL2N
         zRUaQGM4wlJp2kTDzpLgpqVgvOIvF80pkcxND9gw=
Subject: Re: [PATCH v6 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-6-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2b1f1c32-b4c8-154f-e733-b2738c35d6fe@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 11:49:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804092010.350372-6-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2021 2:20 AM, THOBY Simon wrote:
> While users can restrict the accepted hash algorithms for the
> security.ima xattr file signature when appraising said file, users
> cannot restrict the algorithms that can be set on that attribute:
> any algorithm built in the kernel is accepted on a write.
> 
> Define a new value for the ima policy option 'func' that restricts
> globally the hash algorithms accepted when writing the security.ima
> xattr.
> 
> When a policy contains a rule of the form
> 	appraise func=SETXATTR_CHECK appraise_hash=sha256,sha384,sha512
> only values corresponding to one of these three digest algorithms
> will be accepted for writing the security.ima xattr.
> Attempting to write the attribute using another algorithm (or "free-form"
> data) will be denied with an audit log message.
> In the absence of such a policy rule, the default is still to only
> accept hash algorithms built in the kernel (with all the limitations
> that entails).
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   Documentation/ABI/testing/ima_policy  |  9 +++-
>   security/integrity/ima/ima.h          |  6 ++-
>   security/integrity/ima/ima_appraise.c | 29 ++++++++--
>   security/integrity/ima/ima_main.c     |  2 +-
>   security/integrity/ima/ima_policy.c   | 76 +++++++++++++++++++++++----
>   5 files changed, 104 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index aeb622698047..537be0e1720e 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -30,9 +30,10 @@ Description:
>   				[appraise_flag=] [appraise_hash=] [keyrings=]
>   		  base:
>   			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> -			        [FIRMWARE_CHECK]
> +				[FIRMWARE_CHECK]
Is there a white space in the above line that is showing up as a change 
in this patch?

Other changes look good.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

>   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>   				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
> +				[SETXATTR_CHECK]
>   			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>   			       [[^]MAY_EXEC]
>   			fsmagic:= hex value
> @@ -138,3 +139,9 @@ Description:
>   		keys added to .builtin_trusted_keys or .ima keyring:
>   
>   			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
> +
> +		Example of the special SETXATTR_CHECK appraise rule, that
> +		restricts the hash algorithms allowed when writing to the
> +		security.ima xattr of a file:
> +
> +			appraise func=SETXATTR_CHECK appraise_hash=sha256,sha384,sha512
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 8db0238a0fd6..7f2aa875fd72 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -46,6 +46,9 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>   /* current content of the policy */
>   extern int ima_policy_flag;
>   
> +/* bitset of digests algorithms allowed in the setxattr hook */
> +extern atomic_t ima_setxattr_allowed_hash_algorithms;
> +
>   /* set during initialization */
>   extern int ima_hash_algo __ro_after_init;
>   extern int ima_sha1_idx __ro_after_init;
> @@ -198,6 +201,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
>   	hook(KEXEC_CMDLINE, kexec_cmdline)		\
>   	hook(KEY_CHECK, key)				\
>   	hook(CRITICAL_DATA, critical_data)		\
> +	hook(SETXATTR_CHECK, setxattr_check)		\
>   	hook(MAX_CHECK, none)
>   
>   #define __ima_hook_enumify(ENUM, str)	ENUM,
> @@ -288,7 +292,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>   		     const char *func_data, unsigned int *allowed_hashes);
>   void ima_init_policy(void);
>   void ima_update_policy(void);
> -void ima_update_policy_flag(void);
> +void ima_update_policy_flags(void);
>   ssize_t ima_parse_add_rule(char *);
>   void ima_delete_rules(void);
>   int ima_check_policy(void);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 9aa0334b8e54..4949aabce36c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -597,12 +597,32 @@ static int validate_hash_algo(struct dentry *dentry,
>   	int result = 0;
>   	char *path = NULL, *pathbuf = NULL;
>   	enum hash_algo xattr_hash_algo;
> +	const char *errmsg = "unavailable-hash-algorithm";
> +	unsigned int allowed_hashes;
>   
>   	xattr_hash_algo = ima_get_hash_algo(xattr_value, xattr_value_len);
>   
> -	if (likely(xattr_hash_algo == ima_hash_algo ||
> -		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
> -		return result;
> +	allowed_hashes = atomic_read(&ima_setxattr_allowed_hash_algorithms);
> +
> +	if (allowed_hashes) {
> +		/* success if the algorithm is allowed in the ima policy */
> +		if (allowed_hashes & (1U << xattr_hash_algo))
> +			return result;
> +
> +		/*
> +		 * We use a different audit message when the hash algorithm
> +		 * is denied by a policy rule, instead of not being built
> +		 * in the kernel image
> +		 */
> +		errmsg = "denied-hash-algorithm";
> +	} else {
> +		if (likely(xattr_hash_algo == ima_hash_algo))
> +			return result;
> +
> +		/* allow any xattr using an algorithm built in the kernel */
> +		if (crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0))
> +			return result;
> +	}
>   
>   	result = -EACCES;
>   
> @@ -613,8 +633,7 @@ static int validate_hash_algo(struct dentry *dentry,
>   	path = dentry_path(dentry, pathbuf, PATH_MAX);
>   
>   	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
> -			    "collect_data", "unavailable-hash-algorithm",
> -			    result, 0);
> +			    "collect_data", errmsg, result, 0);
>   
>   	kfree(pathbuf);
>   
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 205138e7016d..f6389f0ff81b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1052,7 +1052,7 @@ static int __init init_ima(void)
>   		pr_warn("Couldn't register LSM notifier, error %d\n", error);
>   
>   	if (!error)
> -		ima_update_policy_flag();
> +		ima_update_policy_flags();
>   
>   	return error;
>   }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 831ce0c690ec..c83f7c199610 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -53,6 +53,8 @@ int ima_policy_flag;
>   static int temp_ima_appraise;
>   static int build_ima_appraise __ro_after_init;
>   
> +atomic_t ima_setxattr_allowed_hash_algorithms;
> +
>   #define MAX_LSM_RULES 6
>   enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
>   	LSM_SUBJ_USER, LSM_SUBJ_ROLE, LSM_SUBJ_TYPE
> @@ -720,24 +722,57 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>   	return action;
>   }
>   
> -/*
> - * Initialize the ima_policy_flag variable based on the currently
> - * loaded policy.  Based on this flag, the decision to short circuit
> - * out of a function or not call the function in the first place
> - * can be made earlier.
> +/**
> + * ima_update_policy_flags() - Update global IMA variables
> + *
> + * Update ima_policy_flag and ima_setxattr_allowed_hash_algorithms
> + * based on the currently loaded policy.
> + *
> + * With ima_policy_flag, the decision to short circuit out of a function
> + * or not call the function in the first place can be made earlier.
> + *
> + * With ima_setxattr_allowed_hash_algorithms, the policy can restrict the
> + * set of hash algorithms accepted when updating the security.ima xattr of
> + * a file.
> + *
> + * Context: called after a policy update and at system initialization.
>    */
> -void ima_update_policy_flag(void)
> +void ima_update_policy_flags(void)
>   {
>   	struct ima_rule_entry *entry;
> +	int new_policy_flag = 0;
>   
> +	rcu_read_lock();
>   	list_for_each_entry(entry, ima_rules, list) {
> +		/*
> +		 * SETXATTR_CHECK rules do not implement a full policy check
> +		 * because rule checking would probably have an important
> +		 * performance impact on setxattr(). As a consequence, only one
> +		 * SETXATTR_CHECK can be active at a given time.
> +		 * Because we want to preserve that property, we set out to use
> +		 * atomic_cmpxchg. Either:
> +		 * - the atomic was non-zero: a setxattr hash policy is
> +		 *   already enforced, we do nothing
> +		 * - the atomic was zero: no setxattr policy was set, enable
> +		 *   the setxattr hash policy
> +		 */
> +		if (entry->func == SETXATTR_CHECK) {
> +			atomic_cmpxchg(&ima_setxattr_allowed_hash_algorithms,
> +				       0, entry->allowed_hashes);
> +			/* SETXATTR_CHECK doesn't impact ima_policy_flag */
> +			continue;
> +		}
> +
>   		if (entry->action & IMA_DO_MASK)
> -			ima_policy_flag |= entry->action;
> +			new_policy_flag |= entry->action;
>   	}
> +	rcu_read_unlock();
>   
>   	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
>   	if (!ima_appraise)
> -		ima_policy_flag &= ~IMA_APPRAISE;
> +		new_policy_flag &= ~IMA_APPRAISE;
> +
> +	ima_policy_flag = new_policy_flag;
>   }
>   
>   static int ima_appraise_flag(enum ima_hooks func)
> @@ -903,7 +938,9 @@ void __init ima_init_policy(void)
>   			  ARRAY_SIZE(critical_data_rules),
>   			  IMA_DEFAULT_POLICY);
>   
> -	ima_update_policy_flag();
> +	atomic_set(&ima_setxattr_allowed_hash_algorithms, 0);
> +
> +	ima_update_policy_flags();
>   }
>   
>   /* Make sure we have a valid policy, at least containing some rules. */
> @@ -943,7 +980,7 @@ void ima_update_policy(void)
>   		 */
>   		kfree(arch_policy_entry);
>   	}
> -	ima_update_policy_flag();
> +	ima_update_policy_flags();
>   
>   	/* Custom IMA policy has been loaded */
>   	ima_process_queued_keys();
> @@ -1176,6 +1213,23 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		if (ima_rule_contains_lsm_cond(entry))
>   			return false;
>   
> +		break;
> +	case SETXATTR_CHECK:
> +		/* any action other than APPRAISE is unsupported */
> +		if (entry->action != APPRAISE)
> +			return false;
> +
> +		/* SETXATTR_CHECK requires an appraise_hash parameter */
> +		if (!(entry->flags & IMA_VALIDATE_HASH))
> +			return false;
> +
> +		/*
> +		 * full policies are not supported, they would have too
> +		 * much of a performance impact
> +		 */
> +		if (entry->flags & ~(IMA_FUNC | IMA_VALIDATE_HASH))
> +			return false;
> +
>   		break;
>   	default:
>   		return false;
> @@ -1332,6 +1386,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   				entry->func = KEY_CHECK;
>   			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
>   				entry->func = CRITICAL_DATA;
> +			else if (strcmp(args[0].from, "SETXATTR_CHECK") == 0)
> +				entry->func = SETXATTR_CHECK;
>   			else
>   				result = -EINVAL;
>   			if (!result)
> 
