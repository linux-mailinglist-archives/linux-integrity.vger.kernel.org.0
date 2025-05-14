Return-Path: <linux-integrity+bounces-6206-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80832AB6CC6
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE21B6687D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDC2777FB;
	Wed, 14 May 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k6VcaaQV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5732701C5;
	Wed, 14 May 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229592; cv=none; b=laHoxjklXs7ka/+zWyqUWPI043SpzEg4sUzhIWOiZ+IffvMqwb3Z70mxqcc1JR2p6wlfDH5xpuOiM9gq6KfNxGUdGLD6d/hgFY555WDp+aY5ChEGDMqSH6YK987kSv7IVm5uMJtlqTV1z/Qv33/NQaxanmWUk+usDhwIpgtptkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229592; c=relaxed/simple;
	bh=H3SY2dVf3ZGa86cb1lywwAegQG8vzceDrlfWd6EfDBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQqLQgnpnr/l4an4gmZ+2M2FjRPZlAlT/WLr9uEW6Bci7ejD/N5jSOBUEGvfBdqvLZulB3gLvdFWgiJJlnn3FeR+6g674RqvBikUYND7DyNOHSzF+jW4Qo4uQS46k/BErgWtuzME8zqdusRPXqYPZesUD53az27iBfbUHJpa7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k6VcaaQV; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0309F3FA5D;
	Wed, 14 May 2025 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747229589;
	bh=lqosz1RPV11z2eat7OHY7I8DhIvH1KfdRar++dw6wvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=k6VcaaQVubXyWvlRuKg/mBxaAI0M8WOYPSJBf+5wKQ3MhAEk9ND5JvuqL2ykTqViJ
	 wOXSi6Mm8ZwH0nC1SsxjLnTx30fQ3BugHlNWyae/OJFVMEqw/fatupH2Dz7Q00/949
	 hj5kBqCGLQzapzVYD5Nb07jy6i3gH42nao+AO2zJkmGLC2iWryQz0VHNAdoWkFAtDA
	 lbTm+tIs7R415RTY8FzORrD4x177KAqqddR/Td87Ds3gc9PbKNYjvnJgAUU6A9o8er
	 lkJFSCjvmUQ6M/FpkEkLkC5TBjgnYLedVit4Gm7Pxvn9UeILXzWwqTfVQjMtxqlCFv
	 IfnMLKe+eJsqQ==
Message-ID: <bf8ecdb1-1f73-457e-aaea-6daf84961158@canonical.com>
Date: Wed, 14 May 2025 06:33:07 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/29] apparmor: move initcalls to the LSM framework
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
 <20250409185019.238841-54-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-54-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:50, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/apparmorfs.c         | 4 +---
>   security/apparmor/crypto.c             | 4 +---
>   security/apparmor/include/apparmorfs.h | 2 ++
>   security/apparmor/include/crypto.h     | 1 +
>   security/apparmor/lsm.c                | 9 ++++++++-
>   5 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 6039afae4bfc..0a7550a5bceb 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2632,7 +2632,7 @@ static const struct inode_operations policy_link_iops = {
>    *
>    * Returns: error on failure
>    */
> -static int __init aa_create_aafs(void)
> +int __init aa_create_aafs(void)
>   {
>   	struct dentry *dent;
>   	int error;
> @@ -2711,5 +2711,3 @@ static int __init aa_create_aafs(void)
>   	AA_ERROR("Error creating AppArmor securityfs\n");
>   	return error;
>   }
> -
> -fs_initcall(aa_create_aafs);
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index aad486b2fca6..e4395c1bfac5 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -99,7 +99,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>   	return error;
>   }
>   
> -static int __init init_profile_hash(void)
> +int __init init_profile_hash(void)
>   {
>   	struct crypto_shash *tfm;
>   
> @@ -119,5 +119,3 @@ static int __init init_profile_hash(void)
>   
>   	return 0;
>   }
> -
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
> index a7f6a3274682..2fefaab6349f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -31,6 +31,7 @@
>   #include "include/audit.h"
>   #include "include/capability.h"
>   #include "include/cred.h"
> +#include "include/crypto.h"
>   #include "include/file.h"
>   #include "include/ipc.h"
>   #include "include/net.h"
> @@ -2146,7 +2147,6 @@ static int __init apparmor_nf_ip_init(void)
>   
>   	return 0;
>   }
> -__initcall(apparmor_nf_ip_init);
>   #endif
>   
>   static char nulldfa_src[] = {
> @@ -2277,4 +2277,11 @@ DEFINE_LSM(apparmor) = {
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
>   };


