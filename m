Return-Path: <linux-integrity+bounces-5727-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABDA8331E
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACDC19E0C95
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC35214201;
	Wed,  9 Apr 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmy2FGnt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC291EB18E;
	Wed,  9 Apr 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233403; cv=none; b=b8Le6qUrx8uedKkFLtBlcocOm82efjDmoBo6wAOPbzX0W6VWDO0z7hU+Cg1C4eINFArciA/fdy/SokmeuczUecehH+mx3pOJJ+Fw+CtmpMmzcVI8WkgezF9DLWZRCcJAcdp1zSxE1mhThkle15BVfh+O9UVHWOf7LwkUsFNbjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233403; c=relaxed/simple;
	bh=+mqY8nLH6ozGdqw3+Rz1yDdpQlH+FIoOnuqVmEWUUKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPKV++mFZTQAR7XYKKAEeosVzaEgnDkL3AjvWD2uBShaCIE2I10WrWd+s9u/bH9S4NsjIH3zkvp5VrQPCa7Jcefw/ze7YunTm1BQT/AdYPe0RTJstBbjMoHjQ1a+SMT38YuZk1cNC47EFcOHHL2QUFVsEzO2eTlu/3kuQfd7aFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmy2FGnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5676C4CEE2;
	Wed,  9 Apr 2025 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744233400;
	bh=+mqY8nLH6ozGdqw3+Rz1yDdpQlH+FIoOnuqVmEWUUKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cmy2FGnt6RKSBHp4nugrmO9gaL8uU4BZZ9jzoA4Q3c5pFLY7cH+FYbqi6JvwvynVw
	 lKoldyDhh0N9qLdoOoCbirFU8fqGZOYT7l6kR1HfNHDuiVPjJoklen5ODet5DrXTjw
	 5kCM5Ue770pRo4CmfWREuEyUIgXZaA+qN3opRyY9/Rz17VA2j0o+zUg7GCVwz7O7qZ
	 2BCkielMJBleKdBy669h6JXRvmTDLu1uyvdBV4xW5KZNBh2nWCMSrG1W3qciPa146V
	 McrRweZgLnrnaLHMpJPXyzdIB3qJV1pqo9AaMKp8l8dPzGmPI9lMJIT4zZXYAcz62Q
	 2ochW06DTuLMA==
Date: Wed, 9 Apr 2025 14:16:37 -0700
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
Subject: Re: [RFC PATCH 17/29] lsm: introduce an initcall mechanism into the
 LSM framework
Message-ID: <202504091406.0A86DE05@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-48-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-48-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:02PM -0400, Paul Moore wrote:
> Currently the individual LSMs register their own initcalls, and while
> this should be harmless, it can be wasteful in the case where a LSM
> is disabled at boot as the initcall will still be executed.  This
> patch introduces support for managing the initcalls in the LSM
> framework, and future patches will convert the existing LSMs over to
> this new mechanism.
> 
> Only initcall types which are used by the current in-tree LSMs are
> supported, additional initcall types can easily be added in the future
> if needed.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h | 33 ++++++++++++---
>  security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a7ecb0791a0f..0d2c2a017ffc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -148,13 +148,36 @@ enum lsm_order {
>  	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
>  };
>  
> +/**
> + * struct lsm_info - Define an individual LSM for the LSM framework.
> + * @id: LSM name/ID info
> + * @order: ordering with respect to other LSMs, optional
> + * @flags: descriptive flags, optional
> + * @blobs: LSM blob sharing, optional
> + * @enabled: controlled by CONFIG_LSM, optional
> + * @init: LSM specific initialization routine
> + * @initcall_pure: LSM callback for initcall_pure() setup, optional
> + * @initcall_early: LSM callback for early_initcall setup, optional
> + * @initcall_core: LSM callback for core_initcall() setup, optional
> + * @initcall_subsys: LSM callback for subsys_initcall() setup, optional
> + * @initcall_fs: LSM callback for fs_initcall setup, optional
> + * @nitcall_device: LSM callback for device_initcall() setup, optional
> + * @initcall_late: LSM callback for late_initcall() setup, optional
> + */

Yay! Proper kerndoc. :)

