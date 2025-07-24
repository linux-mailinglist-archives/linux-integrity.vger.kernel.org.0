Return-Path: <linux-integrity+bounces-6705-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E6B10E59
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9AC4E6699
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEFC2E9721;
	Thu, 24 Jul 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ol3XeJc7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F426B2D7
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369856; cv=none; b=krPl1DTxF/OU1yTU/ttzQCSJcTFtG7u7Gx8JK2xBvYVZN92pQ6ttJ5Tzk8tHJ0zupv9PJYRBu0jviJ6AhVhLNTdfiGHYysQuWVs/OuNok3rC+P1U4Zm+0Rz1c4f+DygqIWaUHY/3tXc3ucLkUkhghVXq6y/sre2+tfJI3vRAc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369856; c=relaxed/simple;
	bh=iEGOBK4J6fAPKd6d6d6dz+RdLdYadCNLathV9qHy8gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/vmdgosqABvWQU/pCumzEUG265hNgS2hZU8kKvGN5B4fUZ5ABfc6jmiGaU0Fcsb0JTeydS+F/ghFQiCVtTFP1N9Ihok5lIIy1Ouib+pVwqbJqrP4zXiDC9M6RdfbpNXIbMBH5RtxbItZqGLb88ju3BXst6UilfsTdLOXLEQHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ol3XeJc7; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369854; bh=wCTkENI+R3PCWQzo3p72E06KNuul0FZ5SzeTS0QeBxM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ol3XeJc7FTOsD+plrk19y4BddZxFxEO1pswyU1Ft+uxXukC8g43sg6dpNxYhOGXCgy+4HaVbvk2a5dZRHAtwTgN37O4spYjZEXA5mj/fvtUgZh+mUsHxaRqhtQrbR7lLYeQAjaYc3gfRbnxe/hMKaxhZF/jzsTCrikJW+/TtAQrc8vFyyAIiQGnDjZmGlh+mL/e06uPlrgcgMASxpvRwhFEd7VlozHt+XqF7qEoZFHA+9biMS3uA8viHXsZPNGJZIF9EbVNa4tGB0/SqgRlJhh6o29jgCI6c0ujIqXy4TXPM68SShcLCghZBWmpqLTr5ROLQrAnewWdf2r84cnhVlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369854; bh=VxvVM5qsprHXo+ogQBYeV/OUOR/S337YOB1WoxsSFJc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mwbMmyi8AfS9/f7Wr/8iKcmu3DEMBvEsS3fztoVuKD1hqakSvIw2V/i1qdAoO6AFIOJHWhaUM/x544OjqVLYI2ZaNnla0tbeegxnk3nQSYsRVj1ZLXb3IOv3q9raU7SvR1SLFLi1h4HgOlLsKWdxbPGGvrvc22piUKidi3Z4JEh7yUj7ukmZh6EqjCZoLt502RGvQUTMlO0eHk7xFv6Hkf+Fxi4B0azuzzuMLa0cMxYXVMwfggSdugEN50fc1YqSOmJuV4Gsa462w+Fvs8+VduaWEkzs7kGr8Cdpclf2HeQUhXuJEcvvMfFTCjI8lDs9gMWsYdyDyMgisYu4TJNXPQ==
