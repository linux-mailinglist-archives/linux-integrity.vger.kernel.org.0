Return-Path: <linux-integrity+bounces-7929-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524ACB7335
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF1143025F8C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06A2741A0;
	Thu, 11 Dec 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PEswLXfr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E503B8D67
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487570; cv=none; b=LCOUiOJE9rhDK9Ok9YoceOxvIOKzbdPi5JdMxNw/gsjpiuawx1pfhvJKydxWcF4x6gVz6Xo/KKsygf2EeaIKJK//cVRFYJ5D+HzAj4LYv6iFQEhHtcRk2l4ZxfRwqSveDPVyojc8yMH7i12d9W5kNGMplfKuUpf5Y70bUU/pQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487570; c=relaxed/simple;
	bh=2StT5fey7xO/gGkRoOza1EpEfTzayi0kGne6NOjJklE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJXNDft3AUo/O31UqwsQwO0UGuFRC8cdTqnjj1zf42gS0HfY6QTSxD70DXnAx6L65K+Datd/nFBSICSCmkS1OIUphjz0R9L1UKmtbo+xvpP8LNRaDmX61EHyeQ+evg9sTSrSf9M/bq0+/MS2O7OYD6DwRBSJ3vcH/KAAjlvODCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PEswLXfr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6e815310aso391638a34.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765487568; x=1766092368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XheekkRDFybc7x85IgNduTzuOzvtB/yxFRw2uL5q9I=;
        b=PEswLXfrSpSYFs+imbUCO7CZiwM8N13f6CVVXN7NKXyA37AYWVaUPlg5ZDF/hEmTbl
         5bs/kv4TBHUovzZAhevOfmzUo3e3GWBnN1pqyN9wVtcX7WkW1+cKvw6GdpZMZecIwu84
         KsihdwxIjQu1Fl165OMI9z/HaN3ZvECHHe7J0BjdS6CPHubrZ/Id6gg+JLpgI3kNekWx
         4lC3EOYpLGz6vlxWsSlrXYe9PwUip7NLm35cUO/9oL2G0IJJKp42z13Vh2cSGfEW4eWs
         Za+er2+TDji0GuMFx5dFJv6uhplRBO8cvAgqYW3mGwq9EUh+4XdwjGjGIsNxPUF2u7wC
         5heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765487568; x=1766092368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XheekkRDFybc7x85IgNduTzuOzvtB/yxFRw2uL5q9I=;
        b=fJFRgntSJXB381ntWQmBYlr7yNUtfTpKTHXM/jav+tQ83QF3imZ8kLYjF2Cd1mVulm
         ztIok0qJZHcE9in6ZnOXld+qEBpEKnPqxQOHNzvVcfCrvKQSsKbE29YPZuF6REKjdcFE
         j9XWbIDAxwun44yodRe+I9NNesoeqNH2vnsI92+y6CHnTDW6tXGeRh6MEZqXGj6sHpDQ
         tyBT1QCXv9Lj6zZfmXhIgQG++NUTbh1sgXHQz4WWlzr84zOJ4ux/8ZbCIYg2FpFbWIsD
         hp4rP4xtAW6S++US+f7m00ahPqMNt5gIiLQRqeFzpZN78A3owXO1uW3hnm1fgDk7aQJ0
         Dy8A==
X-Forwarded-Encrypted: i=1; AJvYcCWbMexrSCPf/LbytUapqZMR+dJrwBalEAtCX4i6bu8H94f7nUfsUaIYFe2aG+ldovgCU9UZ+GGMdG7GVJx/fCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqA0JlARe3d3H3ljKfTdWYqkQ0Gmb2RcRSpcQkRSC0pyc+MND8
	V5DInj06WKz8Sszr+q5+V8SXKelzb2KSsr/79EUJpSmeWmFNbI3w1Ypkm+m2fYjLCdQ=
