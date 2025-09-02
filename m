Return-Path: <linux-integrity+bounces-6983-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03242B40C51
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECB57AD0CB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B12E0915;
	Tue,  2 Sep 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H5cXqrza"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57B2E06EA
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834946; cv=none; b=KUMn3ssJ/+RILCsvZliMIqkmHFm8JOu7xjCmoZjQJ5DAD2UjgI+sXVf4abJRx4z9J0aLE9F5ObJa/AaGOLKXix9PSxsjYc3hFmElAb0Bhs8XmnI/LX0JQJDcLmpkMz1p26IDx95TEhTmYKaNhocOFNrQBi20YMDHmFlm6KAM4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834946; c=relaxed/simple;
	bh=KOGBX3OjF43QzjSeHsTt7YXEzPgmCR6KFEFJf07pGoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfGX5I+6ykmALEykeNYgBeSANPpFtILWRlnMTmO35UYNnKSWB5IygvwAW75Mbvj5IJLX+N8mjC1Y/EG5YXKUitDCkt5QYqBpu4hLGAqFkFIyFOyQwvmfU9/QmZfSS1RSv9g/DXgPUvF+j3jIkoceu31YM+Hp99Qpd0zl3jdaLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H5cXqrza; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C43D3F5B7
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756834942;
	bh=gh3hOv1yCTHyZzXMIsqBOWC7kzvUNQqAjqBxPsFIuD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=H5cXqrzaS+WuOrWD3/UmJhAyOw+4+uSZKTnQVdxZMcNRKHEzPEN4TOwdejdkmhCkv
	 zqUw7uUOi5cBdx8rWDXqzIpYy+icsc0Yh0o2UgKKPqaWqW0GUUQtOkltxFBUCk09EH
	 Ylk+Cr4VGGbIP4SWvJNiVVLWiazV7rX9pUwpXw6D6XCzQHFWYzAF6tNut73aoLUHdN
	 PXA4bAT7lWwp6FRYvQn40awEYiy76JPr/kC1NGflxWP7cT0gyXYOgVnOCmswEBdUhp
	 oGkGpnMf9v/H4jbH4zPX7IfTLa5I24wH/wfTQZLgT7P9pMGn9ahs/wZvCyjaKSk6LW
	 goUlzcoajrjyw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248eec89618so59427585ad.1
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834941; x=1757439741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh3hOv1yCTHyZzXMIsqBOWC7kzvUNQqAjqBxPsFIuD8=;
        b=PcT7Jj6P/wcBmGxVfhz5VmS1gsdflwwPy/+YyKTkdWqnPWx5DHxlkZKrKu3jwI/SBt
         RtAyigb5tRZt63WbD2/8W9icvejt+xYsr8j1GQrznd1yjt1vcp5qBeniPaPXEsv+kOxs
         ZiFiesBR4sRhqEOY/l3XQy5+KCh2BHFlscn+tC04FJW6Rf6dnjHM5sDrCxUD3V4EyN9n
         GJjsiedzh3ovtVebtJjGn8ELnDA/lBEV4/U+t2e11SqqCK5N1FCHdtks/2+YnpD4VNeZ
         638kB2iCZje63s9djt7j/xkYvIDBc1Fuzkpynhb2MJwljgbOVVj+uo0x1DFaJFZ5n0Ki
         N06w==
X-Forwarded-Encrypted: i=1; AJvYcCXKuqcbO4+ir1gzBahf8tLefb601sKfauuA8CR7gEFXrKCPpXHndhNiDFFbRVRRWN+SlxyZrd0jZIQOVQ0pNFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsD4+npD7gEuOnArrEzc7fM9LaMLsBWTZNECQSQMQqS+pZvGU
	NPPNL1AuU3p0vZMfq9LHdBNUXpyUT7zH9SRiMw4HziD5sKEbLvOsaqHmVZ5Ow25u92xpKv4vfn1
	8Bv8FlzVNnDAaBm6Hu1TiOGDNZGWEa+PHTyb5R5LuicUF15qCxz3JpDHIm/0oLqZaxzRrWYPd3i
	xC3XkGSsp65A==
X-Gm-Gg: ASbGncuOtZnGzZDiKwMxNxK7Ro3/3jW3v5MhZ4vIZ2M3H40+iP9aK+8fy8wfGK+3viN
	n2jVlfT44AYi/4pHfC3MEbK4U4/SOw005eoWYTuP+CBdAk14DTtlv2zouYC0BqTsrFg7PMXlLnO
	1MDJVWm5UyJn+c/JGNmRCjI26sGH74whG1T1Mti19BEkyOMjkDXEATGaF4ntRmI4zkL8tBVpa/3
	54MPan4n7CCKQ8jgpF9Kv6FuBuSaJ2ArZDxoH4dcaqrgNSKdW0znuBxv2orH1KcBjU9ZX8HJLz2
	5dpfByVAFT05VFMgBuGjhfG46ul86T0gyKDXO0F4Te5o3jDV9arT8A==
X-Received: by 2002:a17:902:ea09:b0:248:e0a2:aa31 with SMTP id d9443c01a7336-24944a99188mr139257435ad.32.1756834940616;
        Tue, 02 Sep 2025 10:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH9O2MGGD36YTtYgbIL9Lp8qqpdIau5uMd5kUIES2cdeaB0Lc3os++mtNsOR3Vbj8xX2sZ5w==
X-Received: by 2002:a17:902:ea09:b0:248:e0a2:aa31 with SMTP id d9443c01a7336-24944a99188mr139257185ad.32.1756834940246;
        Tue, 02 Sep 2025 10:42:20 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm12594375a12.31.2025.09.02.10.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:42:19 -0700 (PDT)
Message-ID: <0e5505ed-aa38-4217-bec5-77279987d5f9@canonical.com>
Date: Tue, 2 Sep 2025 10:42:18 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/34] lsm: rename exists_ordered_lsm() to
 lsm_order_exists()
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
 <20250814225159.275901-49-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-49-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Also add a header comment block to the function.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2cfd72ade6fb..ec46ddb18e1e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
>   	return (lsm->enabled ? *lsm->enabled : false);
>   }
>   
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +/**
> + * lsm_order_exists - Determine if a LSM exists in the ordered list
> + * @lsm: LSM definition
> + */
> +static bool __init lsm_order_exists(struct lsm_info *lsm)
>   {
>   	struct lsm_info **check;
>   
> @@ -126,7 +129,7 @@ static int last_lsm __initdata;
>   static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   {
>   	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> +	if (lsm_order_exists(lsm))
>   		return;
>   
>   	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> @@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	/* Process "security=", if given. */
>   	if (lsm_order_legacy) {
>   		lsm_for_each_raw(lsm) {
> -			if (exists_ordered_lsm(lsm))
> +			if (lsm_order_exists(lsm))
>   				continue;
>   			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
>   				append_ordered_lsm(lsm, "security=");
> @@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   
>   	/* Disable all LSMs not in the ordered list. */
>   	lsm_for_each_raw(lsm) {
> -		if (exists_ordered_lsm(lsm))
> +		if (lsm_order_exists(lsm))
>   			continue;
>   		lsm_enabled_set(lsm, false);
>   		init_debug("%s skipped: %s (not in requested order)\n",


