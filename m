Return-Path: <linux-integrity+bounces-6710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D18B10EBE
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06007AEAC0
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2842E9722;
	Thu, 24 Jul 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ys2hsk7a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE2264A74
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371029; cv=none; b=t1B9lSI6ApRLd4uk0NY744BZoKJ7B5wRItHTVfGqk8oc7E3tq90XkMks+J/RdoT1prSZvneh1CvhvuThCzyGur7LpW7KohNLqwi1b0uhPDadWCXyZ9HuKGF+6KcSdfun5DxMP75+vpHilvA/8yEjYxbFifFlNFvoJKk0kFPMGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371029; c=relaxed/simple;
	bh=x9UdV4oSNneLirwwu3QJwhpni8ZsTu7ctrrSOY9amQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSsL61G1tawfZ95CyPLQPlq+MbZ8EUkZM6KauLcQrY08JFr5oRJ4+m2nT3PZ4A235EtrV+4FzKL59u1DJgUfb7dMyBGfZJRLAThQTSYZibBfWzR1fDurpYvlR3KjmeitVNWYcXsF7c3m/vADYTuxr6my/xYLJEwvIW4c5su92aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ys2hsk7a; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371027; bh=9uqXxwgH5e47xnWS4vdhwxlwHO2vkiLMD0xYo5UWv7E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ys2hsk7aTLsqIcnD/JHeZ+rEv6FX5mfzF/t+J65O2SpWBAh3f1uku3GRLdNTvAxwj+XV+q0p8YNUvCsl68echDSRYbpnIvmg0b63buJDeW0u5tufrobSnMDrWvbvF8pm0uqldAG4hyB4MC9mfPkZ2K7VVCP+bpKYblGDTuTh0YjJ1Dxo4OHYtqFBAm9F6qQ232lVfFU5WzoF3/A1quFLeotQNTsVm+urVPdvlGfFtOyg68LG+kl4NrEFYPdITzbjexWLd4mGMmIfQQvaAn6NCadJjjHnSRGXM1qnXT/ugaBNHms0gQhLnwovd2WHSz6ZaE5wT/qiXVnf19pJ8VgCZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371027; bh=ml6LU2ZYjH/SU9XZNPYaaFWYEZm7PkobVo8NOUZhQVd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F4vK5FnfqZ2h4hkWf2flQPBtf3Dxw72L4gQA1VYzj5FoMykU4H6yHJxz4WhAaQWoOLGycInMmRxidsN/zwmE2lCfuuG3Y5EW/cE/GhuIx99R5V5kfHg0PxshOlP3gU9OA/vzD40oVfL70gfCOnGHlaxlJChk8Ac989qQZ10Z4CL3wkq5tPmtzNDwyTQ4w4+Xg0otAidmGyP73/kRq8X2cgWJYVpyRuXC5HAm5Wq++M5P5UGnISLGGhrcgY0yoZR96dFRalW8875JXzuL+lSV5eurCQ59Hjcccg0N5QPpFM2yPzTKFSGc698WRZ4jf5MSaVKvFaxdg8FCpMeAbDvOlA==
