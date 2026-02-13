Return-Path: <linux-integrity+bounces-8505-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cByFAq6Aj2kfRQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8505-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 20:51:10 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DB139474
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 20:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBD7301F4B4
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B812773EE;
	Fri, 13 Feb 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MBnLq9Se"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D37271A94
	for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012267; cv=none; b=VSPe/30YDPWHW2mqj7723HHzXhKRleWWOUhalrysw1c2RDaXk7ZRFlr0ZlCaeqk/iGtZFsC+Vpe2yWj2fHx3PsV7blWPx/9pwb8kq2uBr4SGhD6jizJux3Kb8ssXSoKS0j15RS2x8YY91dOHEanQ+lTXsjdqOFbLKG5cw2MEkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012267; c=relaxed/simple;
	bh=TEs4DPVba0gplXJbyNN5ClbqSickAgUQf3hni7CLCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl/Pf4k8NR3uA8xz4yGeAOR7c0vt9undpAdeZXQQ9G9ic0lOiv2X/amIJbaiysR/Qs8ji1+vOo1D4w2C6c0Yz2jcmUt1JzRoftFPlaa8CHSgxW9OqDboLV2epR6MtKphXYttV4oHV75KNxConJAFTi6+3RcUXrLbYOQ8Dp54sBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MBnLq9Se; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d195166b2cso907237a34.3
        for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771012265; x=1771617065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGR8qn9iC/h+RvTMU1MmxMn1+m6GJ2Z7ppqye/pPeJM=;
        b=MBnLq9SerywPCBHl4Kwif1I+tKjEFqwjmwWegm6Zs6DZklpHjsOjbgHN2hZPcMmv0/
         rTvToGmbSKjoHh9bNjcejVWjgyqqtH5kDIZ9IjIddwblajx9EEvSjexZM/wIl49McgER
         boTQJhFzjMOraPkMtpPa8d/md6OfWjjWHnivus545OIwCxolAfVX/UfSz9ynlw0SYn0I
         20fb0fTJ9ZOMOo5jgScE7YdY3waXB98eIqCCBkEVlsOj2H9as7hDDFXLTItSLzatrdM6
         q8OS+YoNA2NGp/8nAc1GWscQnuwJt3jMPkyduOlfa2HD7kZ/5eKm+UACoYd3WT3n4M1O
         tgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012265; x=1771617065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGR8qn9iC/h+RvTMU1MmxMn1+m6GJ2Z7ppqye/pPeJM=;
        b=CVn7rx6h/4o7ThrV0Q/ZLHEdba8rH+8/lhtClHAWSrD9fEo4U87KiV7M7ZmV9WPs1t
         C9IabRMiCLCqSFO483ijj91FUxRaYsCHjwfTqwj1vzT/skqcpABjBGWdStJesjci2I0f
         F+XPTjA8PIja79vLU+Odh2I5sZQGWjGtyWMDvuGbPNP0EhAHg+Oyj7SUAHf3uUxRTSo6
         0Gg0Fad+n2j3WqGBPTfh/0Qu0Y08RuDWKQxUem6KbEoLJn5oxzYD6pkw+1390Gr31g64
         QM2hRs9me4ngtd3wkGbnDPF+MQeaXRdDg9oxrVhjPlgPVpw74EfGxrJVC5TVO9PiIUyU
         uJng==
X-Gm-Message-State: AOJu0Ywu2KPWrXsvgJfYsSQqjjnGIjBeyfWeaKQiFSXMLgVi9kCGaYqc
	fmgrjK2mH+wlArEWWnHH7m9VyGs2tjoTU1N51+UgkO1Xx9GaGRNKld9vTyf8dX7iucE=
X-Gm-Gg: AZuq6aIqlKRArezYkSai1zxPysYvmxEuI82RZWxGDAUQ82aGcWH19rrLQ9O0WjTlHMV
	1Nmwpaa1tEXeHve4Go+gdLYE7gy7B644ibBLm5/OR2lcKuMrxH7QUlraTTkjs4lT+9p1CMcmB8B
	sOy5bnbewIT/MBBUGTRIPJlnQPIYeVXWcX1AhWedehfX53H5jog5uwaYqSchAJKaCGxcvWk6pSM
	KjnoD2nkRlbHGie5tqpdJG1pDjkjz3WBGKntG1mCXsn4Tsz4SBPDc3qbwSKBdnT4KXbIXO7sIHg
	REscf6vSherLm8LAAPZlmqxyac2+ZjwhKuVh0tLxcQ3QdGPw7J6H9kPIeUjATp8C/SGHzK5/w6A
	YOXcJEQOU9Yk5pJ25V/EdfUWlGY4dE3YwPoc9qhlg+W6cTIISfeKr1cBPOIeP9yXU+mtHct5Xyi
	HbZ5jXXB6puWoqYDY=
