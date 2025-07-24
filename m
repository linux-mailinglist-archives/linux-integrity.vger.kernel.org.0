Return-Path: <linux-integrity+bounces-6728-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A31B114E2
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54ECC7A531E
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3253E23C8A4;
	Thu, 24 Jul 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bswgLYqh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AD8834
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400857; cv=none; b=blYPAEn2o+Ra6tpbI3EVbyGwARMvTRamfqTyRKAU+EWEvcER5vUxVPuTXpqGIiH/K8XGaM+wOnbnRmCVD54hafqusIbQnKJjGI9le06L/2SMU11/pkigap1k8zVRJgcdPfDAus1hwBmwR9JLXRPG/qiTnSz1VVvXLqsW+NPnsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400857; c=relaxed/simple;
	bh=nSD/g8rUyKgAX04DY5Gev065jpILmNUi3DNLtnfxlNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMp/ItyQDh5/EEF+Vn2G1itoSaWkpyT/AgVN7C1h6aCFXU/zM38mO1BZu9A0tt4xaXhzEb2jYc9TnEFj1zyadCLxDqrdIFe8OEBu94ipHVEH68i/EGiBXtgbYhVpsGv0sT0SUhaFXpvWUfB/XN3KMHwoiBMVUGYdAfSH/uTeohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bswgLYqh; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400855; bh=50lU7HATAnkWlmI/Pv0M0xZGpAoRy6Olqb1NCNlvBdc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bswgLYqhXTYfUaTuLATcDeFPXqgF7IvItPoAoOCLqQczoHa4f6MhzLgbYYcHSGFspxlVSpKrnaKgRrtaN27PCyadyLbJbX81mL8mVxovbGujuyAPgU/VSmONvQAYoqmOTAXyxyirXdwqRXOpW0cP83GlMIu7a04Db3a/YUK+FHcE1zT66HCqPch++iyvxXO2wXNVaEWkVJkwyORyGfE5ZLit3fCw2VOoh4rVk1bP+DJO/vhXDoaVEGBzwTSluyBriBuNT9+ruc4q7Tb1uSKtt0uehNheEfaRgc0gVshI/xX/nsjUaYCygOAbmQK6VXLsmOaXliVzjdFXU9Zz9aFBmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400855; bh=O+pXbz08OEytKfwFbkVsqmWviX4tRGlI5vw7CQr3+JE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lFKjZT3fHtRvkKlsb2gI9Ezd9kNTp3qavY04vqZqppyVokspEUfHHHlD3s4BQ6/pYEsqxoOkv0QfWxsx5eK2kVaiVJ447saYjBfCWis4rhN2I1PTPO3wkHP141T5qtcDikNarIkPljaUhwIMxd+D/5Lwn9EuGeOsZ9/gjZlkb+X4g/3IUItqYG/5mb/xJUyjsIB6ZopOsGJ+whi/jWBAJZSbjo+zJHy+FK2P5BbLp2aKCXVVSFECFzAbV+HsqdZWxquWmUeaoQgbvGF/YFYst/VMMwroR+2Q1VDC6MStAr0e7lbnAr+oJZWbzrmYpwQhn6WyCkZ0yz/H9mwky8YWoQ==
