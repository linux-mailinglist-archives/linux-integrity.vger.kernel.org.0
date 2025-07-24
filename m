Return-Path: <linux-integrity+bounces-6716-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3FFB10F11
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31656166542
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BD2BE657;
	Thu, 24 Jul 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cLSnmYKw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615828D849
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372038; cv=none; b=B/wn7kse15Xf1Y0dDhSmcjMETDK9EXcOgawutdxBqgaEbXHsh1MFIzClsQMDX6BwdZvzBWvIqgO9THkM0iV97Rv5L/KuRcr9hn3BO4pJIOz1EZP76mCXI/EeXyPhJyt/ZZHLrVsGXW2zj4EMTnJdUJ6N87oNTQfZG4uyQKr1hgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372038; c=relaxed/simple;
	bh=5Da/UHbXZOotit9ZSt7OIDZkmTEY6o+8Dn5xU0qJu/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSOANc0GawoeWA3P61qoLGd0L4JegZ9pR5RmXehKd3OdZua4ZWXo1MssKnq8e0DJd65JFC14BwSlCfox+8kDZFYoFihczvl3w1IxDp1JPOUh7S9eLIQwst/4xSwuoqjbVZd81brIVBhMVYJwKDY+pMjWkTO16eFqCdMSpSAshpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cLSnmYKw; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753372034; bh=GRdz2ieYUtEN3gMrhTU4borJ/xRHvvTiEAbcm/InHCs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cLSnmYKwlQLkLhrTP4Q2uVzIUXp7wwjNi1ogwCY6wJ71FdB38UH97rH93X6xhvEI2PgKbVj5oQ9oynksQPaJBNA9BHbqmcs05CLIVu1JAv7fRQJJ2xPNdcZSUGaN6TF0zem7GQdacA1TZ9Az2xlaEWy7t/RzpScl9QnlNEzVsq4UDWOmj6NjE3Q2/RYNVIb4W2JweJeloY61lUPJQG7QI3C2x1MHgEG2Mv1V1TqV9jGfC4K9YBM4TgLQKxPYCz7y+BBQaZYU5xkvxTUZXA37d9oKtw+5JXYxIpxk+z7pVXHhC5bQuq1OoogNpDFKmXtmp2XaXVLUR3i0yFivXCOhbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753372034; bh=bnNsq0ymeq5GiH5ml2MvGF3jEM2upqX2qgN0Z6UzMmX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=L7RpHylFNiQ4hibARn2OepPDE8EfP1LUD2RhANuEnjwZM951lHxhKdRD/yRo96UpxcK2pcqHwRBak/6j/L+SyKDl1K2ECOhfto9GnSfE9q9iMys6vM/qvhm0DVWf7yJMXX+eD3DfqJuvpjd35QeaTzlF5bR4r5YVcSmJOd0jYWV9tv+J9Nrotcl4TZTqCR+hFxSUFRQKExc/RR15HJFDtiZKKgKIAtI9WlwQbAXg4BIQU5djCrMorbbNXFfsvg4BPV6hEa8J+Q013N5TPqMzV0oYiz6cZr/HbEIL49cSaPomwC5njOCyGFh3TS3RJ/s7GZYUfX645m6iZV6iCurnwg==
