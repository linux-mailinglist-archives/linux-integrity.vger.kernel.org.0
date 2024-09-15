Return-Path: <linux-integrity+bounces-3600-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA39797CD
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3DE281EC8
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C871C8FAA;
	Sun, 15 Sep 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpC6ELW6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0618B04;
	Sun, 15 Sep 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726417328; cv=none; b=XjlKIE6vit9d0U1gqCo7gPD/oJssLSp+s+GnY8PlhN5eRmlqKWoBZmAU1Vf0qSaH04+NAv8UEPNPTu4UbiEFZAvg8RFkyDysOQzIrSt7JYrZ7VnJ2rPhXP1yGPD1eO5k7swNxUDBmS64hiv9CzjHx2tAJgT6pgIvGoOrd5YWOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726417328; c=relaxed/simple;
	bh=Fq7ExgekfgiYR2Q2UUEbsFBFg9UlNjKP9oZ4jQg+N10=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A4YGTHfsRZZoFm7GgxPVUi5UJn6EPwTo3ud1aLxIXZq8RKPUu6nXs3MMCUE8asFbbVQeaCyt2izBaHn88vvC+OnrtMH70xcJ20wY62/DJKIbISkmEfmoX9484goL5WKgGmLLYdqvql05StLR1pSO6V+zxD25glPj0nNqlmmINFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpC6ELW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A47C4CEC3;
	Sun, 15 Sep 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726417327;
	bh=Fq7ExgekfgiYR2Q2UUEbsFBFg9UlNjKP9oZ4jQg+N10=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LpC6ELW61q80XTX72iF4DECJhAJ6/VBb2mr3poUPNGrgaIUMR/KQc+wrmmpce5l0N
	 eMUxvCKup90GEtZZFT7UI1x2EOhIfRS5wlyQDhFY1gkIGGbTCCPWgW3q+wH6vJRzUS
	 mvmGIw3C2eKrbJN190te3+5pqlJ91QL40gcYI8HpmjYLYrHutMh5h31xL1KkzOwTgp
	 OQjIWa0Gx65nTBWqwQf7k+XLbzQy82IznPWbg8Sp9jnPONMHa43C+UL0U+faw7YJkc
	 6Ylcu+imnuJW4NuB+HbiEJq7qKi+rdHvhyyMWvjBBRQqiRP6JWgX3AIWyBBeuZX/TI
	 fAexa6X22Zy4A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 19:22:04 +0300
Message-Id: <D46ZV5RXW7Z9.26N1IRXNRLV9X@kernel.org>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Roberto
 Sassu" <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
 <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
 <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
 <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>
 <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
 <7586c7e6e6028a734a8cac3d4b1a8504e6cd4b21.camel@HansenPartnership.com>
In-Reply-To: <7586c7e6e6028a734a8cac3d4b1a8504e6cd4b21.camel@HansenPartnership.com>

On Sun Sep 15, 2024 at 6:00 PM EEST, James Bottomley wrote:
> On Sun, 2024-09-15 at 17:50 +0300, Jarkko Sakkinen wrote:
> > On Sun Sep 15, 2024 at 4:59 PM EEST, James Bottomley wrote:
> > > On Sun, 2024-09-15 at 13:07 +0300, Jarkko Sakkinen wrote:
> > > > On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> > > > > When it comes to boot we should aim for one single
> > > > > start_auth_session during boot, i.e. different phases would
> > > > > leave that session open so that we don't have to load the
> > > > > context every single time.=C2=A0 I think it should be doable.
> > > >=20
> > > > The best possible idea how to improve performance here would be
> > > > to transfer the cost from time to space. This can be achieved by
> > > > keeping null key permanently in the TPM memory during power
> > > > cycle.
> > >=20
> > > No it's not at all.=C2=A0 If you look at it, the NULL key is only use=
d
> > > to encrypt the salt for the start session and that's the operating
> > > taking a lot of time.=C2=A0 That's why the cleanest mitigation would =
be
> > > to save and restore the session.=C2=A0 Unfortunately the timings you
> > > already complain about still show this would be about 10x longer
> > > than a no-hmac extend so I'm still waiting to see if IMA people
> > > consider that an acceptable tradeoff.
> >=20
> > The bug report does not say anything about IMA issues. Please read
> > the bug reports before commenting ;-) I will ignore your comment
> > because it is plain misleading information.
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> Well, given that the kernel does no measured boot extends after the EFI
> boot stub (which isn't session protected) finishes, what's your theory
> for the root cause?

I don't think there is a silver bullet. Based on benchmark which showed
80% overhead from throttling the context reducing number of loads and
saves will cut a slice of the fat.

Since it is the low-hanging fruit I'll start with that. In other words,
I'm not going touch session loading and saving. I'll start with null
key loading and saving.

BR, Jarkko

