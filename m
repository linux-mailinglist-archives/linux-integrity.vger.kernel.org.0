Return-Path: <linux-integrity+bounces-5738-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F889A83468
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9C219E8017
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40E21CC70;
	Wed,  9 Apr 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+vl051X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50F1B6CE4;
	Wed,  9 Apr 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240421; cv=none; b=RqpVj7NreJSpf8MpxTdYK1Lhyf4ToFOclmfJVa1DLx/gMuDxriXrbcFs4If+qJLvcAlDCQEuWmt2adUbJhG730v52ZFBdIC+fILoWq9nkVuGZZkrw51nmCPuTTJT56egQNjqKX1+0g7Ah47K4kxtv/Rg5UErOZFsMVqkuaWLPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240421; c=relaxed/simple;
	bh=7zpSl2+SuRlsMyf8A/BePZWrAporJuU1AvwD9i9NPDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmRL2H1du8phIAqIVfEKFPLZsEBADZm3P8VUeRSPiAbJxbmRxdncVOgg6vcWE+rfH5S1zCCx7QtQtJ33M7KTvXuYifhRN6egfyawogTDSiIrw4/g2KAL62CzJIjEWbuwHYm2Lm2zd6+Yj7yj+0SLvhY8HCxTl1xj8alji7rhoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+vl051X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C5C4CEE2;
	Wed,  9 Apr 2025 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744240420;
	bh=7zpSl2+SuRlsMyf8A/BePZWrAporJuU1AvwD9i9NPDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+vl051XOm7J4XpwiX6XEZ0fCUvzGIxwBxItF+edo8YfLTLAFVwX+gBsnDCusjH6+
	 G9VfxXFUAaHqETyvQ28mDsyCPhj9ZayXcqklLX9RBpzlTXuc6AbkjR/gwBUYo8APXR
	 9EBt6IQRSiEdblKbc/dGCp88Ki6ADvVS02eSRjmA+QB8ylRDWsB0spo4hvC5cSymdK
	 DkWo/UUZ9lQk1/jcM0rQ6MQ9Qh+j7rocabbtIJexE6LNZMF8kIjp7+woZBB/Ja8TFu
	 zbAFZ+Zzuh9mrRlnbG38gwRlu/hryXAz4gIcUTJmo0Immo/dyNUNOUxL1xyF343WEO
	 EPC+iSNfgdv4A==
Date: Wed, 9 Apr 2025 16:13:37 -0700
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
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some
 cleanup
Message-ID: <202504091607.0A394D5EF@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-39-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-39-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:53PM -0400, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the
> currently active LSMs in a human readable string, with the only
> user being the "/sys/kernel/security/lsm" code.  Let's drop all
> of that code and generate the string on an as-needed basis when
> userspace reads "/sys/kernel/security/lsm".
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 27 +++++++++++++++++++--
>  security/lsm_init.c       | 49 ---------------------------------------
>  3 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4cd17c9a229f..bc477fb20d02 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -169,7 +169,6 @@ struct lsm_info {
>  
>  
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..49bc3578bd23 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
>  
> +#include "lsm.h"
> +
>  static struct vfsmount *mount;
>  static int mount_count;
>  
> @@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	char *str;
> +	ssize_t rc, len = 0;
> +
> +	for (i = 0; i < lsm_count; i++)
> +		/* the '+ 1' accounts for either a comma or a NUL terminator */
> +		len += strlen(lsm_order[i]->id->name) + 1;
> +
> +	str = kmalloc(len, GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	str[0] = '\0';
> +
> +	i = 0;
> +	while (i < lsm_count) {
> +		strcat(str, lsm_order[i]->id->name);
> +		if (++i < lsm_count)
> +			strcat(str, ",");
> +	}
> +
> +	rc = simple_read_from_buffer(buf, count, ppos, str, len);
> +	kfree(str);
> +	return rc;

Hrm, at least cache it?

static char *lsm_names;
static ssize_t lsm_names_len;

static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
			loff_t *ppos)
{
	if (!lsm_names) {
		int i;
		char *str;
		ssize_t len = 0;
		...
		lsm_names = str;
	}

	return simple_read_from_buffer(buf, count, ppos, lsm_names, lsm_names_len);
}

Better yet, do this whole thing in a initcall after LSMs are loaded, and
both can gain __ro_after_init...

>  
>  static const struct file_operations lsm_ops = {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 981ddb20f48e..978bb81b58fa 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,8 +10,6 @@
>  
>  #include "lsm.h"
>  
> -char *lsm_names;
> -
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -363,42 +361,6 @@ static void __init lsm_init_ordered(void)
>  	}
>  }
>  
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last = strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last = list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result == NULL) {
> -		*result = kstrdup(new, GFP_KERNEL);
> -		if (*result == NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp == NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result = cp;
> -	}
> -	return 0;
> -}
> -
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -435,15 +397,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsmid = lsmid;
>  		lsm_static_call_init(&hooks[i]);
>  	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
>  }
>  
>  int __init early_security_init(void)
> @@ -480,8 +433,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */
> -- 
> 2.49.0
> 

-- 
Kees Cook

