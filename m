Return-Path: <linux-integrity+bounces-6704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC55B10E56
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EECA1891CC5
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735542E040C;
	Thu, 24 Jul 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DSsSP/V8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3839255240
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369787; cv=none; b=ZF4I03sP4Z5G8mowDjNBGm2vBVpl+sJEykW5sAw4x/31jNM7djZ56XemG2clM8v96hkXpLT/ZpMF/rirsv7OLSi3QLhu4ssuYw24MqChMtiDC4xYteRAjSN0MSZYbYcDtBRo+9RlF5tTHd8PpE/2l5C92NOM4MNYM52dJUVXE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369787; c=relaxed/simple;
	bh=YYqsTuNHQfr2r328rpb2mLMHlYe22eUtT1NxSPbiFk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHmcNvER6tW79IkQ+1M3IKCJpVe7iEyYlPv9xv7Jz8m+VpnzaLlJQxWaS2agr3emPWqFkSoECzFrtqLCkFl6XoqerzuVnvrBnxpCN6UWiIaAyTfnOvHyoiJP5ev45xZRcNAt3XWEg4LgIzU2w2iLOyGycG3P32R7re29NZ3552c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DSsSP/V8; arc=none smtp.client-ip=66.163.184.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369785; bh=GKpU8Lr4KERCPJ/YI1WntB9JYltkrcxN3ijErftnLY0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DSsSP/V8stnPeGT0bavzIgOmbjgRZA5Xwlb6LHM+Z9FDM/XOkiGvA78RSn5S3uGZDqqyiKvBIEtL2c1C9FvP/laifvDe3b3FgcdfIT4Jw55NmBnpZhWoLlOFCHuFpabgVVeVo6RUNeT9ihJj0/ohRpeuppOGZGWlatAwn6IuBZMUo+FMgELt/wVVMdjw+SqsXw2dta6Kqc+Jy5M0hkHd2tCliZFWOhIT0bbz2kIsOWDMYUgcrHSQWXhKA4fRMD9sccsYVVUP5759wo4AjZkg7nF+w5GtIv0ANQFsPKzPahkQUHjOapYJC9eVP/tsQxepYREODCQzCKgit3VdGdTqJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753369785; bh=UWsjat/v1JGD2sXXyPggsefvu97I+xDJx/hOWXMWqw9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a1WOV24atW/+0Z7fwxV+wNJEQIbjXen1g7eS4kb6XFpWWHSw0zZfKBDi5cXEh3QHUtRW7SaYtW0F25JBIAlyqZeznUtkabY+mO0sHD+7ZWVPrsDCmrXHgLFiBI0Til53k8p9jP+E8eBFFUxeApCdSLKnkb0phSaoN1nQaQZYAL7xuaTd8rDzCqSsujRumaLvkSYi5TlAF9Y9/xXcVUs6YWB+r+MD5W7N6wdE2+inhJ/3DsqCEeCWRs2yeGLChSOjfdPQZHLQ0eN3mL/ZIKZ28KyrsQUR0FsXj0u676SptMrUdzSt7ls3OY8QzArm2u7m838A/KHsNwlA/MhBTVy02A==
