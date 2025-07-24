Return-Path: <linux-integrity+bounces-6711-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D4B10EC5
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319D6AE7221
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CF2EA479;
	Thu, 24 Jul 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZXgcK8/T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8142E9722
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371081; cv=none; b=MWEnZ3JroyaOXclshnFhBnDX7TITjab7GDwTzmbMy7h0bSiSLZNXOwd+SexuU8fJ+D/p3KgnfX7LsE96F2JP7Enjd9VzJcAkeDH+Jrcbh+eUDot/SqbsazHWuzI/aR8B3qTV7QwsmPB4ou6GU5kdcog9cBztwmbzGZB3C3/Cpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371081; c=relaxed/simple;
	bh=pKJvtlCwG7IGuFy7M3oz3mCpDWdhcbRFeBCEBEywj3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKsz9kuF0WePyZqzoRyso/V7BYA/mwgmIelhiSst1Geq4SWaZyCDYsqHqoP9oYKcJDj1Ov4njrci8D6UL1y9jKjmbxiZq1ic0rdBkW7BnQbjZ3FlEKdsh7st6J76YX+o4wtyBnpEQLpNQsuZzB36f2yUG9SQPyqfrPGjJ17dTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZXgcK8/T; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371079; bh=cPCUIk0mPTvpY7bjm8l6e5yLwIOp5oWkQDiIW50DBi0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZXgcK8/T2tBV9Edy7zsjrWMzzErPOo1oiEyNYrAIKlLVWlDreidVetaZqOWvLAjsKwpcuOprGd0KemBctTNtUe7B1MXyPUw8Lbi17eLd/8z2B3iiDVMODEMATwVwU6x289Cc0Qz7wyEpg1V1hBbMmxWWDdTZbJ1lRvXMqKqrVd308cjScOUcUNy0IZRcTcWHBSJZQPjwzKenauo41JaTjKiU5JA7D4VJ3jxq52q+mZT+xFHsQUv+ppiFkSrKyHrYLitnPxmoNq2kYTEzdRhwy3NTjGMvlPb1+aHisbDwfciPA9EeFxHH63STFVEhE+svmHTkUUI/ELHQAdsZZjmWSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371079; bh=mYN1weGsKOJhrBIEjvgSh8TfoCQ04ISM1WhR/C1IgW+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PxaQ9yYWl796xz8Gjs5xix0eTIu36zyRupa1OMG5pCtFArdkiyPmEvlYDnDqW0M3FkvgozX3TkuMRp7faA23ADxUWN+uwm8y5tncuM6frXVToLsayOZgWietDqNRPS2hcRylrrU6CcMqhrdkBbRJxwlyVCzIM098kFXKsvXzJMLjdUGe06Ti3g0DRqyZivWg6hvKDP15r3Tjl4u0B+o6Vhe2BleJNVFWpFkhIZ++FcMUVSSQZl4h8MY5qYODmWMfIENv/+YaXWSxac685/NWBa9Fz2wd0AqIAWl3XbY7K3L6JhVRLYYVs3saN/ZE5S4nlwfVXmKqtA24ti1ANl3VLQ==
