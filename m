Return-Path: <linux-integrity+bounces-2762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE28D686D
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71C128B29D
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2017CA1E;
	Fri, 31 May 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4BwxNqu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E117CA0B;
	Fri, 31 May 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177633; cv=none; b=G/LiKh0Q7CLbGzdVtxBjpFRcD/lCIwiWCvQ+r7UDCt4rzgLGqhKV07kWGF2d/wZlrpc6xn1RbtfzQ6MaRlZjB5J1/omyE3pItCUadSx81I9V+p9pp/Djv17PyV5Yq6+qEvYpf7ryju7nuy2nnDkUKb96xFA20biGHn+A31Y6SFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177633; c=relaxed/simple;
	bh=21LSgTExidJOfb9UA4FlB1VpQJ4ptiqM3M6lPGstxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvPZi3xYPfoWg3lYON7LZK8LCF755Vwirer+Fn8da5Fog03MkaMzJYesmRIYQr0p8ceRHAKBPaTNGepPHigZi1r+WDuGnKHf3b+2bKHvPsdpayoCnMGa5FrKtYmpcfUd9aVGLqIYsQXRKcOfg765Imo1NWQcj7REYz7Iipif80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4BwxNqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C999C116B1;
	Fri, 31 May 2024 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717177632;
	bh=21LSgTExidJOfb9UA4FlB1VpQJ4ptiqM3M6lPGstxwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4BwxNquzh28rbTZt9KxjLyZLSvSTUEVYSPItGYpHKgF/llgtUdz7spzjZ1qDWfGa
	 gKO93Wzjs8Vx+T8V7cNOyauHIs3UPX+aRXdcfko+GnDigHqMnATPDylVjCYUbIalCu
	 mLK9weStMKWstAV1+MOMVnDgh0XnsGGB0giWmHjEA+/CpLAcZ/MnvoduJIbPJUQR47
	 OMjgYtOyL1c0PuJ+BD+6oBCQtj7WuFB/ZZM9kuhxilKjJWYp8n0ptSfDTR2GWqS4Hy
	 v3VLBCY65eRALsv2ivwmueMxnocgcpQHy8qIu0uRVOh2SVw9hwMi7BOqKdB89RIP2S
	 HBkfZ4plenMPw==
Date: Fri, 31 May 2024 10:47:10 -0700
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
Message-ID: <20240531174710.GA1199@sol.localdomain>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
 <20240530030605.GA29189@sol.localdomain>
 <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>
 <20240531004321.GA1238@sol.localdomain>
 <CAHC9VhRRuBdnv3u2VjKZCR672p4oj_smA72P-181ysdDXGJ-AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRRuBdnv3u2VjKZCR672p4oj_smA72P-181ysdDXGJ-AA@mail.gmail.com>

On Fri, May 31, 2024 at 11:51:47AM -0400, Paul Moore wrote:
> On Thu, May 30, 2024 at 8:43 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, May 30, 2024 at 04:54:37PM -0400, Paul Moore wrote:
> > > On Wed, May 29, 2024 at 11:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > > > > On Fri, May 24, 2024 at 4:46 PM Fan Wu <wufan@linux.microsoft.com> wrote:
> > > > > >
> > > > > > This patch enhances fsverity's capabilities to support both integrity and
> > > > > > authenticity protection by introducing the exposure of built-in
> > > > > > signatures through a new LSM hook. This functionality allows LSMs,
> > > > > > e.g. IPE, to enforce policies based on the authenticity and integrity of
> > > > > > files, specifically focusing on built-in fsverity signatures. It enables
> > > > > > a policy enforcement layer within LSMs for fsverity, offering granular
> > > > > > control over the usage of authenticity claims. For instance, a policy
> > > > > > could be established to permit the execution of all files with verified
> > > > > > built-in fsverity signatures while restricting kernel module loading
> > > > > > from specified fsverity files via fsverity digests.
> > >
> > > ...
> > >
> > > > > Eric, can you give this patch in particular a look to make sure you
> > > > > are okay with everything?  I believe Fan has addressed all of your
> > > > > previous comments and it would be nice to have your Ack/Review tag if
> > > > > you are okay with the current revision.
> > > >
> > > > Sorry, I've just gotten a bit tired of finding so many basic issues in this
> > > > patchset even after years of revisions.
> > > >
> > > > This patch in particular is finally looking better.  There are a couple issues
> > > > that I still see.  (BTW, you're welcome to review it too to help find these
> > > > things, given that you seem to have an interest in getting this landed...):
> > >
> > > I too have been reviewing this patchset across multiple years and have
> > > worked with Fan to fix locking issues, parsing issues, the initramfs
> > > approach, etc.
> >
> > Sure, but none of the patches actually have your Reviewed-by.
> 
> As a general rule I don't post Acked-by/Reviewed-by tags for patches
> that are targeting a subsystem that I maintain.  The logic being that
> I'm going to be adding my Signed-off-by tag to the patches and arguing
> these in front of Linus, so adding a Acked-by/Reviewed-by simply
> creates more work later on where I have to strip them off and replace
> them with my sign-off.
> 
> If the lack of a Reviewed-by tag is *really* what is preventing you
> from reviewing the fs-verity patch, I can post that starting with the
> next revision, but I'm guessing the lack of my tag isn't your core
> issue (or at least I would argue it shouldn't be).
>
> > > My interest in getting this landed is simply a
> > > combination of fulfilling my role as LSM maintainer as well as being
> > > Fan's coworker.  While I realize you don't work with Fan, you are
> > > listed as the fs-verity maintainer and as such I've been looking to
> > > you to help review and authorize the fs-verity related code.  If you
> > > are too busy, frustrated, or <fill in the blank> to continue reviewing
> > > this patchset it would be helpful if you could identify an authorized
> > > fs-verity reviewer.  I don't see any besides you and Ted listed in the
> > > MAINTAINERS file, but perhaps the fs-verity entry is dated.
> > >
> > > Regardless, I appreciate your time and feedback thus far and I'm sure
> > > Fan does as well.
> >
> > Maintainers are expected to do reviews and acks, but not to the extent of
> > extensive hand-holding of a half-baked submission.
> 
> Considering the current state of this patchset I don't believe that
> verdict to be fair, or very considerate.
> 
> We clearly have different styles and approaches towards subsystem
> maintainer roles.  I've had the good fortune to work with both hostile
> and helpful senior developers during the early years of my time
> working in the Linux kernel, and it helped reinforce the impact
> patience and mentoring can have on contributors who are new to the
> Linux kernel or perhaps system programming in general.  While I'm far
> from perfect in this regard, I do hope and recommend that all of us in
> maintainer, or senior developer, roles remember to exercise some
> additional patience and education when working with new contributors.
> 

It's not clear to me that you've done a close review of the verity related
patches, including not just this one but the dm-verity related ones and the
fsverity and dm-verity support in IPE itself, given the issues that I've been
finding in them in the last couple months.  As I said before, I'm not too
enthusiastic about IPE myself, for various reasons I've explained, so I've
really been looking to the people who actually want it to help drive it forward.

Anyway, as I also said, the fsverity and dm-verity support does seem to be
improved now after all the rounds of feedback, and I think it's close to the
finish line.  I just hope you can understand that I'm also a bit burnt out now,
and getting asked for an ack on this patch again and then seeing a bug in it
(despite it having been simplified to only a few lines now) and also still
misleading information in the commit message that I asked to be fixed before, is
a bit frustrating.  I think it's reasonable to expect a bit better, especially
for a security oriented feature.

Thanks,

- Eric

