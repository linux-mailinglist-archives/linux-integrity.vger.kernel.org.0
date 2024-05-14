Return-Path: <linux-integrity+bounces-2393-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B08C583F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9863FB2169B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4817BB37;
	Tue, 14 May 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9CV9EkU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96F3EA66;
	Tue, 14 May 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697954; cv=none; b=bI+ZuRrNXFKPeuIEihPbCqrIjd7/0/ISUGbTSkCXLgYJmYKppoYImAkC9FG1rCRDXqtc4TYcnOL6os7Dw/iBAQCwdRipa5ndCAPHT7u780obsTCXNuqgm2sMhBv8oNnpmusYoUzX7AkDKTgQB/4UdVo4hWwFMANf0u/ijrcWOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697954; c=relaxed/simple;
	bh=4tuLmuKyPPAsksDDdtfpJMRM0l1987d1hE3znuGBeDg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jhKnPBUrXW6/JlX6y7z0scosA1KtFWy+YUlFbrPTWDJ7lHElnPgnRjho9zSFzvcqkMjRgBeY/DQ1hr2xLlm63rqKxNEFZr/4LO470bad0UONT88aTducXzLS7pxOhJUFFH13f64Yd0UEnRu/Mn9CoOmZxaxXKrvVRBmtyUr+Mdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9CV9EkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082C7C2BD10;
	Tue, 14 May 2024 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697954;
	bh=4tuLmuKyPPAsksDDdtfpJMRM0l1987d1hE3znuGBeDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9CV9EkUOq/B2CQfJNAcKoeAd2nmHcNStoUO2luKUMUf1CzWliXW39l9PHxJHEaoP
	 xK0xOP2P0j2LUVnIU9fFKQsX3DCP3OEyAaw6gQSBoi3heJFPIJ3K7RqqXOI0Gq2wK9
	 74BR1gIuQfAnYFNT8NRYzqUXigLZL8cjkOVQqfIQ3My4hzt0bV2JBCO9M+BoXbUYi4
	 Ft58L66BYlAhgLzHUlE/BKz4v1+r3kM3x9lUxVHatluxLcGlFQT6GkuiCiN1N9ux4b
	 W5vV6q49+/oixFYij2DIY3CCqsAuTHtmhALwS0afroafQ7dv+Ps9m80tnhA/36VhsM
	 FjACYt7DWJhhA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 17:45:49 +0300
Message-Id: <D19G5WTFSJ40.1D0KEUQO6Q8AT@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
 <CALrw=nE_sV=1DnCx1eM8Sgno-di0yCaWHX467ZEf1Fddwg7_rA@mail.gmail.com>
In-Reply-To: <CALrw=nE_sV=1DnCx1eM8Sgno-di0yCaWHX467ZEf1Fddwg7_rA@mail.gmail.com>

On Tue May 14, 2024 at 5:41 PM EEST, Ignat Korchagin wrote:
> On Tue, May 14, 2024 at 3:00=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > For example, a cheap NAS box with no internal storage (disks connecte=
d
> > > externally via USB). We want:
> > >   * disks to be encrypted and decryptable only by this NAS box
> >
> > So how this differs from LUKS2 style, which also systemd supports where
> > the encryption key is anchored to PCR's? If I took hard drive out of my
> > Linux box, I could not decrypt it in another machine because of this.
>
> It differs with the fact that the disk has a clearly identifiable
> LUKS2 header, which tells an adversary that this is a disk with some
> data that is encrypted. With derived keys and plain dm-crypt mode
> there is no LUKS header, so it is not possible to tell if it is an
> encrypted disk or a disk with just random data. Additionally, if I
> accidentally wipe the sector with the LUKS2 header - all my data is
> lost (because the data encryption key from the header is lost). With
> derived keys I can always decrypt at least some data, if the disk is
> available.

I figured most of this out myself and sent a follow-up but yeah thnaks
for confirming my toughts. I get this part now.

Follow-ups to my follow-up...

BR, Jarkko

