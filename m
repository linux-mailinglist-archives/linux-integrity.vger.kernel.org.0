Return-Path: <linux-integrity+bounces-6300-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA7AC15EE
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 23:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E01883E57
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6E2566DB;
	Thu, 22 May 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qSi232lm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89FD250C19
	for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949803; cv=none; b=usy7qTT6bmVJxcL57+TNQY646L4o9boD9UEvsGd5Lcvev1aeNmvfs8kdZzAsi16cUyTQDn2O2eQQNjhhI8mF4ZLj0qDiRm4uRb1fL45irwlktk9wluR05Aop9Aejgpcg8vM73CmS/yjO47zmygTg4mV6shA0fjParjjH6ItrQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949803; c=relaxed/simple;
	bh=p0XtKa4G3Os7sLtY7r/MCEt1W8df4n6nks5yo8d5ArQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNgQj8CP+tj/5b7/Y4gRbB3sHUMs2hhz1j1AEM5St6AUUppUQE6ERXZiVw1/q8K53kd4cqci6RIBUfq/Q1IFAac2mbsm9dF3+5Hjy35jlaOA8u28IpxjFYJ9qRw0p+s7i5X10p4WmI77DvqlhKtIqNADvV7O2vDBqhby/59DERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qSi232lm; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747949795; bh=d3NLFw1TTHGD7vlrnR29VaX5fVGtaKRIi+SZUrP6hnA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qSi232lmuJELn5qm3iMll4Y7iXn5d2a2f8J4vUbeDkrR+3J614Mjkt9j1lLMmbQGH0LjqGpD7jZxQkRVHwF+hVQAmJ7ngSH+WZFaNN3yWJEe3217sAdD1IR4NyesmE9ayxBxhy7T+MVr2tR/uduCJR++YEuaNlDnwaTG1wtWaD+rX63JyEakMzKjKLtp60w60A6DmPLDoPmeNqrTYkLAw22o/i9+E5VOF8iinGI1PFzvx13AeLlNtmHq5baAMvnPnrMsOtzdWOFQIIUz/0wIdVEv2YeO97xWnqFbpb9BIBrmouzAQkBIh6xN+WY7M/LuZ0BpvhZQasdnpVmjvF+bJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747949795; bh=P2FW60tELJ7r2Yopu+fs+7vs9tP1Ci8PEdVgkobC8II=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FiwaFFASH8DHTGRjEwHVFXuEOGO4WY538bO6hZyQuZifjcLnmhPBJOU6/ao4aRdm0QUsnCWK31TJtTzgU9t/zdFqMw9HLyKkMrdp4kfKACy4/u7uyaz5v8Vbac6vjfkqUwSb3YC2q19aV4/JGE64UYtv9w7xMu/XIkFLV/TfKKawsKPqtmt0V+cpEZr6O3doTSNEfKo8izLgc62XhBQ78aeNtanTcWX46BxkC/WpnnMcXHI/Nz4LGT2MezLca0JtOcgnQkbJT3a4/7juYiy5WB/vOMGkNseCbqHNamg68LgFXgHbgAxVnwo3l1Csxgr+9E/Sxi3hqLNN1Du10bwXwA==
