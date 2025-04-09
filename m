Return-Path: <linux-integrity+bounces-5731-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A628A8337C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1B43BA255
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF26021324E;
	Wed,  9 Apr 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YBST8raE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340319CD07
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234703; cv=none; b=LFDKE7C3fIQp3GrDbIV0ujMeCyZv9Zfv8mXScgnt2+BxAgJRwiFWwIwmMDvlh5PPrQ5bgvu508DcjEVBKf/jLj4xVUc5fUD/bbPj2QA2CHHzoyFxjTTuI5d0OWTVezMvU7H5aWh+zH/PNvn99v+ugA0JRnGClylmHiBE1KcaVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234703; c=relaxed/simple;
	bh=R82LSHj7N4tJ7gew6Nu23Tbw32/zF+eamEB3P8P9ZCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb+1pazooUhEhpUVX3nQrfTAlQBM8d0Nend3w/T9xPsBIFoK6nECjBO9m2x8z4tp2NtLz+bh0+7QwaLys1a2VRhZliR0OEy3GyIGFY5eoKnYJCt8or/kphjdjj5pxhUBHse+qrP6y19lU6ADcUxmIlc7EI37o5Ju4m4YsG2/FfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YBST8raE; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744234694; bh=BKwkbEL+xqeQQJIuEtRYzG8Md9h3vjR3z9rIUD97FVM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YBST8raE2WSQeIwZi6kLR8YmDiF9WXaHpamfyZtwbSQnUiIcRFupgojBk4UACbUbQDiMTjWmzF/u7kSYEfI5kx1Mc3kTJSJ/EToPVIhNpycjrqOPeg9SXgsi1g6w6E+g+Iy1ZKEO7bn6EyGGp+4Js6VlBLpVoDSlRF/cy9ktrElLkaut9yq16qUZFKmuG6ITQthRH0Fd5+Rbev242spn5d4GQi/uXjKpGzyRVTTJkXqlJjBo/9KZz/GLs2P/+KqtrOG2euUGNN58ah6bwZ6pUSXCpv286aJ41rXgs/AkIBCR+OHAu6jvBxOhmQ0GhSAiQHdTvGQxQXxMmuxZaD94yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744234694; bh=Rw/iRMW8D02TzQ42RckUVB2t5gJ72fIbqIFXJ4Xd50Z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nopo1DDHdA3ijAeH6D11Ccq8WdhfhbutCdqQ5xHXyxWifAhpDgkq0m+VE0mhg2s6074tIyKfvTOE+YvvY2kUETCJwfq9jp9Eii9IgkHf7virb4I7eDy5TA9ZewqKoHhwIvxkfBXicqZGqdLR34mALYHvWwR1/hvaBd9qvecMDlbpv4t9AMvxSs2lefobAFwqdtpxD2lK0uU8Op0QnIzcmZadakT14P38cfhMZJyawJqcwfwce9xx6Mof2F3gLMwEb+UxRcOxFQOkUPygzs2LBcZMaY4W2cSqYqjfOX6SxgmoFfbA+cVSLZ+PhNEuJkZbbBWzPYbCJA9M0DEjqtJhAw==
