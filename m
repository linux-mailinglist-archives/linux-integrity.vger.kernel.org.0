Return-Path: <linux-integrity+bounces-6733-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F40B1223A
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA697BE3FE
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161B2EF282;
	Fri, 25 Jul 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L4jAhkKB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5632EF28E
	for <linux-integrity@vger.kernel.org>; Fri, 25 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461782; cv=none; b=hSdfKqX6/eSHuRN/gja6ns7o+T13k4SR1wcqsWN7OjgnS9zVtpJ850X4VYbbkdgu+XMfIQd8ntxqT/Nni5l+QQtqcSNE8DHNf1VbjD7twYHEFF6C4AIVOuPO7Zh3sIVVnXaTTsblx9zhhyPLvemw+peh61FWczXbBGYeSq1iGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461782; c=relaxed/simple;
	bh=hhtlTKXXECi8yi5iXycyKR9shLCwOKiYr5xEdB0jQpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INIeqBVE+IhWwmtFKGsa275omzKxNGurV97gq6u25jkOPPHQlX96utpHooPlvWVLEpDhJunY2nwZaLWwMaWeD6l9RVJD3QaC8gIGfmwAX8Gv/tjv4jgn7AaGSVe8hl6MUOaxQ3BsMxtaKrMT119ZJgbxSLFG+FTb+Uk2XLy/Qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L4jAhkKB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8d2c331bb5so2634792276.1
        for <linux-integrity@vger.kernel.org>; Fri, 25 Jul 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753461778; x=1754066578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJzRqhe+x1DhI6Hy5VLKk5oBTrst/YcQYkVXjLnnM6c=;
        b=L4jAhkKBoJMuMXC9u1RsjBdJG7LPDmsUParFxp7tg2e951gGEBiypKbYWYA3C+5ERg
         3d0hupBGQTEfzoxQnTTqo7vq9dYZyYPQjt9c7rLMb6w/Gt10+jaKamR0bDeG/VVeXQI7
         T18xrTnnIZT0k7/GTymY6bimvCfa6/ccFYt+x5C+qO2O62TmnKWMB7o8R2BzHG8olMeE
         bPU1JZCla6S0UBqTKR3ghgpJlzvh851wBNIMmEf/GnnwAXZ7p/K+GvN3F+SNLh9MXgdh
         vYfHO+s7L/rskIXo+s7gdnhN62PNcNnu09CIsliUHngJGcs+/aBOD53iNySU/Tui1U75
         D86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461778; x=1754066578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJzRqhe+x1DhI6Hy5VLKk5oBTrst/YcQYkVXjLnnM6c=;
        b=s6hDju+lKA+C0ffeekVCPPhjkuCMU4X/vBeXz1v3um0iktXUgZa7rujYlN5lEy+7hj
         K9dDOBkkblgU0imhDbuS4LK1PKTYWGlcDqq6mG9D6WvQeSL2tkwvlIQHSg+jSBgRIu0v
         DrH01HGmtGMutNMUYgmkAM3WKQKycywbHA5UXPgVgIySN6Q/Pr6wMCSooM3kYGnrPDTL
         WMlXJmrk+/viJcGjXC6GPDRmb3kBRVBDTLJb2p1GdajfqkW5gfJ5z8Cm22leedfsLMgl
         6o494U7VZdxrCnciaDvLvRiJoc+EzIABhzdjICljgEQEunfIOdC2o8672pQPFEumicO6
         Ggkw==
X-Forwarded-Encrypted: i=1; AJvYcCXliA9lvdTWSKt4BqzjbvdzjoOwDZwmEXmaQCq1MOVRG/AXxn7TTttGTW6efqciOmbGYAoMhnCTmXWuTe5DRBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYtXBavc5TLK4YWn1J56VrnWZ4sUdoYgF/klmsy/zy6qTNQCk
	BclpxrfrURiWG0kOWYs/w63pil6l8KZ6w7dnbFt62R5zyXclZDQ5S3fN8ytljGqLHbItLHaD5sM
	TkYX5/+EnbVyRxzxpVZ+27RJX8iiw2Eg2/8nw9x3T
X-Gm-Gg: ASbGncua2hQEuYBKleFLLJOMuiTkSpDrlO4MPXBBGpbm9VkwIB536EyMmpPyvJ449XS
	z2pCB79rN3ehCeZG4eYJ+HLXOQ+GXEFXlyBZzf/d3Pa4X3GWlvjkwb8V+ibcrWae6ZKTGnzgesd
	tXcnOlufvgxilsPk2qCNmSAUT1G0un67iZUbuNhCG2Aic9j9BLD11mEIqx//rQnlNNl6AiopshB
	gYMOH6/2oKjuIb7sA==
