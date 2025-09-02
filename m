Return-Path: <linux-integrity+bounces-6982-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C61B40C3F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737405E471F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EF345722;
	Tue,  2 Sep 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ojITE5pu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B42D5C91
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834792; cv=none; b=V9C6j1ePZc41BJALtltnzn5+GNqp8xVF6bjROX3FNTLZkOOXUxEvP0Du/Wlihjpx9vgcmGlu1hCq9blCtzekw2JCkmhi8tDaBQH6fxb0UtzZAofqkXzFBymnU0PNItR9nduNRUXwdNGokkaRSmk8JzWnCCatX/korIhTmno72E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834792; c=relaxed/simple;
	bh=9EjYW0NlXmZj7ngtFFwvLwjOZz3+gof9lGMzMMq6GEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0NRtWf9MP7W/PGspZqDM5pNv/NWHqgITc+uUa1uydOBI7B8iluygSGlzhdqDiMh1KGLnrryKR4cN9NCbrkREYRQDtCSzB7Gff7zS2rOOw1XFVyPBS2KJTpHLlzFW+1gXNtRs7vceWMT28e5km+XwjGUI0BI/Tvfe1aB+6vFMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ojITE5pu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A3CE3F46B
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756834788;
	bh=CQAPL2B8jwXU/gL5cL3xyJ/d1DMjUpNCkzMpRDfNqZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ojITE5puDr3t/AHUInsTTO4ckv1Ro0F96VqGURn7ytk4OEry5ryxrBxKvfoytX3R9
	 KSUKUWcyWMJXUGn379iFVUBdBRbtXuH1hxNmvSlyI+Nz8sSmvq54Ax0Ns6vQ8S7k3U
	 GS35NJap9X6pSfVGSd/9OM6mIu0WFgRYkBhMoGGTuRTv4eqrW4YfSKz/9sUUDRYdZN
	 ILSW9cxvHpSuJ30vO5CHkradDYzuVR5IgaoJxsRLaAFOdO7AEyBF73RekBE0ec6lKb
	 Dw+UL2lH9DmUyJThmvnDicaZzEoguekEIDnreHkz4ME8xpTm7XL5VOpn3SXcPy1SaV
	 5UfdJNSoRPljA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329e375d372so1210733a91.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 10:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834787; x=1757439587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQAPL2B8jwXU/gL5cL3xyJ/d1DMjUpNCkzMpRDfNqZo=;
        b=SJfI1S9lUuZdLk+sxpoxoITtjAURfBzPGrdGxXpT8KVfZLFb1Qa3X1vDxnx34IyLQO
         aYgtnX6uFXqzNL6IAstbVQuvXwwvDB3P7ahgCH0AiIhOgWD8nCQbjviHa/UM8GxhjDnq
         RJTwFKD8gPDvlc8E6a9x8Msqnd394NPvwJzrxeVoabB45uYXxxbuvYju1/qHR0cNnVng
         bRWgp3y5RtVAtVU/ALW39t8LDUBphlSAWqz6xE1vL0FYpA0I0+omYDvfG06jhqSBmA0O
         pOE7FXuqhFaqdF4MKCrJ7w9w+fC9pswzubGIXIUrACmkP0CscwXOdCkFmcjttERqDuO1
         sDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrMxIRjTHlW5/bZv/uv0Ze/sG+B/rFHTeLsi8BmaYse/IBkCmqERhHcDaCyoEPRcd4z0ovDpW/DPnVF5biKj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YJAR1td5pbUX8/wb+Eo6r6jd9zz/DQSlHjT4dVYRZhYDuWfp
	y+WOZ4gvkEo35qdMBB5nMsaVpY3Urte4hK2cpw3CHLdqRJ5MfsvEndDPKILzFWi7guAQMaZCXMe
	2G8ekfsGeDGNQ2P7lCAKgnDCIXI+p0j+NUeVXf8wmg9MyL1pI+JCC1UrNrsQaiVuhHIRZb4cKaB
	GKjLEpE3uCog==
X-Gm-Gg: ASbGncvl9nFENqPgF5OBXMUfTnSFHvAfZBrS5noHbINzSoXlH+NDuQ+NjeDpBsYLcoD
	q1Tshu0COjwF/seou9OvfsSDvAJ6xY927X9OOnUQp3eeODQPB3UiQWGuyedbN0GGqEfTe/Kw9e7
	ULVNVjcfD5nUoB1sxV34ZLwMulITeNIXJith1iuwaxTPlbB4/A+gnNk0IDNlUk5ccL2Sye9CUKx
	RENxT8KlmT+ixY+WfeRzfBcntQtTQU2GlisZbE35U2JSVqs1sY6Wb8Wdz5PPqMAQ61mnB4rWROA
	AyeS+IcsBx6RQmZ+WY7cPjdWSHpQ9CUOvD347t76LRKYHTUQsvm8VA==
X-Received: by 2002:a17:90b:4c8e:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32815412afemr17944778a91.4.1756834786522;
        Tue, 02 Sep 2025 10:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeJUN3gU0fn6ndmM4prVYdQtdUviIC6tlxtrjRGwMTHzubjAPqyn19lmQY/EJ+mRPyfxK0jw==
