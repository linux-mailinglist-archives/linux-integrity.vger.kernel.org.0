Return-Path: <linux-integrity+bounces-3597-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577797974F
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E0CB21181
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3811C8FAC;
	Sun, 15 Sep 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZxcmd0B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6B1C68A8;
	Sun, 15 Sep 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411844; cv=none; b=NQInwt1vnG6CxweE4x9oxvM6y4dt6+Utmrmx3+wc5PF9CLhPnjP5NZxOg83Mpfud33De+1Z/5y85MszHmvAxGJOTULJFruiUZcgPkOnt676Ga2PB8CQldD06EUOkiVadbUINVDni5FF0PExclIhvdjSI0A2aSeiAMjaX9jAtJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411844; c=relaxed/simple;
	bh=+pFOBVWQ+KCu7865fggG1AmPINb8pZIa+6bLlFOXDv4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=j4FzhDg1Sgi+GRneYubLSuWaarAz5F44mwBEyTVw71Cy3jb0CU9BCWG3Tmt3+VNFhfXFPJFxjZ5golXP4EsKuEVumcNYPEJVWOczfaQbJ48RRx5QYG3N9eIzUJG3zABc5FvKldo5aLuFF1JoAMrDl/LM0P6mF1RqNAst8cOuELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZxcmd0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE6C4CEC3;
	Sun, 15 Sep 2024 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726411843;
	bh=+pFOBVWQ+KCu7865fggG1AmPINb8pZIa+6bLlFOXDv4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UZxcmd0BbBZcKKkcEd6o4L1piat87Nm98axT+JAWwKAa/NNDCrrp5FSDttScp/KoO
	 8wZxA192KGK/xe9lGWkRGyBeaZjMDPZtmVOISqs1lTqHa+Jl3qMs5rd/vS4h23/WAy
	 3zwnRQTmAPPOy/C4dDXOn/aNK8E2T0Y3wCDBMQbsT9dbzgQJRtVc6NeU5dO4ZBvZ5H
	 mW2gCeuMHvuv17ku2O1b/vNmQJy4zR4vzQDLqyB+C3zZqJN3odKGK2yvyRRkE20umr
	 KTmKLO3vK5bAWyLBWdR3Mvcg4gU+cgDdYPdxHsTPDohCJJqzAYxQlwnuvbMKpTF2LC
	 XtA10y7kF7XwA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 17:50:40 +0300
Message-Id: <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Roberto
 Sassu" <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
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
In-Reply-To: <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>

On Sun Sep 15, 2024 at 4:59 PM EEST, James Bottomley wrote:
> On Sun, 2024-09-15 at 13:07 +0300, Jarkko Sakkinen wrote:
> > On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> > > When it comes to boot we should aim for one single
> > > start_auth_session during boot, i.e. different phases would leave
> > > that session open so that we don't have to load the context every
> > > single time.=C2=A0 I think it should be doable.
> >=20
> > The best possible idea how to improve performance here would be to
> > transfer the cost from time to space. This can be achieved by keeping
> > null key permanently in the TPM memory during power cycle.
>
> No it's not at all.  If you look at it, the NULL key is only used to
> encrypt the salt for the start session and that's the operating taking
> a lot of time.  That's why the cleanest mitigation would be to save and
> restore the session.  Unfortunately the timings you already complain
> about still show this would be about 10x longer than a no-hmac extend
> so I'm still waiting to see if IMA people consider that an acceptable
> tradeoff.

The bug report does not say anything about IMA issues. Please read the
bug reports before commenting ;-) I will ignore your comment because
it is plain misleading information.

https://bugzilla.kernel.org/show_bug.cgi?id=3D219229

>
> > It would give about 80% increase given Roberto's benchmark to all
> > in-kernel callers. There's no really other possible solution for this
> > to make any major improvements. So after opt-in kernel command line
> > option I might look into this.
> >=20
> > This is already done locally in tpm2_get_random(), which uses
> > continueSession to keep session open for all calls.
>
> The other problem if the session is context saved, as I already said,
> is that it becomes long lived and requires degapping the session
> manager.

I don't really care what you claim, I care what you code only at most.
Especially when topic shifted like it was now to IMA, which feels to
me like misguided communication tbh.

I don't think a round trip in kernel would qualify in that but there
is more low-hanging fruit too.

One low-hanging fruit improvement in the startup code is the handling
of null key. If it was flushed only on need, which means in practice
access to /dev/tpm0 or /dev/tpmrm0

I'm already working on patch set which adds chip->null_key that will
be flushed on-need basis only. I can measure with qemu how it affects
boot time.

BR, Jarkko

