Return-Path: <linux-integrity+bounces-6861-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD9B2849D
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF97B188A2AA
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402830F801;
	Fri, 15 Aug 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nfAmXrth"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB430AAA2
	for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277261; cv=none; b=WwpuRgxKThpiyKBfAs1AGhkCgj9m3w+6VeobOe8lKryzcS9WbZnhBPMekf+553ybHtvw1gb7WVXaizXcTTgkfmG/zaslmESF6Xy7FIpygzRA/Z5/1gO/f4GcXFiJlmea4jiFkwm8E4/z6XBXL5jeaHBG8mc9FDeVr1NBGBlGL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277261; c=relaxed/simple;
	bh=lFWa0x7pJ4oX2LkaowGiliGhSLBu6A87s+Kqvhkhds8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIlSjLLcAPyVIwd7QNu2lWievUWMlOp61tt02czxBgQSE0MHdJX7InWhfuwB6jMtOF3+NswOx6MTBjeFvMSXUDt9/Wk8Z7ZMSjWsvCmiwvgSwp9aoooPnbSS75lsamI73RfQpYCIhj51W0wWdueakFoJ1VtEvZ+LgqM0nBPuwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nfAmXrth; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755277251; bh=ymqbZq6vmMO00i56GB/E+3scTdF5LBGYevaRRc+yoN0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nfAmXrthrbEP2y5HxZP85blshLLOHRvk8BPigkZDd3As8teYkssOiNhe1/lhJVYEVjlxCKCpwoZswEEjAvnxCg87M3HnserA5lTrlFy8OORDnEwSg8eNyhj0n4nhkoe3DI4syJektdVhqiSYee2/4jMG9miev3jsqUlFgNA1MPBVXyJRSMbPWAgScTJV9/tWXHVifQubfP6wWC+jlEdsVvQuya2aMc00dte9TbkJYKmTkBh05BTZYdMPlMQBreLXWMsAOPMizq0WAbouG6+4c0PDC1jiGVALNmaOFA0420gplkYDQjB8f7icgLuu+6+m6I4u9UmZJs1wks2woeI+WQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755277251; bh=RUw0IduYY05EXQm3UsqYALI/yCYRnLjhxr4g9xjWtHx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oy1WZ1jNjtSIYoSVjUMx8RY9ICAYAUy39SdXawu9Y58RsLZJcga9NSCuI9KkPAqF5GSRSpnBLcROpjmhaGb0gW+FPUKCEMWVM1jL3sLhNw2mWZlhTx/q0IF6KJ5IfrGKvnkbdW++vXz1o9HinOaXC6ZVz3cEU8JnDx0UE9S23cwfXz9eRAQJET8NQQoK4U8QgLeDHIkbFA+41r7BP2iCmY/4+nxbfaM829glFK27S3QpG7uPegoE2HobmpR/juSaKAOF3E/sIloTcNcIOaBN/bOfEWrz5JsqHF5UWLxqWpHwb+2HksyUXrSxoGm2k/letmgHTMNHl/a5IL/K4qy2SA==