X-Google-Smtp-Source: AGHT+IF1faD5g6+XnhuNEv7CBYvFQPNcZ+LK70Kcbf62OUhg6COOmvkNfui8ej3LxKAZeu2xE91uB+0DguYnF971Bic=
X-Received: by 2002:a05:6902:18d4:b0:e8d:7904:f065 with SMTP id
 3f1490d57ef6-e8defb397acmr2712573276.15.1753461778426; Fri, 25 Jul 2025
 09:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-47-paul@paul-moore.com>
 <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com> <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
 <6621fbb0-fb66-4aa0-b77b-1cd0db195660@schaufler-ca.com>
In-Reply-To: <6621fbb0-fb66-4aa0-b77b-1cd0db195660@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Jul 2025 12:42:47 -0400
X-Gm-Features: Ac12FXzZH4VsZDsAGPbKQw8Kv6dIfR7tsNmxsQ9bEltpRC2GFe7Nt38l4hGhaAY
Message-ID: <CAHC9VhSdLO-TdMp+oZjxb-jzuqoQX0sD-84G+SoqNwn2i3VZaA@mail.gmail.com>
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

On Fri, Jul 25, 2025 at 10:27=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/24/2025 7:28 PM, Paul Moore wrote:
> > On Thu, Jul 24, 2025 at 11:39=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 7/21/2025 4:21 PM, Paul Moore wrote:
> >>> The LSM currently has a lot of code to maintain a list of the current=
ly
> >>> active LSMs in a human readable string, with the only user being the
> >>> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> >>> generate the string on first use and then cache it for subsequent use=
.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  include/linux/lsm_hooks.h |  1 -
> >>>  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++=
--
> >>>  security/lsm_init.c       | 49 --------------------------------
> >>>  3 files changed, 57 insertions(+), 52 deletions(-)
> > ..
> >
> >>> +/* NOTE: we never free the string below once it is set. */
> >>> +static DEFINE_SPINLOCK(lsm_read_lock);
> >>> +static char *lsm_read_str =3D NULL;
> >>> +static ssize_t lsm_read_len =3D 0;
> >>> +
> >>>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t =
count,
> >>>                       loff_t *ppos)
> >>>  {
> >>> -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> >>> -             strlen(lsm_names));
> >>> +     int i;
> >>> +     char *str;
> >>> +     ssize_t len;
> >>> +
> >>> +restart:
> >>> +
> >>> +     rcu_read_lock();
> >>> +     if (!lsm_read_str) {
> >>> +             /* we need to generate the string and try again */
> >>> +             rcu_read_unlock();
> >>> +             goto generate_string;
> >>> +     }
> >>> +     len =3D simple_read_from_buffer(buf, count, ppos,
> >>> +                                   rcu_dereference(lsm_read_str),
> >>> +                                   lsm_read_len);
> >>> +     rcu_read_unlock();
> >>> +     return len;
> >>> +
> >>> +generate_string:
> >>> +
> >>> +     for (i =3D 0; i < lsm_active_cnt; i++)
> >>> +             /* the '+ 1' accounts for either a comma or a NUL */
> >>> +             len +=3D strlen(lsm_idlist[i]->name) + 1;
> >>> +
> >>> +     str =3D kmalloc(len, GFP_KERNEL);
> >>> +     if (!str)
> >>> +             return -ENOMEM;
> >>> +     str[0] =3D '\0';
> >>> +
> >>> +     for (i =3D 0; i < lsm_active_cnt; i++) {
> >>> +             if (i > 0)
> >>> +                     strcat(str, ",");
> >>> +             strcat(str, lsm_idlist[i]->name);
> >>> +     }
> >>> +
> >>> +     spin_lock(&lsm_read_lock);
> >>> +     if (lsm_read_str) {
> >>> +             /* we raced and lost */
> >>> +             spin_unlock(&lsm_read_lock);
> >>> +             kfree(str);
> >>> +             goto restart;
> >>> +     }
> >>> +     lsm_read_str =3D str;
> >>> +     lsm_read_len =3D len;
> >> You're going to get a nul byte at the end of the string because
> >> you accounted for the ',' above, but there isn't one at the end
> >> of the string.
> > I'm not sure I understand your concern here, can you phrase it differen=
tly?
>
> "lockdown,capability,...,evm\0" You get the '\0' because you always expec=
t
> a trailing ','. On the last element there is no ',' but the length is add=
ed
> as if there is.
>
> +       lsm_read_len =3D len - 1;
>
> will fix the problem.

Ah, yes, gotcha.  Thanks for catching this, the fix will be in the
next revision.

--=20
paul-moore.com