X-YMail-OSG: uY7nkAcVM1l2yRxJ..hRuEy2IVrNS848gr2xbl6UkvmW_FsqdMQRLgaKgLlkaDW
 Ht4dem.RXIbHo4c950Nmrj.rcdTpnZTCVfBoFOB77B011LpkF_nEYNUh7w4lYZ_awnYel6kyrtMz
 xVEJGm8VbhuP3PmZsQzu3ts.rk3E0Ep_jDZ_oQidHnyw9iAAESwuIsmHhxC009qQGDi3E7KIm4Dy
 yzjFplW6M6TDlNFWonWK3TReC5kAgJuNpTf38dls33wvGb8JZIpgqvKufr5r80mQFo1RTylWAyTv
 Py12buVms0X1gdkUyKlbEjZbga1JXmJew1trEffqpo7cyuPiuKvr2a_n9RA0Pv0E1QcXPtqJpRWs
 UNmLkza_6kPeB8KvaAU6hPZf_nIaD0E4bJM1.9zIJrTB5rV7T_Q.KpQE7j05eAfJsyllmXy2dLnx
 AZxDWQ6_GtAhMuJfvoMMiAMtY8XTQas1z6rKmq4Uc2gMpByuCQOamO4UhBjrXe97TcmHjf059v_9
 4d35IDwz2HCulA6.xXJ6UmIRdNjFZQvoDpkoHghk6UgGE1RUd8Z5dc_gXwmPRXxxFHzJHFO6siF8
 VCRSZop0vZfMFkFoZs4BUFdRjRhFj_5ykHxgmjOMWnts_elgDPL9ZpXYM81SmVdxTgneOk0Azlzt
 Vy9RVHNLrjmJkCvmQIqnMHs6lIBbO0Dm8KIH8p.jJGE_zmxuQmZAOh1b94O5IVjS0Wyt6cKA7MlR
 LAsWKVE_pbVt_WXeLe3wwY5R37CjWIFaZhKMZFwSjgX6nRclRPD8JkVLU779pNSOyzBibdnNJjgY
 UAvppPTnCr_S20Dnn0IEPwvb0nj7W3Q2IOyNXDShdvnqXGKR61d1nseIy_DWGktQ9lTUt6wJYiM_
 nqQW19gmF0h0IGVW7x4ogJaS.koSgJ2dkYrNpEuIma30FqlhPBt0yfxkG44IyF_iadH00EBl3Mhn
 k0HmitrVDLM9vWrjQ2M.DYfql80H0OYD.CtzKinHrDCjdh9ArGDNdKPKdoOK6KgpfGeDenb2nFUb
 p_hk024sRDOHOgyFXvcopBQA9Md2VeP4OoDhC_8o6KwMkIBH3mQl1u2NWdGMpjS2TKuhlcVGpdxo
 hqSkKGYrrw9XBNZDGkOnQhIahtnJoRvGBcgAbeRo94BJ2iRx.n6phPPqrRc.siuQlh8piBTiYjXq
 isqfxitIHRumuQoKV0mCnUAFzzDS7zaI7WX55Y9KSejp_cENeMUIG9k4zv5m6UIzWx2EPMGI8FFi
 Lmilxk5I8fdZAGG0A2Voy_hMBMaYkv8fFYUsWRGoIcbDL24P88.WKzcD4qZxE5FxhAXlAbwRx2fC
 GEgjZYWDc9ysGtDePEPrjao1Oa6YMBnV.Kkbg4MuhKmVB0ljRRa2QT_Bijg.WQw745b1DaX3Bg9x
 FlHXtl9UWhBAJw.YADuOwYG.7JCj9MOuCRk9wzt9ew5fAquGQF7Y36JY7moUpFFA_sPrureflFwx
 LazmI.0Sm8dqmvXtHyjd.p0iKX45KHmebb9Ad.hX8OaNwcGWsKGJOOaeByKQ0BTPpCdH7iLx_CtS
 V8RHFpk1.3j_fNAglX1oQ1H15q.ZkaeR8m.QmOOcBVxcR_b1BKm0ivZWg6uAePrjez5dExjz4ycO
 Ks9vlhFBYywX0lfJ70xmMTE.ComYsHLYkb2B66LPk2JG_LZ942hQVkJ.DY_rRKg_zEE0qEusN4ex
 Q_SOta0voui5Rt6c1vjfTRtMciQ.ckXiVV_DO7k7MXddthiiNcxbC9Ky8lVTblybl59SKLSO2HCC
 CeFYDY.L5XlxISIIlO_Pfit.hrre35qWp38S7a4IDRwEvSrpVC4C.1dHpwkAKIqXEpbhKzUQMETM
 eXwn70hZSMRaC95OkyjVLzGCMq873gRFn8iaBKMm5nAdk29IMLnqqQJCArAfoacdhoEXkNizfRVC
 8lBURN4ls0v4ZISHY9D_miwrFcQGE9zHkGE3bKlIDezSrRFiHH8cZ0U3HeNKOHhKiRsJ6Uq7qxvm
 hF8.6W8zyXrvuebPVEcvxRhGF1jIkpYqEMiCoQ.PKdrYlbQPgXkCHmU1osJl3cULAbxGRM0v_YUE
 daJzpfvsVFxPFGpqsGXU.HfVRYwLZj6LRlVkNg2reumPiXTcFBkHwqDqfyy5U2vv5mXb.__sKt1Y
 WpQGswmX5AVvxLpUFuoG6dAIQZYdRJN94rHL7_gohWjfptTgvK9Xfv1fNp3kNmSomNkvSur8ovOB
 JAjJvOvECB2MPcYujq2oA1Bii.bNbrAZdS6mB35efrUMLBpKZaNez8TXVBB73pHEtCRbVp4OyIkC
 juFaSLWK_jZOtamTUVIvDdH5ruJGtBN5o6tLBeCnlqA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2e20fe0d-1e4e-4636-8d8a-2c0ef4818c42
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:47:35 +0000
Received: by hermes--production-gq1-74d64bb7d7-s6s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 971bbd4092929fae29e7a1404554e2b8;
          Thu, 24 Jul 2025 23:37:26 +0000 (UTC)
