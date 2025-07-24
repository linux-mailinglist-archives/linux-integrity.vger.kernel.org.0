Return-Path: <linux-integrity+bounces-6703-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C0B10E0E
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9F2AC72B4
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B992E8DF1;
	Thu, 24 Jul 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="obYW+7IW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47F2EA154
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368640; cv=none; b=MjD53k48jKKjSCpUd1gCAvwSNPgyP6cmCjZy0FmXBqvAW/H9egoAS5UeuqmSSUOFpzI9GlpcHV98QFz99+CoM8b3mbOYydwDWUJeCoIDwljTcv86dxy4zuS68s36cPcm73m6k5b0tNzDi907mPGxumGpS1QiUldZgMyAwN0fnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368640; c=relaxed/simple;
	bh=BjH315SGYWUfQLfYN+UcCRlsHmQbEQdEZ3H48SGrfOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns+pKoBOO3wq+sdjNkDvBe8WaZTEQgjrFam4vEftK5tzRaKWTTxsRbLJQ9IxkGjnSGesRk7BnpRbpwGeXvhldiqSVYkaJFTCKmzyVK/0Vp2ZObA3nuWio8Sa1MRv2aRIv1a812MkU5cGPj2SNUYjBUUX2lkbmhJ35ljbiSf+fSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=obYW+7IW; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753368636; bh=tVD3JxsoJQVkZHdvS5msfPA5fbGpFlS0BodHUHzrLJ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=obYW+7IWxs7sW1Czt8jATFDT1ActQetWeTfu4bmsVkGz7L2anCOaN1mDGSBQN/RPwg0ufjnZszMJjPx+nCmpfFp3sEeG2SILf5aWwx6n1amNFPTAfwSi1vNPnhiQzuqK0T932vt7C/56aCN2Sgdgt+pnVoOXykE9XkfZGZh9e2qV1yr05nabfAaEbLcYo+LfwAWXnvgKkHPXGdxK8XSktfPAy7YuKCXiqq34IPM/SlYwWd8eEn3Ndf/6nrx+hz6ChdQQIwA6bedLV1MsB0jaaAMOmC9ryFJEhHlD0RuCgiEZi9CMiTuZdk6ku8k7PQdGGYOWYugf2CEf332p89qGQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753368636; bh=KGynvuox3NVcK4HhC7uEmUV7zTJLlgFYyxE9/XreuEY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aCPJNX1GIDGyleOIAj8vKc8eHJUIX8k7AaQxCdfsnPK4/gKE8ysMXbl4N3lfTBTfeNNRQrktKb84RPAGO7iCViXJRSsSwUJQ/M0VdOJX+HT4dYEWOlk9RpjFP5O58o02Ot8JwDx+iiowPeyeRAybEwL6KbqyMlw/AA2z7W+Wo2exEba1hBhfff4xZOBBroOl9Seb9PLGy4eYKzJQvvRef0zugd1RTKfcKNEu/66BR9laebxlwuMATldXOlraJk+yPnDQhFfx2PH1DReS/K3blnMm5Mjds0K6MybENDJQ9RUqh5F0+JKKKJsFHXmGIvE1W7IEChIChhzgyEPSDSE7EQ==
