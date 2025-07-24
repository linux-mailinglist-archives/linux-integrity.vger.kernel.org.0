Return-Path: <linux-integrity+bounces-6718-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC54B11485
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C41F1CE3884
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895023FC66;
	Thu, 24 Jul 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZPJNzORS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260511E500C
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399839; cv=none; b=KWvbOfPcRbGLCeuN2HjhQpFJ3KnAhdd1MUu3sq28tH4M9O7ujJzA/5wRFWxRAdx+7PkIVQ/20qKqtEw8tWjOD0yDGrFM2lV5krJZHJEdwLpDQQ5DsSGq19p9acUC5OnfGfQgfkvWiO+kMv6Rwx89U8Yv41lX4hDah3B/LdxsZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399839; c=relaxed/simple;
	bh=GglzYBI5xUwolaDcydem0f4m9wok9jkwac8MwWk5Y1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7y/YuRh2wUq08WY10DcFk1SqV7W6YiZBjp4EnXSVtISsH0v4POKPFi4Yhr10+LXwhB3zkQkqZG6G39g+DZuQDE78wt3UrA4ToHOwsMAK78CtWapAykvUKIttOTyZ2oLcBZOoK3OAgkNutWdamrT0jVGcRooVp14Kpfrox2y/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZPJNzORS; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753399835; bh=dIWZ6fug7P9aO0dy/nbz3vrb6cZC9YaxpddoH2P+ZXU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZPJNzORSGbMTPAfmhD1kMVRObyx+yX1j/fdq5qBfM8m/S2C2Tf+aa7G1a8q4a6yo/AYVO14qbQQ2NwPoUUDLBE8kL/lZs36uD3A/zTOpsOqi0wpJNS3jr863lzhGxnXA1XjaLUiHkAsQ7bEn1WPx4ntQojaj09TCJ38f4x+QOtvOkwOdv/aF/XJnno3m1bIeQb+m2I1KbIpqK2M9+HVVYV8IJDLPxYvOG6YeFmzKpGGt5Ywr8NKU2ToIakjmXrII71vH3/uqP+DhRq25EsFURmY9B6Hw8/sSqsqHztcbDVXZ4qtahCthseqM5JaIgNwEa6WNfKjCdy5V69CqJjJJmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753399835; bh=zlHUlYsSHisAOQRiDjNuIR44Des7SXYH0bsAKyRhkSS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XYyKp5FdsKpDIB2gCU4ME1qP0ObOKApLiuQCVIA7qY+0YftM+5B0oREUO2xQfPotsfKSMVfEoiWby1RpAZDUO2FUdS6G54TUd+m3g+TiRgFhHFamvyg+dIkcqmVK7peSQkA547t7zvFZ07ssDwf1CIBiDKP0HGE1folFB+3lAR1/hnfwFCuo3wH+S+hOEFeVsf7iMaaycg+Cs2YwKl3FeFhaKuHcZ6UDwV4GqpCxwFeYhwTmj8DXKrbPjEu0qZIBI9Az/bxQOJK8+GChpUGGwBC4a2KPK+xZEDvJvnH/+duw7jjKcB5IL1GU+uivzAvgk0k0WidbtbRMDpu8nCJU2w==