X-Gm-Gg: AY/fxX5pofW7mSMVHqu8Zkz/K4BOOkeuAQ8U95PNFholMMnIwVO2MqhddpM8KbngGx4
	4DI/MkWfFvq7lMjbQKu6pJigOqGm7x/8KpxCkvV9bNz9W5OUFH8CY7+3t/SGSd/nLsGGlkXqUcz
	kV7+GeoojH9K7HDMjbR9pHpoGF9G+OtRHAC25mxj9DTvH8agR1iRnfJUHApJIx6+g7gW1nv907r
	lKerUQ0CkJnRh7l+3UW5M1jUP6ebK0UZm3jqgVsyrBMwStFxYTeuMg78PfFXoqNSAvaiN1sUlmT
	9jIgft5JQe51Dv2ksgtWWLeuU2/n2Jlfry7z/lB6J12zlmvgXMzB3mkzmeobHbzSR/DI34ie5hH
	zXCeP+mAG89vlHsf6LKitgSD1nzDde3svLsisfY8JDc/VqbKKg71Nie8wrldve5V3Et0=
X-Google-Smtp-Source: AGHT+IFSOsvPqHBXCLwDMa/o2UaxQjPew98a3AmxZA3+OsFsZN55l1zZO8FFLZh/lYirNNidSm4pnQ==
X-Received: by 2002:a05:6830:4c08:b0:7c7:6da2:6d67 with SMTP id 46e09a7af769-7caceba996emr3989412a34.3.1765487567654;
        Thu, 11 Dec 2025 13:12:47 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1d0facsm2218090a34.3.2025.12.11.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 13:12:47 -0800 (PST)
Date: Thu, 11 Dec 2025 15:12:45 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	kernel-team@cloudflare.com
Subject: Re: xfs/ima: Regression caching i_version
Message-ID: <aTszzVJkIqBpYLst@CMGLRV3>
References: <aTspr4_h9IU4EyrR@CMGLRV3>
 <2b193b5ccd696420196ae9059f83dcc8b3f06473.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b193b5ccd696420196ae9059f83dcc8b3f06473.camel@kernel.org>

On Fri, Dec 12, 2025 at 05:55:45AM +0900, Jeff Layton wrote:
> On Thu, 2025-12-11 at 14:29 -0600, Frederick Lawler wrote:
> > Hi Jeff,
> > 
> > While testing 6.18, I think I found a regression with
> > commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") since 6.13
> > where IMA is no longer able to properly cache i_version when we overlay
> > tmpfs on top of XFS. Each measurement diff check in function
> > process_measurement() reports that the i_version is
> > always set to zero for iint->real_inode.version.
> > 
> > The function ima_collect_measurement() is looking to extract the version
> > from the cookie on next measurement to cache i_version.
> > 
> > I'm unclear from the commit description what the right approach here is:
> > update in IMA land by checking for time changes, or do
> > something else such as adding the cookie back.
> > 
> > 
> 
> What we probably want to do is switch to using the ctime to manufacture
> a change attribute when STATX_CHANGE_ATTRIBUTE is not set in the statx
> reply.
> 
> IIRC, IMA doesn't need to persist these values across reboot, so
> something like this (completely untested) might work, but it may be
> better to lift nfsd4_change_attribute() into a common header and use
> the same mechanism for both:

I agree lifting nfsd4_change_attribute(), if anything else, a consistent
place to fetch the i_version from. Am I correct in my understanding that
the XOR on the times will cancel out and result in just the i_version?
IMA is calling into inode_eq_iversion() to perform the comparison
between the cached value and inode.i_version.
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c35ea613c9f8..5a71845f579e 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -272,10 +272,14 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>          * to an initial measurement/appraisal/audit, but was modified to
>          * assume the file changed.
>          */
> -       result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +       result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE | STATX_CTIME,
>                                    AT_STATX_SYNC_AS_STAT);
> -       if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> -               i_version = stat.change_cookie;
> +       if (!result) {
> +               if (stat.result_mask & STATX_CHANGE_COOKIE)
> +                       i_version = stat.change_cookie;
> +               else if (stat.result_mask & STATX_CTIME)
> +                       i_version = stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> +       }
>         hash.hdr.algo = algo;
>         hash.hdr.length = hash_digest_size[algo];
>  

