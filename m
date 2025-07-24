Return-Path: <linux-integrity+bounces-6719-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A6B11488
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6180188C82D
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5DB23BCF7;
	Thu, 24 Jul 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JQoXzTLb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6C1E500C
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399982; cv=none; b=hBsn9kjKAmc6F+XWMSUe84OgFXz2S67RcAF33Bgz9TYelsqe4p27n3IbTT7gIlifTAR2c+0DlZCu8fk+q1FqzHfebF+AS5DTi8QRuWDLVpTPIWgKVBW8KD+9wn24ifTZlxCoeYpVJqkr9aXbMOm1Zx2zNOjiAjbK/1tG7rcAlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399982; c=relaxed/simple;
	bh=qI3BvQZemMrBw1U6aS4agOdzJWSDrfTl0Tz1hCYJDaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGe7WD2ZjMtyMvbAoODh69Y7CtFl7QNt7z7Ai8GAcaSglnKzJDamLjqGcUiuGrBxGbKWe49QKDjMZ/dw/hN60EqAHAu0HEHlMZ9CdvAGnmbpAYA3dMfd7I8/6q4IIJ39nuOidhju3x5eah64TCcQMH5/e1j2p/DYeBrmXh9nhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JQoXzTLb; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753399979; bh=15AlHogZpYhRMwd700b1H/fwysD4eLnbXurHXDl+Qco=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JQoXzTLbqrENxaz2p4ZTceA/fQ1G36KYjuMyLPLBw7P6P3RKV/I/QXINUwaYA8ksWjJ1ZJNxBzOVi4d7BxQYpoi52nKfDBskzsVqAm2DL4dq2xCriKRJqWZ54o1ED6YWO2Yi1brBS/rpjQWczj5Bs7mf9KGTag32YHRnjyd8Mzt8vwCZ0xAL3lnqc0hoVeQbDD+mf7+IKeYRDC/K18X9EypI17lZfi4goLM0V83a54spBNofA3wNj9WStoa5uD7A9XWI7yzsi+nGpGx+GKmAcT7BgvZJ5t7jnuow5a+7YxZmdD/ruz+yBbSNBy98LiRdyXZeZIUqCARDY0bHgocxfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753399979; bh=IIkYRmc229kPzFLXOR5r7BLVxucl2Cfcf2dMUrubdy5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rOVylIgqgzoqQuhOCFlTACoSx99kB95RKijTIcAAh6lX5+aX0+KgADtMZoSV9eXKQXlCxgPwDFma6uXtjeweosLOxEp9SMO+ViKdPwA7HHeaudRRNmb3Z39WdVjrfohoizWHBTxhzqbs4zOvJSZRHseJz49GPDhyMfTLvvPPN3xLMQ5PCBL26eeOsaW+gEULDOFVIpxXBE3n1+p6ZumgKU1PgZQLehF2nrCCH03G5yRiYww6jBKxq5f80YaalMyRuq0a4fjvjUcFNwHVrXUM32t473zb+RCEeGhZKvhfK/9BbEhU+BmaQ77IOcw79V8+0jfy9ZIzPJHvqLNcp5HdIQ==
