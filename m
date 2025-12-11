Return-Path: <linux-integrity+bounces-7932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884ACB74CC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 23:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D9A83006F4A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B492E8B62;
	Thu, 11 Dec 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LtOXT6RE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E92E7BCB
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765492193; cv=none; b=E7MsT87PU3oSc0m8p/eRuRIbbjkOoq5bZMi4koYrnKsfLs98VaqvCdc85heXPr8B52JBjEfFddcm46vN5tMaOwIxdglsaqs2GlI7E7Hm/TzHVeHkeKd7ZdVeijU0WYuxZo9mCI1L85FAGNQN8dosGzA360nb1WE8ZSQikWac0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765492193; c=relaxed/simple;
	bh=OXXw/H1GKc6o37sW4mJQvxxa+HrNSmgnTm1bGhLbWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGBCzDn/8AIOBskgEk42u7uYnIYPxPg/TWUby5fCvRavnRIWVU6iV7rpi8p9FNkAnjAKbfvShEP/b/bAGpeGA5eJXUU+Tbj5mU0IF1BxtQ5y4qG+hBzpHh/wAatSqfE5hwl2avQzHwTrRoLFFd+2ZyfTsoWstLxWMZDXdy4XdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LtOXT6RE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c76f65feb5so509356a34.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765492190; x=1766096990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKnIdtm3pPod0xxvLT1ihslA6jGApo/slzwgiyZO2hE=;
        b=LtOXT6REZfsu1Fmr6wm28PS/iIB49use4bPHqjrPPYC2xyMRAg2UwHDAgnBVv6C+9b
         cDvwKVNHs1A2/8SR2oXuMNhZ6GC6i5U2BUq9Y7YjNAAW3sdKokRt1XOG6aXWe428/g3u
         SqVjnNRuGWjmI745qkmhF/jaBeZ2FaSWy39BEm4hHSxzcn2XCrjz3ENJjOq/0gBCW/4L
         MzgPRGiBqTw6UWFFQJY9UebihswTkRZWtZS9+VdPTdFpIvsNDzUiPuDJKP0klUjIXPSx
         eK1Csy3oXqMt58bLU7kvoEzN1jj2iN7UZ1QGK6whvaTDGISHDRwdT0PMQhkKAmZJdyRn
         C/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765492190; x=1766096990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKnIdtm3pPod0xxvLT1ihslA6jGApo/slzwgiyZO2hE=;
        b=YZrPGtRmrzM/+ubXCsUnfKRHE/3E0sM1H4DLeEgTYNwnUzU8FZCP3Vo+p6C4YvjXGH
         WqXj3w24058PJpviF/YIRAKCCCHTnH9mnm2BysGk2nR0Jvg7kvEPAMofJLdXpQxD9pUZ
         sOQP2l3TTs6fCGMgaSl1CdVPcKWDoFg5RGuMgwcOf94p0Wuc4F/596MvBD1YPJN7AJJ8
         lxwOHG4VHLVsc5jHuRaMG8PWEIJs6Dck0fwCW/VV26eRTD3HISb83ogwBoFH76x+7AvV
         MtaJRjst02efXybC0Kw42j6N6FFZjnvdqj/7o/iU/qXVz9FudnPGEc9AQOZDIRycVIbp
         Syow==
X-Forwarded-Encrypted: i=1; AJvYcCXKZw9twtvg8ywMG0Fo5dzZlZHtNp5DZHouAxsD3tAM+ICgjSat+oA2YheOc0WRERiGm5dpHKj3G1aVkbbgrWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvrAtsbCueJGO7/6GqsVy57TrJsqjhxbKlsNyIYU/je4I4uXO
	O23kthtcyWeMh7ma6VgqKh1u7oYJH4yEimc+rGrxStCcQlrfQVjplq8/TIVYVZdMxYw=
X-Gm-Gg: AY/fxX4MgzFsWQ+viz02WZUHb7aUGKU2w+1Ul1ykz6nsilXk2/0lWD5L5CwNIcCcxQ6
	mopJU7ool4K0U8hLnHoGZrPu0yN5wqb0qyINMi+yMbRJgRQWgZqB1oJnL4IIEfBi5KaARPxF0Ar
	0yf3+on+pwjfA09ANBRM1nMYKMqYnb1fc4d4pVbwjdR6LIYjpEvhzLbdlaVJJC5pPwPrOQDo+1D
	0m2SKkmP1K+eWOzWPFv8XCqoKii6RielQ9HuW8ETZauPXa+eQVHb/ah1L6aVF1J0xe+e91X36yy
	lgFSBkn8v4Ao2b1nj8NuWDwc1yh6R8pVpUmA9fLTUx3noBt5N+PS8ZA+JKPt16MMU2rdwvK9wbV
	cweIgrIdQjC5bHT/7DAusD08xp4miK4bUER4nzumLhHsPKs0+qGkqBm/m27xwSpSNy4A=
