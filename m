Return-Path: <linux-integrity+bounces-6984-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF92B40C60
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0045C48728E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1A31CA69;
	Tue,  2 Sep 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oVvdJHzH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F3286D69
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835179; cv=none; b=l0u1rvx7uvqcqO5boPgTy7KdqRVFUREsRcLOO7XoAhEWkK55kbUWDLdZu6lahEPih9Hs4SyuDFwgAxDHv9sSMaQiTkOrPwnwRdk077gLr/KHbgXcXwtDRsI7yWFmehGb9Sl65KH0pVNbbsKZ24GqKqYyB8bcmE70TWR2QzRBOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835179; c=relaxed/simple;
	bh=zi4BgGIfTPkFUP7Fj1QB76fodBeojjY2YiBgvgoME9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0QrGMThmMbeQtudyv0yb62cZ/bYiSPJk7ViDyUpociT/0yA4HTyaZ/n0W8pjEupwwKc3tzR4VjJBobEYMTvYm09eR0khwfyo764LnYmGTzMOTPUUIk/Hkdr7MN8p9Ff/J0Di0HQx/qVVvzvpW3Q9JBQFjAMWitkfBOPCCruXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oVvdJHzH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F5243F284
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835175;
	bh=aq0IYKta8jtQb5eLXBbqhKQ5ZCe1AOVpkLAUjDUFfgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=oVvdJHzH6D8sa9XzL3n00KGKR1Ss16ncOUTUCoYVGzPOFCEI7GsHe9q2fpPw/9+sE
	 IV6ABF/0sLKJ7yiC2oK9mS2bwj3mo/e/BXZ61mJ8WdiEwNmlwAWtckQInSKGPMA+yg
	 KV4fSMdc4TDrIb+sOn1j1tOlgPe9nB0NgRg/0gYeDaCRT4G/NFA1xXb6iM8mrW6gTa
	 oEfPnLJhDiS+ok9X71C1XiKuisyfJ3ZPqYGQTvjn0VstnjafVThMY6kTG/7Pke92Px
	 Ond2c5nY+BAade9tBoLNp9O/HcklzFp/FoPHnCDrOuGf9xri0VSxY2p8TYdIQsiRFl
	 uPio021dU8wNg==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724688833bso3125842b3a.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 10:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835173; x=1757439973;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq0IYKta8jtQb5eLXBbqhKQ5ZCe1AOVpkLAUjDUFfgg=;
        b=Nd+fY9GCCbj6182nsYuNFTi0NbNMEhizZdDdl7j7Wqu+1MYLqAZJBe/69bi4GUbqQq
         DOZU3ovaW892qZ59bcJoS5MihlKYAa+mqHSZ0OYvYiYAv8IVkAQhlA3cfBBl+VRiR3cv
         /UglXCNP44OL43PThEtKEtd2rnoee0T0Yf8CdRvUv9R0ZFt2vNOVYn8Yh4D3d1itj4QC
         yn1vacr0PO+ELD9Ajvpa9/S4tmRXb7nmGwSsFyO0jzXjoGi2yoFmkq4u/R+w/jLex9Oj
         EPJevY9CgxOieF7h+N8tJgIX2FXb8ry85yt3HnzH/IiVTyL0sO9e7k+R10jMxTv0rVKi
         8XDA==
X-Forwarded-Encrypted: i=1; AJvYcCUovET8RyIF9SqJiQcJwGGRlfWuSl0ueUOtj4ob9M8IwEyQktZ0qL9uocccSd4a/+2+iNDfvjI4uys+W3ALYTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpPHKpqlMtRylhLKUQkyVscpgSkJU61xhE0EQ4B3wRJZOYdl/
	DJjFj4nqhLfkJAcYTErIp8Qk7xoO+ZMuM4TwUOwRR7nGg9OKx9VTBprTMmsw1VzPMeH5BVc8nEw
	ALlYHO7E7wBpjmqMyOI6k78Bk5mhHXj11VD/kTYseUDtbJ7M3IMif0/qds9XnDDgpPMh23RYauh
	E4JDYz46LqoA==
X-Gm-Gg: ASbGnctJVe7dP4dKa28trGanuQgOwLPa/gaoTnB3DBXJnDQi5CamlYoKoYYAS+0c48Y
	HSAxMCSCOAFv+lCxwbNMG9MMZulGNZ0c+ELNkDJUwQf9w/cQrbW9qXzv3vcqfBb6lphrdbiXfHw
	YuOq4/dc3Tf05Dh6qLEG2OeauLyXq6RI9HR/7tLMbXDyWTSsAZVNTNRoSDXuD8wO5Iuzf70pccN
	brk3d7czqLpvcJ5W9SyYZzZkgmLg3vie2cYFpCAS6oHzFj1eMQ38CDWbK35n3GUiAy8lKGuN358
	JJ6Fs3i9X7nB0icCSMBwOFOVL1GlA6pRqXnN6lUF87tZmobk0MamNw==
X-Received: by 2002:a05:6a00:bd84:b0:76b:eedc:8e05 with SMTP id d2e1a72fcca58-7723e262bedmr14087045b3a.11.1756835173378;
        Tue, 02 Sep 2025 10:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYu/9tGpEXzpiCabBMBN29KMm6HkiCJecu8MIooPDY3d2vebNTwPJtu9nSGL6rL5yyFUe07A==
X-Received: by 2002:a05:6a00:bd84:b0:76b:eedc:8e05 with SMTP id d2e1a72fcca58-7723e262bedmr14087015b3a.11.1756835172942;
        Tue, 02 Sep 2025 10:46:12 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a4bd1ccsm13975405b3a.47.2025.09.02.10.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:46:12 -0700 (PDT)
