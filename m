Return-Path: <linux-integrity+bounces-5896-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F20A8AB39
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A417CA68
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FEE27511E;
	Tue, 15 Apr 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Rq65eT/n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976F18D65E;
	Tue, 15 Apr 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755629; cv=none; b=jSvXyuc0Xs4zDZ5vD8Wd1EVLf2RfnOfe8mrcYzolZvpXy7oV3zQMll6zc9AattKd40uuIhoGrIws4SZmovsmcAlN3/pbLDkdyVdKsJsqMaeyZW2BhKg0fnZZEp2Ps+1atgLvYQ212lMyf0PgR8Mye7fduSmjP7Zm99EN+hsYLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755629; c=relaxed/simple;
	bh=AzahQwlSCH6s1vCo1CR3wFKc44D3IhLgNuB0CmzvXGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQv2LHlAZjiLLvWiGL3FZ/XrgH2i2Ga0ENF8aHxTVONOq4uNfXr2Ix+2m3MXiERALHWxuDFVZ2gmUHMMwZc7ozHxF7MLRWCu8w7UlteaIpfcsk7T4L8bXrgS1i7UpRBEl8eQunM82C/Z9Fq5LX82stUbIWZNLE0R4T1wUfu9THk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rq65eT/n; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 634753F779;
	Tue, 15 Apr 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744755624;
	bh=6U1USbtGfcBikKztHoLjjrarLGNGDJI2WnIN47llRKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Rq65eT/n0G1FuDguu+7hGIT871z5fdqRLh26yXrmvtH/OrBhTxgHPiMEFCsJ1TFOm
	 MJ3KdG5Kv06uPNSiBeSf3dwBd2QEa18vgZ8+J7yJ9wS6OpRv9YlKaV4ykaX1WHkT4B
	 mjzjymmR90LnfoXPOoYcF8hzdaA7fvpaXSv7kD+yJYmzXqqn3MCndpHBYaN+DxCgR0
	 EY3D4xBcXGkviu5avS5AHEO3OBiufw6rfTZGD6nFY4ZlgR5U17PhRIE/NUArzjOLT8
	 XCA+onpvFCCTFs+fI9zY8EyFnK8jDnl8aF6wLP6Lmkv4m5J67EO4gpwWfu8iuvT6y3
	 U5CLWZ/rPeGGA==