X-Received: by 2002:a05:6820:8186:b0:676:e126:e7b4 with SMTP id 006d021491bc7-67723709956mr1774815eaf.78.1771012264824;
        Fri, 13 Feb 2026 11:51:04 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6747540780asm4668601eaf.9.2026.02.13.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:51:04 -0800 (PST)
Date: Fri, 13 Feb 2026 13:51:02 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] ima: fallback to using i_version to detect file change
Message-ID: <aY-ApsCkJQ05-FIk@CMGLRV3>
References: <20260213174947.976924-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213174947.976924-1-zohar@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8505-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 640DB139474
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:49:47PM -0500, Mimi Zohar wrote:
> Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> replaced detecting file change based on i_version with
> STATX_CHANGE_COOKIE.
> 
> On filesystems without STATX_CHANGE_COOKIE enabled, revert back to
> detecting file change based on i_version.
> 
> On filesystems which do not support either, assume the file changed.
> 

Tested-by: Frederick Lawler <fred@cloudflare.com>

> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v2:
> - Use the real_inode's iversion to detect file change on overlayfs
> - Add Roberto's Reported-by tag
> 
>  security/integrity/ima/ima_api.c  | 13 +++++++----
>  security/integrity/ima/ima_main.c | 39 ++++++++++++++++++++++++-------
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c35ea613c9f8..28cf1fe07f8f 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -267,15 +267,20 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>  		goto out;
>  
>  	/*
> -	 * Detecting file change is based on i_version. On filesystems
> -	 * which do not support i_version, support was originally limited
> -	 * to an initial measurement/appraisal/audit, but was modified to
> -	 * assume the file changed.
> +	 * Detect file change based on STATX_CHANGE_COOKIE, when supported,
> +	 * and fallback to detecting file change based on i_version.
> +	 *
> +	 * On filesystems which did not support i_version, support was
> +	 * originally limited to an initial measurement/appraisal/audit,
> +	 * but was later modified to assume the file changed.
>  	 */
>  	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
>  				   AT_STATX_SYNC_AS_STAT);
>  	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>  		i_version = stat.change_cookie;
> +	else if (IS_I_VERSION(real_inode))
> +		i_version = inode_peek_iversion(real_inode);
> +
>  	hash.hdr.algo = algo;
>  	hash.hdr.length = hash_digest_size[algo];
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1d6229b156fb..4fc383479847 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -180,6 +180,34 @@ static void ima_rdwr_violation_check(struct file *file,
>  				  "invalid_pcr", "open_writers");
>  }
>  
> +/*
> + * Detect file change based on STATX_CHANGE_COOKIE, when supported, and
> + * fallback to detecting file change based on i_version. On filesystems
> + * which do not support either, assume the file changed.
> + */
> +static bool ima_detect_file_change(struct ima_iint_cache *iint,
> +				   struct inode *inode, struct file *file)
> +{
> +	struct kstat stat;
> +	int result;
> +
> +	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +				   AT_STATX_SYNC_AS_STAT);
> +
> +	if (!result && stat.result_mask & STATX_CHANGE_COOKIE &&
> +	    stat.change_cookie != iint->real_inode.version)
> +		return true;
> +	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
> +		 IS_I_VERSION(inode) &&
> +		 !(inode_eq_iversion(inode, iint->real_inode.version)))
> +		return true;
> +	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
> +		 !(IS_I_VERSION(inode)))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void ima_check_last_writer(struct ima_iint_cache *iint,
>  				  struct inode *inode, struct file *file)
>  {
> @@ -191,18 +219,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
>  
>  	mutex_lock(&iint->mutex);
>  	if (atomic_read(&inode->i_writecount) == 1) {
> -		struct kstat stat;
> -
>  		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
>  
>  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
>  					    &iint->atomic_flags);
> -		if ((iint->flags & IMA_NEW_FILE) ||
> -		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie != iint->real_inode.version) {
> +
> +		if (iint->flags & IMA_NEW_FILE ||
> +		    ima_detect_file_change(iint, inode, file)) {
>  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs = 0;
>  			if (update)
> -- 
> 2.53.0
> 

