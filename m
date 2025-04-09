Return-Path: <linux-integrity+bounces-5734-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CAA833BB
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527314A1601
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF2215777;
	Wed,  9 Apr 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="APHJia6r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED801E7C1C
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235713; cv=none; b=ZwLw0OMlo7Wf/yFdu+rJ9VB8N68/OEd/zt4AISj4bJLLNyWpRUZmrbNYokJmgrIulp4pMLqm8W0heIr0gPVnASR3jaavUrS+cCZpzR5gP0UoBdm3412Mn5tjLmTBEbrsdMdzQZyo6r9VGZjRomMLyblSCLNlLFUzZGpldUSlOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235713; c=relaxed/simple;
	bh=NgCLzGIpE6sK5tDppclVks0xtdgtNbHJZPJX63o4pXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqWjGI2kOGAl3aqk4qaHyGgv2H+fA4rsksezsSHNuau53z2vmqmG3Dx+P+08wVxllhnZZc5XOh7vbs2hAi24qL3+0raMb3tA16mkcoPi9VjluqDn9Tkx234Z37ip2/QRVr8Q4rGJBTwbHqu33SB3JjsDl6wAEgcDuuhC86oFCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=APHJia6r; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef9b8b4f13so1694787b3.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744235710; x=1744840510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BzfnLoFkzfih57uE/uB+rGIEl0CKJHJOVcHtFoCVd4=;
        b=APHJia6rymXcKBfKIZ54DZoTBCUxzLuENVmnwmL3UUDAMfsL4v6R8f+571c5bcCRKy
         1TyNCMyxASbG8t/BpNGWObZEZzKatQN5o8SyCTSR+DiU5WoN5QLWiqxW2cXjLY5cntSL
         qD3gR/Kz3CmsAwykFIUDvE4DFTm2DEbd53oKGUlwMKMIAYhSMS0s6CAXyFn0Oqo8Vu/0
         OOOIC6L9j+ajHmyfRygImMy8QN5fyE1Yq0pPtYbI/kxqNbKq0I63V79hv8XZ/UpHuPmg
         vVjkSNF/PkY8G1ANnp5owFIfBrVePsNHkv+aHrfVI/kl4eF4d43X+TlsYHJahJlO+QdY
         5M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235710; x=1744840510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BzfnLoFkzfih57uE/uB+rGIEl0CKJHJOVcHtFoCVd4=;
        b=aFQTCqUFzD/THCovik3yPIkoGN6XFdxKO6yqshxuozMD/NiNpZYwcBlZLDfxE0qKoI
         m3R1HfIA8+GchM8CMy8tICotnYLS5uI8pchASrnYv37KdjRBaiTRVtX5j4igqkg1l/qo
         v4qYHv/RSXm4n7L0NhDxTsGoHva9icFx6Elbmu9GCTtAOXqM8GfWoMnPSVw8BKzwbqin
         epTUt94hLTsiUJnjzlqjGsSmukMhDqqmJTnwT4WjaVE07GNnyRengQ/LQrRBoEGSsQUI
         zRpyZiYhS7nU2G9PzA4jy+ggXSYk4NpWOiuDaSdPn4MUigZ9z7MiqNIdG6EPNkjWItvA
         buAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTH4vEM9pvXREZcWliW8MNimTQ3y2vWOIumH0WDK6AykSOiFYw/QSzi2Th4XPt5PyKg2UoBEfYETrBV1Yf+ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY71xA1vIjWkEm/Yl2GBs1QxnMyGA9tt3JaYEW19302aI8l9bv
	NlcO2A8LZe8DijJJdZfQKq9r5teWwUEFwXcMGu46XHfgRgAcM3Xk+ZHNHUPf98B/LLJh47EElUg
	h7a2rdFuSV+jL0LULPaEUj5PGmD+5y31bmyyr
X-Gm-Gg: ASbGncu/3LpV9td3nKk8ae6vw3V+49hfplsqIyYfQD1KqK85lZ3vFcy0kXpgeZLpC8z
	BSDYK7k+vne3fORWbdMA6pCvg2eM1Je7IbnkX647lFJulKXonIwTEHmJTZRXo/EuKhZOv8Pt2l/
	ltJBjBWfSAmln626X9vIcDfw==
