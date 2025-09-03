Return-Path: <linux-integrity+bounces-7002-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0879B41BAB
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4A3A1F6C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE1286889;
	Wed,  3 Sep 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vtaN4XxF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B644204E
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894934; cv=none; b=CQBN4mWzwP+bSgKNcmn1f+z1FhOG3mc29QthiaghfRiNoAtl0gR03P3sTxZJEd3PqERHBaM249nnIaxWxbbbzou+a12KIXY/Jg9CkWBHBj3oB3YxcG5qewhEpENiJuHS9e7hDPRsxFcDjGr78zAB9ShIWiWvPnqi2R2MxDHCQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894934; c=relaxed/simple;
	bh=6ldFftuBmSJ4jN2N2fWS+bZRb2qjKnaPwAXrXw3rlkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx7hfsCwcORyRujL0StSU8XHm+HutNfWWDQpwcoqCdPwEe6Z15TjRVph1KC20WPnRNPrJswkInAlMMPgIEYj5kPgLH6XPMuulgtosTseoq60GtHYVRsZsGnVteqcf/t8iLf2NifLSX5AftyIVJ9gcnVpnyxy0DgvcXv7hTlqK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vtaN4XxF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 17DF93F681
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756894929;
	bh=lHCz3NMqznmzfsG/CHMRSMl43bn2mVbTvbWSD58QCHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vtaN4XxFoWmI72Obq3SZqXF/N1qCJharjtWJU8ly6vz80tu0SLiADLevmiHlKgh5I
	 2FdS3pTs72f5qCmOZkNTrXe4hPoGyh55tD3N1XYcTBnSEOywoETQuwco2tbchtk4RB
	 6PM3nY5KC1BslhcYZWerDJ1ELy5aMh92enlKiS7QXCZ5D//tOtkE39s3X7FTcPITcf
	 euG8ah71TXVBsJoW3KjudlvJkAY9tyk+ojHnJpjs0ywVPDoauZwpX5buDvke03hUq4
	 wSzgVrNt4x+9x7KAt4hp+bp9jZm/Y58aFh++m+fEWJO7mXrjSHbOJhnNY8aeMZ9Qis
	 tzgBmC50Bm8BQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-325b2959306so10596180a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 03:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894927; x=1757499727;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHCz3NMqznmzfsG/CHMRSMl43bn2mVbTvbWSD58QCHI=;
        b=J/O6a/DteY9n0ySWtxKCFcv3RRfkYXyHtVs01SSTCGKS39cYRnu7CVRwrMB42zuHCp
         fSZNTjWXoj+wVaJQDpjMqyZn6QQOZYG7KK5UG7dmDJ8EOv+hM7rKGWcZ7b7q3URjd5DC
         KRtw9zcRQQdEKzdt459Q3y/YsdEV8Fni6owByiIna0jIChdaagY0x5OP9mzcQ0A0bt2k
         wrHCI4zc5AsRXQRCumoRxjSWgnGhgM1FK2K18gO7++zxF/1DkACBG2dBUckaEb09IlDk
         2IDQDEFiGYrZaJSZ/rP9+5fRNgCTqxKePTd8cO1vb1irjbY3Fq4UW5+TF1qobIigBvNV
         bH7w==
X-Forwarded-Encrypted: i=1; AJvYcCXnR1GWovUiZctUhUhc7AakLadtT3Zf4qoSv+2BBz3FwbSmcCjhwgMVercyQhadi8M2Eio++uQ8CaDygufQ00k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGBTrSH25JHYSUieCOUvL6DGYh9jclL4N7hO/LnSF+1NF9MKZ
	vB/ObEsBMPlxtryfuFzqF4RKKKmptS/u92Fjux1TCj6iiUjxYVeCexrQgNxNQ4HBkRIwDfTUONv
	Nc/Rro8Uw7+Z9alZBvKRrQNrUMd9WGWUOS0HFaADohr7Vl8r+gRV7EQlHfK/bijvYLwYWbz+JhZ
	Eqk9gq5zubdw==