X-YMail-OSG: Pe1yUQAVM1kkSexFItAtLkIpWinlK2m_JcE0_FnLU7wDj1lPp9LL1uoapPRTroj
 X.LO4qs8sqbP4q5M4iKC.JLbu9SG.XUNyXA2LJ5THkIqUsq17u083ZaJ5iDXK1EXONYs3Em0hZnc
 LGaNUVSVxbMS1CpEBps7n.Rh21_LuxnwukL7Z9RJDji55Yl9Al.21gYsF4OKuSagLQoQs3AiAjsL
 vQHsBdBuvPK4BZ5e2ggD5eKulCcVeWBxcIQcH1UHyGOEG8JguI8AWxy0rGVS3.3hTktEGVHPCpmF
 isUeWgS4ryBILqwwmf6TxN5fpnq_JnKX2JobBhKFrcz9cKMkeLqZqn9iz20vwlOOh6Gp8QB5pPcI
 w8NN5TPX82PFZy3P3ZxpFRfWqRPLDnMDOkveIdPCpzZLdbuQkvPwNu7S61JTIMBUA_qdOIKPShP8
 pqVYfblk4r4ROLAP.cwJvOZClA2B7PEoctHVSOT5bY0BQweca5W2on7mRmoivyNae6GUFus3KxRU
 hMyk3hSGbq7c7B_FgN5w5PuPy9F_yTFeGop1LgjYEgxFVOr9rGO6XFDjpcgiV5HnI7kikOuLvmtP
 Qoq9plK2LsNRX93Y1szyszLOPdoTVXgiYW2vsW86JZnm57YosCHgCYvs2NjrrYbqUa.UtLUOiiQ_
 VLfuKIJuQSeHNOYlcYhDRVpTXgK3IPJQz1LQTIO3DIwQIRISfchOgqWoleR8QHQsDNU6VrKKpnL.
 bKdJUej3Ff5J6E2cpAP_V202VQ1V5rlCsO1GPTFUuuskQ2WDqHKWbzejTAY_x8tijKRAPbrSqnfa
 eK33TmUw.okES8K3U_BkGGG5qfMMm.kgeiduf4u0ovOua4_aG7yzp4ZFo8C.cwALdEHrIPdPpOW9
 QACbc1fVRugL0Jz1tyHZvARsoVqxyDQ7nO8GBGeDwXvn6h5CDqUmPlL_MP4e7bywe7jIQvsjVDwr
 wlgkzbPLHEdhX6SpZjfqo_0rWDYQxZD.wr3M5dJB4dPD6NuohezAZUIjJKX1trpK5eHOc91yeD3a
 pkdYXBhKY5pI45bjaCGutqXQZi3Fn.drjk3ImwFECkrrMQxo8p6LpCar.D5fBi.VBv16uOEqJ7mi
 rkmIBadebwKqc.SUr8.RnpVGdxsqHpZhqFQv57Nl6.YB9_7jwuT5erk2g92YKZmvneCYwMmDWMze
 LgFgqX3grWjnqDZzuu1ePpfOy_ZTuF108Zzo5MBY5wfmRujXTqwMXlf20fLG4CxnrM3yjUGmlGuG
 evASL2TQ4whiNS7uSbl4I0MSnyMMQ6BaZdY_Zz8Xo7senSOzT2ogMLrxUOobL.N9qoz5c3X2gKN8
 pA0fKdKXZ.Jv7WLu8IB6GYN8r.2Mj16rXtd4YTtj1HuhDPPpK_bNtV0orOu_zn0h4gv3lXVKZHJ_
 ukg8x.8Wuy6JREeeqK.omTbLE36TVo4eWq6pERTBBn7TJ2u73IiUtuRm81eh0kcWIYDe7jEK6_2r
 E4LEDDmtlnKBR81CnABMOL8qdgl3Hv3.QKy_6Wvyjobq6eIxKuq8qG_UyLoAPwtHK0WIBOhpfEkU
 zahKwgjTIXEJAwoD9HIarJHQgnCb4P7IHArHsgrjqsHzgJPGXvv8txdsIEhaQqBTHvNV7LFbg9VK
 i_xH0bXknNM9quS2d60vIIh1QG2JJw6BDHvbKEnz6ERSrpv8GDz86ZTTQHlwP1L2vt_xGEpZFeiU
 SR8KxNO4k80Xy_rVvuzKZDTLbwK7aNwjQddTKKyM5aseOmxmZBNcB9muHTYdzT3mRrLdPQy_uuM4
 XoswQqF.LFhDMzUWK34xFNItGjP37OLvGTp7Prv_awDKqBK0e9QD0sxXj5H2ghv6_xNCTaY3AzFf
 7VQhNO4AuljM3M8WRNeOlDiYxdv4Oj_riDm0t2RG4kLAP2Tq43F1DtGOSKixFmLSPziZS2gNsfFv
 ytOeAnO1MgYhvKQ6oVKROo.71au39FSdFTlDRoHIuJxzLjMb_PvjZCpzeM97MUGO2PIoOqZPw_Y_
 vqwT3OUEdgvzK1ru3cu57kulVZ7cUXye0nUD6.lBfYZKek63QWkdC5Z6ZlNnchx.VHaW.D12TbJH
 gkormPC9mAFdqJCsP34G5DK60YOu3TePj9QGlQ00Hrf3GYygfWqRPXkQR_HaYkcTSZ2GOOfmUUr0
 zrxOmH6RuNGdKr8.nWKl6ARoIdy.DLORm1Pdxleh3JiHz4OTotaoIy1Vq5BxeVCQqCrGDA6pxjJU
 TbvBPb705dWad8rpABp11qOwU_2gyf8FgwAnTegkReiKJ8q_Pvh9zBK8EqIEOn7kKcuRetewdL9q
 0oUfTLDlpJlb44aJFsBl7qXduJ_9P8edRxFYGEls-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 79dab694-2af3-478f-9c89-80c8855b6f79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:30:35 +0000