X-Google-Smtp-Source: AGHT+IHnLh0Wm5MhR/M9zp8F7sUZoLW7BhmbCXHVzZF2t+qG34NaJR9geNaTITGyvyIncasI0zxF+X/b8eO4m+0T4O4=
X-Received: by 2002:a05:690c:30a:b0:6fb:4648:3425 with SMTP id
 00721157ae682-70549e80da0mr6788057b3.16.1744235710398; Wed, 09 Apr 2025
 14:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-34-paul@paul-moore.com>
 <202504091422.13DA5BED@keescook>
In-Reply-To: <202504091422.13DA5BED@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Apr 2025 17:54:59 -0400
X-Gm-Features: ATxdqUHmF-DbkQ9SoQgZu9u9N9waCVDbm9Wxk8rKX44Sx6e78bebd2A7FbC6x9M
Message-ID: <CAHC9VhRPpNfjao0j7BfuS7s5xya-PPOE8_5DZkN1pVvucnVWSg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/29] lsm: simplify prepare_lsm() and rename to lsm_prep_single()
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:49:48PM -0400, Paul Moore wrote:
> > One part of a larger effort to cleanup the LSM framework initialization
> > code.
>
> This commit log needs improvement. i.e. explain what and why:

Yeah, it's bad, see the cover letter, the commit descriptions were
explicitly mentioned as needing improvement.  You'll likely see a few
other patches with let's just say "less than good" commit
descriptions.  I basically go through and add/edit/fix-up commit
descriptions while things are compiling, tests are running, etc. and
with the number of patches in this patchset I didn't make enough
passes through the list to get beyond some generic text in a lot of
the patches.

I simply wanted to get this patchset out as a RFC as it had been
mentioned to a few people offline and I wanted to get some feedback
from the individual LSM maintainers who might be affected by moving
the initcalls out of the individual LSMs and into the framework.

> The execution flow through lsm_allowed(), prepare_lsm(), and
> lsm_set_blob_sizes() is a bit convoluted. Merge the logic of all three
> into a single new function, lsm_prep_single().
>
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/lsm_init.c | 103 ++++++++++++++++++--------------------------
> >  1 file changed, 43 insertions(+), 60 deletions(-)

...

> > @@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, i=
nt *lbs)
> >       *need =3D offset;
> >  }
> >
> > -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> > +/**
> > + * lsm_prep_single - Prepare the LSM framework for a new LSM
> > + * @lsm: LSM definition
> > + */
> > +static void __init lsm_prep_single(struct lsm_info *lsm)
>
> Nit-pick on naming: why shorten "prepare"?

My fingers are lazy?

> > +     /* Register the LSM blob sizes. */
> > +     blobs =3D lsm->blobs;
> > +     lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> > +     lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
> > +     lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> > +     /* inode blob gets an rcu_head in addition to LSM blobs. */
> > +     if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> > +             blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> > +     lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> > +     lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> > +     lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
> > +     lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> > +     lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_ev=
ent);
> > +     lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> > +     lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superbl=
ock);
> > +     lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
> > +     lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> > +     lsm_set_blob_size(&blobs->lbs_xattr_count,
> > +                       &blob_sizes.lbs_xattr_count);
> > +     lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
>
> Another refactoring idea I saw recently from the sysctl subsystem was
> turning these named "same things" into an array with enum names, so
> instead of &blobs->lbs_ipc, &blobs->lbs_key, they can still have useful
> names but also be iterated in a loop:
>
> enum lsm_blob_types {
>         LSM_BLOB_IPC,
>         LSM_BLOB_KEY,
>         ...
>         LSM_BLOB_MAX
> };
> ...
>         for (i =3D 0; i < ARRAY_SIZE(blobs->lbs); i++) {
>                 lsm_set_blob_size(&blobs->lbs[i], &blob_sizes[i]);

Cool idea, but let's leave that as future work since it is going to
start stretching across security.c for the allocators (and in xattr
count stuff) and this patchset is already more expansive than I would
like.

> > @@ -499,7 +482,7 @@ int __init early_security_init(void)
> >       for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; =
lsm++) {
> >               if (!lsm->enabled)
> >                       lsm->enabled =3D &lsm_enabled_true;
> > -             prepare_lsm(lsm);
> > +             lsm_prep_single(lsm);
> >               initialize_lsm(lsm);
> >       }
>
> Regardless, this looks correct to me. With or without renaming the
> function:

Thanks, I appreciate the review.

> Reviewed-by: Kees Cook <kees@kernel.org>
>
> --
> Kees Cook

--
paul-moore.com

