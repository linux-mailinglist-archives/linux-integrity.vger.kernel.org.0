Return-Path: <linux-integrity+bounces-5822-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADFFA8519A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00288C5E71
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2F1E515;
	Fri, 11 Apr 2025 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XMqmHjqE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E041F0990
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338669; cv=none; b=j5sSS+sD9TwbEUkOz4HSmeakz8xW0UCpL1UpF3vfWHW2hPSjGnayrGnC3H+TEzsTdekPOGIb7LxvL5JOigdOuUH4EOUAazvHhPgEcslgIm9zCjk0VQsy7bXyklZ18BSA5m7UOTC+SnPm7qFgRc9hsH+sts+uHdn8bHZaoJAqhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338669; c=relaxed/simple;
	bh=cc5e2N+6H+tcjGaaKsPHIo72TMBB5vvw4D15hIgSMjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvKeP7qumOef0a/ii0eTeG6PxME1BV/RgPT5BspBu6dgJPzENZ4wGV3JvlrsfBE+g+S7cVyrv2abrX/IC+2mciDIP4/7MYzmDU1Vmx/AhfP6bUUl/025jDxB6v6zAZPr2ei0PdOd34rxvUqxAfpypjfUQELL7cDxm9ZDa6vmk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XMqmHjqE; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso1081938276.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744338665; x=1744943465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNkKNP1Bw20PcmRVgsTkFbGsUkto8dq13qXkhzYeC/4=;
        b=XMqmHjqE9jNbfNBmZiGBP4E1KgVEZoPdZRsjgQnNvlM3tP68j0vZTY9CeeG0TQMYtn
         5mFsZka8dDK/A9OzrioKY/jCxyAuCyatWwHsZ3ThbJktpeYwwwPr+c3RsTWqWkmsj71+
         6gBAyQRsZkiTbUFHcquoHLvBHFLRAabreijy9c/WiQrJoOtPrtyuu7PLx8koYERMe91T
         fYFt3fqbn6GXUBfyM/ySKqeArxDt7/l289hCRVsD6e7y9JetyKYkVTRGy8KlnS3tSTmS
         iQH5NvG2gl4zL0DHaf6WGMyw1uaS+Qu6Rn3giyUAbdKslQGo5bPy31qbiurG+rYnubDi
         WejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338665; x=1744943465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNkKNP1Bw20PcmRVgsTkFbGsUkto8dq13qXkhzYeC/4=;
        b=An+s/Fh7B5j+cxtOK3S0QyH3z7sDqyADgB+Ro9pny+SJx+v09BmSNQmdSiyN3jZkfw
         RwVzxIf8A7/1jCvEyeQXonAJPIvoRxy6CdyNqybH/8io7D6XaSbmg2ckAtjYL3dJQpyc
         FhN7G9tAEasGJZaINEy40uDeJLd8rKkL3k4nSe+iTrKrfe3TVAoJs2sOtM4FtGRb9D2l
         iEXH6sGAew5Ku7yh1/g844NZrq3NwqSx4ltJh+E7gkkp7NuE30SmagOECWdWDZ1dMesr
         tR66WDbl/QqnrygP32Y/leZcDAEPsgrtz18A6IcPEO4rVleDWCyVfpauEJ0fRScmWCGT
         kYvA==
X-Forwarded-Encrypted: i=1; AJvYcCW3XjbXACAr5dYbsx/2TMJaaZruC49KS/FpICM9GlpcjBA35Wwphu7DWW6h9z922VF2XMjc4Z7Dusm7AB87B6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/R6oepq5akFNVbcRGz8iP2b/yWTlk4TQemICEVKgZyUeqK9+
	uU7qdqflmMv+NhgFMOOkESkhbhnkOLhjr00uRngsD1ZzH/PoqTEktfzfwSnkL0dHwAQUbgUfLR/
	e8yb4AfKSUPlCm5Zyg2cT7rmHnmKqnFuAbqgL
X-Gm-Gg: ASbGncs+HG3JyQPW4lq0O1hMzHQM4xRVk+GNaZJqRr7sQYldkgmFMQ1RcK7cabn5Pv8
	wqkyfm+5BNFvEC7PIDZEpKQIUGuHj/IMVTULPqFIoPK21cQWAK7vvfTZbguILQ4JDFDoM/IdCpm
	EwdQUrIzI3gT+hgvfucFnD/w==
X-Google-Smtp-Source: AGHT+IGLmFFovthkCzz9zBGQUgYH6D8PODA4GkT138VS1bTfJxT4nmfLax5WnRDWztoeEsfK8XQd5OQOr2/L7Vnjktg=
X-Received: by 2002:a05:6902:2849:b0:e6b:834d:f0f5 with SMTP id
 3f1490d57ef6-e704dfff761mr1728571276.39.1744338664834; Thu, 10 Apr 2025
 19:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <202504091641.738FECED@keescook>
In-Reply-To: <202504091641.738FECED@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:30:53 -0400
X-Gm-Features: ATxdqUFcx8JbctC3F2mPuvKMKmLPfNyuoiYJRtlnAQbggL6SjsGiuCMVstB_u88
Message-ID: <CAHC9VhRZqdrzkiy9CrK+a8GT+vToymU75kH64fP7XOnp=76nYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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

On Wed, Apr 9, 2025 at 7:42=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:05PM -0400, Paul Moore wrote:
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

...

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
> > +
> > +     rc_tmp =3D init_smk_fs();
> > +     if (rc_tmp)
> > +             rc =3D rc_tmp;
> > +
> > +     rc_tmp =3D smack_nf_ip_init();
> > +     if (!rc && rc_tmp)
> > +             rc =3D rc_tmp;
> > +
> > +     return rc;
> > +}
>
> This retains the existing behavior, but I think it'd be better to
> evaluate if the init_smk_fs() call can be tied to the fs init hook
> instead, yes? Then no new helper is needed, etc.

When doing this work I spotted a few LSMs where I think we could
consolidate multiple initcall types into one (or two?), but there was
enough in this patchset already I decided to leave that for another
day.

--=20
paul-moore.com

