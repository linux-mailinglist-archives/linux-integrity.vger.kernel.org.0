Return-Path: <linux-integrity+bounces-3654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EC97DD6E
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376571F219D5
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33B416DED5;
	Sat, 21 Sep 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgKli/CF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5AA47;
	Sat, 21 Sep 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726929495; cv=none; b=Ef/nR1H9UTowvjQ8bXh3arBaG2XPk4SZE0HObTBQWuBBD2QNHBN6tV/Ax46/BCTOCVIUueAmJMM04/a9a4nhpVxh9UDZlWCe60Gz2h0Qx43uHPU6+Gf5424M5Okkcf/ThR/ro1hli0QFsjNuU6Tuh08w1sjxJ9nDkXyoFdqR6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726929495; c=relaxed/simple;
	bh=rhYc03IAIsKRQv6i1mpLkXFUePErWwbLge6QrEecCUU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jthYupnEu5qI4d9UtZuVzBSHGxRwjgQnKB98AWr6fgy3eWB4pVKXFrI4nAl8dAfYAUqCuv6VyLvbbxOBs6+iZry3VF8B/DpkWLeseckjnnm5gHYhgfK+Og5tT1noLgQCvVO950Z0uC733P/mnKLGp+zwPQQr3wsQ+BoYShCWzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgKli/CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685E2C4CEC2;
	Sat, 21 Sep 2024 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726929494;
	bh=rhYc03IAIsKRQv6i1mpLkXFUePErWwbLge6QrEecCUU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jgKli/CFBL2UAcZS/AGmZUyW8V6ycBRUKTN5QOlO0MtSYOqz2yu3vOHY3MrF303EE
	 H4IGb26h6AxdMoTTyULXlurriWz7YxEASuyeCeXUF1qQQvwNqs+lnEXinIKle20VjE
	 5NVp4GFtOH7W09CN4mrqV6aimY/vfD6X/xmcknQ/16U6q6HaWXhorhLVMUInlZyNey
	 ddHk0TrVpHbU4K698hGxla6o/NxG8eOS3PbhmEj0pGvJPFG33T8ojtl6PK2DTC6kbm
	 m4AEUaNsPYBotKSZd2dg6T/nDsGTT+zTHEQkiXFmzd53Yydgn8OAvb+UBzSxUeWD2f
	 h/bb5bdacE85Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Sep 2024 17:38:10 +0300
Message-Id: <D4C1EVX2T5EW.1HPJFFD1ZA6YE@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Paul Menzel"
 <pmenzel@molgen.mpg.de>
Cc: <linux-integrity@vger.kernel.org>,
 <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "David Howells"
 <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <f9bbc8a7-4292-47a1-8987-b931284a7738@molgen.mpg.de>
 <D4BZLX10S23R.8CQD7UTH7AM1@kernel.org>
In-Reply-To: <D4BZLX10S23R.8CQD7UTH7AM1@kernel.org>

On Sat Sep 21, 2024 at 4:13 PM EEST, Jarkko Sakkinen wrote:
> On Sat Sep 21, 2024 at 3:36 PM EEST, Paul Menzel wrote:
> > Dear Jarkko,
> >
> >
> > Thank you for working on this and your patches.
> >
> > Am 21.09.24 um 14:08 schrieb Jarkko Sakkinen:
> > > This patch set aims to fix:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> >
> > If I am not mistaken this is about reducing the boot time, right? It=E2=
=80=99d=20
> > be great if you documented the numbers in the commit messages.
>
> So what you're asking is already documented by:
>
> 1. https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> 2. Tested-by
>
> I added lore link to the bugzilla bug, in order to address your comment.

... to the email which contains the figures.

20 s -> 8.7 s

BR, Jarkko

