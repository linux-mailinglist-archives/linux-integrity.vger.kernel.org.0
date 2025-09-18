Return-Path: <linux-integrity+bounces-7160-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB80B85BD0
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6731C24933
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB592F616A;
	Thu, 18 Sep 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZAtRkFSP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F02264CB
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209953; cv=none; b=riLjRWb6NVoKLLdY3kohIBMyy2hh2rRUnRT3gxze8uU/AFW+3OgeOpjfytTa24H65zhos9J1Negw5bi3clZdA8kiYRyu78MUkBR/VWiQhJUbNLm4mRQkBOaKnXrjKH4vyMjXPmdiF65i7C4Y3dxNU2s+ZJ6oDRQ3dTMfhXd/Hwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209953; c=relaxed/simple;
	bh=l+CHzfhzTph9TC1j6Luy+Ow00xFATk2QnuE2sNI8HvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUhTf3/+dB5w+IKQTtwwxpHNB/nO/HPElWMUzUPpUjC61i6hsyy4pRV8TK/EHIs1xyrIzMo3LBZxPjL63bV1GECRCc/k8W9sApWDvgsg5SATrjZ38umN7Q4iVcYsI7QSp8wcpyNGZ/9EurHlzlj8RzKsXr03iEo9J0qlPcWquv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZAtRkFSP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77b2e3169dcso1506533b3a.2
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758209950; x=1758814750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r97KKGYMsHeXRrgZiOGNJu+AOhAt5WoepEoce/7wW0=;
        b=ZAtRkFSPf5ojJtW5ChBGUbvS+ay7iIPvOJudujNeN5AvH3CWRJlB/z7qFqCvog+NKI
         hzY7GO8FBHC+YHd5byMPQA82ZFA05HZCZaKJZ2eNWv8yTBXxJ6QIqgLvoft56+yWgGwN
         QSGtNF3QjWl72RnbslNjbsC+z+17hibmiXjlc3izTf2eJ92Q3mX2iIfPdrxXnZGSR4lc
         XxbpE8SaEkYOqsCSD8qKSHrZID/P+1bF9o8mN+LHnQjzPjjGUBGWsgX9rpx28Il5fzem
         i7f61mCGFRktj9xSM9JPo8G0iSm5q0vY1tMX8ME3r+WZCu/KOBU8yqfPIZ0hO9SLj/7H
         QC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209950; x=1758814750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r97KKGYMsHeXRrgZiOGNJu+AOhAt5WoepEoce/7wW0=;
        b=eGOgIbK3ZXAh9LWEYHM6OJF1ScmhbG+iP6IaJImDCV/k42M3zbtua04YIuBmYX9eo1
         oBF9jX/Ib765JKBM7+4WPm99yNxyAsxq4SYpe27DyKuXN670/MdIGpNpt+IWd0UI/LSa
         fiEOit8+Ep/lHcwpAdtnf7Rn/xunNlwPuuph8fgsv/JtBl8uvUEMaQuvM5CDcBkPy16E
         igf8FI3aYTatGt/zVLB4a4WD2BLmSgVwrre+tn9Y1YfKddTqyyJOFHU/NcaXq7EA0Fr7
         q5aZQa1UfSlw65Tfq3QqyglCwSGnWuQy5hFPdZgHOk6S5cNniVzUB/fAUmHhkxfnHzaL
         78oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXwp1jgcksRrLoztpN3iWYx/tuUpL2matMJrS82tvyyke5c0WHlmqb1pzHQSl9NlXfjL4EaZLOWXp4T6NPVJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkyQSV0AeT2+fIyqDwwa9Ne4U1v/qJOU7j8oDeX8KJ1J3c/GV
	UWtJ0sRtN6mv+729iK8uO9mQpBsZ/e4/xGszr8JHOLHc+7QqNnk2qA0ENO5rNSRnqy6Ljg8O16H
	E+dwk7uU93nZsDUoCV5WOWBs9X7hjRP6ugMBo3m4N
X-Gm-Gg: ASbGncsN0hJaGmEVWgWzDTxAB2epCzJ2xuQtBOSarwIcvd8TLj4S3m8Q4H+D/7SGxsU
	vj3Xjfa+qTPaJLN7+IKvonh2ZQQHHV4g1IlyNjYgOqwNebwtUesQymKuQgEDR/JpD2DdnHan0UA
	Tc2ILRE7ygU8SAQRS88ORKQwkdB2l9/xod+osdd/07UIxRY1WaunKMjSAOpK7YjIdiAh+UoJkN2
	mBJ1uGf96CSZ6O773k5EAsA+g==
