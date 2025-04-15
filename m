Return-Path: <linux-integrity+bounces-5899-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3355A8ABBA
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 01:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2F1902783
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66127E1D5;
	Tue, 15 Apr 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JUyp+cdD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CC226CF6;
	Tue, 15 Apr 2025 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758186; cv=none; b=DfjSjJ/i0o2neufgz4uWY2KncNLPfRBdygTaBexx3A4sSktqSXTuTguD5c2UxdiPUP1FwfA0/bhb7SzLZ4fPRmI9JvFvez/nEFSfA72NG2Wo1run8DIEspraKC6CH7zD2KtLoVOLE5ev80PgRRfh/JpTM30CgpwyYVNIsk7pTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758186; c=relaxed/simple;
	bh=qRqEMRS1Xc5oGgsA7fIpZ88w2dIIdw95fR0JJfgMZ2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaU0tmbaMKiBEYDYPwrC61p4FyALDHHriqgq7H0ShLvgCf2mEddg2XBMKCH1GDgCjSYzxcdhpi8H/qh8IPmKJGTl43LuJqnPOXzPOglanG2TbMrZArpCXLuXQNKHUwQZOxOXyu8rAAD/yzC3dHHZLzEDiRLYFQy93YsP7XL5148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JUyp+cdD; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 342833F1E0;
	Tue, 15 Apr 2025 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744758179;
	bh=tHVFJlZirvSP8jcYvgXm9cY4OU+leDwBsAXROWsIbXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JUyp+cdDvuf9iJqPQgygBlFaYXLEQIJFx84rctJtqsLM3SZsjAf6UnhrkMuUGxuqE
	 dVBwRx+ykR7thCCDI0kXDOhFYHS7YWQZXf4AwPKRMc4CEeK6M30x0E+ye03cszuC5I
	 Vf3hCOUz/ucjKWQVXcJ3n5fXvweSQ0E0M2TB8wQJCj21sY9I+BZRtusKEFiwWTkYNX
	 JfQ3/OBfokP5qAGpresg202MPWHdb98fodDtU0W4D0FRA5OKirIMOEPizARXG/2BRY
	 z623shtpk50VLZBlCr4G82qdM6ITUT4/bzh2sBb9RDz0EeCqIOxRvxObnHo2yYylnU
	 hoBqI6Ny2SKKQ==
Message-ID: <b2bb1bdb-c698-462b-95aa-f1bbb4b73ad4@canonical.com>
Date: Tue, 15 Apr 2025 16:02:54 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
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
 <20250409185019.238841-41-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-41-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:49, Paul Moore wrote:
> Convert the lsm_blob_size fields to unsigned integers as there is no
> current need for them to be negative, change "lsm_set_blob_size()" to
> "lsm_blob_size_update()" to better reflect reality, and perform some
> other minor cleanups to the associated code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hooks.h | 28 +++++++++++-----------
>   security/lsm_init.c       | 50 +++++++++++++++++++++++----------------
>   2 files changed, 43 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index bc477fb20d02..a7ecb0791a0f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -102,20 +102,20 @@ struct security_hook_list {
>    * Security blob size or offset data.
>    */
>   struct lsm_blob_sizes {
> -	int lbs_cred;
> -	int lbs_file;
> -	int lbs_ib;
> -	int lbs_inode;
> -	int lbs_sock;
> -	int lbs_superblock;
> -	int lbs_ipc;
> -	int lbs_key;
> -	int lbs_msg_msg;
> -	int lbs_perf_event;
> -	int lbs_task;
> -	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> -	int lbs_tun_dev;
> -	int lbs_bdev;
> +	unsigned int lbs_cred;
> +	unsigned int lbs_file;
> +	unsigned int lbs_ib;
> +	unsigned int lbs_inode;
> +	unsigned int lbs_sock;
> +	unsigned int lbs_superblock;
> +	unsigned int lbs_ipc;
> +	unsigned int lbs_key;
> +	unsigned int lbs_msg_msg;
> +	unsigned int lbs_perf_event;
> +	unsigned int lbs_task;
> +	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> +	unsigned int lbs_tun_dev;
> +	unsigned int lbs_bdev;
>   };
>   
>   /*
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7f2bc8c22ce9..9bb4b4fc9888 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -148,16 +148,22 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
> -static void __init lsm_set_blob_size(int *need, int *lbs)
> +/**
> + * lsm_blob_size_update - Update the LSM blob size and offset information
> + * @sz_req: the requested additional blob size
> + * @sz_cur: the existing blob size
> + */
> +static void __init lsm_blob_size_update(unsigned int *sz_req,
> +					unsigned int *sz_cur)
>   {
> -	int offset;
> +	unsigned int offset;
>   
> -	if (*need <= 0)
> +	if (*sz_req == 0)
>   		return;
>   
> -	offset = ALIGN(*lbs, sizeof(void *));
> -	*lbs = offset + *need;
> -	*need = offset;
> +	offset = ALIGN(*sz_cur, sizeof(void *));
> +	*sz_cur = offset + *sz_req;
> +	*sz_req = offset;
>   }
>   
>   /**
> @@ -186,24 +192,26 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>   
>   	/* Register the LSM blob sizes. */
>   	blobs = lsm->blobs;
> -	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> +	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> +	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
>   	/* inode blob gets an rcu_head in addition to LSM blobs. */
>   	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
>   		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&blobs->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> +	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> +	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_blob_size_update(&blobs->lbs_perf_event,
> +			     &blob_sizes.lbs_perf_event);
> +	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_blob_size_update(&blobs->lbs_superblock,
> +			     &blob_sizes.lbs_superblock);
> +	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> +	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_blob_size_update(&blobs->lbs_xattr_count,
> +			     &blob_sizes.lbs_xattr_count);
> +	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
>   }
>   
>   /* Initialize a given LSM, if it is enabled. */


