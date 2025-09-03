Return-Path: <linux-integrity+bounces-6999-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5519B41906
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D7481B4C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69512E54BC;
	Wed,  3 Sep 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E1iMR5Jg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6A2E6CB4
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889256; cv=none; b=Wz/TLxv5ejorw0EECGxmNrGdu+28+MRbaakM+8tRaw7npO65oGzfV86wIhWfrk7knIUEoDx1W2z9afSE8jlyUZTjvdF8NT10XMX3iJFJ2DWYsBVgXnpGk14vns+dKXQikcNHaz4T/k0lNkcnkMZhekToG20GT1MsWrkr3H3tdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889256; c=relaxed/simple;
	bh=ac7EqySBguPKgv6xPiXC664YTMTQTy42OQwsYfOwmnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0f/H9ty3vmulWa2NlScPR37QA1m3FLZQGMx2Xh8LssgA9g1aJVgIArlfeB/vBj1cVviMEG6jJqCoixOTgZTq/Jo/dd6UUuv046+9FKEUmQdWO6nDXt0ju+EjjBHC/A9NwZH7yWJk1Emh2MFHSJDL/wQ/YI6x44ySPtqHfCn3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E1iMR5Jg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 340503F2B2
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756889252;
	bh=VzK2rSQaQQohIIhg7/9GUOu09QgezDsJ9dSX0Tn1W4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=E1iMR5Jg0yAsYyzUR776oGyqwf02awmVj91sMuyHps4I2giEzHh7Q0tPFsAbEJmnn
	 prHaKUMsxHDv1O3A7sedWATAd0SuQgZUw9QATimk4aKgG2ZLRpL1DTwAMxCW1c170K
	 daMFP3k9j0aN2JqisrijuZ61fuEklMNJW59TTFHgks2bqlZUe3cSfwmlpMhB1ZUQ4n
	 JIH3nHHWJQHBrvn0qy1hA+kCFxoIgpwMRxMxhEiG8m/ManINwnl3XZxu77SUt7s8LI
	 0E4KgA+aARs5JapwMaD3i1p1WoKngJIBHdQHXOa/e5GGXsPwFxK6omXp8vWdK25w0t
	 W3qWqwGsE7/zQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329dbf4476cso1761449a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889251; x=1757494051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzK2rSQaQQohIIhg7/9GUOu09QgezDsJ9dSX0Tn1W4w=;
        b=vOFVyQ0WChOfMCCyYCQc6zQw841GJN7nnVl+khSKV0xzcw8HWf5/MjyuHc+xwASAw6
         vJhSBlMi5OKQ52npKuflUYLwGgfn9Eg7rmuKgNyYdBtsK1wtM0H9CYumSUVEQQJ5iw9Y
         DOpriM2pK606cNMI2b8JlnbhnzeB8Ap3yK0/pvrXVRHxNi7XYDyZcHhcy6eA4f+kb+nT
         mjXyolJW/5c5StykJjcbbkGC54jgDWE127SWPqEN7S0KTHxEz+K+o1if2RDqlT+Oy3xK
         1yjiehT0e3ZhI89NTXnuOWIkyW8WP7vAzrhVcLAA8cXUgPnu5/70Vul/z9LbOIdAZzP9
         kEsw==
X-Forwarded-Encrypted: i=1; AJvYcCUpUL/jhHLpn6dX5N3QA982Bfz+yQgHe1O8pISuxMz7Gbm2Mp4vTozB7oZ40urpg1CIsCiO0pZMpr44Y/ySFos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mG/hU0SbiqdgzMBgG12ZYa7ix5OgmU2xcNl5u0kUdHRZYuxG
	1SrKJxgFng0E7uWGQlJF2WOzjl4jjVaWUZ68mjyZdhTDan8YHjrYuyOGqpIqta2fDHxjjhyskIp
	5H67X+tOCzCaT8A0bDzber416Gfj27Kes7sSKUak0ptpUSOZFrF57o0whJsfbPmxqjqi46DhlxN
	GWM8Nr1u04vkY8jyIs0oeY
X-Gm-Gg: ASbGncsOyBP33PyXTni2+KDML6wm+k+Dfhv5AfU9gnwOUue7VdYBdRMdl1SySNZmQz8
	ZyEb/yD2M5a4mh5XJTPDsZGny6DvSKjQzeRoYrSEC2QIY395dGX7otKOWduA0oOCQpXyPGZM3IS
	K5IqQoIPN3KcPSWd0hzFdnO2Hyx+lA5UXh2dSkFg2GY/iA6bvNAEU8rFUKyRUzsXOJlxOghemPB
	zFmdcb1f7dnlafFnXCXlUd4ffeXjP1X0xYp2m1Xg/kseQq7oZ9vg9ksD/IIJb07nx/WIsPQmFzO
	xpZ5gmSWoESAwgi9qFgUzcvx+/gUAhUH34y19jp7/Vicen7rPPc3Ng==
X-Received: by 2002:a17:90b:3f8d:b0:32b:5f2f:f675 with SMTP id 98e67ed59e1d1-32b5f2ff9b4mr2488430a91.19.1756889250732;
        Wed, 03 Sep 2025 01:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLGIQOwGVWLMSTRfaDmoNY+ufQw1MfRrjPTWZV4OMEhb2ZaBxy7WM6YboLSJ+JRkSjBzaA5A==
X-Received: by 2002:a17:90b:3f8d:b0:32b:5f2f:f675 with SMTP id 98e67ed59e1d1-32b5f2ff9b4mr2488387a91.19.1756889250314;
        Wed, 03 Sep 2025 01:47:30 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32745900a2dsm12139666a91.4.2025.09.03.01.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:47:29 -0700 (PDT)
Message-ID: <180e8f03-66b3-44c7-a8d9-f185370267cf@canonical.com>
Date: Wed, 3 Sep 2025 01:47:28 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/34] lsm: fold lsm_init_ordered() into
 security_init()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-54-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-54-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> With only security_init() calling lsm_init_ordered, it makes little