X-YMail-OSG: pyKvCjoVM1lhzyrdVx8kfL3wOc5tfaWNLqwODzbqRoE6_RU7kgbsY2rs7.lwpvj
 VvEwT5h1912L4Dhti2u.97OYnq6O.jYPE6UrrZdf4Sm0vGYxehU71Zl9I_m9fanJUHIuA6lXKGd3
 PtWB2mHNK62vGJohOVGnM3XjV2KYdakl2L7dhyMlA_DVyedXsc4EUCQmjWc3yDn3aSIREWkTK03t
 VoKp37FJmcEKqSWrT7ffsVLM5Oh6YDGY.LBRlZfiCi0wWY.c.S7FwdwXwH2h34YP8lc3IcHgBTiQ
 OwZJkFvy11gg6x1dnxuPpLv3_l7LU2pbTlBTA1tAR0KltNG4mHMjio.t7T4c3LPxZ9xYXNooe9Lu
 qlMX.aOw3AJR3O3Hf9pvYfjTr4bEPDUOMgw1y36Dn8rorZLtY98tAyB5PUlCbL5zQP9Dhia2Q6YW
 45aZFIH_ZsBKZFSfTE7HvcSFROqAXltABnlVbpQyzyfD6g7fI.eusZDtqYA.hgxp5gP.bnQqA7EQ
 6ag2BO2MATWis4Nty4niY1aLP0Xpr47PEBo9j28eLGbu0j_vcZMzV.Rcc.fo7tOmRWIRlx7nTH8f
 y2Vhsai88s.xXNTP7XjKQbATWgBKUfranOYlR1rk_wC4N699nFVTmSzqe2LA5ZhTHZk.WBvN9hzl
 6RKUqXixXjCL3sCyiXf6uVGZ94ildkaFJdAB9SgtJGjrS2C2plogIsFBT2LzSd0RkkEZndVJoaTz
 Gsbicm_m1M4RwL9WrBIIzmJK8ca0cN43Ird2ereKy1wL6P7wC5pN409H5Ayb6s9YaFNVEZgsDsdg
 Lmjvqd0J8Ne29htfhQIALH7R_qFVeLmi5BkqYSTLBPDdXkmKnoMIZhKk.rLSioj9R_16iqWZOXIt
 DveGYvtIUpY0rSDpdhFW2JQNhhnyF8.7RapuyUqhmvM11AjH3HgvmhVpphhKIf0_LXoVLvNw.SoG
 KVrJVibtmfQPuwbc5.0rBojSAH2GRv9hhiaxdVKJkujkkC8bE41Uz9Q97s6DuQmDwy0yMO7RctsX
 isKxBC_qwrtwZIrsPdwe6_nSVYQarHM_K1hXPSyolDbHkl67N8M1MCyO99nB9NvIVNyF1FGRAmgK
 mvHBCgyOwHHeEbL.JiTVge6mcwjPq0uSNUiJ5oLbDihDTQ3nw2iqreoCWDM8Z2eOQwwL2CK0AQqr
 qhPOsGr5oCD8_egyeRaDcFCwDtXpWteAbzOmASc6ksJ.iDioqYnpCCztnQ4KKPP09lA5PS8_8_Vs
 qVHPuS2wr49DYgHSZmiu7guZTHs.ZK1nKoy8UacZq70J3NtKno045b0XXLgIIjLskjd.kQ1Qsiqh
 jjfp.vtkU5zo9RD18bYeYCw7bDLuNQEXGU01Ps4j68RHDEhP1YZ7mw97nZ0_vE4T8itLdJvEdoW7
 Y4e52FwaqX8QZxIS1OrCsF5OdU.E4FKUckB06jR3JziDyetdkZdVb36pGV1fthQyBcEHepnfBVvS
 n7_4o1aVNSumIIL4ENnkvuBeo7e5CHBhvlrX4hA2zxzrw8gTkP4jqUw9tqxq2G0wWUsfrJHtHyXq
 f4yB5E1wGaSEA4Wx.RWMAc2Vr3cfCuZ8.UqOjq9cLsmYiBRVK1kdzMepag_dbpah7QtGmpJkZw5i
 ixk.ud4vQ0HWRRIKj_mZVQjIWRuiAM.hagqxiB.Q4GLnP0DzopAZzulV99QVYbVptWomjUYI67ME
 eY4A6lFK8FQ9XJqzbXDh1dkju57fNWHr0MMSF1Nw4hswvzNJuHWLv5TlqEmfwndq6d3lDGVtLJ2N
 JkTbvzHlXBR.1NQESwW._WTQKklalwXDeYwcjBtMxiHTeQjUrg5dAsb8iFjDwoEeFiQmesjFYvoi
 Mc1uJmvcqvGr3mddvEJK0BHQn0UecorlHxUa9.CRx3rH1DIiJN5dJFZ7kHon0kYHqEYvYOhtJPr1
 c8c17iRAVcovV51nBa8bmmMiZRRvZFJRWzUZiCO7rZMrUCjbm_Y2ove4s1PRbT9vc1gF28X0sODC
 McDz2PTy2_dn4sdU4HrIFA91CkUzHcMzgKWra9gYme54EvzD0MuOEtCHvGNJMKFNuqjGdgBEnYFN
 86n8UKVusRm7r5wmq2c29at4MMe_Chft1lT8byrp2P2QVSDTTffUr3m38MaGRxg5qwOdSJ6LsOW_
 .bDaHL1c_YNntoVeaStaxvTXLorKfJNhhqyLW_5FhzCe2Lnx57zhEPGips3t7lejZ9Ptn49QNi4N
 hnwMqBC_6UnfN7QF6KZtEx3fTg9K9pmLkw_3AQdkYBRX1fQIGhO0AYavCYCrbTuQ.A7b8VIMFfM.
 3.8kXKaCErX2Swui3zwayuuiokWM0_546AP_.t90J
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 271ecfae-aa9f-4d91-ad0d-46a3107e0cb0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:32:59 +0000
Received: by hermes--production-gq1-74d64bb7d7-5wzx5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46e3ad76557f4274467c8303f0561506;
          Thu, 24 Jul 2025 23:32:53 +0000 (UTC)
