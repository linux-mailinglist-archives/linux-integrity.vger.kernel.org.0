Return-Path: <linux-integrity+bounces-5732-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C00A8337A
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1277D17111C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE22135A1;
	Wed,  9 Apr 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyzWVakr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3121324E;
	Wed,  9 Apr 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234718; cv=none; b=U782pt/fvqLjFn5kgDdfaP+vWHswBFNQtHLuVCZGM9nYzB4Gvqbh0fi1+ceVyoHjEh+xzudhAcLTPWNVN43Tpe3vK1zf83CPP7OPFrWFodc5f3mF4GwJyUXmrH6TEZF7ohxoGijvEjgV/HAs+7ONDiRCYY1Phs9gFcZdVg+beAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234718; c=relaxed/simple;
	bh=NgNEGsc/PB76G+1Qn4WHyb6dPGyxzqa2T/v4MBr0Xt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd/ghsYL5Sl0tLtsd5IIHKecaktG2/Y75EJ9RqiCsscl4A5xhmZmK8Y+70QBH9ALdQohYJjYjAUscSL0FBTT29YmJfUajOxvOqsgLalcW7WltdRXoQQjs3zshTyYcezA5/X1dy71i5VPSOMV8+Vks2ydYAhlsYVvaemtFaeYq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyzWVakr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D393DC4CEE2;
	Wed,  9 Apr 2025 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744234717;
	bh=NgNEGsc/PB76G+1Qn4WHyb6dPGyxzqa2T/v4MBr0Xt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyzWVakrW+DjDqCchMFJ0nFlLojk9T0PbY38xcQOTu3P5BEs2/FiNlk0Skihhhnmo
	 GmlyUdGL3Mu/VQCgdmp0NCY0ZRN/RkKlD5FHRvfQvmaKHKGXlvnfZIqrReGgWtLDRO
	 JVN17B1h4cHNRtgT9adJp8l7JGLovJm4B/R9N2x+EMXPX/h2YsuZGoN2a7tzwpYElX
	 0RmFTvdREGV5GJQMEMqFeKtl/5z47rcqM5FOFmV/75ztkvh72MYU7IbOPh/GVqSGgu
	 Id8GPu0XPeuPjozeSskgrGUPPiufMqhMDoigeiR6QCqEe0jsBwJ4UDL+h+yl+Pgs5l
	 YfQiOabfuEXxw==
Date: Wed, 9 Apr 2025 14:38:34 -0700
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
Subject: Re: [RFC PATCH 04/29] lsm: simplify ordered_lsm_init() and rename to
 lsm_init_ordered()
Message-ID: <202504091435.E172A67C6@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-35-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-35-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:49PM -0400, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.

Again, needs a better commit log.

> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/lsm_init.c | 94 +++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 58 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index dffa8dc2da36..407429688f1b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -32,6 +32,12 @@ static __initdata bool debug;
>  			pr_info(__VA_ARGS__);				\
>  	} while (0)
>  
> +#define lsm_order_for_each(iter)					\
> +	for ((iter) = ordered_lsms; *(iter); (iter)++)
> +#define lsm_early_for_each_raw(iter)					\
> +	for ((iter) = __start_early_lsm_info;				\
> +	     (iter) < __end_early_lsm_info; (iter)++)

The longer I look at this patch the longer I think it needs to be broken
up into a few separate patches, but they would be relatively small, like
this one: replace iter loops with iter macros.

> +
>  static int lsm_append(const char *new, char **result);
>  
>  /* Save user chosen LSM */
> @@ -96,9 +102,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
>  {
>  	struct lsm_info **check;
>  
> -	for (check = ordered_lsms; *check; check++)
> +	lsm_order_for_each(check) {
>  		if (*check == lsm)
>  			return true;
> +	}
>  
>  	return false;
>  }
> @@ -279,56 +286,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first = 0;
> -
> -	pr_info("initializing lsm=");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	for (early = __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> -
> -	pr_cont("\n");
> -}
> -
>  /**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> + * lsm_init_ordered - Initialize the ordered LSMs
>   */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc = lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
> -static void __init ordered_lsm_init(void)
> +static void __init lsm_init_ordered(void)
>  {
>  	struct lsm_info **lsm;
> +	struct lsm_info *early;
>  
>  	if (chosen_lsm_order) {
>  		if (chosen_major_lsm) {
> @@ -340,10 +304,23 @@ static void __init ordered_lsm_init(void)
>  	} else
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>  		lsm_prep_single(*lsm);
> +	}
>  
> -	report_lsm_order();
> +	pr_info("initializing lsm=");
> +	lsm_early_for_each_raw(early) {
> +		if (is_enabled(early))
> +			pr_cont("%s%s",
> +				early == __start_early_lsm_info ? "" : ",",
> +				early->name);
> +	}
> +	lsm_order_for_each(lsm) {
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s",
> +				lsm == ordered_lsms ? "" : ",", (*lsm)->name);
> +	}

report_lsm_order()'s use of "first" needs to stay here or you don't get
the right comma/no-comma behavior. It's not about the lsm, it's about
whether "first" got incremented. Perhaps "count" might be a better name
for "first".

> +	pr_cont("\n");
>  
>  	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>  	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> @@ -362,9 +339,6 @@ static void __init ordered_lsm_init(void)
>  	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>  	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
>  
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
>  	if (blob_sizes.lbs_file)
>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>  						   blob_sizes.lbs_file, 0,
> @@ -374,10 +348,14 @@ static void __init ordered_lsm_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
>  
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> +		panic("%s: early cred alloc failed.\n", __func__);
> +	if (lsm_task_alloc(current))
> +		panic("%s: early task alloc failed.\n", __func__);
> +
> +	lsm_order_for_each(lsm) {
>  		initialize_lsm(*lsm);
> +	}
>  }
>  
>  static bool match_last_lsm(const char *list, const char *lsm)
> @@ -479,7 +457,7 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
>  		lsm_prep_single(lsm);
> @@ -506,7 +484,7 @@ int __init security_init(void)
>  	 * Append the names of the early LSM modules now that kmalloc() is
>  	 * available
>  	 */
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)
> @@ -514,7 +492,7 @@ int __init security_init(void)
>  	}
>  
>  	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> +	lsm_init_ordered();
>  
>  	return 0;
>  }
> -- 
> 2.49.0
> 

Other stuff seems good.

-- 
Kees Cook

