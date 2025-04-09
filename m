Return-Path: <linux-integrity+bounces-5743-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC72A834B8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879A419E4513
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9121CC7C;
	Wed,  9 Apr 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwrW/0vT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838582135AD;
	Wed,  9 Apr 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242166; cv=none; b=YMw41G1ojsCgV/B2wkK1T0ihvJB4A5Pq1/O7QLF8UYwP8N60Mv1mxKj7RucAjc/vS3l50J6lsBc5T4canPB9yYxex1aTTuy7cQbCZ770i6ooYbZ4jbFqtgJdeUMKC5epjMH85LeR3tTqMlht6lA0dPwfJaKftK5fkpWS4O2jpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242166; c=relaxed/simple;
	bh=fd1XZ9DP1i3ZKcXtK0GbmtugiXsp8ZiAgCYkG7jHH9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpX/exYA5mbMBbjlJSfKhjgTwLfZ5NohSmWPLQVPfCpn0/KCNLNxkfR5RgtBgw1BDsl2CRyHFphOgkAB5KVGG/r6yP1/zvK7wfxrPMQIf2XKDIPRxIafF2sUC+aLCQcV2fAcTjbbCJq4PEj3PxzRCIIa1dxo0d3+dWLHluv2j38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwrW/0vT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F113EC4CEE2;
	Wed,  9 Apr 2025 23:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242166;
	bh=fd1XZ9DP1i3ZKcXtK0GbmtugiXsp8ZiAgCYkG7jHH9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwrW/0vThFdH8cQt3xkJrxYBSSoFr2CtuQp81ownypvIWYVJ+6sul70yWxSfIJMGe
	 tt2B6XX/fVNOud+WJYMqbvH26mIer3wSK/OSnnBRO5VLtwZvAElLJ6JqSvxFHYgfYK
	 iCjymgaz9arlRCl8DRToLDUT1hPrHXdOSFF+Umn4Em8qNBbos7/qgoIEkGLt+QcD06
	 yQfBV9JwYDsjMAhil2lw3qrMMK6dHJ48I1PQdbz/IC+kbFTOWI51gbRbkLE2TOnE75
	 puw83yB5cCF5L2GnKJtt1SDFE2RnMaQjEDYSNiWWQIn34G6tby0n/jzR6ZrAZ15aTp
	 lSSWWAa2y1bKw==
Date: Wed, 9 Apr 2025 16:42:43 -0700
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
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
Message-ID: <202504091641.738FECED@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-51-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-51-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:05PM -0400, Paul Moore wrote:
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/smack/smack.h           |  6 ++++++
>  security/smack/smack_lsm.c       | 16 ++++++++++++++++
>  security/smack/smack_netfilter.c |  4 +---
>  security/smack/smackfs.c         |  4 +---
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..709e0d6cd5e1 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,12 @@ struct smk_audit_info {
>  #endif
>  };
>  
> +/*
> + * Initialization
> + */
> +int init_smk_fs(void);
> +int smack_nf_ip_init(void);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09b33fed5f0..80b129a0c92c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
>  	return 0;
>  }
>  
> +static int smack_initcall(void)
> +{
> +	int rc, rc_tmp;
> +
> +	rc_tmp = init_smk_fs();
> +	if (rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = smack_nf_ip_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	return rc;
> +}

This retains the existing behavior, but I think it'd be better to
evaluate if the init_smk_fs() call can be tied to the fs init hook
instead, yes? Then no new helper is needed, etc.

-Kees

> +
>  /*
>   * Smack requires early initialization in order to label
>   * all processes and objects when they are created.
> @@ -5286,4 +5301,5 @@ DEFINE_LSM(smack) = {
>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.blobs = &smack_blob_sizes,
>  	.init = smack_init,
> +	.initcall_device = smack_initcall,
>  };
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index 8fd747b3653a..17ba578b1308 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
>  	.exit = smack_nf_unregister,
>  };
>  
> -static int __init smack_nf_ip_init(void)
> +int __init smack_nf_ip_init(void)
>  {
>  	if (smack_enabled == 0)
>  		return 0;
> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>  	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>  	return register_pernet_subsys(&smack_net_ops);
>  }
> -
> -__initcall(smack_nf_ip_init);
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 90a67e410808..d33dd0368807 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2980,7 +2980,7 @@ static struct vfsmount *smackfs_mount;
>   * Returns true if we were not chosen on boot or if
>   * we were chosen and filesystem registration succeeded.
>   */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>  {
>  	int err;
>  	int rc;
> @@ -3023,5 +3023,3 @@ static int __init init_smk_fs(void)
>  
>  	return err;
>  }
> -
> -__initcall(init_smk_fs);
> -- 
> 2.49.0
> 

-- 
Kees Cook

