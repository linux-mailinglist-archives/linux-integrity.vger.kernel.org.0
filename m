Return-Path: <linux-integrity+bounces-3682-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC59849C6
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F41F25CF3
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88311AB6F6;
	Tue, 24 Sep 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ8GcDQE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772D1AAE0D;
	Tue, 24 Sep 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195787; cv=none; b=AhS6Qenaty+MAScdWF4kqI/5hByRWUUINGJ7eCGK1lPNX++MQB4sQOIKK7chz36yzMT21WLUbcY3Zs1FMdbYyfybJjhJlNWBZVLFIVB9qzqRLdFPdRLznS1LD21PhndjfLUlaxO5Zs5jdIIxyrU55nbzDfYUIK04lp0FOrD2guU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195787; c=relaxed/simple;
	bh=HjBIuX5FaD8TNAF4/04sGMON9kjAruI8oBmc8dJVfzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nuvhDwdQXwWtHB/kQ7cHNId1azFG0hBTVhtyo/G6BOyAfcVBtgdQuefoWvHSwxT4ATXAxhsh4kV3cGgVh5dFMrHzwRO1SUFhjxRtbw+1HzMaki95mZW2zOOT8uMjoHh7TuzFeyFIFZHy6AR8+P62rynrcjogcblYimbfuMULvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ8GcDQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD5FC4CEC4;
	Tue, 24 Sep 2024 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195787;
	bh=HjBIuX5FaD8TNAF4/04sGMON9kjAruI8oBmc8dJVfzY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TJ8GcDQEebVn8OzKc+fZ2+176kojOeR6YzfVucATXXLG/hNRhnM+5nXVbjARs1eGg
	 +duj7+mNc7DppMQcVXfKGz7OGF8dgxnuJEDM2rUswB0+BHyRnuufQsP6dXL/a9L4ng
	 ZNEc3f0j3XTOdxZrPCiUfZC3Htbpm22t+YCVxjFjCB0WkxwO4w1FjYbqDQz2aFRumY
	 C3TZZbgB7BklJ8+PT8Z60w6yQEmTQ79j44hp99fkvUz4MSgypbRbQN4Hv9pphHJAp7
	 R5FfmuZo7UIz6zDSYjdityEZqEwWEtrlRO3AJIzEUUc/exdY7CPj5Ci8viN6MTF8JR
	 rjrV5rSYn7qRw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 19:36:23 +0300
Message-Id: <D4ENT15WZFRI.HA0FFVBWVISI@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
 <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
 <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
 <19a242eeabaa72dcc159c9c24fb412e3f68f8e7e.camel@HansenPartnership.com>
In-Reply-To: <19a242eeabaa72dcc159c9c24fb412e3f68f8e7e.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 7:33 PM EEST, James Bottomley wrote:
> On Tue, 2024-09-24 at 19:29 +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 24, 2024 at 4:48 PM EEST, James Bottomley wrote:
> [...]
> > > Patch 3 is completely unnecessary: the null key is only used to
> > > salt the session and is not required to be resident while the
> > > session is used (so can be flushed after session creation)
> > > therefore keeping it around serves no purpose once the session is
> > > created and simply clutters up the TPM volatile handle slots. (I
> > > don't know of a case where we use all the slots in a kernel
> > > operation, but since we don't need it lets not find out when we get
> > > one).=C2=A0 So I advise dropping patch 3.
> >=20
> > Let's go this through just to check I'm understanding.
> >=20
> > Holding null key had radical effect on boot time: it cut it down by
> > 5 secons down to 15 seconds:
> >=20
> > https://lore.kernel.org/linux-integrity/CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB=
4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com/
> >=20
> > Then in subsequent version I implemented lazy auth session and boot
> > time went down to 9.7 seconds.
> >=20
> > So is the point you're trying to make that since auth session is=20
> > already held as long as we can and they flushed in synchronous
> > point too, I can just as well drop patch 3?
>
> Yes, because the null key is only used in session generation which is
> now lazy, it adds or subtracts nothing from the timings.  When you're
> forced to flush the session, the null key goes too, so you again have
> to restore it from the context.  When you can keep the session you
> don't need the null key because you're not regenerating it.

Yeah, OK, then we're in sync with this. It's evolutionary cruft.

Just had to check that the logic matches how I projected your earlier
comment because these are sensitive changes.

BR, Jarkko

