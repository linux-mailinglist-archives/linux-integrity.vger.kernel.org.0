Return-Path: <linux-integrity+bounces-6986-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA24B40C81
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325DA7B570D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419019F12A;
	Tue,  2 Sep 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v4X0mTI7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671A32F761
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835481; cv=none; b=iaXzwrvpmh0CFCP+lX7uq2EqVWL+v4pTlgzf4Y27AH5xrfy6B2HM0ptUGF34ys6EK3iowJOQfrK2GW3GYNaI6lm11+37/q9tNYJkKcrlTC/RYxEAYF/FjKPh5mo66m7WZ3+L7Cw1kwVCC1RqYLZG884pE7EkjbJ2L6rNLh38yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835481; c=relaxed/simple;
	bh=ij3QU8NGC7NeXdaBvPYfa9JhjcDXbQ6Y+v9D62BQ/uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh4rTmWGxqtUZnHkU5kCVhOXcscgbNdiB4n+mV8BZ4AC+oWQ8hevbEJqbYZQeVEeBnebqqyJw8lKj/Rs1hgzK7TZj/NhRLnKhbNrVKYvZ8+omBmxyAuaJOW8vUqjPihOR4rU/MVX5wjdVIZtjlzcm/wCCetUz99nkKFqi1pw8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v4X0mTI7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7480E3F681
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835478;
	bh=HfZznrJfB1dICVVaT+f4HXRi6Umt1xD9tUrHuERyGaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=v4X0mTI7Qg7WnA3lULG9zkSn5Z8vp/TGzgk2yka3RkGwuIOlKkAbLew+PWVrX8E42
	 3/EnUy7rM09JP7nQpDfAXhN2QH4wAyJT+gjNfaizI0mPquIw/iEowRfi+eftYXnl0p
	 IWjnhzzQI+fNuF8KvtKtsphKwdPyIsQIdwTJJKjFtA+y4jZviBtawgRASd0hE4F21K
	 RNdzYiuKpExiXw4xCQ/GQZQNakSPW+MamJ4O42t0AVpEkKwhfvlDa/uxJA8vrTUs2u
	 ZsTnFHaxu/0Xa2LVysAfibkiW39B7NAk01sVgGnZg6UfDL2r9XuQ9R+5hYy6Czief3
	 bxo0GhO/NBXmA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c46fbb997so103959a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 10:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835476; x=1757440276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfZznrJfB1dICVVaT+f4HXRi6Umt1xD9tUrHuERyGaU=;
        b=hQlXp9haN7V+JZ5dIBcA01ZjDUdBiy21JLH/5C19w8DQh3vF39VtvXv8dn6bExN4fZ
         9BrN0nqr4bpauynjJ1T7NRngKKmkMHr+4Mq8LWymKz/jLLDkOJCjzA7Fe9WEVKNZ6/K7
         qi88hXaazGBnCO8VJnJVybtT5JWT7yx/+YuYJViOE6Rkk49cTZboSpQllee+RQPa8+4M
         RrHfORR44Wg0ZmjOzo/WBjfomQHMI1Vn1eFEMQaHaEBerMzEjbWFCCIQwBeCsQhqZYrV
         kaAuirDPs2Fx0HPaJq6wL1asrUivbv0Bdbi9ClgYp2qaO/UllayCcKyBfajT3JtormMs
         MiAw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/Xe/aeAeqCnm0AXc1qywyayfgdospwd4R6ZdYFmxss/ksw+wS/axBhQWlmRkyP4vglWzMu2dhF4UutHv9AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBFlyBuR/Cz7/UMq96uI81S2sLKAfMWLw4EH8XE54j7uWiqjE
	SoOoO3g5qxNsSIuD3qvKM4AKS8s1Z6LYhwY4iEuRSX+mdYj1VN4U1cPV8gsB1WfvQW212sejMDH
	4IMquXCz+jfBFPQlBAlMMC0x2vALX94Z0YZ8O8g3N2HVyaK4NgpgSRrjhnTQTJS7S1eCf2H/wkJ
	C4NKPoBBYZMw==
X-Gm-Gg: ASbGncuF6vyEhQmDsjHsB9fw1sRoUa3vsKbInuuP0zouDofqBq4UT/AZ5hzSivPbuAh
	D1fdc0y6TMrQ+gPEb8ExBZX5No70yOAy4a7jzyyWPIQ7vlPS3MbHpcRgUu9hmdf+BA38OW4BRch
	9giHIWp43mLXflPfVdaEAuwwOBUlXB8/O6YJwB7otNcZtv7CeWmtcKO+H4XidFzyQungOxSfDzc
	jLAk8hPhuCWdTmsxYSoE0N4pOyL/HTwoWQYuN20MqvqMmzrz8BaldoMuJYjyQio1AG/HnSaTy3+
	yfcSlSbCh9Sis3AFvF4CKoFbueX5IaUfj0RKAscz2Fmtr8E5qS8MRA==
X-Received: by 2002:a17:90b:3148:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-3280d364e5dmr16357085a91.16.1756835476419;
        Tue, 02 Sep 2025 10:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3NfrNr0u5Dl1pH4RPhQ18KvyHS94K+Vbw2+IqYN4A6Mu17B0XKZuKf5zW+cDevvlZZMUBGA==
X-Received: by 2002:a17:90b:3148:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-3280d364e5dmr16357053a91.16.1756835476018;
        Tue, 02 Sep 2025 10:51:16 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd366a909sm12145798a12.52.2025.09.02.10.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:51:15 -0700 (PDT)
Message-ID: <00faa5b3-819a-40b4-99b1-5f6a3b7d9831@canonical.com>
Date: Tue, 2 Sep 2025 10:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/34] loadpin: move initcalls to the LSM framework
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
 <20250814225159.275901-60-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-60-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Acked-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/loadpin/loadpin.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index b9ddf05c5c16..273ffbd6defe 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -270,11 +270,6 @@ static int __init loadpin_init(void)
>   	return 0;
>   }
>   
> -DEFINE_LSM(loadpin) = {
> -	.id = &loadpin_lsmid,
> -	.init = loadpin_init,
> -};
> -
>   #ifdef CONFIG_SECURITY_LOADPIN_VERITY
>   
>   enum loadpin_securityfs_interface_index {
> @@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
>   	return 0;
>   }
>   
> -fs_initcall(init_loadpin_securityfs);
> -
>   #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
>   
> +DEFINE_LSM(loadpin) = {
> +	.id = &loadpin_lsmid,
> +	.init = loadpin_init,
> +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> +	.initcall_fs = init_loadpin_securityfs,
> +#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
> +};
> +
>   /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
>   module_param(enforce, int, 0);
>   MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");