X-YMail-OSG: _aT.iiwVM1lzMjrvAbKDot2bqC6poXm9L1u4l0nm7BwygktqPyRMpVPfxORCGXZ
 Ty2hMLHdhXKMmWmPKSV21aH7hkO3JypqXFzlEFYiyK0qbYLRbymDXX0gA4_mfLebriIuR1oCvg7Q
 ..xqDouRDmMZnglgo3zMV2jDj3OjniEWZPaqV9R.GDqrsUqbUtkndfySw6qfMkj7PRsrF4gW0mog
 Vf_Gt7cwQRGHxTad7bAOoidBfJAMmaOuOUzRPfv8jg2ndTE4i76ppYrACzn5d3fZDW7xqdn9GRor
 rLki59Hh2lm9lrZihRgECFcgOpC.IQgNEttDkJp30aSMpeQm88i_N.Lpy2CYVWZaOdvVIH9hc8q7
 XINu9OMak0MbouwcupT.k.LDEG0U5NeiYdhl3brVVc626Yx0cJqdwpnVuxdaAp01WiGFIdv5wTrS
 iOxlloWTi5eRvJdDqePpGUyS_qe0GvBdhTdHQD5mYGgTgb_OFYOUVY7j6uasaaJJ_vt9wVXqfQjR
 VsCPTI_8p.W.4Gpgjp_9Hrqpg4hhAJrEm.6lnKGLoIzrHX6_O08r8wtzHr3c9yHM7mm0Qat9dlc6
 Bx9jMuQ2XTc07USli9E2is9mobvnRUHFInR0f6dlf05sfR4wD.w2bttfgURHNL3U6cYR2nMoUttU
 SIjFqc5Y.C.Kow2BbBzksnjC56m3seg2sKaYx5i70CwS5agUs9d5sc3rpJv7Xvr5wDWI.6I_kgjM
 9fR7JkVH1WtU6AhyhAbY0Z37vfqO.K46F4LWJ_I8XKifkwTSDvCPCzFDn2avaPo4uODYw3fiLfy_
 zlR2AydrcAwwmZUHK6Pqmz0DFOmMgU4.oJ2RtE_tTGXYVjojbpWFcUjJqZSFt6h0FJATR5aarIyB
 tMwUcwSwFGzDaluZXUJ3ZypS2OCk4uzt_aJcNQzlXI7XmKqNzx26tkxE9ACwrFeIY7n._gODK4IV
 f9mZGk55E3S3dGknk9fO755_6htEU2TjLTBX_oBRQYRoGPdwrB8BJzGG_7Sgety.zmVFYuWiO5Uj
 t2y6JF7MIZbxxCOWa0_ME3oQ4LoHbg.WzH78O99B9O78lvxWLC2ymQ3M2q44XYjR6HDzHgHT7dl7
 sa5QinT90Psbn9_okRwgMBO8M8rS2_7DNqZmJmk5roz_lhdT_RfunBZA3IAGfkV8h5ALm6Rjk5Df
 sbgkB4l2DLd.mdHbRTX_WyLdmQ.T5qSGrXLikbCRq705V_iz1QkkHfdAxxJXSmgINI35rM6mm9Bz
 GTHGRaVzlgiCbpJnnMx7kMPwfsLfrtJT0KdFXkTpOj2c87yu7OvXTfnYKvuUATZYXHHwKy5Dyq1Q
 CnbE5kX72.qRLhd1IP7AGX6maHBXsUerW5jXYggImLePbLTvQnWiK.oEs0DyS9Tv2xZbJgIPE7Mh
 oLpCijPvPMda7YZbX_RivBMGFxm52XpUwhMD_3EiHp4svdoi_uUzuIAzszNAKfECft.ct.MQfSyX
 ATRQYN7j9wUxKwPmbBaEKZMJH0a_lfJ5DJbkx70GubPvxK8xHMPXz7aV723X0lhkRZWiD0Xam.ml
 gu9G3a6kwH1.JWfOtuWnKE9Hid1D.7.SAxFJYH83oAHJOnW2Qq6QOXlmQRsuTp416I9IQ.d8X0Oz
 HjXQqhH6d0efr1FjEyHBHZAgF68qpqiH2X1UsBz0CBMogMQZUM57QTYiRkBOGRel21ofgMW9VhIB
 XF49drK8l.7Z01kpmE8RB5vmyrxrOXE36x3VUC3LyvCUPaAzdzIokJimk0XbLrrlG8QNjQT7gYo5
 Po6zD1.XUUgCBe7EMFOsLE1hqmKr8goq9sgTc2JEVMcL0YPXcu15SgZkFwwO8zy5grXsVeodbvVo
 rwWba1lXm6599Xa3.q0Qk.67DESqsuucygoEen5gR6pKjbYlCc9_lWtqRAhn8krrIc5GlzTwO.pW
 agvUlt0ala5D_kPuIz6FNWCdxmYJ9W4hWq09gBH0.VLU.m5VCsI7odNuOmA8AC9BYe9ERmf1NcGS
 KUCy7vvbWyVKJR0EG5y2eJe3ekAwsUVaC3JeAA4AcDE_yYxLjiZwBEV4L5rn5WnEctrOmNadgQXA
 kf0VarpEzU5HGBr3RaNALt46fX.PLK_8QBg.c85S11jaGW3RPRE8yaEwmUH33hig0ZpVB87H2tJs
 nl517gDDPtk_UXMIabfpv5DXjo5H9UXNDQQM2.t45GqmP11tpGbcrzz_SPunz_en4VixY4c5N9O4
 Fr7S7rh6wKIyh35s1PiqnWDV6NbJjtfI59Vvl4egdaZFOXn29gThWGokDzX6A79so24.e6Pl_FcH
 9NQStrYUTqqI4cbxcBOaV2g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 85d9168a-817e-4894-9f96-de24c0b4e419
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:09:45 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e5599fdaa5f1b7062e67c44c27e5632;
          Thu, 24 Jul 2025 14:49:27 +0000 (UTC)
Message-ID: <161dfaa8-8273-4b15-8a26-abd1af2fb739@schaufler-ca.com>
Date: Thu, 24 Jul 2025 07:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/34] lsm: split the notifier code out into
 lsm_notifier.c
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
 <20250721232142.77224-37-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-37-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> In an effort to decompose security/security.c somewhat to make it less
> twisted and unwieldy, pull out the LSM notifier code into a new file
> as it is fairly well self-contained.
>
> No code changes.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/Makefile       |  2 +-
>  security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
>  security/security.c     | 23 -----------------------
>  3 files changed, 32 insertions(+), 24 deletions(-)
>  create mode 100644 security/lsm_notifier.c
>
> diff --git a/security/Makefile b/security/Makefile
> index 22ff4c8bd8ce..14d87847bce8 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+= min_addr.o
>  
>  # Object file lists
> -obj-$(CONFIG_SECURITY)			+= security.o
> +obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
>  obj-$(CONFIG_SECURITYFS)		+= inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
>  obj-$(CONFIG_SECURITY_SMACK)		+= smack/
> diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
> new file mode 100644
> index 000000000000..c92fad5d57d4
> --- /dev/null
> +++ b/security/lsm_notifier.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM notifier functions
> + *
> + */
> +
> +#include <linux/notifier.h>
> +#include <linux/security.h>
> +
> +static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> +
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> +{
> +	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> +					    event, data);
> +}
> +EXPORT_SYMBOL(call_blocking_lsm_notifier);
> +
> +int register_blocking_lsm_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
> +						nb);
> +}
> +EXPORT_SYMBOL(register_blocking_lsm_notifier);
> +
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
> +						  nb);
> +}
> +EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
> diff --git a/security/security.c b/security/security.c
> index fc8405928cc7..ea09a71d9767 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> -
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
> @@ -643,27 +641,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	}
>  }
>  
> -int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> -{
> -	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> -					    event, data);
> -}
> -EXPORT_SYMBOL(call_blocking_lsm_notifier);
> -
> -int register_blocking_lsm_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
> -						nb);
> -}
> -EXPORT_SYMBOL(register_blocking_lsm_notifier);
> -
> -int unregister_blocking_lsm_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
> -						  nb);
> -}
> -EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
> -
>  /**
>   * lsm_blob_alloc - allocate a composite blob
>   * @dest: the destination for the blob