Message-ID: <49872772-335a-4828-8cbd-4f438633ebbe@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:32:52 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 20/34] lsm: cleanup the debug and console output in
 lsm_init.c
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
 <20250721232142.77224-56-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-56-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Move away from an init specific init_debug() macro to a more general
> lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
> both before and after init.  In the process we do a number of minor
> changes to improve the LSM initialization output and cleanup the code
> somewhat.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm.h      |  11 +++++
>  security/lsm_init.c | 117 +++++++++++++++++++-------------------------
>  security/security.c |   2 +
>  3 files changed, 63 insertions(+), 67 deletions(-)
>
> diff --git a/security/lsm.h b/security/lsm.h
> index dbe755c45e57..8dc267977ae0 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -6,9 +6,20 @@
>  #ifndef _LSM_H_
>  #define _LSM_H_
>  
> +#include <linux/printk.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/lsm_count.h>
>  
> +/* LSM debugging */
> +extern bool lsm_debug;
> +#define lsm_pr(...)		pr_info(__VA_ARGS__)
> +#define lsm_pr_cont(...)	pr_cont(__VA_ARGS__)
> +#define lsm_pr_dbg(...)							\
> +	do {								\
> +		if (lsm_debug)						\
> +			pr_info(__VA_ARGS__);				\
> +	} while (0)
> +
>  /* List of configured LSMs */
>  extern unsigned int lsm_active_cnt;
>  extern const struct lsm_id *lsm_idlist[];
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 75e97f6b530c..0a8e4c725055 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
>  static __initdata struct lsm_info *lsm_exclusive;
>  static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  
> -static __initdata bool debug;
> -#define init_debug(...)							\
> -	do {								\
> -		if (debug)						\
> -			pr_info(__VA_ARGS__);				\
> -	} while (0)
> -
>  #define lsm_order_for_each(iter)					\
>  	for ((iter) = lsm_order; *(iter); (iter)++)
>  #define lsm_for_each_raw(iter)						\
> @@ -77,7 +70,7 @@ __setup("lsm=", lsm_choose_lsm);
>   */
>  static int __init lsm_debug_enable(char *str)
>  {
> -	debug = true;
> +	lsm_debug = true;
>  	return 1;
>  }
>  __setup("lsm.debug", lsm_debug_enable);
> @@ -143,22 +136,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>  		return;
>  
>  	/* Skip explicitly disabled LSMs. */
> -	if (lsm->enabled && !lsm_is_enabled(lsm))
> -		goto out;
> +	if (lsm->enabled && !lsm_is_enabled(lsm)) {
> +		lsm_pr_dbg("skip previously disabled LSM %s:%s\n",
> +			   src, lsm->id->name);
> +		return;
> +	}
>  
> -	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
> -		 "%s: out of LSM static calls!?\n", src)) {
> +	if (lsm_active_cnt == MAX_LSM_COUNT) {
> +		pr_warn("exceeded maximum LSM count on %s:%s\n",
> +			src, lsm->id->name);
>  		lsm_enabled_set(lsm, false);
> -		goto out;
> +		return;
>  	}
>  
>  	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
>  		if (lsm_exclusive) {
> -			init_debug("exclusive disabled: %s\n", lsm->id->name);
> +			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
> +				   src, lsm->id->name);
>  			lsm_enabled_set(lsm, false);
> -			goto out;
> +			return;
>  		} else {
> -			init_debug("exclusive chosen:   %s\n", lsm->id->name);
> +			lsm_pr_dbg("select exclusive LSM %s:%s\n",
> +				   src, lsm->id->name);
>  			lsm_exclusive = lsm;
>  		}
>  	}
> @@ -167,9 +166,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>  	lsm_order[lsm_active_cnt] = lsm;
>  	lsm_idlist[lsm_active_cnt++] = lsm->id;
>  
> -out:
> -	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
> -		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
> +	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
>  }
>  
>  /**
> @@ -236,7 +233,7 @@ static void __init lsm_init_single(struct lsm_info *lsm)
>  	if (!lsm_is_enabled(lsm))
>  		return;
>  
> -	init_debug("initializing %s\n", lsm->id->name);
> +	lsm_pr_dbg("initializing %s\n", lsm->id->name);
>  	ret = lsm->init();
>  	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>  }
> @@ -263,8 +260,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
>  			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			     strcmp(lsm->id->name, lsm_order_legacy)) {
>  				lsm_enabled_set(lsm, false);
> -				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   lsm_order_legacy, lsm->id->name);
> +				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
> +					   src, lsm->id->name);
>  			}
>  		}
>  	}
> @@ -307,8 +304,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
>  		if (lsm_order_exists(lsm))
>  			continue;
>  		lsm_enabled_set(lsm, false);
> -		init_debug("%s skipped: %s (not in requested order)\n",
> -			   src, lsm->id->name);
> +		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
>  	}
>  }
>  
> @@ -316,7 +312,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
>   * lsm_static_call_init - Initialize a LSM's static calls
>   * @hl: LSM hook list
>   */
> -static void __init lsm_static_call_init(struct security_hook_list *hl)
> +static int __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
>  	int i;
> @@ -328,11 +324,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  					     hl->hook.lsm_func_addr);
>  			scall->hl = hl;
>  			static_branch_enable(scall->active);
> -			return;
> +			return 0;
>  		}
>  		scall++;
>  	}
> -	panic("%s - Ran out of static slots.\n", __func__);
> +
> +	return -ENOSPC;
>  }
>  
>  /**
> @@ -350,7 +347,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
> -		lsm_static_call_init(&hooks[i]);
> +		if (lsm_static_call_init(&hooks[i]))
> +			panic("exhausted LSM callback slots with LSM %s\n",
> +			      lsmid->name);
>  	}
>  }
>  
> @@ -381,19 +380,16 @@ int __init security_init(void)
>  {
>  	unsigned int cnt;
>  	struct lsm_info **lsm;
> -	struct lsm_info *early;
> -	unsigned int first = 0;
>  
> -	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
> -	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
> -	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
> +	if (lsm_debug) {
> +		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
> +		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
> +		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
> +	}
>  
>  	if (lsm_order_cmdline) {
> -		if (lsm_order_legacy) {
> -			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				lsm_order_legacy, lsm_order_cmdline);
> +		if (lsm_order_legacy)
>  			lsm_order_legacy = NULL;
> -		}
>  		lsm_order_parse(lsm_order_cmdline, "cmdline");
>  	} else
>  		lsm_order_parse(lsm_order_builtin, "builtin");
> @@ -401,35 +397,22 @@ int __init security_init(void)
>  	lsm_order_for_each(lsm)
>  		lsm_prepare(*lsm);
>  
> -	pr_info("initializing lsm=");
> -	lsm_early_for_each_raw(early) {
> -		if (lsm_is_enabled(early))
> -			pr_cont("%s%s",
> -				first++ == 0 ? "" : ",", early->id->name);
> +	if (lsm_debug) {
> +		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> +		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> +		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> +		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> +		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> +		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
> +		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> +		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
> +		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
> +		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> +		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
> +		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
> +		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
> +		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
>  	}
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
>  
>  	if (blob_sizes.lbs_file)
>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> @@ -441,9 +424,9 @@ int __init security_init(void)
>  						    SLAB_PANIC, NULL);
>  
>  	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> -		panic("%s: early cred alloc failed.\n", __func__);
> +		panic("early LSM cred alloc failed\n");
>  	if (lsm_task_alloc(current))
> -		panic("%s: early task alloc failed.\n", __func__);
> +		panic("early LSM task alloc failed\n");
>  
>  	cnt = 0;
>  	lsm_order_for_each(lsm) {
> diff --git a/security/security.c b/security/security.c
> index 106f225f4a80..9dd1435f9965 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> +bool lsm_debug __ro_after_init;
> +
>  unsigned int lsm_active_cnt __ro_after_init;
>  const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
>  