X-Gm-Gg: ASbGncsOE9/PRCjIywVCHcdw33+Bi5NpOC5IvfvY2tUFvWUkC5h70bTI/HXg7pidzMS
	8jFqRpRPjeir7Pqb3RUWcbRFmAAc0tFTLREuEavcRznGXs05+UkT6UwuiaT5PMCQwEzVL4NAcMG
	R02+GQKD0dY74Qs75vYSOz+G7xDRxNhU5xKc2VPLa9W7u7A+2AnyItLIkgE0OTo1FEQT8lSTPiW
	VaPxY3sVZnpMA/xjApwphLaimiFeei/t1mWhZTxNrG24h2pSdOo1vnGX+MDRIOR20ZKuXCu8WTv
	eiLFJSujEmoK1qUkRrFwpIZpt+DDYaCsDQ/o2upDBRKhtn4cr0Jx/w==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr15553006a91.5.1756894927521;
        Wed, 03 Sep 2025 03:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUc9MsEnOB5zFHhrC4GPIVt04uDe9KvRYLvyWLer3axOPYOd/tXBbTCGZA7oezno9EJ4CexQ==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr15552979a91.5.1756894926976;
        Wed, 03 Sep 2025 03:22:06 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327da8e7186sm17157712a91.16.2025.09.03.03.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:22:06 -0700 (PDT)
Message-ID: <68fb24bf-46a9-4333-86df-654013468455@canonical.com>
Date: Wed, 3 Sep 2025 03:22:05 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/34] lsm: cleanup the debug and console output in
 lsm_init.c
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
 <20250814225159.275901-56-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-56-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Move away from an init specific init_debug() macro to a more general
> lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
> both before and after init.  In the process we do a number of minor
> changes to improve the LSM initialization output and cleanup the code
> somewhat.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm.h      |  11 ++++
>   security/lsm_init.c | 123 +++++++++++++++++++-------------------------
>   security/security.c |   2 +
>   3 files changed, 66 insertions(+), 70 deletions(-)
> 
> diff --git a/security/lsm.h b/security/lsm.h
> index dbe755c45e57..8dc267977ae0 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -6,9 +6,20 @@
>   #ifndef _LSM_H_
>   #define _LSM_H_
>   
> +#include <linux/printk.h>
>   #include <linux/lsm_hooks.h>
>   #include <linux/lsm_count.h>
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
>   /* List of configured LSMs */
>   extern unsigned int lsm_active_cnt;
>   extern const struct lsm_id *lsm_idlist[];
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 37593805ba9e..2f7ae26fca0f 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
>   static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>   static __initdata struct lsm_info *lsm_exclusive;
>   
> -static __initdata bool debug;
> -#define init_debug(...)							\
> -	do {								\
> -		if (debug)						\
> -			pr_info(__VA_ARGS__);				\
> -	} while (0)
> -
>   #define lsm_order_for_each(iter)					\
>   	for ((iter) = lsm_order; *(iter); (iter)++)
>   #define lsm_for_each_raw(iter)						\
> @@ -77,7 +70,7 @@ __setup("lsm=", lsm_choose_lsm);
>    */
>   static int __init lsm_debug_enable(char *str)
>   {
> -	debug = true;
> +	lsm_debug = true;
>   	return 1;
>   }
>   __setup("lsm.debug", lsm_debug_enable);
> @@ -143,22 +136,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   		return;
>   
>   	/* Skip explicitly disabled LSMs. */
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
>   		lsm_enabled_set(lsm, false);
> -		goto out;
> +		return;
>   	}
>   
>   	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
>   		if (lsm_exclusive) {
> -			init_debug("exclusive disabled: %s\n", lsm->id->name);
> +			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
> +				   src, lsm->id->name);
>   			lsm_enabled_set(lsm, false);
> -			goto out;
> +			return;
>   		} else {
> -			init_debug("exclusive chosen:   %s\n", lsm->id->name);
> +			lsm_pr_dbg("select exclusive LSM %s:%s\n",
> +				   src, lsm->id->name);
>   			lsm_exclusive = lsm;
>   		}
>   	}
> @@ -167,9 +166,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>   	lsm_order[lsm_active_cnt] = lsm;
>   	lsm_idlist[lsm_active_cnt++] = lsm->id;
>   
> -out:
> -	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
> -		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
> +	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
>   }
>   
>   /**
> @@ -239,7 +236,7 @@ static void __init lsm_init_single(struct lsm_info *lsm)
>   	if (!lsm_is_enabled(lsm))
>   		return;
>   
> -	init_debug("initializing %s\n", lsm->id->name);
> +	lsm_pr_dbg("initializing %s\n", lsm->id->name);
>   	ret = lsm->init();
>   	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>   }
> @@ -266,8 +263,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
>   			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
>   			     strcmp(lsm->id->name, lsm_order_legacy)) {
>   				lsm_enabled_set(lsm, false);
> -				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   lsm_order_legacy, lsm->id->name);
> +				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
> +					   src, lsm->id->name);
>   			}
>   		}
>   	}
> @@ -310,8 +307,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
>   		if (lsm_order_exists(lsm))
>   			continue;
>   		lsm_enabled_set(lsm, false);
> -		init_debug("%s skipped: %s (not in requested order)\n",
> -			   src, lsm->id->name);
> +		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
>   	}
>   }
>   
> @@ -319,7 +315,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
>    * lsm_static_call_init - Initialize a LSM's static calls
>    * @hl: LSM hook list
>    */
> -static void __init lsm_static_call_init(struct security_hook_list *hl)
> +static int __init lsm_static_call_init(struct security_hook_list *hl)
>   {
>   	struct lsm_static_call *scall = hl->scalls;
>   	int i;
> @@ -331,11 +327,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>   					     hl->hook.lsm_func_addr);
>   			scall->hl = hl;
>   			static_branch_enable(scall->active);
> -			return;
> +			return 0;
>   		}
>   		scall++;
>   	}
> -	panic("%s - Ran out of static slots.\n", __func__);
> +
> +	return -ENOSPC;
>   }
>   
>   /**
> @@ -353,7 +350,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   
>   	for (i = 0; i < count; i++) {
>   		hooks[i].lsmid = lsmid;
> -		lsm_static_call_init(&hooks[i]);
> +		if (lsm_static_call_init(&hooks[i]))
> +			panic("exhausted LSM callback slots with LSM %s\n",
> +			      lsmid->name);
>   	}
>   }
>   
> @@ -384,19 +383,16 @@ int __init security_init(void)
>   {
>   	unsigned int cnt;
>   	struct lsm_info **lsm;
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
>   	if (lsm_order_cmdline) {
> -		if (lsm_order_legacy) {
> -			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				lsm_order_legacy, lsm_order_cmdline);
> +		if (lsm_order_legacy)
>   			lsm_order_legacy = NULL;
> -		}
>   		lsm_order_parse(lsm_order_cmdline, "cmdline");
>   	} else
>   		lsm_order_parse(lsm_order_builtin, "builtin");
> @@ -404,38 +400,25 @@ int __init security_init(void)
>   	lsm_order_for_each(lsm)
>   		lsm_prepare(*lsm);
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
> +		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
> +		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
> +		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
>   	}
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
> -	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
> -	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
> -	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
>   
>   	if (blob_sizes.lbs_file)
>   		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> @@ -447,9 +430,9 @@ int __init security_init(void)
>   						    SLAB_PANIC, NULL);
>   
>   	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> -		panic("%s: early cred alloc failed.\n", __func__);
> +		panic("early LSM cred alloc failed\n");
>   	if (lsm_task_alloc(current))
> -		panic("%s: early task alloc failed.\n", __func__);
> +		panic("early LSM task alloc failed\n");
>   
>   	cnt = 0;
>   	lsm_order_for_each(lsm) {
> diff --git a/security/security.c b/security/security.c
> index add46073af0c..c9642020755e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>   	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>   };
>   
> +bool lsm_debug __ro_after_init;
> +
>   unsigned int lsm_active_cnt __ro_after_init;
>   const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
>   


