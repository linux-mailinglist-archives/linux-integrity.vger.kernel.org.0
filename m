Return-Path: <linux-integrity+bounces-5897-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C4A8AB41
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EEC190213E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDBD27A11E;
	Tue, 15 Apr 2025 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JHgSBOWQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34206253931;
	Tue, 15 Apr 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755826; cv=none; b=AHonOQ0dcB1W2Uy0a5T6YTFCQtCch3neAXSXAYFKS/+42VHWsj5Z8slxMivzaMiit4CeNlVSk1pAPgJIhbASpJZgHOskU/z2YBVfjey0cToIlgZMADQIPLPArJiILOVBQ+t5Va0EEPdwWZA8+Ue9sVfrnAkXFMLzc2I5WUHb0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755826; c=relaxed/simple;
	bh=UR1EetPlV+Nd5sGJsTN2JugrrrnfSEbKC7T3+YfjMk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLvzYgNI+xYMuAR69Kkap136y0Y1JafddRiRGYs/IKdiCEBHQ1fx0g6xRgfzxhVIeou25bGea/eSrcgOjhBlDMKfpocAmPYCh2HX2s2KBEjUhM0wALsH9re6nDbOpoeOnuq2CnWKU1G0d848ekmMHC+/9iBTS5RGikeeQsV02IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JHgSBOWQ; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E9E4C3FFBD;
	Tue, 15 Apr 2025 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744755822;
	bh=OLZPU84AT8z/GbuM8a7jT0j3hPgDeUKlnU69wpD/hLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JHgSBOWQ2MLCSOkbwNUqN/6PKTx2KlpCoqmM83hjnSRh1dc8eAnil+gPhxqtna/S+
	 oWXdHMOZ68vEoVtjcWOP2+A0wzsSN9oZqVxLZ+rWCRepSsC+9+ZjoPraJoojo8BXby
	 qyc8ZauGG/rvzBcbxPxS3yjL1l4Oq3pJpH2ziEGcFUqtIsP+HfOJTsq/O1oMC4ecoZ
	 sLAVSi/SGUeFfiCPglB9DArvtCpRRiyZywrx+GpDsgT/oTapbYK99Cj5l7GE9hjQLO
	 nQv/JUvE20HyqzBRpX6gv9qS2mLha9K7KWD8v43jAr2S8KsKawWlpwwq/GJMM39+f2
	 pWGN24gSW/x7A==
Message-ID: <48b48a94-8dd5-4c5e-8de9-ef2ff3645846@canonical.com>
Date: Tue, 15 Apr 2025 15:23:36 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/29] lsm: cleanup and normalize the LSM order
 symbols naming
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-37-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-37-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:49, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

