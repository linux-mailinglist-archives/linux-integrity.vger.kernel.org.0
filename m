Return-Path: <linux-integrity+bounces-5810-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06EA84FC4
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8605B4A16E7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D11FC10E;
	Thu, 10 Apr 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBCRfGKZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540581E9B0B
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325247; cv=none; b=eK88P7n/EbhQUh6cb1fvyEzIDErby7Z+ZVOiu3u272vWGyN3RxhE6aXZpgPGK3UXEMcE4xaT0TiWSA4Imc2AjBKpS6GwxsDp3QziGU2glVef7VKfSSiX8rRXXtA5wodH/NGhswzyHAUAZCJUaybuZR1ATRjxKn7W8JUw6b9tQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325247; c=relaxed/simple;
	bh=t0WHWF9UD1DRoY8s+UFJorlWHrn+kwq7FR9h9tDwLbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i81RivntL1GmxJV3/ISHdV0O/fRNSd6ooelp+q2R3jus0VcBr1G75alyIt2netHnicocDpSoN6F0wJn61AGvVKcgH51Upo1JZ//Wm73fLeIusTvY/9UW7HRBspMZ1HiEnlDvMBaVfEWMUmI9Arm3Iv7sYQNG7NzBCWqqkafqkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBCRfGKZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6febf391132so13174057b3.1
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744325244; x=1744930044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4baDOK+hOnqwwRvcq0Pn8YBJYVT7qAO9stCuIJlFccU=;
        b=QBCRfGKZ8Q2nF6vILxn8gBd26JMRe5mdu0/0y0Y48tfKlRnJiwOJtrHkVGzCs8pU/q
         7C6kQFy0tCYukxeP9HUJxQcCCsfK5LGdltmoH+fD68RoDUmEUUxphHkDnscPnnZXfJUV
         6A6+2POZBCoZbW8qedT5rZqZVuvmUxWYIcZDl13fJ/AkGswNOAuKTLocx40E1yYz30Zw
         9+YJJ4qK/Lwo/OFAjONG3cPRlGJT0GFtEYmntWiemRWohh9iykpCcH0V3u744fSZQoGl
         KgqI8Wpw8yf1T089P1DKysTHn/4sYtDG+FktKz347q/Dpn8v+/3EHustnFwQS/XoqXrN
         d9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744325244; x=1744930044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4baDOK+hOnqwwRvcq0Pn8YBJYVT7qAO9stCuIJlFccU=;
        b=VyY4NvO9HVmJ6Eeyerl7NRNkUc9K7ZwLLOZHh5C4zG4ZzUcU9W8rCMGmuQjfA0fe0M
         Les433Mt3x2ZzhpNg7Dc0HfFYF6VtyQjMx88cKBtjQnJPImVodct37VeUA7wHGYv2ytB
         oiMgdxKABR77+uA6LerZbpf5vF2ODeCBxt+iVzEfSLFbSystvhDOpYtvfzALIP9QrC4s
         JTC3ZRiRlBDxX5kkJQMKAzfZQSD0PlQXc6yBcyatWrAbAlc2lFO19uAxsS7/c6I+IXmx
         Umi6ZOEkPEfDi07FsF284cKj/Mvs3XPQq2T3kGNIn4yf4Cab3NJBwkAFoPn2xjXxJyIB
         z6eA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrQp4y4yF15H3SJMJ43u+MsDf9f2zvoDiSKwAymZZzQoJz6RYDt0HjwM5BQH4+den6V97QkCMeeK1VH8sExs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCa1I9szqoTRMFvf4ty29NHzvoCzvidFRtIJ/SItuR8+aE2b9
	oyPTTwaPoI2+uEqy0mIkrunb+pzhoPSkJQ97ZYhRv5KrtmiMGFuMiUebDziw8pW9jGFBCvZdeXu
	qmgsab2v26ZLhL5K7OrMRXZv7AlWNyvMN+5Ub
X-Gm-Gg: ASbGncuC/3vfTOPzUyWGIyllC+twV7dopmoKHjDD9c1wrbNb/QZFEyYpUGBs+MH6c31
	lzw9TvQN4j6E6vWbIajgAC7l9S0KNbvis5OoXxO/EMz9PkWNerhvIghU5DZ+AkdZZKIVr6xDs0T
	48GReQlTN1tfWkKGXMp7c+PC7BsmXTVYCU
X-Google-Smtp-Source: AGHT+IFgcMp7/WMc+kqP4e3WnS6Fg1zzj4n+C0a8bspl4n4V7LCbv5x6jMxmdOvw76kxObafg2bPEM2ljqeu7CQkIjo=
X-Received: by 2002:a05:690c:6aca:b0:702:4fd1:aff with SMTP id
 00721157ae682-705599ea13dmr12334217b3.20.1744325244291; Thu, 10 Apr 2025
 15:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-39-paul@paul-moore.com>
 <202504091607.0A394D5EF@keescook>
In-Reply-To: <202504091607.0A394D5EF@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 18:47:12 -0400
X-Gm-Features: ATxdqUEutKgeD2WmDngbQutC5jk-ZnYZE3BJM25bNgtT7teaIomg7a1L8VFk-FY
Message-ID: <CAHC9VhS4nB2xV-zw+=eN2MYaetvCkParammXn1fPGsm-wuHtTw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some cleanup
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

On Wed, Apr 9, 2025 at 7:13=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:49:53PM -0400, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the
> > currently active LSMs in a human readable string, with the only
> > user being the "/sys/kernel/security/lsm" code.  Let's drop all
> > of that code and generate the string on an as-needed basis when
> > userspace reads "/sys/kernel/security/lsm".
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h |  1 -
> >  security/inode.c          | 27 +++++++++++++++++++--
> >  security/lsm_init.c       | 49 ---------------------------------------
> >  3 files changed, 25 insertions(+), 52 deletions(-)

...

> > @@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
> >  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t co=
unt,
> >                       loff_t *ppos)
> >  {
> > -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -             strlen(lsm_names));
> > +     int i;
> > +     char *str;
> > +     ssize_t rc, len =3D 0;
> > +
> > +     for (i =3D 0; i < lsm_count; i++)
> > +             /* the '+ 1' accounts for either a comma or a NUL termina=
tor */
> > +             len +=3D strlen(lsm_order[i]->id->name) + 1;
> > +
> > +     str =3D kmalloc(len, GFP_KERNEL);
> > +     if (!str)
> > +             return -ENOMEM;
> > +     str[0] =3D '\0';
> > +
> > +     i =3D 0;
> > +     while (i < lsm_count) {
> > +             strcat(str, lsm_order[i]->id->name);
> > +             if (++i < lsm_count)
> > +                     strcat(str, ",");
> > +     }
> > +
> > +     rc =3D simple_read_from_buffer(buf, count, ppos, str, len);
> > +     kfree(str);
> > +     return rc;
>
> Hrm, at least cache it?

Are you aware of a performance critical use of this?

> Better yet, do this whole thing in a initcall after LSMs are loaded, and
> both can gain __ro_after_init...

I *really* disliked all the stuff we were having to do during boot,
and all the redundant global state we were keeping around.  I'll go
ahead and cache the lsm_read() result local to the function but that's
probably all I'm going to accept at this point in time.

--=20
paul-moore.com

