Return-Path: <linux-integrity+bounces-6721-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508AAB114A9
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A4AE3531
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FA242D8E;
	Thu, 24 Jul 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Sw2E2V7h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B61DED40
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400129; cv=none; b=FoMcAhrxEr/BX9Ww/ihvY1FrHE8mMkHaiH5cL6a8wQ7PSPGX5sSKjb4INT3GrF7hnv1j6Hpq4NZZWavGDTD2M4NHe/jxpX8u7t3O3QyUQAJN74IOaDOmr+3So/VMjv8CZ8buA8l1mndILSMiC1bHUzDm7zPZxAv/yuUud4sStGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400129; c=relaxed/simple;
	bh=dWrjZzM7+Zt0YTgW7GK/L6qCDdBDg08xCwywqXSteRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FURz6P/o50OZ3H0qlXJ5so8k3vXV1n92BIQR8m31+6hrULMVdu+3J+8sTCYSwxTSgRS460nmeAHq+yFzwQjp7FL56s8kQRDBmBGCU0frEoXk648e5seeaxO238emuzGLNSPIR8Ahc6QW3SCfkqQsWs9bfZQT5y7qcdwv+r5bMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Sw2E2V7h; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400125; bh=h84vVaXfCxoOptU2ne+KUNJdZtOHWoyPtC3vG7/zR/U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Sw2E2V7hW/N7XWvjnNA+H3T/4cJYtZaTmydvTGCY4w1fKPFjpGgt96UyHuh9I6JTFrR4FS4IK2xBFt2DGTPnUOMfl7gV5s4yf+BySD0uYxww7CAxxWn4aUJ8alOzPy7AOi4SBpobZkYOf0Bk7zbo0bc2te7tX5gbLX+9ekbazQI7htZe2G6wTqIa5MEEz+1kTojs9jMUqcE9roMRpxaGKqZuS8yc3f6KBIS5/8B7jEH78ZuZA9R8F8dixrkHFwmglph5aYLugYk8gdJ/Fkp4MfrUGVq/8W8CFsGB3vSEI6WBhk6J0uiTCZw4VyF83uKqHJW1KTUs8cnDlhJvq0sunw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400125; bh=VlBr+N7SmmNmeTgvf0RPiRZcVjBbqoRnkm+5gTQwa9q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oyIgc2ah4sioROCeOQS/0usBHjly9hCZxicWdQuC+phJ6iFLoBlxhp7lHlabqynKmO90gMfMpE7p5uFHS3SI4bKY9L6vJE1iRwphZo3Wr53HWSdTwWV2NsyEDaYzv4B4QkJ9HSPd0NReKXR2XCD2DrRfs/gSY3JfDPdrqJKSD0OIrH4XjVS8JIHKXKjkfcJyGQBnpRPZHaLCaiud/at95vzMdv34lBd2ghK/C4fhx9oI8HCjLCenMK1ltcKkCs/K6wgjQaaABTYyLeJ+HXXj/b15km5x8y5ECS85xrguQQa7jhMc/NnipB3MQX+iOrJplj5IQiIpM06zIGhNkQPswA==