Message-ID: <45a15a0e-7d4d-478d-8b3a-d0d9b9aec265@canonical.com>
Date: Tue, 2 Sep 2025 10:46:11 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/34] lsm: group lsm_order_parse() with the other
 lsm_order_*() functions
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-58-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-58-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Move the lsm_order_parse() function near the other lsm_order_*()
> functions to improve readability.
> 
> No code changes.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
>   1 file changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index c6aea57a01e6..363aac92a8da 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -169,6 +169,76 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
>   }
>   
> +/**
> + * lsm_order_parse - Parse the comma delimited LSM list
> + * @list: LSM list
> + * @src: source of the list
> + */
> +static void __init lsm_order_parse(const char *list, const char *src)
> +{
> +	struct lsm_info *lsm;
> +	char *sep, *name, *next;
> +
> +	/* Handle any Legacy LSM exclusions if one was specified. */
> +	if (lsm_order_legacy) {
> +		/*
> +		 * To match the original "security=" behavior, this explicitly
> +		 * does NOT fallback to another Legacy Major if the selected
> +		 * one was separately disabled: disable all non-matching
> +		 * Legacy Major LSMs.
> +		 */
> +		lsm_for_each_raw(lsm) {
> +			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			     strcmp(lsm->id->name, lsm_order_legacy)) {
> +				lsm_enabled_set(lsm, false);
> +				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
> +					   src, lsm->id->name);
> +			}
> +		}
> +	}
> +
> +	/* LSM_ORDER_FIRST */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm->order == LSM_ORDER_FIRST)
> +			lsm_order_append(lsm, "first");
> +	}
> +
> +	/* Normal or "mutable" LSMs */
> +	sep = kstrdup(list, GFP_KERNEL);
> +	next = sep;
> +	/* Walk the list, looking for matching LSMs. */
> +	while ((name = strsep(&next, ",")) != NULL) {
> +		lsm_for_each_raw(lsm) {
> +			if (!strcmp(lsm->id->name, name) &&
> +			    lsm->order == LSM_ORDER_MUTABLE)
> +				lsm_order_append(lsm, src);
> +		}
> +	}
> +	kfree(sep);
> +
> +	/* Legacy LSM if specified. */
> +	if (lsm_order_legacy) {
> +		lsm_for_each_raw(lsm) {
> +			if (!strcmp(lsm->id->name, lsm_order_legacy))
> +				lsm_order_append(lsm, src);
> +		}
> +	}
> +
> +	/* LSM_ORDER_LAST */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm->order == LSM_ORDER_LAST)
> +			lsm_order_append(lsm, "last");
> +	}
> +
> +	/* Disable all LSMs not previously enabled. */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm_order_exists(lsm))
> +			continue;
> +		lsm_enabled_set(lsm, false);
> +		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
> +	}
> +}
> +
>   /**
>    * lsm_blob_size_update - Update the LSM blob size and offset information
>    * @sz_req: the requested additional blob size
> @@ -241,76 +311,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
>   	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>   }
>   
> -/**
> - * lsm_order_parse - Parse the comma delimited LSM list
> - * @list: LSM list
> - * @src: source of the list
> - */
> -static void __init lsm_order_parse(const char *list, const char *src)
> -{
> -	struct lsm_info *lsm;
> -	char *sep, *name, *next;
> -
> -	/* Handle any Legacy LSM exclusions if one was specified. */
> -	if (lsm_order_legacy) {
> -		/*
> -		 * To match the original "security=" behavior, this explicitly
> -		 * does NOT fallback to another Legacy Major if the selected
> -		 * one was separately disabled: disable all non-matching
> -		 * Legacy Major LSMs.
> -		 */
> -		lsm_for_each_raw(lsm) {
> -			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			     strcmp(lsm->id->name, lsm_order_legacy)) {
> -				lsm_enabled_set(lsm, false);
> -				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
> -					   src, lsm->id->name);
> -			}
> -		}
> -	}
> -
> -	/* LSM_ORDER_FIRST */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm->order == LSM_ORDER_FIRST)
> -			lsm_order_append(lsm, "first");
> -	}
> -
> -	/* Normal or "mutable" LSMs */
> -	sep = kstrdup(list, GFP_KERNEL);
> -	next = sep;
> -	/* Walk the list, looking for matching LSMs. */
> -	while ((name = strsep(&next, ",")) != NULL) {
> -		lsm_for_each_raw(lsm) {
> -			if (!strcmp(lsm->id->name, name) &&
> -			    lsm->order == LSM_ORDER_MUTABLE)
> -				lsm_order_append(lsm, src);
> -		}
> -	}
> -	kfree(sep);
> -
> -	/* Legacy LSM if specified. */
> -	if (lsm_order_legacy) {
> -		lsm_for_each_raw(lsm) {
> -			if (!strcmp(lsm->id->name, lsm_order_legacy))
> -				lsm_order_append(lsm, src);
> -		}
> -	}
> -
> -	/* LSM_ORDER_LAST */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm->order == LSM_ORDER_LAST)
> -			lsm_order_append(lsm, "last");
> -	}
> -
> -	/* Disable all LSMs not previously enabled. */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm_order_exists(lsm))
> -			continue;
> -		lsm_enabled_set(lsm, false);
> -		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
> -	}
> -}
> -
>   /**
>    * lsm_static_call_init - Initialize a LSM's static calls
>    * @hl: LSM hook list


