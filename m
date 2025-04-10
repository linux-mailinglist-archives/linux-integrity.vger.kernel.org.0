Return-Path: <linux-integrity+bounces-5781-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96355A84B0D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3484C8A6575
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01B28153D;
	Thu, 10 Apr 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZIpEii3v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB520371E
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306224; cv=none; b=pXfh/A7xOEKFbNIWmULNAcmmwIV7qxrhqDS9Y8NWuzrs7n91xoRuouEH3ye1qps5/mc9+n8BySlO4xkApuVgmcWjt4ajz0L7aCHqoKdhuT5gLAvAB5n6KshyugICyd1NYbkZfL9WV8iwKZv7epfdO8zuGd5VilJWuB+W2ES8SSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306224; c=relaxed/simple;
	bh=oGPf0V15EOLKzDpHsUH6nfodog9PLqZphJqpkk/OP9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXUMlYBWtZ3P/BDfusFmLCdGjyeDQDLyo0ciM+JVn3RkDZmc9e9pleKSIqQsw8VrQI3Ss5ErugoxK8THkdqJan+SkJrKrc7KDKME7O6pCup/TJR01l02H1cCmCNT52IGYM6L7BMzNnBJpBntbfspIuwZa5oKzoKys5/i1nFkhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZIpEii3v; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744306222; bh=uk4TTmTSQ0qbEOKqRjvg7bqOKso1/KavqiiaM4Tfz50=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZIpEii3v5hGMhtZ7W4efZ2/oUPEOieE/xQfrOvxg2sSUujxHY0bCXauxVjtXnTIZMqHRba1hW16nObQfZ1sFx4SrI0/GTWUEv0ll1QpJ8a/LcolBoJtcQx6DZhFxePzCp2d4nWDZQMtxLzXlIhYyNGYBXu+1Gj6sQkNKqp/kEDRAsuPIpMrhEa0EblZ1nhH226arRQ4dPBV2dwVyUX92sPWgT4+qhCgs9byN3iVtycG3miaWiZfRKTmT2DYgSgZjj0MBWJ0YGvZ9RDJtTqRZ7UWOoZ7cf0jOw+UwW2fU0wrUxdny3Hngau/OCBqIpA1JIWGKU2hhA8jB/56RyB+HLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744306222; bh=bI5xx8tgflOYwEVMuu0KTUdZoySYcv07Dpb015Zx+O2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XdZXh6WD4FiPaKB8Eb8OKEE/ahkvJcKFAUpCK+0bFjNHzWYzDFZTJGpuQj19v9qd/IrhwIxXIJCLqiQayExFP/XeCmWs1/x/HWlu6XGWrKP7SqimNYRUBUCtsqXcxOatPVnJtxHNxjjlcn9zbgcKIIcw1jeg0utzBdjzePNx20+iClsS/nC0HPBS00W4ip3p7MlIaxXaFO+tPZwg/vlhDy7Cmc+aInb998oSlXP9mPJTOmyhxXAsT8eTWy6p3nLJTEYBEnPN9NQrbvRN0aqZW5q9fn/M7c7ZwitThxfFFpdIyZnOdRnx8J5clX9+uDViI3GQIxo9XcMcXSGTJNE6Eg==
