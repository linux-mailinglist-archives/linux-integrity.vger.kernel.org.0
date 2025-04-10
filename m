Return-Path: <linux-integrity+bounces-5750-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138EA83505
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 02:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782931B6735C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537B53AC;
	Thu, 10 Apr 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkzcUwbD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90D4685;
	Thu, 10 Apr 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243900; cv=none; b=YpuwRHZbThXtLbNVx4AykbyRaCecdGvPPGBF6yzuKZtPLSiRI9wXSI0u8eckTQrEcfifhCiP0+QGEOHJTTWmUKqXPPYv/7oaq8+lKKo0sX+JpWpxRkLzVqfMJcTKJxrrX/NglyJkF4GTOVF79uWpjMXynbzjw65K8BiFYZM1Diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243900; c=relaxed/simple;
	bh=l7u3G5FskDGTRZL8mw18xKij5qhLkRxc1bM1ncxHQVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deEHtijLm5Zakx23gUTniiwYKz81LKOayLzphbdHwzFTBwbnfCPlAtawy4iNA/AcxaidVFLfCwRnihp9RUApUsw+IyQ3cj4bS8Zuc17QAK459FxByql7Z3mwLeLfQh33VKVp28zvxuf4ng5GLmDITEMgCM8gQUdnFq7gkK+mrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkzcUwbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B09C4CEE2;
	Thu, 10 Apr 2025 00:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243900;
	bh=l7u3G5FskDGTRZL8mw18xKij5qhLkRxc1bM1ncxHQVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkzcUwbDhMi8ZeKCC8cFdZZw8LDHNEZl38b+8/Vxx6/RBkekZijQVl/qZZj5g/mwI
	 wxmh52IYt0VP+cP3soze3dWDonk/XZAmDSXqpupqm6qGNfJ97lutuTx7Cy3qXcwsKE
	 SRBe2lnA2i//uaSShU4YeUVGiJXgf9Glm0nEUxNxazFNDYKIhm0EA0tyYZ8AXwYCmd
	 WpRMWdZVWMUQbHM6TfHRumurjShNjdpnep26bYMT/AHdNHPOix0Cnl1CZkt0Db3NZc
	 awCQIbsl/A/CLLsEAxOBHiHqH8MKLqoC5UKjIYyy9Awj9DCidTID2pS9lqotZMmQIC
	 O/6QafnleUbBw==
Date: Wed, 9 Apr 2025 17:11:37 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled
 functions
Message-ID: <202504091656.21EEF38DCA@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-40-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-40-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/inode.c    |   9 ++--
>  security/lsm_init.c | 110 ++++++++++++++++++++++++--------------------
>  2 files changed, 63 insertions(+), 56 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index 49bc3578bd23..f687e22e6809 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -351,18 +351,17 @@ static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  
>  	for (i = 0; i < lsm_count; i++)
>  		/* the '+ 1' accounts for either a comma or a NUL terminator */
> -		len += strlen(lsm_order[i]->id->name) + 1;
> +		len += strlen(lsm_idlist[i]->name) + 1;
>  
>  	str = kmalloc(len, GFP_KERNEL);
>  	if (!str)
>  		return -ENOMEM;
>  	str[0] = '\0';
>  
> -	i = 0;
> -	while (i < lsm_count) {
> -		strcat(str, lsm_order[i]->id->name);
> -		if (++i < lsm_count)
> +	for (i = 0; i < lsm_count; i++) {
> +		if (i > 0)
>  			strcat(str, ",");
> +		strcat(str, lsm_idlist[i]->name);
>  	}
>  
>  	rc = simple_read_from_buffer(buf, count, ppos, str, len);

This chunk needs to be folded into the lsm_names changing patch, I
think. I missed this on the first pass, but lsm_order can never be used
here because lsm_order is initdata -- it will be thrown away after init
is done.

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 978bb81b58fa..7f2bc8c22ce9 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,6 +10,10 @@
>  
>  #include "lsm.h"
>  
> +/* LSM enabled constants. */
> +int lsm_enabled_true = 1;
> +int lsm_enabled_false = 0;

Why are these losing static and __initdata? It looks like they're
staying assigned to the __init-marked lsm_info instances.

> +
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -72,41 +76,42 @@ static int __init lsm_debug_enable(char *str)
>  }
>  __setup("lsm.debug", lsm_debug_enable);
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
>  {
>  	/*
>  	 * When an LSM hasn't configured an enable variable, we can use
>  	 * a hard-coded location for storing the default enabled state.
>  	 */
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
>  	} else {
>  		*lsm->enabled = enabled;
>  	}
>  }

Good logic folding.

>  
> -static inline bool is_enabled(struct lsm_info *lsm)
> +/**
> + * lsm_is_enabled - Determine if a LSM is enabled
> + * @lsm: LSM definition
> + */
> +static inline bool lsm_is_enabled(struct lsm_info *lsm)
>  {
>  	if (!lsm->enabled)
>  		return false;
> -
>  	return *lsm->enabled;
>  }

This could be one-lined, actually:

	return lsm->enabled ? *lsm->enabled : false;

