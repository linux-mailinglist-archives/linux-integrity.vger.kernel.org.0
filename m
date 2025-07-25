Return-Path: <linux-integrity+bounces-6729-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3659B11535
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 02:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA65E581052
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 00:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D3341AA;
	Fri, 25 Jul 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL95pT9n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064E4502F
	for <linux-integrity@vger.kernel.org>; Fri, 25 Jul 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403183; cv=none; b=Imv3KD+tVvHSVpCpDjomXR3VFUbWEyqfcDYMdbE2iMMRid0eztsdTgIYO+UpiWBDyDmn7JX1I7Khx2ChXZeHXX9+cHbZGYyPxriz9/vAhqxU+4Ej+pKWRLTQ30bqmFRP2ONBOY56kXYxXgb5DXGu5JuPIQJe7H5fBInD5K1jGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403183; c=relaxed/simple;
	bh=l6KU0Ym47gpo/4+gkXeck9uuSdoJ+qGh859kPbrOGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzj8R1c3KuDFZx7tgZ5rSDqdTeqcnaypjR8MrdiK47lvkFR4Mw6XiyA9dg+1/plRLj1a9qwLJ2jLgTfmQK+3GT7G2KaCcUOXcoVmDA4q+5osoLNGanpWCYTx9ifdOqJldBES6Q08JktOPS+pzpKitsxoSDJU+FeAoyLlI1Tnfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL95pT9n; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bd2eae9e0so1421059276.1
        for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753403179; x=1754007979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=QL95pT9nNEUuLj5YIn8J968lin62mEs8NsAxep0uc80xD58yjg+QAEu0hyVdff3bTy
         2V+TuRY/rDd8wCtME6VGwi++mN5YN8mdlqF2yhJwHsB9pej45Mksj1JdjPGFzQqwt+xp
         GZFjNl6++t+OD/gKZdk8ZLSLMKKIDDMAMZ5ugpO6n3j/AXc9h1/1NyN7PLJMtaKWpezX
         QyhWbS5TSEEDlidavpE0MMKwQfZ3ZKBJuosFgjAjePOUNSMM31MQvFRPDDjiN34kRRvB
         Rmt5LJpNbDTTwOiyQaiUmWvwjiPWGTIUKjhiG8tXsEZeEy5/Hq7R0FAwQIyrYSdR1ljO
         17cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753403179; x=1754007979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=sunBCmME5PRQEcYuG4Duuej4wW1lFac5yHw3uEvswKZDgboxmmDvh4bc/BYcB3NqaG
         n4jdQHZmE8g39JfAg4Dh0lT+8Ddwj2BjP5CNa+s848cD5YAGYuGVb66iQHdXva2Fqlej
         TZYNAorV9+O3M8UUPYuSY9oWvFYnJuOIxEofInvjfSg/giXMh+uhKbIfATFIjDhGDXVh
         ND50pDM/nayyDKVCcQJUJLlDG3aT/JdMYyiDl2fRbK2I0YVTgV8zNSpw6EpgjxMYKHOf
         lyAnX7FGuS/CSolnBfVzxXcaQnJYBvjwLk1PkIraUBiECWorAkI54m8AKFGoXnDOn0CW
         iRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUgucjyjkSytB+X0qf3dQRwJnmeqjYN1Z4jbrTCSrDkEsNFveGgKRe7ZM26ArtdIGZxBRVUQm2UZaVSxiqPU1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzewNqj5TZHW//QPGlhO+4pA+LawpX+BsR5g7+SS5uHyONxgvPE
	0YAj9duasLTMndDJBuDX8ZPwGM3+rE0+7atsBiQV4nfKJdmftlYOwMbyo/ax9YnuDCCeAOAX9w/
	iHUlrL4PgXKgJwaVdXBmgqn3kEfGfNKxXJaXWMhN/
X-Gm-Gg: ASbGncvghdGqByaAwlNflDVMe3GYxJtPrs2+S+3RiiPjc4lDT0NYb0Ovl9lstKTpLqY
	DVPJMEFcXmLdcikgUXpQdepor+hxMNqPmP9Dg56yYU1vzJQuH0F8QcbUjDdxx33tQD2/5O+xgwD
	N5Sta3/1exreBcGqyDI9l01z8wy1+KMHEzMD7rz0YSjXklJleu0dGPbUMKXrql/ekO+D4Hi8PeJ
	gqOjVY=
X-Google-Smtp-Source: AGHT+IG4xX28wZoJE5JbFJ1OTlVa2IhSG6LUzyalZVXihO1W5jvkr82mHUzmVqX4OTGOr9Xttp4WAF0/MiDAQgFmyD0=
X-Received: by 2002:a05:6902:13ca:b0:e8d:ed1b:3186 with SMTP id
 3f1490d57ef6-e8ded1b3c48mr1253952276.39.1753403178849; Thu, 24 Jul 2025
 17:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-46-paul@paul-moore.com>
 <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
In-Reply-To: <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 20:26:07 -0400
X-Gm-Features: Ac12FXxzx9eoUQimi8ooqCkQhXmAgNy1LksHgxSM-xb0VeXwFZGGkkiSgXURJwg
Message-ID: <CAHC9VhSV=e6aM1raofn-WWRJLS8aMYxi9kEsmL4BuTWLxXWLvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
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

On Thu, Jul 24, 2025 at 11:34=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/21/2025 4:21 PM, Paul Moore wrote:
> > Move the LSM active count and lsm_id list declarations out of a header
> > that is visible across the kernel and into a header that is limited to
> > the LSM framework.  This not only helps keep the include/linux headers
> > smaller and cleaner, it helps prevent misuse of these variables.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>

...

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index cbdfac31ede4..03d3e140e0b1 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> >  static __initdata const char *lsm_order_legacy;
> >
> >  /* Ordered list of LSMs to initialize. */
> > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >  static __initdata struct lsm_info *lsm_exclusive;
> > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>
> I can't see there's a good reason for the reordering. I'm not
> objecting to it, but it's curious.

I'm pretty sure this is one of those things that came about while I
was upset with the state of this code and was going through it with a
hatchet; a lot of code was ripped out and put back, so it's likely
just an artifact of that.  I'll flip it back around.

--=20
paul-moore.com