X-YMail-OSG: p6cRc2kVM1mxxl4rjJC_wjGY5Mb0ZvzjEVU2MpHlrJHb42NohzS1wL1CMeY8aw.
 B5LpNtm6m8p1xxdq_vH0gMn5I5s6XcYYMt_gSui7o6N2Hmz6chzGTNKeeuytYZv709y29bUfC0Ho
 kJeYNy5YD.t4TQAp825BCpLXGz5vNDGi1Qfeq8.Ese27zIosKkT.iZjxUL_alYOO_Wr2nRaeepoB
 02czEW6kh.oHQyH7Kj.BYNn2KEE1P3_5BpuL1doc9lK4kXqAXEQOg95x5PJpykoVlfT_0jj9kh2d
 FhxqFuFUfSWS_YR5_h_KP01OSwtPfphYd54OoWKPm0DX4gbbDjlUHDJMOf9Zc3W.wKmXQAqhFJ48
 fPrR_X9SbaPYOQo.XS6TQXvYfnhA3P3M8k7nilVGhbZ5RFa3EmuRSero13nDNQVuP6ZaPxNcYsPh
 JYj7tbhhdLuVORYXZvyevQtZ5F8uh8.5r0O3.XbXjxyzhZXWL0gEbInePowKHC5Hump61hDl8PbU
 D4hieUXaS9Ay4W2VElEKPL5rtIJUUUNY5ZpHgGStkEj9YBI0oEV7fJ8.vnkJ3DWb.cncIdBBg8I8
 pM9xr5L1H5ILflQRgAifJQxI15gKeO.zbcMzpqVgqcdaU2FFP91tqkAvigQo6a58MjeZBiNxV06I
 M.5ABcevoDew.UkPfu8AzfF5lGFaKPvqENDF40rtOLpBaRWWdet.c6BKpwEfp_klwJp1AI26rlZN
 DX.5Oc1eHG_uFobobzp1NbQEwBpXbY8PeFdqWyrhIWPjHEUaGHgx1_SNI0QZ8V0Iq7goZekIgZYw
 FpnjtJ_cwNbV3fnWsmhLSaVivmdtwH8dvSY0hmYHQIHuHvJuoelzbJUwlCf582nHffgosx1zIEhO
 e9uS_U8PzqXLUIpWfqp99jlUaZcrFSx_hix51_nkSRpoKdtQaHLO_l9VXNcnW0Aa2PvhzZ8bD8jI
 2lOJNJz6Ee5.FuTkplrAQrE4JU.rH5ISxYjVBzoc74puwULAhKHUb1jKRXGP0wXqtpS4A7GpCQds
 ODqCk6cXOuf9hxgUHgTTooC.u6VhfUmVFVr3EcmNoUHd_brFnwCml9zJ5QOEiESKd0E9Sn94w7Lz
 NVeTeCbbdcIobENVapcX9sAiDLJfiwWF1ftQ_HHtNI4w7unO9u35WgO08lJiltH5rPm7xfHo8oct
 wS79_eX9rhIx_6Pg6JJdY4SEI1kY3KapTE1MknmaxEs0IGd8mAomhQAOp11Q.WmhMTEgnUalzJYP
 ucitUmap82vO36IkUCrc4bsrEU1A3jJPIKqejECbSQkpSdG6HeiVfCIB6I02IxcTz9BX2Qhrx3WY
 imWQdmh8yfvRdLR801D2YdtzrZ_UqcG.IhzeylUrUBDyajPsMI_8yWEMpS9k8427G_wHntxdT.40
 uG.njp31Bvy5s7342npmMYxxXhcOAecJR3jo9JQajhYYZl5OSLdt8t4GxNDfYoGGypw58xIsNg91
 .ckIz2kawlHfegN91_lh0IQz51oaalcBkMIwY79MYB7iRiVjrkZqJQQ8lSX6fLgXgPnQCCM50ccI
 39HLuO_qgkmvuQOadw6iGOOY6i3PvonGo9TUQ7rRmjFEiZlnjW5X0IRZ2vU6dXmFZTQIBVdMAx9y
 iTkAupu7POIcl_mj88FdFoQnCDR_1_0KA0QYiLMmFhm3nb2qo85d9fL1IiUypziMZzkK6EWEEJ8z
 WrwxjUGYcPZAvb4KwAeCyLz4oeDmpdkU4JkQqlN13S.JqCIyklpSuw3QxHJoey.vlwj40YiMWcNf
 eRMo4O2LxJaRvWZFPjUjmG2XpEqhqS7BTXU2sW6toPPs7Dl39WipuDYTWb_zBZEqvKO8sy30JOwS
 wpdhdrQ7w3GXKVol6GJBrduzRaOPNBdd.KB3SEORM0vyJcRhpW7yFYK4Mgflo9XXhAnuvqdVQSGm
 iBuFEf04j0L.A62sZR2_NF0sNZUa1qrfKOIbOaaT5QZCphydEybQtFntOOuHvvWkxE_McPlza9Ri
 93EdoAom4vjA0qFnriRFEUhCDan8mrcd83lkSvG_YTW_7C4UkKF0..7n5GSKpdRUsKB5co8Vxtnl
 4YQ6p4muLSVC9j_N3Z5Zba.g6x9p2xKYnGwmCj7Alin5.sUOMTYh8oMOiARohujDihllwDravMW8
 wKSSYQ_Ql8ZMzZDDnWhMqPiQItoNVTqZROm_5.SbB4MG_AiExnd.sGa8.SJZG1z5gFMDEMZJP3XU
 4pqZ8xm_a.SSjDFKZhzYHiafjChhwK5rFpbVCSC25Cx8yhHrxpqWPSOFUPsRI1g1SkyZsd73fPz9
 4tEDKSrVp5mrKikv86iN5u1l4grtDjkALa5s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e3272be0-f84e-4fa9-8631-b478720caeb5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:10:54 +0000