> sense to keep lsm_init_ordered() as a standalone function.  Fold
> lsm_init_ordered() into security_init().
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 159 ++++++++++++++++++++------------------------
>   1 file changed, 73 insertions(+), 86 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 1f64222925c1..f87f5441617b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -18,6 +18,9 @@ static __initdata int lsm_enabled_false = 0;
>   extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>   extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>   
> +/* Number of "early" LSMs */
> +static __initdata unsigned int lsm_count_early;
> +
>   /* Build and boot-time LSM ordering. */
>   static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
>   static __initdata const char *lsm_order_cmdline;
> @@ -169,7 +172,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
> -
>   /**
>    * lsm_blob_size_update - Update the LSM blob size and offset information
>    * @sz_req: the requested additional blob size
> @@ -313,14 +315,74 @@ static void __init lsm_order_parse(const char *list, const char *src)
>   	}
>   }
>   
> -/**
> - * lsm_init_ordered - Initialize the ordered LSMs
> - */
> -static void __init lsm_init_ordered(void)
> +static void __init lsm_static_call_init(struct security_hook_list *hl)
>   {
> -	unsigned int first = 0;
> +	struct lsm_static_call *scall = hl->scalls;
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_COUNT; i++) {
> +		/* Update the first static call that is not used yet */
> +		if (!scall->hl) {
> +			__static_call_update(scall->key, scall->trampoline,
> +					     hl->hook.lsm_func_addr);
> +			scall->hl = hl;
> +			static_branch_enable(scall->active);
> +			return;
> +		}
> +		scall++;
> +	}
> +	panic("%s - Ran out of static slots.\n", __func__);
> +}
> +
> +/**
> + * security_add_hooks - Add a modules hooks to the hook lists.
> + * @hooks: the hooks to add
> + * @count: the number of hooks to add
> + * @lsmid: the identification information for the security module
> + *
> + * Each LSM has to register its hooks with the infrastructure.
> + */
> +void __init security_add_hooks(struct security_hook_list *hooks, int count,
> +			       const struct lsm_id *lsmid)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		hooks[i].lsmid = lsmid;
> +		lsm_static_call_init(&hooks[i]);
> +	}
> +}
> +
> +int __init early_security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	lsm_early_for_each_raw(lsm) {
> +		lsm_enabled_set(lsm, true);
> +		lsm_order_append(lsm, "early");
> +		lsm_prepare(lsm);
> +		lsm_init_single(lsm);
> +		lsm_count_early++;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * security_init - Initializes the LSM framework
> + *
> + * This should be called early in the kernel initialization sequence.
> + */
> +int __init security_init(void)
> +{
> +	unsigned int cnt;
>   	struct lsm_info **lsm;
>   	struct lsm_info *early;
> +	unsigned int first = 0;
> +
> +	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
> +	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
>   
>   	if (lsm_order_cmdline) {
>   		if (lsm_order_legacy) {
> @@ -332,9 +394,8 @@ static void __init lsm_init_ordered(void)
>   	} else
>   		lsm_order_parse(lsm_order_builtin, "builtin");
>   
> -	lsm_order_for_each(lsm) {
> +	lsm_order_for_each(lsm)
>   		lsm_prepare(*lsm);
> -	}
>   
>   	pr_info("initializing lsm=");
>   	lsm_early_for_each_raw(early) {
> @@ -383,87 +444,13 @@ static void __init lsm_init_ordered(void)
>   	if (lsm_task_alloc(current))
>   		panic("%s: early task alloc failed.\n", __func__);
>   
> +	cnt = 0;
>   	lsm_order_for_each(lsm) {
> +		/* skip the "early" LSMs as they have already been setup */
> +		if (cnt++ < lsm_count_early)
> +			continue;
>   		lsm_init_single(*lsm);
>   	}
> -}
> -
> -static void __init lsm_static_call_init(struct security_hook_list *hl)
> -{
> -	struct lsm_static_call *scall = hl->scalls;
> -	int i;
> -
> -	for (i = 0; i < MAX_LSM_COUNT; i++) {
> -		/* Update the first static call that is not used yet */
> -		if (!scall->hl) {
> -			__static_call_update(scall->key, scall->trampoline,
> -					     hl->hook.lsm_func_addr);
> -			scall->hl = hl;
> -			static_branch_enable(scall->active);
> -			return;
> -		}
> -		scall++;
> -	}
> -	panic("%s - Ran out of static slots.\n", __func__);
> -}
> -
> -/**
> - * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsmid: the identification information for the security module
> - *
> - * Each LSM has to register its hooks with the infrastructure.
> - */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -			       const struct lsm_id *lsmid)
> -{
> -	int i;
> -
> -	for (i = 0; i < count; i++) {
> -		hooks[i].lsmid = lsmid;
> -		lsm_static_call_init(&hooks[i]);
> -	}
> -}
> -
> -int __init early_security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	lsm_early_for_each_raw(lsm) {
> -		lsm_enabled_set(lsm, true);
> -		lsm_order_append(lsm, "early");
> -		lsm_prepare(lsm);
> -		lsm_init_single(lsm);
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * security_init - initializes the security framework
> - *
> - * This should be called early in the kernel initialization sequence.
> - */
> -int __init security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
> -	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
> -	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
> -
> -	/*
> -	 * Append the names of the early LSM modules now that kmalloc() is
> -	 * available
> -	 */
> -	lsm_early_for_each_raw(lsm) {
> -		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
> -	}
> -
> -	/* Load LSMs in specified order. */
> -	lsm_init_ordered();
>   
>   	return 0;
>   }


