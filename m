Return-Path: <linux-integrity+bounces-8167-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4CCF5F11
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 00:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA853057106
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jan 2026 23:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A01311979;
	Mon,  5 Jan 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GMcjywvj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F722D6624
	for <linux-integrity@vger.kernel.org>; Mon,  5 Jan 2026 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767654597; cv=none; b=aDSB/CzR0LEsWBFUol9sr6gh22oXEMWYWJpRptT2Qrn5Ihf8xYiHNkDpjOh9QExAywKglQ8aQhNmkfyQdpFLqmDO1z7Bh+KG4fQrc4vItx0zoxTslik/n0QDQzDzieFQfEji5okDm2NBdiXhCIW4Y2EEhuoElocJoaaPEcmY5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767654597; c=relaxed/simple;
	bh=avo5CR9Z1DYQeJXwYN+xxzxXqUvd/jN3tXFeP6w6pys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb6arcFU3lnX9M8o9Z/0M3TIw7R5gvvd4kZlHwA9LeP8uYnAjzb+wXaOtfhgDHUXZGhiLA0ihSvc5IWPw0BSgtQhTP1yQXCRHGKrZ03zvCsl7fBwIoBzxHe+MXmP3jZ7tJODSsplG+f7Jezu7EcS/M1t3Be4JSCymMlPWu+8V5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GMcjywvj; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3ece54945d9so201152fac.0
        for <linux-integrity@vger.kernel.org>; Mon, 05 Jan 2026 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767654594; x=1768259394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BfI8p5Sg/gvNukiFtFu/vPv9ZMQSyL6zAakTHxHqPk=;
        b=GMcjywvj0eVcWJ+mhdKworuuKpRddK3/pUdblBKr9rO+pszwMbAEbPPiNo4m3p0Fcd
         ul50D6HpXBxTWkZO7RpReNJ7I8dqFqDlwOfPflrEkev1qEsLgEyhTxAfgOZ/xru1UGyq
         4M3BKhqMAle4HWh7XCjs0q36txrL1n+dbEVlt3EwlSM1g2omsHhY7gUJ7F6t2aUmH43X
         MrI3bWM+CklFbl2jOKpqaI7mfOkwNsf9rmakotlSnAkERdE7iDznb3KWVW33fhDl0tGe
         ORhNMXGVRf4+/BWhA34Kpx0Jvhak/b18ZfJmLwHE0JJfuvD2CvfwBsJb0k4zi99Ij5Bd
         E8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767654594; x=1768259394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BfI8p5Sg/gvNukiFtFu/vPv9ZMQSyL6zAakTHxHqPk=;
        b=N2zu9SRZQ8u+pz5tNro84gO6hxxjh5boR8KhX/2CxnnNY0qLMCzmtinFBzgRIJQnCK
         8b8QiMuanI8e+kLrGQhRBfKfapDxuah6t7d+2mqoctcNVWp3+mUnKihbWNH6SimkVyKa
         7NGT5fNwCRor69kdj+bEyWPN3hqwoAa1Dkx1R+fC3h6GvDoHRgsiYKQL9esyw57+CqE7
         yaywUtTcpRPKZ10jRbqDdjheFcEBX97wwECmn7/zxdVOjeOuAiDanFZnzy7L6cMc+se9
         Wdw/NJJxMr/5ci9a91JACYRgTtRQjJDU+H9f4kVRVIahbfadMyTgSM+tTNAhO1paCjjC
         ElQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyXeH6u+/VP3nggNSw+lZFBa3VED8YQDS1APMx8G4YXy0uKN85k8g1WOR3NWVDrBMgzUlFX+i42fZPFzzUMyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6/Kcae2xDr5yc65g+At3foNsG9jHMYcJ+hfWI18U+fyJFTDo
	vOHNahmEDQLzWxkjOe+cYPIpZYKZtL3MY1W9HP1+dC7Hz6qwkk3xrNsyvPLWQHuMUQU=
