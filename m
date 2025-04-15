Return-Path: <linux-integrity+bounces-5875-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7612CA891B4
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858C017D19A
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED5201116;
	Tue, 15 Apr 2025 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XEflOkZV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0673A1BA
	for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682302; cv=none; b=WkzrHzEdEiVzzcRPE+3X+KWSum3MYCRZL+xTnZRaBl15LZRvQb7u/I81m0Uu3+xRUSR3DdY+ouPvz1SaZ4XR3K9UGFoJRA85PCtdRru/6vNONagmI6/AMS0adCUb8KksQKJO2jwKabn8xo91xcmARFooUAC44DoqXAxceY8TBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682302; c=relaxed/simple;
	bh=rxUfE/v2nDHJxUYj7jPx7y6EB83OwOnUI3i7DLmxAuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfEfeyV8EiO1fdj+4OmUkUlVAAYN7+LFO2LsSwKoH6J5rTKMFIAqHGgbJ9RgTc8UneAb/c4Fm3WHhU+xWTx7kdfw4taWFzlo9rw8JbmAnZaQ+SZRKnFadTTUNSJDnmHyxkjBAGG7KjDKfkNqKuIb6ZyPagMdmwBMMuc866XS/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XEflOkZV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70575d66612so19622127b3.1
        for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744682300; x=1745287100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgNnzJLDju9A10e50BztXbFlpGHdbLWVEcQRfEr8Uao=;
        b=XEflOkZV4UIL5V+xKBe4TLQXozbELihpI2uHHbBzD+r+H3lzBlic4kfWhJ9kHcKhcH
         XeVrog6gXYuqMB7fszOIMcq8trvx145vOFl46WI19+SvbBc11Q1Hw1w49KpSFlFDtVw+
         7DPvA90IrdT9oZ+MR57IQ2RA8OkmBhAEvzcY8AEamCxB0qH8ZdHT9XYfSv+/SMoc6uq3
         RCjy6OeJaGYPM33YRzr9DLX5w/bvWXEfA1K2o3xAkktaMGRk50TjROE+z0QIStoDyZw1
         l0VQ+v1t66dyShfkMDMkndzD2K9nJkZu0LjNU9cYw6Xf9Lz4JBEM6zjpJwA0kCFx1+Fv
         ck0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744682300; x=1745287100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgNnzJLDju9A10e50BztXbFlpGHdbLWVEcQRfEr8Uao=;
        b=n/L01RU+NyjvN2VSDwZFS70FJHw3tS+HVNQve2/QT3AfE9RiyJUQyv29jOT54/0Xdt
         8liax0C38C+31XDXbApa4KqbeYlVPdxiHicKn8Q9U2iaTa3y25Sm+Z6rtFUr5nF8hp9i
         YkxyoTXQROrO5zGGfirKyFO2zvFMKXHWAXD/E5A46zkYCzcZO9GE4uQoCQO47zzob8h+
         p+PTX0p1Uh8OZ5pwpUlMC11vljvutC21h9c1SedAuIOb00ufko3LMgPcMpJVJVTGtesS
         6k2yRHih/ponjiBVf0HziSlmZcBsPiPCYwH7CkHHjprUapvgeX578CLN7zyz8ilDhbD2
         iQnA==
X-Forwarded-Encrypted: i=1; AJvYcCV7xs1Ml92l2FWDA2V6UEJhxJX4WqM3VvNocBLr4CSbv7Rz5ORLHNXe82UIzT3UvxLn6EYIBXqo9PW4Wrce7nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEogpwCfy1U0uXe2seZupR28W1GgFfOhLY90FVutAPZR+5CCAk
	kvybREk/ZppOHV1jN0Sx7eCc8hQmCLHVDoJ290Pkfd8HRnUHqOHOBGhtyJ16KE4foZh6VpZTi0W
	RtN10zIkz9S0kL6XW8sgrj+CCSs778mlYQxCL
X-Gm-Gg: ASbGncvlNVoO1UQ6qEIrpw6NSlC9aM00CVFkaYdEsg3r2AdSirU8TvyAmFKusKSSp4T
	BYOKYIPGwCOA9wdE1A2SI92Mg+Yj3NKVz0vLLjY6SoBb4e1Cee8MgwIOBaxLZ6crBpfKfraB4lv
	VKcza5MMbK6YO7jDDgN7qfCg==
X-Google-Smtp-Source: AGHT+IE+O+qaO9IzOFxYmwdXgL5o4sY4lXcGxON+fCx0AlD3dy29wINp9CXDcgL2xssdQXTCuf5oMj4o1y2NmO59pkc=
X-Received: by 2002:a05:6902:1606:b0:e6d:e183:4e0e with SMTP id
 3f1490d57ef6-e704df5f8b0mr21296050276.22.1744682300213; Mon, 14 Apr 2025
 18:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-50-paul@paul-moore.com>
 <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
In-Reply-To: <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 21:58:09 -0400
X-Gm-Features: ATxdqUHXTqHh3BTd3Af7U8uMaRUAJKrsIIuJHmSbWNQTnuyizJTe74CXY-81aIE
Message-ID: <CAHC9VhSDqftrOS=maqPhw6A46X7H3X+QAc1AFXeb50GRdjbm=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:19=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>
> On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/ipe/fs.c  | 4 +---
> >  security/ipe/ipe.c | 1 +
> >  security/ipe/ipe.h | 2 ++
> >  3 files changed, 4 insertions(+), 3 deletions(-)

...

> I have run the ipe's testsuite and all passed.
>
> Tested-by: Fan Wu <wufan@kernel.org>
> Acked-by: Fan Wu <wufan@kernel.org>

Thanks Fan.

--=20
paul-moore.com

