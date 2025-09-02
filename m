Return-Path: <linux-integrity+bounces-6970-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589BEB40AC6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75EC188C535
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C982DCF70;
	Tue,  2 Sep 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bGu4k1if"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AD320A1C
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831046; cv=none; b=Z1qNQH0XVNNpAGpjkVOqZgws9/hPfOMEbmvvaMK0KxcjUxgWDJy4HglqVbAeEjoX9nyKlcJcxRsSrXJDe5IK4pCz/g9B/is4WeJt5J6CMf8wXqFq90V6Z+8pJAVsZKLoPT5rr8NTtcQ/CABWmG1Kawq79B9Le0eMpvoPxxpO728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831046; c=relaxed/simple;
	bh=lX5CVDR6umZkvzSyLIyqOeZWiWEsX7qhlSNvuLHh9Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I//BulS+p9erKbXv725qoFv2WQV+ZzPI2lIz+Y5B46bxrjaAM0aNvhjSAvUzG176Zy4ss0fkWVDJDkGcWG9Gl2w50IwhO0O3eCwO6L7PFmO7B27rFTyW4Gz1W9uxTlHpBuQXqBXB8CxPKGu5w5m58TO04B9bOBdhmnkkU+yTkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bGu4k1if; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6FA883F679
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756831041;
	bh=X79iWGzsrYcNCnMB1bw3eBVILKAFS1+ceM31KkkDuqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=bGu4k1ifM2HZBEUxAiJKS32iILtIIRmQvKoKuGeEY/6RYx0zfaI5ZMpnVmNd0uMZm
	 oawdp1SsnMoewaYWnA0gzcOeN/D1RVp+slRjkQdHnKEtXiDjll/4+1uxRTQavEEgff
	 dCTa6IiuEnx8BdSkncXHeigvmcnykVcNdGb+GmB7TtKEvOXXPg1HaxHK9ZZ8u7Vhm3
	 JqZXTqZKp/2VbmcOyolM2XlaNTknuyq7fTvgkCM2lCRiqqlWh9Q67JA1v8KcyUuHu1
	 xzSTlcYK1NTuUrZv1/DypmgXAHJKV5ahil4KPvi3x9gOAzyuFcSFqrlnsF4UgLn6yQ
	 DNzw+OaU/XGZw==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77260b29516so3483646b3a.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 09:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831040; x=1757435840;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X79iWGzsrYcNCnMB1bw3eBVILKAFS1+ceM31KkkDuqk=;
        b=o48mEaGp9zgacFNKSYxDiWC2pSMWJT8H4acarlaPln/BrzQGniA0MXs53Ywfjt/OLC
         8CNGUi0E2PgEwykJgEli45MF66qmcBQ2O2hNPFJ9xLFJFuFS8z5GeMdvOJ+0OJ75RWSd
         7f3whN3MxPgIitvyGgHU16sG/HZsCyyEqbQDtXYoZX7JIhLgtvXAD44X4doEnwHnHaHA
         saFOhl90vXE5Ytzri2ciLV34efvPFPCjlIaHuIRLWdnNykSr1CpKGjhxh1CcLwPbXnT4
         y9P7geIzWRCpKKhC1Nj4x46AgUOLaU59vr0z2OpU1dX+4eJM/kS3PY7RZlEfI7IBGCK4
         SGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrz9wft+QL3eEbGL3Farkge3x8ojKUw/fknc21ps32NEuEBcMrKMf+Uno2Q58xAaxxcCGKf2WNIsb51dUeNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYlfewDeH2MWzeVGEddwsWvdGu8ecoopHNN6vysKzkvnEID1b
	V0kMDvCdh1emLrTaNVI5XHgQYqF7+EkDO/xJJNpOP6QXBDz7vgZaRKaNxNwiI2YQQl5Jy9UiPCw
	Xv4/SeiJr42L+8ttGq1sPqxQ8LQ9MQXhvfGeEM9sFnp0FaoGbxLxOfoi/fxCLy+PfqJXUnxQmUI
	MjT058Apid7Q==
X-Gm-Gg: ASbGncsOCzpOB3pjPCZHAuUhR8Z8PBTJg+Q4MwXom5d4DkIkR209XiBniAHEj5y5NIc
	3Oqp1rwV/FXhAG6+kpsYbLLAyAtJciT1VNTV4e+TSJJx4EHzjwZns3XIQeJHuccUp80EFy38PJe
	gJVxwVh0h3PI6AcFI5WfcJEoADOXa5Ecjk0e5gF9I5Y3+jVAZZlDo87U+Qh53OA7ImAT3hmIlnZ
	AlxXMeaNZsc/hC0oNa0pfui21KN9VbHraCvR2r9pcUEhcHJykZBWBxajhjYelrftjxbe8pMtIJ0
	vmEmGA7eoj/jVno1gGbWTIMSMZKAMFg9DKxACEBF7nctq3aim0h3zA==
X-Received: by 2002:a05:6a20:3ca8:b0:243:15b9:765d with SMTP id adf61e73a8af0-243d6f8822fmr16295178637.55.1756831039665;
        Tue, 02 Sep 2025 09:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Ub5Kte9WUe0ugpXEllAAi4l/lJFZkdi3buuoyU5sFQEgZKzqzK/zS+/fOSMOWBW9VR6MSg==
