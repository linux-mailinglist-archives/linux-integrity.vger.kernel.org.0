Return-Path: <linux-integrity+bounces-3680-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC59849A0
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F21A1C20878
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796AF1AB6E4;
	Tue, 24 Sep 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXTw8RmA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49033D531;
	Tue, 24 Sep 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195365; cv=none; b=KdvlU0xeeiqbZ3/jEJQL0stOG7Ixg8FN6r8zt1iS73YB0B5g4E9llk3mmnA5qITfNj9b62bqWFxU3SWKBkFyTxAFY4dROcv5VdH/bjJrkjiR7K9xFeXG9Il2QSmS6sMj+IivbEd4KQ8pFfDvW6ItRhpk0vmxdxzZuFlTZR7wte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195365; c=relaxed/simple;
	bh=e5QIhvKs5LENAO7Bu7T9ljRq0OrFUzWyWsn/utgn7Y4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qt0pE+QXxpDSQHoJDY1fxTVAIiJZcZRMApcikdaYbVm17fDnI0UGWlXuzHWrgKPP/HsPVxWze4gIZ8nXYAcy/v3uHqbCvNDO/+JLXeeUB4o0iIfcxZq+bZZrFjidrLBsDfFogCoRz4cuDlorPapGCdDj9UfcTy08jd9fkN1GOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXTw8RmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C480C4CEC4;
	Tue, 24 Sep 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195364;
	bh=e5QIhvKs5LENAO7Bu7T9ljRq0OrFUzWyWsn/utgn7Y4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aXTw8RmA1WzEtnUAjUC+dX8A273IPQZ+4Bh7+4RL3hlCBg7tnNV6cRD097rulmZ7B
	 UUZjI+4gH0GduKgyS65VZnpo/5GRoC4WUtrjA6D2AUgmMSK0GHuPYOJHbRGGrrJiPM
	 9CTcjF0Op75nb3a+npqjMSuGF4NzmdiIDcIchF0zFpUu6nt++jRIC7yTh9swLXFvy2
	 M49j/Y6YOEPiniPcifAEFRoj8kF5O4sqet/Bkmgo9s5fKyPWcKRzqtbWK6EWYJvWVn
	 weUpm8jv7QJzOCYwfIsWlatm6UpcFyGL7vz6C++dcXVVund0NepmD1eSnq612447Mw
	 7NXkdC0RW1Z6Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 19:29:21 +0300
Message-Id: <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
 <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
In-Reply-To: <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 4:48 PM EEST, James Bottomley wrote:
> On Sun, 2024-09-22 at 20:51 +0300, Jarkko Sakkinen wrote:
> > On Sat Sep 21, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > > This patch set aims to fix:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> > >=20
> > > The baseline for the series is the v6.11 tag.
> > >=20
> > > v4:
> > > https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkk=
o@kernel.org/
> > > v3:
> > > https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkk=
o@kernel.org/
> > > v2:
> > > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jark=
ko@kernel.org/
> > > v1:
> > > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jark=
ko@kernel.org/
> > >=20
> > > Jarkko Sakkinen (5):
> > > =C2=A0 tpm: Return on tpm2_create_null_primary() failure
> > > =C2=A0 tpm: Implement tpm2_load_null() rollback
> > > =C2=A0 tpm: flush the null key only when /dev/tpm0 is accessed
> > > =C2=A0 tpm: Allocate chip->auth in tpm2_start_auth_session()
> > > =C2=A0 tpm: flush the auth session only when /dev/tpm0 is open
> > >=20
> > > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 14 ++++
> > > =C2=A0drivers/char/tpm/tpm-dev-common.c |=C2=A0=C2=A0 8 +++
> > > =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0 |=C2=A0 10 ++-
> > > =C2=A0drivers/char/tpm/tpm2-cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 3 +
> > > =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0 | 109 ++++++++++++++++++=
--------
> > > ----
> > > =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A06 files changed, 102 insertions(+), 44 deletions(-)
> >=20
> >=20
> > Roberto, James, speaking of digest cache. This patch set has no aim
> > to fix those issues but I do believe that it should improve also that
> > feature.
> >=20
> > If I don't get soon patch reviews for the patch set, I'll pick the
> > 2nd best option: disable bus encryption on all architectures
> > including x86 and ARM64 (being by default on).
> >=20
> > It's a force majeure situation. I know this would sort out the issue
> > but I really cannot send these as a pull request with zero reviewe-
> > by's.
> >=20
> > I expect this to be closed by tomorrow.
>
> Hey come on, you knew I was running plumbers last week so I had all the
> lead up and teardown stuff to do as well.  I'm only just digging
> through accumulated email.

Fair enough, I actually do not want to disable the feature. That
was my main concern here. Now if we get this fixed we might be
able to revisit earlier decisions on defconfig and widen the
support eventually, not shrink it.


>
> Patches 1-2 are fully irrelevant to the bug, so I ignored them on the
> grounds that improvement to the error flow could be done through the
> normal patch process

Hmm.. I'll revisit this for v6. Not sure what to say on this yet
because I need to address the other remarks and based on that
reflect. So might drop or keep them but not 100% sure yet.


> Patch 3 is completely unnecessary: the null key is only used to salt
> the session and is not required to be resident while the session is
> used (so can be flushed after session creation) therefore keeping it
> around serves no purpose once the session is created and simply
> clutters up the TPM volatile handle slots. (I don't know of a case
> where we use all the slots in a kernel operation, but since we don't
> need it lets not find out when we get one).  So I advise dropping patch
> 3.

Let's go this through just to check I'm understanding.

Holding null key had radical effect on boot time: it cut it down by
5 secons down to 15 seconds:

https://lore.kernel.org/linux-integrity/CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_=
4mOHJThH_d1Ed1nw@mail.gmail.com/

Then in subsequent version I implemented lazy auth session and boot
time went down to 9.7 seconds.

So is the point you're trying to make that since auth session is=20
already held as long as we can and they flushed in synchronous
point too, I can just as well drop patch 3?

I think I reach your point but just want to check that I do it
for the matching reasons. It is evolutionary cruft in the patch
set :-)

BR, Jarkko

