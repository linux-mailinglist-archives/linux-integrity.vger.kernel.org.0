Return-Path: <linux-integrity+bounces-5730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF1A83363
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360E8441866
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2C2135A1;
	Wed,  9 Apr 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqSohweB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A519ADA4;
	Wed,  9 Apr 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234247; cv=none; b=K7ZjaDBcaB4uxHnOlCwtsMwcq5sLGJ+ra/utcMR5Css645jEizse1JMFGvDJ8V8FKFKuoe4mArv3Mu4K3teduw5/DeAnDV89aXBFL+NbVwC42qU2vZB8eCUXa5svw7bcl222e1OEEuneY2XuePB1+AXEh4RBvegyod+VkJoNU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234247; c=relaxed/simple;
	bh=22WQEyzjUWzY/g7d1KuZg8YwBs01n8kEsile7XAvSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAwVk+//OqiuWObO+bHsuHq16jKDbiN7d8Od/kEt6Irp7U72bbTQ7oH5W3Z5IL/oGghwX2tp6hlqQXFmXkof3GE+h99IljTkUq58Do6QJ37f8hg5OEIyn9bMNHlDrQK7TaX+RMw3xJURU7X0zPDutZiBhudcOjEtFOFxIqHClas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqSohweB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AA3C4CEE2;
	Wed,  9 Apr 2025 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744234247;
	bh=22WQEyzjUWzY/g7d1KuZg8YwBs01n8kEsile7XAvSPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqSohweBYX/dMiJT+jH18DgdaN4Yu2qxatQIMJl+iWQcgC0VWdxQwHst/L1+vu8GZ
	 bp1594SpWmG9h+4ZLkZW6CdWA/gTgFlOiASHA4E+E7O0jRUryRfIuqOmnahjEJVAMa
	 yxaNNIRi++Uc4yh0QLHJWJTHQopcqTdngRZ8Lsoo7wbwRyK2EoaONClXxZFk+d7swc
	 sbRqNGox6IEWyhRBGy6YbjtZcMV4MA3zrRwVPlXo/dXR36gHIvRWHEEyJtIJ5M4kLd
	 9h45CnhErMiGTiVmfva2FF04yuBrCUHL5qfTGr/B7qVpUmyhu8bOR2YBpCEWjFzel7
	 Ipw5+Z0VcGA/A==
Date: Wed, 9 Apr 2025 14:30:44 -0700
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
Subject: Re: [RFC PATCH 03/29] lsm: simplify prepare_lsm() and rename to
 lsm_prep_single()
Message-ID: <202504091422.13DA5BED@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-34-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-34-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:48PM -0400, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.

This commit log needs improvement. i.e. explain what and why:

The execution flow through lsm_allowed(), prepare_lsm(), and
lsm_set_blob_sizes() is a bit convoluted. Merge the logic of all three
into a single new function, lsm_prep_single().

> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/lsm_init.c | 103 ++++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 60 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 70e7d4207dae..dffa8dc2da36 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
> -/* Is an LSM allowed to be initialized? */
> -static bool __init lsm_allowed(struct lsm_info *lsm)
> -{
> -	/* Skip if the LSM is disabled. */
> -	if (!is_enabled(lsm))
> -		return false;
> -
> -	/* Not allowed if another exclusive LSM already initialized. */
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static void __init lsm_set_blob_size(int *need, int *lbs)
>  {
>  	int offset;
> @@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>  	*need = offset;
>  }
>  
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +/**
> + * lsm_prep_single - Prepare the LSM framework for a new LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_prep_single(struct lsm_info *lsm)

Nit-pick on naming: why shorten "prepare"?

>  {
> -	if (!needed)
> +	struct lsm_blob_sizes *blobs;
> +
> +	if (!is_enabled(lsm)) {
> +		set_enabled(lsm, false);
> +		return;
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		set_enabled(lsm, false);
>  		return;
> -
> -	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> -	/*
> -	 * The inode blob gets an rcu_head in addition to
> -	 * what the modules might need.
> -	 */
> -	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> -		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&needed->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> -}
> -
> -/* Prepare LSM for initialization. */
> -static void __init prepare_lsm(struct lsm_info *lsm)
> -{
> -	int enabled = lsm_allowed(lsm);
> -
> -	/* Record enablement (to handle any following exclusive LSMs). */
> -	set_enabled(lsm, enabled);
> -
> -	/* If enabled, do pre-initialization work. */
> -	if (enabled) {
> -		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -			exclusive = lsm;
> -			init_debug("exclusive chosen:   %s\n", lsm->name);
> -		}
> -
> -		lsm_set_blob_sizes(lsm->blobs);
>  	}
> +
> +	/* Mark the LSM as enabled. */
> +	set_enabled(lsm, true);
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		exclusive = lsm;
> +	}
> +
> +	/* Register the LSM blob sizes. */
> +	blobs = lsm->blobs;
> +	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> +	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
> +	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
> +	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
> +	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_set_blob_size(&blobs->lbs_xattr_count,
> +			  &blob_sizes.lbs_xattr_count);
> +	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);

Another refactoring idea I saw recently from the sysctl subsystem was
turning these named "same things" into an array with enum names, so
instead of &blobs->lbs_ipc, &blobs->lbs_key, they can still have useful
names but also be iterated in a loop:

enum lsm_blob_types {
	LSM_BLOB_IPC,
	LSM_BLOB_KEY,
	...
	LSM_BLOB_MAX
};
...
	for (i = 0; i < ARRAY_SIZE(blobs->lbs); i++) {
		lsm_set_blob_size(&blobs->lbs[i], &blob_sizes[i]);

>  }
>  
>  /* Initialize a given LSM, if it is enabled. */
> @@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
>  	for (lsm = ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> +		lsm_prep_single(*lsm);
>  
>  	report_lsm_order();
>  
> @@ -499,7 +482,7 @@ int __init early_security_init(void)
>  	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
> -		prepare_lsm(lsm);
> +		lsm_prep_single(lsm);
>  		initialize_lsm(lsm);
>  	}

Regardless, this looks correct to me. With or without renaming the
function:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