X-YMail-OSG: 1qjdmcAVM1mKu23e25ZnI1pvhPfw364tbSROZJEkFD4WIafblKdTp6026pcHnKJ
 chwLay6oShOpFbTvlD8N0sECQFwlqOFUCSBRwMJlwblgWQc9zVbsTMwGJuHfcIKWeIaBZSVdD0j6
 Z4vyoB9pi7QIZ.aUWeIZaUZJQiYuDMHbMhENXiIKf_peoo1oSvqJzpaQv9EJyndZ.GA7_8mLQpg9
 6op4a_UhsWd2MWOvQPHPqADol5U2wjtbcd9TBnUKvh8Ca5Rfv5kHWAFalUt4XkPPdfwjb4v7Kgn6
 47Vzw2m04PVwkPBHMBDCSdaoinytOQedyYIHV3mURKW4htSl0Rrx0IAMlHS24zJBD0YelWaEPR2e
 EDphQBvA5qNC4mM8p9yaqOYWsbvTbJgt_h_Qkp9sdJi5wKR6ULocLf86K1Wzv5Juk_0wWJVNeK8f
 Qxtk1jXoPbjkehYHCCxDIUXfuVfrKlsMCihtgcvu_EPk9PUmNzGswWetxSFGl_mmZXM9uYusrDdk
 xS1STo7K4_qGXjllfIJK8mPs0gqgM8k1RyPR1z8uwDinHkQl.BGlnfpXDlN1dSp45eTq5JfAzPpk
 0cyIy3WFYjz2rC4gp7cv_3ISywcyxnPt8uoXg6jcFExZfkvOETRPROYR_gWVNbsWqxtMRis3c0iE
 EXIwHcky8ePUUxh21MAMiUT8l_MYxZQsFrgTL1p8eQRPo_3PiDmKITUL2.qrLMr4xf_X8bXSv.t_
 PvdO1PGksNnGMNs.e8_OsvYcWoyUI5hK4YXX6mHVTeIy09LmYndZzJAlI3UNBP1hFfiNmyr40krd
 4nETPRz37F9d6xIA6VyeH2sfbjCAzoABY88mg_RqB4atd7wX971vVshwwN_lOVva0dcQ1buUFTmn
 U8yB1SooM4L0hGuSvDvfD_Vjw.U3pdvDsp3gEcXEjvtD9s_8zMOSMAkdnW4VQ.CqiisWBjkdT73O
 qAfON6n1dm9wDvwpJl2fArP9vKenFs4goe_ep.l23j7rkddiKi_bh5.klCksaFJpAHc6.TjMu_cQ
 6RHkZo70SJ2t0KaqPy7KQLYffkKZgQKs95XCWLTEXo6ikge3E_fE4phARR3a2bpSCGC3jSDEP1Jb
 l6QdLbdRr78ZnEMMBEBjblebB3CaLIABluZizHnZLaUmuzY16Q6hvd7p2nYo4X5wPFJ1eXkdvzJ2
 Er2McYyVV2_RxlOiAdyKCDKqpOWvOdQEu1XlDD7DZOpTfr6vFbBiY1TclMOU1THCMtVRokcbt3p8
 8wTaoaJ8dRrCtLYCiqkNYAT7zpAFtZSi6x8UOoLrWSoonpb7WMtafoHyyL_925fDIvgN8v_9AhOv
 Jg8wJco8WLih8SVkXyXbwNFLMC3u26DBuFtu6O0C.BorXn2RBI9QGIaYFBulfULM2.P9qAnhgPie
 TedNG4idQTQF3eBU9gSqmELqVeDvrrmQyJtE8_q5fmBGxmB5IZP4lRf4Zp86UdylgH6fLxs.rCQi
 a..TVUrUIY7apQxII8dlN1u86wWdhflktL2uu4J_lcz27LTsjXlgk8icQzI7OFwqdLgICGqQkuJ_
 YsQmlnOCjdJ0zgKhzZ3DFRSSkyvbTy7xkCbT84Z0HjK9ni98vvz843IPgdSaYrhRsRM1XlTw5u_P
 qOE5JJnAZdW1lpSv04qcIcxjeahos88.1oiVqJ5KNNtewUA.tqrS6wBhFUZrKSoxH0iU_6M0vixm
 b_IpEgWXtkosotmnFsCEQexuAbvHRGrmIFn2WKDD0rUAdLw.2L0jrnZ9MCnmkSt2asZh49H1aFxZ
 JDiodkwx_FW17_HLNaPtARownYZMYrcTpPAbrTFHlMr5dVqZP6uof5blo9gP4LpjNhmq5D05FNwy
 hcoObwDvEaIsBk6_S96y_SdcKKOeHDZzbYVRVVi.Hx1DmFeEeMETDyL80pGE5ESekqBVcqM8q5Zr
 tR9l_whWJfzfm71YAVVM0IjRX5Ql7CgGFe6XUjwWgUhTlquZ0c6GRSNl.OkBQor2GlqsIEC7vQ5x
 AkzR4E3NWkN6mVsIAsAT5NpP3lqY3R1eoQfZWNvXbGzri0X_thVE5CIxoEvsB6Ps2Sc4JUUbTAIo
 5HD.l_En62yRM2021.n13Y2dFMFIgcUmvpCgXEPs0HZ_tS_pl.vAImfhlLzdZ2rt3Oat9qiIhf6v
 XzWmaroZ46jEwVpy_zXOSTdoJj4T9mTDJkNeIGyBaX3QhUp3v5ip4oFQLwqj8qISMY7FA..FZDPO
 XE_MnCq66v08LqAObEsQq5tb0qP1S9B4u9GFkWROJ.ySBBTbx7NYVqYKH9Joyejc.f5Og3GubopA
 1t8a_P5WxFf3heqRyLjRds2IkYe3cpdV3Huygg7i46Fmg
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a70324c6-1544-4989-9d28-614411ff6751
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:47:14 +0000
Received: by hermes--production-gq1-74d64bb7d7-grhph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87630d6b4341849f99c6431bc4f79fb4;
          Thu, 24 Jul 2025 15:47:09 +0000 (UTC)
