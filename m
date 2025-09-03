Return-Path: <linux-integrity+bounces-6996-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE862B41141
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 02:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8333BC20E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81663FB31;
	Wed,  3 Sep 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PIekkIEX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FF632
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858684; cv=none; b=UyVuW4e0r2y0PCOIzIitGUVtqdgzWeHdAHPoc7Pazk2krMia8ENV9weyCkGQdGUijJsRFiz8ed3Meez/kEtDFWHo/yfvEVgGTu1JgjFhvMn/QZvY9mMAn8nl/1fwNAzIgps4uiBk733soLwQBYYGii3s1HAMOH21ASOOnx9KnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858684; c=relaxed/simple;
	bh=zdeh2+Czz6hyix97NV88jknuC0BadM9igbftWcHSoG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne6zSSVAXtENNahADERw0wcQ0h9TbNdvoZz6kq6rZkQL77Lu0NmI0wBL5Q8aPlAiBnQQiwQVFqoVDqWbZMR8sNJcOoo9Rfk3Ab9LwxUQlpz3nwflmLt0p01NN00e/vK4S3ttX5rsPxKyEwDNU0B+Zs1QL+ORKK+h9pEQLc1a8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PIekkIEX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 50B173F291
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 00:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756858679;
	bh=3ZLUE3b5vts51uZx5sGny1FJSR3Be2RNzerSO3A0DPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PIekkIEXhz6NqUWX3YlFpUQ1TefwuLkQ4f6UzHDIzgI/1JN+VLQ9jCnB5V6bFw5Jg
	 plSOupCAPgBgV6AMYWNeofidrikAZavd0a4ROBn4kLdCmht3IehPb25jDegzI71Yg2
	 WEr5qQJX2z38RPu4FhH9zuyl4yVothDa+HD2U+fsNOkGj16x4AtVKJhkvfUw8m8wMz
	 qVHU91iuwiMz1ZxnUmem8eMCCJWk9NMVTxPED2ju8Fpm6UlALmk+qrHcUxvcqQrP+Z
	 zkGj5YS008HyNlfQ6vWKx0kd7tho5Ou+/1Je4IlPMTOvhDvACbIL9iZTjUTjnD0LPz
	 gSsEINoecmzSQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7723aca1cbcso3316937b3a.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 17:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756858678; x=1757463478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZLUE3b5vts51uZx5sGny1FJSR3Be2RNzerSO3A0DPg=;
        b=U2a9siY90jJHNg6lvgFw6pJUu5oVsWitLqMC81yBcix+JedW5ZH6v2C/6F5pwrqq3z
         UDwDoP4Vb+AIMlOzfC9IKancElCsIVaKgSAgopB9SWShz8elXR8VwJbt4Vid2WiLkn4/
         qwdDHQXVguZq2GwrYvidRhS10Q7xtqxg8SdI360GA/kczOcaOK7qMqJkt6OtFHW53/WG
         7HipeijuUT++ISo/bc3ldNpxZCU+Llb2NEYnhVtpSNMntMqz0mnJgeLk/nNTFtzCsQtY
         ealsSb5ZooxTrLh0u03pCxo7D45dgEi1TWmOCC3aYceHkz66LnGpr9La/nSw46Ci+4vg
         SmPg==
X-Forwarded-Encrypted: i=1; AJvYcCUs1nUytjZgfHc8tTMDN4K535aRAOi0gSjc/HTH4b05GKY8HoATMyo6B7VO/79San0OnEQVsZmDC2LMQ5Sm8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmVhvJ47MpyE8jB9+MhK4KyollgAJvoYaIJrW+MlZseS2SeJV
	GTKKtivBs/RBCXHJ4V4w9Zl/ospplcOKj9JFBp9CN1A/WZve1hdVj/CrOo/ezYB1EvB2CsONmAa
	At1A42P/7XsBxEtCJNu+FUsG7Wg8UO21IlJCtE3IwatvLk5q7ODKnaGFdZFNccYoUsI2vP9clMp
	Hj/DFSB9JyZA==
X-Gm-Gg: ASbGncviqyAPN/Z7JifovzgmvK5+7LFAyQ/oCPfnJGKBimxdBwXnh7Npt/TNbe3Yogl
	37GNHSe37R1bn/V0ml/beLE4i7UifEzggt7KMi0CXpK6s7ycmT0mczi4tNL22prvBtZrJuNJfn6
	syQEncj2GkfXCPigOO0B/W+kyTQ/a/QVqGPzJjAY0qfcanVTHuTDkIKdauY6HCU91jHnR+2bm/r
	MAh3InJPUxkk829qkkZzG/w5IGq6eLq4YaqmaqQPKx7w288G2NRROG5fFe7HI6Ydcd5c32scM5K
	fsZ4W+U++8QTbb57I5cM/Jevfy4BK8hcth7FE2Uy2Z7F0U98avargA==
X-Received: by 2002:a05:6a20:3948:b0:243:a251:cf65 with SMTP id adf61e73a8af0-243d6f52621mr17245239637.49.1756858677945;
        Tue, 02 Sep 2025 17:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4g6IRAIgsBLtRjqMYPxhFBZj6ar+WMFcZTWVVaPnD1GSIhpmF9B0C+yFlHy1I2vVDvn3iNQ==
