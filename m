Return-Path: <linux-integrity+bounces-6987-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C631FB40C8E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E9F543EBC
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B71342CBA;
	Tue,  2 Sep 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OHk0Jj4H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34238340DA8
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835581; cv=none; b=a8pU3DYGRghVuqWaueZPyxceHx6USEb32Lf8SVaN31jV6VSsqAyBhElXQ6IX9DgYrL+AelK9P5xZJFMYh0X6Nh4uwULIdiXf4iaE3Ob5pg17ag4nP6p5N8hxUTJMCGMXFtVsvUUwHkNIEG8ZjSrmsiuekuRqch/F3vNaQ5wVFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835581; c=relaxed/simple;
	bh=JEOupSin7pKtPN3pihuGrO9WryLFaHbNLWHULw2oJt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC8PXLbroTGqVCgpSK6EbY0Tl0fgs+8w0vuiAfjrd9omuVQwOOsDYkwFfdY6JQsTTwrQ4L1io1adSpwmIxxaHCihklKYaYVTSS3Co1MPlXKz9xYG0s0SLTCs06CJW6ZVbxAo93EMFX5FDlBh/9YSEsiGIOmltuVZ0MQWerCmnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OHk0Jj4H; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 993103F697
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835578;
	bh=kfAtA0V7pdZn4XM2+1ZyJYSF7zYI6cGbncjMpse8tG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OHk0Jj4HTMYtZs8mzQexV4jHvuXxEMnavgh2Rs1MAYQE9zF4cVoUr5Ks5wvFa8oiX
	 7WLhYxAUlyMiHMTG591rBKJ3zGdc7I924h7HTOC56HC/NibQ5r37BF5QEFEMW9ZSme
	 YTmjEHZXY509NpGiJBxW4BXEPSNxoXCQ2rAlivuC0lcXKJKuQlQeFqiZZ7SCdWTxpG
	 7WuhfZXMteiLP7O4FzPhz/e39uKByKtiSo8Lr5TRCD4SN/OJCGuQg+UeLFS+79cHm5
	 CQ4XwMeJI+J99cKNwFRgS8wKB4ZjEuSOnYCXS9ubvV0nMJ1vfTXaBUiXWkA5O1k8PS
	 J/EZMExQ4x5FQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b4aa90c20so7650535ad.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 10:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835576; x=1757440376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfAtA0V7pdZn4XM2+1ZyJYSF7zYI6cGbncjMpse8tG4=;
        b=XqNIWnb3bnoXByhge7xhTevSnkH9CzTzHeYWC7IaNavQNeD8EUz7j9kgtxgs4/ZNuk
         40oV+3dZcAExpkqiyxbZZzlKqftHmME2u7HjuuiKdREHVR1ZoE2IVXb/O780jIO5b7ms
         CH1rtbuQMOpR4icqQ1x2W86H2IGaBK36ErgudtCrrl9ZpfW31lvxZqvuR8o4S4KoSZcj
         ELqUEb6m865wBGgnNoVd+mNy/P5Eekk6XNpidxlxlRZny6oCTxY5WIH92v5nQI8rSwd0
         2/N4L8B/Lqi6PTvhrRoosLEwy0Fmgxhe9ABSmMW8zcJas4JPcy/fsb9uqd3Z9mLBUFYd
         YzgA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4iFKLlQEuYjBcLIlEhq6gTaLdBzdU0usJPboAZYCiUqlIujU50J/2h4ddUVZsXzu97cS6YKTh8nOnYFn/bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0sQ+FQgpMsKInWWunZaFn71K37AHTYDxumYqzZ2wNzmy8kA4
	EY3AIC8VrEeylFZPE18VWDdz5y/AZBCwZu8y9HaQYEbkrSWoO2pMY1fmYrqz6fdEcgVwz30Ao7Y
	wP49YlRoni99TO3xy/zpurb7nz/x+Zfm3K4jlIm5xIC28heZkz/CtLs/H+lTC7HcKAPAevgfGMv
	0qsXXTB94O7A==
X-Gm-Gg: ASbGncvY+XRuB0l3rbdzSHak+ifC7xe448DFWDP8mMMk7mYqGWrt5yQX4trFagvLT7D
	AM2R3urVhTZrQ0eQfNHQP2hmgM7sucjrVF+eutu61yV2rnEpZNpeJfLqmPFlBthxs6jPXg0mtEL
	JT4tudZHPSnMl+M1BBScfUqUCDC5Por4utvunrlUTOuCkhhIRsEcxl3nr6p0zZupz2j+SsE37dC
	i/Lwgqs8Zw9U5WdiF1//F4rvohIYe6TYF2rTOlSJw4Yb0Ha/gSWg3YMFwY90mXU9UsdvGxyPoHs
	wfYkCdte+YhGfu+6mq3I8X09ZzxbS8LU2TRcd2OYbvkg1zmSsyr/yA==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr179956955ad.18.1756835576542;
        Tue, 02 Sep 2025 10:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaGktaLb6RznTiVgBA0DK5/XFfETIc/FFrAST2RBlUIOVcDtBDWqoTklWzRRQZ4IN5On5ZvA==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr179956755ad.18.1756835576156;
        Tue, 02 Sep 2025 10:52:56 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249067de9f1sm136566315ad.151.2025.09.02.10.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:52:55 -0700 (PDT)
Message-ID: <6b35b7bf-5043-40bc-867d-2ef349cd6a75@canonical.com>
Date: Tue, 2 Sep 2025 10:52:54 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/34] ipe: move initcalls to the LSM framework
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
 <20250814225159.275901-61-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-61-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Tested-by: Fan Wu <wufan@kernel.org>
> Acked-by: Fan Wu <wufan@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/ipe/fs.c  | 4 +---
>   security/ipe/ipe.c | 1 +
>   security/ipe/ipe.h | 2 ++
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 0bb9468b8026..076c111c85c8 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
>    * Return: %0 on success. If an error occurs, the function will return
>    * the -errno.
>    */
> -static int __init ipe_init_securityfs(void)
> +int __init ipe_init_securityfs(void)
>   {
>   	int rc = 0;
>   	struct ipe_policy *ap;
> @@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
>   	securityfs_remove(root);
>   	return rc;
>   }
> -
> -fs_initcall(ipe_init_securityfs);
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 2426441181dc..71644748ed56 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
>   	.id = &ipe_lsmid,
>   	.init = ipe_init,
>   	.blobs = &ipe_blobs,
> +	.initcall_fs = ipe_init_securityfs,
>   };
> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
> index fb37513812dd..25cfdb8f0c20 100644
> --- a/security/ipe/ipe.h
> +++ b/security/ipe/ipe.h
> @@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
>   struct ipe_inode *ipe_inode(const struct inode *inode);
>   #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>   
> +int ipe_init_securityfs(void);
> +
>   #endif /* _IPE_H */


