Return-Path: <linux-integrity+bounces-7029-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EDB484D7
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 09:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25F13A9A33
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297E747F;
	Mon,  8 Sep 2025 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SveNKtWu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7F158535
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315575; cv=none; b=TPkP6WPQfKZAXW1a8DEI3pzcaVHk8snJw+orhet2gGhWJ+gIXj/1CbPOB8ze5fLrIDqhuwlzftzXck9nQy0RggFA97ZWDZ8wNIL0MdqAPldONBZSTa7GMvhMV2Ts3StxBGzyQJLvqV1wDT65EHUdrLfrwG6nJP+A3TLfLmEnZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315575; c=relaxed/simple;
	bh=bRFl6phf//agXMWYkBxqfuS4OBU+Qiep6bWRlrZMc8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlrjZ2zPWn3tuzHvjBTbZ37wdUwdUSeJZmS9PzSlo263BvMJPPnElsihE+84bhAeLV8ZWI4llmUqYWtyrBfJcrASLfZCg1wF39tl8Efa3VBCjOGyZxybbSqE5sDp2vgj6zGfrIXj/HTFbwU0UIOCIFVlRtHZyOWEysPQ3B3Ik+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SveNKtWu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 562913F17B
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 07:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757315564;
	bh=AynpZv807TUQ35uGuPrin3X+OJ+GymjvTkOYjjoh2cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=SveNKtWuHfJbPb18Sc02rlZMNJ1PEXzaMz+p3JXYlSBDRvAGvS33xPWX2Z6RYlZNj
	 tDDmeSf+C/+0+rWKx3ubdcqRju9F09qvfsgcPT/QY4xlhuoqP1hy9sAbziJzrTo+m1
	 Fxp6+Sarg1aN/wC6b9j9KOuNaKJ5JCRKOXamRg0lbmvxBFnt08ZHTzIgSBUMXQaBp1
	 nA9jV6OdoSa66NHPATKFSjm/ewNfO0GMtwGt+3ariLY/VBj/jYWKrH/xGuyMtix0Qz
	 XP4pueVJiKx70XXbXJzVT+SmGhRWi6l7wYZ4Zr1IsgYiZsGWSS8jOyWxTja5AimFlB
	 CHs5g/aJLo5Vw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b52047b3f21so1801938a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 00:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315563; x=1757920363;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AynpZv807TUQ35uGuPrin3X+OJ+GymjvTkOYjjoh2cY=;
        b=cd7Ov5b25k5X8fDB4krP3x8tlNJSzG57mAxph7FD06DCnqKG68QjDTXSfW+ApzTIzs
         nH3szbkRltrbFi47d2pCR2r+SBOLHd9oeh+l5c/X6fNJ+jZfIYawOKaqQbdfx1sYDOER
         SN7R/i420fWPwC1w+/HflcCjs0BbRKAeETIsKREWdz4dXOEHc6xVY0O+jXEk9aCQ/fyn
         VuubCLJREyQiqnhG0Llkduw2llIhEhhYSFYnENM5/xV19KCyFpWH8IwzGYi6CCOxYpHX
         aH86A8t4NtnINrHnNx2Lyb9Ig+raiovEiLcMmg2wPEzTUZjTzpOIZuO8JsZ5Pvmxzo+y
         QG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiSxKU2Qx4iwH8E1OlkRX4NbXa4sbhy1ePinoWmAYsvHfrHav0pRPZ1cHjqbRBF3SKr7nHbIG4xGKB2pl9nNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDctQ1y/35FwTw86wI2PQA+KHxv17uUzWouFqVBmz7ykJGwGeR
	W5rjuY46KafBWvGDFojaFcoO/fRmVsu8wFf+w9xKrpDhvnKh61ueiir3lr2STFkD0JGqK1/Bi0B
	UgyQav1ZdgJVFVExX+56IwVeOCK15NTB2yps1Ja1Xce5/sqiAKy8v9Cj8IqOUTlMFKpgZ/JYtVv
	ItHJyKyvPO/A==
X-Gm-Gg: ASbGncthcEYjOZ+j3tx6z5c1MijoEHLq2A0T1VNEFJEspyEw2/Oym0quRCBdWRSRGgm
	hpSQuNXnz7CoHO+8H7JpSBsbOpw2DARv7Hu8gLtY+aE+oVzOImbuUkU2sW833Se67B7GwYW9C45
	V0E+uusmkSKSbrEx90ru1LhGJERkRyvpqnBxsND6QX01I75QC+c9MqLcZQvChB7ZYiztvopeHU+
	Q5Yd7BlnkZaWZ1v430/duACQcM3huUn1rq6g3RB99FyujPRD4kjo3mOThYUuJOsm7QzeFJ5/vLd
	zhY8U+aTJC53+9HkyDB/jKxLOAGZbnsgQhyUv9jEhCKaYXrtKe00tA==
