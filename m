Return-Path: <linux-integrity+bounces-3004-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E2927CCB
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26811C2175D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749DF6DD0D;
	Thu,  4 Jul 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHtdJ7xL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40024101DB;
	Thu,  4 Jul 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116339; cv=none; b=BZH2kxSlEVYR9+rL8aSq5i8WjHciEpBuSzhP/33k77P4UYY9Ho6RYZe1TMbDh3Ia0wRqZKK1uoipeZ0yEYl7u+Zs71gk09VqnJRmwiaQnHW7Rx7JvKOegl+RAMn68n5HvekIJ8obVIZRlxF9ZAV/jmiaRANagexg//60+3dV9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116339; c=relaxed/simple;
	bh=LVfDPJ6MlW4T5sX4TuLGaaFpU3B6jV4OEm561IhD+yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JVcu04XsBRnaG6ygbftQJVhhsLV8jU89aIzCOeD6/t2raPH1ITso4PDmWR4TFzbid3NmaT6YjgtNWHF1GU453Zgyba1oR9RlkTmPQAwjs3OdMAL4ipgz1Bbr6MhHW7lJcVYoOuyLowh/aVKwBUr+eXJ/mD/CYpNq7DDSZxC2iXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHtdJ7xL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22331C3277B;
	Thu,  4 Jul 2024 18:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720116338;
	bh=LVfDPJ6MlW4T5sX4TuLGaaFpU3B6jV4OEm561IhD+yE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PHtdJ7xLF8yzWO2vJY2JyO0rEXApugSx0sX/4/rvCuIaVu38D/psmgYErQMVQPWDZ
	 qoHM1nPmyQxabn7NNdIew1MQrB5qJZgjXWBdp7HW6/IgUAqezJR/PHlr0Ot0W9nq9D
	 p5yDfEwxqchdjNiTeRtC0zBp8XIBWDJ8tnlHRjV+00C1qKCCGloMjpjU/spBm3MYSR
	 4V2V0upRjTX3fCPSZPR17bJHjtRzcWEC0x/oEnDOjyUAJv36XB7U0D73gARaI0160/
	 pNhgStlPxP99gB2HhpsAT2i+WPI0jkywyh4oe3wYUA8yAW7vjLzWr7/oFPK1vv4oFw
	 L1DG5ZP11UpuA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 21:05:33 +0300
Message-Id: <D2GYCMH24J2W.3MLLRA42T52MY@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Thorsten Leemhuis"
 <regressions@leemhuis.info>, <stable@vger.kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Mario Limonciello"
 <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in
 tpm_buf_append_name()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
 <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
 <91ccd10c3098782d540a3e9f5c70c5034f867928.camel@HansenPartnership.com>
In-Reply-To: <91ccd10c3098782d540a3e9f5c70c5034f867928.camel@HansenPartnership.com>

On Thu Jul 4, 2024 at 8:21 PM EEST, James Bottomley wrote:
> On Thu, 2024-07-04 at 10:07 -0700, Linus Torvalds wrote:
> > On Wed, 3 Jul 2024 at 13:11, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >=20
> > > if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))
> >=20
> > Augh. Please don't do this.
> >=20
> > That "__and()" thing may work, but it's entirely accidental that it
> > does.
> >=20
> > It's designed for config options _only_, and the fact that it then
> > happens to work for "first argument is config option, second argument
> > is C conditional".
> >=20
> > The comment says that it's implementing "&&" using preprocessor
> > expansion only, but it's a *really* limited form of it. The arguments
> > are *not* arbitrary.
> >=20
> > So no. Don't do this.
> >=20
> > Just create a helper inline like
> >=20
> > =C2=A0=C2=A0=C2=A0 static inline struct tpm2_auth *chip_auth(struct tpm=
_chip *chip)
> > =C2=A0=C2=A0=C2=A0 {
> > =C2=A0=C2=A0=C2=A0 #ifdef CONFIG_TCG_TPM2_HMAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return chip->auth;
> > =C2=A0=C2=A0=C2=A0 #else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > =C2=A0=C2=A0=C2=A0 #endif
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > and if we really want to have some kind of automatic way of doing
> > this, we will *NOT* be using __and(), we'd do something like
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Return zero or 'value' de=
pending on whether OPTION is
> > enabled or not */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #define IF_ENABLED(option, v=
alue) __and(IS_ENABLED(option),
> > value)
> >=20
> > that actually would be documented and meaningful.
> >=20
> > Not this internal random __and() implementation that is purely a
> > kconfig.h helper macro and SHOULD NOT be used anywhere else.
>
> I actually like the latter version, but instinct tells me that if this
> is the first time the kernel has ever needed something like this then
> perhaps we should go with the former because that's how everyone must
> have handled it in the past.

I'll go with the former given it is somewhat idiomatic and familiar
pattern.

> James

BR, Jarkko