X-Received: by 2002:a17:90b:4c8e:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32815412afemr17944753a91.4.1756834786036;
        Tue, 02 Sep 2025 10:39:46 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3274572be3bsm12635573a91.2.2025.09.02.10.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:39:45 -0700 (PDT)
Message-ID: <862db43b-52fd-4ad8-b42b-c3fd4033fcd5@canonical.com>
Date: Tue, 2 Sep 2025 10:39:44 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/34] lsm: rework the LSM enable/disable setter/getter
 functions
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
 <20250814225159.275901-48-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-48-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> In addition to style changes, rename set_enabled() to lsm_enabled_set()

not a fan of the ordering of enabled_set() vs. set_enabled() but not
terribly important either

> and is_enabled() to lsm_is_enabled() to better fit within the LSM
> initialization code.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 87e2147016b3..2cfd72ade6fb 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,6 +10,10 @@
>   
>   #include "lsm.h"
>   
> +/* LSM enabled constants. */
> +static __initdata int lsm_enabled_true = 1;
> +static __initdata int lsm_enabled_false = 0;
> +
>   /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>   extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>   extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
>   }
>   __setup("lsm.debug", lsm_debug_enable);
>   
> -/* Mark an LSM's enabled flag. */
> -static int lsm_enabled_true __initdata = 1;
> -static int lsm_enabled_false __initdata = 0;
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +/**
> + * lsm_enabled_set - Mark a LSM as enabled
> + * @lsm: LSM definition
> + * @enabled: enabled flag
> + */
> +static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
>   {
>   	/*
>   	 * When an LSM hasn't configured an enable variable, we can use
>   	 * a hard-coded location for storing the default enabled state.
>   	 */
> -	if (!lsm->enabled) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> -		else
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_true) {
> -		if (!enabled)
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_false) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> +	if (!lsm->enabled ||
> +	    lsm->enabled == &lsm_enabled_true ||
> +	    lsm->enabled == &lsm_enabled_false) {
> +		lsm->enabled = enabled ? &lsm_enabled_true : &lsm_enabled_false;
>   	} else {
>   		*lsm->enabled = enabled;
>   	}
>   }
>   
> -static inline bool is_enabled(struct lsm_info *lsm)
> +/**
> + * lsm_is_enabled - Determine if a LSM is enabled
> + * @lsm: LSM definition
> + */
> +static inline bool lsm_is_enabled(struct lsm_info *lsm)
>   {
> -	if (!lsm->enabled)
> -		return false;
> -
> -	return *lsm->enabled;
> +	return (lsm->enabled ? *lsm->enabled : false);
>   }
>   
>   /* Is an LSM already listed in the ordered LSMs list? */
> @@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   	lsm_idlist[last_lsm++] = lsm->id;
>   
>   	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> +		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
>   static void __init lsm_set_blob_size(int *need, int *lbs)
> @@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>   {
>   	struct lsm_blob_sizes *blobs;
>   
> -	if (!is_enabled(lsm)) {
> -		set_enabled(lsm, false);
> +	if (!lsm_is_enabled(lsm)) {
> +		lsm_enabled_set(lsm, false);
>   		return;
>   	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>   		init_debug("exclusive disabled: %s\n", lsm->id->name);
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>   		return;
>   	}
>   
>   	/* Mark the LSM as enabled. */
> -	set_enabled(lsm, true);
> +	lsm_enabled_set(lsm, true);
>   	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>   		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>   		lsm_exclusive = lsm;
> @@ -206,7 +206,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>   /* Initialize a given LSM, if it is enabled. */
>   static void __init initialize_lsm(struct lsm_info *lsm)
>   {
> -	if (is_enabled(lsm)) {
> +	if (lsm_is_enabled(lsm)) {
>   		int ret;
>   
>   		init_debug("initializing %s\n", lsm->id->name);
> @@ -240,7 +240,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		lsm_for_each_raw(major) {
>   			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>   			    strcmp(major->id->name, lsm_order_legacy) != 0) {
> -				set_enabled(major, false);
> +				lsm_enabled_set(major, false);
>   				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
>   					   lsm_order_legacy, major->id->name);
>   			}
> @@ -286,7 +286,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	lsm_for_each_raw(lsm) {
>   		if (exists_ordered_lsm(lsm))
>   			continue;
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>   		init_debug("%s skipped: %s (not in requested order)\n",
>   			   origin, lsm->id->name);
>   	}
> @@ -319,12 +319,12 @@ static void __init lsm_init_ordered(void)
>   
>   	pr_info("initializing lsm=");
>   	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> +		if (lsm_is_enabled(early))
>   			pr_cont("%s%s",
>   				first++ == 0 ? "" : ",", early->id->name);
>   	}
>   	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> +		if (lsm_is_enabled(*lsm))
>   			pr_cont("%s%s",
>   				first++ == 0 ? "" : ",", (*lsm)->id->name);
>   	}
> @@ -440,7 +440,7 @@ int __init security_init(void)
>   	 */
>   	lsm_early_for_each_raw(lsm) {
>   		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> +			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>   	}
>   
>   	/* Load LSMs in specified order. */


