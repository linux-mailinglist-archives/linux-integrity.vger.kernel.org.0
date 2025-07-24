Return-Path: <linux-integrity+bounces-6712-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8DB10ED3
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEFA7A2D26
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2612E889D;
	Thu, 24 Jul 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xsmb0Kgu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E21509AB
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371291; cv=none; b=JfAWRcsn3chZ7brRXsgluwkIC4EvgXMfxhElnwdnnn3Td0kWBxMdniHUI/HF3qPOBCxCmqpHYDv41KfGFevtxwwrdcN2lHf6trq0Fv6GyLqZ03TnIBNzkQc+hohafUfBK7WPldD7mX5lyW/I32GKj2XycLxRuKYcbhICfgRSOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371291; c=relaxed/simple;
	bh=Pz5SoBH2YUO4yn3YYQgPx/XDyMDgcUNF18g+bfUJ9IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmT3IafTM3yF28jpdHEs2yEouUcSk1P62k0r8QO8GiLeGIrAWjhx7Iukhsrku3m8yIurksqdQ8Jnnqh++g00b63ldbC6nidpwIHl/n2DXibFyYWCi559DzcxnRMrmbqkP8gsMbEaRmL0fB8Sn5cJaQUz9riXkMuf9gMWupB33rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Xsmb0Kgu; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371288; bh=8DOPFlN5bPJaQ0VK2CbbxDCA5xdqsJ3SxCikZr63ock=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Xsmb0KguuZDjBqs3TIqevsQDI800SEcbzhjZRbrP+/vEbvFCk+TRoIb064kqVwwERIjC4EgDoe7Xeh88QlKocfxyIZfaTtRId+rw3+TjRlOD9Zwh4kJvgyBYJ6LnLsBf5dnmMaChm+NHFismaV1N7/Vohvv/M5UEsH+9EzHVfbfPZOO/FKpdhrtYR4/juknhGRhe0y99Zd4lHJpfdA8X891ujBl7Zv6b1eraVAEikIKTzUBvj98EWI0bilddS7OXtMEpetYCFFeZV40lVhkQNF0iHx6zJPAH2th4LJXD1oIGj+sB3SoYlyPzfH4dyQ0NRb9Sks/TCS9l4PjX0yJIFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371288; bh=ZHz1IRnStO+G0IooQN2lIBQIfur94uzKnyz8oofApuU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bTPbTg2PYD2TEi1/W6ODbUOyhQoaO1qwDvOTVAxHlT9hrGv979u1oyX99mW66tfOR8FBF6zRUXoDVcrFzBF+jnNNymq0aLZBlssW4ZP13QpCOFnZxDd2UeFibsHEYSqArD/9P+8c/7J0yw2MGjgGB9j/v7FalJlvF0gvNesK2ig4DhM8+b/JZlZ5MDB2t6fZXEoosZppqMMuqmFdcuqXHEjr41YDSHPpq/HH8rE+1o/NC1NP8EIg2JE+YxUULTQmIIEoAxLLqEzACsF/vEDfMUCa0TX3w2ItS6Vy84x3xA+LmuY/4LwJEl5ktGKlRQGsSLDea2vNJBhIjBwCnYs6zQ==
