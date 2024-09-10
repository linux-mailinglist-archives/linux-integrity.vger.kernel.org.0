Return-Path: <linux-integrity+bounces-3505-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F25973897
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6BC1F24FD3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFE18FDDF;
	Tue, 10 Sep 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHU9oAN3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E97187555;
	Tue, 10 Sep 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974888; cv=none; b=G+i9WQ0CdlF0e9W0idly+iB1xXCYV/7xh6Z8+4ZdFB4rWvhqZKgpCp2/eknYnwd5m5FDA+dW65YxD9JQXi5ufP1qf38YdD50yPLunvgi8WWgPfmphsbXZ2pqiMm0k/16EJQwFzUdonz49j+dQfoqnIbgZ7bb0d3BXQRReoA4vyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974888; c=relaxed/simple;
	bh=uODzBuQjKGBNIgEh2rm1O0qYGbC6BxmbmT5KdxpbNTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XDkfnKQbtAJ6G6ZGTDYUR0TFKrFXG7+s/+tZaAzJwU+2fpXCJq5imeahKfTwUvEAgRtQIIQ5Uj45z7cdneUxXOqRij+LKeP/KWWTUQjNRga4Tfsn+MBWFG8t645IErhHtvFftNPw3PYD17eDlRr8aj/GyoF+u13S0/NSUyLdWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHU9oAN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922EDC4CEC3;
	Tue, 10 Sep 2024 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725974887;
	bh=uODzBuQjKGBNIgEh2rm1O0qYGbC6BxmbmT5KdxpbNTs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MHU9oAN37eRifHBu26IFFWjnutvPksjhQeBYCIHS328EeOu405uOtoAvY2Vat5XQR
	 s/RKBPjWQDXpjInqMDdUgb13OaQjR+HczbtNGosh6Fstjc+hEnonTBl46ufYGgkPhH
	 sx0m1S5kmJy/Q8nAW2Rl9fnTxXLX69Mzv9Un30asM08YXCyzvdVGmvjH1Aqg4Yjpvl
	 8XCRFY+FqHEl6iMWc1ibKqzUHx2cgZtnxTBQ+y6qwQ5mTUpFwxcQbWAksFjPmdTuqJ
	 /vCwSR+e+Dcdtc4cYdQ7RwLQ06CSjG0bhzeqpCs08qHGfosrCnyIz+6iAFDtWUKMyi
	 Gwfxo+3Q4p73Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 16:28:04 +0300
Message-Id: <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
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
In-Reply-To: <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>

On Tue Sep 10, 2024 at 3:57 PM EEST, James Bottomley wrote:
> On Tue, 2024-09-10 at 15:48 +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> > > On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > > > On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking
> > > > (Thorsten
> > > > Leemhuis) wrote:
> > > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > >=20
> > > > > James, Jarkoo, I noticed a report about a regression in
> > > > > bugzilla.kernel.org that appears to be caused by this change of
> > > > > yours:
> > > > >=20
> > > > > 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()")
> > > > > [v6.10-rc1]
> > > > >=20
> > > > > As many (most?) kernel developers don't keep an eye on the bug
> > > > > tracker,
> > > > > I decided to forward it by mail. To quote from
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229=C2=A0:
> > > > >=20
> > > > > > When secureboot is enabled,
> > > > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > > > it's ~7 seconds on 6.8 kernel version.
> > > > > >=20
> > > > > > When secureboot is disabled,
> > > > > > the boot time is ~7 seconds too.
> > > > > >=20
> > > > > > Reproduced on both AMD and Intel platform on ThinkPad X1 and
> > > > > > T14.
> > > > > >=20
> > > > > > It probably caused autologin failure and micmute led not
> > > > > > loaded on AMD platform.
> > > > >=20
> > > > > It was later bisected to the change mentioned above. See the
> > > > > ticket for
> > > > > more details.
> > > >=20
> > > > Hi
> > > >=20
> > > > I suspect I encountered the same problem:
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10e=
de0d574d8930e.camel@huaweicloud.com/
> > > >=20
> > > > Going to provide more info there.
> > >=20
> > > I suppose you are going try to acquire the tracing data I asked?
> > > That would be awesome, thanks for taking the troube.=C2=A0 Let's look
> > > at the data and draw conclusions based on that.
> > >=20
> > > Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=3Dn to the kernel
> > > configuration disables the feature.
> > >=20
> > > For making decisions what to do with the=C2=A0 we are talking about ~=
2
> > > week window estimated, given the Vienna conference slows things
> > > down, so I hope my workaround is good enough before that.
> >=20
> > I can enumerate three most likely ways to address the issue:
> >=20
> > 1. Strongest: drop from defconfig.
> > 2. Medium: leave to defconfig but add an opt-in kernel command-line
> > =C2=A0=C2=A0 parameter.
> > 3. Lightest: if we can based on tracing data nail the regression in
> > =C2=A0=C2=A0 sustainable schedule, fix it.
>
> Actually, there's a fourth: not use sessions for the PCR extend (if
> we'd got the timings when I asked, this was going to be my suggestion
> if they came back problematic).  This seems only to be a problem for
> IMA measured boot (because it does lots of extends).  If necessary this
> could even be wrapped in a separate config or boot option that only
> disables HMAC on extend if IMA (so we still get security for things
> like sd-boot)

I can buy that but with a twist that make it an opt-in kernel command
line option. We don't want to take already existing functionality away
from those who might want to use it (given e.g. hardening requirements),
and with that basis opt-in (by default disabled) would be more balanced
way to address the issue.

Please do a send a patch!

BR, Jarkko

