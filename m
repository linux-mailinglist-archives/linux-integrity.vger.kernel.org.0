Return-Path: <linux-integrity+bounces-6992-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39721B40D03
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9761B63742
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1632F77E;
	Tue,  2 Sep 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OWB8gLDc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172A2D6E57
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837225; cv=none; b=CKfuiwv1+J/mLiaowDJ/5snl/JQK5OG4PHIaHLnQBOJM7BT76HJzSxSnN7FCg2qJnvndYlSQTpxKtqlJ0UwZAOQLJ8/OFMmcZ+TMs5AHPcnaWr3q8nlj9wsqCMTqa8IKzhARMbjAQmPLGjBCpiMbv+Ak5V4MTLzXyYQ9kD7pcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837225; c=relaxed/simple;
	bh=3KBBQEXp1j2SUecge6Vg1ut0WIqcmHxhVYmH8pKx/O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/pnEK5UOMrydIGCsSjFAw/amg32981DSs06nWviaFLlpUiFgc8pqRg7eqBJAwBrNAjjWgZUjrNVQPWLno2qH7Pt2jZfYQqxu5tzu33Lq0ng1kyER/OO9wBXJTu1bHgybvlZFsVaRk7t12ewSDhOeIqpGvNc1/fiUq//6kqduo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OWB8gLDc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 770BA3F078
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756837221;
	bh=S029MEGT5TSIi/OkV9SSMnt5iIRR8VzURXAohDvFhBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OWB8gLDc8WEfWCe/LgyJRe0+Jo+SUI1SY7zQ+naLVtKOMZ933ErbVSKf4dlsZi1O2
	 9OFSo+xb/lUWEi3R4nCh0a/Z3phMXaTv82aXIiKT3BgpnqkwuHQ2LgaNS/rU/W/Ap4
	 UZvlHKIkz9RrVjGvDWdon+Zwo/81CD1XSQpEiG2U7OsSEolKoYQ2g5tZFTAe928FCL
	 bQKTqcg/8IfNybIfyJ7xZb+/2yKh6Cj2wKzgL11FUECg4w3Oxxq8mnSSOE7dhK5kDm
	 OuqlMqBSttzofezM8lDQKJZiDu8q2QsM9OOTJilikBIa27wO3b1AeW2asNXpxlKi9j
	 xnj8HKwgxoObg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24a9de13b7eso35611835ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 11:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837220; x=1757442020;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S029MEGT5TSIi/OkV9SSMnt5iIRR8VzURXAohDvFhBg=;
        b=KRGNBsn15Qilp/0da0Scuhyq3efyDzRBdmKt3t7cPe5GH5+lq1HM5d5fPPFLXzOS06
         V0gCQUYuyaP0eiUVmR/LjrYzy4e6oB6rJ32gTYwHH4It37luGDYohRJtVARqYKLO8W8N
         ovG7m8xJwsS6IITyBLcggUngE7golhLmi42GhjeCd80JFA4jlWQn/Qvjr7hX99L1diPk
         K9X1Jhd2KRbYP9txbE1BX+mloAu3oYmBaD7mHMgKMydZ+7n1krJZvcRMuiiauqxyFSEV
         4zyZiLAMjyeqqiOe1g4zLgLz2wJeFqbc07hZl8VmoubddYBoeu+NT76VaQvPN5bMlw0N
         wHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWQe2Q4LT+e+9XerV/EBp0jRRAuv9/YjbRatvF9QxYAAiDBMSSnIpeCHXM3q9CV/QzH3JKkzdFenrex+3RogXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFf0IlkFeZWOkNOV2gexavRWNkJlTFhMiGNCJclVvoJElS/sXW
	PQL4iRNxGQOSq92IhsTjdQ9rI+GjqKPnweNkOwGnA48qLLyHQ5iV7SBpVPpjOAWajmiZfiv7KdU
	E+plyY3ZIaJToSPVMRUmsdx67Y8OYJGERREcdQxUSoyrx6/V0AIUZllu+46hhTzBsu/uo3WFb63
	r655qHj51wIw==
