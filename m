Return-Path: <linux-integrity+bounces-3501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511EB9737A0
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16C11F254FA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FB19149F;
	Tue, 10 Sep 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzmYGBwR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF588184522;
	Tue, 10 Sep 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971950; cv=none; b=fX+w9WdmjaADVOqcjamZSJpZOX9BQNh4GxS2axFcpxjmuqC+5SLS5F98dHm5ndlQ7ftWVwaolLIidjhbHAokB7AR3RaphiR/Pw1EiMZC41ZH5j9vTXNW6nnL3IMiX5e/cb+LG3o8tbVA8Jl4+rZVjYi0nSw5FoQVCxz0OzVU4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971950; c=relaxed/simple;
	bh=4pA6APXmYoJFw+7ItjSMDOPbrsRxS0JVM6V7ix/HD9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eAqDRexbHbbzSwhCLbk0yDtC024iQ/jwYHJKdo14w3SJXx2Spxf3NvIMi2IPNNF0aRCpEfUbS90HnIKPgIyXIo4zalkmLr2ErOcQOyE8/e6Ib+tZW4yNpAg695As9au5cg1NImcSM9+VATkCRCAfWMtRc7TBux7UkPo/T8x7aP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzmYGBwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF547C4CED6;
	Tue, 10 Sep 2024 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725971949;
	bh=4pA6APXmYoJFw+7ItjSMDOPbrsRxS0JVM6V7ix/HD9o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=KzmYGBwR2ZRY/TggMH6KHqHagLhTq4ea6pDxURyf2jDtYFVkXehvPyNd1ZeEUjeJg
	 WloFnmtLS07DBgLUUxwjSz+W0ObxXYCeTk75ZiUmkaRKrX+ZMRDVIqQrf9eVCNxAuD
	 ZyOf5AB95UbGasBB9vsFCl7ZLjQ1Aum68MaOWfyjWfI853pSOvLcIVk3NCEatVz4Hv
	 a+7zOx19vqH+pOG+hc+g7Lm9ZoqVZkTY9oNjpRVOBhg5T4sIxq9bMb/0752zyUQzZY
	 A/jZUkF0TBwnPHUUxzGVLBnMJwKPY/vX/sUIVu25GSAdvppn4QlPrKVm3OckKEJrEf
	 00I1dNUEWikXA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 15:39:05 +0300
Message-Id: <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "Linux regressions
 mailing list" <regressions@lists.linux.dev>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
In-Reply-To: <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>

On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> >=20
> > James, Jarkoo, I noticed a report about a regression in
> > bugzilla.kernel.org that appears to be caused by this change of yours:
> >=20
> > 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-rc1=
]
> >=20
> > As many (most?) kernel developers don't keep an eye on the bug tracker,
> > I decided to forward it by mail. To quote from
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229 :
> >=20
> > > When secureboot is enabled,
> > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > it's ~7 seconds on 6.8 kernel version.
> > >=20
> > > When secureboot is disabled,
> > > the boot time is ~7 seconds too.
> > >=20
> > > Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> > >=20
> > > It probably caused autologin failure and micmute led not loaded on AM=
D platform.
> >=20
> > It was later bisected to the change mentioned above. See the ticket for
> > more details.
>
> Hi
>
> I suspect I encountered the same problem:
>
> https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10ede0d57=
4d8930e.camel@huaweicloud.com/
>
> Going to provide more info there.

I suppose you are going try to acquire the tracing data I asked?
That would be awesome, thanks for taking the troube.  Let's look
at the data and draw conclusions based on that.

Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=3Dn to the kernel
configuration disables the feature.

For making decisions what to do with the  we are talking about ~2
week window estimated, given the Vienna conference slows things
down, so I hope my workaround is good enough before that.

> Roberto

BR, Jarkko