X-YMail-OSG: iTUA45AVM1mGA7O45zmNOTrUusVBFkbHmVe3EJ0Xdpn4bHLOwUx4C._N7iErJjK
 rWJc8.nHTHuy.dVBLgYxGcF39u.qAH1hUpcB1QaP.3EHI3rUTIMQkCDKTFQpDC9NffBXto5lTIcr
 QAISwFMwgJKaa0dYJ88iQqIJVpKT_X07zAMeP2suSVoCb2VLzDTehCMz7GG1WGthpqStRK3BOCLa
 Us3ACL0puKqtUtyNUOWMa1KuIuy8ZOU6qWvSlxK4YCHnmKvebPPE1jvn7G5uUR1vIOCxgb8bXXqI
 vhqpwHxdokF2GMhqKC5fGB8ZxpwBnKYbfQbp82shtuY2ArGt.dvelPGULcIykTn5VMxklywmri2j
 tpUIYjXlZWLrHUUDUVbZhhE0MxE8CryNrheBaJO0S4s6rLYrRnpxZyfkQ1_FA6kW7dnQeVc7nB9C
 6xmoZCUc.26k40vryH03kGIm3HIX.elUt.kvRzn38T591x1uSKa3G3hwRFVM515Cr.f_b3QjU55K
 SyuWg0ksSH51N52aGWXSii3hUZNQDtlVzfN1A8eQKYvljzbzlZC_B0YnfM8oi6YpQwbHCtwd93NQ
 ryNNUMbfgBw0Ui_GYx2N75mDHF7NeNb_HGPlvMu9TpeSkE0yV5YWCj9_FRJFmLNl7Mw0Ao902FWM
 srWATXaAtxq9mjdRSVGifBFRqShcT_PW3o2PlPACcBqtQmZF_xX94NjhmpRldBJ7MtrOhAPIc5MU
 qEAzF6ZoexYtsX9wHBoQRttdT3LAPS_Uz43MF0WcTy3sd8_dtB6RqlXm7jgI2FmtXrJ.7e4A8cwE
 4i99MUfCow.RV8Q77MoFLip8TwVWbN5k.r1dQG0s18QsvBzglMPMQSForKHfBTUkvqIKJXwLLJqI
 zEbwsKX7b4pg6bxqgAx86sclXaBiHUlnZJBeZyD2F08KoYUnVzPbDSVqx70oDySiBlRx.oZ9CYnb
 MKnf31tdDbxSNBZ65Ax4JDPjWygTNd3VfFqohtPkUtHAQMiNqVxrRypohhhZzoDcW_0k0Dso9tcu
 ZUAVxTBlhYx19W2xQHsXZh7qekmy1AG_knioOPV2yXIbVsuouoQhisUjDCPEZrFcbL9YXuDWTfLW
 uDKgoxUOH8tQZr.EOrrj4ff6xvmNXtsWQhkbYNkkJwTPAXD2zg8nwlMMqr39CmvsZ9fxYyd6EjY5
 4jCW8JyKHD1_SJ8S_N3su_Dp5EEgvA0wXcdu62hdHNxpFp0i.okhSeX2sObG6sFucc35MBSDUTZn
 eNZNl2shHMhNcR_hzUNiMIcMJ_CtWAqVzen42BX1Aoye9RnTYbeQC0uPyf2nLq3goACoXY0c1h_h
 Dct3gz_43UFpz06As4ZQSv_A0rCzUKWu.3U0mZ0jN.as2WChfLgppQSgxzc94Cta7eB7K9p05fyM
 iboHzEl6iVBeq94LdLGuZnKPLd7wuffaFn913EcKhBtwy4Yo5x3vEMoqFg_zgB52aVqjEB6RDjN_
 mKRFB5pZrRb5L8Mha0I3DZUTtl_phdWyFt1uIBK7vB2MPCNk3OxexZdv5UAMAqAVN9uB3ZUYEyPS
 9TuK1hLTS73duuZ9DX_vlROOqyRlsikM60qQZrLCXgVR9rUPYNBb3vMFGzQl.Ncp2ul1NcCom_fr
 OpKf2WTtykmbz_Vo0uiESTKhVNu_Xv_5gXihedOz_dzOSswgUzY2uBIp.T02nsns6Wl.03iNYB14
 oIF0728JfD7GsuNsjtGd6HAxzS5BCTzR.jHKSjIU6.UV2lPlUPF_MzOWPWcx_YHyLR.rxMRlZsNt
 4mI28yMJ.JfZRae5eQQ0VbAjp8cN68l8f2jaTI_hLzcPe1E6WfKNdQorpYucfLfllPvZ_vrmzfIf
 QoCrPiRm6lvDB_2n_anqKChDaLTg7sP1bgG0TBRKIozr4kS50lZ5HniBO4nDX356.TrWVPoXKQGQ
 5CpD3OOHWVPIqJDgvw5UcDmq6.15qZ_nTBOaYURa2WJJODQqXcyxkqAwm4lxSMMpGX3gCg_jXAGH
 bL_UwRmO2DQDOwBLECUbSlOFhxatMva9r9TY9gQ5L6jX0v3ANiZxwx4AvsYkmmBC6NmuqFH9LZ4a
 PLlsjGt2h5hYA3B2PUJTaPajlVB_pQ2GVXQf8MDSvzQVIiHZf9MGEBlgOB8L66kPpekJa6SPRFFr
 PsY0iobQ1tCaATQbNWDPRkSpV316mWIc_bwqdWcjibHTvd9TnBLvf0Of55cak6K11nl6JnI__knz
 uy0VTetySAFlwBdjWJDaeg_cM_HwfwdoHxnsrlKDUPQ9Eax7CXx_ZumL.FArpp628dCZKiUrgyOp
 5ExNHm5H7VlyjPgDeJ3aXyxNG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 116fc614-cbcd-4d6e-a3f1-8482a3048b63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 May 2025 21:36:35 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b10af0932dc8e225430908a16a0d3a50;
          Thu, 22 May 2025 21:26:24 +0000 (UTC)
Message-ID: <8bb003b3-8026-462c-ae9e-fd79fdb47ad5@schaufler-ca.com>
Date: Thu, 22 May 2025 14:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some
 cleanup
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
 <20250409185019.238841-39-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-39-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:49 AM, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the
> currently active LSMs in a human readable string, with the only
> user being the "/sys/kernel/security/lsm" code.  Let's drop all
> of that code and generate the string on an as-needed basis when
> userspace reads "/sys/kernel/security/lsm".
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 27 +++++++++++++++++++--
>  security/lsm_init.c       | 49 ---------------------------------------
>  3 files changed, 25 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4cd17c9a229f..bc477fb20d02 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -169,7 +169,6 @@ struct lsm_info {
>  
>  
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..49bc3578bd23 100644
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
> @@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	char *str;
> +	ssize_t rc, len = 0;
> +
> +	for (i = 0; i < lsm_count; i++)
> +		/* the '+ 1' accounts for either a comma or a NUL terminator */
> +		len += strlen(lsm_order[i]->id->name) + 1;
> +
> +	str = kmalloc(len, GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	str[0] = '\0';
> +
> +	i = 0;
> +	while (i < lsm_count) {
> +		strcat(str, lsm_order[i]->id->name);
> +		if (++i < lsm_count)
> +			strcat(str, ",");
> +	}
> +
> +	rc = simple_read_from_buffer(buf, count, ppos, str, len);

This results in a trailing nul byte at the end of the string.

> +	kfree(str);
> +	return rc;
>  }
>  
>  static const struct file_operations lsm_ops = {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 981ddb20f48e..978bb81b58fa 100644
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
> @@ -363,42 +361,6 @@ static void __init lsm_init_ordered(void)
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
> @@ -435,15 +397,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
> @@ -480,8 +433,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */

