Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005AC2D89AC
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501890AbgLLTVH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 14:21:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60624 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501886AbgLLTVH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 14:21:07 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id E476820B717A;
        Sat, 12 Dec 2020 11:20:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E476820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607800825;
        bh=5ksj1UHNuBAABEl+/jn4cYgqXNXCmJX9vdNbEeENg08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBhBKQvHgJRUcQcgKM74P1aJ6cgivcillH1PmeggevYop5Ti3TGuGp+67Sewyn0tV
         NFaTeGUZsU30e8h422XiZeMfdr8ABKDyBOLHSK5/6YD9qc/mCpiiVjGWFuffIaTsOt
         pJpEPTSDysfNA86LdIPV0w0LX0cVc+sxn1vv28yw=
Date:   Sat, 12 Dec 2020 13:20:22 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v9 4/8] IMA: add policy rule to measure critical data
Message-ID: <20201212192022.GI4951@sequoia>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-5-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212180251.9943-5-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-12 10:02:47, Tushar Sugandhi wrote:
> A new IMA policy rule is needed for the IMA hook
> ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
> measuring the input buffer. The policy rule should ensure the buffer
> would get measured only when the policy rule allows the action. The
> policy rule should also support the necessary constraints (flags etc.)
> for integrity critical buffer data measurements.
> 
> Add a policy rule to define the constraints for restricting integrity
> critical data measurements.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

This looks nice. Thanks for the changes!

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  Documentation/ABI/testing/ima_policy |  2 +-
>  security/integrity/ima/ima_policy.c  | 29 ++++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index e35263f97fc1..6ec7daa87cba 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -32,7 +32,7 @@ Description:
>  			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
>  			        [FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> -				[KEXEC_CMDLINE] [KEY_CHECK]
> +				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a09d1a41a290..d45c2dbb6d45 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -479,6 +479,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
>  
>  		opt_list = rule->keyrings;
>  		break;
> +	case CRITICAL_DATA:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -515,13 +517,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEY_CHECK) {
> -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> -			ima_match_rule_data(rule, func_data, cred);
> -	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
>  		return false;
> +
> +	switch (func) {
> +	case KEY_CHECK:
> +	case CRITICAL_DATA:
> +		return ((rule->func == func) &&
> +			ima_match_rule_data(rule, func_data, cred));
> +	default:
> +		break;
> +	}
> +
>  	if ((rule->flags & IMA_MASK) &&
>  	    (rule->mask != mask && func != POST_SETATTR))
>  		return false;
> @@ -1116,6 +1124,17 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		if (ima_rule_contains_lsm_cond(entry))
>  			return false;
>  
> +		break;
> +	case CRITICAL_DATA:
> +		if (entry->action & ~(MEASURE | DONT_MEASURE))
> +			return false;
> +
> +		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR))
> +			return false;
> +
> +		if (ima_rule_contains_lsm_cond(entry))
> +			return false;
> +
>  		break;
>  	default:
>  		return false;
> @@ -1248,6 +1267,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
>  				 strcmp(args[0].from, "KEY_CHECK") == 0)
>  				entry->func = KEY_CHECK;
> +			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
> +				entry->func = CRITICAL_DATA;
>  			else
>  				result = -EINVAL;
>  			if (!result)
> -- 
> 2.17.1
> 
