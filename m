Return-Path: <linux-integrity+bounces-6708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D040B10EB4
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E94C3B3C2D
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED52EA142;
	Thu, 24 Jul 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OsAslRPe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic312-29.consmr.mail.ne1.yahoo.com (sonic312-29.consmr.mail.ne1.yahoo.com [66.163.191.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D112E9EBA
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370926; cv=none; b=a3tSymKGMYabLADINazbkEqwyCTKswGdkMd15qOescPbEH/KWX9BSpJphVKociWEAnaEpItqFSG/conmHwIfphnHysod8TMihvaF4nx4JAmCdLHc+C8NZaNJAp/8X7x0Pky+Fjevuoth8gCxpQip5wZM21WS7LZDRn8Ps6FYcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370926; c=relaxed/simple;
	bh=wFG6ginIIiiPePvgb9Hpc9kirHtgpX0uxnTLwJhWcjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCh1/0H45hz55pxE5mSZ/sCva6JPWMlTKhCQWxu15PTwTvOQaEcPJCafI94S2RxsJMwBNSJy9YQPUIjyMCUVLsQULbwd3Aslpp9qaWsZQGrg+OyoemhWm3VNfR4rhfsLnOqH39juHskBEALqc5YmuXd0TNDvAAoF1ZufbAzljnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OsAslRPe; arc=none smtp.client-ip=66.163.191.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370924; bh=IzFKE5uzWQzH8q+DZ2R5voj5753qmS0KFa13aAkfcXQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OsAslRPeARV6AimZsavD+bJvE0gccMZ/f56Ypm+hHZWHIUmc8yPpmKY98FDXoI4dzWWpNAIcamjp94M25bn0Z0UR1n3uQeTd1MH+dD1EExyKZ5+J0nkyE1UbGfdZjmSvsf+bwBZqr9agufK4Pzeh8GMB0eFt0paQ7C9BB1jU4KbZxYjogh2tnnUCoQBIzzty4ucLKtMEz0B3fWyQbh7nVAojKsuTE+tIM7opAUnsdXvWfZag/sGGMGiXn5fJV9T0ZHUIMr9b4fhREotFhiQLhg/fa5xV5tWvd8LrvyKcIfL3Tpdha7uYl92lQDDZ8hrHTbcBMCnH6pQnDHr/vBiuGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370924; bh=nrCCEXkM5ne4ZCKca5Zxbq6NikYWjwX2neVdq8uTMFR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hyBJzx/Bt+EIYpNqtD4waQfutXdllMYh0KaqFsnnqY1ndZC9zZBhWoWNEBSe4L1dGmRs4yVXNQkobcfzwEVPFJqMlD2qUnV/ACJsd+Wk8xM/U+IsB7EbLeL2Ct3sAC4B8qxxcSt/NuSSyO9s6Y0nQU+YHpF398Vj+yci8hJ8Nlfp5bPh5Pzuf62jhdt3fXPpTk4Bm/tXeHqPHZmsJK7oRCSv7KByycub8dtpdl4v4LaCCxAyw1Iey2hZ1uKtW/W8shVM8z7XmTqlau7nScZk/Y4RqSdW9Ia0zIRnLt5fSt84GRYN3DVW95VBwi277Bmlu3TVJaCOoEEBSNT6VkVnVA==
X-YMail-OSG: BVijqLsVM1kSgO__1x5iyoabSF5PVNqQkShDih7tLDIwq_mrUYqFPf7k8pE04Vt
 bEiudCQI3hVslk5KuJRcqg9rSwzII00McgjuSnO83_.5a8zFX_malfk10BIWs5zUqizkev7Bd81Q
 fhb6N98ltEUNRABJsOGAdihJxT7mxhCHY9WRKLB3Sd5SB38tOlr.ax27IlSfvTgAZlQX5pYGjT67
 W1Ez3x6mmzsUW.3iNWTxU4w4FQlkZmsAc6dKAnkg_R7ORe_0jhgPGg5aq5mjB765MiXnpjPk_K1w
 Io.YL_s4prBJBO9_K24Sh5PuMt_.tO6jEmd5Kvgnv0jzbcVW0sdipDAAhoPFGd6rocfIfM7a2W5i
 U0Tj0hqZDVnwrriKs48Q93p2FcWiEqEsQVXfZ.OCEDBOkU6mGJ1MYvX_PmaF0DMaTqw_8WkZ1Omu
 rEZjAroYCgix8KkOXbiJfQ7tYQpUgcdNJnoQpgshNvKyw9oZ2PypRjyPnEXtNECeQJe_XqmjEMyj
 rXh7vRxfIluyZBlzJYhw.hLmuTFgRFYDc4rqCmvGuW2rdD17cF3QLDDaGUKHxFrcWATAowrqopfl
 FJHXrTHalxCRz4yM0Or2NKXDXC7ODiNJLrPtlsg6yYRPoq086A1_S3q0bBhu2myGGv_kGe7DXFpl
 vLgOYg8WIjyCSJjG4AwANDnp7mob845j7qF9QFiw6WV_VcDgvY_9SRurCxUVrvEwk9GgGRAOEiWB
 RBr5phUBwO.OSYO1APZ_i0KTBLekzpSwNpPitgLY6tUu5B5BldGNVc0fQC3KWP7I7yZdNHrVH7Xe
 tlTMIACI63pCIbRBSNh_WWdEhj6u8VH9arj6OPVr3LiiVn0yDo5kigjbqkXbTLDXDPyzeoRCsYHW
 1AMwChRiMiRC6HM5P0dKuV0c32m1w_7JaEp_cgYWPEby.rIf6HqSOZl9QpGDioUAOkXyqxrU2l8v
 yaG6Fd4EQTT1zMFpEwjo42WjZj0tzoGl_MEBP2vQDr3llSM9.bl_.c3t3ZXl.UyVFEOR2m2BtblK
 j7rXUHV7hQ1FKztVt4ibKkkJnOxyl4hfTckAw6T6Hgr0iG1RoBQx1pYC7dkr8BqnVPQ6MeH9VEia
 rKurrd6UVRWmznNM8k8nJXx1n0X84KSSrIB8w4P3pnepDyApZCVpaf2NEUJ.bO116o0Xb.dzg8YL
 hmuFXhJKiDIAqVBQsZgxd6W7ZKMHv6o2AdfQYqtUTogPEI5kjRBLzw2e7mzY6OxIU5T0zhZboJ_.
 XiZeNUJ5MZMkKd5dPa5nhvOKG2.7OlOnYR_mkxUR0p5pcF_JpwpQjcG0Ff.viGwuDYSRZvm7LHeQ
 qtSx5pYbpV_u4ktqGoMc0awg2w59FyJB2GCkVZK49PTxNt1dEBqLo3KYS.Q7NY0YAG9eTZ4sqv81
 9J3jmklSVHaxTL8MUzg3yBZrxavShv3338XWAG.LDCOPpkOfNSohp6NBI3Gr2VbKf6xSHCaOwslZ
 aJuzz.BpuQ88zk6Fo4_3gVIKHXdyFCE5zFuRIUAVvq.Z0k1dZdklXxO_fmxA2L6r4Z6MRKWTBzk.
 kMyxb2zCUGuRc19mSoCZrc6nD1uye3FwBQo.eC21QxUxDnpezLnzbMywKa0nFcezBknoraHtqsfh
 5vqgGbFrW.uHeb1_Ct4wiSjpbtlJcE9KvN3A_OilmsUU78E6eauV6YcKnhbxdvBVX2DM1Ryenv4H
 RENaSAz3Q07rv38H.IrLmjLOd.EGEQkkg6G5ChepUsftxAWHb1e4bw6WYsEVDoGQrevxmXpWQiPZ
 HavPe8.bc.oihJN983Oi.0JoZsSpaaUEaOYowVtzjKbiL9fxVWb0HA6YOgMvQlOpQ39n3_cxtTpC
 qyVnns6GEMt.48Cf100gYvofQ4srIyWo41EfGayi.ZmgPrnUfyfZYG6VLCCslrJlBs15BNzdbDui
 AyQF.1HsjfLoS3xIuHclH7ZRIlbK6TFDku8xb7Qjr6g1PLtEYgxanBBOnIwA05vADTSdBC0oI4XS
 NEyWc9522J8lD9JnOw98OtRhiDvzSNkKZGcacirZOHPHcr0U7sPY1A07L4WnHvE2mM6LhXgooDxM
 L52WwblFwefAlQ3vADKvzfwUtCRbvHv7V4mYza6S3ZlzrflNNq8K44oyRNt8OfU5q6jGdM06OlIB
 4cjUlOlA1rYvzxlepcuuUQD2cStMadp9A3cVRdmzAygl_qRLt0ythLrEw7kKIPQPn_A6bA0o59hk
 meYsV..6yo4yxD2V5On7x0i0ajtM4TZerPE6nmnAsxYmJtHgIycoKJksGvBzF2ESZ5f99sMCYjMt
 wRn8SZO73NNl4FGuSs.FskySNoUbhHcN4ww--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e60a6a92-d3c8-4dd1-a3ec-77719cfe82fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:28:44 +0000
Received: by hermes--production-gq1-74d64bb7d7-w6q4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c0be3c125fd03faf460576765fd8680e;
          Thu, 24 Jul 2025 15:28:41 +0000 (UTC)
Message-ID: <58465c46-72b9-4f6d-9ebc-668a95024a27@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:28:39 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/34] lsm: rename ordered_lsm_init() to
 lsm_init_ordered()
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
 <20250721232142.77224-43-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-43-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> The new name more closely fits the rest of the naming scheme in
> security/lsm_init.c.  This patch also adds a trivial comment block to
> the top of the function.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7e736c20458a..c8af26a6ce14 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -288,7 +288,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -static void __init ordered_lsm_init(void)
> +/**
> + * lsm_init_ordered - Initialize the ordered LSMs
> + */
> +static void __init lsm_init_ordered(void)
>  {
>  	unsigned int first = 0;
>  	struct lsm_info **lsm;
> @@ -336,9 +339,6 @@ static void __init ordered_lsm_init(void)
>  	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>  	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
>  
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
>  	if (blob_sizes.lbs_file)
>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>  						   blob_sizes.lbs_file, 0,
> @@ -492,7 +492,7 @@ int __init security_init(void)
>  	}
>  
>  	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> +	lsm_init_ordered();
>  
>  	return 0;
>  }