Message-ID: <c730af93-62fe-499a-ba0d-5d8a49bb8e50@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:37:24 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 33/34] lsm: consolidate all of the LSM framework
 initcalls
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
 <20250721232142.77224-69-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-69-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> The LSM framework itself registers a small number of initcalls, this
> patch converts these initcalls into the new initcall mechanism.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/inode.c    |  3 +--
>  security/lsm.h      |  4 ++++
>  security/lsm_init.c | 14 ++++++++++++--
>  security/min_addr.c |  5 +++--
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index 68ee6c9de833..d15a0b0f4b14 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -408,7 +408,7 @@ static const struct file_operations lsm_ops = {
>  };
>  #endif
>  
> -static int __init securityfs_init(void)
> +int __init securityfs_init(void)
>  {
>  	int retval;
>  
> @@ -427,4 +427,3 @@ static int __init securityfs_init(void)
>  #endif
>  	return 0;
>  }
> -core_initcall(securityfs_init);
> diff --git a/security/lsm.h b/security/lsm.h
> index 8dc267977ae0..436219260376 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
>  int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>  int lsm_task_alloc(struct task_struct *task);
>  
> +/* LSM framework initializers */
> +int securityfs_init(void);
> +int min_addr_init(void);
> +
>  #endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index ab739f9c2244..f178a9a2f9d4 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -482,7 +482,12 @@ int __init security_init(void)
>   */
>  static int __init security_initcall_pure(void)
>  {
> -	return lsm_initcall(pure);
> +	int rc_adr, rc_lsm;
> +
> +	rc_adr = min_addr_init();
> +	rc_lsm = lsm_initcall(pure);
> +
> +	return (rc_adr ? rc_adr : rc_lsm);
>  }
>  pure_initcall(security_initcall_pure);
>  
> @@ -500,7 +505,12 @@ early_initcall(security_initcall_early);
>   */
>  static int __init security_initcall_core(void)
>  {
> -	return lsm_initcall(core);
> +	int rc_sfs, rc_lsm;
> +
> +	rc_sfs = securityfs_init();
> +	rc_lsm = lsm_initcall(core);
> +
> +	return (rc_sfs ? rc_sfs : rc_lsm);
>  }
>  core_initcall(security_initcall_core);
>  
> diff --git a/security/min_addr.c b/security/min_addr.c
> index df1bc643d886..40714bdeefbe 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -4,6 +4,8 @@
>  #include <linux/security.h>
>  #include <linux/sysctl.h>
>  
> +#include "lsm.h"
> +
>  /* amount of vm to protect from userspace access by both DAC and the LSM*/
>  unsigned long mmap_min_addr;
>  /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
> @@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
>  	},
>  };
>  
> -static int __init init_mmap_min_addr(void)
> +int __init min_addr_init(void)
>  {
>  	register_sysctl_init("vm", min_addr_sysctl_table);
>  	update_mmap_min_addr();
>  
>  	return 0;
>  }
> -pure_initcall(init_mmap_min_addr);

