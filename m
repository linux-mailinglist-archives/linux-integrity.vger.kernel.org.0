Return-Path: <linux-integrity+bounces-2400-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824EF8C58F8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6A1F230EB
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33117EBA1;
	Tue, 14 May 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6+bqjAs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1E4F602;
	Tue, 14 May 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701380; cv=none; b=FzifCEXItWxR9qLCCAcQl5my5t1R6/nuXkO8D+vJNt5kIYm148i4FAG3DCourRPm8ZXyeLMOghytaI5B9JaWLh9y5fXsV9mfSLkPHIgCzVZ0rsxF0R91QZ/K5X1vl6CIN83viKFJ8uiZZiuf94wfcgzq57pW0NeVnbcx78z6/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701380; c=relaxed/simple;
	bh=G9bkSXC/HoKB0LRGDSxJBNl76PuNphzWlxfBPUUC1Bk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u1j8I3LdYMNrYvO+CyS9wgs6SxM12aqbA/xm32hQauwiG0KgptaC7ZYWmKxxtjpkU9XeMvXWcpA8H3sOXUifEJeXJYpbv3bt1VrqJ3FQ07hc4oFVOxQtzknHfkBVOExSAAQHefOcZOfBCODfQT5ImUVuJh8zbu3ePj/jh0GSEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6+bqjAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BCCC2BD10;
	Tue, 14 May 2024 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715701379;
	bh=G9bkSXC/HoKB0LRGDSxJBNl76PuNphzWlxfBPUUC1Bk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=e6+bqjAsRsLFJsK41xwKJM90B0mBX/wOVREX64PWRayfubtXbnxCtKCKzpTjIFn+k
	 aW/8vgtd0qkpD0rCVb4EFpi/oZ+T0BvE5gYp/eC4HxdzM4U0SnpYUThMIzuQRMDc4x
	 FmtXsS6QqVTnUBjalpX1vaAEIppkDf2p70VyNjvSzUDtktOFAe771IOtGVpjF6g0aH
	 wioM1CoHnG/pzDPlpEMlCuN1NRLfqoFICtd5ik+P2Ic4Ky1XP3SXxLzxUrnziopZu3
	 XdA25xDL4uA1pemY7V6GwTmcxGasLKhNU2HBuX9NJqX625Xj4VeoioBGHzSEpVqndM
	 Un0cHzzROqxcw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 18:42:55 +0300
Message-Id: <D19HDMZ1OKN9.2PX2FJVY4WZ09@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
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
In-Reply-To: <CALrw=nE7ga6wxSqrJBTOaj+pPXhi4+-Rn4ePRC9vXL-8Qd3GrA@mail.gmail.com>

On Tue May 14, 2024 at 6:30 PM EEST, Ignat Korchagin wrote:
> On Tue, May 14, 2024 at 4:26=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Tue May 14, 2024 at 6:21 PM EEST, Jarkko Sakkinen wrote:
> > > On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> > > > On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > > > > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > > > > For example, a cheap NAS box with no internal storage (disks co=
nnected
> > > > > > externally via USB). We want:
> > > > > >   * disks to be encrypted and decryptable only by this NAS box
> > > > >
> > > > > So how this differs from LUKS2 style, which also systemd supports=
 where
> > > > > the encryption key is anchored to PCR's? If I took hard drive out=
 of my
> > > > > Linux box, I could not decrypt it in another machine because of t=
his.
> > > >
> > > > Maybe you could replace the real LUKS2 header with a dummy LUKS2
> > > > header, which would need to be able the describe "do not use this" =
and
> > > > e.g. SHA256 of the actual header. And then treat the looked up head=
er as
> > > > the header when the drive is mounted.
> > > >
> > > > LUKS2 would also need to be able to have pre-defined (e.g. kernel
> > > > command-line or bootconfig) small internal storage, which would be
> > > > also encrypted with TPM's PRCs containing an array of LUKS2 header
> > > > and then look up that with SHA256 as the key.
> > > >
> > > > Without knowing LUKS2 implementation to me these do not sound reach=
ing
> > > > the impossible engineer problems so maybe this would be worth of
> > > > investigating...
> > >
> > > Or why you could not just encrypt the whole header with another key
> > > that is only in that device? Then it would appear as random full
> > > length.
> > >
> > > I.e. unsealing
> > >
> > > 1. Decrypt LUKS2 header with TPM2 key
> > > 2. Use the new resulting header as it was in the place of encrypted
> > >    stored to the external drive.
> > > 3. Decrypt key from the LUK2S header etc.
> >
> > Maybe something like:
> >
> > 1. Asymmetric for LUKS2 (just like it is)
> > 2. Additional symmetric key, which is created as non-migratable and sto=
red
> >    to the TPM2 chip. This deciphers the header, i.e. takes the random
> >    away.
>
> This could work, but you still have the problem of - if the header
> gets wiped, all the data is lost.
> As for storing things on the TPM chip - that doesn't scale. Today you
> only think about disk encryption, tomorrow there is a new application,
> which wants to do the same thing and so on. One of the features of
> derived keys - you don't store anything, just recreate/derive when
> needed and it scales infinitely.

OK, so now I know the problem at least and that is probably the
most important thing in this discussion, right?

So make a better story, now you also probably have better idea,
also split the patch properly by subsystem, send the patch set,
and I'll promise to revisit.

Fair enough? :-)

BR, Jarkko