Received: by hermes--production-gq1-74d64bb7d7-nrjbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd7abbe9d1ea2b3cde3798a018adedfe;
          Thu, 24 Jul 2025 15:10:49 +0000 (UTC)
Message-ID: <ecaa2670-1f1e-4e6a-b56d-f8d17799029c@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:10:47 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/34] lsm: introduce looping macros for the
 initialization code
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
 <20250721232142.77224-40-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-40-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> There are three common for loop patterns in the LSM initialization code
> to loop through the ordered LSM list and the registered "early" LSMs.
> This patch implements these loop patterns as macros to help simplify the
> code and reduce the change for errors.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

I'm not a big fan of loop macros, but they seem useful here.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7beb028a507b..a73c3769dfea 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -32,6 +32,15 @@ static __initdata bool debug;
>  			pr_info(__VA_ARGS__);				\
>  	} while (0)
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
>  static int lsm_append(const char *new, char **result);
>  
>  /* Save user chosen LSM */
> @@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
>  {
>  	struct lsm_info **check;
>  
> -	for (check = ordered_lsms; *check; check++)
> +	lsm_order_for_each(check) {
>  		if (*check == lsm)
>  			return true;
> +	}
>  
>  	return false;
>  }
> @@ -206,7 +216,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	char *sep, *name, *next;
>  
>  	/* LSM_ORDER_FIRST is always first. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (lsm->order == LSM_ORDER_FIRST)
>  			append_ordered_lsm(lsm, "  first");
>  	}
> @@ -221,8 +231,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		 * if the selected one was separately disabled: disable
>  		 * all non-matching Legacy Major LSMs.
>  		 */
> -		for (major = __start_lsm_info; major < __end_lsm_info;
> -		     major++) {
> +		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->name, chosen_major_lsm) != 0) {
>  				set_enabled(major, false);
> @@ -238,7 +247,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	while ((name = strsep(&next, ",")) != NULL) {
>  		bool found = false;
>  
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>  			if (strcmp(lsm->name, name) == 0) {
>  				if (lsm->order == LSM_ORDER_MUTABLE)
>  					append_ordered_lsm(lsm, origin);
> @@ -253,7 +262,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  
>  	/* Process "security=", if given. */
>  	if (chosen_major_lsm) {
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
>  			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> @@ -262,13 +271,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	}
>  
>  	/* LSM_ORDER_LAST is always last. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (lsm->order == LSM_ORDER_LAST)
>  			append_ordered_lsm(lsm, "   last");
>  	}
>  
>  	/* Disable all LSMs not in the ordered list. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (exists_ordered_lsm(lsm))
>  			continue;
>  		set_enabled(lsm, false);
> @@ -287,13 +296,14 @@ static void __init report_lsm_order(void)
>  	pr_info("initializing lsm=");
>  
>  	/* Report each enabled LSM name, comma separated. */
> -	for (early = __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> +	lsm_early_for_each_raw(early) {
>  		if (is_enabled(early))
>  			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	}
> +	lsm_order_for_each(lsm) {
>  		if (is_enabled(*lsm))
>  			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +	}
>  
>  	pr_cont("\n");
>  }
> @@ -340,8 +350,9 @@ static void __init ordered_lsm_init(void)
>  	} else
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);
> +	}
>  
>  	report_lsm_order();
>  
> @@ -376,8 +387,9 @@ static void __init ordered_lsm_init(void)
>  
>  	lsm_early_cred((struct cred *) current->cred);
>  	lsm_early_task(current);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>  		initialize_lsm(*lsm);
> +	}
>  }
>  
>  static bool match_last_lsm(const char *list, const char *lsm)
> @@ -479,7 +491,7 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
>  		lsm_prepare(lsm);
> @@ -506,7 +518,7 @@ int __init security_init(void)
>  	 * Append the names of the early LSM modules now that kmalloc() is
>  	 * available
>  	 */
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)