X-YMail-OSG: hr_2aL8VM1mEI__m7pq1rKqBAbCyaRbYh9Q2g8ZiOe.BV7AwOqxscisDbtN271Y
 zLWDBVznSbyZFHWm4nCxr6vEB1M8_EfwVjCkoUKxf4_ZjAPWOuSC7cgzULAJrMpi_wn.50ZD.AOG
 PDimeTn9AAV4l.jGE_9eA2AoczcCL9.CvhY3Xm5t.LOqzsNNhvrDzXyzmkr3ZYvdurLQntacO_yi
 sUHcpfLmiTsG_VkvPVdrqC3UgpHTG7iwZd8xHzFsWnP4h8TpLVkxfl35PIoIzCtE2JIRf3GdVY1N
 gJ9wsDYPo68B5s47Chypz9ORTZq60BjMllexwQPGbppapcKUNPiojB7JvPpWGKmGhSFyOhqPf_R.
 NWoTfA.LrkdmjWhiurq1HrS6kZoD82Yq8ctZp1aYJ_bSVFlcWvQzDucFRsPqB8zIY7M.7cVLExmd
 vgyD23L1dw.FRMp9pjN6HPOHTRoB8uq4N.m2QfDAUZw0BuQFuUQC49ZZPfcqwWEPskB1JiPPEmK7
 JfPTJ5aKh1cyH97KJ5Bj95VtSICTMGwg991XdZwyftJQ6ezi.LQJhMWMVSgcf.3fzads4EftuSYh
 aIifbiIl39rq.pzYKDw5AsqEN91tKB_UuOTDyTwIjAdEMFQj0THA5BQqaf_f.DTplho67dQ9CnFF
 uCnbmlHung8_Q5uoTvvheOh8zIousBP_lKj5ZIv58cZhU5_c28MgLIyCh3.vr0HnibvJM1RsFomF
 MYEL354NChpBibylhWgTE5DKXQMKqDIy9HhaGeAv9vd4Y.IAHP2O_6T2C0pbc1mZVlFGjeBZwRAH
 nRoZB3oUXjKiHp7icaGNbQY4wnYKpW6X9L8kVK99PpONnz2MxHVRlVKd7Xh4KotJp17lXR4pMeWJ
 MmyoVqC2Tqv.aDsXj_omIEyYP5B6X_MlNm15qoAlJKL7R.0bWrWObUyPnnuY7XbFvL5a.fiKrzaz
 h2xQiOnIN2jX0OqF.mzku3OkZbxUxb.Mk4tMGS6tXqBfFs.txxZ1.4TIIkohObYti54.Aqk66GgI
 HtGJEiV_9KLdzYtqTlJtdxrzv1HCWc8Ct4NyCm4p6A4IhKsByeqjX0jC9ZUh6kBGDHRF7tIV7Vtc
 uN0v9VxEK1FYkfrRukWOjjr2WKxqDjWlOgitoS_QHchSRhctrHcqVSfWvfY0tx3W9JPpiK.bkfVH
 hM2WboBFUAC9JW0wm1Kih3wOABTxqhMHNGEneVUFzbXNUYBf_SamVsrZ0YnBLMP49sa7l7SFqRBL
 DFoLN9s8tZ8yDByniUgdQaltohNBoXf__wUZudEz0zwUI94CzaCUDURtReHdYt7w7APzSBM0Y61R
 IinQfAwMCVINiyBTBJHG_h8HnwynNfGObfngR_zuiYoB.ryU8CbZyR5paCgQgrOlAtFTuFig3I0J
 Hn9jIpw4Rzs8vccYC.MPsGos1bPJhv8wuAlc4K4bLNYFaTHQwXUq_qCd.9JAatS_Dhy_oYWstICs
 AxGhE5LhPbpU8iWJ0KH.3SJMk9a5yOsEsYELY95w5Y6xiPtdJPcMyb8IIY5tCBAJcSP9AMCjThLL
 mQ1IrOmdASNr719wrrN_BTxJ731szJ8Q4RO9YPV17ZYf3Q4GN1TvqTIgIQpPUtkE1LKzbxMq8DBj
 iNJRkw8jdeO0LhXgMZ_j2rMZTOwbh7LARv0xidGloAdOlVzR6kI7YrTWDqYv3WkRToZdrbdPkx.O
 ldaZitQ8YMAe6YB1C59vjgBQ4ijfyETDEwdt3Mfo1fb0el7nGvGB9F2LPO0o8F315QswtlmQaXjx
 D3IrLa2ePGIbfFZP.yBsZnF25hP1jKvVD677u4hxu1ZZF5IaLqkwD9Ejal_RAhGkjwuFxPi9bbs2
 hp217ovenr59zYqKo9Tv2nSsVaICoIb70yRsm06So9DUHJ3p4k3NoKMAYWfYVQ5Wr7ryHJfSTDqC
 U2Yx.O5a1SKbMpz9FPNdrF1eTD3kfmBiioMf4.o3AvuaVvOc3m.I3xj6SPAJKU.6y0PANwtKpnPF
 g9YULPRXjRdojvpFI_r1O9Ukidg4G5wPQOtEVEOngG1IFMJbJfUfy1xZnCip63JGRWEdlIEziToW
 5d3skalz_DZDxL382ZLBn73uw9MfZYyP1L2DPpeEuYgMSH_r5yMSoC7P37BLALbp8CFYHEBNGC3I
 UIIcB1fflpkNPxzLIO5ctO8JrLMZFsX04wIYtNHV1zpmqfk1lOhhiYplbMAvmXPZRFI1Wt.aILAf
 QvvqchjFQqq9PrI2zm1qtBZrDxjR2d.AivKj9.Oa8u8.lmLFokFYkNxirGXQYaoY.33tIaAIcJ3Z
 LjVYgy4dH.gDTQ4F07KPYBt7b7DXR2kdRbirN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 045e5c58-5218-4991-a171-3fc2b2ad1dcb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 14:50:36 +0000
Received: by hermes--production-gq1-74d64bb7d7-4jn9v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 97a3247265eac70b86f54749fa70c9d6;
          Thu, 24 Jul 2025 14:50:33 +0000 (UTC)
Message-ID: <f3c79703-b9b4-432a-88db-772825276d85@schaufler-ca.com>
Date: Thu, 24 Jul 2025 07:50:31 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/34] lsm: split the init code out into lsm_init.c
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
 <20250721232142.77224-38-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-38-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Continue to pull code out of security/security.c to help improve