X-YMail-OSG: AolkRTsVM1kswcr9Q9YA8lKkyMwBX_aLWU3jGjuFnm7k.sBYg1wdgcXkZrIOlXf
 ax7PSnz4GEgA3mXvLwiR7kn11JcRY_J5tXSq79hSU0JnKtntVJT0uqjJUH1A98hbVFGcAeNv8r7.
 x3FzZqCfbKDcuhd8FTG33bDNrIC9MoaYPjbLhKb0i9AV_C5A5CPnJ9OGOeQQ55Qra9V_CgR6InWy
 nE7tbt2zXae14f06AsytgVyzwUHJMGOOgd8d0JWCm3mexStze4msZbmfGRzUJ.l8TYWflYTCCA6S
 bDe4kcuTlDzyRD17C3vha0JF6P0HIrMdAD_FvQMxgA0CFpUjrj6VyYAeKmkTN1BwqiAa2CKxDBBX
 7y18hUb9zwaYfjA1nx.MlBI6AyGuTRitmovbw50ONV6EQpRhrlHMYs5iIZl63wA.F2odCqW1pnCH
 eNSXLb65fgamS0FUPclhyskIe_SBEN2bYyAwPKXqGZlP2b5oNzOXSEmAbt7SbTkcTQB__dAiEmBw
 LTAQ1N7ZObYJTKjBmQZkzuxtviTW.XKE4sLpFuWPmp6AuEIX.bN9iudSAsYfTQtzVE.TR8ZHK365
 uzcnAy7YCD.n.a3IfrjegWUvSU.5.6Hf3.4ihX0q.s6n1JtK3UlZt9zeshQ16QqoiPNZyVy.QEJK
 3v1aXXQCLIrK8ekJKokccDXkvZq37Sc3gLNdXnS3o5L5BSTbr8UEoAYna2GlvIBZ3E2YMYkibovz
 FZmabPk21Yu7ev22doLcNWCu80cYVgeXYhV_Z.8jtTRWxMGXIN5ukrw47xPuBFQo43nmSkF0cN_I
 67xS5TwbIbWFtA3.71ZN6XzzTg1Ef_L0qqAdrDgf8tc5Cylt2IitHdRzeLkN48kvbGT4u2cbFDE8
 zrpRpAtul40xiA2MFryIRVvI7WtBtzVcgrRXh9XuO8M92QBLThh9tTUWy4WdGsg0vqvAYcTu7Rec
 VElviTgq8.D4CiTAnlggdqibQRtMTWhrJ6GUB0AHMPTrpFIlC5lcMGnjBZIZODZPGCZZXdydBW8n
 hfwsGQjSTzYFoSoTeeTChO8V4_fDxc02qXO6gYpILZeDtxMKCZjNy8kXdzE6sM5EbKieWlQL7y04
 0yn3DeoE5ddZvLPnz.iqk7q8VICAidQ8SJsrI_Gmkpms_RVgAPZT7TLRC6c3yuLkVHYhYy2hOUD2
 mX8lKWisY8pknVwoA.aRHeYXNjhszp7Ori5G7s9lExwJIppLkt5SDoIQv4i6vzfoztpD2UP.w4Aq
 DrGm2zlOdDy0XPO2JXhfV82TJwrqAFvr8Dep3gh.2eRV2H3OJ._Mkiv3RHHGDDxgBE2l5ceH.fBj
 TqKIgfaEUKWdt.NMZTMj6KTO9LPJGTpuqUHUjgPyeI34qrrrjl7TPwINr9rpzF_tg9dZqLlL9a3b
 _andrKWAmwaefz49YeYCOLFyy9VbEi21DAdAWoaWlKH9PKJ4UEydpiJb7uLGZIqCPxk1zmg0n06S
 pcknu7T0efN5YU1RWfOdMW7wvPDOWMrfZJjtogLD2.E2yMzO7xirWQCticu6S32vHpvLvf64meZw
 LWhWDD5faqdDZiXyPcffbt8QLv0oGdXz2bWZKuaC3xi4DeNCIT3HMfrmuY2QM4rDB415R5G6g09n
 NJRvBQg7gSPiJpSBv0Lp4FpDeB80BC52U7D7HH2e_XUy6qZ7UqSUCDwsRYj9i9SOJrSzf7wYcuO9
 8_aIMByPXcd501io6nyueFpq9holwQntXdo1mpcLWowKlMCMkFatPXmfFGMpyCEDqMC_QSdqW9Ob
 SC63z5ROUzWif9JG5tYltpQFnh66FWHu0NsIylV_a2rk8np7l7xjSsDodlCKXdU1Byn5V0f0A6UO
 KLU6GzilKaj8rVWZBvB00QazpHZT1w88EamIN6L5Uhl4ZyS4WJzBT8Kh_IIxx1lgXVylF.8CWUAE
 SxEC4OxTASNcHSp_g7JMR9.KZblk3iMBubtyqB1nwfUqVa4c_SAPgCysNryedQ93DBtV.J4i6NO1
 4vnp5brsackf44y6ka4IDn4.4fF0Dos0S.CoVJmMaIxRC_sKFpXd2Xm1zACSwR5EDaAZ.hw3cUR9
 PEHJKnyK_M9uqJAi9_GE8zG30X5ly8o02.YwO5WT6dSxG.FdRGMYtQAzFE4z4xrVnYo7M6SK9QMU
 976mm5hTCHw71K94lICf9TGT3nBhaKaUkS58rpGjxWj4DEHLn7IA9JX8BzU.L6zxk9AMAOAvnyUt
 AAdICUfsNQCekeb_SkaIKhd3K5PP2KppW2PPUrj2gyUaAH6PFW9EqjaS4ITA_LZwYuHFr9tiPSdx
 pHn4A_s8iJ4FHNKx7HK1kGm8I80lEVqTCbcL5kC_N
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 845d03a9-909a-40be-8e43-b6ac2dde4b4d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:34:48 +0000
Received: by hermes--production-gq1-74d64bb7d7-grhph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e57ca9b53ea44660d24e6669cf30f03a;
          Thu, 24 Jul 2025 15:34:46 +0000 (UTC)
Message-ID: <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:34:44 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
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
 <20250721232142.77224-46-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-46-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Move the LSM active count and lsm_id list declarations out of a header
> that is visible across the kernel and into a header that is limited to
> the LSM framework.  This not only helps keep the include/linux headers
> smaller and cleaner, it helps prevent misuse of these variables.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

One nit below, otherwise

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/security.h | 2 --
>  security/lsm.h           | 5 +++++
>  security/lsm_init.c      | 8 +-------
>  security/lsm_syscalls.c  | 2 ++
>  security/security.c      | 3 +++
>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e8d9f6069f0c..c57a9a7499ea 100644
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
> index 0e1731bad4a7..dbe755c45e57 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -7,6 +7,11 @@
>  #define _LSM_H_
>  
>  #include <linux/lsm_hooks.h>
> +#include <linux/lsm_count.h>
> +
> +/* List of configured LSMs */
> +extern unsigned int lsm_active_cnt;
> +extern const struct lsm_id *lsm_idlist[];
>  
>  /* LSM blob configuration */
>  extern struct lsm_blob_sizes blob_sizes;
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index cbdfac31ede4..03d3e140e0b1 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
>  static __initdata const char *lsm_order_legacy;
>  
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  static __initdata struct lsm_info *lsm_exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];

I can't see there's a good reason for the reordering. I'm not
objecting to it, but it's curious.

>  
>  static __initdata bool debug;
>  #define init_debug(...)							\
> @@ -214,12 +214,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
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
> index 8440948a690c..5648b1f0ce9c 100644
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
> diff --git a/security/security.c b/security/security.c
> index e77791058086..106f225f4a80 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> +unsigned int lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
>  struct lsm_blob_sizes blob_sizes;
>  
>  struct kmem_cache *lsm_file_cache;

