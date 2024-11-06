Return-Path: <linux-integrity+bounces-4034-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2729BF576
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AADB21D48
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982120821C;
	Wed,  6 Nov 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJEc1tlE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D7208217;
	Wed,  6 Nov 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918340; cv=none; b=GNav/ID/0MUKCrez77fK6yCgYDNXWLsJRg9db8qj7ALv1Uu//HNsEgB6a5qCnRsluNiuLx7+v57pwKtGZ+Yqn/12KC21eUBF4iBQPGXcPkmv16TmUuENXrjlsOH1roygZY2w5rWtAi/QTsDV6DrZvZkacZWAI9P/6cPBeIP+EN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918340; c=relaxed/simple;
	bh=hfsiubwE8UnbZ9AU3TXwnnJyFZUi7Z6WW66CkyjmgSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eot9d1bFhWKjYje0f5JqWmxIQ2cjS0OHem/NtBRAmz9bVJ2XmYHkY6jZFWJmfwqHp0kSD0e3WZUpTD+Vfff3RBUK8GJGcKQTLFx5uodkHDeUi0jShO1sZYuou1osbfr0Ev1pNRNe5TlZlNOFA8ZpKvneZoFKvUZMyloDA8zZpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJEc1tlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADBDC4CEC6;
	Wed,  6 Nov 2024 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918340;
	bh=hfsiubwE8UnbZ9AU3TXwnnJyFZUi7Z6WW66CkyjmgSE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cJEc1tlEb/Iu7ty9QYtsbqpxeHIIhAwd1B/o7ga/3lskmWclVengzMkovJo2ZtxTX
	 rXPJy4VPdj3fhuyRzDu44FrX6PyDvOulc2Q7PyNNQZ8d08vF+2DksB799Ufgf2Lst7
	 Cglb2olRUwAhBBwbvEVuAb/G9s6nUromugArEMcmNsssYzujvH28hGhHfi/ZqUBGZe
	 K+gMUYk2nLcK9NfBCd1EE6V7L3ipZPTk+tINVMPWhEEHPI+UFXHjilNlzYRs6HdSry
	 kTjBT9QLOZ2T2gJEgnhJNP45YDOpQxdcJmUr2EaLcjbrg/MqcHFYeDbTQfk6xXahsU
	 JBdlrFEZyms5Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:38:55 +0200
Message-Id: <D5FBC9UCGZXJ.6QNQGC6T3361@kernel.org>
Cc: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240702161052.3563599-1-robh@kernel.org>
 <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi> <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
 <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
 <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi>
 <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
 <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org>
 <D5FAXEKQ71ZJ.1U9AE15UVWRT9@kernel.org>
 <CAL_JsqJdabUmgOEe29y4o5muOnh83V7rS=YwfXMtZ+Fugcgzdw@mail.gmail.com>
In-Reply-To: <CAL_JsqJdabUmgOEe29y4o5muOnh83V7rS=YwfXMtZ+Fugcgzdw@mail.gmail.com>

On Wed Nov 6, 2024 at 8:32 PM EET, Rob Herring wrote:
> On Wed, Nov 6, 2024 at 12:19=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Wed Nov 6, 2024 at 8:17 PM EET, Jarkko Sakkinen wrote:
> > > > Whatever happened to this? Can you please apply my patch if you don=
't
> > > > have the time for further rework.
> > >
> > > Sorry unintentional.
> > >
> > > I applied with
> > >
> > > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *=
region_size)
> > > +static void __iomem *atmel_get_base_addr(unsigned long *base, int *r=
egion_size)
> > >
> > > as this gives checkpatch error.
> >
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/=
commit/?id=3Db18ffd5e0faaa02bffda61e19a013573451008d4
> >
> > If that looks good to you, I can mirror it to -next.
>
> Looks good. Thanks.

Ya, an my sincere apologies!

>
> Rob


BR, Jarkko