X-YMail-OSG: YLeWBGoVM1nLF4XaGXY1vRhOxZRsi2af2wrEEOzQxZb75iTKXN4Kycned76p9ez
 X3GxvY6yt.uyiMzlNgldDHBqpTtFAi4NsOXtietodJdaWhX3xnRfbrScUCCIiCkY.pwVV6z5OOM5
 Cf6O6EYERPycPJm6x8NQzLnTAjgLV1FLife3G.xhk1f6LgfLT7WcbI30qZaQrcF1q6iHYMd.fwyP
 hWFQuAGs790WaM_Mv70tqNVOjxSOGFDEBAvqOoayn51godA.R_BBqazYl4In3Gr.2AODQ9P1KtJf
 qmDUqaSOyyWDh6CRXK2ydWAETTEfnfmVPjd3uBF2ejYqvtAgV6QczelkcwMBh1o7HAPhDQ1qLtsy
 1TX.ZL97V2IR7fo.OR6AJM1NVfw4PKkEQ6oOc6lv777oGtS.whVAskEBZ11QiCWtXy2XkVCfkHh7
 dg7Zjmzjczg9Hv1jHijHexwGBQgT.UUKuIT1fclGyu0AZ5FzsGdt7UQjfyx.Ez9DChvDKunV20WJ
 z5ciwixZp8uz1g40KA0B_ZSnR7WAAdb8QVmRDAqkaWf4nru18kknxyOt_DxicdTpMJXl0A3WcFoD
 PRtkPxzbY.ozsU88ud5IFBAohflnMnVDZw9P5_08sI4ZzpZqaEoxS25jNXqTBgRuyu39V_O7mGC1
 jonsLerBy.koKOhwS69Oi7uLASZJoGmDSs4yBPVQbJTK4vguh2NtzASMQO76J_DPm_nJQQ4jaNp8
 zlOXZ0EIsQtbNP5BWJxPc.7Ag92RTEg_b1oGHQb2rc_JB9wQf1WcDxhFlu5cjYP8J9FRlby0VsMM
 UqcyVCombY1MUBHQ7fcMcKsLTovh2dWb2OngtXxhN7IxG1spCil8veMjjMg5kzxUm38tvdTWfbiI
 Gw709Mc4IrpxQh3TdOloFVdo8x8o4T2X0PyzMrEUGloi5JSDkTIS6Oa00Q4FVj3wWuVwH8iowTtd
 AwR8TCint.PqvZTzLQhqK24w3Bi8YwUeMbKTzSAP9zJJbSp9fPPTrPymZbtLqnVgCw6yTH7yfIwL
 ug2Kmn3Lt_S_49fha4vRuWlF2egVfhghluVZSRqK60B1Gox3_ca._3VHE2KIQUR6PBjJFPTESG4e
 akqfJcsFy1NCp.16q1G8p_RokI41jP0Yzp9W0NdBp8oCgfyvpzKDfG0xNBK4K07pxEcyRW0KUuxg
 6DRq.epvBnTcUM0snz2XZBRjOO6s2LQmXtv0Bol0JOq9tbY0Yyn_1w3B_wrmI.W42pjSmoAdFnbh
 9tb3RCOI5L.fpcBdzBNXVgjUhEc9TOi5YsZmfb76pidPe2av8ZU2ocRLn8Ppgx3.eDbqF._Y_bSI
 UWNtogKve9.9KIjRCjSJisLDTCWAyIdzuIMwgFgY7HXiRGHrWxY6EsATZbwh.rg9yIANLNfKdYWw
 R0XdIEbnYJuthcnwxupMm1iWk7qYQA7q06V6G.Yni_sV9u0Re5EYX3F4zDHJleJ_UFaId0NsxRex
 _v08Y104O.4G7zAXynVRI.IHTil__szluT0xMwSMly1cExviQIo.6MUWAL2mjvPHvamsTJQW.5O0
 4TMlfr6Nnx_1a.TJOsrJrhoYmhgwthWlcpFVtGg9eKq0V1N0EW85lY8CW3BFIOTdtA5WX_u.FTWP
 90Z7B8yVXXUqd3EFarZDcMglC55eUyrFLk5BpzH6jGhkqVKuIGGIuGKW5XmiEkdiB28Deil_xycF
 u25BveG8UDA1iOX_jyq36aFetMObZ0318_8sj_r72WfpcS6bA6wGHtk4a7EM4vRhXEyRjtiZ89KH
 Ez5ax0h1RY3yG6q89oYXaHoper2qKNb71xgyC6Gm27bWUhmyluQd5dkgLSvrIOCz4KoU1YWbGlyZ
 7NKtP8xwV3wSqahx0oejpv9Y3y8eeXtpaTusgmPqEeqSZ3UJsRZ4E7xFRCkIsVdJ9tsD6E07xKkp
 5J.0mpPbN9SjzH7xRkygRxa__57Wp1cF8hcZuc8Xr_tPjU2Mu1rxyG5FMWUfI.rkSL1mvKX0SYjU
 J6UTX0LexhYyW40cn1JWbEPJLLVrKi62wn5USsiRUqKQ38.IhK9mboFv5qqdSGsJ7rr90eTF3mVi
 NPbEfrnG6AS9VL9V2du.l_YKIBW_bO0lqhnMPSUbYC96Ctsgv0ZSzL1NShPTRqc7vLrwOGLxLju5
 piMl2M7qYHpIltwipO1limq9xzSu5xaLFV7e3I1V7357SLA.f.h7ZUwwF3HhBDzC18SzU9cQJDEj
 78Pr92GNXUoSSl.UO4EbUJhsdlWphdIMiuABJfvuaBptCOfQBqk0fFvkDyraoADRJ7LSNa0_DOxL
 OXu8dvfZGvOmGJ2rOQWBdT22lyQodSOVi5hECSK7W
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ad25b1cf-194e-456a-a97f-a1ba7068714e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:35:25 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bb5b3b3aaeaca0508c460696a0f44663;
          Thu, 24 Jul 2025 23:35:20 +0000 (UTC)
Message-ID: <eeb65a54-75fc-46c6-85b3-a1f572c419c0@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:35:18 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 23/34] lsm: introduce an initcall mechanism into
 the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-59-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-59-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Currently the individual LSMs register their own initcalls, and while
