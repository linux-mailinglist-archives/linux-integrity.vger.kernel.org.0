Return-Path: <linux-integrity+bounces-6722-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4EB114AC
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1887A3A2BEA
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B312DDA1;
	Thu, 24 Jul 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D4RkJzSS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5102E36ED
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400199; cv=none; b=OBvNgzS71MJ8TBaxz/ivvzYO5tYkSh9HcebJvvih+VnaPsV7B2/eSqBDHmFYgCitF5IbUHu/BLThdhEhgWyMF6eaUyw2zuQnlph2JfAIrzpZ6186rgU7NViL92JfxlzB09DTVpf1hjhUBRfOncxislDpL97ewYmopeaBUpCSNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400199; c=relaxed/simple;
	bh=T0TIDSmOsE4oh4XxQpQYdt4FjSQIk2vkaV51X6C2gxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDIfPZgiJpOosae6xSNWnW/CpnDnimSBHvggVJ8kFJdl+B7qNxQLAPiG0lnDS95aR3HzDvPdHmMKohmIcEIwKW+T3Ne6UqNt3eBmLT/ATE5S2kxetXYE7Eu5hjPwcASpf+6NT2wsL+iiPKdnEq+daqQFORpho5Ctr0eKfCzv50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D4RkJzSS; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400195; bh=74YS9bna/gLHEaqxbEgNNmy/bTlgIUhG/VOgM/kvatQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D4RkJzSSuFsCCRfyI6thz5heFXpgKNS8tMj3raD7I+1aAEkagcvdRIBTW5DQpUM5eGq7fxNpSsiY8eAaj9+Huu9zZ3ds6nhAIc6Zjtjzhd/7kUzQfjsj07LafI4J7TGOZ1Mz994WDLQotHWJRMGVFRGYIUzYzg2K7GyGp87qvNRGPAV0F69GXrB0sidkyTXhekHj0HxboblMB0IotEXcT4iBGtl0grPMwkQ+zoPQvPK5ZBtLR6wQcrPROJOuFYf6aF9BO3Bm3G71fZ2nMUVi4dZi9stMqSZzA8Tgph93njxhsi0MNgLkPM1K3C2SijeYDml2q4MWcRRIj4tLCfr59w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400195; bh=Vnd2ujxSYwPjVvSTe6bmzwfXizpxBV2KGqrcpSY7oFc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Xaa6y4Oef+PJURF/4vyXevdUDYWUD9vOWpzrLI6p0pHYIouer6FjUR5LUd7VQUFHLHCS4xEtF3zFGiIn2ijEaV5khLY9CKyCQeBdek7vw2V1GA5sPT50XGXQBYfAjbsxKZ70tS9V3fPmw3odKxiZBgP66dJqQ5bbKW94YVts5t98BndBhsig86WLCmHfqs9rGRjRklU7rpJATtdh6DSRpjJSpT3RmsE84Sg3as0AgCqRhSqioBAtavxFv3bjDFPviFnWIOUL09s4JDKhlBxhmFw2ojbNAs9f0swM94BVOjbUqYhVNhbC3nCCf5hIPksrsm0fh63XHQYwAyV2meRWiQ==
