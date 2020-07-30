Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4822334EA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 17:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgG3PCd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 11:02:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55250 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3PCc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 11:02:32 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 610CF20B4908;
        Thu, 30 Jul 2020 08:02:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 610CF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596121351;
        bh=vKzSD0CcVGwc1leJ+1uee8TOPGRgvmYvqxvarqXtglA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIE2Bh+h354aB27e8tSl3CCtSBrFMWO03GkwNede75VLrbyfSU1mD4qGsi9yrMJKN
         h6tarjd4QEKaGhkjmBDFum+uyczMgX6OdnxBeSuNnoCMtW9N4iD6KWk8FoBzWxlVoJ
         RpUPYUiY5a9CJPB7iEHxRdLIcX84FN2XbO06EkTU=
Date:   Thu, 30 Jul 2020 10:02:28 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] IMA: Add func to measure LSM state and policy
Message-ID: <20200730150228.GV4181@sequoia>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730034724.3298-2-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-29 20:47:21, Lakshmi Ramasubramanian wrote:
> Critical data structures of security modules need to be measured to
> enable an attestation service to verify if the configuration and
> policies for the security modules have been setup correctly and
> that they haven't been tampered with at runtime. A new IMA policy is
> required for handling this measurement.
> 
> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> measure the state and the policy provided by the security modules.
> Update ima_match_rules() and ima_validate_rule() to check for
> the new func and ima_parse_rule() to handle the new func.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  9 ++++++++
>  security/integrity/ima/ima.h         |  2 ++
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/ima/ima_policy.c  | 31 ++++++++++++++++++++++++----
>  4 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index cd572912c593..b7c7fb548c0c 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -30,6 +30,7 @@ Description:
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE] [KEY_CHECK]
> +				[LSM_STATE] [LSM_POLICY]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> @@ -125,3 +126,11 @@ Description:
>  		keys added to .builtin_trusted_keys or .ima keyring:
>  
>  			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
> +
> +		Example of measure rule using LSM_STATE to measure LSM state:
> +
> +			measure func=LSM_STATE template=ima-buf
> +
> +		Example of measure rule using LSM_POLICY to measure LSM policy:
> +
> +			measure func=LSM_POLICY template=ima-ng
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 38043074ce5e..1b5f4b2f17d0 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -200,6 +200,8 @@ static inline unsigned int ima_hash_key(u8 *digest)
>  	hook(POLICY_CHECK, policy)			\
>  	hook(KEXEC_CMDLINE, kexec_cmdline)		\
>  	hook(KEY_CHECK, key)				\
> +	hook(LSM_STATE, lsm_state)			\
> +	hook(LSM_POLICY, lsm_policy)			\
>  	hook(MAX_CHECK, none)
>  
>  #define __ima_hook_enumify(ENUM, str)	ENUM,
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 4f39fb93f278..8c8b4e4a6493 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>   *	subj,obj, and type: are LSM specific.
>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> - *	| KEXEC_CMDLINE | KEY_CHECK
> + *	| KEXEC_CMDLINE | KEY_CHECK | LSM_STATE | LSM_POLICY
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 07f033634b27..a0f5c39d9084 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -442,13 +442,20 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEY_CHECK) {
> -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> -		       ima_match_keyring(rule, keyring, cred);
> -	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
>  		return false;
> +
> +	switch (func) {
> +	case KEY_CHECK:
> +		return ima_match_keyring(rule, keyring, cred);
> +	case LSM_STATE:
> +	case LSM_POLICY:
> +		return true;
> +	default:
> +		break;
> +	}
> +
>  	if ((rule->flags & IMA_MASK) &&
>  	    (rule->mask != mask && func != POST_SETATTR))
>  		return false;
> @@ -1044,6 +1051,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		if (ima_rule_contains_lsm_cond(entry))
>  			return false;
>  
> +		break;
> +	case LSM_STATE:
> +	case LSM_POLICY:
> +		if (entry->action & ~(MEASURE | DONT_MEASURE))
> +			return false;
> +
> +		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
> +			return false;
> +
> +		if (ima_rule_contains_lsm_cond(entry))
> +			return false;
> +
>  		break;
>  	default:
>  		return false;
> @@ -1176,6 +1195,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = KEXEC_CMDLINE;
>  			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
>  				entry->func = KEY_CHECK;
> +			else if (strcmp(args[0].from, "LSM_STATE") == 0)
> +				entry->func = LSM_STATE;
> +			else if (strcmp(args[0].from, "LSM_POLICY") == 0)
> +				entry->func = LSM_POLICY;

This patch generally looks really good to me with the exception of one
thing...

We should only accept rules with these specified hook functions when an
LSM that has measurement support is enabled. This messes up the ordering
of your patch series but it could be as simple as doing this:

			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
				 strcmp(args[0].from, "LSM_STATE") == 0)
				 entry->func = LSM_STATE;

Or you could do something a little more complex, like what's done with
CONFIG_IMA_LSM_RULES. You could create a CONFIG_IMA_MEASURE_LSM option
that's default enabled but depends on CONFIG_SECURITY_SELINUX and then
check for IS_ENABLED(CONFIG_IMA_MEASURE_LSM) in ima_parse_rule().

I'd personally opt for just placing the
IS_ENABLED(CONFIG_SECURITY_SELINUX) check directly into
ima_parse_rule().

Tyler

>  			else
>  				result = -EINVAL;
>  			if (!result)
> -- 
> 2.27.0