Message-ID: <3d5ba3b4-2931-4544-9861-947bd378c1ae@canonical.com>
Date: Tue, 15 Apr 2025 15:20:19 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/29] lsm: replace the name field with a pointer to
 the lsm_id struct
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
 <20250409185019.238841-36-paul@paul-moore.com>
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
In-Reply-To: <20250409185019.238841-36-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:49, Paul Moore wrote:
> Reduce the duplication between the lsm_id struct and the DEFINE_LSM()
> definition by linking the lsm_id struct directly into the individual
> LSM's DEFINE_LSM() instance.
> 
> Linking the lsm_id into the LSM definition also allows us to simplify
> the security_add_hooks() function by removing the code which populates
> the lsm_idlist[] array and moving it into the normal LSM startup code
> where the LSM list is parsed and the individual LSMs are enabled,
> making for a cleaner implementation with less overhead at boot.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hooks.h         |  2 +-
>   security/apparmor/lsm.c           |  2 +-
>   security/bpf/hooks.c              |  2 +-
>   security/commoncap.c              |  2 +-
>   security/integrity/evm/evm_main.c |  2 +-
>   security/integrity/ima/ima_main.c |  2 +-
>   security/ipe/ipe.c                |  2 +-
>   security/landlock/setup.c         |  2 +-
>   security/loadpin/loadpin.c        |  2 +-
>   security/lockdown/lockdown.c      |  2 +-
>   security/lsm_init.c               | 43 ++++++++++++-------------------
>   security/safesetid/lsm.c          |  2 +-
>   security/selinux/hooks.c          |  2 +-
>   security/smack/smack_lsm.c        |  2 +-
>   security/tomoyo/tomoyo.c          |  2 +-
>   security/yama/yama_lsm.c          |  2 +-
>   16 files changed, 31 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index eeb4bfd60b79..4cd17c9a229f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -149,7 +149,7 @@ enum lsm_order {
>   };
>   
>   struct lsm_info {
> -	const char *name;	/* Required. */
> +	const struct lsm_id *id;
>   	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
>   	unsigned long flags;	/* Optional: flags describing LSM */
>   	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9b6c2f157f83..a7f6a3274682 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2272,7 +2272,7 @@ static int __init apparmor_init(void)
>   }
>   
>   DEFINE_LSM(apparmor) = {
> -	.name = "apparmor",
> +	.id = &apparmor_lsmid,
>   	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   	.enabled = &apparmor_enabled,
>   	.blobs = &apparmor_blob_sizes,
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index db759025abe1..40efde233f3a 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -33,7 +33,7 @@ struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
>   };
>   
>   DEFINE_LSM(bpf) = {
> -	.name = "bpf",
> +	.id = &bpf_lsmid,
>   	.init = bpf_lsm_init,
>   	.blobs = &bpf_lsm_blob_sizes
>   };
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 28d4248bf001..e04aa4f50eaf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1509,7 +1509,7 @@ static int __init capability_init(void)
>   }
>   
>   DEFINE_LSM(capability) = {
> -	.name = "capability",
> +	.id = &capability_lsmid,
>   	.order = LSM_ORDER_FIRST,
>   	.init = capability_init,
>   };
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 0add782e73ba..db8e324ed4e6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1175,7 +1175,7 @@ struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
>   };
>   
>   DEFINE_LSM(evm) = {
> -	.name = "evm",
> +	.id = &evm_lsmid,
>   	.init = init_evm_lsm,
>   	.order = LSM_ORDER_LAST,
>   	.blobs = &evm_blob_sizes,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f3e7ac513db3..55a4f08a2565 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1251,7 +1251,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
>   };
>   
>   DEFINE_LSM(ima) = {
> -	.name = "ima",
> +	.id = &ima_lsmid,
>   	.init = init_ima_lsm,
>   	.order = LSM_ORDER_LAST,
>   	.blobs = &ima_blob_sizes,
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 4317134cb0da..2426441181dc 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -92,7 +92,7 @@ static int __init ipe_init(void)
>   }
>   
>   DEFINE_LSM(ipe) = {
> -	.name = "ipe",
> +	.id = &ipe_lsmid,
>   	.init = ipe_init,
>   	.blobs = &ipe_blobs,
>   };
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index bd53c7a56ab9..47dac1736f10 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -75,7 +75,7 @@ static int __init landlock_init(void)
>   }
>   
>   DEFINE_LSM(LANDLOCK_NAME) = {
> -	.name = LANDLOCK_NAME,
> +	.id = &landlock_lsmid,
>   	.init = landlock_init,
>   	.blobs = &landlock_blob_sizes,
>   };
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 68252452b66c..b9ddf05c5c16 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -271,7 +271,7 @@ static int __init loadpin_init(void)
>   }
>   
>   DEFINE_LSM(loadpin) = {
> -	.name = "loadpin",
> +	.id = &loadpin_lsmid,
>   	.init = loadpin_init,
>   };
>   
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..4813f168ff93 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -168,6 +168,6 @@ DEFINE_EARLY_LSM(lockdown) = {
>   #else
>   DEFINE_LSM(lockdown) = {
>   #endif
> -	.name = "lockdown",
> +	.id = &lockdown_lsmid,
>   	.init = lockdown_lsm_init,
>   };
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 407429688f1b..d458a365b0d5 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -124,9 +124,10 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   	/* Enable this LSM, if it is not already set. */
>   	if (!lsm->enabled)
>   		lsm->enabled = &lsm_enabled_true;
> -	ordered_lsms[last_lsm++] = lsm;
> +	ordered_lsms[last_lsm] = lsm;
> +	lsm_idlist[last_lsm++] = lsm->id;
>   
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
>   		   is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
> @@ -154,7 +155,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>   		set_enabled(lsm, false);
>   		return;
>   	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> +		init_debug("exclusive disabled: %s\n", lsm->id->name);
>   		set_enabled(lsm, false);
>   		return;
>   	}
> @@ -162,7 +163,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
>   	/* Mark the LSM as enabled. */
>   	set_enabled(lsm, true);
>   	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>   		exclusive = lsm;
>   	}
>   
> @@ -194,9 +195,9 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>   	if (is_enabled(lsm)) {
>   		int ret;
>   
> -		init_debug("initializing %s\n", lsm->name);
> +		init_debug("initializing %s\n", lsm->id->name);
>   		ret = lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>   	}
>   }
>   
> @@ -231,10 +232,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		for (major = __start_lsm_info; major < __end_lsm_info;
>   		     major++) {
>   			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->name, chosen_major_lsm) != 0) {
> +			    strcmp(major->id->name, chosen_major_lsm) != 0) {
>   				set_enabled(major, false);
>   				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   chosen_major_lsm, major->name);
> +					   chosen_major_lsm, major->id->name);
>   			}
>   		}
>   	}
> @@ -246,7 +247,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		bool found = false;
>   
>   		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (strcmp(lsm->name, name) == 0) {
> +			if (strcmp(lsm->id->name, name) == 0) {
>   				if (lsm->order == LSM_ORDER_MUTABLE)
>   					append_ordered_lsm(lsm, origin);
>   				found = true;
> @@ -263,7 +264,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>   			if (exists_ordered_lsm(lsm))
>   				continue;
> -			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> +			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
>   				append_ordered_lsm(lsm, "security=");
>   		}
>   	}
> @@ -280,7 +281,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   			continue;
>   		set_enabled(lsm, false);
>   		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->name);
> +			   origin, lsm->id->name);
>   	}
>   
>   	kfree(sep);
> @@ -313,12 +314,12 @@ static void __init lsm_init_ordered(void)
>   		if (is_enabled(early))
>   			pr_cont("%s%s",
>   				early == __start_early_lsm_info ? "" : ",",
> -				early->name);
> +				early->id->name);
>   	}
>   	lsm_order_for_each(lsm) {
>   		if (is_enabled(*lsm))
>   			pr_cont("%s%s",
> -				lsm == ordered_lsms ? "" : ",", (*lsm)->name);
> +				lsm == ordered_lsms ? "" : ",", (*lsm)->id->name);
>   	}
>   	pr_cont("\n");
>   
> @@ -426,18 +427,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   {
>   	int i;
>   
> -	/*
> -	 * A security module may call security_add_hooks() more
> -	 * than once during initialization, and LSM initialization
> -	 * is serialized. Landlock is one such case.
> -	 * Look at the previous entry, if there is one, for duplication.
> -	 */
> -	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
> -		if (lsm_active_cnt >= MAX_LSM_COUNT)
> -			panic("%s Too many LSMs registered.\n", __func__);
> -		lsm_idlist[lsm_active_cnt++] = lsmid;
> -	}
> -
>   	for (i = 0; i < count; i++) {
>   		hooks[i].lsmid = lsmid;
>   		lsm_static_call_init(&hooks[i]);
> @@ -485,10 +474,10 @@ int __init security_init(void)
>   	 * available
>   	 */
>   	lsm_early_for_each_raw(lsm) {
> -		init_debug("  early started: %s (%s)\n", lsm->name,
> +		init_debug("  early started: %s (%s)\n", lsm->id->name,
>   			   is_enabled(lsm) ? "enabled" : "disabled");
>   		if (lsm->enabled)
> -			lsm_append(lsm->name, &lsm_names);
> +			lsm_append(lsm->id->name, &lsm_names);
>   	}
>   
>   	/* Load LSMs in specified order. */
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 1ba564f097f5..9a7c68d4e642 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -287,6 +287,6 @@ static int __init safesetid_security_init(void)
>   }
>   
>   DEFINE_LSM(safesetid_security_init) = {
> +	.id = &safesetid_lsmid,
>   	.init = safesetid_security_init,
> -	.name = "safesetid",
>   };
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..f28a12a0a1c8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7562,7 +7562,7 @@ void selinux_complete_init(void)
>   /* SELinux requires early initialization in order to label
>      all processes and objects when they are created. */
>   DEFINE_LSM(selinux) = {
> -	.name = "selinux",
> +	.id = &selinux_lsmid,
>   	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   	.enabled = &selinux_enabled_boot,
>   	.blobs = &selinux_blob_sizes,
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99833168604e..e09b33fed5f0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5282,7 +5282,7 @@ static __init int smack_init(void)
>    * all processes and objects when they are created.
>    */
>   DEFINE_LSM(smack) = {
> -	.name = "smack",
> +	.id = &smack_lsmid,
>   	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   	.blobs = &smack_blob_sizes,
>   	.init = smack_init,
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index d6ebcd9db80a..ed0f7b052a85 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -612,7 +612,7 @@ static int __init tomoyo_init(void)
>   }
>   
>   DEFINE_LSM(tomoyo) = {
> -	.name = "tomoyo",
> +	.id = &tomoyo_lsmid,
>   	.enabled = &tomoyo_enabled,
>   	.flags = LSM_FLAG_LEGACY_MAJOR,
>   	.blobs = &tomoyo_blob_sizes,
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 3d064dd4e03f..38b21ee0c560 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -476,6 +476,6 @@ static int __init yama_init(void)
>   }
>   
>   DEFINE_LSM(yama) = {
> -	.name = "yama",
> +	.id = &yama_lsmid,
>   	.init = yama_init,
>   };


