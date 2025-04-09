Return-Path: <linux-integrity+bounces-5735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565CA83413
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 00:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F314475F5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8721A95D;
	Wed,  9 Apr 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f88vYIWx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA509215179
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237893; cv=none; b=NVSQ0IK1eKrFO9efA5woNenZRhlPCWI9F+TCtRLxWahGYsQffNJn1A2Xzh6vUsx8lksK6BmrrtaQZQWS9uUBXax7BuusKiza+z+gMwObBm/cyCTHF5qGrAYdS8AhZgj426V/qecYFz82FSnm2khqMTS92MLKFbpbC7zpcZvcTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237893; c=relaxed/simple;
	bh=SWdd9RTpM42vC5ZNMkrzCkNmTgWrjK/TrQBHQAK+k78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMn0aWGibSVZojjqgI2GKPCExKqU0/fugT46pwNFG/WnA2lIoF7+loBRW4TW9XThSt02Ety0PzWWY7QPXjb2dpVGRfeGECBc1+mFQQKxZTc+oHoCPgDGQWMEXZgOpvdJ7LaxKek0VCMaWYauTPm/jjRoxtKB+Wx3VBtBkFfYRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f88vYIWx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7023843e467so2265477b3.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744237890; x=1744842690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4woi2xGlWCHzrCPzebUyPEdkLsFWCOIqQ/998TUZGI=;
        b=f88vYIWx6yMftnd776OavRz+1EofjrnydXgO/syIDFz1ghNDulCEA25vE+/8QaUgTz
         GFR9FTkJ03I6fy1Pn845QnV5CYVOn8n1gAX2CWkA8/ZZ7aQPGml/PSoi5lW47fwSxGUy
         Bgx1lBkxncvLN9Qv3jumcRtx6RegLeOkbA7FCe33D703ojORT0+3Ip9wT3ummy6en2Sf
         Rjoqdu54u+lHIdsIcRU1vF5H9Uw3jpUx8QBcf51M3C9jck/LdF00S564FrLwlGJ47W8S
         TCbaRBv1G64Ie/9tulIuGTFejZkj/Tp/jtLlJ/JJgQVBCNy2nDgQR39CkaJJCBdX6VZX
         hZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237890; x=1744842690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4woi2xGlWCHzrCPzebUyPEdkLsFWCOIqQ/998TUZGI=;
        b=qIIZewLXP5wSG57s0YH/BArV+UwcLWfVYD1/WNHehWtJbmZwXI5pm64G903PDiZRx+
         ZAD8NeAO3sHWCLLiRSzkHbLE8xxlrdBB/l5najvql7FNYBbDSAXBGikvsf9vZaKHQyEl
         7CKx5BGPZFu+rW09n/NVmTLLIN3CGXIu2Kf7r94C5FZ0oiSPomhIRVUYe4KyIE9BM52V
         3wQy+iB8+ni8noHUpu39h/K4rdxgrcQvDm8jtSco3Ret590uf+rhCxwGBuIPCadom+Kq
         Dw4ZzDHiF96+ST0ndnBuyjrOPiu080O7v2OscZ+PrRDRg5U1dYgUoH5hSgHzJhOxXpN/
         8AOw==
X-Forwarded-Encrypted: i=1; AJvYcCUuzudBxKqkOekDBhFYj4qjkRw7IRDgaH6QoxiRItLFwM6vgep+C/fCGHMqCdkmBbqtfHid4SzWpaJovaWg2wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGlOXIEovcnvr3z+D5mWxUq0wOTe9dtniUI4F1iskCIXAgJssn
	GTMc5qqymDKxAgFQKvDjb1d34fNns42L5ppCg5E+3K+mP1U7V9itTbiO8g502b85O6h08+LNCaw
	Ezhn78c71X4RettN6+IkZyaDoN/YuWSMz9hFQDDSWLwxZzak=
X-Gm-Gg: ASbGnct8mxacN3K4ZuUO6UfX+BbCPGUjFIHpJIg11+2KuHC2y4ljmxkdzlom2MUtXuj
	5glN0Lsn/T5d5eM+HzEvlSYoIgLFb3tvxSrwDcxyzl6zs4Qa3bLzFHvWQdyZRTiL97XKWi3RmzD
	vDP2RppcjYzSAUh8xYt5vEYOtqdjaBclv4
X-Google-Smtp-Source: AGHT+IHxj+xJhKVAVZeidbydD08JnIVI+V9xRkPwJ88AD9pQb4gyRiYQ0vkLQ7TS1/g0pr0/pAEfyoXjrdjyN8nC7i4=
X-Received: by 2002:a05:690c:4906:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-70549eccfd8mr9140947b3.20.1744237890543; Wed, 09 Apr 2025
 15:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-35-paul@paul-moore.com>
 <202504091435.E172A67C6@keescook>
In-Reply-To: <202504091435.E172A67C6@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Apr 2025 18:31:18 -0400
X-Gm-Features: ATxdqUF58K2osiGI0aRmIUdrzsTIM0H-CerRYW_6JWr-DyWGlRBbjMVguJ_NTOQ
Message-ID: <CAHC9VhS0Nc_uYMDfmaiQPV9fDwRcB_4wHGvXhEDi0AFpLXeXQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/29] lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
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

On Wed, Apr 9, 2025 at 5:38=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:49:49PM -0400, Paul Moore wrote:
> > One part of a larger effort to cleanup the LSM framework initialization
> > code.
>
> Again, needs a better commit log.

See my previous comments as well as the cover letter for the reason why.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index dffa8dc2da36..407429688f1b 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -32,6 +32,12 @@ static __initdata bool debug;
> >                       pr_info(__VA_ARGS__);                           \
> >       } while (0)
> >
> > +#define lsm_order_for_each(iter)                                     \
> > +     for ((iter) =3D ordered_lsms; *(iter); (iter)++)
> > +#define lsm_early_for_each_raw(iter)                                 \
> > +     for ((iter) =3D __start_early_lsm_info;                          =
 \
> > +          (iter) < __end_early_lsm_info; (iter)++)
>
> The longer I look at this patch the longer I think it needs to be broken
> up into a few separate patches, but they would be relatively small, like
> this one: replace iter loops with iter macros.

Fair point, done.

> > @@ -340,10 +304,23 @@ static void __init ordered_lsm_init(void)
> >       } else
> >               ordered_lsm_parse(builtin_lsm_order, "builtin");
> >
> > -     for (lsm =3D ordered_lsms; *lsm; lsm++)
> > +     lsm_order_for_each(lsm) {
> >               lsm_prep_single(*lsm);
> > +     }
> >
> > -     report_lsm_order();
> > +     pr_info("initializing lsm=3D");
> > +     lsm_early_for_each_raw(early) {
> > +             if (is_enabled(early))
> > +                     pr_cont("%s%s",
> > +                             early =3D=3D __start_early_lsm_info ? "" =
: ",",
> > +                             early->name);
> > +     }
> > +     lsm_order_for_each(lsm) {
> > +             if (is_enabled(*lsm))
> > +                     pr_cont("%s%s",
> > +                             lsm =3D=3D ordered_lsms ? "" : ",", (*lsm=
)->name);
> > +     }
>
> report_lsm_order()'s use of "first" needs to stay here or you don't get
> the right comma/no-comma behavior. It's not about the lsm, it's about
> whether "first" got incremented. Perhaps "count" might be a better name
> for "first".

Sure, I'll just put the "first" code back, it all gets changed later
in the patchset anyway, no need to worry about long term stuff in this
snippet.

--=20
paul-moore.com