X-Received: by 2002:a05:6a20:2449:b0:24d:56d5:369e with SMTP id adf61e73a8af0-2533e18ca7cmr11487656637.3.1757315562879;
        Mon, 08 Sep 2025 00:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCy8YzCNFnPx4W6hGVndSBHP5+0cYoG8jaVcNZwogZyPLG38j8OT8+5jEAQaBBeGrFHZiNaQ==
X-Received: by 2002:a05:6a20:2449:b0:24d:56d5:369e with SMTP id adf61e73a8af0-2533e18ca7cmr11487602637.3.1757315562168;
        Mon, 08 Sep 2025 00:12:42 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm28567515b3a.42.2025.09.08.00.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:12:41 -0700 (PDT)
Message-ID: <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
Date: Mon, 8 Sep 2025 00:12:40 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-65-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-65-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sorry this took so long.
So the patch itself looks good, and can have my
Acked-by: John Johansen <john.johansen@canonical.com>

with that said I have done 3 different builds with this series. Tweaking the base,
and the config, and I haven't been able to successfully booted any of them. I am
not sure what I am missing yet. I working on a bisect, but its just a side project
atm.

Until I can get a successful boot, and test. I am going to refrain from finishing
out the review.


> ---
>   security/apparmor/apparmorfs.c         | 4 +---
>   security/apparmor/crypto.c             | 3 +--
>   security/apparmor/include/apparmorfs.h | 2 ++
>   security/apparmor/include/crypto.h     | 1 +
>   security/apparmor/lsm.c                | 9 ++++++++-
>   5 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 391a586d0557..ee04c1ac9d6e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2649,7 +2649,7 @@ static const struct inode_operations policy_link_iops = {
>    *
>    * Returns: error on failure
>    */
> -static int __init aa_create_aafs(void)
> +int __init aa_create_aafs(void)
>   {
>   	struct dentry *dent;
>   	int error;
> @@ -2728,5 +2728,3 @@ static int __init aa_create_aafs(void)
>   	AA_ERROR("Error creating AppArmor securityfs\n");
>   	return error;
>   }
> -
> -fs_initcall(aa_create_aafs);
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index 227d47c14907..d8a7bde94d79 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -53,10 +53,9 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>   	return 0;
>   }
>   
> -static int __init init_profile_hash(void)
> +int __init init_profile_hash(void)
>   {
>   	if (apparmor_initialized)
>   		aa_info_message("AppArmor sha256 policy hashing enabled");
>   	return 0;
>   }
> -late_initcall(init_profile_hash);
> diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
> index 1e94904f68d9..dd580594dfb7 100644
> --- a/security/apparmor/include/apparmorfs.h
> +++ b/security/apparmor/include/apparmorfs.h
> @@ -104,6 +104,8 @@ enum aafs_prof_type {
>   #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
>   #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
>   
> +int aa_create_aafs(void);
> +
>   void __aa_bump_ns_revision(struct aa_ns *ns);
>   void __aafs_profile_rmdir(struct aa_profile *profile);
>   void __aafs_profile_migrate_dents(struct aa_profile *old,
> diff --git a/security/apparmor/include/crypto.h b/security/apparmor/include/crypto.h
> index 636a04e20d91..f3ffd388cc58 100644
> --- a/security/apparmor/include/crypto.h
> +++ b/security/apparmor/include/crypto.h
> @@ -13,6 +13,7 @@
>   #include "policy.h"
>   
>   #ifdef CONFIG_SECURITY_APPARMOR_HASH
> +int init_profile_hash(void);
>   unsigned int aa_hash_size(void);
>   char *aa_calc_hash(void *data, size_t len);
>   int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 45b3a304d525..647c13e13e63 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -32,6 +32,7 @@
>   #include "include/audit.h"
>   #include "include/capability.h"
>   #include "include/cred.h"
> +#include "include/crypto.h"
>   #include "include/file.h"
>   #include "include/ipc.h"
>   #include "include/net.h"
> @@ -2426,7 +2427,6 @@ static int __init apparmor_nf_ip_init(void)
>   
>   	return 0;
>   }
> -__initcall(apparmor_nf_ip_init);
>   #endif
>   
>   static char nulldfa_src[] __aligned(8) = {
> @@ -2557,4 +2557,11 @@ DEFINE_LSM(apparmor) = {
>   	.enabled = &apparmor_enabled,
>   	.blobs = &apparmor_blob_sizes,
>   	.init = apparmor_init,
> +	.initcall_fs = aa_create_aafs,
> +#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
> +	.initcall_device = apparmor_nf_ip_init,
> +#endif
> +#ifdef CONFIG_SECURITY_APPARMOR_HASH
> +	.initcall_late = init_profile_hash,
> +#endif
>



