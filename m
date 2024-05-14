Return-Path: <linux-integrity+bounces-2396-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E88C58AF
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C791F229BD
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB517EB8A;
	Tue, 14 May 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZSQRfD3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932681459E4;
	Tue, 14 May 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700378; cv=none; b=nj98AyK7LkRpZwvoLw7h5AS6Vetldb4AuNBr0wLsrV4YWzpuDE3lh9DXYhSRuktPV95OWNph4mqKAqMSTndi0X47DnUZIqF33jxMa/rBEvGD2SoSih4nWwg/yJwLnJTejJPX5qywxaPZIDigxmVEmTb5kJgnu9SLCGKGqixXwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700378; c=relaxed/simple;
	bh=9KMbCQl0+iQEOyt5weo+F3V77somwAtxeW8gev83MFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZaKwx6+KBmBQ709PkE+SBmV+Uzr3Wyz/bnIsQD4ViiHh7qLdHPENJle2z3Hy/PzGCgCe9T4aRKBtR6GmqUCKtMJCWP8t0Y+uGZUQIzWjP3oL8QZxJhoFoi1YS/aDomZPh9791QiiLPB5OYNdKHxu20B/XKPmhxIfQwI+55+8YQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZSQRfD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D816FC32781;
	Tue, 14 May 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715700378;
	bh=9KMbCQl0+iQEOyt5weo+F3V77somwAtxeW8gev83MFI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bZSQRfD3b3TmCGmAoNlZP5Z+ti6zRY1bqgMeBI/7dcb1Vkxn0iM8re+TS+Y6IAB4e
	 YsufHqfDR3/7v+GtCiiZxlY0QN7/ZmTHR0AheCQAX9/sOMwyIFcE7oIuiw9buZy0Ah
	 qFDwoRQNjXJ7sDKot19XBwyO8RxEufqGNWrocmxJ8Nsxz37SGuRyhKcLKuMXB8hEuc
	 Pj+747hIVMeDxN2+1JyI/zWLmZW8BzjRVONbq8VZlhBU7VLGAJi9VhNbHptRwmASUC
	 C86rnMhHXjFIC+QTKvnzESbG1WVTFnxejqvfDeo5D0s9sO3Wt1j95TEUGCJnBoyHns
	 FCgnCFifkMHQQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 18:26:14 +0300
Message-Id: <D19H0UVF3R0O.3N4GLZWFRZ2DO@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>
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
In-Reply-To: <D19GWXHYP2VC.1OY7BOW5LNXVF@kernel.org>

On Tue May 14, 2024 at 6:21 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > > For example, a cheap NAS box with no internal storage (disks connec=
ted
> > > > externally via USB). We want:
> > > >   * disks to be encrypted and decryptable only by this NAS box
> > >
> > > So how this differs from LUKS2 style, which also systemd supports whe=
re
> > > the encryption key is anchored to PCR's? If I took hard drive out of =
my
> > > Linux box, I could not decrypt it in another machine because of this.
> >
> > Maybe you could replace the real LUKS2 header with a dummy LUKS2
> > header, which would need to be able the describe "do not use this" and
> > e.g. SHA256 of the actual header. And then treat the looked up header a=
s
> > the header when the drive is mounted.
> >
> > LUKS2 would also need to be able to have pre-defined (e.g. kernel
> > command-line or bootconfig) small internal storage, which would be
> > also encrypted with TPM's PRCs containing an array of LUKS2 header
> > and then look up that with SHA256 as the key.
> >
> > Without knowing LUKS2 implementation to me these do not sound reaching
> > the impossible engineer problems so maybe this would be worth of
> > investigating...
>
> Or why you could not just encrypt the whole header with another key
> that is only in that device? Then it would appear as random full
> length.
>
> I.e. unsealing
>
> 1. Decrypt LUKS2 header with TPM2 key
> 2. Use the new resulting header as it was in the place of encrypted
>    stored to the external drive.
> 3. Decrypt key from the LUK2S header etc.

Maybe something like:

1. Asymmetric for LUKS2 (just like it is)
2. Additional symmetric key, which is created as non-migratable and stored
   to the TPM2 chip. This deciphers the header, i.e. takes the random
   away.

BR, Jarkko

