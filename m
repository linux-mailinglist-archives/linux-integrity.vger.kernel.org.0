Return-Path: <linux-integrity+bounces-5737-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A5A83460
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A2746400C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DE215198;
	Wed,  9 Apr 2025 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWSsQrb4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574326ACD;
	Wed,  9 Apr 2025 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744239967; cv=none; b=Wqbp7oHjz2eRMKuui+t1Lt3YhDrSgDLuie/5tBMAGYXQSQpV9cQ6p5Yx1vwGAkHtiKmssuz/efL940W/7PRJv61/rGT+m7beZcfdbTzbUnzyIDN0f19t1eX7KtoNxvQ5VuuoSE2kBqAbjCmyQ7DxfmtAN9VKNpfEqJMMp6X7ZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744239967; c=relaxed/simple;
	bh=w+IeKZ/Ui/ClNXJRS/hAfzN3sJmD1iEPc2E8em+kTeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx+e57/xP9hrJRLzlUTMrIeksT70cQQpGec/xp+u4DjptARL8WxnDZKyerlYH8C/+nXkhGtQWM5IjXYijfu0Re0wacv3PwUoad3/QL+SW207Jm8FA5yA7diUoTmgPjfppHINs78spoZCMiUG8KgLvHVRnztAf/6AW0Y86TsD5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWSsQrb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089ECC4CEE2;
	Wed,  9 Apr 2025 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744239967;
	bh=w+IeKZ/Ui/ClNXJRS/hAfzN3sJmD1iEPc2E8em+kTeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWSsQrb4h+jMQpuezT7YuGAoBPKrSecs/Gw1p9ILpCLeNgurpkWPp+A9NVgAWJB/P
	 29IfbnmEJ680nZnJT+6nBFNZroTj8qFrqrqkVBtGoqM84OWa/fERAnW2rxFU1h807y
	 7olCQFV8kLyndUrQpuo6P8GRXSd9YllLKAWZEVPbfsdxkpb2HjYrEqWYaZe65Juc2/
	 LYVNOHaawvdFcqGdQEy/I4opC9AKet6GL/ztIWZRPJHWDZZj/zoqgGoSM5fsVnCdrH
	 rUt9Ny/O9rhmqJGO+NTXXb5Z3bLS5t6bT/MwtNfHHHt1/kFhGoZwZ/ls9WXQTaYJrp
	 4RHywJKO3iq5w==
Date: Wed, 9 Apr 2025 16:06:04 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
Message-ID: <202504091603.107B41F4@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-38-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-38-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:52PM -0400, Paul Moore wrote:
> Move the LSM count and lsm_id list declarations out of a header that is
> visible across the kernel and into a header that is limited to the LSM
> framework.  This not only helps keep the include/linux headers smaller
> and cleaner, it helps prevent misuse of these variables.

Yay for private headers!

> During the move, lsm_active_cnt was renamed to lsm_count for the sake
> of brevity.

I would echo Casey's comment. Other places deal with a count based on
the compile-in count of "all" LSMs. This one is for the active list.
If you really want two words, perhaps "lsms_active"?


> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/security.h | 2 --
>  security/lsm.h           | 5 +++++
>  security/lsm_init.c      | 8 +-------
>  security/lsm_syscalls.c  | 8 +++++---
>  security/security.c      | 3 +++
>  5 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..8aac21787a9f 100644
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
> index 0e1731bad4a7..af343072199d 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -7,6 +7,11 @@
>  #define _LSM_H_
>  
>  #include <linux/lsm_hooks.h>
> +#include <linux/lsm_count.h>
> +
> +/* List of configured LSMs */
> +extern unsigned int lsm_count;
> +extern const struct lsm_id *lsm_idlist[];
>  
>  /* LSM blob configuration */
>  extern struct lsm_blob_sizes blob_sizes;
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index edf2f4140eaa..981ddb20f48e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
>  static __initdata const char *lsm_order_legacy;
>  
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>  static __initdata struct lsm_info *lsm_exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];

I don't care either way, but why re-order these? Just local reverse
xmas-tree?

-- 
Kees Cook