X-YMail-OSG: FGeAXPcVM1kdVeFnNkj7_LXN0d9YeyR9S_Vp0aEDLzrqieXrMNFYBW9fswlDdlH
 pGht3WKU7FhaMSKVwnneglu_geiKCQ4uVnyAcz2RTtwxIG4huJVxBF5Zkqd6r4mhwWcGW6ZbJVKQ
 BmO2_ochDxs1EVweEfiVKzvmAJlXHPjKvp0iecCnSnqsxJr6pzCQy.Sd4_gEuvv0U8xuqX96z5kZ
 Lh9wAKYfQUVE1sCGhxXCqTEcqv2hkpXb2EczMOJxpv39l3y5SaE_Ge6K62YiHgsH6GHmuJmMTe32
 lO__h8DgmT8U868QxnmAfCEjWqo59lVTHNflvWewPJv3sTvx_lH35XDjMM2XdFi5gT49YaHm4BLQ
 cPzWo8OeTblmlOz7dIQCVAdxHY7RZt2Lo7Uxh2pyVr90uJB5nRLhX4PfhWIOqLG.8GbDn78pe_mN
 dq_RBlXpkQrijNZQDX_v622Ekbns3txe4iI1UIEwJQoXMzndjLPOdobEQU8DtQ78tR2qlSgMKvkD
 dKVd4bh4F8AVrAsNPBtO6tM1_zU5p68D8O4dUZ82CYCVMm0_0rsPwbgVGjd0IiSykV8RhA38unA6
 B90V6Xftjtl5icVBEE_G4ESH_tDKDe7xJq0DGL2qg_xaxhoRHNmBX8QJlzJDsiGgljTIxhl0QolG
 rsTHsLHjPrykKlhd5hAs76Aa2SxTq8cDE1gjPsOXQLCGw3Lrl11tELgxRl8DllM3jIBYZDlFULN4
 HLvpSKt2dufcK_UFUNqSW_TMB.LOn2CO0BIGTnyHmW0Le94e1sEWguhQyHIB9xFDMkfikH3IdBwV
 xbIOr9zrEDSvnB5ZbYo26RlK8MvMyXaMeF03CyfSNIgSYZFJ3TZ2JR2qaeE3vZvldi6gRRjMpQCH
 m7NbvNR6XJLIsS5o0iMNWtZuwmuUotuqr1ZMS2rwMd0gGW7PHRqLK3YCTjfSwNr.PVP00McY1lG3
 GgChtxiiB9GbhTvlW1SCblbkPsjiBuWOrEQXVe9khMsXpJ1ntwfMvHcbU1O9Anx6bH5Mzkz_TKhO
 RFAuhYmlE5iCv77agB.XkVKW5pIQeK9g19H_PL1CUKc7uyStL56FtcShXhI9rn6h34RHvJt_WC9B
 qvC_U8DLkN8TwckL2gY8KHLyV8VUwxYRLmDt2qT2I4XyOLOEEUgz3n..04zswvUXs0c40pLq.nQJ
 txe9sbxbXd6z6yBwNm3trqMFSE_xHLgcZU6q7LeHPRSaPs504ZqLlqT8ciYzaRVJc4PHcAuT5X7V
 X8Kl5zRthaUDYys3SWvB6Rrfdeq41rHy0cHhJKbEx..zRvN.J7yHuZ3XmWdg1KJ2WSb.u4Ps5HMG
 qgPe8mdp08fqm2JFE0pj_O56W.0tOT6ttem.VXK5dFZ3wPIm8Ia_lfthxhC0bmF_mFtdk2WuYQXx
 2UZ1SFRAusZRX3hQUN0LzgFyIgNp5QgqqXYa_Pklf2dOvL8sCKLNx22jCpKwzJjzHIgRvfht1EM7
 ExbQLtJvmALRNfc.mhPR38VfhA2yohpPsa.HKLbl9QpXmmtabxkghqOYL.t1WCfD1NrRYhcof2S.
 5KbcX63BcrScN0m89uYbvAWjAN4cIUmiYa.7yEB.jhDLOc3pxWA.XYiwdh_1ydXoaU8RWFIg9I..
 CQ7PMY6sg1Bt6FnB2aJoPmfGmLZUN_c8fm.T.gSEJKgcMbt56sd6Tbh9kb.YlxWhntKKjOJ.Xgo1
 9qFBt02hWooTJXNJE5I3RmwiOcnntISgHLl3yAuflt_qklPh4lfn8.5eyt8Lm2uEg.Si.6EmIciK
 O7gT02jU9vztonRmNV_Lw1l3t34SvlZ0aFQtTFa4ZRl3.g2mdWElg3bRTXB12y.lCBjHKZl6wNIn
 .Tqe3qUtFQJgkSOGec_kVv2rmEhd5c0wNB4jr2shNcspm7dP1kMz5vJQTAdVXqxWvrkUaeNOUgiL
 c6XmI4.1pefX5_XP_nbJZ.Wy090Mf89.pWvTcz78RwRBn7ilONImbF7C7iIcmgDgoFoqqErDtcMm
 MbN_8vvNcr9.oi2MTeqKpSGiHP4b_DET_13pyWE2zpcwtMZoFM1ynDR8MfW836qdggN67XqdvPsV
 i_TBjONMI_06MyHgVA.2THfJ4Iy.QIi_qEXYnfyZk5_hXAmBsVPgFqg5qhbQ6_bqW1BjxjVzZ5BU
 DdAezByjF5TKuNE3DSrnvEWFh_3M56nJfZveRG1iSb2voLYEQHGfqFkGiDQ05DYcEd6JILShHAQN
 ILSjwgtrb.HN_q98_6A9mJzr6W8HNre5qm1CATbaJWng1nhtwn45bhO0W5NtFQl8HXRiVPVzm3Ti
 RJuiu2QYSC4VYcp_RTm.TkO7u64V8
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 795b897d-17e4-4e70-b3de-54f3abf86b2a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Apr 2025 21:38:14 +0000
Received: by hermes--production-gq1-6f8bfcd964-g9xd6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca171e99012c059d23a387c1d08bb5c4;
          Wed, 09 Apr 2025 21:38:08 +0000 (UTC)
