Return-Path: <linux-integrity+bounces-4030-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B819BF51B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112441C23AFD
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788AD2076DB;
	Wed,  6 Nov 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COMLHltx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA43201104;
	Wed,  6 Nov 2024 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917175; cv=none; b=gx+SWuSZHrb3eFbN5Rs6cdE71Bbvp8j0TLX5bHhTlEXrV49p1qtMQJ9Hr6xf0qaJbNsD2vVzKkq99AzVYaaLvQvwaN7B8XKH4Evkuh+y3d1f4fq/ia68akuuxpI/oJ0/iUO+jrGmoHDNFcEwOL2rI3jhFkU3V+sUEPovheMdPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917175; c=relaxed/simple;
	bh=sn7rRtukOUPi2X7skDpsh/lp6w1uJoAopG9xoA9cpjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=X+BKSqQDDo47xV2KHGc2uy22J/CHLfsao14cns1fJb/vFY70Khy7Y1p0Y4jwiUEdOruaVVcw1Vi+0H4mhzpV1QXrqblpwPpw+Sx3Ho/ARBeYHMHu5V3hCGCCuj9R2Ajh1r+sM86ONGDazkNcFgtF8bdlLzdzV3t5wc854RugCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COMLHltx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C3C4CEC6;
	Wed,  6 Nov 2024 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730917174;
	bh=sn7rRtukOUPi2X7skDpsh/lp6w1uJoAopG9xoA9cpjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COMLHltxKBSv7HFq68JU1n/OI1WOrP4iijOSeMjN1bNXTIcaD3+61mrthb3NLHksX
	 G/DEnahcYlzwZFfi4bbDgHncZr/aC4FZ8ENpILoc/p3b/Bn5sJJ12YzT5JpdCcv4H8
	 StMi8W+EzKuqMhJ6PUTHk6OekEzz1egCDwPdTfOiRyFdNe/4eReK0Axxc0RhYkdxob
	 0FujBSYVjW70Q05xZvj5aXePyZq9G3e57rgR7in0aeOp1OXJ7WesA97P6cK+OOr2cR
	 WaKiYQT3TvIIL3DtlmUBBcb2eZN9brgSUpfssjw7w0Zr5kqzJiynPXQ5ANyDIu+myc
	 GT6sjwZwer68g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:19:30 +0200
Message-Id: <D5FAXEKQ71ZJ.1U9AE15UVWRT9@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin"
 <npiggin@gmail.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
X-Mailer: aerc 0.18.2
References: <20240702161052.3563599-1-robh@kernel.org>
 <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi> <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
 <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
 <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi>
 <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
 <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org>
In-Reply-To: <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org>

On Wed Nov 6, 2024 at 8:17 PM EET, Jarkko Sakkinen wrote:
> > Whatever happened to this? Can you please apply my patch if you don't
> > have the time for further rework.
>
> Sorry unintentional.
>
> I applied with
>
> -static void __iomem * atmel_get_base_addr(unsigned long *base, int *regi=
on_size)
> +static void __iomem *atmel_get_base_addr(unsigned long *base, int *regio=
n_size)
> =20
> as this gives checkpatch error.

See:=20
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3Db18ffd5e0faaa02bffda61e19a013573451008d4

If that looks good to you, I can mirror it to -next.

BR, Jarkko

