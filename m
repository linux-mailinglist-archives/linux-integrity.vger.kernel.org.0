Return-Path: <linux-integrity+bounces-3295-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF99499AC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 22:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED10A1F241BC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC116ABF3;
	Tue,  6 Aug 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J9LvP6Wz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4215B55E
	for <linux-integrity@vger.kernel.org>; Tue,  6 Aug 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977711; cv=none; b=IzGIlYyfApCgIrMxDnB8Sth6AaQmWnOHYWOXLgqcbko1Ahyhbr4au+j2r0hGbyv1JUinoQildpBv3vJLtukqxLK5Ukyl3Xw2irwK/8ERnHakyJkH0VT/ZHYOv79aPpca7FFay2pvM4s3ua5BBkTdhA+VSJbrIekv4FG7pRL6xgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977711; c=relaxed/simple;
	bh=Q1EFjItpPAJVvRpOJiKVEeB9t84orASFY/TzMasrm54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp0Ryh1bVLeH9/D93GcLB6crNO2wdDvHUF3DFL9tpnwk/OwPaAXHnhQFqqfq1T1LxrfZwRwW0tpyvdRCNpb1qa++mn51RwZ0KBTm1WQhkzOUbOIwfb6OmRocrleSqQTUqdCifYXPiGZgZY/L8f2fINhZV0Hod306IXbuGW4/wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J9LvP6Wz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0b2d502c6eso1011585276.0
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2024 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977707; x=1723582507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddUgUKkImUJBZRqaPBh4WpQntM2pgtbxW0LlNFNQthQ=;
        b=J9LvP6WzsHCDvrj2ADlfQxZ+5S7SpXsWuAnvGoTiKwzrkTAYtuGkWaXW9Cq5wlO9Qh
         D/YR5zglVkofWi2ld0OZOWgxLsCXHGc38lQXqK5r5bcca0X2gefHhm9qyJE2Lutp2v51
         quEykI75yi+ydzJrWtD9d5nocZc6CxsSsjxrSVC5RB2Cn6E5QIkuYIcSpXm/VPxfUqi9
         5CaF3deusHY2tUaA4MYtaMnt0DekhxDLUwUvitPwjEKxVX4PJfqSxblBgzPhgre5U8pQ
         T+MpyGKZSo+z7gB+r+bE8PqaNW13txwd38RnSxCS6zgALbcMEe+NNIuNTm79oFB+FBTD
         dTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977707; x=1723582507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddUgUKkImUJBZRqaPBh4WpQntM2pgtbxW0LlNFNQthQ=;
        b=cn1Fdx/pC+cv679CoT9ay3W0i85DNfTrsT0aRl5jUqIZEsDY5NN4Tk0EK6PZoBuPaX
         79mCJJehE/10fMi0AhQiZ3y2phrYS6s+tducKKm618T4XfloeXcbK4PjrEIBJNvDEF2t
         GO0ePQBVMmbfHZR8lgA32VU3wKEAv7lnDjDOWOjBLPaNCAjZ2p4o3Ld8tSzHmVcu7zZM
         UGhbuy/DEFvVU4z+X1sBbVlzgeJpxpHvKsi5doloEhNBxvxecaCDIZ5bOzcHrfUekwYw
         PUcb8J066gGHUH5ieVfM6o0x+If1f++hlq9VhVyWy2X0L260mRvw7brpUP5i1oVzdZBj
         Zhgw==
X-Forwarded-Encrypted: i=1; AJvYcCUFlYoVsU5xEaYyBCMunGU/38GoK/edtWvThgJ1ytU7laUox5/6gbVPnQctiUMBtsRDmQzlmIBJRWyzZjd/LpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzAtcasfH/Z/gQO1MnEGrqAJdmjkjVUhP0zyxokyPwqMTNknm
	4BVokWNlG08DFL8qYSmg5k+cb8Dstx3of7etYeIqeo3vZfhL17kkocxQbwQyHMXaRj6yFcUq2tU
	MDJ0sgA2fajQh9LuThYfiq0H4nJsvMXvFUI+F
X-Google-Smtp-Source: AGHT+IEV3DoSxpbwywgyClpobkg3f96r+2vacgaYADkIDoHb8BVfBMUuKoLI3KKW3kNSXmapcP0+yqslrTw3VHo3MFI=
X-Received: by 2002:a05:6902:dc9:b0:e03:5bca:aee6 with SMTP id
 3f1490d57ef6-e0e54be0a4amr8897314276.54.1722977707114; Tue, 06 Aug 2024
 13:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com> <de7857fb-63d9-42fc-af1e-12ffcdfcdda8@molgen.mpg.de>
In-Reply-To: <de7857fb-63d9-42fc-af1e-12ffcdfcdda8@molgen.mpg.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:54:56 -0400
Message-ID: <CAHC9VhRmcReVM_Le5bYor2deotnSe4OT08UYhL6xhiKCu0+3kA@mail.gmail.com>
Subject: Re: [PATCH v20 20/20] MAINTAINERS: ipe: add ipe maintainer information
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	eparis@redhat.com, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 4:15=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Fan,
>
>
> Thank you very much for your patch. Two nits, should you sent another
> interation: A more specific summary would avoid people having to look at
> the message body or diff, and `git log --oneline` would be enough.
>
> MAINTAINERS: Add IPE entry with M: Fan Wu
>
> MAINTAINERS: Add IPE entry with Fan Wu as maintainer
>
> Am 03.08.24 um 08:08 schrieb Fan Wu:
> > Update MAINTAINERS to include ipe maintainer information.
>
> I=E2=80=99d at least mention Integrity Policy Enforcement. As you not onl=
y
> include the maintainer information but add a new entry, I=E2=80=99d leave=
 the
> body out, or mention that a new entry is added.
>
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

Working under the current assumption that a new revision is not
needed, I can fix this up during the merge.  Fan, other-Paul, are you
both okay with the following:

  "MAINTAINERS: add IPE entry with Fan Wu as maintainer

   Add a MAINTAINERS entry for the Integrity Policy Enforcement (IPE) LSM."

> > --
> > v1-v16:
> >    + Not present
> >
> > v17:
> >    + Introduced
> >
> > v18:
> >    + No changes
> >
> > v19:
> >    + No changes
> >
> > v20:
> >    + No changes
> > ---
> >   MAINTAINERS | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8766f3e5e87e..4cdf2d5a2058 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11118,6 +11118,16 @@ T:   git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/zohar/linux-integrity.git
> >   F:  security/integrity/
> >   F:  security/integrity/ima/
> >
> > +INTEGRITY POLICY ENFORCEMENT (IPE)
> > +M:   Fan Wu <wufan@linux.microsoft.com>
> > +L:   linux-security-module@vger.kernel.org
> > +S:   Supported
> > +T:   git https://github.com/microsoft/ipe.git
> > +F:   Documentation/admin-guide/LSM/ipe.rst
> > +F:   Documentation/security/ipe.rst
> > +F:   scripts/ipe/
> > +F:   security/ipe/
> > +
> >   INTEL 810/815 FRAMEBUFFER DRIVER
> >   M:  Antonino Daplas <adaplas@gmail.com>
> >   L:  linux-fbdev@vger.kernel.org
>
> Kind regards,
>
> Paul

--=20
paul-moore.com

