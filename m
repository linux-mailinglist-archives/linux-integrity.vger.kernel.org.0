Return-Path: <linux-integrity+bounces-2766-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6F8D79DB
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2024 03:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22131B2123F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2024 01:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A524A0A;
	Mon,  3 Jun 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RYjQsO0D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1B29A1
	for <linux-integrity@vger.kernel.org>; Mon,  3 Jun 2024 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378848; cv=none; b=Yzt6a2W1lSvd162xsg6UcbeWStAhkD1QLpZBsMM+91VSrFdpliPZyYAzS9vwkas3eN8IFwBKWif51PO06t6twZBkw82V+d43b3UgeDk9JBFScce/t9NUbIq+tNhHUm3+EkcJU0pJtzBtZTr+Ol9CdoFjQyJtqEWE/Yjhb10CDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378848; c=relaxed/simple;
	bh=uDNSXK89staAi5wtMKyMoU94EEY42WkdDv0RK++eZMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUXELP3ZjKiJnsD4Smf3/M1MzXxSVG5f1f5MJeoh40jlB8t48zuPs7KvCjPOQE2eSHYAHFHmtLyZwJpvc4glJjxOd9mBQZaZ2fref0kbEdNnMmBkC1YFkblDTMzWTGlnx4spsq17gCMG1iNwn36UMtgoFNAavKrrFx3YiprOd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RYjQsO0D; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a0827316eso26683867b3.1
        for <linux-integrity@vger.kernel.org>; Sun, 02 Jun 2024 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717378846; x=1717983646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TDOjHWp8bXjvFuOeUFIDKGP58ph/UwrghwjNGtMBFo=;
        b=RYjQsO0DfvgHqBCGsvHAcbAHl9HU4f0BLKGWoAhkVfLHsMzZCDlauGIcO8Zi0zsEE8
         M7XvTDb+YCrGoMFDowYr9Yh4XYdyVmnfFufXCWm4umBfkR8jbFUQu1bpJZt+75dS68jg
         OD8r5v+QXd4Hge4ei1NoIcL5zd8zZenWCZ873uuKAoF6Nbqf9Q7rZeJOihdC8ebvVd3H
         29C/F08soBnYShxWQxDw3x54ov00DwutdtBZoZdvNL50Edk6qwkE6om+Q7LIfnfbeRCI
         szNU4K+o9p4Y9kl+1PRQ+nH1LCjBgj3g51DXdOAqFietZ3FwamjP9dvQ9FOsvBynxG+y
         hkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717378846; x=1717983646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TDOjHWp8bXjvFuOeUFIDKGP58ph/UwrghwjNGtMBFo=;
        b=jMBMQ/1G+4m473hT6Sk/UvlZ64oJTOIrrBbz78HMSehqvPs1M4jXwEB0k2se4oZ2EF
         SrvK9QsXdzM+FocwCFVJcwJvu/JVH9dp6Yjo53rjc4g7Z5kFBgCCKUdiMG8himz2HBvj
         oXzinvc5BCisYUxzsJjz1GbV4rbZJwQvabGMv/6IYbZ95ao4AB+GiBtkrfN+AYLUhq5i
         cbdYrGtaZYVTS+QL9mnU/YSh56/reM+sW3ZK9ECkFw05Z3onj50KfPvxTI1Eg1qX110H
         L2Ef6U7Z/uFsjoLoa/v3zr0DgCCJtp5bPUZewYEC+WmRI06Nf8KCAvJ7jqEW5efYKEuK
         6NIw==
X-Forwarded-Encrypted: i=1; AJvYcCVVW2Ss9Ilhza6NiSSzE30TfoSnJ1ZdNGVa9Y6z/2wBwRtmsJPUDcDZWw5g73rREaAiQqFcNXHhtCjHW+pjiprgTd1leGuakQwRt+EHYubA
X-Gm-Message-State: AOJu0YzqK0gw5Qyk9H0xU8eoEOIsYoo06hTdFDw+tZsxmtHK/bNxo4BD
	1MAqEkEoFIHrYP9Q2NxK3ezRvkYYdQOeIgkyjyyVAb3Mv3238yfVtbT6LdVcoY+L8jprC4ClR8r
	M1tEKrw9w0OGJOcTK2a2oeU0xY8p/uSLdDWee
X-Google-Smtp-Source: AGHT+IFp652CCfD0M3qHSzvSxnuvYGSkS9KDgo5K/vd2UhiOAnsvsgHt4NTZTmN643EolwNgor3GheXekQ2a83RNBjY=
X-Received: by 2002:a81:ae42:0:b0:627:e414:2f46 with SMTP id
 00721157ae682-62c79708847mr83808507b3.28.1717378845664; Sun, 02 Jun 2024
 18:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
 <20240530030605.GA29189@sol.localdomain> <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>
 <20240531004321.GA1238@sol.localdomain> <CAHC9VhRRuBdnv3u2VjKZCR672p4oj_smA72P-181ysdDXGJ-AA@mail.gmail.com>
 <20240531174710.GA1199@sol.localdomain>
In-Reply-To: <20240531174710.GA1199@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Jun 2024 21:40:34 -0400
Message-ID: <CAHC9VhQDPnq3X0fFOXf5zY38K_STffmZJMqHp50sVqWW6pcabw@mail.gmail.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> On Fri, May 31, 2024 at 11:51:47AM -0400, Paul Moore wrote:
> > On Thu, May 30, 2024 at 8:43=E2=80=AFPM Eric Biggers <ebiggers@kernel.o=
rg> wrote:
> > > On Thu, May 30, 2024 at 04:54:37PM -0400, Paul Moore wrote:
> > > > On Wed, May 29, 2024 at 11:06=E2=80=AFPM Eric Biggers <ebiggers@ker=
nel.org> wrote:
> > > > > On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > > > > > On Fri, May 24, 2024 at 4:46=E2=80=AFPM Fan Wu <wufan@linux.mic=
rosoft.com> wrote:
> > > > > > >
> > > > > > > This patch enhances fsverity's capabilities to support both i=
ntegrity and
> > > > > > > authenticity protection by introducing the exposure of built-=
in
> > > > > > > signatures through a new LSM hook. This functionality allows =
LSMs,
> > > > > > > e.g. IPE, to enforce policies based on the authenticity and i=
ntegrity of
> > > > > > > files, specifically focusing on built-in fsverity signatures.=
 It enables
> > > > > > > a policy enforcement layer within LSMs for fsverity, offering=
 granular
> > > > > > > control over the usage of authenticity claims. For instance, =
a policy
> > > > > > > could be established to permit the execution of all files wit=
h verified
> > > > > > > built-in fsverity signatures while restricting kernel module =
loading
> > > > > > > from specified fsverity files via fsverity digests.
> > > >
> > > > ...
> > > >
> > > > > > Eric, can you give this patch in particular a look to make sure=
 you
> > > > > > are okay with everything?  I believe Fan has addressed all of y=
our
> > > > > > previous comments and it would be nice to have your Ack/Review =
tag if
> > > > > > you are okay with the current revision.
> > > > >
> > > > > Sorry, I've just gotten a bit tired of finding so many basic issu=
es in this
> > > > > patchset even after years of revisions.
> > > > >
> > > > > This patch in particular is finally looking better.  There are a =
couple issues
> > > > > that I still see.  (BTW, you're welcome to review it too to help =
find these
> > > > > things, given that you seem to have an interest in getting this l=
anded...):
> > > >
> > > > I too have been reviewing this patchset across multiple years and h=
ave
> > > > worked with Fan to fix locking issues, parsing issues, the initramf=
s
> > > > approach, etc.
> > >
> > > Sure, but none of the patches actually have your Reviewed-by.
> >
> > As a general rule I don't post Acked-by/Reviewed-by tags for patches
> > that are targeting a subsystem that I maintain.  The logic being that
> > I'm going to be adding my Signed-off-by tag to the patches and arguing
> > these in front of Linus, so adding a Acked-by/Reviewed-by simply
> > creates more work later on where I have to strip them off and replace
> > them with my sign-off.
> >
> > If the lack of a Reviewed-by tag is *really* what is preventing you
> > from reviewing the fs-verity patch, I can post that starting with the
> > next revision, but I'm guessing the lack of my tag isn't your core
> > issue (or at least I would argue it shouldn't be).
> >
> > > > My interest in getting this landed is simply a
> > > > combination of fulfilling my role as LSM maintainer as well as bein=
g
> > > > Fan's coworker.  While I realize you don't work with Fan, you are
> > > > listed as the fs-verity maintainer and as such I've been looking to
> > > > you to help review and authorize the fs-verity related code.  If yo=
u
> > > > are too busy, frustrated, or <fill in the blank> to continue review=
ing
> > > > this patchset it would be helpful if you could identify an authoriz=
ed
> > > > fs-verity reviewer.  I don't see any besides you and Ted listed in =
the
> > > > MAINTAINERS file, but perhaps the fs-verity entry is dated.
> > > >
> > > > Regardless, I appreciate your time and feedback thus far and I'm su=
re
> > > > Fan does as well.
> > >
> > > Maintainers are expected to do reviews and acks, but not to the exten=
t of
> > > extensive hand-holding of a half-baked submission.
> >
> > Considering the current state of this patchset I don't believe that
> > verdict to be fair, or very considerate.
> >
> > We clearly have different styles and approaches towards subsystem
> > maintainer roles.  I've had the good fortune to work with both hostile
> > and helpful senior developers during the early years of my time
> > working in the Linux kernel, and it helped reinforce the impact
> > patience and mentoring can have on contributors who are new to the
> > Linux kernel or perhaps system programming in general.  While I'm far
> > from perfect in this regard, I do hope and recommend that all of us in
> > maintainer, or senior developer, roles remember to exercise some
> > additional patience and education when working with new contributors.
> >
>
> It's not clear to me that you've done a close review of the verity relate=
d
> patches, including not just this one but the dm-verity related ones and t=
he
> fsverity and dm-verity support in IPE itself, given the issues that I've =
been
> finding in them in the last couple months.

I have not been able to give the fs-verify or dm-verity patches the
same level of scrutiny as the associated subsystem maintainers simply
because I lack the deep history and background; I rely on the
associated maintainers to catch the important "gotchas" as we've seen
in the patchset.

> As I said before, I'm not too
> enthusiastic about IPE myself, for various reasons I've explained, so I'v=
e
> really been looking to the people who actually want it to help drive it f=
orward.

Once again, that is what I have been doing in my effort to get this to
a point where it can be merged and sent to Linus.  I've spent numerous
hours reviewing patches on-list (and catching quite a few issues), and
working with Fan off-list, to ensure these patches continue to
improve.  I'm asking you to review the fs-verity patch(es) for two
main reasons: 1) to identify any fs-verity interaction problems, 2) as
a courtesy since you are the fs-verity maintainer and I want you to be
aware of this and accepting of the code being introduced in the
subsystem you are responsible for maintaining.

> Anyway, as I also said, the fsverity and dm-verity support does seem to b=
e
> improved now after all the rounds of feedback, and I think it's close to =
the
> finish line.

I agree.  I appreciate your help in reviewing this patchset, and those
that came before it.  I've seen Fan voice his appreciation too
on-list.

>  I just hope you can understand that I'm also a bit burnt out now,

I can understand that, and I'm sympathetic.  I've been doing this long
enough to have gone through my own cycles of burnout and rejuvenation
and I know how disheartening it can be at times.

> and getting asked for an ack on this patch again and then seeing a bug in=
 it
> (despite it having been simplified to only a few lines now) and also stil=
l
> misleading information in the commit message that I asked to be fixed bef=
ore, is
> a bit frustrating.  I think it's reasonable to expect a bit better, espec=
ially
> for a security oriented feature.

I firmly believe that no one writes perfect code, and no one performs
a perfect review.  As far as I'm concerned, the important bit is that
you respond, learn, and strive to do better next time.

--=20
paul-moore.com