with the commit message updates already brought up, code looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 88 +++++++++++++++++++++++++--------------------
>   1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index d458a365b0d5..edf2f4140eaa 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -16,14 +16,14 @@ char *lsm_names;
>   extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>   extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>   
> -/* Boot-time LSM user choice */
> -static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
> -static __initdata const char *chosen_lsm_order;
> -static __initdata const char *chosen_major_lsm;
> +/* Build and boot-time LSM ordering. */
> +static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
> +static __initdata const char *lsm_order_cmdline;
> +static __initdata const char *lsm_order_legacy;
>   
>   /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> -static __initdata struct lsm_info *exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> +static __initdata struct lsm_info *lsm_exclusive;
>   
>   static __initdata bool debug;
>   #define init_debug(...)							\
> @@ -33,36 +33,46 @@ static __initdata bool debug;
>   	} while (0)
>   
>   #define lsm_order_for_each(iter)					\
> -	for ((iter) = ordered_lsms; *(iter); (iter)++)
> +	for ((iter) = lsm_order; *(iter); (iter)++)
>   #define lsm_early_for_each_raw(iter)					\
>   	for ((iter) = __start_early_lsm_info;				\
>   	     (iter) < __end_early_lsm_info; (iter)++)
>   
> -static int lsm_append(const char *new, char **result);
> -
> -/* Save user chosen LSM */
> -static int __init choose_major_lsm(char *str)
> +/**
> + * lsm_choose_security - Legacy "major" LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_security(char *str)
>   {
> -	chosen_major_lsm = str;
> +	lsm_order_legacy = str;
>   	return 1;
>   }
> -__setup("security=", choose_major_lsm);
> +__setup("security=", lsm_choose_security);
>   
> -/* Explicitly choose LSM initialization order. */
> -static int __init choose_lsm_order(char *str)
> +/**
> + * lsm_choose_lsm - Modern LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_lsm(char *str)
>   {
> -	chosen_lsm_order = str;
> +	lsm_order_cmdline = str;
>   	return 1;
>   }
> -__setup("lsm=", choose_lsm_order);
> +__setup("lsm=", lsm_choose_lsm);
>   
> -/* Enable LSM order debugging. */
> -static int __init enable_debug(char *str)
> +/**
> + * lsm_debug_enable - Enable LSM framework debugging
> + * @str: kernel command line parameter
> + *
> + * Currently we only provide debug info during LSM initialization, but we may
> + * want to expand this in the future.
> + */
> +static int __init lsm_debug_enable(char *str)
>   {
>   	debug = true;
>   	return 1;
>   }
> -__setup("lsm.debug", enable_debug);
> +__setup("lsm.debug", lsm_debug_enable);
>   
>   /* Mark an LSM's enabled flag. */
>   static int lsm_enabled_true __initdata = 1;
> @@ -124,7 +134,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   	/* Enable this LSM, if it is not already set. */
>   	if (!lsm->enabled)
>   		lsm->enabled = &lsm_enabled_true;
> -	ordered_lsms[last_lsm] = lsm;
> +	lsm_order[last_lsm] = lsm;
>   	lsm_idlist[last_lsm++] = lsm->id;
>   
>   	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> @@ -154,7 +164,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>   	if (!is_enabled(lsm)) {
>   		set_enabled(lsm, false);
>   		return;
> -	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>   		init_debug("exclusive disabled: %s\n", lsm->id->name);
>   		set_enabled(lsm, false);
>   		return;
> @@ -162,9 +172,9 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>   
>   	/* Mark the LSM as enabled. */
>   	set_enabled(lsm, true);
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>   		init_debug("exclusive chosen:   %s\n", lsm->id->name);
> -		exclusive = lsm;
> +		lsm_exclusive = lsm;
>   	}
>   
>   	/* Register the LSM blob sizes. */
> @@ -220,7 +230,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	}
>   
>   	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>   		struct lsm_info *major;
>   
>   		/*
> @@ -232,10 +242,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		for (major = __start_lsm_info; major < __end_lsm_info;
>   		     major++) {
>   			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, chosen_major_lsm) != 0) {
> +			    strcmp(major->id->name, lsm_order_legacy) != 0) {
>   				set_enabled(major, false);
>   				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   chosen_major_lsm, major->id->name);
> +					   lsm_order_legacy, major->id->name);
>   			}
>   		}
>   	}
> @@ -260,11 +270,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	}
>   
>   	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>   		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>   			if (exists_ordered_lsm(lsm))
>   				continue;
> -			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
> +			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
>   				append_ordered_lsm(lsm, "security=");
>   		}
>   	}
> @@ -295,15 +305,15 @@ static void __init lsm_init_ordered(void)
>   	struct lsm_info **lsm;
>   	struct lsm_info *early;
>   
> -	if (chosen_lsm_order) {
> -		if (chosen_major_lsm) {
> +	if (lsm_order_cmdline) {
> +		if (lsm_order_legacy) {
>   			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				chosen_major_lsm, chosen_lsm_order);
> -			chosen_major_lsm = NULL;
> +				lsm_order_legacy, lsm_order_cmdline);
> +			lsm_order_legacy = NULL;
>   		}
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> +		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
>   	} else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +		ordered_lsm_parse(lsm_order_builtin, "builtin");
>   
>   	lsm_order_for_each(lsm) {
>   		lsm_prep_single(*lsm);
> @@ -319,7 +329,7 @@ static void __init lsm_init_ordered(void)
>   	lsm_order_for_each(lsm) {
>   		if (is_enabled(*lsm))
>   			pr_cont("%s%s",
> -				lsm == ordered_lsms ? "" : ",", (*lsm)->id->name);
> +				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
>   	}
>   	pr_cont("\n");
>   
> @@ -465,9 +475,9 @@ int __init security_init(void)
>   {
>   	struct lsm_info *lsm;
>   
> -	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
> -	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> -	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
> +	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
> +	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
>   
>   	/*
>   	 * Append the names of the early LSM modules now that kmalloc() is