X-YMail-OSG: uGQFfWwVM1ldWFNcwOctIgHjxM0.6MVmfOR9.fa2vxqb1JaxO5keU4RauwCmzZj
 WDquMEcSool8mEiKO8hXhV7Qt2OjfHo6U18nnYU4fhk62JAaM22AhNV6TGE_3Q5_C1K_QlBbbZRE
 IlH1pcckjOuSc_OPyiHg4mqXLriToM2dpvF2r8jRZKBS7klrYLxTBT1POjvIZCNM8RRS1rvUqDgK
 1xjvAsrLt.WyJwgBJIK3b9b8I9QOBqnSitLHljzxzCwfi1OYwLqcpa2NPg89R1Qo8JyZn3p1MYeD
 3u720J_ZCpzPpoRI7MBxLEHRzFkesSonjrCJLLEcBiUlk_hkbDktWa6ejVDw81WSVSZQ6fiC6bQ9
 brgaG5Ctc4t77VvlvXdpnqzFgmDbLmAcX74EjEYFLKpPwo1.gCdSfCiA3OE05I.G6zetT8DskmgE
 w3v_qfj6WN4UIXm26jEwF.ozVLoLo990OKxrCek8Ku7b3LFClD5rF2tI7tEixNPVmIve1pSv7BDK
 c1hm6joQR.KP07n2cQiyAgh6WlB3h0Ti2Fv.YPR173zgv.7y7pRwua42MxbMLMOZqoissekymIA7
 TMYs1IDUlAkFRY5mEveMExbEmH2tuTSBIQYDJlD_TdI6o2V4.zaATz9HJ5rA3_RTzBHtZ7wyaJ6_
 uPFDezBfwyS0vDftBVrkz5TdglacvY0ltWBchnnVmm9jtYBdXbtceGOcNo8.u14sNOkALNFMM9E_
 X2IWSjHQlYlSP1N3kIXs8lhch257EQbXvy3Q10k7YzJDk1NVurQ2YPgbecYp0GT7yMecFSyQic7R
 BtaLIY1O5F6Z4xyj.Rcm0eenbNUPv3oPBMW.j9AQ4ZL7axBvT0sS4numzUuiv60J2GIfqddLTM2C
 g9h9ieZrqJIGZkwB.nUvNsuiTz_aXr9FUdF3qrZ7RCgW35zOz5WggTIQwx8AGQyJjlHpFubtuSHC
 kua7owzOvHxqg_jarvLoIHf85uk72CQ2Jddc0O4p_4ESJTi284P5tDdFI7R5DaJj1K_v8ZbUaSkE
 V93LNg.LeR.yJSi.GBmrnTxvb5fNVhSlujvlF5ZciwhFJ4aDNASICzO7OJFF3zKci239tJbv0lE6
 DZUbtWB17n_w4CL9hLCF_1_mYkI08.qE5S_Ib10HN6CtKDN.teNQQD.fqF49WMJj6ooGkgPnkQOd
 GL50.UqkhD031UFkDOhaG7Cz7lZUy5xqoDJL2azTeHUau9EyorDad1qAI0RNqtev7SttkVrnkjJz
 GJoklvwPRikNr_KOTdMj8dNdJ3__F3brCbjcysEJK5x5kxcdSd.Cf4SSINS0QPzfVhnibfeBv6rL
 NJSCfOs82mrx2wnB7UCukhhTB3Aa0JAr91muoiBlyHd8mcpUc5PYd5ZqqJmxVFPa37WwbroU8Ypm
 o.sMxSXouFJZX3XqZ_0A4oniae9v.DqjJ9XzmVGMqCOzKdSQg03h0I0cPeHXa2gnOpinoQAFbiVC
 wZjO.b3_d0ZqqJQtRqbUl70WlpEEFGYsG98tsCxK6TJPHkXLyi525JMsxy4Sn5bgw1JgVBBdwauN
 DTjJx97_PVH2U4vIUPB6nMsg2_Kl_v42pRKeT.Wl3Ab9SXpyO2KHIY4tLls9OucktSNTvnAofi9T
 POA10D1UmlahmU695sZ_Y1YDKIf7.ZGhN5qUkgJ3vzhZCHgz8vJzBMk3lbszXmqheKuM1yVHuGoU
 f5KrC7xp.efHwPIE8hR9pH2tEYlC.ntKli9Z240940nVFpd0b5kU9MlxGfefEIReaT0.vdju73wq
 rKyWHaKGtTEJXSkxfeMGOLNHJv3em5mowseG89hqsgYGGv6flEZnntBUbmqWa5tyVmlH6LlXDh64
 LkSKwkdJ.Ta_E7qyHU1Qf5Bgbs6gxJAsws0hwlAT1K6Hul43Vgy.XhasO6EUBv.C30C2uEBWsN6v
 NEDTBzKf1VFYINyXuRuf6NS_cCQ1aIyMK1cEdetv5EbnE6kq8A25EnTg0Af44dN0lNa1vwSvvsf.
 LLhV8r1Txu_qSis6cXMYxdEdAwrOnrMCXXJYICv.4jmyqjIkJHth03TBFgkaw.OtmVmph2euzcEZ
 IfntfIN17k_JyduGQZisUo4AysXBkxR3P5uHbIaTTwMGHHigl30ZGsaTfn3dIuMW1hKpN3tEtAfs
 j9MB4fXLrjHv4sGgwPAqMiAaPkMzoFBrTsfHm9bmZjWVxDqTeHq1ezt3gq7sA2blSGl.4eGnxqLt
 mZrTmIKhT6LcUgaWEc1DEeSk6VhFhd4X_IwezIlZialBLzBShWMHG5bIw1BQIZO.DXGdEpA0hoZL
 TNwtzsL7rS5Z0vci0.7FxzfzMa9_bHZD_Zy0JxsjCeAQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2b06fa6b-cd3c-41c5-bb86-ee6ee1209c49
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:36:35 +0000
Received: by hermes--production-gq1-74d64bb7d7-fsgc5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 42b00b52ec24e938bd811d053fb845bc;
          Thu, 24 Jul 2025 23:36:33 +0000 (UTC)
Message-ID: <83e69664-b28e-46fc-a2ee-1584cc35b4e2@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:36:30 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
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
 <20250721232142.77224-62-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-62-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/smack/smack.h           | 7 +++++++
>  security/smack/smack_lsm.c       | 9 +++++++++
>  security/smack/smack_netfilter.c | 4 +---
>  security/smack/smackfs.c         | 4 +---
>  4 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..885a2f2929fd 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,13 @@ struct smk_audit_info {
>  #endif
>  };
>  
> +/*
> + * Initialization
> + */
> +int init_smk_fs(void);
> +int smack_nf_ip_init(void);
> +int smack_initcall(void);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09490c75f59..f14d536c516b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5270,6 +5270,14 @@ static __init int smack_init(void)
>  	return 0;
>  }
>  
> +int __init smack_initcall(void)
> +{
> +	int rc_fs = init_smk_fs();
> +	int rc_nf = smack_nf_ip_init();
> +
> +	return rc_fs ? rc_fs : rc_nf;
> +}
> +
>  /*
>   * Smack requires early initialization in order to label
>   * all processes and objects when they are created.
> @@ -5279,4 +5287,5 @@ DEFINE_LSM(smack) = {
>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.blobs = &smack_blob_sizes,
>  	.init = smack_init,
> +	.initcall_device = smack_initcall,
>  };
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index 8fd747b3653a..17ba578b1308 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
>  	.exit = smack_nf_unregister,
>  };
>  
> -static int __init smack_nf_ip_init(void)
> +int __init smack_nf_ip_init(void)
>  {
>  	if (smack_enabled == 0)
>  		return 0;
> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>  	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>  	return register_pernet_subsys(&smack_net_ops);
>  }
> -
> -__initcall(smack_nf_ip_init);
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index b1e5e62f5cbd..405ace6db109 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2978,7 +2978,7 @@ static struct vfsmount *smackfs_mount;
>   * Returns true if we were not chosen on boot or if
>   * we were chosen and filesystem registration succeeded.
>   */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>  {
>  	int err;
>  	int rc;
> @@ -3021,5 +3021,3 @@ static int __init init_smk_fs(void)
>  
>  	return err;
>  }
> -
> -__initcall(init_smk_fs);

