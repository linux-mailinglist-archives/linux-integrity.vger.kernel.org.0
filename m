Return-Path: <linux-integrity+bounces-2730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068768D5747
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 02:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376521C230F7
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA84D51E;
	Fri, 31 May 2024 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL+I4kcJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A44C8E9;
	Fri, 31 May 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116204; cv=none; b=XbnH2XFsGz3VYksgngGQwBo2TKEie3tMsNJbYPnwGkRZCVio8vjkXYsY2tTgrAtTxIzS6k1//oJD8SejceyNVle0oQj+7kqrVH09wy+4kNyNjtAq2Zl0x0IFGamK4vlCCSKzhy3NF1b7VIMfzavB7ZUm5EMsl76ssza7R3mqMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116204; c=relaxed/simple;
	bh=Si8XOeHALztLMCNRy0WVUR6eEdJsznZcIFbxAADO+ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6mFcna2KcbI4CdYz3HgExVYO6j+3xgXfT52pPWNViVMNYFZo2WXY+RuYoxenvFD9JLcaur1Gjar1JSgyNh8bRHuUftwbn3Y9YuBDIjqJlXQA1dtVHXIl6kBO7o8Gteq1WZCU5II6QFlumAV0NLnzx8+s7SWKA97H4gNAUckDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL+I4kcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22D7C2BBFC;
	Fri, 31 May 2024 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717116203;
	bh=Si8XOeHALztLMCNRy0WVUR6eEdJsznZcIFbxAADO+ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aL+I4kcJ/OXypWoEww0Gcs/K6q+ipdHIFStSTPXEusvtmwsVT6Y5Gx+hB/Z8NFvcg
	 kk0aN5Ya2M3CtobxjGIO/J8URF8KA8GPPSqmdaRS/J0LLdEfPA0O12JA7q/hQ6fGfX
	 SwfuTm0oJ+BUOIpXNNN9GK0rAuZVJsxMYF0i/EoIwfnBnWjEOag1O0HrcFn3kbyYtd
	 t1OTPhgcjJPrqXeKo5kubhG5AO+qWl+nsDbFvnc17W78pikT8ci40gbrCQjnnwBQH1
	 AzakKGpI2SiDbCV3seJHFg22s50U9W40RxniIrslsdhtv3JRiZLu3+h/ThTs7xM5SB
	 Kvdqh9bknwLeQ==
Date: Thu, 30 May 2024 17:43:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	eparis@redhat.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
Message-ID: <20240531004321.GA1238@sol.localdomain>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
 <20240530030605.GA29189@sol.localdomain>
 <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>

On Thu, May 30, 2024 at 04:54:37PM -0400, Paul Moore wrote:
> On Wed, May 29, 2024 at 11:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > > On Fri, May 24, 2024 at 4:46 PM Fan Wu <wufan@linux.microsoft.com> wrote:
> > > >
> > > > This patch enhances fsverity's capabilities to support both integrity and
> > > > authenticity protection by introducing the exposure of built-in
> > > > signatures through a new LSM hook. This functionality allows LSMs,
> > > > e.g. IPE, to enforce policies based on the authenticity and integrity of
> > > > files, specifically focusing on built-in fsverity signatures. It enables
> > > > a policy enforcement layer within LSMs for fsverity, offering granular
> > > > control over the usage of authenticity claims. For instance, a policy
> > > > could be established to permit the execution of all files with verified
> > > > built-in fsverity signatures while restricting kernel module loading
> > > > from specified fsverity files via fsverity digests.
> 
> ...
> 
> > > Eric, can you give this patch in particular a look to make sure you
> > > are okay with everything?  I believe Fan has addressed all of your
> > > previous comments and it would be nice to have your Ack/Review tag if
> > > you are okay with the current revision.
> >
> > Sorry, I've just gotten a bit tired of finding so many basic issues in this
> > patchset even after years of revisions.
> >
> > This patch in particular is finally looking better.  There are a couple issues
> > that I still see.  (BTW, you're welcome to review it too to help find these
> > things, given that you seem to have an interest in getting this landed...):
> 
> I too have been reviewing this patchset across multiple years and have
> worked with Fan to fix locking issues, parsing issues, the initramfs
> approach, etc.  

Sure, but none of the patches actually have your Reviewed-by.

> My interest in getting this landed is simply a
> combination of fulfilling my role as LSM maintainer as well as being
> Fan's coworker.  While I realize you don't work with Fan, you are
> listed as the fs-verity maintainer and as such I've been looking to
> you to help review and authorize the fs-verity related code.  If you
> are too busy, frustrated, or <fill in the blank> to continue reviewing
> this patchset it would be helpful if you could identify an authorized
> fs-verity reviewer.  I don't see any besides you and Ted listed in the
> MAINTAINERS file, but perhaps the fs-verity entry is dated.
> 
> Regardless, I appreciate your time and feedback thus far and I'm sure
> Fan does as well.

Maintainers are expected to do reviews and acks, but not to the extent of
extensive hand-holding of a half-baked submission.

- Eric

