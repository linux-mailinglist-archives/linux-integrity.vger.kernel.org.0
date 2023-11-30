Return-Path: <linux-integrity+bounces-293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3B7FF798
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Nov 2023 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B81B21152
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Nov 2023 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AB55C24;
	Thu, 30 Nov 2023 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XBD3WWY8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81C10D0
	for <linux-integrity@vger.kernel.org>; Thu, 30 Nov 2023 08:59:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso1066724276.0
        for <linux-integrity@vger.kernel.org>; Thu, 30 Nov 2023 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701363570; x=1701968370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC+YVAHwKs2kkAU34IYOVVTovQR04OMhKsJNMkFTFrA=;
        b=XBD3WWY8IJSAStE1FQ8v8QeGtkTywkRiNNMMP5q9awnNXYeghZAfOB7ojMuBO9spjw
         m4mLJ6G5vY03eH0VF1kwgEhQw1fQLPpYCs1xBDaCecI+/AcxI5OKCTB5vTjYU8g1yyR+
         hBk3h3jJnp8kwKY1Yf2n/tF+DJJx88OaR0E2vXRabM/Aa2p7r2nTH2l7j2usbBFcyJYC
         OuyMoARJPHpPYisjarNftLXrZ+/bSInY0EgbtJnfhv0m/6yAduXEkzksSVCDEUtyrdGA
         rAy3TQuRs7d+FrTJC873C90ZPCNTlwi3pKycdFCHEK7TGJbG2NieBz2fhijCFRZS0u1y
         fyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363570; x=1701968370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC+YVAHwKs2kkAU34IYOVVTovQR04OMhKsJNMkFTFrA=;
        b=FfKXlJY5441O5QV/z0CQUsPxrxFfJ2TcBR7pLK4OLKpNEQ64pJ8TPfi80CRk0PbKrr
         LuqcyJApO9g9LvCWKNCrnHt5oZcODkhWDVjD7Vj+Z4PklJRwocGcjzVZAmfrAvLte/29
         +U3OUg3nj7wlDxrxqAfudu+hXUAbZFs9HG1KQLX0LDdJA0Lj5yMTjI5mB06pFugHwRCu
         +7+im2eseTGC767spgw5MZ4w6TVVJlo5EmTg2g8wPEzWI35Jj6NzixWGQIlRpVpx8TLi
         iSM71YWffSadaKykUIBsqnJH1HViMPiS/iUttxXRUNzQX9s8S4Kemk0HC3hSZV5SbTrl
         5tkA==
X-Gm-Message-State: AOJu0YwV5HZHXVWYMCPDpUAfYLZ1GGQA2f+MDpfuNNwbljlDOqbkIS3W
	EuOHKQvingQuTMX01fJtZZSFIIHNuWNXr75O54cp
X-Google-Smtp-Source: AGHT+IERQwY73BfKyowLaBkWCwON5Z7fm/5peh0ErEUfe9ZiF54XUdUJecnVn1oRjqpirYk/CaQQxBixoUm8GSxjd0s=
X-Received: by 2002:a25:8d0b:0:b0:da0:cbff:4e20 with SMTP id
 n11-20020a258d0b000000b00da0cbff4e20mr20156386ybl.56.1701363570522; Thu, 30
 Nov 2023 08:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com> <7cb732ea42a221b4b8bbfad941d9dec41a3a35fa.camel@linux.ibm.com>
In-Reply-To: <7cb732ea42a221b4b8bbfad941d9dec41a3a35fa.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Nov 2023 11:59:19 -0500
Message-ID: <CAHC9VhS28XuVjNX73H9qWZibObCxKCx_M3omQu9+5EdourUc+w@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, mic@digikod.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:13=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2023-11-29 at 19:46 +0100, Roberto Sassu wrote:
> > On 11/29/2023 6:22 PM, Paul Moore wrote:
> > > On Wed, Nov 29, 2023 at 7:28=E2=80=AFAM Roberto Sassu wrote:
> > >> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> > >>> On Mon, Nov 20, 2023 at 3:16=E2=80=AFAM Roberto Sassu wrote:
> > >>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> > >>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wro=
te:

...

> First you suggested lumping IMA and EVM together, dropping EVM
> entirely.  Now you're suggesting making EVM dependent on IMA.  Please
> stop.

Welcome to design discussions and brainstorming where changing
opinions and unexpected suggestions are part of the process.  When we
are faced with difficult problems I want everyone to think creatively
and not be afraid to adjust their thinking based on their changing
understanding and the ongoing discussion.

Asking people to stop thinking outside the status quo is not a good
way to solve challenging problems.

> EVM and IMA should remain independent of each other.

A few posts back that was the goal, then Roberto mentioned EVM
breakage when IMA was disabled so I simply asked if it was worth
"revisit the basic idea of if it even makes sense to enable EVM
without IMA?".  A bad answer to that question is what you provided
above (and to be fair, we are all guilty of that at times), a good
answer is to explain why IMA and EVM need to remain independent with
bonus points awarded for realistic use cases that support the
assertion of independence.

> > >> Regarding the LSM order, I would take Casey's suggestion of introduc=
ing
> > >> LSM_ORDER_REALLY_LAST, for EVM.
> > >
> > > Please understand that I really dislike that we have imposed ordering
> > > constraints at the LSM layer, but I do understand the necessity (the
> > > BPF LSM ordering upsets me the most).  I really don't want to see us
> > > make things worse by adding yet another ordering bucket, I would
> > > rather that we document it well and leave it alone ... basically trea=
t
> > > it like the BPF LSM (grrrrrr).
> >
> > Uhm, that would not be possible right away (the BPF LSM is mutable),
> > remember that we defined LSM_ORDER_LAST so that an LSM can be always
> > enable and placed as last (requested by Mimi)?
>
> Making EVM a full fledged LSM was contingent on two things - EVM always
> being enabled if configured and being the last LSM.  Using capability
> as a precedent for ordering requirement, Micka=C3=ABl suggested defining
> LSM_ORDER_LAST, which you agreed to.   It sounds like you're
> backtracking on an agreement.

I not only agreed to LSM_ORDER_LAST, I merged the code and it is
currently in Linus' tree.  See my last reply to Roberto; I see no
reason to change that.  I never would have merged that code or sent it
to Linus if I didn't feel it was necessary.

I'm guessing that you misread my reply above (perhaps you missed the
"another" in "... I really don't want to see us make things worse by
adding yet another ordering bucket ..."), but regardless of that, I
want to deal with your "backtracking" comment.  Similar to my comments
above about brainstorming, I don't want people to feel that they can't
change their mind about something.  Call it backtracking if you want
(although that has a negative connotation for many), but I want people
to feel free to adjust their opinions as they learn more about
something or as the conversation evolves.  I believe this is the
primary (only?) way for us to reach consensus on challenging problems.

If you are uncomfortable with new, different, and changing ideas this
may not be the right place for you.  I might suggest a career in
politics as an alternative.

--=20
paul-moore.com