Message-ID: <63420aac-3d51-407d-8dc6-1dd0a961b3f0@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:47:07 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/34] lsm: rename/rework append_ordered_lsm() into
 lsm_order_append()
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
 <20250721232142.77224-50-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-50-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Rename append_ordered_lsm() to lsm_order_append() to better match
> convention and do some rework.  The rework includes moving the
> LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
> in order to consolidate the individual LSM append/activation code,
> and adding logic to skip appending explicitly disabled LSMs to the
> active LSM list.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 33 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 01825da2755f..8c632ab77da9 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
>  	return false;
>  }
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
>  {
>  	/* Ignore duplicate selections. */
>  	if (lsm_order_exists(lsm))
>  		return;
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
>  		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
> @@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>   */
>  static void __init lsm_prepare(struct lsm_info *lsm)
>  {
> -	struct lsm_blob_sizes *blobs;
> +	struct lsm_blob_sizes *blobs = lsm->blobs;
>  
> -	if (!lsm_is_enabled(lsm)) {
> -		lsm_enabled_set(lsm, false);
> +	if (!blobs)
>  		return;
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
>  	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
>  	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
>  	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
>  	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> @@ -224,7 +234,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	/* LSM_ORDER_FIRST is always first. */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "  first");
> +			lsm_order_append(lsm, "  first");
>  	}
>  
>  	/* Process "security=", if given. */
> @@ -256,7 +266,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		lsm_for_each_raw(lsm) {
>  			if (strcmp(lsm->id->name, name) == 0) {
>  				if (lsm->order == LSM_ORDER_MUTABLE)
> -					append_ordered_lsm(lsm, origin);
> +					lsm_order_append(lsm, origin);
>  				found = true;
>  			}
>  		}
> @@ -272,14 +282,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  			if (lsm_order_exists(lsm))
>  				continue;
>  			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
> -				append_ordered_lsm(lsm, "security=");
> +				lsm_order_append(lsm, "security=");
>  		}
>  	}
>  
>  	/* LSM_ORDER_LAST is always last. */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm->order == LSM_ORDER_LAST)
> -			append_ordered_lsm(lsm, "   last");
> +			lsm_order_append(lsm, "   last");
>  	}
>  
>  	/* Disable all LSMs not in the ordered list. */
> @@ -409,8 +419,8 @@ int __init early_security_init(void)
>  	struct lsm_info *lsm;
>  
>  	lsm_early_for_each_raw(lsm) {
> -		if (!lsm->enabled)
> -			lsm->enabled = &lsm_enabled_true;
> +		lsm_enabled_set(lsm, true);
> +		lsm_order_append(lsm, "early");
>  		lsm_prepare(lsm);
>  		initialize_lsm(lsm);
>  	}

