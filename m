Return-Path: <linux-integrity+bounces-3696-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91598545A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 09:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944171F21BA4
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7C156F28;
	Wed, 25 Sep 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMqqLII9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB214B950;
	Wed, 25 Sep 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250144; cv=none; b=Qf2y+cDLCR8ZpLrZUcI3DFYLvC1vwWK9EWIwJ8dpKx+6o4DmUZEXqP/bZrKZ5a90wvz6rPfmO3Cd77zrauG5PHV2Puw44cx8rXrC3w1D+uUeCNyCshpvzzQedW/Kl2MaL8Lo0yS2wF7JoivKsBYEfqTvnP8LuhlJw2PJWf4dWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250144; c=relaxed/simple;
	bh=9ve0J8ohIJ9K3MhUzdqrB4TkyiG6Duo/wk9xoZ+FVnA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MYOTBzDC+d8pv4WGrLWlqMhCI3fCeGodcKCWE/Sqymjl5lYI6m3MnTXq4QZSEZxghXx32MWWPbQIl3jjyPV+eJn2lZIGyZmJPwt6HeFrpR66yW0OXaRAR/j7UnoSjFzWK+Cahcunk5xKgcZAxMVp137FB1tyuCuepzRDkYdUM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMqqLII9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D180DC4CEC3;
	Wed, 25 Sep 2024 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250144;
	bh=9ve0J8ohIJ9K3MhUzdqrB4TkyiG6Duo/wk9xoZ+FVnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMqqLII9mltW9L7xhuzHFLTI4cgs4vz5qdVYmu8BG77v/YTgjak4Dh3mwXP9UQ4eX
	 c8DuKgbslWvwPa36Yfaj2Xvys/QsOFwmZu29nDdG2IDsdTSGC78bCmojBcr9W2ERbr
	 FvY5oWn4Xp9ImVAuFwrddM3+x5Q2ssF87G5Hazhgdnman62xVF8dC9yRgQekNaYgUY
	 G6kzfeFIJ+4gZJso/NQztSBQ4+JG2dym0YhT1DBa+ENv6aG7ehgK2J0Z1OzfDcd7yp
	 5I3TcvkrujgXH38VCMH0NTGJcmJdke88FBlihI3dSEaSzDOvJBFJTheXEadAaqo0fl
	 Wn7xSEgaWy9qg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 10:42:20 +0300
Message-Id: <D4F72OC53B3R.TJ4FDFPRDC8V@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-6-jarkko@kernel.org>
 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
 <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
 <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>
 <D4EU5PQLA7BO.2J5MI195F8CIF@kernel.org>
 <2b4c10ca905070158a4bc2fb78d5d5b0f32950ad.camel@HansenPartnership.com>
In-Reply-To: <2b4c10ca905070158a4bc2fb78d5d5b0f32950ad.camel@HansenPartnership.com>

On Wed Sep 25, 2024 at 12:51 AM EEST, James Bottomley wrote:
> On Wed, 2024-09-25 at 00:35 +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 24, 2024 at 9:40 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-09-24 at 21:07 +0300, Jarkko Sakkinen wrote:
> > > > On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> > > > > On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > > > > > Instead of flushing and reloading the auth session for every
> > > > > > single transaction, keep the session open unless /dev/tpm0 is
> > > > > > used. In practice this means applying
> > > > > > TPM2_SA_CONTINUE_SESSION to the session attributes. Flush the
> > > > > > session always when /dev/tpm0 is written.
> > > > >=20
> > > > > Patch looks fine but this description is way too terse to
> > > > > explain how it works.
> > > > >=20
> > > > > I would suggest:
> > > > >=20
> > > > > Boot time elongation as a result of adding sessions has been
> > > > > reported as an issue in
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> > > > >=20
> > > > > The root cause is the addition of session overhead to
> > > > > tpm2_pcr_extend().=C2=A0 This overhead can be reduced by not
> > > > > creating and destroying a session for each invocation of the
> > > > > function.=C2=A0Do this by keeping a session resident in the TPM f=
or
> > > > > reuse by any session based TPM command.=C2=A0 The current flow of
> > > > > TPM commands in the kernel supports this because
> > > > > tpm2_end_session() is only called for tpm errors because most
> > > > > commands don't continue the session and expect the session to
> > > > > be flushed on success.=C2=A0 Thus we can add the continue session
> > > > > flag to session creation to ensure the session won't be flushed
> > > > > except on error, which is a rare case.
> > > >=20
> > > > I need to disagree on this as I don't even have PCR extends in my
> > > > boot sequence and it still adds overhead. Have you verified this
> > > > from the reporter?
> > > >=20
> > > > There's bunch of things that use auth session, like trusted keys.
> > > > Making such claim that PCR extend is the reason is nonsense.
> > >=20
> > > Well, the bug report does say it's the commit adding sessions to
> > > the PCR extends that causes the delay:
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229#c5
> > >=20
> > > I don't know what else to tell you.
> >=20
> > As far as I've tested this bug I've been able to generate similar
> > costs with anything using HMAC encryption. PCR extend op itself
> > should have same cost with or without encryption AFAIK.
>
> That's true, but the only significant TPM operation in the secure boot
> path is the PCR extend for IMA.  The RNG stuff is there a bit, but
> there are other significant delays in seeding the entropy pool.  During
> boot with IMA enabled, you can do hundreds of binary measurements,
> hence the slow down.
>
> > I guess I need provide benchmarks on this to prove that PCR extend is
> > not the only site that is affected.
>
> Well, on the per operation figures, it's obviously not, a standard TPM
> operation gets a significant overhead because of sessions. However, it
> is the only site that causes a large boot slowdown because of the
> number of the number of measurements IMA does on boot.

Fair enough. I can buy this.

I'll phrase it that (since it was mentioned in the bugzilla comment)
in the bug in question the root is in PCR extend but since in my own
tests I got overhead from trusted keys I also mention that it overally
affects also that and tpm2_get_random().

>
> Regards,
>
> James

BR, Jarkko