X-Gm-Gg: AY/fxX7a+W/1nE4iwE1jmyF9n9WU1JybwqkHLDM4iS+gMMrrGf1Nq+3J8WxoBxCYL/R
	CsunpAvGZgREdBWE5OeDCUv5UERYoU2xyE76zolXiA9/4iWiKknS7QZQOAW8lHImmDJFRxttxnc
	jjmjCmxqZ3o6kANXRCk4DPMA07+wUh46n2lF5xa48LVd72Qvhj3SGRVDVForLKSKXdNkgwDJY12
	zGeuE4KvexfLea0woTjjGmy4OX9WAEF4iejqkdtlEfZzm61kAHFeVHJ2uuXHhNxVONeQSAlqwsK
	lxFmJBehPftVNqrU9PA3fhbPYtZNFayJfxxRu0icoc33uKcfhFgI3KXBrm3Wv0HEKYPGEARKTuq
	VYAXdOAT9uYjsh5/+5k/k23MXtnZJVr2Wi5WDfP0eoeZs7ZWDluTw2LK1Rjdnx28zwQ==
X-Google-Smtp-Source: AGHT+IHvXL/KsqfHMGfaILEYbvXCIfRFUV+zAwS7sLeUwWiNFvLcGCxGKaIGOym3oFjVne8ZfPZqqA==
X-Received: by 2002:a05:6820:1c91:b0:65b:32b4:840a with SMTP id 006d021491bc7-65f47a2fbe5mr601235eaf.51.1767654594081;
        Mon, 05 Jan 2026 15:09:54 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:88])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ab2d00sm251173eaf.0.2026.01.05.15.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 15:09:53 -0800 (PST)
Date: Mon, 5 Jan 2026 17:09:51 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
Message-ID: <aVxEv3k9YeG1or8z@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
 <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>

Hi Mimi,

On Mon, Jan 05, 2026 at 05:15:15PM -0500, Mimi Zohar wrote:
> On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> > is no longer able to correctly track inode.i_version due to the struct
> > kstat.change_cookie no longer containing an updated i_version.
> > 
> > Introduce a fallback mechanism for IMA that instead tracks a
> > integrity_ctime_guard() in absence of or outdated i_version
> > for stacked file systems.
> 
> Thanks, Frederick.
> 
> Instead of using the new function name integrity_ctime_guard() to describe the
> change, please describe the change in words.  Perhaps something like: rely on
> the inode's ctime to detect a file data or metadata change.
> 

Sure thing, I'll change for the v1.

> The purpose of generating a ctime guard value, as opposed to using the tv_sec
> and tv_nsec, I assume is to minimize the amount of memory being saved in the
> iint.

This was Jeff's suggestion. It does serve the purpose on saving
some memory, but also has some value in the event nsec or sec is zero'd.
It just needs to be different enough from the last cache'd evaluation.

> 
> > 
> > EVM is left alone since it mostly cares about the backing inode.
> > 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> > The motivation behind this was that file systems that use the
> > cookie to set the i_version for stacked file systems may still do so.
> > Then add in the ctime_guard as a fallback if there's a detected change.
> > The assumption is that the ctime will be different if the i_version is
> > different anyway for non-stacked file systems.
> 
> Agreed. This patch inverts the i_version test to return immediately if the
> i_version hasn't changed and then checks the ctime guard value.  Is the ctime
> guard value test simply a performance improvement?
> 

Kinda. The thought was to make already-audited files that have an
unchanged i_version since last audit succeed early.

Stacking tempfs on XFS for instance, would incur the stat cost each
evaluation, since the cookie that used to set the i_version on
evaluation with XFS on 6.12, is now always setting it to zero since 6.13.

> > 
> > I'm not too pleased with passing in struct file* to
> > integrity_inode_attrs_changed() since EVM doesn't currently use
> > that for now, but I couldn't come up with another idea to get the
> > stat without coming up with a new stat function to accommodate just
> > the file path, fully separate out IMA/EVM checks, or lastly add stacked
> > file system support to EVM (which doesn't make much sense to me
> > at the moment).
> > 
> > I plan on adding in self test infrastructure for the v1, but I would
> > like to get some early feedback on the approach first.
> 
> I really appreciate your adding a self test.
>

I was poking around last week at some testing platforms, and instead of
adding to kernel sefltests & setup a VM etc..., to instead add to 
Linux Test Project (LTP) if that's fine?

In any case, I can add my test snippet to v1, so you have something
to review with the patch. That snippet works the same on 6.12 as it
does on 6.19 with this patch.

> thanks,
> 
> Mimi