X-YMail-OSG: 8CCh2e0VM1nm2oZGG7YYQKHxKYy8x1hGixt_NQYjO6D8e.8MP1GaLUAua1qZDbT
 VvyTmGW5mvAa96ryct3pqcvSVnHi4OB3vxDhNhVFpiU_SnLbxCNyeNOhFGnKOmqaVHDXqGXqTQqw
 l5edBWJ9D_6PhCcvshSyuudXNuj9dsnAorkn7T8tZH5olYJksvAD0felPs4kEDMcKJlr3Fpg3kV2
 i0O6UZoroja6GjS9cJvgv.xjdgggdo8fOtPZRD6dv1L5wl.S0n_EOehnWNrPX.7kJkfWUxPK207h
 uzxbYjZ51NOn3yCrwWs1Ly.ScqQ7lvcg_pp5e_5_BC1hnl6cld1HD_dsIVf4UZv8uk3oE.fkWdVc
 dJN8CACUrQaTmrmk8eZduzwUqdxqKegP4483nGb4AeriALsnrNg3fyQxHol8B0ag.22cknUsD.EB
 LBNqfUzHT3a4RvAN.H6KxB6emFiMoSxXl139u4_PTbP5tEYKVQELgijU.SLex9J_AEFfNLtCCRlj
 7YKF6RvupGMTAQRZp6TiltaGHJlUiumNc2jTMHHesj8GBtRjO2Umf9u9eQloGNMGywMtPIoKAD8P
 BtSxbB9ZNxT7yJwoEETaTRoLIO6zdqgxOCxMDBnxFSTdTswsiPYmQGFM8YGCHX7KEYD2JtYMIV4k
 48kglI9GLyytH2s0j0EhJcP6Gib_FxFeDhwfKEtA4h5w_K7nc..nzJFGaumI326JOouApfw.thqd
 Jo7ttPhps7YVW0MQojKkWu8VlVLJp75LYCATSU1DjA4NiWYuYz63pP3W2H7x8S9ql1EOM.wHXCWa
 dPU2JZMZ58PGlV_0i5hBieUi2QcPVl378b4r33Gc51CRXvGduKdb4yQfrqY3uc6SONqZCoFwJZPd
 orFU4c3aNpN41ouxFD36lnBBTVkC0T7Ztujfmh1fMAuV5Bpg0zpu7qEWa8v_aYTlU9e7Hu7AZjCb
 JpBWYKXhBdXVY5UltRn2NQL5My5.ML31tECXPrqmqQZly.fP.5B3R_Xk6aA5FmwYK3Zognp9DcYf
 GoxNuLGSSSxodkVgywV_aQlsXaq.9PGHazjpcjLh8IM2VL2g077jrV7epFXD7omXx3y6Mmv7x1aV
 q8CmMZUsUq2.6cs8GMIyx9FpJ7Sfh_3J8LQwMxJnBbtuwM2BNr1OLSI95hR8cPFsr4uYwGCMpruS
 UxvoPO0V3dL6HmwJiNfSQIw0x_ED6fMD_uVEzd3SAK00k3PJdFyvXMRtcxcgwQRQwuVb8IplbmvI
 eMqNJyglDWJb4_Y_E_NpuKeYLM.I0e6iEfr.jrxqih9.xKUVXDPiALqtuzH2zQqYPAlVKPjbbEkx
 sBmH6FoQkXGEWAkl0RU3OC5nAGNxG4DJW5GhogcnoIYYY0YGg1Vgrt78A115JOf4WwTFhns0dO.Z
 xC7779CPugWtozCJCerJkhjMwf.3OyFbGKmaTN62rOOuXe7Tm2MPCexhHbXoZN7L8VDvQNfxC5s9
 or6Fd_Q.m2VKzdOsxxsBD0PRHmbfnzeoSSSUTIllWhe1MB_uiiFmEpvjXFoaY_floYthUvciyXK7
 MKDyH8q2ARgIP3R6nLwr6pls47dgrWR9Th.YNZvnuepg5pf7kYCBuUdiUfQhWhWrq0D1IPREGOa1
 ZhqvPyfUIHh9iFkRfPQ6kR5waObe29z9O3kFy6I497QB9aU.bOLxlle7BNiNzTRPQBwX5IQj1IlW
 .3cCy91ikNw0wwSa2pMZZN_ZCo5770YrMSz9bY7vUOmFoFsfUpXV9SX...aJafFiEs9.6LHeTYAM
 lbJi0KTGTEl8oDnghk20K3AAtwCA.I36jR50IGsYpjezIKYmLKzrDRLJ.VJjD.sfMGXApYknzBj2
 HwMODdFmgMmyJr1MqlpGASbDCDzQnkXCaYrkzKdu0v_Qo768ifhG7ZKp5RdrCAYvbSHTwUvepVo0
 S6SGDpFkaT0Q4VnViDNjK60Y64FosFrkJ0BkoKAzYtvuXNGqHCu8he.4fPmunw8dV_IwCY5R9StD
 SVwrOF3x6mFNP3G1seFhN0AcNfs5p.emoOtPO3i8Bk5yjL6RTv_VtsWvBV8XwGzIR03YqCyigqKq
 ku42mlIHaC1TsTB734q5UmIB0xVMbCMAP_7LVweNg.cYr2pZSMRT7P0Nd5jzl8YTDIuCESnYBEsV
 Rgl3z6nJEwX6Ssjt81nlav3q2DVeuTB9EvUnvpMMnZGIXBiKrcROetaQlcoF1iAb89dB9g3c.Wbo
 WtGsxlpOSdd7a7SfAiUiXvMjvlV3JO.IxQfnPWAc7MXCqTVDEn8X064oYSyOOqzSn74upd9jtww4
 cD5vXLZphiUJQstVF0TZsywTJp_TiyaKBri6ix9g-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b60a97f1-b8be-4337-b828-1c986eed81f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:30:27 +0000
Received: by hermes--production-gq1-74d64bb7d7-lwch7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef04c1b6feb17243845c823b57640189;
          Thu, 24 Jul 2025 15:30:23 +0000 (UTC)