X-YMail-OSG: x5nU2YIVM1lv2qNkLStparhBR9QF.sZHexEMGd7_v8cCFawhR.vuuFoO4ENhamS
 _Jr.PxsLgvLfNPmp6XCzLfnwE0erC2oVkm3U617IhYp9jXdv8Hf8w0WuQ4Odalm0im6Jy5AO6ARE
 qxcyz6FAsu8bysIr02ANH5.BdPW3jfvoVtk5WWhtyLAuvnG0WQPdRIAfSkdjNC6O_m1s4Ue4yiGV
 KIhHWMJxH3kD0E0OFKKPUPyEBL3jX98mPJGo5zKiA7taHXB3ddeoBc88rdjshgXLgiIxYdDZ4mbr
 pfJha1cAaqbQ2v4EFQa.BQEBgXn4CSJMTV_WDf7Z2yLBTclWlqh5V4XH6GtqKUcyfQMgTwCjZB4a
 8364.32uyzbY994iuMjHqlhkwMEPuP4hGLKt.6t9B5SvGJnMz61ojh2gdU6Pi0Fn8pLL2pN7zich
 ojhr9akFtk98eRzPQV6lxeSCuPzA_svNk9RgEfcMBeAb7WkE3M_ChrkQv6.kVLM7I6d5u4g2LxvE
 I.m0lGtaodXRCqwr.K6XoCf6iz5_8YWXSonkcZ2zAiQWY1lnZGOQ9a4HMoS2arc2Xy6vBweWWiia
 DuCIVLKq0QHePYqFDEchwxx1q59E4iElBVX5RQRuaAvcT7_akwS.YtSCBfilg70SzffLpweQhKPe
 pPI.tbhKInQiKXw9Nlj9Vn5Ex7X5dxpbddTTaJy05qHQRG5ejD2P1nPya6r74Sny4Fwm.7wLuIvn
 kPrcQXLfiZc_DMyJr6PU5nsbYnIWCj35i4WW3eandIL9dMpfoZc0TXx4XNAiLs4o0SpUaFUAd94L
 21_xbYthzZjwYE5H2vAVAKNI4SNJLGsb7IltHoCaIB0NSHuk8ZoG7pf7HmQiLIBwd.pKkgkbh8EL
 j_.pAzIrp4eZYT4io.niWzl8NLFRXTgxftZV9Rv.BLpAolSDwlKKX5.MkaCio_BQdSFugNz.Sr6Z
 iy8S74rxlCc4tNgmHwvKLVjae1k5_F9krbvqQe4.34Wqv7jujiR2MNtJcZisWIA4zSDfB7ufIsOt
 d6sFKg_8IBCFAX1aGFJqZLiHeO9KmrAfYd4Pk_rk1vM6_t3rmurCeqxgg81PgcWSt_ZAVd1Yg5Pp
 _eWJj2pHwpUEAWK9MsvjYFOF99wiVkdWGx4k2syAJhYEZhvlJreHoKbbYpCKG2K35SFzagyOFUNN
 502bZbYtDLOvBJOfGb2UclIjTQCDdrZvbOlLmPot7Pn9yH5hMZ072zln96iT2Voxwe7mt4PG7xqz
 VCQgDEGfB9e1qUQt0Pp4RuFxAg.SaE1Q0GgwYlDQ09z5D_Or67MFB7sFbpQj.vc2j9J_myS2aO5J
 rzGza94OoSyZbS9yNT2ZU_ZG0Vilxh2U.lqwXQ.JRmJBd89Bs5E2vWWaVG_nLfdTV.tRgsZTeS7.
 Gcwa97b6EL9GGmPEZut5ij7wI21lvWA3HdqeUgedKpgk9qtxO1Sfpm0u5Iu5HUv1oUiYVYU5vlkj
 mqhUxnXl2KJJZj8OXRHjMrr6uP3Cow8r.OmcripgVK6d5bnaHplPwWJye6goO67SSrb25woIUC2_
 aVtRwnFQB5lYyOpNwTiqkxh12py.T01MEZ36gxMaFg18vFNGnr1eVBu4SeeJabCApmAg4gGnTpzB
 MQyMXG1nuiVjW90z7HALLIA6IkAi8zQxGukQlNyu.JE89yahQ4KOzPdtYWKR9Mjqi0o3qw_mP8JT
 8tynM6Mz.CuEJmQxXWaIXSock2iaBZI0iNri1ayhiSPKvcT8sRv303aAXlSJEfvZSFECZsjBYUh.
 fnXay8VqBiowMKvPZLzE.J85Q1rw2iaZZyZqum53aYbAGq.2._s_S95aprmA7HFlvi7HsvhGIGzJ
 2gdHmaIf6vYtcm8IbKqH4OJbWT.tJBWEg_3jInb34rDDUn8yCB6ck2w8vrmAuslTmVZEMyyWgfLw
 AWNiIf8LfBCE_1_0fU_j.bhKmm_pT5n79H_eY0RzFhNh9FSYIXrTcotWDQFSKNoIH64L1DN3HPDp
 xnFxAFQkDGSQiXgFlHHKnYQ_E_KsAAz2Zh6CVFR.f8AtxQAKQY0YPSJhAnIOQCjH_1vXIrtkt0BS
 XTNYDkVUYg0Q6E4YZWx2GBvM51mFx9ufFJl2vU3q.arzAy1Fm5NtiJRI0c6.aOiK6cgIemKe_QF9
 2YnOqJXynRHbRH0iH12E.XP9XgWV9bnq6eqi11qY_xZZfFxB0p0fdu5.sser7tIj2GJ.L09RkCrq
 1BnEx3UmwTOsZnlxYVY_zoQxDOTVj0RSBLVk4gmiwyptxXT2kttjOu1mxdHsIG7svkyAy1l1Ny7D
 F0kHYsVLQRCsMzLP98POYRWEOctMwJvM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ceefb65d-14e4-4eac-a042-ba891eca9ca0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Apr 2025 17:30:22 +0000
