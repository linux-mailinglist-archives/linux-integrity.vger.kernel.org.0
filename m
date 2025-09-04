Return-Path: <linux-integrity+bounces-7012-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61249B42ECD
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FF57C2469
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F61C831A;
	Thu,  4 Sep 2025 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+mNVC5p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126433E7
	for <linux-integrity@vger.kernel.org>; Thu,  4 Sep 2025 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949330; cv=none; b=Phn+F/DF4J2PPltc4L5hNJY1cfDt6EmCbSUbQbwF3bI3tn36iC8iyBJRgmq6nmhi7YLT1B96Gm5hal1loO5o+KtltRbBa9WuTLDdYfw4OU2AGLLpiWYiVwfRG6qQAJ2fHZ9mjrIufael/9CLngVZav6KB7xOYjRC3TdiTXrCj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949330; c=relaxed/simple;
	bh=IaQ5uwK4QwBnH+gS9G1h8dmnPscMOmuMdmvaxqjSAxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfGW/Z/nX41wqI6Z+6K9hgY0a5xN6M111OpKtP7CelNhAiMSAUclApmSTD4XjFvCvXq3i5SRMtrh6QwdU0dc2RvJ8qCkft6INilNiDoEgEJ2hiSDVhW3gQ8RklEfmk4y1FGuBeD1D5w7d62R0Vn+vgwmkcotxEXr+4sfjEJ3IUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I+mNVC5p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso368203a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756949328; x=1757554128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=I+mNVC5p8jsB4c5LGhX+j4MhdLjPXQIPnp5qzLJTPHAE+z6X0j1+aVElLhqIReksk/
         NIq6qDy1eSTdVSYa/aC+dSpTOEt2ghoFtQMkh1LvmN9b+f0X6PyP0bzjaO3mSZ3bwZEi
         XUVNbl+Zvp2RgvzrOyP3H1LtuhJYsTBSdTNxbBvFJciS2pl0CB0DXR0caH26a1/gysKW
         SPiUf1gI1pylraX6ni8iSvfhv0G+SfRAvO2BwqO66EaknX2B35yHPt54GZ9Dg5HnMOyN
         2tbNxR0D6umhQUS7lK6hSQIu7KyUnIZWt+KfkmMDk0e0SFFGjQMG9jIHi/4QW0tE+j3Y
         vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949328; x=1757554128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=RyDY5gjUApwbDRUZUjCp4y3z8D5aGP7KBBraVJAq6Y37J4Qosx7E7sMC7KAwtDjvwh
         Hr1l0MAsHr3BowpjnPHyvKkjujhQW93QjClPMrCroU9l/1Twr5vaqKnbyo01QS1cvBym
         7/dw+us3L1/4KsZ0Nm38zcxXxK+xCkjZFcZQQPG1VoZZJsFtttLQsOqKikgurQKraddX
         FF5/pDCQczYVWB571PS5eN5TJGHbChDfhU3bvi3mjuMpswSjqCs3n92kLy9Ah8T4nDdj
         3w0Q4bxidaCzc2pZiUUxvhALtPnGJkgJrLcMvCpcS2ZSw+g7KZ4Wz75Qm1y1YElKqIDt
         Rh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPwKmx1ei00lwn675Bj/jU4M+v8Yu+ScGpoyXckJzqReWqymB6ZbIdjZ+UwqtqYYvqLAh5qjPeXOhgvTpjKTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NXaX3KeiIFg6gL6/bnz3KSdnrA0cUj+46AEoGEPOfu2frHRj
	M3nC8uqhEDAqBSDr3SxJijzvinanrJTVNDqnQwVsrjaYM0k/HkbB3a840Hc5nAC34Y7i14fkaX8
	0ZmiJO+0YVQhDQzA0A1Eqv2WcUOazre1Nk1e1xof4
X-Gm-Gg: ASbGncu7LTeoiYaC9RdJqVdaBXERLtKmI9eg0iKWz+2rFbsUyX59uoQ28nmi5hE0P6z
	3jIigIDkmyZH8IRLZsg9/s2+MCREFvBK6hY/6sWFOJx4h2QCAAzmweC8W8+U4qYRBj59NvluW5Z
	ooS8Lthh52dr3w7cNntAdf84SDfVmDhX/2/eDFFuDvSMan76ORRKHxZA24ZiiO1NXPZrprK7g4J
	4dFX26njLUGQQIQC5ke6VPA8YoG
X-Google-Smtp-Source: AGHT+IFBKmXhFkhlf3AO3YklhmlQlkknPiNAGzAs3/NGtNx5EdCIX4CD+Vo4Pco6SEL0557kGd49fhJOqXjMoxsF0Cw=
X-Received: by 2002:a17:90b:3fcc:b0:329:f630:6c3 with SMTP id
 98e67ed59e1d1-329f630078dmr9758647a91.20.1756949328511; Wed, 03 Sep 2025
 18:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com> <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
In-Reply-To: <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 21:28:35 -0400
X-Gm-Features: Ac12FXwM_owd8hqAIDRgoryFAGYaav8zfNn8ISHgZWw1QPDHSomawRHnM-NiHCQ
Message-ID: <CAHC9VhQbRp7i6dP_Z1W41ykeG6N2Dp_fGzE6sh8xXo_pxPSfWw@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:15=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/3/25 13:34, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>   security/apparmor/apparmorfs.c         | 4 +---
> >>   security/apparmor/crypto.c             | 3 +--
> >>   security/apparmor/include/apparmorfs.h | 2 ++
> >>   security/apparmor/include/crypto.h     | 1 +
> >>   security/apparmor/lsm.c                | 9 ++++++++-
> >>   5 files changed, 13 insertions(+), 6 deletions(-)
> >
> > Thanks for reviewing all the other patches John.  Assuming you are
> > okay with this patch, can I get an ACK?
>
> I'm working on it. I managed to get down to I think 3 patches remaining t=
o review/ack, and I wanted to get some testing on this one before acking. H=
opefully will get that done today

No worries, I just wanted to make sure it wasn't an oversight.  Thanks
again for reviewing everything.

--=20
paul-moore.com

