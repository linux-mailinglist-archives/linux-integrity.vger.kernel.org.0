Return-Path: <linux-integrity+bounces-7038-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13AB49D47
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 01:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098AA188361A
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8E23B61E;
	Mon,  8 Sep 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FuCn4CUU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A821FF39
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372770; cv=none; b=NZRUXKR5/KLna9N7Qqb48PYdRb+tApZQVQlA5eO0p2Ei0NVkO6ozVP9IQfXg09IUOIzUq21txCbl26W89MMr68IiHY0CCbZGEzrPxeBCsksHkNXlLGKAnDtwJqfmuv4mvfKsXVMKMnzaBQP3W/wGRItzo0CDxaz5b4OKAlaDU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372770; c=relaxed/simple;
	bh=Y5RZSb94nAB2oyU1qoO8afAl+wCOgH+J1m+ytAgunGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geUjgnVwF7sEnjucHZrcJIi65+NCAWpN8hTTD0S9r1MgrcK3fhYaygnpcTT05Egg1QIsnXZwvnPbCH/43nZa+cSC/HQEyzyUDLdQHkgtwXDuR3uRUEGeX3Xrg7wKXj5nwzhgcpQ+H/I9iWW78j6HoCSBVowj5t9N2wXtIi3t0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FuCn4CUU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so5858067a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757372768; x=1757977568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=FuCn4CUUjgnNvtegpU/nHCxIG72/RqpukgPzgn/NB7mzyhx8waHFDDfVtFZ84r0haq
         A5CltYE17oZ6zKlQ1KkO7Rh1IcvqXZaZ84CPwy3RHww4qXC2AhxZOnzqVjQSJUwUu/i7
         Sgrp5zVpM2ekQyNsnpxNcfPoJ8x8PTufkYZ0diGzB38hw0qmxafGRm00yjbZBoiImyrg
         VawHe2RPR4E8xX5LD1cAgcT+Be7Fkgxpi5zuy9afzLCB98yv5jgM46zVjl1ysuuqgood
         zH5oHWUNiP/27MAJB3teMsatItiUqzQi4/z3wMEyPSZ6y8ljkRDGGf61maLLITB8cPzL
         q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372768; x=1757977568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=YWuV5iZKkzeu7+VUCaIhX/dD/g/36HGIh0ohImaE9jfc8O0npEQteGLwP6jynv9Esu
         FioutxZZtVkWIMgKzjnPuhNnLQm/2zxK6xjZgxZMMWZFEFh7LLktWQHJXhjRcI6wVTHu
         FlP55X2mVAXKU5iZrPhJCaKOcw96Zt3nRgANYvuVeGC97UPf9OKcl3zX/Rcp7t8+2cvd
         TNqZzMGmnLur16jnZ647/iSA/O7zctsZCvC5MQRD+EF3V163RIkQWy5tG/fmcEic3tXb
         XorSWgcXyrmojfT4sOtEoOU05RRacsuaAuKRMfUuzyXJ595j/I7i35suNZawUHVwNkVX
         0C2g==
X-Forwarded-Encrypted: i=1; AJvYcCW3g4IjoGViIJBDI1D2YiJQ0qCeYidbgkjD1Ca/WX8xjVMP1BRLhrrPipt4b1yo63TNycZYZd3Gdqdxz73uges=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSxb+T1E+MBYcAxG/768Q7/ml9LBuR3ec8BXIn4fM68ZCkpzK
	VaX2ez1FzSu2KsAfhAP0rcGnbHA6T9/qCvaaCMcvXxii0yBb3N40NiBSLj9oqxr8W0WZ89ne6TT
	CnJa61Pal9GyV8nNU+TpTV9Dvb+oQYKZOFqqaee75
X-Gm-Gg: ASbGncsH1jwCxIHIiT4j3go3yXDVdvs89ygQqh6v0zBYLwOw9Q76zF9pVdEQicxMNHB
	zpO+BIY+C9ftRFHKFTaR1FXBnfhfu0c6iYI8WWibqaTCzwAS6zyFY2U394vbEQ+lW+uhCcaVswB
	3wFnhJQ9myjj+keuOnPikkgzvUGN21CLdl7q0VGUwi7rVsCFqOisNW/UMg5MfqBBe2oTMz//jOP
	tHgxcg=
X-Google-Smtp-Source: AGHT+IFB+FxnX4rjcAYZGM7fEt911DkcKdbHyBbmx41VKn8nMmV/AAJIF3WqaGwCTnbvarfbhMxVBFEgH0t3USpFar8=
X-Received: by 2002:a17:90b:1d0b:b0:32b:df0e:9284 with SMTP id
 98e67ed59e1d1-32d43f45856mr12879413a91.10.1757372768528; Mon, 08 Sep 2025
 16:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com> <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
 <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp> <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
In-Reply-To: <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 19:05:56 -0400
X-Gm-Features: Ac12FXxJDTl9FmflOjd4KGcqf27UBcWa5-_QkD1wxw_L_dqqk3VN6ThLKrEYEI4
Message-ID: <CAHC9VhRvdxdmyp1+hDpiOZTLdJjuK1u5Rvk5dTsbN=oDAyPkNA@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:07=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/07 16:35, Tetsuo Handa wrote:
> > On 2025/09/05 2:52, Paul Moore wrote:
> >> +               if (!str) {
> >> +                       str =3D str_tmp;
> >> +                       len =3D len_tmp - 1;
> >
> > This needs to be
> >
> >                       len =3D len_tmp - 1;
> >                       mb();
> >                       str =3D str_tmp;
> >
> > , or concurrent access might reach simple_read_from_buffer()
> > with str !=3D 0 and len =3D=3D 0. (If you don't want mb(), you can use
> >
> > -     if (unlikely(!str)) {
> > +     if (unlikely(!str || !len)) {

Good catch, thanks.  I'm going to go with the approach above as it is
rather straightforward.

> Well, memory barrier is more complicated; it will be
>
>         len =3D len_tmp - 1;
>         wmb();
>         str =3D str_tmp;
>
> and
>
>         }
>         rmb();
>         return simple_read_from_buffer(buf, count, ppos, str, len);
>
> pair.
>
> Just splitting the whole { } block that follows "if (unlikely(!str))"
> out as an initcall function is much simpler ...

I would very much prefer to get the string generation out of the boot,
and generate it on demand.

--=20
paul-moore.com

