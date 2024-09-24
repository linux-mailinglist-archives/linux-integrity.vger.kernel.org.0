Return-Path: <linux-integrity+bounces-3684-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA3984A48
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099151F23FBF
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398D1AC422;
	Tue, 24 Sep 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txKUjW7Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E01AAE13;
	Tue, 24 Sep 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198920; cv=none; b=GAH7iq192f8PRnHiILoOHMrL36xa3UMU7Xo/wbyISkkBlwdId2XktcOCnLzDysDRefAZx+T6heX1NRLrJmkze5EAA8syk7mxmd4TShKex7UvQswiCZfcP9A0OpxDKvC7IulaD42WUqAXfNM5j2X8nBYKIxYJ9EvZ4XJpBtNX6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198920; c=relaxed/simple;
	bh=4rXJ3Ug+ChU6kKShl/7blrYhseVKhyBFt5ThHO8h0kA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eCtuBUMWfAK2003ekKikSCBvVwycm/dqXBbSPcWSoaGbYs+U3qkA+xzbzNZ3OeZlrfmr7nX7QQZaVqTF+BKMbjuaNg94ppfPOyHPVchR9vjFXxiv3WjEWkg9Pof8Ek56W85hf0nAUiT5wKEb5huq98e3wlcNpnZJJCQdzqQIQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txKUjW7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A659C4CEC4;
	Tue, 24 Sep 2024 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727198919;
	bh=4rXJ3Ug+ChU6kKShl/7blrYhseVKhyBFt5ThHO8h0kA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=txKUjW7ZFaa57Y6T7xvWAGy+68LYLuEtBWkcjxgTdO+uNx6x8nIW2unJS5ndQRkn9
	 r+HTaW1bh3s/6eUe6SSUvRj81shRjS5HH2qySLXrV9xi+zreNAf3oNVjY5W9jEAtJc
	 5Q4c6ohu8TAUr55WmgAj8MW3+kIm2X7An9OQLytpl3+WBKwUBvhhmLj92ddeBTlNYD
	 I/4jmj8PHnbrK2GHK95jPJZUR6OoQiCHG7IWGTwG5tRwCcexY4Gpb/bxa1THqFml4/
	 35hW7/IjaxbA+UKnEylOrUFdLGNmw0lL+Fjs1D7v1/diUkVaZU0xiCVrbStx6hGjrY
	 0mAj2StFkCxTQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 20:28:35 +0300
Message-Id: <D4EOWZYNG3AS.1NW958Y0FK6NS@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
 <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
 <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
 <19a242eeabaa72dcc159c9c24fb412e3f68f8e7e.camel@HansenPartnership.com>
 <D4ENT15WZFRI.HA0FFVBWVISI@kernel.org>
 <D4EOVMA9YR3W.1X1ARMW6APFPP@kernel.org>
In-Reply-To: <D4EOVMA9YR3W.1X1ARMW6APFPP@kernel.org>

On Tue Sep 24, 2024 at 8:26 PM EEST, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 7:36 PM EEST, Jarkko Sakkinen wrote:
> > On Tue Sep 24, 2024 at 7:33 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-09-24 at 19:29 +0300, Jarkko Sakkinen wrote:
> > > > On Tue Sep 24, 2024 at 4:48 PM EEST, James Bottomley wrote:
> > > [...]
> > > > > Patch 3 is completely unnecessary: the null key is only used to
> > > > > salt the session and is not required to be resident while the
> > > > > session is used (so can be flushed after session creation)
> > > > > therefore keeping it around serves no purpose once the session is
> > > > > created and simply clutters up the TPM volatile handle slots. (I
> > > > > don't know of a case where we use all the slots in a kernel
> > > > > operation, but since we don't need it lets not find out when we g=
et
> > > > > one).=C2=A0 So I advise dropping patch 3.
> > > >=20
> > > > Let's go this through just to check I'm understanding.
> > > >=20
> > > > Holding null key had radical effect on boot time: it cut it down by
> > > > 5 secons down to 15 seconds:
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/CALSz7m1WG7fZ9UuO0URgCZEDG7=
r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com/
> > > >=20
> > > > Then in subsequent version I implemented lazy auth session and boot
> > > > time went down to 9.7 seconds.
> > > >=20
> > > > So is the point you're trying to make that since auth session is=20
> > > > already held as long as we can and they flushed in synchronous
> > > > point too, I can just as well drop patch 3?
> > >
> > > Yes, because the null key is only used in session generation which is
> > > now lazy, it adds or subtracts nothing from the timings.  When you're
> > > forced to flush the session, the null key goes too, so you again have
> > > to restore it from the context.  When you can keep the session you
> > > don't need the null key because you're not regenerating it.
> >
> > Yeah, OK, then we're in sync with this. It's evolutionary cruft.
> >
> > Just had to check that the logic matches how I projected your earlier
> > comment because these are sensitive changes.
>
> I'm definitely going keeep 1/5 and 2/5 as they are still bug fixes.
>
> So they will appear in v6 unchanged and perf fixes (which are not
> functional fixes) should not be built on top of broken code.

And 3/5 is actually required because it saves of doing flush during
the boot if nothing else.

We are wasting more time so I don't want to waste it for nothing.

BR, Jarkko

