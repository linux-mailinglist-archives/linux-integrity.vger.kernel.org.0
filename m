Return-Path: <linux-integrity+bounces-6199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE8AB6AE1
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742323B4E14
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A321E9907;
	Wed, 14 May 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WCr5nv7x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38822202997;
	Wed, 14 May 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224174; cv=none; b=huAI4RZa8b9SiwV/qCvJgvcAqVh6JVTuE5zOgg2ZhT2WkTh6uqcbZIwhmHjUDlnWgaAbJi6yBula732rbx+dM/ed/HTlqsHX22KTVgcINkfvDpdwAi5DRFXTophgsFl9yz60ucf0HsalrC9EHexzztfwTCU9Gk58pM2XBwn9sOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224174; c=relaxed/simple;
	bh=GJbvmy8qNXkkuZgH06DyobcDeTbwNMdLFQJ8IEqKXEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUdemKy0e9BKp/fzfInrKaw9jssU4mv5nDSwgjbbH4VhMvwM9MUYczpwtANFhGZ0NGEbEtnmgPo8dVEuoMhRuy+CXr1FV7KJRH1ZVEApRXOJOhP3Ld6u4+crDe0QOspIgViY45gSH9yics3rnRryM2tTFL25Djn9yd4J8K1D/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WCr5nv7x; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9E5B33F78B;
	Wed, 14 May 2025 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747224172;
	bh=TmC3CIVizcLnnWBKfbtchRyDAwGclsEpc8usMmpxuUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=WCr5nv7x03SPY9ftFic/R5NkGC+InYQUFZtH3Lvz56k902LpfII/Fir9HqilBFfki
	 cR2N2lGPqajWEbgR6MKbr56J0Txap89k1w/dD4GP9kjuuwPd5Vy/6Jpva1TlF5s+Mb
	 k0H6iqtSLoXHt52Zx/sDOenRAZyS68u/IrodzsSixDwmghDfRHACZvwP0PvT5SRIf0
	 HLQi2aWxby4+AOf20Lf8M8Hz7Roi22L3TdK5Fy2TmbJOnLw8EFvE8Bjq55zHswSUoR
	 xQlAOOCVKbQ/bUXdB7+B5v7cMY3AqP0y5JuOaf2m+vNT0OU9awHfOPLmiFSDvwbb7z
	 kuMkciIvfaJ/Q==
Message-ID: <6d764173-cdf8-435a-a789-bbaf5ecccf0e@canonical.com>
Date: Wed, 14 May 2025 05:02:51 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-50-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-50-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:50, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   security/ipe/fs.c  | 4 +---
>   security/ipe/ipe.c | 1 +
>   security/ipe/ipe.h | 2 ++
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 5b6d19fb844a..e4437c70ed3d 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -187,7 +187,7 @@ static const struct file_operations enforce_fops = {
>    * Return: %0 on success. If an error occurs, the function will return
>    * the -errno.
>    */
> -static int __init ipe_init_securityfs(void)
> +int __init ipe_init_securityfs(void)
>   {
>   	int rc = 0;
>   	struct ipe_policy *ap;
> @@ -243,5 +243,3 @@ static int __init ipe_init_securityfs(void)
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


