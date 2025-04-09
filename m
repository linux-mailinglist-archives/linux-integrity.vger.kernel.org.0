Return-Path: <linux-integrity+bounces-5749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DCA834DA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F52A441346
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA921C175;
	Wed,  9 Apr 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfLVa2iS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229A1A5BA4;
	Wed,  9 Apr 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242810; cv=none; b=JJVpUirgaVAsSGS9GYEz77NYTumENo+AE8czLee5GYVTPDKyFBQw1S2FTRSkquMXjXmqodCJ1PTpFsBmN0uh6dRSQzzg7JYsnI8yEFTQosHmEXdD1GtziBi4n+NuHWwWbQfbnguvvTWas7oPIKwFRKmLnEV1ORH1rszZnfWr+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242810; c=relaxed/simple;
	bh=gQiSJTWNpNvGvjN0lEjNm2j7h8tUQdhBj/HZ/EeSPNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buJz0R6/XTnHYsyp5ygBun8okO3Jx2dTngV5x+ouvKA4dVgicqjGATX5hSEww+38xUt+tsUAGVfxkGHG9Lx2A2rirSciasv5sraJqfVqMxuCDPhom4TEqkQWXFyNRYWRjNZMKhCW64cuyiJWUvZOZ2MURhDWoagntILxOlyMCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfLVa2iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E79C4CEE2;
	Wed,  9 Apr 2025 23:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242810;
	bh=gQiSJTWNpNvGvjN0lEjNm2j7h8tUQdhBj/HZ/EeSPNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfLVa2iSV8jOguJ6nB6ykV9+AvK6GSKPQAQM5mlCSVeEYPYolhRtuJJVyqfOkWzsq
	 XUVQ2suFvtlJWEne08r1UsHApRxyemCgiOSwXnlHqZIkc72CQ6ErYH8Ya28+9XsRhg
	 pRtI9M8WBjmLmgxkrEK5mp6aTnButQ5g9Db+xo17lHQRaw1VG8dfppziXwykGhsli9
	 9RC7yGDNZ87EbTsTEjGv1bM1gYQCapEuMTnFHFGGnZNWjrmExQjf0hBeZTJAe6N1eR
	 ZL7KIyO8Bv96wt5OsmeHo9LD6YCX9jqheu2VYIDYv3mgmd4fv2jbZiq0cQZBxj/plV
	 /GboGNs3Lo3wg==
Date: Wed, 9 Apr 2025 16:53:26 -0700
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
Subject: Re: [RFC PATCH 28/29] lsm: add a LSM_STARTED_ALL notification event
Message-ID: <202504091653.7A2CD9B@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-59-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-59-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:13PM -0400, Paul Moore wrote:
> Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
> boot when all of the LSMs have been started.

This is where the lsm_names string could be built too...

Reviewed-by: Kees Cook <kees@kernel.org>


> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/security.h | 1 +
>  security/lsm_init.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8aac21787a9f..a0ff4fc69375 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -85,6 +85,7 @@ struct timezone;
>  
>  enum lsm_event {
>  	LSM_POLICY_CHANGE,
> +	LSM_STARTED_ALL,
>  };
>  
>  struct dm_verity_digest {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index c0881407ca3f..cad6d243a2a6 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -553,6 +553,7 @@ static int __init security_initcall_late(void)
>  
>  	rc = lsm_initcall(late);
>  	lsm_pr_dbg("all enabled LSMs fully activated\n");
> +	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
>  
>  	return rc;
>  }
> -- 
> 2.49.0
> 

-- 
Kees Cook

