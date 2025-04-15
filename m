Return-Path: <linux-integrity+bounces-5892-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54BA8AAEE
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 00:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D6F190295C
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69E256C77;
	Tue, 15 Apr 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Y1k6NFoU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20362741DC;
	Tue, 15 Apr 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755017; cv=none; b=dOSHnbdT200M1IMaq1XPb7/WTGWc3IgqEbT5ikibmZhmhk33G7TKMK07qQmqMKhe2tU24rgPcoF8s30O9pmkas35VmFvT9L4W9qC/2NKuqLyvMsH+jA1qAaHpN3dJKYW7vfyZTWkmRutYv6tyMZSUCR0nxgP2UE7GzO7pjvO1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755017; c=relaxed/simple;
	bh=yGwv+j0AP3j1mVbjqCa9z1HqH7jViFBSIV6B+v43esA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8KTJdRzRYC1pmeOmZgDcXp7UL3Az6An3GWe7FGkKkpSQqwrPR34tiDOJH1qwWRlsSTOGvfpdv34NdrC/vR3mrEQlUe9EkUrvlK98iKtnec464phuEvD94G1UGMq8Sdq8dtYdKWBvKgrx9vJY1t3qbEEYk+jYTB9s58ZypRJsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Y1k6NFoU; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 38C464005F;
	Tue, 15 Apr 2025 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744755010;
	bh=vSOFeKHk9s4fHqWNQksgWfZ88+x+a/ZncPwYJCic3Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Y1k6NFoUYSSjXwf1Pn2OJZh4E6Em56tAdX47FLRX5W2mu15x+42F7cLxd5OQvlwO+
	 IHXXGuqeRyopmDElTZHFFGG4HvCAx/rWh2qxVpHdlgmcFNh5AyLpy5regjegS4b6be
	 44JOK9u1YPnGFKscpk/73qpTPO8TWiMi5vFyMSkSfXRzE+RVnjcFiJMjyWZ5hHCdIz
	 x2D7n0WIPJt9RS37G6Jf7QU2nIQJFbugb4av4nyYNlFDDiR//lQeGuL5dXLO1NLmnP
	 ZZNbcwfciwpcpMjguww0/iHuNQrLkkqIRFZ6f0HDqVPAkpYM7kgZw0RzmCSNzyUi6P
	 L0dD1cPtLQUzg==
Message-ID: <21cc3a80-e80f-4960-a562-f431bd9610cf@canonical.com>
Date: Tue, 15 Apr 2025 15:10:06 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/29] lsm: simplify prepare_lsm() and rename to
 lsm_prep_single()
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
 <20250409185019.238841-34-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-34-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:49, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.
> 

I like kees's suggestion of using enums and arrays but I think that
should be done as a separate patch. It doesn't even need to be part
of the series. Keeping the logic changes small here makes it easier
to check what the patch is doing. Then another small step ...

> Signed-off-by: Paul Moore <paul@paul-moore.com>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 103 ++++++++++++++++++--------------------------
>   1 file changed, 43 insertions(+), 60 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 70e7d4207dae..dffa8dc2da36 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   		   is_enabled(lsm) ? "enabled" : "disabled");
>   }
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
>   static void __init lsm_set_blob_size(int *need, int *lbs)
>   {
>   	int offset;
> @@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>   	*need = offset;
>   }
>   
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +/**
> + * lsm_prep_single - Prepare the LSM framework for a new LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_prep_single(struct lsm_info *lsm)
>   {
> -	if (!needed)
> +	struct lsm_blob_sizes *blobs;
> +
> +	if (!is_enabled(lsm)) {
> +		set_enabled(lsm, false);
> +		return;
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		set_enabled(lsm, false);
>   		return;
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
>   	}
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
>   }
>   
>   /* Initialize a given LSM, if it is enabled. */
> @@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
>   		ordered_lsm_parse(builtin_lsm_order, "builtin");
>   
>   	for (lsm = ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> +		lsm_prep_single(*lsm);
>   
>   	report_lsm_order();
>   
> @@ -499,7 +482,7 @@ int __init early_security_init(void)
>   	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
>   		if (!lsm->enabled)
>   			lsm->enabled = &lsm_enabled_true;
> -		prepare_lsm(lsm);
> +		lsm_prep_single(lsm);
>   		initialize_lsm(lsm);
>   	}
>   


