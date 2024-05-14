Return-Path: <linux-integrity+bounces-2404-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C748C59AB
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B51C20F72
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E817F367;
	Tue, 14 May 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peUIeD6F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA72E644;
	Tue, 14 May 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703757; cv=none; b=NX2fl588dZdvWx6kvGrLzqIKIA1LHwDY9Wz1hYyF2tssaZTArjrD7GmxezvuOADLmH+fW6QqtJfH97zrck4Dw5Rn20+H8rna8yxwTxrevq+6uXxZz/If7qTBq8MvNgEHrtFjzprCDVVxL98McG6jQVvSurlz3TlRL+gLbZ464Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703757; c=relaxed/simple;
	bh=c1D5oPweUPm1QJ+Le24bvk/5IJRPjpfVxwksA/GvpoM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Bqlxm3KniHF2BkTAyhcd/h3hs2gPYiIlL14dGZTgRJB0HbUJRanTW4Vb+oylCEhVM7JbS2s5GIg6ZlkLXYzEEWykiHf4qXuux6+xhwQAVGk49suEeJ6/whZGrANRa9xCx4q9c7mkHViuJ1UiRW93ZiMd+jmcgOoWl0mV9izztwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peUIeD6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961EEC2BD10;
	Tue, 14 May 2024 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715703756;
	bh=c1D5oPweUPm1QJ+Le24bvk/5IJRPjpfVxwksA/GvpoM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=peUIeD6F6fjG1+0+vQ451kilofzGPLYKZ1lfae89jLvCXonvc40lDCP9daAfJ1Qrp
	 1fKKYGkqXPUaWkLQzF8M3BoshSYjw4dFnUwKQQyK8fHmjxuHg8Gqpmj0SAcITGIZgJ
	 LQpS5veRcA7n94ER2XA1K2J0vV58I7o/vJbfO1CPZUfpu92jEteRF7Pi948ZLFtE4o
	 WodY0vikN4K1XMcgmpN0Hjh9A+RtLk26o224r7wRj8xc3z17LDmyo6teKQ2KJG+r+q
	 7M5tJt9jmLfRCsMfI0vlU6nPbitq+7j0PyFi1nAErDGTG7cgDbL9hZDa6q2M8h93Sa
	 cONwTIZ8GLHMQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 19:22:32 +0300
Message-Id: <D19I7YXP7TMW.3QLJORO21LBXA@kernel.org>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
 <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>
 <D19GWXHYP2VC.1OY7BOW5LNXVF@kernel.org>
 <D19H0UVF3R0O.3N4GLZWFRZ2DO@kernel.org>
 <CALrw=nE7ga6wxSqrJBTOaj+pPXhi4+-Rn4ePRC9vXL-8Qd3GrA@mail.gmail.com>
 <D19HDMZ1OKN9.2PX2FJVY4WZ09@kernel.org>
 <CALrw=nF53qsmBp06qDerh3++0VYm-OZJ8k-Es3+2AAQFRjY-9w@mail.gmail.com>
In-Reply-To: <CALrw=nF53qsmBp06qDerh3++0VYm-OZJ8k-Es3+2AAQFRjY-9w@mail.gmail.com>

On Tue May 14, 2024 at 7:08 PM EEST, Ignat Korchagin wrote:
> On Tue, May 14, 2024 at 4:43=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Tue May 14, 2024 at 6:30 PM EEST, Ignat Korchagin wrote:
> > > On Tue, May 14, 2024 at 4:26=E2=80=AFPM Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > >
> > > > On Tue May 14, 2024 at 6:21 PM EEST, Jarkko Sakkinen wrote:
> > > > > On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> > > > > > On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > > > > > > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > > > > > > For example, a cheap NAS box with no internal storage (disk=
s connected
> > > > > > > > externally via USB). We want:
> > > > > > > >   * disks to be encrypted and decryptable only by this NAS =
box
> > > > > > >
> > > > > > > So how this differs from LUKS2 style, which also systemd supp=
orts where
> > > > > > > the encryption key is anchored to PCR's? If I took hard drive=
 out of my
> > > > > > > Linux box, I could not decrypt it in another machine because =
of this.
> > > > > >
> > > > > > Maybe you could replace the real LUKS2 header with a dummy LUKS=
2
> > > > > > header, which would need to be able the describe "do not use th=
is" and
> > > > > > e.g. SHA256 of the actual header. And then treat the looked up =
header as
> > > > > > the header when the drive is mounted.
> > > > > >
> > > > > > LUKS2 would also need to be able to have pre-defined (e.g. kern=
el
> > > > > > command-line or bootconfig) small internal storage, which would=
 be
> > > > > > also encrypted with TPM's PRCs containing an array of LUKS2 hea=
der
> > > > > > and then look up that with SHA256 as the key.
> > > > > >
> > > > > > Without knowing LUKS2 implementation to me these do not sound r=
eaching
> > > > > > the impossible engineer problems so maybe this would be worth o=
f
> > > > > > investigating...
> > > > >
> > > > > Or why you could not just encrypt the whole header with another k=
ey
> > > > > that is only in that device? Then it would appear as random full
> > > > > length.
> > > > >
> > > > > I.e. unsealing
> > > > >
> > > > > 1. Decrypt LUKS2 header with TPM2 key
> > > > > 2. Use the new resulting header as it was in the place of encrypt=
ed
> > > > >    stored to the external drive.
> > > > > 3. Decrypt key from the LUK2S header etc.
> > > >
> > > > Maybe something like:
> > > >
> > > > 1. Asymmetric for LUKS2 (just like it is)
> > > > 2. Additional symmetric key, which is created as non-migratable and=
 stored
> > > >    to the TPM2 chip. This deciphers the header, i.e. takes the rand=
om
> > > >    away.
> > >
> > > This could work, but you still have the problem of - if the header
> > > gets wiped, all the data is lost.
> > > As for storing things on the TPM chip - that doesn't scale. Today you
> > > only think about disk encryption, tomorrow there is a new application=
,
> > > which wants to do the same thing and so on. One of the features of
> > > derived keys - you don't store anything, just recreate/derive when
> > > needed and it scales infinitely.
> >
> > OK, so now I know the problem at least and that is probably the
> > most important thing in this discussion, right?
>
> Yes, I think so.
>
> > So make a better story, now you also probably have better idea,
> > also split the patch properly by subsystem, send the patch set,
>
> I'm actually not super clear on this part - I have two patches: one
> for TPM header definitions and another one for the keyring subsystem?
> Any other subsystems in play here?

You're absolutely right the split is fine. I look patches every
day so that must have stuck me somewhere else (sometimes does
happen).

Sorry.

> > and I'll promise to revisit.
>
> Thanks. Would probably take some time as I want to think more on the
> open questions I raised in the description, try to address some
> comments from James B from other replies (key rotation for example)
> and rebase on recently merged TPM encrypted sessions. But since this
> is an RFC I would like to continue the discussion and gather opinions
> from folks here, if there are any more concerns.

Yeah, not trying to argue of anything. Just have shoot with
stupid questions until it gets through, and not pretending
of understanding if I actually do not :-)

So I'll be ready once the next version is out.

>
> > Fair enough? :-)
> >
> > BR, Jarkko


BR, Jarkko