X-Google-Smtp-Source: AGHT+IGywbe0BB3deFRAIXxlLuosG5PBVaz326jAfocDpJ8kRogIfj//FG80YFsTf+7RwCSyXE0kyA==
X-Received: by 2002:a05:6830:2648:b0:7c7:2e9d:aee1 with SMTP id 46e09a7af769-7cae8362956mr7043a34.19.1765492190551;
        Thu, 11 Dec 2025 14:29:50 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb010476sm2303448a34.0.2025.12.11.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 14:29:50 -0800 (PST)
Date: Thu, 11 Dec 2025 16:29:48 -0600
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
Message-ID: <aTtF3BPUcd9crhAm@CMGLRV3>
References: <aTspr4_h9IU4EyrR@CMGLRV3>
 <2b193b5ccd696420196ae9059f83dcc8b3f06473.camel@kernel.org>
 <aTszzVJkIqBpYLst@CMGLRV3>
 <fab68913274be1cb2a629372eafd52205a51b74e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab68913274be1cb2a629372eafd52205a51b74e.camel@kernel.org>

On Fri, Dec 12, 2025 at 06:41:00AM +0900, Jeff Layton wrote:
> On Thu, 2025-12-11 at 15:12 -0600, Frederick Lawler wrote:
> > On Fri, Dec 12, 2025 at 05:55:45AM +0900, Jeff Layton wrote:
> > > On Thu, 2025-12-11 at 14:29 -0600, Frederick Lawler wrote:
> > > > Hi Jeff,
> > > > 
> > > > While testing 6.18, I think I found a regression with
> > > > commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") since 6.13
> > > > where IMA is no longer able to properly cache i_version when we overlay
> > > > tmpfs on top of XFS. Each measurement diff check in function
> > > > process_measurement() reports that the i_version is
> > > > always set to zero for iint->real_inode.version.
> > > > 
> > > > The function ima_collect_measurement() is looking to extract the version
> > > > from the cookie on next measurement to cache i_version.
> > > > 
> > > > I'm unclear from the commit description what the right approach here is:
> > > > update in IMA land by checking for time changes, or do
> > > > something else such as adding the cookie back.
> > > > 
> > > > 
> > > 
> > > What we probably want to do is switch to using the ctime to manufacture
> > > a change attribute when STATX_CHANGE_ATTRIBUTE is not set in the statx
> > > reply.
> > > 
> > > IIRC, IMA doesn't need to persist these values across reboot, so
> > > something like this (completely untested) might work, but it may be
> > > better to lift nfsd4_change_attribute() into a common header and use
> > > the same mechanism for both:
> > 
> > I agree lifting nfsd4_change_attribute(), if anything else, a consistent
> > place to fetch the i_version from. Am I correct in my understanding that
> > the XOR on the times will cancel out and result in just the i_version?
> 
> No. I was just using the XOR to mix the tv_sec and tv_nsec fields
> together in a way that (hopefully) wouldn't generate collisions. It's
> quite not as robust as what nfsd4_change_attribute() does, but might be
> sane enough for IMA.
> 
> > IMA is calling into inode_eq_iversion() to perform the comparison
> > between the cached value and inode.i_version.
> 
> That just looks at the i_version field directly without going through -
> >getattr, so that would need to be switched over as well. Could
> integrity_inode_attrs_changed() use vfs_getattr_nosec() and compare the
> result?

That makes sense to me. I'll look through it a bit more, roll a patch, and
see what the IMA folks have to say (unless they comment here first).

Thanks Jeff

> 
> 
> > > 
> > > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > > index c35ea613c9f8..5a71845f579e 100644
> > > --- a/security/integrity/ima/ima_api.c
> > > +++ b/security/integrity/ima/ima_api.c
> > > @@ -272,10 +272,14 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> > >          * to an initial measurement/appraisal/audit, but was modified to
> > >          * assume the file changed.
> > >          */
> > > -       result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> > > +       result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE | STATX_CTIME,
> > >                                    AT_STATX_SYNC_AS_STAT);
> > > -       if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > > -               i_version = stat.change_cookie;
> > > +       if (!result) {
> > > +               if (stat.result_mask & STATX_CHANGE_COOKIE)
> > > +                       i_version = stat.change_cookie;
> > > +               else if (stat.result_mask & STATX_CTIME)
> > > +                       i_version = stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> > > +       }
> > >         hash.hdr.algo = algo;
> > >         hash.hdr.length = hash_digest_size[algo];
> > >  
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