>  struct lsm_info {
>  	const struct lsm_id *id;
> -	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
> -	unsigned long flags;	/* Optional: flags describing LSM */
> -	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> -	int (*init)(void);	/* Required. */
> -	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
> +	enum lsm_order order;
> +	unsigned long flags;
> +	struct lsm_blob_sizes *blobs;
> +	int *enabled;
> +	int (*init)(void);
> +	int (*initcall_pure)(void);
> +	int (*initcall_early)(void);
> +	int (*initcall_core)(void);
> +	int (*initcall_subsys)(void);
> +	int (*initcall_fs)(void);
> +	int (*initcall_device)(void);
> +	int (*initcall_late)(void);
>  };
>  
>  #define DEFINE_LSM(lsm)							\
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 8e00afeb84cf..75eb0cc82869 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -39,6 +39,27 @@ static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  	for ((iter) = __start_early_lsm_info;				\
>  	     (iter) < __end_early_lsm_info; (iter)++)
>  
> +#define lsm_initcall(level)						\
> +	({ 								\
> +		int _r, _rc = 0;					\
> +		struct lsm_info **_lp, *_l; 				\
> +		lsm_order_for_each(_lp) { 				\
> +			_l = *_lp; 					\
> +			if (!_l->initcall_##level) 			\
> +				continue;				\
> +			lsm_pr_dbg("running %s %s initcall",		\
> +				   _l->id->name, #level);		\
> +			_r = _l->initcall_##level();			\
> +			if (_r) {					\
> +				pr_warn("failed LSM %s %s initcall with errno %d\n", \
> +					_l->id->name, #level, _r);	\
> +				if (!_rc)				\
> +					_rc = _r;			\
> +			}						\
> +		}							\
> +		_rc;							\
> +	})
> +
>  /**
>   * lsm_choose_security - Legacy "major" LSM selection
>   * @str: kernel command line parameter
> @@ -458,3 +479,71 @@ int __init security_init(void)
>  
>  	return 0;
>  }
> +
> +/**
> + * security_initcall_pure - Run the LSM pure initcalls
> + */
> +static int __init security_initcall_pure(void)
> +{
> +	return lsm_initcall(pure);
> +}
> +pure_initcall(security_initcall_pure);
> +
> +/**
> + * security_initcall_early - Run the LSM early initcalls
> + */
> +static int __init security_initcall_early(void)
> +{
> +	return lsm_initcall(early);
> +}
> +early_initcall(security_initcall_early);
> +
> +/**
> + * security_initcall_core - Run the LSM core initcalls
> + */
> +static int __init security_initcall_core(void)
> +{
> +	return lsm_initcall(core);
> +}
> +core_initcall(security_initcall_core);
> +
> +/**
> + * security_initcall_subsys - Run the LSM subsys initcalls
> + */
> +static int __init security_initcall_subsys(void)
> +{
> +	return lsm_initcall(subsys);
> +}
> +subsys_initcall(security_initcall_subsys);
> +
> +/**
> + * security_initcall_fs - Run the LSM fs initcalls
> + */
> +static int __init security_initcall_fs(void)
> +{
> +	return lsm_initcall(fs);
> +}
> +fs_initcall(security_initcall_fs);
> +
> +/**
> + * security_initcall_device - Run the LSM device initcalls
> + */
> +static int __init security_initcall_device(void)
> +{
> +	return lsm_initcall(device);
> +}
> +device_initcall(security_initcall_device);
> +
> +/**
> + * security_initcall_late - Run the LSM late initcalls
> + */
> +static int __init security_initcall_late(void)
> +{
> +	int rc;
> +
> +	rc = lsm_initcall(late);
> +	lsm_pr_dbg("all enabled LSMs fully activated\n");
> +
> +	return rc;
> +}
> +late_initcall(security_initcall_late);

You'd need a new place for the lsm_pr_dbg, but these are all just
copy/paste. These could be macro-ified too?

#define define_lsm_initcall(level)			\
static int __init security_initcall_##level(void)	\
{							\
	return lsm_initcall(level);			\
}							\
level##_initcall(security_initcall_##level)

define_lsm_initcall(pure);
define_lsm_initcall(early);
define_lsm_initcall(core);
define_lsm_initcall(subsys);
define_lsm_initcall(fs);
define_lsm_initcall(device);
define_lsm_initcall(late);

I'm not sure exposing the kerndoc for them is worth open-coding them?

And, actually, it's just a macro calling a macro. You could just combine
them? i.e. turn lsm_initcall() into:

#define define_lsm_initcall(level)				\
static int __init security_initcall_##level(void)		\
{	 							\
	int _r, _rc = 0;					\
	struct lsm_info **_lp, *_l; 				\
	...
	return _rc;						\
}								\
level##_initcall(security_initcall_##level)


But, I like it either way.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

