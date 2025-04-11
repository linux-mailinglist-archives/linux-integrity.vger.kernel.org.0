Return-Path: <linux-integrity+bounces-5844-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F003FA866C9
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 22:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045511B633D8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDD28369F;
	Fri, 11 Apr 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aVuDQUNP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7B280A39
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402179; cv=none; b=uwHg4UyDahKXpU6RrSNQQ9Hcj6UCexhMGmSuZlnpAMgjWfxEpsDJW7bJqYW/qKjoCXQTvqmRDkpXNM+QK1qSGPGQMBZ9fDWuJiyBMAwghiAiINba82KnyKNuglRDTYLm7/sWpjTIBBE1enhtwbwdSrrfjwqNsjR1lslKq7KQ5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402179; c=relaxed/simple;
	bh=21yvNPq4OdKIL+bkvchjbw/MGuaALNF22N0yQBLatR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZng75JPP11uDN4mZvzEjYU4a2+L363SYJEL0v3uanN3wshxW3aFrb2f6oF6gczmZAPQRxICzc2AYft6bGQ8Kr3DynHvolavqSA1FnP26mJvkSNuUgnHzuwmPLXjslGxwqebw5SpPd5l+nFQ46yw+YBVR1HOeEfjti6Wx7PTQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aVuDQUNP; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-702599fa7c5so23575937b3.1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744402176; x=1745006976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GcjugSSYmWDoQ6ghXIELsbqGaG1SaMXcW6c00jIJHg=;
        b=aVuDQUNP1q8UJmP7yJOI+PGd+EvAngmS3u+IsbQYX7Z1UigqDJsPEWXaor8PdFwMog
         bnayzMgCMuPuZJE2HJs32ESFTu60dL8YBpzLeYPJKKhVOh2GnKmw3+GcvoCZN8db5l2q
         YF/0eLVS8HdVMjSmVT5Gxsjl9GymW5Lm9/sSY6jaIepqTPeKW7CDSF+JraXdk90cgjYp
         0+5CvyZnhYAr2jXgKH1J8G8gKmzirUZDnBsdSAQvAA4rcfSrkSpNaC/EqBk+xIVGkyTT
         8wLltvpa4Nfx2nJq9bmEzJt4N6Rns6piWHqln/u/O9dKmcCfDTtnu8SLLVPiw++85s4W
         RHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744402176; x=1745006976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GcjugSSYmWDoQ6ghXIELsbqGaG1SaMXcW6c00jIJHg=;
        b=GFG1z5SPU7L8FrTJ/xd+xh1UMAl2gqOAGbuHCoE/F8yArv4bqeKnTtYnCFn+CcyKq2
         /TwlrTtH5OLHIMLGdIUecnnwVfUtzsvfotJ/mLFqzHfKKtV//PO0pyd8zyFh9sEfxd8z
         +01LDpWpuBKzamOpas7d5MYhFGWXnUmi+Rcqo1uUh8mVX4gKTB5Mce+hyBTM7X2sjvDm
         Ff0pYZn3ynbk74BDfpSqBVgdlvw9IdcU7gHFUWft4TvaVbz4SjELYVx9xJXUmhpDmS4b
         INma6HtswXY4YMLxGAGzkNK4tBFn5fWgZTxPpfZYDoBhXBZLO0jsGidBwv3x/op+i0Pt
         ZouQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB8HnwWOxI39YYOcyESDD6GariOT84GeEftuyb1DOYvUIq6r6j4gJXednFxBYGwmSx93hEXJ6iiVLqT+ka0Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxK9lAGNKoraJEQmeEt+frFa2+rriQSI43aFBb54p2dYlpTOT7
	hU0hC1+LIxim1VCwFs3A9nt5JukXx81Yb06FgwMdmsndm7f9U5NcPhWAV+SZZbXsA39UIXIOAh8
	QcRK7ja073x+ZvU655aJYQnfTGZhGbmsoIoLT
X-Gm-Gg: ASbGncsPtrV9YYQXj9p0BYzvYy95nsDdUd+d7Uh9dL9D6RE4VXGLD4WEkJQbYUvnrCq
	rZ19CmN9aRcPwW4bP/LwbJ5D1nAYP1SdnDBuq3PsUqk3hpV7WQTxtVALr/oZRSQ9iCkkoh/FEnw
	pMf7Em4tm8AR723v0LWsERYw==
X-Google-Smtp-Source: AGHT+IEr+91wsNbiAEq6x0+fQAi0c6S+sEU6+/AksTONya6ApekmKG1cLBE7m3sZ0up3vpnnkD4115NERiH7CRon13c=
X-Received: by 2002:a05:690c:3692:b0:6fe:bf32:a427 with SMTP id
 00721157ae682-70558f8057amr68283557b3.0.1744402175968; Fri, 11 Apr 2025
 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
In-Reply-To: <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 16:09:24 -0400
X-Gm-Features: ATxdqUELldJHXfGjYhNEDkIw1GjqNYtZz4Fa16Lgpfa5NTdJpD8GdzXyPKxnGuA
Message-ID: <CAHC9VhRgeb8NQpi0bzTt=P640_LZAm9=U8Efor=aXQdZRRBYsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 1:30=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/9/2025 11:50 AM, Paul Moore wrote:
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           |  6 ++++++
> >  security/smack/smack_lsm.c       | 16 ++++++++++++++++
> >  security/smack/smack_netfilter.c |  4 +---
> >  security/smack/smackfs.c         |  4 +---
> >  4 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index bf6a6ed3946c..709e0d6cd5e1 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -275,6 +275,12 @@ struct smk_audit_info {
> >  #endif
> >  };
> >
> > +/*
> > + * Initialization
> > + */
> > +int init_smk_fs(void);
> > +int smack_nf_ip_init(void);
> > +
> >  /*
> >   * These functions are in smack_access.c
> >   */
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index e09b33fed5f0..80b129a0c92c 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
> >       return 0;
> >  }
> >
> > +static int smack_initcall(void)
> > +{
> > +     int rc, rc_tmp;
>
> separate lines for the declarations please.

Done.

> > +     rc_tmp =3D init_smk_fs();
> > +     if (rc_tmp)
> > +             rc =3D rc_tmp;
>
> Replace these three lines with:
>
>  +      rc =3D init_smk_fs();

Done.

> > +
> > +     rc_tmp =3D smack_nf_ip_init();
> > +     if (!rc && rc_tmp)
> > +             rc =3D rc_tmp;
>
> Change this to
>
>  +      rc_tmp =3D smack_nf_ip_init();
>  +      return rc ? rc : rc_tmp;
>
> Also change rc_tmp to rc_nf and rc to rc_fs.

Done and done.

> > +
> > +     return rc;
> > +}
> > +
>
> Or:
>
> static int smack_initcall(void)
> {
>         int rc_fs =3D init_smk_fs();
>         int rc_nf =3D smack_nf_ip_init();
>
>         return rc_fs ? rc_fs : rc:nf;
> }

Done (with the typo fix you mentioned later).

Thanks for taking a look.


--
paul-moore.com

