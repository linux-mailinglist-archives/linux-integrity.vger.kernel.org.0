Return-Path: <linux-integrity+bounces-6730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A1B1166B
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24A63A3869
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D252376F8;
	Fri, 25 Jul 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WHRR0his"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6B236430
	for <linux-integrity@vger.kernel.org>; Fri, 25 Jul 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410522; cv=none; b=SNof1pJAJXnyMvgdOYeuWaVtXD8PZ2MhzJbM6DM7TgskdAFL/CTD518MvutiUsRd0Ozyx1vLwzpH9562XS4HMYKPa+DzhjjQM8pI8zXJnFf8t3SeRP8C6LXIjYI9MEzubACucNbslxesHCOOmygdDg3F8qIRSDT8/kaCdUYh4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410522; c=relaxed/simple;
	bh=GAnMHTlCdd99u3tfdAsMu7FC3xYg7vAJjeLv7IlrUcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBBZAV8BChDZ1CvC2+31T2EuFuZsROSRyAsG2Ko9N98XsgIN/mUvj/5NI1tZOVlUve9Ke5n6Dx81IZ+yU6k63bhOb44nj2O6mp7rwaQPnRUxw0Sjqxd4A0ixtXqN/BHAiEOM3II7joKIw49x/dMz+THvjLBfmQZ4mpyjWQn/xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WHRR0his; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso1509585276.2
        for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753410518; x=1754015318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76kf2nT7BLoBgPFUTjrSe3BF7zBjdFtl9axEtNhkDAA=;
        b=WHRR0hisT7/TjHIoZrAL5ykqISRi1UTWMPFxYKm02upcVH4TmoYfa5/VcA+IZlxa18
         6DUDWbUaQrMtj5RyPJN4AS+W9msDkwmfW7Cxvw95ZOWpJpXbG+HYVUTT6SEl+ofgueaa
         PSPGxzuEYWfhL92ApJ7LIxp2yBlk/GAvghq+BDLGj34ZoM++ShY4sdPDw3DPpLoAaKaZ
         HPzdCXZt73+xO/M2VTV68a6msiBxqyCjrR+oC6EVf9IbnY24AqbZr3aYH/doIJNwUDlw
         87UGPU+ZInJQf9anHJUoT18AhTVbggBRB5J3NCra1fzEM3pQMRryiMOU8oB86QHafXaQ
         sFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753410518; x=1754015318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76kf2nT7BLoBgPFUTjrSe3BF7zBjdFtl9axEtNhkDAA=;
        b=Rl3h9CILuOnlvWtsB+bGTC151UaBONEj2P+ay0Ar+afrDsR6siG5ZgmiocZHe+EkV5
         j4WHhsFTjIRGKnzaZ3yWYInf51UllmnzdghdqCaDlGE+GIXovBO8aUDnghdMvwOhkBdE
         /F79YKIJxEec71wvLcV4xaI/hZvhc1zuzV5GDJ51M/6KIWnfUlvFe/UtZ+nBi2iDg0V8
         j6cn60OaUW6vHNjhuqJ6kMxvEWpRNqYC+gI+EzdwZYfqvrPzVZJeXXBQV5fm1oXhNYaU
         bDNM3T3EmGvc0P/hek19oCyZGiuXDc6JCYtpvCGGGtKX+TZfmgGLrkDiaQSWKujVuS7r
         Z/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc9Ew1Dpx/0XVF4wnE630i24wmHS3KhfHqZviU75osl4jBQUXr+PFml+4YnZBu1MeRGe5HHsJXpV1G+zUcz/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqFfIWiH9EYJ3P+NnEZxDWHnUOPjp0/CfEzcWogluS4dXnPy/
	LbupBZVCFnIKnhyvtvmnVt3vDPE+VKu0i4nWiW07MmCinvleNYuPENrxGf8+gzI/9ItDcJG9Rx1
	wBuptOkY8YuhkCebzzk0DWXytHovyhzPWNi8P4tK7
X-Gm-Gg: ASbGncvTNwN/7JTQk+x9L8VOuHBEIZj1hJobYqbRI/RX+GkSLwl93pjVXWr0xocNPfb
	IyO5gdU8/YMN/2db64hlg74rTLwBsGBgbxsymQajnixVuMfESTsDvZKTKFI+pHwskMLesfIQwPv
	qznbvOKBm0xpfzwTGzg6+lYKeY/SRZKVczePiPVmYLDNKC/E3hOIbuisrUOrsW/zdMzPcLO0Bci
	m9XZ6o=
X-Google-Smtp-Source: AGHT+IEJ9GccTLafI+eecGRlClmMtuHE2kwpnWx8W6YsYJWnDUno+dKKfkfNq2iUaGnrMXJN6U+a7Y6k027a8lR6STc=
X-Received: by 2002:a05:6902:12ca:b0:e8d:868a:bae1 with SMTP id
 3f1490d57ef6-e8df11147c2mr144468276.13.1753410518164; Thu, 24 Jul 2025
 19:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-47-paul@paul-moore.com>
 <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
In-Reply-To: <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 22:28:26 -0400
X-Gm-Features: Ac12FXyKd_Ubn7_Mym9qREpK7hYDPp8KcVHvLsUwOoojDPjjfmv8o5G-4OtQEiM
Message-ID: <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:39=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/21/2025 4:21 PM, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h |  1 -
> >  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
> >  security/lsm_init.c       | 49 --------------------------------
> >  3 files changed, 57 insertions(+), 52 deletions(-)

...

> > +/* NOTE: we never free the string below once it is set. */
> > +static DEFINE_SPINLOCK(lsm_read_lock);
> > +static char *lsm_read_str =3D NULL;
> > +static ssize_t lsm_read_len =3D 0;
> > +
> >  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t co=
unt,
> >                       loff_t *ppos)
> >  {
> > -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -             strlen(lsm_names));
> > +     int i;
> > +     char *str;
> > +     ssize_t len;
> > +
> > +restart:
> > +
> > +     rcu_read_lock();
> > +     if (!lsm_read_str) {
> > +             /* we need to generate the string and try again */
> > +             rcu_read_unlock();
> > +             goto generate_string;
> > +     }
> > +     len =3D simple_read_from_buffer(buf, count, ppos,
> > +                                   rcu_dereference(lsm_read_str),
> > +                                   lsm_read_len);
> > +     rcu_read_unlock();
> > +     return len;
> > +
> > +generate_string:
> > +
> > +     for (i =3D 0; i < lsm_active_cnt; i++)
> > +             /* the '+ 1' accounts for either a comma or a NUL */
> > +             len +=3D strlen(lsm_idlist[i]->name) + 1;
> > +
> > +     str =3D kmalloc(len, GFP_KERNEL);
> > +     if (!str)
> > +             return -ENOMEM;
> > +     str[0] =3D '\0';
> > +
> > +     for (i =3D 0; i < lsm_active_cnt; i++) {
> > +             if (i > 0)
> > +                     strcat(str, ",");
> > +             strcat(str, lsm_idlist[i]->name);
> > +     }
> > +
> > +     spin_lock(&lsm_read_lock);
> > +     if (lsm_read_str) {
> > +             /* we raced and lost */
> > +             spin_unlock(&lsm_read_lock);
> > +             kfree(str);
> > +             goto restart;
> > +     }
> > +     lsm_read_str =3D str;
> > +     lsm_read_len =3D len;
>
> You're going to get a nul byte at the end of the string because
> you accounted for the ',' above, but there isn't one at the end
> of the string.

I'm not sure I understand your concern here, can you phrase it differently?

If you're worried about lsm_read_str potentially not being terminated
with a NUL byte, the strcat() should copy over the trailing NUL.

> > +     spin_unlock(&lsm_read_lock);
> > +
> > +     goto restart;
> >  }

--=20
paul-moore.com

