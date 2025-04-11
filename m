Return-Path: <linux-integrity+bounces-5814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81CEA85155
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F194A79F9
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6A26FA78;
	Fri, 11 Apr 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hfv/q26Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EA20B803
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744336224; cv=none; b=qCeMbwQagwhR/+Bd0qPb+6MucRlECcDJYSx7gp2pkJpUn9m2DgWaS1aV6cepY6po4c3nCtS49rpXQmWrAgoK7u/azeTcM3D6T1Io9+COKosphsuxkMKOrHGO40/MiIPD9fVJt99uFjduzHIMZnhxsBpIEPPYz43GcZE6oyVCKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744336224; c=relaxed/simple;
	bh=QYVRJoIbp02k9ro1Ax8tSLzruGUWDFtzS5dyKaT2E5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+DJlvpvFdDAWXyqMKIF0cMltFXOcpMJ3xRnWTRMEYoyhivzLmzZdGbRe3Ud4CsVtBBgeQE25Nb2p2EwFxG9VjVfd9TCg8NEUw7fLmlhriTbdkb50ryKhxLXpNQzn2RO9JdcFhzKTjU2FHLiLTJujeBEuVKm10MwzLgX84/K9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hfv/q26Z; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e609cff9927so1068461276.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 18:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744336221; x=1744941021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWCJOJlxzYSawY8S2YrEidc5ixEU2jj2JYExg/ffIDI=;
        b=Hfv/q26Zd32iPqVTeFNL9ZRHvLHgm+8k6CHQolJffKKV65BPTSOz0GVLqiLJm55VFU
         HteunkCRRzd8mStuzha//zXdzQO4kurkZorwDGIudfFh1Unk9IRD5j9QNIfP4N9vc9Ih
         ug3z4gdZm48shdt12AwMlJFkznWwb6ZY+aC3GIBiedU1vispjtEzw2mtEJscJeBjLZO0
         M3Pvq4HpoVB6h9jcdmV5TcNeYILG4E4SUCnqZhAFK90ajkBzLPbepEAIGz1ACCytvVsH
         eiIE9lPH+JYYh7QryBRP6rarBzCIVHGuZGa1tQriG46oDNxR7qEtM2glIUP02eXGsTMB
         JznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744336221; x=1744941021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWCJOJlxzYSawY8S2YrEidc5ixEU2jj2JYExg/ffIDI=;
        b=FyEjyeWVkrNRhLan+pHiLAf4OROwup9h2fDCgp0BTRSfIAlCcCcy+5Z3ouQq5U2nHc
         6xJVEsr3u15suhZKO3zQJx4jvvgVBWbWJKvgZPJni4Y/1LBdGO8ZHJpgGEeF8cUmGGKs
         PEQA5mKeH3e5q5a0BStMFL4r4/qop5lsXx1oGHlYGxA02gbII2i+JhPohDzXH12oFIEU
         q9ABXGH6LviH9ig0klFhmgVGzgO/jImPJKNLEdDoAlv2Je0l5GCgRce9Wcz5nsZoyobI
         CDRbQYmZAbnw0L4ca+CstHyW++51GIkYigk49bU9JuF9ssaq1ABEKy8qnFy7dkVCshlk
         sYiA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4I7a+v66nhOjp8eueQaXA0svin2SaO8C91RUFZbrxbwSUt5IGS+6nOFd9JleM4RqIB5+cy9tUnAqRVIK978=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKoKX9/9VgUPjFPQlhKQR5ZdxREyaLKCqHHAOkOHZqxEs43+G
	o3rXN+DjXS/Y7QAMmoP4XNUncjw/iQ8REJ2/e1u2j/H3bX05JbjWqCWx4iwNBfEnzpVFvEJrDNw
	UWJwpjIaTw7wOKgnJJN7tqo5Sdzb8ltRLoX7f
X-Gm-Gg: ASbGncs51lsMYzh6U2wr/td7JWtBZG13+kkxQewtRZnmAH9PFCKQixtq+buegyQc+Dl
	TylXBawsF39a1j2JZihdZkasprc01SUEo26uJTs4IZY0LCsfl3azQBox7UI1CDQg5nDkgbwGsMO
	0H7wCyNvYsTWqDj+NFtpXjyA==
X-Google-Smtp-Source: AGHT+IF39r4/xCsM2s0Xl2G799TT+cgKymnHxCfrkg4q2FjdtLZ7eLonDSIC+7dWHdaz0rxcK0vmCdtlEEKm63GDpIY=
X-Received: by 2002:a05:690c:9a8a:b0:703:b606:73a5 with SMTP id
 00721157ae682-705599894e8mr17318847b3.8.1744336221259; Thu, 10 Apr 2025
 18:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook>
In-Reply-To: <202504091656.21EEF38DCA@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:50:10 -0400
X-Gm-Features: ATxdqUEgEemI0oUZk3AE1WBtSOsxh1400exynhftXCI3SbBTAqc0p4ZhaZXuw-8
Message-ID: <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
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