> this should be harmless, it can be wasteful in the case where a LSM
> is disabled at boot as the initcall will still be executed.  This
> patch introduces support for managing the initcalls in the LSM
> framework, and future patches will convert the existing LSMs over to
> this new mechanism.
>
> Only initcall types which are used by the current in-tree LSMs are
> supported, additional initcall types can easily be added in the future
> if needed.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/lsm_hooks.h | 33 ++++++++++++---
>  security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a7ecb0791a0f..0d2c2a017ffc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -148,13 +148,36 @@ enum lsm_order {
>  	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
>  };
>  
> +/**
> + * struct lsm_info - Define an individual LSM for the LSM framework.
> + * @id: LSM name/ID info
> + * @order: ordering with respect to other LSMs, optional
> + * @flags: descriptive flags, optional
> + * @blobs: LSM blob sharing, optional
> + * @enabled: controlled by CONFIG_LSM, optional
> + * @init: LSM specific initialization routine
> + * @initcall_pure: LSM callback for initcall_pure() setup, optional
> + * @initcall_early: LSM callback for early_initcall setup, optional
> + * @initcall_core: LSM callback for core_initcall() setup, optional
> + * @initcall_subsys: LSM callback for subsys_initcall() setup, optional
> + * @initcall_fs: LSM callback for fs_initcall setup, optional
> + * @nitcall_device: LSM callback for device_initcall() setup, optional
> + * @initcall_late: LSM callback for late_initcall() setup, optional
> + */
>  struct lsm_info {
>  	const struct lsm_id *id;
> -	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
> -	unsigned long flags;	/* Optional: flags describing LSM */
> -	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> -	int (*init)(void);	/* Required. */
> -	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
> +	enum lsm_order order;
> +	unsigned long flags;
> +	struct lsm_blob_sizes *blobs;
> +	int *enabled;
> +	int (*init)(void);
> +	int (*initcall_pure)(void);
> +	int (*initcall_early)(void);
> +	int (*initcall_core)(void);
> +	int (*initcall_subsys)(void);
> +	int (*initcall_fs)(void);
> +	int (*initcall_device)(void);
> +	int (*initcall_late)(void);
>  };
>  
>  #define DEFINE_LSM(lsm)							\
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index ada9b5448409..ab739f9c2244 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -39,6 +39,27 @@ static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  	for ((iter) = __start_early_lsm_info;				\
>  	     (iter) < __end_early_lsm_info; (iter)++)
>  
> +#define lsm_initcall(level)						\
> +	({								\
> +		int _r, _rc = 0;					\
> +		struct lsm_info **_lp, *_l;				\
> +		lsm_order_for_each(_lp) {				\
> +			_l = *_lp;					\
> +			if (!_l->initcall_##level)			\
> +				continue;				\
> +			lsm_pr_dbg("running %s %s initcall",		\
> +				   _l->id->name, #level);		\
> +			_r = _l->initcall_##level();			\
> +			if (_r) {					\
> +				pr_warn("failed LSM %s %s initcall with errno %d\n", \
> +					_l->id->name, #level, _r);	\
> +				if (!_rc)				\
> +					_rc = _r;			\
> +			}						\
> +		}							\
> +		_rc;							\
> +	})
> +
>  /**
>   * lsm_choose_security - Legacy "major" LSM selection
>   * @str: kernel command line parameter
> @@ -455,3 +476,71 @@ int __init security_init(void)
>  
>  	return 0;
>  }
> +
> +/**
> + * security_initcall_pure - Run the LSM pure initcalls
> + */
> +static int __init security_initcall_pure(void)
> +{
> +	return lsm_initcall(pure);
> +}
> +pure_initcall(security_initcall_pure);
> +
> +/**
> + * security_initcall_early - Run the LSM early initcalls
> + */
> +static int __init security_initcall_early(void)
> +{
> +	return lsm_initcall(early);
> +}
> +early_initcall(security_initcall_early);
> +
> +/**
> + * security_initcall_core - Run the LSM core initcalls
> + */
> +static int __init security_initcall_core(void)
> +{
> +	return lsm_initcall(core);
> +}
> +core_initcall(security_initcall_core);
> +
> +/**
> + * security_initcall_subsys - Run the LSM subsys initcalls
> + */
> +static int __init security_initcall_subsys(void)
> +{
> +	return lsm_initcall(subsys);
> +}
> +subsys_initcall(security_initcall_subsys);
> +
> +/**
> + * security_initcall_fs - Run the LSM fs initcalls
> + */
> +static int __init security_initcall_fs(void)
> +{
> +	return lsm_initcall(fs);
> +}
> +fs_initcall(security_initcall_fs);
> +
> +/**
> + * security_initcall_device - Run the LSM device initcalls
> + */
> +static int __init security_initcall_device(void)
> +{
> +	return lsm_initcall(device);
> +}
> +device_initcall(security_initcall_device);
> +
> +/**
> + * security_initcall_late - Run the LSM late initcalls
> + */
> +static int __init security_initcall_late(void)
> +{
> +	int rc;
> +
> +	rc = lsm_initcall(late);
> +	lsm_pr_dbg("all enabled LSMs fully activated\n");
> +
> +	return rc;
> +}
> +late_initcall(security_initcall_late);

