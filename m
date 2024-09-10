Return-Path: <linux-integrity+bounces-3503-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F089737DA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C281F263B7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1529190676;
	Tue, 10 Sep 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G75tqmt8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB21DFE8;
	Tue, 10 Sep 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972495; cv=none; b=ScBUYFIpEgLM9nDLyjpbePbN/JvHPvxhYgF84KSrM+Uxe8JHXaGoBabYU2EFj7Mc+9C63anQg2MbsJdWk1TxMmlysyB3xstkNLxY8C8DK9ddp/YUXlVf4fYSBqdabQUYj7HDuHOQikpujkjmWtNHUI6s6+iXsC3qwgYoKQcH6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972495; c=relaxed/simple;
	bh=DYQM7tOuNKYk1zdCuWXkCdrgzFIYWM6dNKwjkQu+sAs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZWndcno3cmc3hARR8ewCkyg15mUz7HvXZzC1RirQQCCGqYmbwQh5iyYfPOM1Dn+qJcVaT6Q/YLodzlxbhqQbvsDP5ThnC5fg7oPVOiOvwmaeci9KUc6+2Cy2onV7tutGGRghh/cb0TNlEJjU13AUu5dt0i9ZzYkVq+uq7a4bkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G75tqmt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAB2C4CEC3;
	Tue, 10 Sep 2024 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972495;
	bh=DYQM7tOuNKYk1zdCuWXkCdrgzFIYWM6dNKwjkQu+sAs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=G75tqmt8UPYZCBNbIHZZNU5BUJRO6hvJ2OjXrclDs5/88Nm7E+upYWMMzgw4pxSp2
	 XRTeKQD28garK3imjno+tsFV7b4J4umQiJSemUMRy/LZhTnK1aq3ijrFPy0dEAkBiD
	 YmMHJLh2jZmrLWd0qrYrLhgCDJMU++FaunpO0UERsa47XZ18YKrJTE7ozlElvTwLBw
	 e8XNYFImGu4Iaz7I9u8DLqqrru49Bhxdlh5M9+pyNd1sotCvz2bMEaxy2FobpDCjF7
	 rLJvspB54TJwxZmmOWIURT/LKa5YEzeYumqm5xP0f5oR97cv6v80QgJPIy6c5eGd4Q
	 f4gLXjgESF+gw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 15:48:11 +0300
Message-Id: <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
In-Reply-To: <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>

On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > >=20
> > > James, Jarkoo, I noticed a report about a regression in
> > > bugzilla.kernel.org that appears to be caused by this change of yours=
:
> > >=20
> > > 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-r=
c1]
> > >=20
> > > As many (most?) kernel developers don't keep an eye on the bug tracke=
r,
> > > I decided to forward it by mail. To quote from
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229 :
> > >=20
> > > > When secureboot is enabled,
> > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > it's ~7 seconds on 6.8 kernel version.
> > > >=20
> > > > When secureboot is disabled,
> > > > the boot time is ~7 seconds too.
> > > >=20
> > > > Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> > > >=20
> > > > It probably caused autologin failure and micmute led not loaded on =
AMD platform.
> > >=20
> > > It was later bisected to the change mentioned above. See the ticket f=
or
> > > more details.
> >
> > Hi
> >
> > I suspect I encountered the same problem:
> >
> > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10ede0d=
574d8930e.camel@huaweicloud.com/
> >
> > Going to provide more info there.
>
> I suppose you are going try to acquire the tracing data I asked?
> That would be awesome, thanks for taking the troube.  Let's look
> at the data and draw conclusions based on that.
>
> Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=3Dn to the kernel
> configuration disables the feature.
>
> For making decisions what to do with the  we are talking about ~2
> week window estimated, given the Vienna conference slows things
> down, so I hope my workaround is good enough before that.

I can enumerate three most likely ways to address the issue:

1. Strongest: drop from defconfig.
2. Medium: leave to defconfig but add an opt-in kernel command-line
   parameter.
3. Lightest: if we can based on tracing data nail the regression in
   sustainable schedule, fix it.

Without data it is impossible to point out the right choice (or
some unknown alternative that has not crossed my mind yet).

BR, Jarkko