>  
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +/**
> + * lsm_order_exists - Determine if a LSM exists in the ordered list
> + * @lsm: LSM definition
> + */
> +static bool __init lsm_order_exists(struct lsm_info *lsm)
>  {
>  	struct lsm_info **check;
>  
> @@ -118,25 +123,29 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
>  	return false;
>  }
>  
> -/* Append an LSM to the list of ordered LSMs to initialize. */
> -static int last_lsm __initdata;
> -static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> +/**
> + * lsm_order_append - Append a LSM to the ordered list
> + * @lsm: LSM definition
> + * @src: source of the addition
> + */
> +static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>  {
>  	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> +	if (lsm_order_exists(lsm))
>  		return;
>  
> -	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> -		return;
> +	/* Skip explicitly disabled LSMs. */
> +	if (lsm->enabled && !lsm_is_enabled(lsm)) {
> +		if (WARN(lsm_count == MAX_LSM_COUNT,
> +			 "%s: out of LSM static calls!?\n", src))
> +			return;
> +		lsm_enabled_set(lsm, true);
> +		lsm_order[lsm_count] = lsm;
> +		lsm_idlist[lsm_count++] = lsm->id;
> +	}
>  
> -	/* Enable this LSM, if it is not already set. */
> -	if (!lsm->enabled)
> -		lsm->enabled = &lsm_enabled_true;
> -	lsm_order[last_lsm] = lsm;
> -	lsm_idlist[last_lsm++] = lsm->id;

I don't understand the logic change here. I may be missing something (it
feels like a lot of logic changes mixed together again), but this logic:

     /* Enable this LSM, if it is not already set. */
     if (!lsm->enabled)
             lsm->enabled = &lsm_enabled_true;

seems like it has gone missing now? And I think the last_lsm/lsm_count
changes need to be in the "lsm: rework lsm_active_cnt and lsm_idlist[]"
patch? I'm really struggling to follow this patch, but maybe I am EOD.
:P


> -
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> +	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
> +		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
>  static void __init lsm_set_blob_size(int *need, int *lbs)
> @@ -159,17 +168,17 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>  {
>  	struct lsm_blob_sizes *blobs;
>  
> -	if (!is_enabled(lsm)) {
> -		set_enabled(lsm, false);
> +	if (!lsm_is_enabled(lsm)) {
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>  		init_debug("exclusive disabled: %s\n", lsm->id->name);
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	}
>  
>  	/* Mark the LSM as enabled. */
> -	set_enabled(lsm, true);
> +	lsm_enabled_set(lsm, true);
>  	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>  		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>  		lsm_exclusive = lsm;
> @@ -200,7 +209,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>  /* Initialize a given LSM, if it is enabled. */
>  static void __init initialize_lsm(struct lsm_info *lsm)
>  {
> -	if (is_enabled(lsm)) {
> +	if (lsm_is_enabled(lsm)) {
>  		int ret;
>  
>  		init_debug("initializing %s\n", lsm->id->name);
> @@ -218,7 +227,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	/* LSM_ORDER_FIRST is always first. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "  first");
> +			lsm_order_append(lsm, "  first");
>  	}
>  
>  	/* Process "security=", if given. */
> @@ -235,7 +244,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		     major++) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->id->name, lsm_order_legacy) != 0) {
> -				set_enabled(major, false);
> +				lsm_enabled_set(major, false);
>  				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
>  					   lsm_order_legacy, major->id->name);
>  			}
> @@ -251,7 +260,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  			if (strcmp(lsm->id->name, name) == 0) {
>  				if (lsm->order == LSM_ORDER_MUTABLE)
> -					append_ordered_lsm(lsm, origin);
> +					lsm_order_append(lsm, origin);
>  				found = true;
>  			}
>  		}
> @@ -264,24 +273,24 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	/* Process "security=", if given. */
>  	if (lsm_order_legacy) {
>  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (exists_ordered_lsm(lsm))
> +			if (lsm_order_exists(lsm))
>  				continue;
>  			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
> -				append_ordered_lsm(lsm, "security=");
> +				lsm_order_append(lsm, "security=");
>  		}
>  	}
>  
>  	/* LSM_ORDER_LAST is always last. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if (lsm->order == LSM_ORDER_LAST)
> -			append_ordered_lsm(lsm, "   last");
> +			lsm_order_append(lsm, "   last");
>  	}
>  
>  	/* Disable all LSMs not in the ordered list. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (exists_ordered_lsm(lsm))
> +		if (lsm_order_exists(lsm))
>  			continue;
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
>  			   origin, lsm->id->name);
>  	}
> @@ -313,13 +322,13 @@ static void __init lsm_init_ordered(void)
>  
>  	pr_info("initializing lsm=");
>  	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> +		if (lsm_is_enabled(early))
>  			pr_cont("%s%s",
>  				early == __start_early_lsm_info ? "" : ",",
>  				early->id->name);
>  	}
>  	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> +		if (lsm_is_enabled(*lsm))
>  			pr_cont("%s%s",
>  				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
>  	}
> @@ -404,8 +413,7 @@ int __init early_security_init(void)
>  	struct lsm_info *lsm;
>  
>  	lsm_early_for_each_raw(lsm) {
> -		if (!lsm->enabled)
> -			lsm->enabled = &lsm_enabled_true;
> +		lsm_enabled_set(lsm, true);
>  		lsm_prep_single(lsm);
>  		initialize_lsm(lsm);
>  	}
> @@ -432,7 +440,7 @@ int __init security_init(void)
>  	 */
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> +			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  	}
>  
>  	/* Load LSMs in specified order. */
> -- 
> 2.49.0

The simple renamings looks fine, but would be nicer if they got split
out.

-- 
Kees Cook

