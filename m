Return-Path: <linux-integrity+bounces-5748-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30916A834D6
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3691C1B6128F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF921ABD7;
	Wed,  9 Apr 2025 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McrLBGTy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447771A5BA4;
	Wed,  9 Apr 2025 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242754; cv=none; b=LpXtnBkYWTLM4RdZBh/+tB9qtXJRC/a3vWIh/ilt55yxEa2fDxBGCo7SmRTutRzqA2f44+RDZJQ3xR08Gzuk4H3grmAd8m56y79rOYlV+xCWyG6wb7b8AOjs1zQoWQRWqxR+serczZezSlBCsazpPdh/0WZKPAL39dEYyLjfu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242754; c=relaxed/simple;
	bh=LoTycAir+5G700mQSKip5fyC0TQBQ8p5O3zHgIPojls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPQX3gWoDOaX6AJ9DHPLWGSFiM9qRQ9GVJO2BLYw9yakTUZfC16wCAYzCRm0k8iFb3d0MdkVt5zQUd/QgcPmEBgsFf9tWVdh3X2WYrlTuIVti3sn/7Zh0PJ1YczABx1Dgm8VSzFz3A1+8LVhDEo6LtFOpSrw59d+AULduMx/RKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McrLBGTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC43EC4CEE2;
	Wed,  9 Apr 2025 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242753;
	bh=LoTycAir+5G700mQSKip5fyC0TQBQ8p5O3zHgIPojls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McrLBGTyRpB/MKYXUHzt+9SjOp7K++1pG4TUyFNB7ErLEh4a1rqdESVhJLKz9pTEG
	 KdJ599Hy4+tnx7KPclu9bmYgBd7G1v2e7mrAV1sSReFTwZZ4u3hCva3m7zw6wKfTX6
	 Od/jeaafPrZ036Mh3HHjlxbS8fiCcFAPSJW4BN5oGMHYk1CwC8ogPT/bZ/pETB69XU
	 t9eiOVgllbtqpOTD4ENRBayjtstwoRJTnMvw+WmkeOBCeQSFhllUReEEdhYGfuYnPl
	 /aXzuwpVobKTLZuZ4eDhdjttgkRmtUGewHQxds3M4VfdqW7u82QCk3kaoY29S+g+Q9
	 G+/9U3oPWLdzw==
Date: Wed, 9 Apr 2025 16:52:30 -0700
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
Subject: Re: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework
 initcalls
Message-ID: <202504091649.E30A1670@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-58-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-58-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:12PM -0400, Paul Moore wrote:
> The LSM framework itself registers a small number of initcalls, this
> patch converts these initcalls into the new initcall mechanism.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/inode.c    |  3 +--
>  security/lsm.h      |  4 ++++
>  security/lsm_init.c | 14 ++++++++++++--
>  security/min_addr.c |  5 +++--
>  4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index f687e22e6809..671c66c147bc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -375,7 +375,7 @@ static const struct file_operations lsm_ops = {
>  };
>  #endif
>  
> -static int __init securityfs_init(void)
> +int __init securityfs_init(void)
>  {
>  	int retval;
>  
> @@ -394,4 +394,3 @@ static int __init securityfs_init(void)
>  #endif
>  	return 0;
>  }
> -core_initcall(securityfs_init);
> diff --git a/security/lsm.h b/security/lsm.h
> index 8ecb66896646..c432dc0c5e30 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
>  int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>  int lsm_task_alloc(struct task_struct *task);
>  
> +/* LSM framework initializers */
> +int securityfs_init(void);
> +int min_addr_init(void);
> +
>  #endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 75eb0cc82869..c0881407ca3f 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -485,7 +485,12 @@ int __init security_init(void)
>   */
>  static int __init security_initcall_pure(void)
>  {
> -	return lsm_initcall(pure);
> +	int rc_adr, rc_lsm;
> +
> +	rc_adr = min_addr_init();
> +	rc_lsm = lsm_initcall(pure);
> +
> +	return (rc_adr ? rc_adr : rc_lsm);
>  }
>  pure_initcall(security_initcall_pure);
>  
> @@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
>   */
>  static int __init security_initcall_core(void)
>  {
> -	return lsm_initcall(core);
> +	int rc_sfs, rc_lsm;
> +
> +	rc_sfs = securityfs_init();
> +	rc_lsm = lsm_initcall(core);
> +
> +	return (rc_sfs ? rc_sfs : rc_lsm);
>  }
>  core_initcall(security_initcall_core);

Hrm. Given these aren't really _lsm_ hooks, maybe just leave this out. I
worry about confusing the lsm inits with the lsm subsystem's core inits.
Or we need a new stacking type for "required"? But that seems ... heavy.

-Kees

>  
> diff --git a/security/min_addr.c b/security/min_addr.c
> index df1bc643d886..40714bdeefbe 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -4,6 +4,8 @@
>  #include <linux/security.h>
>  #include <linux/sysctl.h>
>  
> +#include "lsm.h"
> +
>  /* amount of vm to protect from userspace access by both DAC and the LSM*/
>  unsigned long mmap_min_addr;
>  /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
> @@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
>  	},
>  };
>  
> -static int __init init_mmap_min_addr(void)
> +int __init min_addr_init(void)
>  {
>  	register_sysctl_init("vm", min_addr_sysctl_table);
>  	update_mmap_min_addr();
>  
>  	return 0;
>  }
> -pure_initcall(init_mmap_min_addr);
> -- 
> 2.49.0
> 

-- 
Kees Cook