X-YMail-OSG: MsWZsFUVM1m9K3mc.tinv6z2jkiCkUGONceK0ZEQKpBKjXuzvjkkc61XveSYUB7
 06QLzzYGKwUYJO5v9VyF_.adg1_V.ZBPSAYZzhscNio.miIK_YGZd.RV1loDdcV0bYWreudXGk4I
 lIvDTGdf3rnSKqGl1hVYH.tCZu9IuWtNOiFb7VzBfXmp8YpPDP0467zqV_vBv_FdU1KdlbPjTUDE
 SQU3FG_Wsfo5v7ZfMxNOlJFHJCAlxfWav3tnTDmyeCwA7m087KjcGdDm1HhKbbpZydiJ_D6qVoot
 KazBxOfJ2QvNHPF0Ky77NJCWmwjMRz4ezAEYjXYJ4oeyB.csbNldhuM682KSJ4DYMGy67.F41DS2
 jm39noJlYDr0HHzG28kBx012Ay8bt1GptieGmdFehuhoHunfOzH.XBqwBZSfyt3QEHXPFJ_alGmB
 LfR6p8ZjT8QeJvb3Wwou5PtySjtohPh7e12lOrtK1niLfDlCTYgEN6.MRMcD_Cqr77eA2qoxOnBZ
 MYRgQNNKc4GX5p7dOCIlYFqNSwSW80b82a4KuL3bMO5S__ALDPiNwZPZFIIEkM62WHs2sV7CSiNn
 IrmlPNpkSq6.b6HzqvSpyseZBw4FKWjqj_JIa6tKw3.NjaULl2BgdS86sP035S3TUKyUgRKbluQK
 7o3nk.qYMZm0EKjEFVjLAGwbquY581dIcmWRuUdJ75_nE77cwOC47ivq_yi7GssozuSB850KSHIQ
 qH0CxIeMA8NrwtTnlqcVu5x5dUNa2G6Gb1ctii7XmyXnos8i1AAIJjx9bczTsP87u0XsSqtSgD5c
 rBo.Ce2dFogCDtB1U6mfqous1ei3zqP6g1UOkfKfNajXw1OcXR3TOgAzI6MPvYHojgRkNDsB7u0E
 HNPTnBPBoIBjFbYA3g8B1HKHWlqTyG8UpaI0dHxhqwj.vUdaypeWA3iTv1OazcI8LSDcCPSIZs_p
 qDyPDIgtqfMDaugnlEzxE2kyTqHhy1N0BtLx2f72D.L2jakYivs4tAxtwp1gqXRxlMIi6U9ISmuL
 4toJXLQ2IcACpMc_sfnPwLKh9Nt7n9KLWTr7C_Wgc2XFsW70.HLi31uLu.JsGuc55GnBWDWGCRfV
 dzW_2qgs3oCrUp.jouWws3u3c5_SCY0fAwYjdI6_nou7OYuUAUxXKVCCk70U62ofTey8WCH8DJpx
 b6fhO.gczJyB4EDbPcUbtkxARipjM2vm64lKizV3dxhIZ44aMkVGc_ThGr_kNdyXccgXn7iM5Fdw
 Y1WhP0ZPLhowYUzTRwDTiVL0tEqxZF6DqYIzxaudDbQ9eIYYVp10LXnNG2Ju7EnnpYFgRGzBONYD
 EeEVxJltrEiQz8O3w9C94IJxzue5exZlI9gbS8LzVVMYEA6Ep_m3i8qFL8mqb.IPEHX2xYqPPKRB
 Gf.sWqaxRSEoLixUyGO_eV4oYI8TsCz9Oqf1Tb1P6heZEN5IJh26zOzLPhhxO1JZBmeRsyn6FZRe
 sOE.h6DrtL40MzJOB28rJ0F7kBDkmie3CRtthHlJQAXysCjTeqYZePDdgqAhq94ScOS5OTdFG2IW
 i4Ek7wlJxvoMFqL03XNnh6B3_InWRzyN1UE8cQwRk9lYjtQDFRmyxiDX83mep3sdO_U3VCjB2Osl
 1t6pKNwygN5f7iQFWbqRVfqwMn09UihL2cxqyESq5DLwuo_Ritj6R1p_KzLm0wvYzJlVMfWXyFoP
 .0fpWwmu.15DGd._uzp3TyoT58f3XbCGqvluJz_h_7gKgIpiK6kgVv1MG44575RJnaDXL5DwyCox
 M0HbecJi8.d1kdDN5rtOZeESs6QkaNck9NXTNLywI24VbxmuX6ASUDQESEk7CTZzDQUMREnLwvln
 806W8.dz.VmRh415APrc_97PkXxBoTMnDmpXJpA6bNNh84AeRoqRCIJwMOW1.ngWr7arHnEPYRuJ
 bYMzxDwO6WxHg0nZPznlLM5xwFPN41ev31XUyRkmvfWXZVGZ3G6ji6f2ysbNzQFE3afdVe1HSGmY
 uH0PvXW3fa9CNxSGBWvx8LrAPqhp1ybLhJ6yN8TpBx8p_shlbtYZzHV05uP6Ia48e5Kc.xNV7EKB
 ULyxegnLsKkVA4n94WwuGmSTMhgdZBK8DSEsSLpLJ0DNOofPmDU8uM_1B5YWig8H1ghwZETN5S4c
 m8hACG7J_lE9BrypfXrlZZIni3mK6fh3EwSFwhAJW24O95nG_MvGPWo18cCC4moHsYvjQvfWhPd0
 I6ifcUNDTU5jkWr4IGylfdYZ27lVa5KeiOw8h7U2tVkS1z7Zywp9VPt81pSKkEaUkz0hwqLE4bOw
 RoDQANeglUh6WxVfRBzi8cg_mqmqN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a25622e7-0aa0-4ca8-aa97-ce58f2ccebf7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Aug 2025 17:00:51 +0000
