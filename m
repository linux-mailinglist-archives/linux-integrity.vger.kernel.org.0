Return-Path: <linux-integrity+bounces-6990-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F43B40CE4
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709635E3358
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80E34AAE7;
	Tue,  2 Sep 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RucdsYBn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5E34AB09
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836609; cv=none; b=LR6WMngtUz7OaSjLsYRFvQpHdP3nCeHeP01oAuSlrrnhCPUCnEbd7B7hYqp19W7qPY0dRKGBUMcHEf9KmpQ82EVLAQrFqHvsEgCPzPqjEbm1qXdbR1+/46vUkrp6+n++3RLm9qwRRathp8d2uUIjTIVHTe0G7ofhepc2cG0b6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836609; c=relaxed/simple;
	bh=x37aYtQf1T+qQIfI57QuxqNoCxBKfMb0foRem8DJSzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2vFlB7Rf5Fz91vPUrmtgKizc5y2yYdJkk1CCUuX9qQsXpYmsZs/cL5o1oKlAtMzoCcsDKoK4POhzTB3tvhW8ndQKsV4dP+ULdJFTfIIG39cwMYwVD5OQqHUW0hyo8rZcLoDMyD/4qz8o1eB31o4+0zFiCqfPw0rJC0tLkKlS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RucdsYBn; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 210A33F4E7
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756836606;
	bh=vF3jqd81vSB4gpqfdDwkV1Nw7zHIphbc4gz/EPHOY0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=RucdsYBnKhqem84RSrMPYWd3Wa6iecbyS7dCmmRQvr5qJyrqUX9tuWszhcczRcgRe
	 xPWuhBIvFWasFWlmtjWSfA7ybxYzqSOLGOCSS9eM7S9A756oBmBxIUeOJ/Km3Es/ZX
	 eSIIgJXInCbjYu4sIQDSs+zT/8ZKko9cVaAoHjdZpj3KFW64Rly0snLxuZd64uKHPo
	 ekrXuC/o6LXtTzfdUIAOFcVMemRBBcUN0Kb08GT6bp4WvpaZi5QphENHmCIm3HvRD3
	 J439JkfVZsmc0cKxsm8XVdKDkCd3e3CcFXi2OklX6ZBY7dFuB5LFok4TgiPt8UYraT
	 lga/byVApDZxg==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174bdce2so4355608a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 11:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836605; x=1757441405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF3jqd81vSB4gpqfdDwkV1Nw7zHIphbc4gz/EPHOY0E=;
        b=h4HI2f37KeJIH+Z/SAZYqV4sKuSDGYygmjkcaDm12SxNUNqxmZT8KMKXnGXPz/1ONR
         TAeWwFRQ0t6nWIM7n9MpuHe1Adynx6zzEm6hI5t0vHc9VBzYlmeHz/fDxPkAeLYBCMkm
         wGsA8mbawDiJz+z6MmFGp5zj6uptfv6oMS6TohDMFE1yV4U1v0VXa5m5Doq1km3Jku9Z
         EioQZ/ANwFxpkIL4jD2bk6Ocu5CF8SbeHh0YLkq+fPUnsPGpZvVYQAKA/eFELLHucUB7
         veEgt5bLedhlI4z8bARySn2+yJ7ntI6J4pHQfaXbyZZPMlAOA/TMDCCVTZHfj3s6Z3Ik
         8x8w==
X-Forwarded-Encrypted: i=1; AJvYcCVK7a8NwdeWMoLjZZc0kJ1Y+LSEUcFKtNGOkaFhkq6a+QfVKn5iX4sk2p/Fq+s3ABnwyd4eXvTLkHfRHo+galU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wwxer+IDzseqREsMfsgecbVvPDa1skyxS+EhvxMX2yVxBkUs
	KkrbmAW51lu4kPWohhIK3Muhm/l2AobmxC+i9LkmlohQsGIUGaKqZv25OdHhKhoTNy94lwZ4Yo3
	AaoVU2zwMtvM+PZ1iEgWmFdByCupn/+tBNVSloAQi0okybisiEFBMjAPMHfnq+cLvyccz+UW1Ky
	b2RlvUfEjOuQ==
X-Gm-Gg: ASbGnctTrGypJ5CS2kgTtMqfgHj5DsQJsthcXJt7vPdbGOZwY2TTDQw9W+Y3UNIP4oO
	cAJdbUKTuiviH2+QUMnVj+VsuAtqkrRGb5M/zKGJmCsowj316z/MeuQrfQn9OlKRKEdybwPKVZi
	+AF8CtMPF5AYprTh3E7nmhmgZ0xV75wwQM5+US8yCI5oThARazL5gUaO1jhih+OhaMSlQldzqI7
	JWFlrG5GzJneVDOk/9DwxPP7dv5efQzXxUPzjva4hBU02FsH/9AnTR7CQa4zzy9m+4Ki0WpDTck
	hoC1sfMYajX8lYxyXuQp8Z9hze26wOUSFZEIF0J7o6T6ei016dGxog==
X-Received: by 2002:a05:6a20:394a:b0:246:5be:ca75 with SMTP id adf61e73a8af0-24605becd8bmr1112238637.19.1756836604648;
        Tue, 02 Sep 2025 11:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdky4X83dCdLD8W2rdTaUFzawINMvKdk8EFavw2MC7ZaX/ZlbN7IUOQIlY+PSUl6Dzc5J2w==
X-Received: by 2002:a05:6a20:394a:b0:246:5be:ca75 with SMTP id adf61e73a8af0-24605becd8bmr1112201637.19.1756836604144;
        Tue, 02 Sep 2025 11:10:04 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm14187917b3a.71.2025.09.02.11.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:10:03 -0700 (PDT)
Message-ID: <fa97f146-828c-419a-9365-b45d7cb91f35@canonical.com>
Date: Tue, 2 Sep 2025 11:10:02 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/34] safesetid: move initcalls to the LSM framework
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
 <20250814225159.275901-64-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-64-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Micah Morton <mortonm@chromium.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/safesetid/lsm.c        | 1 +
>   security/safesetid/lsm.h        | 2 ++
>   security/safesetid/securityfs.c | 3 +--
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 9a7c68d4e642..d5fb949050dd 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
>   DEFINE_LSM(safesetid_security_init) = {
>   	.id = &safesetid_lsmid,
>   	.init = safesetid_security_init,
> +	.initcall_fs = safesetid_init_securityfs,
>   };
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index d346f4849cea..bf5172e2c3f7 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
>   extern struct setid_ruleset __rcu *safesetid_setuid_rules;
>   extern struct setid_ruleset __rcu *safesetid_setgid_rules;
>   
> +int safesetid_init_securityfs(void);
> +
>   #endif /* _SAFESETID_H */
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 8e1ffd70b18a..ece259f75b0d 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
>   	.write = safesetid_gid_file_write,
>   };
>   
> -static int __init safesetid_init_securityfs(void)
> +int __init safesetid_init_securityfs(void)
>   {
>   	int ret;
>   	struct dentry *policy_dir;
> @@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
>   	securityfs_remove(policy_dir);
>   	return ret;
>   }
> -fs_initcall(safesetid_init_securityfs);