X-Received: by 2002:a05:6a20:3ca8:b0:243:15b9:765d with SMTP id adf61e73a8af0-243d6f8822fmr16295122637.55.1756831039033;
        Tue, 02 Sep 2025 09:37:19 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4e5684da06sm9299895a12.17.2025.09.02.09.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:37:18 -0700 (PDT)
Message-ID: <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
Date: Tue, 2 Sep 2025 09:37:17 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/34] lsm: introduce looping macros for the
 initialization code
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
 <20250814225159.275901-40-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-40-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> There are three common for loop patterns in the LSM initialization code
> to loop through the ordered LSM list and the registered "early" LSMs.
> This patch implements these loop patterns as macros to help simplify the
> code and reduce the change for errors.
                       ^
                       chance

otherwise looks good, and you can add my

Reviewed-by: John Johansen <john.johansen@canonical.com>


> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 6f40ab1d2f54..18828a65c364 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -32,6 +32,15 @@ static __initdata bool debug;
>   			pr_info(__VA_ARGS__);				\
>   	} while (0)
>   
> +#define lsm_order_for_each(iter)					\
> +	for ((iter) = ordered_lsms; *(iter); (iter)++)
> +#define lsm_for_each_raw(iter)						\
> +	for ((iter) = __start_lsm_info;					\
> +	     (iter) < __end_lsm_info; (iter)++)
> +#define lsm_early_for_each_raw(iter)					\
> +	for ((iter) = __start_early_lsm_info;				\
> +	     (iter) < __end_early_lsm_info; (iter)++)
> +
>   static int lsm_append(const char *new, char **result);
>   
>   /* Save user chosen LSM */
> @@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
>   {
>   	struct lsm_info **check;
>   
> -	for (check = ordered_lsms; *check; check++)
> +	lsm_order_for_each(check) {
>   		if (*check == lsm)
>   			return true;
> +	}
>   
>   	return false;
>   }
> @@ -209,7 +219,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	char *sep, *name, *next;
>   
>   	/* LSM_ORDER_FIRST is always first. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>   		if (lsm->order == LSM_ORDER_FIRST)
>   			append_ordered_lsm(lsm, "  first");
>   	}
> @@ -224,8 +234,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		 * if the selected one was separately disabled: disable
>   		 * all non-matching Legacy Major LSMs.
>   		 */
> -		for (major = __start_lsm_info; major < __end_lsm_info;
> -		     major++) {
> +		lsm_for_each_raw(major) {
>   			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>   			    strcmp(major->name, chosen_major_lsm) != 0) {
>   				set_enabled(major, false);
> @@ -241,7 +250,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	while ((name = strsep(&next, ",")) != NULL) {
>   		bool found = false;
>   
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>   			if (strcmp(lsm->name, name) == 0) {
>   				if (lsm->order == LSM_ORDER_MUTABLE)
>   					append_ordered_lsm(lsm, origin);
> @@ -256,7 +265,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   
>   	/* Process "security=", if given. */
>   	if (chosen_major_lsm) {
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>   			if (exists_ordered_lsm(lsm))
>   				continue;
>   			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> @@ -265,13 +274,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	}
>   
>   	/* LSM_ORDER_LAST is always last. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>   		if (lsm->order == LSM_ORDER_LAST)
>   			append_ordered_lsm(lsm, "   last");
>   	}
>   
>   	/* Disable all LSMs not in the ordered list. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>   		if (exists_ordered_lsm(lsm))
>   			continue;
>   		set_enabled(lsm, false);
> @@ -290,13 +299,14 @@ static void __init report_lsm_order(void)
>   	pr_info("initializing lsm=");
>   
>   	/* Report each enabled LSM name, comma separated. */
> -	for (early = __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> +	lsm_early_for_each_raw(early) {
>   		if (is_enabled(early))
>   			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	}
> +	lsm_order_for_each(lsm) {
>   		if (is_enabled(*lsm))
>   			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +	}
>   
>   	pr_cont("\n");
>   }
> @@ -343,8 +353,9 @@ static void __init ordered_lsm_init(void)
>   	} else
>   		ordered_lsm_parse(builtin_lsm_order, "builtin");
>   
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>   		lsm_prepare(*lsm);
> +	}
>   
>   	report_lsm_order();
>   
> @@ -382,8 +393,9 @@ static void __init ordered_lsm_init(void)
>   
>   	lsm_early_cred((struct cred *) current->cred);
>   	lsm_early_task(current);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>   		initialize_lsm(*lsm);
> +	}
>   }
>   
>   static bool match_last_lsm(const char *list, const char *lsm)
> @@ -485,7 +497,7 @@ int __init early_security_init(void)
>   {
>   	struct lsm_info *lsm;
>   
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>   		if (!lsm->enabled)
>   			lsm->enabled = &lsm_enabled_true;
>   		lsm_prepare(lsm);
> @@ -512,7 +524,7 @@ int __init security_init(void)
>   	 * Append the names of the early LSM modules now that kmalloc() is
>   	 * available
>   	 */
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>   		init_debug("  early started: %s (%s)\n", lsm->name,
>   			   is_enabled(lsm) ? "enabled" : "disabled");
>   		if (lsm->enabled)