X-YMail-OSG: 0jwKjLMVM1nd8PNN0ADQAPUVLACKYPhSAkobCH4XF8BPgf8JmPQ0tbWkvr_7Cwy
 sDtsFLtpLmtafZsSxJ8iFw5tCA0Ocwlrld0lx95hUe4j6SXGc6WkMPbJqBoc5lTJVVuefo6DBLv6
 k_Rei9taeE3QBS9rJni1LpTt_hhPEK4G4JCmPfFoRo_hsHhoevDL5K3kDZCQM49jRFCJ1LALOmci
 2DWWMemK_mq9thtLbk1a1TDFgxm3_f_FQ6nWH2ptJkdGhSLwP34a3gVbLL5nbaSFHjpe2_Awz1yd
 Rd8QeT4nW4Gyn5VcliFKtLvAccctrECZb0GzyMg5Ssq3mjFt65gPMeAHL01nk7X_nEsyDTndD4qJ
 zKjT3onfJJaIRdGvo2uIJv24vjKqZcvgaj96l.drFl8Ux6Lkd7Uqhmz0.ISN.jkYmi..xe4O0fzB
 ETheJPbjE1bFf8dk_sRhuvLA_TfMJ.eElh8zCcccrC6pVn4Ic4q2s85Z4PBsqBfJCYpqvbNwRHGm
 fbPTVgBPibiTZBX.UHBRbFsW0D86oMkbkO42bETfsE8et6muu8NVDF8veqnQqAE1rE5qC9eViHXp
 yAYhacdYsgehTD4hoeeNwjYD8x7gDIa8QK0hbYZQV9GaFQpG78Pw1NyQuaMsbj2oaYHUQsq4VJ88
 IHbigljwvYo7f9DzCbJFnkO_WjN8mztDtMWGLaIToR06qePnbeWSbP4kuYCJRK.BoReHA2TlH9nI
 QPRkEcX7L_dklQ7GC5qI71O1DaQkVsrMD8puepK2lRh245igovOAA27tTtLYVoHOD4cKPOnMnMU3
 vIv09vkD_wTr4CHvXyuRMu1GTcuQ_lg.2hJOAUXUDPCgUpxbT9T_NwqXGxx0fPTwadYnPrXGkwt1
 11yUmrCRXvP3R9GQzq8_OOkj3hNODh0Y1K1FK8eiKB20MXw5ps2UnFEOeWmKwQcumFFaYjfcoXmS
 vwzMr0TLpLNEyfSepyHH37fKkjwfQHAer75YVnHhd8mEhmPXt2Uv4WsuRJ2J0HUTzskylji8zmut
 0ohnexq5OIfcS7aaUV6x2jqgmpP3Dp_hnXbN1mBcLZXHPZAhUkpH8P1VYGfFHZRhBTZlZW1OTk2p
 G7PQbntkrI11EAndtOwitYT3sG_0aMhcE5lHXwb7o5W23ySU0wka0MUS7Uu.7n3ViqYJJXOb_9HL
 dTHOKa7qlQBIblJ0KbhQcfNcTsnjfn.8WO7cPeGcHppola4MOcU1Cy5qLI00uOxYlEtnwKUawgSC
 .jYwuFT2d1XPHClPrGh8HBvqv2YMYIUeXmGXpQKl4oE8dtkf0dk3aFXFUAdG8zHgKz8yE6oO0EY7
 3EXQbrIQHnDCTR2yZQBw7xBta.i__o5tFMFK2k8QgwORZ2kHdoeZ7rrhQPGSFS6KpNni.u.bklfa
 Y4LTxVY5nmbL8js7.0L52OcdswKYabxAjN_VT5uHpb62h2A3DnrFDmxrpIIJrGVMC501nurxuIBi
 YmkLKmKtbZeoQY82.82H.pR_FBBTuXv6S9LS6869jPrWwu2mNAKIPJtUXiatbV1uJGHKDtVtRiqA
 Hn81hsMRH7JJHlN0WeNdMKjJtjHcHeHDpPyPJFhUjpXq4ygnXcJxIC3y9cg3zbRojyIXb6fNZlT0
 Pox0590DfTHhT4SMyvCjVV2w8DbFw.Kld58afMAocYC3Q9F98_DljulIVjPX3cbnQscX338HxI7f
 H0o2F1fT9MehAc0WfVXCKn_G6MPIvnEhDCOXKoOc0d_bDecqjabqP98wz_DL7_6s3A99mJBQ4wM8
 gzm1uXqhL.vdJrfeLy6Rnnj8MdAO90a9e0.Q_jF5cFMXC9PdXyxk0dmpNV4C3wF9TKchM.L_I4mi
 UXlURKFakUYI5JyP3lRFTGuZeY6saRwbSSzo5fAiUQGovWaB6ogAC9SWwyb2sMYMtA9Sw7AdgfV_
 N4s9_iwLyW_xtjbY_uhbhBBabrSp_D60sMvdQ8LzNPwL4Lt8No7C2pyJ103I9WGZqXJHkKIYPMDD
 DY9yEpqqBdjoKwK7w5Kg1MbEdujeQf4rvFBWMNOsZtk9JEUegC92QhOJEeitTXo_gMqS9uSoGhiy
 yluD_j7GVnJ8Q9z_CQrYQLOGfsB_2MClcrF4Puqa6OqoSnC0lteqaY_1WfP3xD_lO_8l.ng4fs2S
 sWHzyyJXBEHUQ_Hw_omdw5nTzjTdMXdUFvm4MEEAlhQ91PeQLU3yrlXPt_69_9yNPEZJRyr2e1aq
 BDoymtMLnLTjRy7qHz0sNtlYEE1LVksUaO1S_nwskdaLKo9ZeFFKVzpa5m12pdbQBskGeJBZZCzl
 ka1N5UtbUiXJnSyZFZNSXlDd8i1hf9ts41mBA1gyh
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b55a08ed-340a-484f-a676-4ffb73dc5034
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:31:19 +0000
Received: by hermes--production-gq1-74d64bb7d7-x7xzm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5e5fbbea7957b96cd0a94b4ace4de093;
          Thu, 24 Jul 2025 15:31:15 +0000 (UTC)