X-Google-Smtp-Source: AGHT+IElmkij4wYopIn8UrpgdMTCj5k6zUQlBbkUIO8IyLnCWwFl7MhD5rIB7cKOXRm/+Dj0xrbvWGIatYmEZd7kYmg=
X-Received: by 2002:a05:6a20:a10f:b0:263:81aa:d613 with SMTP id
 adf61e73a8af0-2925d4b2bcbmr37354637.22.1758209949741; Thu, 18 Sep 2025
 08:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-51-paul@paul-moore.com>
 <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
In-Reply-To: <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:38:58 -0400
X-Gm-Features: AS18NWAHpIkWgt5Zhht6NQrhgyLZn1uDjxVxDej5yO7gbsbueflErH6ttnEljyU
Message-ID: <CAHC9VhSxookZfVQhDMdrikmFrk0VoUhEwMx0FR5DS3JfK_MY9Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:30=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
> > consistency with the other LSM initialization routines, and also
> > do some minor rework of the function.  Aside from some minor style
> > decisions, the majority of the rework involved shuffling the order
> > of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
> > LSM_FLAG_LEGACY checks are handled first; it is important to note
> > that this doesn't affect the order in which the LSMs are registered.
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
> >  1 file changed, 37 insertions(+), 45 deletions(-)
> >
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index a314484d7c2f..7b2491120fc8 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info=
 *lsm)
> >       }
> >  }
> >
> > -/* Populate ordered LSMs list from comma-separated LSM name list. */
> > -static void __init ordered_lsm_parse(const char *order, const char *or=
igin)
> > +/**
> > + * lsm_order_parse - Parse the comma delimited LSM list
> > + * @list: LSM list
> > + * @src: source of the list
> > + */
> > +static void __init lsm_order_parse(const char *list, const char *src)
> >  {
> >       struct lsm_info *lsm;
> >       char *sep, *name, *next;
> >
> > -     /* LSM_ORDER_FIRST is always first. */
> > -     lsm_for_each_raw(lsm) {
> > -             if (lsm->order =3D=3D LSM_ORDER_FIRST)
> > -                     lsm_order_append(lsm, "  first");
> > -     }
> > -
> > -     /* Process "security=3D", if given. */
> > +     /* Handle any Legacy LSM exclusions if one was specified. */
> >       if (lsm_order_legacy) {
> > -             struct lsm_info *major;
> > -
> >               /*
> > -              * To match the original "security=3D" behavior, this
> > -              * explicitly does NOT fallback to another Legacy Major
> > -              * if the selected one was separately disabled: disable
> > -              * all non-matching Legacy Major LSMs.
> > +              * To match the original "security=3D" behavior, this exp=
licitly
> > +              * does NOT fallback to another Legacy Major if the selec=
ted
> > +              * one was separately disabled: disable all non-matching
> > +              * Legacy Major LSMs.
> >                */
> > -             lsm_for_each_raw(major) {
> > -                     if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> > -                         strcmp(major->id->name, lsm_order_legacy) !=
=3D 0) {
> > -                             lsm_enabled_set(major, false);
> > +             lsm_for_each_raw(lsm) {
> > +                     if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> > +                          strcmp(lsm->id->name, lsm_order_legacy)) {
> > +                             lsm_enabled_set(lsm, false);
> >                               init_debug("security=3D%s disabled: %s (o=
nly one legacy major LSM)\n",
> > -                                        lsm_order_legacy, major->id->n=
ame);
> > +                                        lsm_order_legacy, lsm->id->nam=
e);
> >                       }
> >               }
> >       }
> >
> > -     sep =3D kstrdup(order, GFP_KERNEL);
> > +     /* LSM_ORDER_FIRST */
> > +     lsm_for_each_raw(lsm) {
> > +             if (lsm->order =3D=3D LSM_ORDER_FIRST)
> > +                     lsm_order_append(lsm, "first");
> > +     }
> > +
> > +     /* Normal or "mutable" LSMs */
>
> Paul, there's a reason for another set of eyes reviewing patches and yes,=
 even,
> comments.

Mimi, if you've read my emails over the years, or discussed this topic
with me in person or off-list, you'll know that I almost always* hold
my patches to the same standard as any other contributor; even in
cases where I know there is likely to be no review beyond my own.

[*] There have been exceptions in the past due to build breakages and
other "critical" fixes that need to be merged ASAP, but even then the
patches are posted and subject to review and additional
patching/fixing afterwards.

>  What are "mutable" LSMs?!

As the "or" would indicate, they are "normal" LSMs where the ordering
is mutable, as opposed to the "first" or "last" LSMs.

--=20
paul-moore.com

