Return-Path: <linux-integrity+bounces-8940-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB7XIPExq2n2agEAu9opvQ
	(envelope-from <linux-integrity+bounces-8940-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 20:58:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E144E2274E1
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 20:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E399304D970
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2026 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084042F57B;
	Fri,  6 Mar 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CQKLwwPF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C43101B2
	for <linux-integrity@vger.kernel.org>; Fri,  6 Mar 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827119; cv=none; b=fiszJep6+amF9kL4YDJGpSIqwK933Lybs4SY410OyRa2KBjK9iV3i/zKoq2dwUWOP1BbpNYIYWD7shOd/RNtFQ3Qf5gli6mFoskknlYpON8L/r7GF249j39jK8MDnJjTLOErLT+SHveCFSf58rI1gLvq3WPeiJUN8HAkvm7nMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827119; c=relaxed/simple;
	bh=IJMHZAxzrRKFMZ1jGq7SviToRj3lMB4JbCUcuxRElX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzwlEHPpx9ysPqsJhM4gkCoN89rEXlR6a4mSsyLJS2heRCYT3kop/dXwcFSK4JPbkHEaK+3xjZQJo2XGtwYyXY2YXY9mVBS/4pSrPHPO5V08HJznfVqckAoteQ9Z6qicxFYqI0N/ku0OL1nrjOLnZSc7cENnePy0huZ7FyurAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CQKLwwPF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ed9a23aaeso1901968fac.1
        for <linux-integrity@vger.kernel.org>; Fri, 06 Mar 2026 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772827116; x=1773431916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpErCLZB51BsavWJOhvG2xoEtejRiiqAE5JsJpA7/Js=;
        b=CQKLwwPFUa2CfeNo/0bvSQHus7ilxLAw950iA8TIQwbvzI7LqrF3mIt5G/3kztJ1X4
         Sj1y9aI3bNgYz/JIF7v4ihui6FrMOyLynLIm9ofXvdYr7DLDXW/b16nimEG67he5dzLb
         FMagHnz49WzwBVs8lj3XhVBdejdPYJEB11IODxYt9EhRx9yf12PvBgDKHNb1luFMJQ+z
         JfPAM+T3NIe82XiALVt3NEjfeRBFGrsUZ23rm869obWK7sHJvv1qpe3UBwVe3I1p9jzH
         1gvShYkE/sHAjwI0nXOyZ2dBzy2eQ7wMHbi1b9WBhc+psDf1qo1mKCC5fNBqIYcc1HQ0
         K77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827117; x=1773431917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpErCLZB51BsavWJOhvG2xoEtejRiiqAE5JsJpA7/Js=;
        b=pmHaxKZzTA8QpiXRDnsSNUoDrWOSiLSmy4a6M36+r3wvSjDxTqpctPkiEowl9veZAt
         vQQ7ZB+CKHe/J2ANg8Z5ArFC16loL659/LQElGyFHaTd/17OXpwS7cuN8qGGWGQGTRU6
         1uIcLCHBdX/RE8JMmCjYPOv8XTCYxS2SuB1QmC5pZnbx+ijRM/MKATIPDAePHZy5Hsoo
         427l+6+KDXrPv0WWsHGboKIl8CTIzae5xPeaWPVDqjSU+m0G3W35y8rhTuwqzEIdVlsx
         xeI0LT+U1YZ2G59+zqHHP6PAWr0XyWkrvlKhuoHeWpqLehPu9HV7RgsRFoFKI8K8bqDC
         Q30w==
X-Gm-Message-State: AOJu0Yzy3u2F26SvByWjdloH6kb0XUGQCYaXn9oUg23BosbIB4UCv03t
	c0o3AEvhoPWiyVNdJ5jyo+dmT6skRAoGMrcvyLHNen+qP93rp9o7TkOqZG7fVVWFjbc=
X-Gm-Gg: ATEYQzwB9bNBln9baMwmvJYnawaHRHI1sSNP4ads/HxXubQjDWEhPcn2e9QbtkC1ArL
	AE3+XDCcQzSxY6rpQhl+SqntNiOM6uNze4EZTGssDVSfpf2UHLSLVwdcbE+U0Sco6O9El/LJGeV
	Q5pEVdhT+YLCWzruK0hox2ds7P3pSC2LDHNOcQcDL7bE/V4RpM6/whTs/Iv7L64uBVmNtC76G55
	D8LeUZi5L00Of0XBhkXrUxbBRxrntJCc5fDvOxIsuhXIXHQplRTIr1A5QrH/RyGFpgjBlPD4t5X
	prNFupEftv2knqnVu1+GxmBqRMmmga7CPoQbmtpoiA1OVYhUAFjJ54upOfT0Kd/P6ocwpqNIQ/7
	sdFqNJkN7qhmWf6yqEd/Zi64/FCEubyb2k0aDahIhMed+GuQXr2xYrcKhWLd9KAc7IYzmQX1aL2
	BvXw==
X-Received: by 2002:a05:6870:4045:b0:404:383f:56bb with SMTP id 586e51a60fabf-416e4488766mr1719399fac.35.1772827116561;
        Fri, 06 Mar 2026 11:58:36 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:81])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e6560df9sm2117682fac.2.2026.03.06.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:58:36 -0800 (PST)
Date: Fri, 6 Mar 2026 13:58:34 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH] ima: detect file change code cleanup
Message-ID: <aasx6nBL-FJ_nlzH@CMGLRV3>
References: <20260306190141.309937-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190141.309937-1-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: E144E2274E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8940-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email]
X-Rspamd-Action: no action

Hi Mimi,

On Fri, Mar 06, 2026 at 02:01:40PM -0500, Mimi Zohar wrote:
> Functionally no change, just simplify the ima_detect_file_change() code.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> @Fred, looking to merge with commit 0824f861605d ("ima: fallback to using
> i_version to detect file change")
> 
>  security/integrity/ima/ima_main.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 6c49afa8dcc0..5cea53fc36df 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -194,18 +194,13 @@ static bool ima_detect_file_change(struct ima_iint_cache *iint,
>  	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
>  				   AT_STATX_SYNC_AS_STAT);
> 
> -	if (!result && stat.result_mask & STATX_CHANGE_COOKIE &&
> -	    stat.change_cookie != iint->real_inode.version)
> -		return true;
> -	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
> -		 IS_I_VERSION(inode) &&
> -		 !(inode_eq_iversion(inode, iint->real_inode.version)))
> -		return true;
> -	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
> -		 !(IS_I_VERSION(inode)))
> -		return true;
> -
> -	return false;
> +	if (!result && stat.result_mask & STATX_CHANGE_COOKIE)
> +		return stat.change_cookie != iint->real_inode.version;
> +
> +	if (IS_I_VERSION(inode))
> +		return !inode_eq_iversion(inode, iint->real_inode.version);
> +
> +	return true;
>  }
> 
>  static void ima_check_last_writer(struct ima_iint_cache *iint,
> --
> 2.53.0
>

Refactor looks good to me.

Reviewed-by: Frederick Lawler <fred@cloudflare.com>

Best,
Fred