X-Gm-Gg: ASbGncswcjYi8KuqLzzGHwQluWdsNuZyiRxdGA0KiUkONWtMmOjgY+Hg5Y0eciVEOxF
	DKF00V+gLddrlVpwWn7qlMEHqCj8mjawITNwyKcA51SB9AY6eI/qDXnoglCT0/T3JG1w6Gy2RQe
	J8bVH/hYLZXGWy3Ha0aaGFibyf91zN2QMxUBfof86awMNEd/jYE1pp/O0VqVVE9lb4rIfgR+QPj
	5U4sOLNnDjGvn4C72YJ0KHIjsPcm0OlyyAjdXPG7Vc/kj4W7TyCjXZEmO9IJDGMJ+mapoah9ORZ
	Mht9E4Bf9Pz/OeycCfavrgpGh9BxevOVHE8r/zOs9m948XmQOnh+4A==
X-Received: by 2002:a17:903:41d0:b0:249:27b9:2a06 with SMTP id d9443c01a7336-2494488a758mr174465785ad.2.1756837220017;
        Tue, 02 Sep 2025 11:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+EckhCuZ4GrS0CI5mr4WL8iciCvCMGF84eY8IDYjRhJGB4SQ097kgD6id6n31fkyvBsZQxg==
X-Received: by 2002:a17:903:41d0:b0:249:27b9:2a06 with SMTP id d9443c01a7336-2494488a758mr174465435ad.2.1756837219567;
        Tue, 02 Sep 2025 11:20:19 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065b7413sm136066355ad.132.2025.09.02.11.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:20:18 -0700 (PDT)
Message-ID: <ed07813e-e000-4e62-8801-8d190517cd5a@canonical.com>
Date: Tue, 2 Sep 2025 11:20:18 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/34] lsm: consolidate all of the LSM framework
 initcalls
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
 <20250814225159.275901-69-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-69-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> The LSM framework itself registers a small number of initcalls, this
> patch converts these initcalls into the new initcall mechanism.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/inode.c    |  3 +--
>   security/lsm.h      |  4 ++++
>   security/lsm_init.c | 14 ++++++++++++--
>   security/min_addr.c |  5 +++--
>   4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index a5e7a073e672..21b1f9b4d396 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -384,7 +384,7 @@ static const struct file_operations lsm_ops = {
>   };
>   #endif
>   
> -static int __init securityfs_init(void)
> +int __init securityfs_init(void)
>   {
>   	int retval;
>   
> @@ -403,4 +403,3 @@ static int __init securityfs_init(void)
>   #endif
>   	return 0;
>   }
> -core_initcall(securityfs_init);
> diff --git a/security/lsm.h b/security/lsm.h
> index 8dc267977ae0..436219260376 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
>   int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>   int lsm_task_alloc(struct task_struct *task);
>   
> +/* LSM framework initializers */
> +int securityfs_init(void);
> +int min_addr_init(void);
> +
>   #endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 697482a22a02..2bd705836df8 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -488,7 +488,12 @@ int __init security_init(void)
>    */
>   static int __init security_initcall_pure(void)
>   {
> -	return lsm_initcall(pure);
> +	int rc_adr, rc_lsm;
> +
> +	rc_adr = min_addr_init();
> +	rc_lsm = lsm_initcall(pure);
> +
> +	return (rc_adr ? rc_adr : rc_lsm);
>   }
>   pure_initcall(security_initcall_pure);
>   
> @@ -506,7 +511,12 @@ early_initcall(security_initcall_early);
>    */
>   static int __init security_initcall_core(void)
>   {
> -	return lsm_initcall(core);
> +	int rc_sfs, rc_lsm;
> +
> +	rc_sfs = securityfs_init();
> +	rc_lsm = lsm_initcall(core);
> +
> +	return (rc_sfs ? rc_sfs : rc_lsm);
>   }
>   core_initcall(security_initcall_core);
>   
> diff --git a/security/min_addr.c b/security/min_addr.c
> index df1bc643d886..40714bdeefbe 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -4,6 +4,8 @@
>   #include <linux/security.h>
>   #include <linux/sysctl.h>
>   
> +#include "lsm.h"
> +
>   /* amount of vm to protect from userspace access by both DAC and the LSM*/
>   unsigned long mmap_min_addr;
>   /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
> @@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
>   	},
>   };
>   
> -static int __init init_mmap_min_addr(void)
> +int __init min_addr_init(void)
>   {
>   	register_sysctl_init("vm", min_addr_sysctl_table);
>   	update_mmap_min_addr();
>   
>   	return 0;
>   }
> -pure_initcall(init_mmap_min_addr);