Message-ID: <3da6eb0d-9781-4d9d-b6ef-f9105c231b17@schaufler-ca.com>
Date: Wed, 9 Apr 2025 14:38:07 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-38-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-38-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23590 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:49 AM, Paul Moore wrote:
> Move the LSM count and lsm_id list declarations out of a header that is
> visible across the kernel and into a header that is limited to the LSM
> framework.  This not only helps keep the include/linux headers smaller
> and cleaner, it helps prevent misuse of these variables.
>
> During the move, lsm_active_cnt was renamed to lsm_count for the sake
> of brevity.

lsm_count could be mistaken to be the number of LSMs compiled in
as opposed to the number that are active. Hence lsm_active_cnt.

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/security.h | 2 --
>  security/lsm.h           | 5 +++++
>  security/lsm_init.c      | 8 +-------
>  security/lsm_syscalls.c  | 8 +++++---
>  security/security.c      | 3 +++
>  5 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..8aac21787a9f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -167,8 +167,6 @@ struct lsm_prop {
>  };
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> -extern u32 lsm_active_cnt;
> -extern const struct lsm_id *lsm_idlist[];
>  
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/lsm.h b/security/lsm.h
> index 0e1731bad4a7..af343072199d 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -7,6 +7,11 @@
>  #define _LSM_H_
>  
>  #include <linux/lsm_hooks.h>
> +#include <linux/lsm_count.h>
> +
> +/* List of configured LSMs */
> +extern unsigned int lsm_count;
> +extern const struct lsm_id *lsm_idlist[];
>  
>  /* LSM blob configuration */
>  extern struct lsm_blob_sizes blob_sizes;
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index edf2f4140eaa..981ddb20f48e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
>  static __initdata const char *lsm_order_legacy;
>  
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  static __initdata struct lsm_info *lsm_exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  
>  static __initdata bool debug;
>  #define init_debug(...)							\
> @@ -211,12 +211,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>  	}
>  }
>  
> -/*
> - * Current index to use while initializing the lsm id list.
> - */
> -u32 lsm_active_cnt __ro_after_init;
> -const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> -
>  /* Populate ordered LSMs list from comma-separated LSM name list. */
>  static void __init ordered_lsm_parse(const char *order, const char *origin)
>  {
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 8440948a690c..3fb0d77ae65c 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
> +#include "lsm.h"
> +
>  /**
>   * lsm_name_to_attr - map an LSM attribute name to its ID
>   * @name: name of the attribute
> @@ -96,7 +98,7 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>  SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>  		u32, flags)
>  {
> -	u32 total_size = lsm_active_cnt * sizeof(*ids);
> +	u32 total_size = lsm_count * sizeof(*ids);
>  	u32 usize;
>  	int i;
>  
> @@ -112,9 +114,9 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>  	if (usize < total_size)
>  		return -E2BIG;
>  
> -	for (i = 0; i < lsm_active_cnt; i++)
> +	for (i = 0; i < lsm_count; i++)
>  		if (put_user(lsm_idlist[i]->id, ids++))
>  			return -EFAULT;
>  
> -	return lsm_active_cnt;
> +	return lsm_count;
>  }
> diff --git a/security/security.c b/security/security.c
> index 8d370a4c5e74..a3e8dd640b39 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> +unsigned int lsm_count __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
>  struct lsm_blob_sizes blob_sizes;
>  
>  struct kmem_cache *lsm_file_cache;

