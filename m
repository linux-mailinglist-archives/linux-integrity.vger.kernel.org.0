Return-Path: <linux-integrity+bounces-3692-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD525984CEC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 23:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEB11C23342
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706113B792;
	Tue, 24 Sep 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjObECcj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFE12EBDB;
	Tue, 24 Sep 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213708; cv=none; b=iG33OzoWAuzHUf0zG2KS1mHOYpoaoxxoDTJpDCflH+Xa3beIWgNCK4hUaUqhzcGKq6dlgdjBrjYa0xPJqbIEY6yfywTRROASqM5/droUimypYzHUNnXPdX3AVwuLUtCdP3MB/bP7Dm+ymGX42X7SQMxbnoAa5WOWU5OX+zDabvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213708; c=relaxed/simple;
	bh=YmPVWJgmPJzLv12DGoKm2ITbmiVNZO2w19XV/CA8iiQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nKfOPH0ititTw7YT1GNG1rKKq1M2hcB4Eszo+F/ZDb6sANQcrFghIcxPNefURbTZd4MqlM/AfebgWTbY/yzls4+nMrsfYOgHhehHmXH4uYjINpCLm4/LiW5jbiOrHHTx0WO6+wOSxem9u9/WJ0zAPrSJUdwM1sBsGIqR9+mtVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjObECcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB6EC4CEC4;
	Tue, 24 Sep 2024 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727213707;
	bh=YmPVWJgmPJzLv12DGoKm2ITbmiVNZO2w19XV/CA8iiQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=cjObECcjti0Kx5qw26RG3QRVd63WOWqOMzHL4EW/j27LlmuKs9O1h9k60/2BFYqwd
	 fSM8+iZw5X0zxuzaELv508SQiUbMxbQwhOkUR4Rsr0Jmu+PZ6ZkzUgHL0zmeO2079W
	 1KyVeRDZRXENC/YO8hbZfh3X3IvoaMedq37Xg9lEIEE4sfQVEqssx2DXIFRp5CiQfJ
	 oTadmxSsEX0/+6soh3EuRsv/AW9iI2ePHPaETgYYHBjOeNVDgxblN2V+Q8JSBEqFVY
	 QOcXskDFBKKyz3M72eEVVcSPH7sT8S1r/8mNmXkhsNpfqo0T6dXJj/sI0zHaE0BS9/
	 WqSkY2Z7eAYjw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 00:35:04 +0300
Message-Id: <D4EU5PQLA7BO.2J5MI195F8CIF@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-6-jarkko@kernel.org>
 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
 <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
 <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>
In-Reply-To: <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 9:40 PM EEST, James Bottomley wrote:
> On Tue, 2024-09-24 at 21:07 +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> > > On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > > > Instead of flushing and reloading the auth session for every
> > > > single transaction, keep the session open unless /dev/tpm0 is
> > > > used. In practice this means applying TPM2_SA_CONTINUE_SESSION to
> > > > the session attributes. Flush the session always when /dev/tpm0
> > > > is written.
> > >=20
> > > Patch looks fine but this description is way too terse to explain
> > > how it works.
> > >=20
> > > I would suggest:
> > >=20
> > > Boot time elongation as a result of adding sessions has been
> > > reported as an issue in
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> > >=20
> > > The root cause is the addition of session overhead to
> > > tpm2_pcr_extend().=C2=A0 This overhead can be reduced by not creating
> > > and destroying a session for each invocation of the function.=C2=A0 D=
o
> > > this by keeping a session resident in the TPM for reuse by any
> > > session based TPM command.=C2=A0 The current flow of TPM commands in =
the
> > > kernel supports this because tpm2_end_session() is only called for
> > > tpm errors because most commands don't continue the session and
> > > expect the session to be flushed on success.=C2=A0 Thus we can add th=
e
> > > continue session flag to session creation to ensure the session
> > > won't be flushed except on error, which is a rare case.
> >=20
> > I need to disagree on this as I don't even have PCR extends in my
> > boot sequence and it still adds overhead. Have you verified this
> > from the reporter?
> >=20
> > There's bunch of things that use auth session, like trusted keys.
> > Making such claim that PCR extend is the reason is nonsense.
>
> Well, the bug report does say it's the commit adding sessions to the
> PCR extends that causes the delay:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229#c5
>
> I don't know what else to tell you.

As far as I've tested this bug I've been able to generate similar costs
with anything using HMAC encryption. PCR extend op itself should have
same cost with or without encryption AFAIK.

I guess I need provide benchmarks on this to prove that PCR extend is
not the only site that is affected.

BR, Jarkko

