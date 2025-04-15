Return-Path: <linux-integrity+bounces-5882-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4937DA89D79
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DD03BC036
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F27129A3F3;
	Tue, 15 Apr 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r1wO3wg4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D72973D7;
	Tue, 15 Apr 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719305; cv=none; b=nPJoH70C0RM5Z8yP1v0ZDDFd54qfhb8z4w2VcaYXPYOgN7NXE3bB4hT4WGWwtQ0ntDCltXmIQo9tvOKGUqFxp3F+AhoYsFKKMY4DDJCzheS9p3uno6r1FneoGlFMrUknPBv8rjnkpZbwH44qlMjp8yOtONtz68g99Bq+bHtAQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719305; c=relaxed/simple;
	bh=vdsvwCD3s4DY/WHfx6PSbZVy63COf/zosT7b77JmbfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVtGTkPzFhYCmQKVt+NY1mcJ+PgYbkKp7JnOXCdpfuI6eBlqxhPfMlE009GU2m+aDZ/5qKbWcLnQ9we531al/6PexkoSwpTxVhNl3EagnMRrQMrL7lrmA1+mNNHDc2SpM0LMRXr/dJJ07RIQjLTRtyYbLS8XSQAJYd9YnxvXFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=r1wO3wg4; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2D81F3F189;
	Tue, 15 Apr 2025 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744719294;
	bh=2WHQwBU+Gw9HB563JW+6d3V4NOu1OiBPoTs+y31s0Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=r1wO3wg4EKbfH80qZ44/SV8Q5TZGsApj5kK+ZQLPWeqWKiVrwVP3tCIunhZqLLl8d
	 abIDLPDomCmt6oTHjz1o3bsgbJnFvxP5eB3irQQaZItLvPZJ6RDY8BUGaIE7beKwKf
	 3OAtI/5hel806I+f6HGs1L/ecH2MKE86BS17ORbSYjTSoW81Uc5oV8UVZLP7+hSYGn
	 ijFzCWOD30nZDYZBJrdV1xNYTsKnm6zFwe+qQ+yXR9hArDQAABjWFLFfuun63fFeFV
	 QKjvT8aJd5fE/UuiC5123X8g/Jm5nYW8+W1gXdTGX5vvBVZufwcrMR77jdmRfLFzLS
	 G3lktbL3NJn0A==
Message-ID: <4c2ff1fe-9ded-45ad-9289-320f6f8fd098@canonical.com>
Date: Tue, 15 Apr 2025 05:14:48 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/29] lsm: split the notifier code out into
 lsm_notifier.c
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
 <20250409185019.238841-32-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250409185019.238841-32-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:49, Paul Moore wrote:
> In an effort to decompose security/security.c somewhat to make it less
> twisted and unwieldy, pull out the LSM notifier code into a new file
> as it is fairly well self-contained.
> 
> No code changes.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

lgtm

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/Makefile       |  2 +-
>   security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
>   security/security.c     | 23 -----------------------
>   3 files changed, 32 insertions(+), 24 deletions(-)
>   create mode 100644 security/lsm_notifier.c
> 
> diff --git a/security/Makefile b/security/Makefile
> index 22ff4c8bd8ce..14d87847bce8 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>   obj-$(CONFIG_MMU)			+= min_addr.o
>   
>   # Object file lists
> -obj-$(CONFIG_SECURITY)			+= security.o
> +obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
>   obj-$(CONFIG_SECURITYFS)		+= inode.o
>   obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
>   obj-$(CONFIG_SECURITY_SMACK)		+= smack/
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
> index fb57e8fddd91..477be0a17e3f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>   	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>   };
>   
> -static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> -
>   static struct kmem_cache *lsm_file_cache;
>   static struct kmem_cache *lsm_inode_cache;
>   
> @@ -643,27 +641,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	}
>   }
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
>   /**
>    * lsm_blob_alloc - allocate a composite blob
>    * @dest: the destination for the blob