Received: by hermes--production-gq1-74d64bb7d7-2dlqg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ba083027440a3314da5d2d85ef4a4f3;
          Fri, 15 Aug 2025 17:00:48 +0000 (UTC)
Message-ID: <cf1592bc-c1dd-48f1-ba33-8c9c1c41cf57@schaufler-ca.com>
Date: Fri, 15 Aug 2025 10:00:46 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
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
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-47-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250814225159.275901-47-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/14/2025 3:50 PM, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the currently
> active LSMs in a human readable string, with the only user being the
> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> generate the string on first use and then cache it for subsequent use.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
>  security/lsm_init.c       | 49 --------------------------------
>  3 files changed, 57 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7343dd60b1d5..65a8227bece7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -172,7 +172,6 @@ struct lsm_info {
>  
>  
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index 43382ef8896e..a5e7a073e672 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
>  
> +#include "lsm.h"
> +
>  static struct vfsmount *mount;
>  static int mount_count;
>  
> @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
>  EXPORT_SYMBOL_GPL(securityfs_remove);
>  
>  #ifdef CONFIG_SECURITY
> +#include <linux/spinlock.h>
> +
>  static struct dentry *lsm_dentry;
> +
> +/* NOTE: we never free the string below once it is set. */
> +static DEFINE_SPINLOCK(lsm_read_lock);
> +static char *lsm_read_str = NULL;
> +static ssize_t lsm_read_len = 0;
> +
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	char *str;
> +	ssize_t len;
> +
> +restart:
> +
> +	rcu_read_lock();
> +	if (!lsm_read_str) {
> +		/* we need to generate the string and try again */
> +		rcu_read_unlock();
> +		goto generate_string;
> +	}
> +	len = simple_read_from_buffer(buf, count, ppos,
> +				      rcu_dereference(lsm_read_str),
> +				      lsm_read_len);
> +	rcu_read_unlock();
> +	return len;
> +
> +generate_string:
> +
> +	for (i = 0; i < lsm_active_cnt; i++)
> +		/* the '+ 1' accounts for either a comma or a NUL */
> +		len += strlen(lsm_idlist[i]->name) + 1;
> +
> +	str = kmalloc(len, GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	str[0] = '\0';
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (i > 0)
> +			strcat(str, ",");
> +		strcat(str, lsm_idlist[i]->name);
> +	}
> +
> +	spin_lock(&lsm_read_lock);
> +	if (lsm_read_str) {
> +		/* we raced and lost */
> +		spin_unlock(&lsm_read_lock);
> +		kfree(str);
> +		goto restart;
> +	}
> +	lsm_read_str = str;
> +	lsm_read_len = len - 1;
> +	spin_unlock(&lsm_read_lock);
> +
> +	goto restart;
>  }
>  
>  static const struct file_operations lsm_ops = {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 9e495a36a332..87e2147016b3 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,8 +10,6 @@
>  
>  #include "lsm.h"
>  
> -char *lsm_names;
> -
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
>  	}
>  }
>  
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
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsmid = lsmid;
>  		lsm_static_call_init(&hooks[i]);
>  	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
>  }
>  
>  int __init early_security_init(void)
> @@ -488,8 +441,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */

