Return-Path: <linux-integrity+bounces-2759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A8F8D661A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C6283316
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875511586C7;
	Fri, 31 May 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WYmK2Ngo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF115381A
	for <linux-integrity@vger.kernel.org>; Fri, 31 May 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170721; cv=none; b=cJsUKtQfB3IXXMSJ31Dx/c2jvUX2P4xtRINjRkNg8fFDodMNLzdWuSWJHoMVOc+b5zLujLd5dvJije9Zwg25GoYHN5so+6aT19uE6wGM1eDrLMUrM2tnXK78sEF9PBn8N5Wxls+Ku4BNxeWEkLq2tR+YTyJf7+1FHbOxrNzqBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170721; c=relaxed/simple;
	bh=3Ot0Q+UNMH93NNe6w2xEdYL7SS7lyjTPxCgxXIk/HII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUZdIVXPPi0YvOdLIt65NRYvudcHgZJ823xDXAcyqRx2IpYrtPQJ3eENICFGh58/gtRpu+tBhOm/ma3MD/O7np3vmytCziqDNJPdwcbTXg2wEBXeWqYpHEV+pE5eORA3gQO65dNJ5KFHUcdLonu/W4gYPTv0wcTwsoROe6/BJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WYmK2Ngo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a2424ed01so23293767b3.1
        for <linux-integrity@vger.kernel.org>; Fri, 31 May 2024 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717170718; x=1717775518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umHwvOWM6BZb7+KUwwTZhP6Ecq2Z1H7xf7RPJu7Y4LI=;
        b=WYmK2NgorglmETNVsa8lVKUBI8stYpjO0fymmtz1DRh+QxwOPCMOqHtdXM+EqwGRuf
         QHENiru5BzdxOE1NquZlCP3t50X7DimA/z+MSjBPfKy5GIhNqaycVFu2c/2g1kviVUkx
         /sS4q7dqa7worYWKYSUeGmZM3jVHXpd3PCD+aiLpAsjfn3mcZSDqmCvKbx2wDIQjkznr
         R0fVnatG25Qkb7ns2K8Qdg44HgZoiCtwewnVl5ZhyjRfOmGLVvNpUqGmEt0dcRPTe4dK
         6d/0ywSUY5ta6fdTzMzzak+v4Z/R0Jyx90j2TcJi8dm3wDLz9sDTZzwKAVHYo71uDyEG
         SpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170718; x=1717775518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umHwvOWM6BZb7+KUwwTZhP6Ecq2Z1H7xf7RPJu7Y4LI=;
        b=rBUc/Fbrl0tghSchh8bVj0kUxsUp88QmeTHI3HgLcAU3cPS9fo2fXdCKVCbnerfKKD
         QQfV2ZcJrILVSTFujg0vFBgQfWvUzA7wIRZHAoR4rDcFVpJxc3V31+VdBn6IWAqoO4ve
         ygYlwuBVtGQr+lNtKEKDvaTOi3yl7YW2bb/AWTZVZmDXX0Z1CJ3eylovNQQNVa/cVmzn
         /220l+ESm7bGFqDui97tT3gbYholHOGis6HGVsbXKLygJGk8UaDdSju9voeWc5ZykgpX
         GmCbWcQzscbUniKc8DznlZ/RRgVdZXxpzJ3TAmJgUDRG51vix8K1KzNXP6mgYX/n5Bx9
         /edg==
X-Forwarded-Encrypted: i=1; AJvYcCXFKpbrngto+w2Yzxhjgu/maB7Gr2jnHR+C0ji/zd6LFUUfrAcEqGFPvKZLM+hwFneOcvv2T1qmpAcY84f86iOai3kNP/Ih5EcdJh1SWYjH
X-Gm-Message-State: AOJu0YxasLkMsJu6/FjmSTvzreyjlpVQXBcVvfbd/khLGfTxz99QGMcx
	sEvXaad4WnMqf4jmOwrqMCMjmQJdxq4TPNXZ62bbIp4tWmj2aZB5Wguc6GHkSG0odBjVltRlrq1
	6EfdC9cJXixiCBWfUQ4sgUSiGfXF5haT9ZtIh
X-Google-Smtp-Source: AGHT+IHXzsYZDXrOIeHpN/g+jpmnMKhUXad17ToUg8H48P+bzIE3W6LWRQGFybVp9CQlBFZl48Ombvk1I/V82/c84Do=
X-Received: by 2002:a81:7754:0:b0:627:ddc5:eb5c with SMTP id
 00721157ae682-62c797e22a5mr22158347b3.34.1717170718539; Fri, 31 May 2024
 08:51:58 -0700 (PDT)
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
 <20240531004321.GA1238@sol.localdomain>
In-Reply-To: <20240531004321.GA1238@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 May 2024 11:51:47 -0400
Message-ID: <CAHC9VhRRuBdnv3u2VjKZCR672p4oj_smA72P-181ysdDXGJ-AA@mail.gmail.com>
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

On Thu, May 30, 2024 at 8:43=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> On Thu, May 30, 2024 at 04:54:37PM -0400, Paul Moore wrote:
> > On Wed, May 29, 2024 at 11:06=E2=80=AFPM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > > On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > > > On Fri, May 24, 2024 at 4:46=E2=80=AFPM Fan Wu <wufan@linux.microso=
ft.com> wrote:
> > > > >
> > > > > This patch enhances fsverity's capabilities to support both integ=
rity and
> > > > > authenticity protection by introducing the exposure of built-in
> > > > > signatures through a new LSM hook. This functionality allows LSMs=
,
> > > > > e.g. IPE, to enforce policies based on the authenticity and integ=
rity of
> > > > > files, specifically focusing on built-in fsverity signatures. It =
enables
> > > > > a policy enforcement layer within LSMs for fsverity, offering gra=
nular
> > > > > control over the usage of authenticity claims. For instance, a po=
licy
> > > > > could be established to permit the execution of all files with ve=
rified
> > > > > built-in fsverity signatures while restricting kernel module load=
ing
> > > > > from specified fsverity files via fsverity digests.
> >
> > ...
> >
> > > > Eric, can you give this patch in particular a look to make sure you
> > > > are okay with everything?  I believe Fan has addressed all of your
> > > > previous comments and it would be nice to have your Ack/Review tag =
if
> > > > you are okay with the current revision.
> > >
> > > Sorry, I've just gotten a bit tired of finding so many basic issues i=
n this
> > > patchset even after years of revisions.
> > >
> > > This patch in particular is finally looking better.  There are a coup=
le issues
> > > that I still see.  (BTW, you're welcome to review it too to help find=
 these
> > > things, given that you seem to have an interest in getting this lande=
d...):
> >
> > I too have been reviewing this patchset across multiple years and have
> > worked with Fan to fix locking issues, parsing issues, the initramfs
> > approach, etc.
>
> Sure, but none of the patches actually have your Reviewed-by.

As a general rule I don't post Acked-by/Reviewed-by tags for patches
that are targeting a subsystem that I maintain.  The logic being that
I'm going to be adding my Signed-off-by tag to the patches and arguing
these in front of Linus, so adding a Acked-by/Reviewed-by simply
creates more work later on where I have to strip them off and replace
them with my sign-off.

If the lack of a Reviewed-by tag is *really* what is preventing you
from reviewing the fs-verity patch, I can post that starting with the
next revision, but I'm guessing the lack of my tag isn't your core
issue (or at least I would argue it shouldn't be).

> > My interest in getting this landed is simply a
> > combination of fulfilling my role as LSM maintainer as well as being
> > Fan's coworker.  While I realize you don't work with Fan, you are
> > listed as the fs-verity maintainer and as such I've been looking to
> > you to help review and authorize the fs-verity related code.  If you
> > are too busy, frustrated, or <fill in the blank> to continue reviewing
> > this patchset it would be helpful if you could identify an authorized
> > fs-verity reviewer.  I don't see any besides you and Ted listed in the
> > MAINTAINERS file, but perhaps the fs-verity entry is dated.
> >
> > Regardless, I appreciate your time and feedback thus far and I'm sure
> > Fan does as well.
>
> Maintainers are expected to do reviews and acks, but not to the extent of
> extensive hand-holding of a half-baked submission.

Considering the current state of this patchset I don't believe that
verdict to be fair, or very considerate.

We clearly have different styles and approaches towards subsystem
maintainer roles.  I've had the good fortune to work with both hostile
and helpful senior developers during the early years of my time
working in the Linux kernel, and it helped reinforce the impact
patience and mentoring can have on contributors who are new to the
Linux kernel or perhaps system programming in general.  While I'm far
from perfect in this regard, I do hope and recommend that all of us in
maintainer, or senior developer, roles remember to exercise some
additional patience and education when working with new contributors.

--=20
paul-moore.com