On Wed, Apr 9, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:
> > One part of a larger effort to cleanup the LSM framework initialization
> > code.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/inode.c    |   9 ++--
> >  security/lsm_init.c | 110 ++++++++++++++++++++++++--------------------
> >  2 files changed, 63 insertions(+), 56 deletions(-)
> >
> > diff --git a/security/inode.c b/security/inode.c
> > index 49bc3578bd23..f687e22e6809 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -351,18 +351,17 @@ static ssize_t lsm_read(struct file *filp, char _=
_user *buf, size_t count,
> >
> >       for (i =3D 0; i < lsm_count; i++)
> >               /* the '+ 1' accounts for either a comma or a NUL termina=
tor */
> > -             len +=3D strlen(lsm_order[i]->id->name) + 1;
> > +             len +=3D strlen(lsm_idlist[i]->name) + 1;
> >
> >       str =3D kmalloc(len, GFP_KERNEL);
> >       if (!str)
> >               return -ENOMEM;
> >       str[0] =3D '\0';
> >
> > -     i =3D 0;
> > -     while (i < lsm_count) {
> > -             strcat(str, lsm_order[i]->id->name);
> > -             if (++i < lsm_count)
> > +     for (i =3D 0; i < lsm_count; i++) {
> > +             if (i > 0)
> >                       strcat(str, ",");
> > +             strcat(str, lsm_idlist[i]->name);
> >       }
> >
> >       rc =3D simple_read_from_buffer(buf, count, ppos, str, len);
>
> This chunk needs to be folded into the lsm_names changing patch, I
> think. I missed this on the first pass, but lsm_order can never be used
> here because lsm_order is initdata -- it will be thrown away after init
> is done.

Yeah, I noticed this when I was reverting that
/lsm_active_cnt/lsm_count/ change and fixed it up to use lsm_idlist[]
which should address that problem.  Later patches convert over to
lsm_idlist[] anyway, which is likely why I didn't catch this in the
preliminary testing.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 978bb81b58fa..7f2bc8c22ce9 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -10,6 +10,10 @@
> >
> >  #include "lsm.h"
> >
> > +/* LSM enabled constants. */
> > +int lsm_enabled_true =3D 1;
> > +int lsm_enabled_false =3D 0;
>
> Why are these losing static and __initdata? It looks like they're
> staying assigned to the __init-marked lsm_info instances.

Good point.  I'm not sure what happened here, it may have been a
victim of an earlier change which I dropped.

> > +/**
> > + * lsm_is_enabled - Determine if a LSM is enabled
> > + * @lsm: LSM definition
> > + */
> > +static inline bool lsm_is_enabled(struct lsm_info *lsm)
> >  {
> >       if (!lsm->enabled)
> >               return false;
> > -
> >       return *lsm->enabled;
> >  }
>
> This could be one-lined, actually:
>
>         return lsm->enabled ? *lsm->enabled : false;

Sure.

> > -/* Is an LSM already listed in the ordered LSMs list? */
> > -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> > +/**
> > + * lsm_order_exists - Determine if a LSM exists in the ordered list
> > + * @lsm: LSM definition
> > + */
> > +static bool __init lsm_order_exists(struct lsm_info *lsm)
> >  {
> >       struct lsm_info **check;
> >
> > @@ -118,25 +123,29 @@ static bool __init exists_ordered_lsm(struct lsm_=
info *lsm)
> >       return false;
> >  }
> >
> > -/* Append an LSM to the list of ordered LSMs to initialize. */
> > -static int last_lsm __initdata;
> > -static void __init append_ordered_lsm(struct lsm_info *lsm, const char=
 *from)
> > +/**
> > + * lsm_order_append - Append a LSM to the ordered list
> > + * @lsm: LSM definition
> > + * @src: source of the addition
> > + */
> > +static void __init lsm_order_append(struct lsm_info *lsm, const char *=
src)
> >  {
> >       /* Ignore duplicate selections. */
> > -     if (exists_ordered_lsm(lsm))
> > +     if (lsm_order_exists(lsm))
> >               return;
> >
> > -     if (WARN(last_lsm =3D=3D MAX_LSM_COUNT, "%s: out of LSM static ca=
lls!?\n", from))
> > -             return;
> > +     /* Skip explicitly disabled LSMs. */
> > +     if (lsm->enabled && !lsm_is_enabled(lsm)) {
> > +             if (WARN(lsm_count =3D=3D MAX_LSM_COUNT,
> > +                      "%s: out of LSM static calls!?\n", src))
> > +                     return;
> > +             lsm_enabled_set(lsm, true);
> > +             lsm_order[lsm_count] =3D lsm;
> > +             lsm_idlist[lsm_count++] =3D lsm->id;
> > +     }
> >
> > -     /* Enable this LSM, if it is not already set. */
> > -     if (!lsm->enabled)
> > -             lsm->enabled =3D &lsm_enabled_true;
> > -     lsm_order[last_lsm] =3D lsm;
> > -     lsm_idlist[last_lsm++] =3D lsm->id;
>
> I don't understand the logic change here. I may be missing something (it
> feels like a lot of logic changes mixed together again), but this logic:
>
>      /* Enable this LSM, if it is not already set. */
>      if (!lsm->enabled)
>              lsm->enabled =3D &lsm_enabled_true;
>
> seems like it has gone missing now?

It's a little confusing as lsm_order_append() gets heavily reworked a
couple of patches later in "lsm: cleanup the LSM ordered parsing",
which is essentially this function's end state from a logic
perspective.  I think the best thing to do might be to squash those
two patches ... lemme see how ugly that ends up ...

> The simple renamings looks fine, but would be nicer if they got split
> out.

I can look into doing that, let me try the squashing first.

--=20
paul-moore.com