X-Received: by 2002:a05:6a20:3948:b0:243:a251:cf65 with SMTP id adf61e73a8af0-243d6f52621mr17245212637.49.1756858677527;
        Tue, 02 Sep 2025 17:17:57 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4fa1a29cedsm900152a12.46.2025.09.02.17.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 17:17:57 -0700 (PDT)
Message-ID: <14213aff-0cb5-4bb3-9327-9b8e7c544c0c@canonical.com>
Date: Tue, 2 Sep 2025 17:17:56 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/34] lsm: rename/rework append_ordered_lsm() into
 lsm_order_append()
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
 <20250814225159.275901-50-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-50-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Rename append_ordered_lsm() to lsm_order_append() to better match
> convention and do some rework.  The rework includes moving the
> LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
> in order to consolidate the individual LSM append/activation code,
> and adding logic to skip appending explicitly disabled LSMs to the
> active LSM list.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
>   1 file changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index ec46ddb18e1e..a314484d7c2f 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
>   	return false;
>   }
>   
> -/* Append an LSM to the list of ordered LSMs to initialize. */
> -static int last_lsm __initdata;
> -static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> +/**
> + * lsm_order_append - Append a LSM to the ordered list
> + * @lsm: LSM definition
> + * @src: source of the addition
> + *
> + * Append @lsm to the enabled LSM array after ensuring that it hasn't been
> + * explicitly disabled, is a duplicate entry, or would run afoul of the
> + * LSM_FLAG_EXCLUSIVE logic.
> + */
> +static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   {
>   	/* Ignore duplicate selections. */
>   	if (lsm_order_exists(lsm))
>   		return;
>   
> -	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> -		return;
> +	/* Skip explicitly disabled LSMs. */
> +	if (lsm->enabled && !lsm_is_enabled(lsm))
> +		goto out;
>   
> -	/* Enable this LSM, if it is not already set. */
> -	if (!lsm->enabled)
> -		lsm->enabled = &lsm_enabled_true;
> -	lsm_order[last_lsm] = lsm;
> -	lsm_idlist[last_lsm++] = lsm->id;
> +	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
> +		 "%s: out of LSM static calls!?\n", src)) {
> +		lsm_enabled_set(lsm, false);
> +		goto out;
> +	}
>   
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> +	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
> +		if (lsm_exclusive) {
> +			init_debug("exclusive disabled: %s\n", lsm->id->name);
> +			lsm_enabled_set(lsm, false);
> +			goto out;
> +		} else {
> +			init_debug("exclusive chosen:   %s\n", lsm->id->name);
> +			lsm_exclusive = lsm;
> +		}
> +	}
> +
> +	lsm_enabled_set(lsm, true);
> +	lsm_order[lsm_active_cnt] = lsm;
> +	lsm_idlist[lsm_active_cnt++] = lsm->id;
> +
> +out:
> +	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
>   		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>   }
>   
> @@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>    */
>   static void __init lsm_prepare(struct lsm_info *lsm)
>   {
> -	struct lsm_blob_sizes *blobs;
> +	struct lsm_blob_sizes *blobs = lsm->blobs;
>   
> -	if (!lsm_is_enabled(lsm)) {
> -		lsm_enabled_set(lsm, false);
> +	if (!blobs)
>   		return;
> -	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->id->name);
> -		lsm_enabled_set(lsm, false);
> -		return;
> -	}
> -
> -	/* Mark the LSM as enabled. */
> -	lsm_enabled_set(lsm, true);
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
> -		init_debug("exclusive chosen:   %s\n", lsm->id->name);
> -		lsm_exclusive = lsm;
> -	}
>   
>   	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
>   	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
>   	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
>   	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> @@ -227,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	/* LSM_ORDER_FIRST is always first. */
>   	lsm_for_each_raw(lsm) {
>   		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "  first");
> +			lsm_order_append(lsm, "  first");
>   	}
>   
>   	/* Process "security=", if given. */
> @@ -259,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		lsm_for_each_raw(lsm) {
>   			if (strcmp(lsm->id->name, name) == 0) {
>   				if (lsm->order == LSM_ORDER_MUTABLE)
> -					append_ordered_lsm(lsm, origin);
> +					lsm_order_append(lsm, origin);
>   				found = true;
>   			}
>   		}
> @@ -275,14 +285,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   			if (lsm_order_exists(lsm))
>   				continue;
>   			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
> -				append_ordered_lsm(lsm, "security=");
> +				lsm_order_append(lsm, "security=");
>   		}
>   	}
>   
>   	/* LSM_ORDER_LAST is always last. */
>   	lsm_for_each_raw(lsm) {
>   		if (lsm->order == LSM_ORDER_LAST)
> -			append_ordered_lsm(lsm, "   last");
> +			lsm_order_append(lsm, "   last");
>   	}
>   
>   	/* Disable all LSMs not in the ordered list. */
> @@ -415,8 +425,8 @@ int __init early_security_init(void)
>   	struct lsm_info *lsm;
>   
>   	lsm_early_for_each_raw(lsm) {
> -		if (!lsm->enabled)
> -			lsm->enabled = &lsm_enabled_true;
> +		lsm_enabled_set(lsm, true);
> +		lsm_order_append(lsm, "early");
>   		lsm_prepare(lsm);
>   		initialize_lsm(lsm);
>   	}