Received: by hermes--production-gq1-74d64bb7d7-2dlqg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10e5f1eddbc5a3ab71a0d019b55f76f9;
          Thu, 24 Jul 2025 23:30:31 +0000 (UTC)
Message-ID: <7e30b90e-27cb-48f2-a6b2-1faf75f00983@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:30:26 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/34] lsm: fold lsm_init_ordered() into
 security_init()
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
 <20250721232142.77224-54-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-54-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> With only security_init() calling lsm_init_ordered, it makes little
> sense to keep lsm_init_ordered() as a standalone function.  Fold
> lsm_init_ordered() into security_init().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 157 ++++++++++++++++++++------------------------
>  1 file changed, 72 insertions(+), 85 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 49f93383e551..25fe0c89e884 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -18,6 +18,9 @@ static __initdata int lsm_enabled_false = 0;
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
> +/* Number of "early" LSMs */
> +static __initdata unsigned int lsm_count_early;
> +
>  /* Build and boot-time LSM ordering. */
>  static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
>  static __initdata const char *lsm_order_cmdline;
> @@ -169,7 +172,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>  		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
> -
>  /**
>   * lsm_blob_size_update - Update the LSM blob size and offset information
>   * @sz_req: the requested additional blob size
> @@ -310,78 +312,6 @@ static void __init lsm_order_parse(const char *list, const char *src)
>  	}
>  }
>  
> -/**
> - * lsm_init_ordered - Initialize the ordered LSMs
> - */
> -static void __init lsm_init_ordered(void)
> -{
> -	unsigned int first = 0;
> -	struct lsm_info **lsm;
> -	struct lsm_info *early;
> -
> -	if (lsm_order_cmdline) {
> -		if (lsm_order_legacy) {
> -			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				lsm_order_legacy, lsm_order_cmdline);
> -			lsm_order_legacy = NULL;
> -		}
> -		lsm_order_parse(lsm_order_cmdline, "cmdline");
> -	} else
> -		lsm_order_parse(lsm_order_builtin, "builtin");
> -
> -	lsm_order_for_each(lsm) {
> -		lsm_prepare(*lsm);
> -	}
> -
> -	pr_info("initializing lsm=");
> -	lsm_early_for_each_raw(early) {
> -		if (lsm_is_enabled(early))
> -			pr_cont("%s%s",
> -				first++ == 0 ? "" : ",", early->id->name);
> -	}
> -	lsm_order_for_each(lsm) {
> -		if (lsm_is_enabled(*lsm))
> -			pr_cont("%s%s",
> -				first++ == 0 ? "" : ",", (*lsm)->id->name);
> -	}
> -	pr_cont("\n");
> -
> -	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
> -	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> -	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
> -	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> -	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> -#ifdef CONFIG_KEYS
> -	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> -#endif /* CONFIG_KEYS */
> -	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> -	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
> -	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> -	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
> -	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> -	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
> -	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> -	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
> -
> -	if (blob_sizes.lbs_file)
> -		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> -						   blob_sizes.lbs_file, 0,
> -						   SLAB_PANIC, NULL);
> -	if (blob_sizes.lbs_inode)
> -		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> -						    blob_sizes.lbs_inode, 0,
> -						    SLAB_PANIC, NULL);
> -
> -	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> -		panic("%s: early cred alloc failed.\n", __func__);
> -	if (lsm_task_alloc(current))
> -		panic("%s: early task alloc failed.\n", __func__);
> -
> -	lsm_order_for_each(lsm) {
> -		lsm_init_single(*lsm);
> -	}
> -}
> -
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -429,35 +359,92 @@ int __init early_security_init(void)
>  		lsm_order_append(lsm, "early");
>  		lsm_prepare(lsm);
>  		lsm_init_single(lsm);
> +		lsm_count_early++;
>  	}
>  
>  	return 0;
>  }
>  
>  /**
> - * security_init - initializes the security framework
> + * security_init - Initializes the LSM framework
>   *
>   * This should be called early in the kernel initialization sequence.
>   */
>  int __init security_init(void)
>  {
> -	struct lsm_info *lsm;
> +	unsigned int cnt;
> +	struct lsm_info **lsm;
> +	struct lsm_info *early;
> +	unsigned int first = 0;
>  
>  	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
>  	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
>  	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
>  
> -	/*
> -	 * Append the names of the early LSM modules now that kmalloc() is
> -	 * available
> -	 */
> -	lsm_early_for_each_raw(lsm) {
> -		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
> -	}
> +	if (lsm_order_cmdline) {
> +		if (lsm_order_legacy) {
> +			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> +				lsm_order_legacy, lsm_order_cmdline);
> +			lsm_order_legacy = NULL;
> +		}
> +		lsm_order_parse(lsm_order_cmdline, "cmdline");
> +	} else
> +		lsm_order_parse(lsm_order_builtin, "builtin");
>  
> -	/* Load LSMs in specified order. */
> -	lsm_init_ordered();
> +	lsm_order_for_each(lsm)
> +		lsm_prepare(*lsm);
> +
> +	pr_info("initializing lsm=");
> +	lsm_early_for_each_raw(early) {
> +		if (lsm_is_enabled(early))
> +			pr_cont("%s%s",
> +				first++ == 0 ? "" : ",", early->id->name);
> +	}
> +	lsm_order_for_each(lsm) {
> +		if (lsm_is_enabled(*lsm))
> +			pr_cont("%s%s",
> +				first++ == 0 ? "" : ",", (*lsm)->id->name);
> +	}
> +	pr_cont("\n");
> +
> +	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
> +	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> +	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
> +	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> +	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */
> +	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
> +	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
> +	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> +	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
> +
> +	if (blob_sizes.lbs_file)
> +		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> +						   blob_sizes.lbs_file, 0,
> +						   SLAB_PANIC, NULL);
> +	if (blob_sizes.lbs_inode)
> +		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> +						    blob_sizes.lbs_inode, 0,
> +						    SLAB_PANIC, NULL);
> +
> +	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> +		panic("%s: early cred alloc failed.\n", __func__);
> +	if (lsm_task_alloc(current))
> +		panic("%s: early task alloc failed.\n", __func__);
> +
> +	cnt = 0;
> +	lsm_order_for_each(lsm) {
> +		/* skip the "early" LSMs as they have already been setup */
> +		if (cnt++ < lsm_count_early)
> +			continue;
> +		lsm_init_single(*lsm);
> +	}
>  
>  	return 0;
>  }