Received: by hermes--production-gq1-6f8bfcd964-2cf6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b583f272d13765c4b5d794aad6dce95;
          Thu, 10 Apr 2025 17:30:16 +0000 (UTC)
Message-ID: <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
Date: Thu, 10 Apr 2025 10:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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
 <20250409185019.238841-51-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-51-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:50 AM, Paul Moore wrote:
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/smack/smack.h           |  6 ++++++
>  security/smack/smack_lsm.c       | 16 ++++++++++++++++
>  security/smack/smack_netfilter.c |  4 +---
>  security/smack/smackfs.c         |  4 +---
>  4 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..709e0d6cd5e1 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,12 @@ struct smk_audit_info {
>  #endif
>  };
>  
> +/*
> + * Initialization
> + */
> +int init_smk_fs(void);
> +int smack_nf_ip_init(void);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09b33fed5f0..80b129a0c92c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
>  	return 0;
>  }
>  
> +static int smack_initcall(void)
> +{
> +	int rc, rc_tmp;

separate lines for the declarations please.

> +
> +	rc_tmp = init_smk_fs();
> +	if (rc_tmp)
> +		rc = rc_tmp;

Replace these three lines with:

 +	rc = init_smk_fs();

> +
> +	rc_tmp = smack_nf_ip_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;

Change this to

 +	rc_tmp = smack_nf_ip_init();
 +	return rc ? rc : rc_tmp;

Also change rc_tmp to rc_nf and rc to rc_fs.

> +
> +	return rc;
> +}
> +

Or:

static int smack_initcall(void)
{
	int rc_fs = init_smk_fs();
	int rc_nf = smack_nf_ip_init();

	return rc_fs ? rc_fs : rc:nf;
}

>  /*
>   * Smack requires early initialization in order to label
>   * all processes and objects when they are created.
> @@ -5286,4 +5301,5 @@ DEFINE_LSM(smack) = {
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
> index 90a67e410808..d33dd0368807 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2980,7 +2980,7 @@ static struct vfsmount *smackfs_mount;
>   * Returns true if we were not chosen on boot or if
>   * we were chosen and filesystem registration succeeded.
>   */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>  {
>  	int err;
>  	int rc;
> @@ -3023,5 +3023,3 @@ static int __init init_smk_fs(void)
>  
>  	return err;
>  }
> -
> -__initcall(init_smk_fs);

