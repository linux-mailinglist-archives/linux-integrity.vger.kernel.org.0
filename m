Return-Path: <linux-integrity+bounces-2300-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6A8B82E9
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2024 01:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85DAB23CE3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1764181305;
	Tue, 30 Apr 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VacM079c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F786126;
	Tue, 30 Apr 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518656; cv=none; b=lrfS7exwKsoVvAYnSjAvkYuh3DeCOzQVYGUsuZjwOAeOwVVWSP5gS/ZTKQap/7RUuC4LiRU9bkbSxwGNL/qMlxd2D4GdOjRcUd9DbTW68keiTkR3c+gY+Vfqf2Ez0gAMYwL+DmQIgxz1b0CzGJsm2EwsH9xQ4r/09hxOLPP+Xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518656; c=relaxed/simple;
	bh=3ozd/dLNcaXnTupI3HAH0T+oR/ZIay1YmFEmUpy28xo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=kV90m1kCq72++lxNw0F528UUlFQZN9jeT5KIIMaPQrkQM4h5p74uybJ8ZsPsBy+EiDAU1Br5xK0bt7zKowQ9Qo0Nmgiv5W8WpzUEKJMJ8z2VG0R2lierL4yMhPwTGAsSX7+LmOqup8AKPlzifNFY0Rvem6TcPAo6FTqaw34BQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VacM079c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8874C2BBFC;
	Tue, 30 Apr 2024 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714518656;
	bh=3ozd/dLNcaXnTupI3HAH0T+oR/ZIay1YmFEmUpy28xo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VacM079cPoTyPXAUN9PlNLBJXYLMcy1bq3KX++VvFj5beHChjaRBwsgve8wrlCfIP
	 aYY2yugdE2B3JmwImqANpbJBZDWwJMLHYx3tdjTcZDStnmqpWDLlXC2lPzb0n4WCm6
	 RRQ8vSwVa45aKUm9I3tbO3j+p/0vw3qeexfcDFHXcIDoEkmcSjMOPhlTv1fr5JBNum
	 3HauCoYf840uCb5JRdZufCbpchsWtY9irV/WH/suzVIyMJs5YxT6pkKe4z9ynZ5rke
	 W2b7Aa2Q6aXvkj0zOHMZaRe2IyWri6MAESKZWt8a84/FP/TldviO+a1QIVf4vPryKR
	 KIVck1KEV0i3A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 02:10:53 +0300
Message-Id: <D0XU4ZTRCD68.2EMZX03QA4I4@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <eef3292f4680c22b817021f973a34a1657b82c86.camel@HansenPartnership.com>
 <D0XSE6G33OHS.1B4OFPN0NCEIM@kernel.org>
 <c175a43a1c33a9513e3319e7b29e3985a140b4da.camel@HansenPartnership.com>
 <D0XTMODYQ0MO.38N6NKD1SYOXI@kernel.org>
In-Reply-To: <D0XTMODYQ0MO.38N6NKD1SYOXI@kernel.org>

On Wed May 1, 2024 at 1:46 AM EEST, Jarkko Sakkinen wrote:
> On Wed May 1, 2024 at 1:31 AM EEST, James Bottomley wrote:
> > On Wed, 2024-05-01 at 00:48 +0300, Jarkko Sakkinen wrote:
> > > On Tue Apr 30, 2024 at 10:23 PM EEST, James Bottomley wrote:
> > > > On Tue, 2024-04-30 at 01:22 +0300, Jarkko Sakkinen wrote:
> > [...]
> > > > > Since I could not find the email subthread I neither have the
> > > > > patch nor do know the baseline. So if you could help with these
> > > > > details then we can move forward.
> > > > >=20
> > > > > I can also work with QEMU Git fork if you have one and point out
> > > > > QEMU_OVERRIDE_SRCDIR to the clone.
> > > >=20
> > > > I only have the patches in a local git repository, but I could push
> > > > qemu up onto kernel.org if it would help?
> > >=20
> > > That definitely does help. I can point out my build to that
> > > repository, (or actually clone of it).
> >
> > OK, it's the mssim branch here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/qemu.git/log/?h=3D=
mssim
> >
> > It's based on qemu head, but it works for me.
> >
> > James
>
> OK, cool. I'll test this on Thursday as tomorrow is national holiday
> in Finland. However, I'll quickly just try it in my host before going
> to sleep (if there is any feedback to be given).
>
> I happen to run Tumbleweed nowadays so I can just install ibmswtpm2
> package, i.e. should take only a short while.

OK, so I got to the point that I can startup a VM with mssim so I'll
do the "final test" Thursday :-)

I have no time to review the qemu patches but you could add my
tested-by if you want to those.

BR, Jarkko

