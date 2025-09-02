Return-Path: <linux-integrity+bounces-6973-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0168B40B4C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FED1B25B3B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94801341AB9;
	Tue,  2 Sep 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vh5/IiG7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECF340D92
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832220; cv=none; b=kgALNc37kkwtzs6I/aAJDOGVGW5aficYHiV6pZVE1+pN4Z5FJ2UxcFQXv/s4VmjSOfYM1zZrcwl0fEIefTR66QFiEZ6dt+nYJ5anEwMMo7l7GRyTQAZz7DZ/QkPCWosixpNT4ZFfKKN/2djxPF3QsOc4aQTOhB3yq8sMgECe1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832220; c=relaxed/simple;
	bh=Xsl0fTGrWItdBHiz7szySL6XM/esp0CwWHActvIgxho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsNM58gg0SPKPwCElsOvFA2Q9iNb9Uqy8QEqZnDHvKWp9WORwqkG0FBbOsRJsTJRIteN2BwxV9kW8h1Ky9tw2r/R8L0x5XyomN0yDyvERIIlGnhR6V2RqRlQHYw/oAmoSkM7susRIaE8J7P5dCu8kPu+5UG/S/KE0mlVg8S47lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vh5/IiG7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 457083F67E
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756832217;
	bh=DXfv54qLINZHJ+rRGxZeXtdhpZedfe063OZrOuY37LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vh5/IiG7GlEHV4Ho7FQ9KgGuugZzscLeCkMqMRTA4m6mTE7jZZIJkMJTQDYdy+LCl
	 +96r4PllnJf1714foUVXqT6M5UhKeSrDqBmg17QQFd9+uhvJ/3Bw0Ozfl7BEzOIyms
	 xlMvd+IOgeEsjuihh4QW/QEvwe7/GI8QUsn50Js5TeyMTyinoHYWcz4K01nA1ssQ7I
	 yQ8yve3IHudZ/Zw15PkklUbz59mxKBtGMf1rLu1GjF1jbziSiezqNH8PjAiIVMW21N
	 Ka118emn9TBBORpCMXmYdRyv13ggglFNUDtCsVLvRNkcc+u0MqRomQgyS/VNlEaU+i
	 /V2cwbIA16qWQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-248f7745075so83482775ad.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 09:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832215; x=1757437015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXfv54qLINZHJ+rRGxZeXtdhpZedfe063OZrOuY37LQ=;
        b=cSMUwB+gDM+6KZ5/8IODGERV8jZY9MRJJ7u+4qYJ+sRR5yTOIdrkzhvvlMFQgEuhz8
         vfjd1N3Nlr2b/3bP2jThpKYOoaMg4QaKcYVKen1NNjTNcp8e7bVi17EmDdxCg3luTb/p
         nql5mCN2l/Xtpv1T4nSx8DV8o4lNXxC1AdXxUTcVATLK4hEeT5VvJmpiDixArh8fyg8D
         /2AmXe0D5LeU3oMdV8QHUOFe8+BU04P971bjaLsKXzfxR1eHUJ5AMqUQ+Agr0pU0qA12
         /cJRiHtlbL9ZfCOnGkLvuYNOBFUIhKxtszcNbkI732ZuwKCeN1ngUgrw3JE5qCr7WPgw
         MyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuDy9qM//G9W9mgY3ar4rBe+tOhmLQ9y0oi2D/gjr5m4lcsWy3Hcro7sEemsPihRKAEe1fO+tr7F11aD6BYXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiFpsKI7mzDa9l4vYS2mPT6bFIDdsLZJDkTNIIGkKfARztKu5
	7PCZA5onmE7v7CP3DJHqxaPDH5scYaxywLb7OCLJyBy/be4HcD86Zziq6jXlmDrH9NWXJLAjjXN
	semftizsxBlaJ0FXPzxYLbdQP8TmLHkmoJHWf/uB6zTzuDMVs9CJFmr5edQLBroTetjE2Zv+4/C
	IJT9woiihrSw==
X-Gm-Gg: ASbGnct19FBYTXS0IVoECOL0FlAADkaTgL905GEf8CyGMxl4fjG5+wqgnOnoaI2g+TM
	imPrQDUiOIxNA+GyD4TUnqgNO9+6+ej9wAL+HRBHGLPl/lNqk7vRZgcuKb7prLiZKS2oAKW5I0U
	vwpYTYzxYbL6VYXPwR3fmGmFB1iTzOb+9LPj9THJsxdK6FxPL2uXo7A9oKg+mZXDwo/U+o05XFc
	UOCsSFstUW0Kt1OFoJqAea1bG5PWuia/2lZrScasU0wKC0+j25eBlvv93x1bVhskKpVsbpUucCC
	VAn12PHw7hnyc7h7QK/hzfw8x13D72q2zEiaMjSYUgMZtXvaK4nonw==
X-Received: by 2002:a17:903:acb:b0:246:76ee:535b with SMTP id d9443c01a7336-24944a8fdd6mr167308475ad.27.1756832215415;
        Tue, 02 Sep 2025 09:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmr8FYHGcXGOf+CAqxfO1q+B3g3pB6PTDPG2bMXyCrVR2UhIEtKzujigzXnyn3YVK5cRkSPA==
X-Received: by 2002:a17:903:acb:b0:246:76ee:535b with SMTP id d9443c01a7336-24944a8fdd6mr167308155ad.27.1756832215037;
        Tue, 02 Sep 2025 09:56:55 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249067de9f1sm135660655ad.151.2025.09.02.09.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:56:54 -0700 (PDT)
Message-ID: <74942c36-4246-4525-8524-3df00fe4e3ed@canonical.com>
Date: Tue, 2 Sep 2025 09:56:53 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/34] lsm: rename ordered_lsm_init() to
 lsm_init_ordered()
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
 <20250814225159.275901-43-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-43-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> The new name more closely fits the rest of the naming scheme in
> security/lsm_init.c.  This patch also adds a trivial comment block to
> the top of the function.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index a8b82329c76a..4a108b03c23d 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	kfree(sep);
>   }
>   
> -static void __init ordered_lsm_init(void)
> +/**
> + * lsm_init_ordered - Initialize the ordered LSMs
> + */
> +static void __init lsm_init_ordered(void)
>   {
>   	unsigned int first = 0;
>   	struct lsm_info **lsm;
> @@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
>   	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
>   	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
>   
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
>   	if (blob_sizes.lbs_file)
>   		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>   						   blob_sizes.lbs_file, 0,
> @@ -498,7 +498,7 @@ int __init security_init(void)
>   	}
>   
>   	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> +	lsm_init_ordered();
>   
>   	return 0;
>   }