> readability by pulling all of the LSM framework initialization
> code out into a new file.
>
> No code changes.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h |   3 +-
>  security/Makefile         |   2 +-
>  security/lsm.h            |  22 ++
>  security/lsm_init.c       | 537 ++++++++++++++++++++++++++++++++++
>  security/security.c       | 591 +++-----------------------------------
>  5 files changed, 595 insertions(+), 560 deletions(-)
>  create mode 100644 security/lsm.h
>  create mode 100644 security/lsm_init.c
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 090d1d3e19fe..eeb4bfd60b79 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -167,11 +167,10 @@ struct lsm_info {
>  		__used __section(".early_lsm_info.init")		\
>  		__aligned(sizeof(unsigned long))
>  
> +
>  /* DO NOT tamper with these variables outside of the LSM framework */
>  extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
> -extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> -extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
>  /**
>   * lsm_get_xattr_slot - Return the next available slot and increment the index
> diff --git a/security/Makefile b/security/Makefile
> index 14d87847bce8..4601230ba442 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+= min_addr.o
>  
>  # Object file lists
> -obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
> +obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o lsm_init.o
>  obj-$(CONFIG_SECURITYFS)		+= inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
>  obj-$(CONFIG_SECURITY_SMACK)		+= smack/
> diff --git a/security/lsm.h b/security/lsm.h
> new file mode 100644
> index 000000000000..0e1731bad4a7
> --- /dev/null
> +++ b/security/lsm.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM functions
> + */
> +
> +#ifndef _LSM_H_
> +#define _LSM_H_
> +
> +#include <linux/lsm_hooks.h>
> +
> +/* LSM blob configuration */
> +extern struct lsm_blob_sizes blob_sizes;
> +
> +/* LSM blob caches */
> +extern struct kmem_cache *lsm_file_cache;
> +extern struct kmem_cache *lsm_inode_cache;
> +
> +/* LSM blob allocators */
> +int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +int lsm_task_alloc(struct task_struct *task);
> +
> +#endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> new file mode 100644
> index 000000000000..70e7d4207dae
> --- /dev/null
> +++ b/security/lsm_init.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM initialization functions
> + */
> +
> +#define pr_fmt(fmt) "LSM: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/lsm_hooks.h>
> +
> +#include "lsm.h"
> +
> +char *lsm_names;
> +
> +/* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
> +extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> +
> +/* Boot-time LSM user choice */
> +static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
> +static __initdata const char *chosen_lsm_order;
> +static __initdata const char *chosen_major_lsm;
> +
> +/* Ordered list of LSMs to initialize. */
> +static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> +static __initdata struct lsm_info *exclusive;
> +
> +static __initdata bool debug;
> +#define init_debug(...)							\
> +	do {								\
> +		if (debug)						\
> +			pr_info(__VA_ARGS__);				\
> +	} while (0)
> +
> +static int lsm_append(const char *new, char **result);
> +
> +/* Save user chosen LSM */
> +static int __init choose_major_lsm(char *str)
> +{
> +	chosen_major_lsm = str;
> +	return 1;
> +}
> +__setup("security=", choose_major_lsm);
> +
> +/* Explicitly choose LSM initialization order. */
> +static int __init choose_lsm_order(char *str)
> +{
> +	chosen_lsm_order = str;
> +	return 1;
> +}
> +__setup("lsm=", choose_lsm_order);
> +
> +/* Enable LSM order debugging. */
> +static int __init enable_debug(char *str)
> +{
> +	debug = true;
> +	return 1;
> +}
> +__setup("lsm.debug", enable_debug);
> +
> +/* Mark an LSM's enabled flag. */
> +static int lsm_enabled_true __initdata = 1;
> +static int lsm_enabled_false __initdata = 0;
> +static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +{
> +	/*
> +	 * When an LSM hasn't configured an enable variable, we can use
> +	 * a hard-coded location for storing the default enabled state.
> +	 */
> +	if (!lsm->enabled) {
> +		if (enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +		else
> +			lsm->enabled = &lsm_enabled_false;
> +	} else if (lsm->enabled == &lsm_enabled_true) {
> +		if (!enabled)
> +			lsm->enabled = &lsm_enabled_false;
> +	} else if (lsm->enabled == &lsm_enabled_false) {
> +		if (enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +	} else {
> +		*lsm->enabled = enabled;
> +	}
> +}
> +
> +static inline bool is_enabled(struct lsm_info *lsm)
> +{
> +	if (!lsm->enabled)
> +		return false;
> +
> +	return *lsm->enabled;
> +}
> +
> +/* Is an LSM already listed in the ordered LSMs list? */
> +static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +{
> +	struct lsm_info **check;
> +
> +	for (check = ordered_lsms; *check; check++)
> +		if (*check == lsm)
> +			return true;
> +
> +	return false;
> +}
> +
> +/* Append an LSM to the list of ordered LSMs to initialize. */
> +static int last_lsm __initdata;
> +static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> +{
> +	/* Ignore duplicate selections. */
> +	if (exists_ordered_lsm(lsm))
> +		return;
> +
> +	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> +		return;
> +
> +	/* Enable this LSM, if it is not already set. */
> +	if (!lsm->enabled)
> +		lsm->enabled = &lsm_enabled_true;
> +	ordered_lsms[last_lsm++] = lsm;
> +
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +		   is_enabled(lsm) ? "enabled" : "disabled");
> +}
> +
> +/* Is an LSM allowed to be initialized? */
> +static bool __init lsm_allowed(struct lsm_info *lsm)
> +{
> +	/* Skip if the LSM is disabled. */
> +	if (!is_enabled(lsm))
> +		return false;
> +
> +	/* Not allowed if another exclusive LSM already initialized. */
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void __init lsm_set_blob_size(int *need, int *lbs)
> +{
> +	int offset;
> +
> +	if (*need <= 0)
> +		return;
> +
> +	offset = ALIGN(*lbs, sizeof(void *));
> +	*lbs = offset + *need;
> +	*need = offset;
> +}
> +
> +static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +{
> +	if (!needed)
> +		return;
> +
> +	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> +	/*
> +	 * The inode blob gets an rcu_head in addition to
> +	 * what the modules might need.
> +	 */
> +	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> +	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> +	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> +	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_set_blob_size(&needed->lbs_xattr_count,
> +			  &blob_sizes.lbs_xattr_count);
> +	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> +}
> +
> +/* Prepare LSM for initialization. */
> +static void __init prepare_lsm(struct lsm_info *lsm)
> +{
> +	int enabled = lsm_allowed(lsm);
> +
> +	/* Record enablement (to handle any following exclusive LSMs). */
> +	set_enabled(lsm, enabled);
> +
> +	/* If enabled, do pre-initialization work. */
> +	if (enabled) {
> +		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +			exclusive = lsm;
> +			init_debug("exclusive chosen:   %s\n", lsm->name);
> +		}
> +
> +		lsm_set_blob_sizes(lsm->blobs);
> +	}
> +}
> +
> +/* Initialize a given LSM, if it is enabled. */
> +static void __init initialize_lsm(struct lsm_info *lsm)
> +{
> +	if (is_enabled(lsm)) {
> +		int ret;
> +
> +		init_debug("initializing %s\n", lsm->name);
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +	}
> +}
> +
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
> +/* Populate ordered LSMs list from comma-separated LSM name list. */
> +static void __init ordered_lsm_parse(const char *order, const char *origin)
> +{
> +	struct lsm_info *lsm;
> +	char *sep, *name, *next;
> +
> +	/* LSM_ORDER_FIRST is always first. */
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order == LSM_ORDER_FIRST)
> +			append_ordered_lsm(lsm, "  first");
> +	}
> +
> +	/* Process "security=", if given. */
> +	if (chosen_major_lsm) {
> +		struct lsm_info *major;
> +
> +		/*
> +		 * To match the original "security=" behavior, this
> +		 * explicitly does NOT fallback to another Legacy Major
> +		 * if the selected one was separately disabled: disable
> +		 * all non-matching Legacy Major LSMs.
> +		 */
> +		for (major = __start_lsm_info; major < __end_lsm_info;
> +		     major++) {
> +			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			    strcmp(major->name, chosen_major_lsm) != 0) {
> +				set_enabled(major, false);
> +				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> +					   chosen_major_lsm, major->name);
> +			}
> +		}
> +	}
> +
> +	sep = kstrdup(order, GFP_KERNEL);
> +	next = sep;
> +	/* Walk the list, looking for matching LSMs. */
> +	while ((name = strsep(&next, ",")) != NULL) {
> +		bool found = false;
> +
> +		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (strcmp(lsm->name, name) == 0) {
> +				if (lsm->order == LSM_ORDER_MUTABLE)
> +					append_ordered_lsm(lsm, origin);
> +				found = true;
> +			}
> +		}
> +
> +		if (!found)
> +			init_debug("%s ignored: %s (not built into kernel)\n",
> +				   origin, name);
> +	}
> +
> +	/* Process "security=", if given. */
> +	if (chosen_major_lsm) {
> +		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (exists_ordered_lsm(lsm))
> +				continue;
> +			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> +				append_ordered_lsm(lsm, "security=");
> +		}
> +	}
> +
> +	/* LSM_ORDER_LAST is always last. */
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order == LSM_ORDER_LAST)
> +			append_ordered_lsm(lsm, "   last");
> +	}
> +
> +	/* Disable all LSMs not in the ordered list. */
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (exists_ordered_lsm(lsm))
> +			continue;
> +		set_enabled(lsm, false);
> +		init_debug("%s skipped: %s (not in requested order)\n",
> +			   origin, lsm->name);
> +	}
> +
> +	kfree(sep);
> +}
> +
> +static void __init report_lsm_order(void)
> +{
> +	struct lsm_info **lsm, *early;
> +	int first = 0;
> +
> +	pr_info("initializing lsm=");
> +
> +	/* Report each enabled LSM name, comma separated. */
> +	for (early = __start_early_lsm_info;
> +	     early < __end_early_lsm_info; early++)
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +
> +	pr_cont("\n");
> +}
> +
> +/**
> + * lsm_early_cred - during initialization allocate a composite cred blob
> + * @cred: the cred that needs a blob
> + *
> + * Allocate the cred blob for all the modules
> + */
> +static void __init lsm_early_cred(struct cred *cred)
> +{
> +	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
> +
> +	if (rc)
> +		panic("%s: Early cred alloc failed.\n", __func__);
> +}
> +
> +/**
> + * lsm_early_task - during initialization allocate a composite task blob
> + * @task: the task that needs a blob
> + *
> + * Allocate the task blob for all the modules
> + */
> +static void __init lsm_early_task(struct task_struct *task)
> +{
> +	int rc = lsm_task_alloc(task);
> +
> +	if (rc)
> +		panic("%s: Early task alloc failed.\n", __func__);
> +}
> +
> +static void __init ordered_lsm_init(void)
> +{
> +	struct lsm_info **lsm;
> +
> +	if (chosen_lsm_order) {
> +		if (chosen_major_lsm) {
> +			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> +				chosen_major_lsm, chosen_lsm_order);
> +			chosen_major_lsm = NULL;
> +		}
> +		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> +	} else
> +		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		prepare_lsm(*lsm);
> +
> +	report_lsm_order();
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
> +	/*
> +	 * Create any kmem_caches needed for blobs
> +	 */
> +	if (blob_sizes.lbs_file)
> +		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> +						   blob_sizes.lbs_file, 0,
> +						   SLAB_PANIC, NULL);
> +	if (blob_sizes.lbs_inode)
> +		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> +						    blob_sizes.lbs_inode, 0,
> +						    SLAB_PANIC, NULL);
> +
> +	lsm_early_cred((struct cred *) current->cred);
> +	lsm_early_task(current);
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		initialize_lsm(*lsm);
> +}
> +
> +static bool match_last_lsm(const char *list, const char *lsm)
> +{
> +	const char *last;
> +
> +	if (WARN_ON(!list || !lsm))
> +		return false;
> +	last = strrchr(list, ',');
> +	if (last)
> +		/* Pass the comma, strcmp() will check for '\0' */
> +		last++;
> +	else
> +		last = list;
> +	return !strcmp(last, lsm);
> +}
> +
> +static int lsm_append(const char *new, char **result)
> +{
> +	char *cp;
> +
> +	if (*result == NULL) {
> +		*result = kstrdup(new, GFP_KERNEL);
> +		if (*result == NULL)
> +			return -ENOMEM;
> +	} else {
> +		/* Check if it is the last registered name */
> +		if (match_last_lsm(*result, new))
> +			return 0;
> +		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> +		if (cp == NULL)
> +			return -ENOMEM;
> +		kfree(*result);
> +		*result = cp;
> +	}
> +	return 0;
> +}
> +
> +static void __init lsm_static_call_init(struct security_hook_list *hl)
> +{
> +	struct lsm_static_call *scall = hl->scalls;
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_COUNT; i++) {
> +		/* Update the first static call that is not used yet */
> +		if (!scall->hl) {
> +			__static_call_update(scall->key, scall->trampoline,
> +					     hl->hook.lsm_func_addr);
> +			scall->hl = hl;
> +			static_branch_enable(scall->active);
> +			return;
> +		}
> +		scall++;
> +	}
> +	panic("%s - Ran out of static slots.\n", __func__);
> +}
> +
> +/**
> + * security_add_hooks - Add a modules hooks to the hook lists.
> + * @hooks: the hooks to add
> + * @count: the number of hooks to add
> + * @lsmid: the identification information for the security module
> + *
> + * Each LSM has to register its hooks with the infrastructure.
> + */
> +void __init security_add_hooks(struct security_hook_list *hooks, int count,
> +			       const struct lsm_id *lsmid)
> +{
> +	int i;
> +
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once during initialization, and LSM initialization
> +	 * is serialized. Landlock is one such case.
> +	 * Look at the previous entry, if there is one, for duplication.
> +	 */
> +	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
> +		if (lsm_active_cnt >= MAX_LSM_COUNT)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_idlist[lsm_active_cnt++] = lsmid;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		hooks[i].lsmid = lsmid;
> +		lsm_static_call_init(&hooks[i]);
> +	}
> +
> +	/*
> +	 * Don't try to append during early_security_init(), we'll come back
> +	 * and fix this up afterwards.
> +	 */
> +	if (slab_is_available()) {
> +		if (lsm_append(lsmid->name, &lsm_names) < 0)
> +			panic("%s - Cannot get early memory.\n", __func__);
> +	}
> +}
> +
> +int __init early_security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (!lsm->enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +		prepare_lsm(lsm);
> +		initialize_lsm(lsm);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * security_init - initializes the security framework
> + *
> + * This should be called early in the kernel initialization sequence.
> + */
> +int __init security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
> +	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> +	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
> +
> +	/*
> +	 * Append the names of the early LSM modules now that kmalloc() is
> +	 * available
> +	 */
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		init_debug("  early started: %s (%s)\n", lsm->name,
> +			   is_enabled(lsm) ? "enabled" : "disabled");
> +		if (lsm->enabled)
> +			lsm_append(lsm->name, &lsm_names);
> +	}
> +
> +	/* Load LSMs in specified order. */
> +	ordered_lsm_init();
> +
> +	return 0;
> +}
> diff --git a/security/security.c b/security/security.c
> index ea09a71d9767..e77791058086 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,24 +32,7 @@
>  #include <net/flow.h>
>  #include <net/sock.h>
>  
> -#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
> -
> -/*
> - * Identifier for the LSM static calls.
> - * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> - * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
> - */
> -#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> -
> -/*
> - * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> - */
> -#define LSM_LOOP_UNROLL(M, ...) 		\
> -do {						\
> -	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> -} while (0)
> -
> -#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
> +#include "lsm.h"
>  
>  /*
>   * These are descriptions of the reasons that can be passed to the
> @@ -90,21 +73,29 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -static struct kmem_cache *lsm_file_cache;
> -static struct kmem_cache *lsm_inode_cache;
> +struct lsm_blob_sizes blob_sizes;
>  
> -char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __ro_after_init;
> +struct kmem_cache *lsm_file_cache;
> +struct kmem_cache *lsm_inode_cache;
>  
> -/* Boot-time LSM user choice */
> -static __initdata const char *chosen_lsm_order;
> -static __initdata const char *chosen_major_lsm;
> +#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
>  
> -static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
> +/*
> + * Identifier for the LSM static calls.
> + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> + * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
> + */
> +#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
>  
> -/* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> -static __initdata struct lsm_info *exclusive;
> +/*
> + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> + */
> +#define LSM_LOOP_UNROLL(M, ...) 		\
> +do {						\
> +	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> +} while (0)
> +
> +#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL
>  #define LSM_HOOK_TRAMP(NAME, NUM) \
> @@ -155,490 +146,25 @@ struct lsm_static_calls_table
>  #undef INIT_LSM_STATIC_CALL
>  	};
>  
> -static __initdata bool debug;
> -#define init_debug(...)						\
> -	do {							\
> -		if (debug)					\
> -			pr_info(__VA_ARGS__);			\
> -	} while (0)
> -
> -static bool __init is_enabled(struct lsm_info *lsm)
> -{
> -	if (!lsm->enabled)
> -		return false;
> -
> -	return *lsm->enabled;
> -}
> -
> -/* Mark an LSM's enabled flag. */
> -static int lsm_enabled_true __initdata = 1;
> -static int lsm_enabled_false __initdata = 0;
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> -{
> -	/*
> -	 * When an LSM hasn't configured an enable variable, we can use
> -	 * a hard-coded location for storing the default enabled state.
> -	 */
> -	if (!lsm->enabled) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> -		else
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_true) {
> -		if (!enabled)
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_false) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> -	} else {
> -		*lsm->enabled = enabled;
> -	}
> -}
> -
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> -{
> -	struct lsm_info **check;
> -
> -	for (check = ordered_lsms; *check; check++)
> -		if (*check == lsm)
> -			return true;
> -
> -	return false;
> -}
> -
> -/* Append an LSM to the list of ordered LSMs to initialize. */
> -static int last_lsm __initdata;
> -static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> -{
> -	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> -		return;
> -
> -	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> -		return;
> -
> -	/* Enable this LSM, if it is not already set. */
> -	if (!lsm->enabled)
> -		lsm->enabled = &lsm_enabled_true;
> -	ordered_lsms[last_lsm++] = lsm;
> -
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> -}
> -
> -/* Is an LSM allowed to be initialized? */
> -static bool __init lsm_allowed(struct lsm_info *lsm)
> -{
> -	/* Skip if the LSM is disabled. */
> -	if (!is_enabled(lsm))
> -		return false;
> -
> -	/* Not allowed if another exclusive LSM already initialized. */
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void __init lsm_set_blob_size(int *need, int *lbs)
> -{
> -	int offset;
> -
> -	if (*need <= 0)
> -		return;
> -
> -	offset = ALIGN(*lbs, sizeof(void *));
> -	*lbs = offset + *need;
> -	*need = offset;
> -}
> -
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> -{
> -	if (!needed)
> -		return;
> -
> -	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> -	/*
> -	 * The inode blob gets an rcu_head in addition to
> -	 * what the modules might need.
> -	 */
> -	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> -		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&needed->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> -}
> -
> -/* Prepare LSM for initialization. */
> -static void __init prepare_lsm(struct lsm_info *lsm)
> -{
> -	int enabled = lsm_allowed(lsm);
> -
> -	/* Record enablement (to handle any following exclusive LSMs). */
> -	set_enabled(lsm, enabled);
> -
> -	/* If enabled, do pre-initialization work. */
> -	if (enabled) {
> -		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -			exclusive = lsm;
> -			init_debug("exclusive chosen:   %s\n", lsm->name);
> -		}
> -
> -		lsm_set_blob_sizes(lsm->blobs);
> -	}
> -}
> -
> -/* Initialize a given LSM, if it is enabled. */
> -static void __init initialize_lsm(struct lsm_info *lsm)
> -{
> -	if (is_enabled(lsm)) {
> -		int ret;
> -
> -		init_debug("initializing %s\n", lsm->name);
> -		ret = lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> -	}
> -}
> -
> -/*
> - * Current index to use while initializing the lsm id list.
> - */
> -u32 lsm_active_cnt __ro_after_init;
> -const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> -
> -/* Populate ordered LSMs list from comma-separated LSM name list. */
> -static void __init ordered_lsm_parse(const char *order, const char *origin)
> -{
> -	struct lsm_info *lsm;
> -	char *sep, *name, *next;
> -
> -	/* LSM_ORDER_FIRST is always first. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order == LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "  first");
> -	}
> -
> -	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> -		struct lsm_info *major;
> -
> -		/*
> -		 * To match the original "security=" behavior, this
> -		 * explicitly does NOT fallback to another Legacy Major
> -		 * if the selected one was separately disabled: disable
> -		 * all non-matching Legacy Major LSMs.
> -		 */
> -		for (major = __start_lsm_info; major < __end_lsm_info;
> -		     major++) {
> -			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->name, chosen_major_lsm) != 0) {
> -				set_enabled(major, false);
> -				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   chosen_major_lsm, major->name);
> -			}
> -		}
> -	}
> -
> -	sep = kstrdup(order, GFP_KERNEL);
> -	next = sep;
> -	/* Walk the list, looking for matching LSMs. */
> -	while ((name = strsep(&next, ",")) != NULL) {
> -		bool found = false;
> -
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (strcmp(lsm->name, name) == 0) {
> -				if (lsm->order == LSM_ORDER_MUTABLE)
> -					append_ordered_lsm(lsm, origin);
> -				found = true;
> -			}
> -		}
> -
> -		if (!found)
> -			init_debug("%s ignored: %s (not built into kernel)\n",
> -				   origin, name);
> -	}
> -
> -	/* Process "security=", if given. */
> -	if (chosen_major_lsm) {
> -		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (exists_ordered_lsm(lsm))
> -				continue;
> -			if (strcmp(lsm->name, chosen_major_lsm) == 0)
> -				append_ordered_lsm(lsm, "security=");
> -		}
> -	}
> -
> -	/* LSM_ORDER_LAST is always last. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order == LSM_ORDER_LAST)
> -			append_ordered_lsm(lsm, "   last");
> -	}
> -
> -	/* Disable all LSMs not in the ordered list. */
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (exists_ordered_lsm(lsm))
> -			continue;
> -		set_enabled(lsm, false);
> -		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->name);
> -	}
> -
> -	kfree(sep);
> -}
> -
> -static void __init lsm_static_call_init(struct security_hook_list *hl)
> -{
> -	struct lsm_static_call *scall = hl->scalls;
> -	int i;
> -
> -	for (i = 0; i < MAX_LSM_COUNT; i++) {
> -		/* Update the first static call that is not used yet */
> -		if (!scall->hl) {
> -			__static_call_update(scall->key, scall->trampoline,
> -					     hl->hook.lsm_func_addr);
> -			scall->hl = hl;
> -			static_branch_enable(scall->active);
> -			return;
> -		}
> -		scall++;
> -	}
> -	panic("%s - Ran out of static slots.\n", __func__);
> -}
> -
> -static void __init lsm_early_cred(struct cred *cred);
> -static void __init lsm_early_task(struct task_struct *task);
> -
> -static int lsm_append(const char *new, char **result);
> -
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first = 0;
> -
> -	pr_info("initializing lsm=");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	for (early = __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> -
> -	pr_cont("\n");
> -}
> -
> -static void __init ordered_lsm_init(void)
> -{
> -	struct lsm_info **lsm;
> -
> -	if (chosen_lsm_order) {
> -		if (chosen_major_lsm) {
> -			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> -				chosen_major_lsm, chosen_lsm_order);
> -			chosen_major_lsm = NULL;
> -		}
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -	} else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> -
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> -
> -	report_lsm_order();
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
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
> -	if (blob_sizes.lbs_file)
> -		lsm_file_cache = kmem_cache_create("lsm_file_cache",
> -						   blob_sizes.lbs_file, 0,
> -						   SLAB_PANIC, NULL);
> -	if (blob_sizes.lbs_inode)
> -		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> -						    blob_sizes.lbs_inode, 0,
> -						    SLAB_PANIC, NULL);
> -
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> -	for (lsm = ordered_lsms; *lsm; lsm++)
> -		initialize_lsm(*lsm);
> -}
> -
> -int __init early_security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> -		if (!lsm->enabled)
> -			lsm->enabled = &lsm_enabled_true;
> -		prepare_lsm(lsm);
> -		initialize_lsm(lsm);
> -	}
> -
> -	return 0;
> -}
> -
>  /**
> - * security_init - initializes the security framework
> + * lsm_file_alloc - allocate a composite file blob
> + * @file: the file that needs a blob
>   *
> - * This should be called early in the kernel initialization sequence.
> - */
> -int __init security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
> -	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> -	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
> -
> -	/*
> -	 * Append the names of the early LSM modules now that kmalloc() is
> -	 * available
> -	 */
> -	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> -		init_debug("  early started: %s (%s)\n", lsm->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->name, &lsm_names);
> -	}
> -
> -	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> -
> -	return 0;
> -}
> -
> -/* Save user chosen LSM */
> -static int __init choose_major_lsm(char *str)
> -{
> -	chosen_major_lsm = str;
> -	return 1;
> -}
> -__setup("security=", choose_major_lsm);
> -
> -/* Explicitly choose LSM initialization order. */
> -static int __init choose_lsm_order(char *str)
> -{
> -	chosen_lsm_order = str;
> -	return 1;
> -}
> -__setup("lsm=", choose_lsm_order);
> -
> -/* Enable LSM order debugging. */
> -static int __init enable_debug(char *str)
> -{
> -	debug = true;
> -	return 1;
> -}
> -__setup("lsm.debug", enable_debug);
> -
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last = strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last = list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result == NULL) {
> -		*result = kstrdup(new, GFP_KERNEL);
> -		if (*result == NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp == NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result = cp;
> -	}
> -	return 0;
> -}
> -
> -/**
> - * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsmid: the identification information for the security module
> + * Allocate the file blob for all the modules
>   *
> - * Each LSM has to register its hooks with the infrastructure.
> + * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -			       const struct lsm_id *lsmid)
> +static int lsm_file_alloc(struct file *file)
>  {
> -	int i;
> -
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
> +	if (!lsm_file_cache) {
> +		file->f_security = NULL;
> +		return 0;
>  	}
>  
> -	for (i = 0; i < count; i++) {
> -		hooks[i].lsmid = lsmid;
> -		lsm_static_call_init(&hooks[i]);
> -	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
> +	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
> +	if (file->f_security == NULL)
> +		return -ENOMEM;
> +	return 0;
>  }
>  
>  /**
> @@ -673,46 +199,11 @@ static int lsm_blob_alloc(void **dest, size_t size, gfp_t gfp)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>  {
>  	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
>  }
>  
> -/**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> - */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_file_alloc - allocate a composite file blob
> - * @file: the file that needs a blob
> - *
> - * Allocate the file blob for all the modules
> - *
> - * Returns 0, or -ENOMEM if memory can't be allocated.
> - */
> -static int lsm_file_alloc(struct file *file)
> -{
> -	if (!lsm_file_cache) {
> -		file->f_security = NULL;
> -		return 0;
> -	}
> -
> -	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
> -	if (file->f_security == NULL)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
>  /**
>   * lsm_inode_alloc - allocate a composite inode blob
>   * @inode: the inode that needs a blob
> @@ -743,7 +234,7 @@ static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -static int lsm_task_alloc(struct task_struct *task)
> +int lsm_task_alloc(struct task_struct *task)
>  {
>  	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL);
>  }
> @@ -812,20 +303,6 @@ static int lsm_bdev_alloc(struct block_device *bdev)
>  	return 0;
>  }
>  
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc = lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
>  /**
>   * lsm_superblock_alloc - allocate a composite superblock blob
>   * @sb: the superblock that needs a blob

