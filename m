Return-Path: <linux-integrity+bounces-5874-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEBA8919E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E32B17C6F7
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2913C8F3;
	Tue, 15 Apr 2025 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FlcWpH2c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CC19E99E
	for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682091; cv=none; b=H4pH15yUKCbVQgvIsn9I126bQtAbUzvph8scWE2YApAlzlFrSvYJk9wiA+zAlREYHBsYjaKnA6FoXdAPLmwBlVdR1QdwsT+v1bXUc8EXpCC1RwGI1BP1XUmGIZwihF3793OqMjVT/Ufrt5fsBxLFU4C+nm70X3LIEyQjyuadA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682091; c=relaxed/simple;
	bh=RIuEpCAWwJBwcXSxpMUxjacCf2Nd7SQD0nUn/o2H6WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMLyw2gIoKnF7+Xavvqqc6iChHElGvntqIo1GsAfw6G4oWA8EUyk79hlkp7+UuMpSZZ5PaBp+0aY/vL8CI/S3MLjSHdOFANQgO4ZlT0V7Zg2vVFdVcGRsegPkxSa/8cJzKiWm1UK+dJcpvjCw1F3brhikyyDXNK3i26ZdHGPDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FlcWpH2c; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4794819276.3
        for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744682087; x=1745286887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kf2HB+2t0DsSXOO3Gr3LgcuugUFp/PyDyoGAYGDC1c=;
        b=FlcWpH2ckuRZRNrpGaMccwMpvcn6AoggUaeR+7f0b/Ks2jLEqYH3E1E4kOFPi/rli9
         oAHxvyE/NaSK5zFxicoA01dMQhrmWoFyOD2Spb61QHs1ktuV4kHaAj/E+36L+PZBPddJ
         BsU5M0jz2WN7yr0kalvuGCo66eAbHLuwXrI5pkcnNwqYrjzyw0QUVbt02ojITRqJO6Hp
         ieNmLr2WFCwsXT7ktSk+YrZYsn3pzvYKKRb4QtWblQ1i5VgVQMZEDK2h31lAMYOYENyH
         OVt6TVeNRdDxeWX8yK+eegWzSnCxTKvVsYBZbSfKOYFjf9NYdLj4gxWikLNylTzDFiw0
         zKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744682087; x=1745286887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kf2HB+2t0DsSXOO3Gr3LgcuugUFp/PyDyoGAYGDC1c=;
        b=g8DYstAbshe1FbmGLGx05a3i19TqoekUN9LXtr7FTCOcz3MiLgKBzP6nA8IsG3fryz
         4OYKRib7gp5nvBhVFuNpELxokKuTTXjvAN0xcT11LlTl5fRN/EOkVNzXOr6rCUmENOjh
         Ab6V4Xtpp+pjGi41LMwZ+Lm6uBuYaZrbGvpCxQlP/rxyklqyuseTjnp3hCTjGGhoa5CI
         xOSr7QeLv91a9GMbx2rURzpcvJTz8SYGsBzTRbrN8mZJW3i95kxYga4BfaVgn56mhbhR
         DPeMMopQu41JbzCaR0DtABI/FPGBCz2ipHSwrRlw71thWboG9AViSBL4Co/F8hLyF1me
         IPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUkkgkzSn11a35UAHDpFXmkms1bg/x2wZD0OZluZONR4flV/APqDtF1n/guHjXjJtZkGgjFjBQLBvXZSuBqS5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYwoTpxp+ginU/Ll6nFia66/okqiVgA0Pn7E2Gl7+24Szt56q
	kosJRf5gfLWYgMoH50dFWu2n1rHgImPPasTDx01vz5NfceQ/JR0A+IJKe5CTjxdDItCvDqU7Z6F
	8G1XcD/NAxNKQfuVMLkgnWeApCPMIV84nbHka
X-Gm-Gg: ASbGncv/rLIBoS7sbjy3Z1ssg20hUaoB1Tfng0x9IpGWTg4bsLuMQr1YXBeTX1roEVX
	L39I0lG+Xt1DMIiel5c97nzJ42ZqIZ9o/NsbuIPxhyafo//KQIrG+c2vBh4opnZRzsu6Gt+9I9Z
	aw37erzOItN6pSJ4NAMpIvpg==
X-Google-Smtp-Source: AGHT+IHAvWs/9H4IE5oVAZXQLadFHf3OPEuDA39J2HxSOfQADnUIBLhlOASR5Q5rlyPVk613nwuKqqugeaFfh5OppIo=
X-Received: by 2002:a05:6902:d43:b0:e6d:e3d0:38 with SMTP id
 3f1490d57ef6-e704dfbe613mr22814287276.39.1744682087599; Mon, 14 Apr 2025
 18:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
In-Reply-To: <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 21:54:35 -0400
X-Gm-Features: ATxdqUF1-XzruXrFAtcGGxs4uxnPPaDZjoullBc6BTEXhHCar2kkKxiuquSCz30
Message-ID: <CAHC9VhQtN93Z7pfQL-63ZLbm61g-UUc+RrdmzUtRiqeJyp5Sig@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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

On Mon, Apr 14, 2025 at 5:04=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
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

> I'm getting the following WARNING:
>
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0xb (section: .text) -> init_smk_fs (section:
> .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0x16 (section: .text) -> smack_nf_ip_init (section:
> .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0x27 (section: .text) -> smack_nf_ip_init (section:
> .init.text)
>
> I guess "__init" is missed for smack_initcall?

Yep, fixed, thanks.

--=20
paul-moore.com