Message-ID: <ce88d6df-aa9c-4c07-97b5-7017fe2f422d@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:30:21 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/34] lsm: replace the name field with a pointer
 to the lsm_id struct
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
 <20250721232142.77224-44-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-44-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
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
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Significant improvement.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/lsm_hooks.h         |  2 +-
>  security/apparmor/lsm.c           |  2 +-
>  security/bpf/hooks.c              |  2 +-
>  security/commoncap.c              |  2 +-
>  security/integrity/evm/evm_main.c |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/ipe.c                |  2 +-
>  security/landlock/setup.c         |  2 +-
>  security/loadpin/loadpin.c        |  2 +-
>  security/lockdown/lockdown.c      |  2 +-
>  security/lsm_init.c               | 45 +++++++++++++------------------
>  security/safesetid/lsm.c          |  2 +-
>  security/selinux/hooks.c          |  2 +-
>  security/smack/smack_lsm.c        |  2 +-
>  security/tomoyo/tomoyo.c          |  2 +-
>  security/yama/yama_lsm.c          |  2 +-
>  16 files changed, 33 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index eeb4bfd60b79..4cd17c9a229f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -149,7 +149,7 @@ enum lsm_order {
>  };
>  
>  struct lsm_info {
> -	const char *name;	/* Required. */
> +	const struct lsm_id *id;
>  	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
>  	unsigned long flags;	/* Optional: flags describing LSM */
>  	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9b6c2f157f83..a7f6a3274682 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2272,7 +2272,7 @@ static int __init apparmor_init(void)
>  }
>  
>  DEFINE_LSM(apparmor) = {
> -	.name = "apparmor",
> +	.id = &apparmor_lsmid,
>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.enabled = &apparmor_enabled,
>  	.blobs = &apparmor_blob_sizes,
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index db759025abe1..40efde233f3a 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -33,7 +33,7 @@ struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
>  };
>  
>  DEFINE_LSM(bpf) = {
> -	.name = "bpf",
> +	.id = &bpf_lsmid,
>  	.init = bpf_lsm_init,
>  	.blobs = &bpf_lsm_blob_sizes
>  };
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 28d4248bf001..e04aa4f50eaf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1509,7 +1509,7 @@ static int __init capability_init(void)
>  }
>  
>  DEFINE_LSM(capability) = {
> -	.name = "capability",
> +	.id = &capability_lsmid,
>  	.order = LSM_ORDER_FIRST,
>  	.init = capability_init,
>  };
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 0add782e73ba..db8e324ed4e6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1175,7 +1175,7 @@ struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
>  };
>  
>  DEFINE_LSM(evm) = {
> -	.name = "evm",
> +	.id = &evm_lsmid,
>  	.init = init_evm_lsm,
>  	.order = LSM_ORDER_LAST,
>  	.blobs = &evm_blob_sizes,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f99ab1a3b0f0..ded971bdeaae 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1253,7 +1253,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
>  };
>  
>  DEFINE_LSM(ima) = {
> -	.name = "ima",
> +	.id = &ima_lsmid,
>  	.init = init_ima_lsm,
>  	.order = LSM_ORDER_LAST,
>  	.blobs = &ima_blob_sizes,
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 4317134cb0da..2426441181dc 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -92,7 +92,7 @@ static int __init ipe_init(void)
>  }
>  
>  DEFINE_LSM(ipe) = {
> -	.name = "ipe",
> +	.id = &ipe_lsmid,
>  	.init = ipe_init,
>  	.blobs = &ipe_blobs,
>  };
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index bd53c7a56ab9..47dac1736f10 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -75,7 +75,7 @@ static int __init landlock_init(void)
>  }
>  
>  DEFINE_LSM(LANDLOCK_NAME) = {
> -	.name = LANDLOCK_NAME,
> +	.id = &landlock_lsmid,
>  	.init = landlock_init,
>  	.blobs = &landlock_blob_sizes,
>  };
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 68252452b66c..b9ddf05c5c16 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -271,7 +271,7 @@ static int __init loadpin_init(void)
>  }
>  
>  DEFINE_LSM(loadpin) = {
> -	.name = "loadpin",
> +	.id = &loadpin_lsmid,
>  	.init = loadpin_init,
>  };
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..4813f168ff93 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -168,6 +168,6 @@ DEFINE_EARLY_LSM(lockdown) = {
>  #else
>  DEFINE_LSM(lockdown) = {
>  #endif
> -	.name = "lockdown",
> +	.id = &lockdown_lsmid,
>  	.init = lockdown_lsm_init,
>  };
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index c8af26a6ce14..96d51e4d625b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -127,9 +127,10 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  	/* Enable this LSM, if it is not already set. */
>  	if (!lsm->enabled)
>  		lsm->enabled = &lsm_enabled_true;
> -	ordered_lsms[last_lsm++] = lsm;
> +	ordered_lsms[last_lsm] = lsm;
> +	lsm_idlist[last_lsm++] = lsm->id;
>  
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
>  		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
> @@ -157,7 +158,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  		set_enabled(lsm, false);
>  		return;
>  	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> +		init_debug("exclusive disabled: %s\n", lsm->id->name);
>  		set_enabled(lsm, false);
>  		return;
>  	}
> @@ -165,7 +166,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	/* Mark the LSM as enabled. */
>  	set_enabled(lsm, true);
>  	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>  		exclusive = lsm;
>  	}
>  
> @@ -197,9 +198,9 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>  	if (is_enabled(lsm)) {
>  		int ret;
>  
> -		init_debug("initializing %s\n", lsm->name);
> +		init_debug("initializing %s\n", lsm->id->name);
>  		ret = lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>  	}
>  }
>  
> @@ -233,10 +234,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		 */
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->name, chosen_major_lsm) != 0) {
> +			    strcmp(major->id->name, chosen_major_lsm) != 0) {
>  				set_enabled(major, false);
>  				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   chosen_major_lsm, major->name);
> +					   chosen_major_lsm, major->id->name);
>  			}
>  		}
>  	}
> @@ -248,7 +249,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		bool found = false;
>  
>  		lsm_for_each_raw(lsm) {
> -			if (strcmp(lsm->name, name) == 0) {
> +			if (strcmp(lsm->id->name, name) == 0) {
>  				if (lsm->order == LSM_ORDER_MUTABLE)
>  					append_ordered_lsm(lsm, origin);
>  				found = true;
> @@ -265,7 +266,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
> -			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> +			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
>  				append_ordered_lsm(lsm, "security=");
>  		}
>  	}
> @@ -282,7 +283,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  			continue;
>  		set_enabled(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->name);
> +			   origin, lsm->id->name);
>  	}
>  
>  	kfree(sep);
> @@ -314,11 +315,13 @@ static void __init lsm_init_ordered(void)
>  	pr_info("initializing lsm=");
>  	lsm_early_for_each_raw(early) {
>  		if (is_enabled(early))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> +			pr_cont("%s%s",
> +				first++ == 0 ? "" : ",", early->id->name);
>  	}
>  	lsm_order_for_each(lsm) {
>  		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +			pr_cont("%s%s",
> +				first++ == 0 ? "" : ",", (*lsm)->id->name);
>  	}
>  	pr_cont("\n");
>  
> @@ -426,18 +429,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  {
>  	int i;
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
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
>  		lsm_static_call_init(&hooks[i]);
> @@ -485,10 +476,10 @@ int __init security_init(void)
>  	 * available
>  	 */
>  	lsm_early_for_each_raw(lsm) {
> -		init_debug("  early started: %s (%s)\n", lsm->name,
> +		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)
> -			lsm_append(lsm->name, &lsm_names);
> +			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 1ba564f097f5..9a7c68d4e642 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -287,6 +287,6 @@ static int __init safesetid_security_init(void)
>  }
>  
>  DEFINE_LSM(safesetid_security_init) = {
> +	.id = &safesetid_lsmid,
>  	.init = safesetid_security_init,
> -	.name = "safesetid",
>  };
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 595ceb314aeb..d7ec6bc6168b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7640,7 +7640,7 @@ void selinux_complete_init(void)
>  /* SELinux requires early initialization in order to label
>     all processes and objects when they are created. */
>  DEFINE_LSM(selinux) = {
> -	.name = "selinux",
> +	.id = &selinux_lsmid,
>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.enabled = &selinux_enabled_boot,
>  	.blobs = &selinux_blob_sizes,
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fc340a6f0dde..e09490c75f59 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5275,7 +5275,7 @@ static __init int smack_init(void)
>   * all processes and objects when they are created.
>   */
>  DEFINE_LSM(smack) = {
> -	.name = "smack",
> +	.id = &smack_lsmid,
>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.blobs = &smack_blob_sizes,
>  	.init = smack_init,
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index d6ebcd9db80a..ed0f7b052a85 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -612,7 +612,7 @@ static int __init tomoyo_init(void)
>  }
>  
>  DEFINE_LSM(tomoyo) = {
> -	.name = "tomoyo",
> +	.id = &tomoyo_lsmid,
>  	.enabled = &tomoyo_enabled,
>  	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.blobs = &tomoyo_blob_sizes,
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 3d064dd4e03f..38b21ee0c560 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -476,6 +476,6 @@ static int __init yama_init(void)
>  }
>  
>  DEFINE_LSM(yama) = {
> -	.name = "yama",
> +	.id = &yama_lsmid,
>  	.init = yama_init,
>  };