Message-ID: <00814552-6d2e-48e2-a00d-981c7f8dfff6@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:31:12 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/34] lsm: rename the lsm order variables for
 consistency
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
 <20250721232142.77224-45-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-45-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Rename the builtin_lsm_order variable to lsm_order_builtin,
> chosen_lsm_order to lsm_order_cmdline, chosen_major_lsm to
> lsm_order_legacy, ordered_lsms[] to lsm_order[], and exclusive
> to lsm_exclusive.
>
> This patch also renames the associated kernel command line parsing
> functions and adds some basic function comment blocks.  The parsing
> function choose_major_lsm() was renamed to lsm_choose_security(),
> choose_lsm_order() to lsm_choose_lsm(), and enable_debug() to
> lsm_debug_enable().
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 96d51e4d625b..cbdfac31ede4 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -16,14 +16,14 @@ char *lsm_names;
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
> -/* Boot-time LSM user choice */
> -static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
> -static __initdata const char *chosen_lsm_order;
> -static __initdata const char *chosen_major_lsm;
> +/* Build and boot-time LSM ordering. */
> +static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
> +static __initdata const char *lsm_order_cmdline;
> +static __initdata const char *lsm_order_legacy;
>  
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> -static __initdata struct lsm_info *exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> +static __initdata struct lsm_info *lsm_exclusive;
>  
>  static __initdata bool debug;
>  #define init_debug(...)							\
> @@ -33,7 +33,7 @@ static __initdata bool debug;
>  	} while (0)
>  
>  #define lsm_order_for_each(iter)					\
> -	for ((iter) = ordered_lsms; *(iter); (iter)++)
> +	for ((iter) = lsm_order; *(iter); (iter)++)
>  #define lsm_for_each_raw(iter)						\
>  	for ((iter) = __start_lsm_info;					\
>  	     (iter) < __end_lsm_info; (iter)++)
> @@ -41,31 +41,41 @@ static __initdata bool debug;
>  	for ((iter) = __start_early_lsm_info;				\
>  	     (iter) < __end_early_lsm_info; (iter)++)
>  
> -static int lsm_append(const char *new, char **result);
> -
> -/* Save user chosen LSM */
> -static int __init choose_major_lsm(char *str)
> +/**
> + * lsm_choose_security - Legacy "major" LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_security(char *str)
>  {
> -	chosen_major_lsm = str;
> +	lsm_order_legacy = str;
>  	return 1;
>  }
> -__setup("security=", choose_major_lsm);
> +__setup("security=", lsm_choose_security);
>  
> -/* Explicitly choose LSM initialization order. */
> -static int __init choose_lsm_order(char *str)
> +/**
> + * lsm_choose_lsm - Modern LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_lsm(char *str)
>  {
> -	chosen_lsm_order = str;
> +	lsm_order_cmdline = str;
>  	return 1;
>  }
> -__setup("lsm=", choose_lsm_order);
> +__setup("lsm=", lsm_choose_lsm);
>  
> -/* Enable LSM order debugging. */
> -static int __init enable_debug(char *str)
> +/**
> + * lsm_debug_enable - Enable LSM framework debugging
> + * @str: kernel command line parameter
> + *
> + * Currently we only provide debug info during LSM initialization, but we may
> + * want to expand this in the future.
> + */
> +static int __init lsm_debug_enable(char *str)
>  {
>  	debug = true;
>  	return 1;
>  }
> -__setup("lsm.debug", enable_debug);
> +__setup("lsm.debug", lsm_debug_enable);
>  
>  /* Mark an LSM's enabled flag. */
>  static int lsm_enabled_true __initdata = 1;
> @@ -127,7 +137,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  	/* Enable this LSM, if it is not already set. */
>  	if (!lsm->enabled)
>  		lsm->enabled = &lsm_enabled_true;
> -	ordered_lsms[last_lsm] = lsm;
> +	lsm_order[last_lsm] = lsm;
>  	lsm_idlist[last_lsm++] = lsm->id;
>  
>  	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> @@ -157,7 +167,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	if (!is_enabled(lsm)) {
>  		set_enabled(lsm, false);
>  		return;
> -	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>  		init_debug("exclusive disabled: %s\n", lsm->id->name);
>  		set_enabled(lsm, false);
>  		return;
> @@ -165,9 +175,9 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  
>  	/* Mark the LSM as enabled. */
>  	set_enabled(lsm, true);
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>  		init_debug("exclusive chosen:   %s\n", lsm->id->name);
> -		exclusive = lsm;
> +		lsm_exclusive = lsm;
>  	}
>  
>  	/* Register the LSM blob sizes. */
> @@ -223,7 +233,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	}
>  
>  	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>  		struct lsm_info *major;
>  
>  		/*
> @@ -234,10 +244,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		 */
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, chosen_major_lsm) != 0) {
> +			    strcmp(major->id->name, lsm_order_legacy) != 0) {
>  				set_enabled(major, false);
>  				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   chosen_major_lsm, major->id->name);
> +					   lsm_order_legacy, major->id->name);
>  			}
>  		}
>  	}
> @@ -262,11 +272,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	}
>  
>  	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
> -			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
> +			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
>  				append_ordered_lsm(lsm, "security=");
>  		}
>  	}
> @@ -298,15 +308,15 @@ static void __init lsm_init_ordered(void)
>  	struct lsm_info **lsm;
>  	struct lsm_info *early;
>  
> -	if (chosen_lsm_order) {
> -		if (chosen_major_lsm) {
> +	if (lsm_order_cmdline) {
> +		if (lsm_order_legacy) {
>  			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				chosen_major_lsm, chosen_lsm_order);
> -			chosen_major_lsm = NULL;
> +				lsm_order_legacy, lsm_order_cmdline);
> +			lsm_order_legacy = NULL;
>  		}
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> +		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
>  	} else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +		ordered_lsm_parse(lsm_order_builtin, "builtin");
>  
>  	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);
> @@ -467,9 +477,9 @@ int __init security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
> -	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> -	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
> +	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
> +	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
>  
>  	/*
>  	 * Append the names of the early LSM modules now that kmalloc() is

