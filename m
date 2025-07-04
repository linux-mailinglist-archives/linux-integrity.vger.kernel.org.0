Return-Path: <linux-integrity+bounces-6626-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48BAF94EB
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58834542B7A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF0273F9;
	Fri,  4 Jul 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4R/Kp0C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F04360;
	Fri,  4 Jul 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637846; cv=none; b=uPdzF14ATZ7/O6qZwaubLjA5+T1kGXSBGzCbJTLHzN+VOTiIkCRpnVgp6hBzS1yiewrV67vS7m1hZZlzmBCGiJHTqi2gRnPLmF2qplzJzlwQyU1uFiT8kGqN2rOzIKBLXmfVA9bJOtN96CEC5enhwKozb6DMWxiY7KWevsMS33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637846; c=relaxed/simple;
	bh=uDK0VCJtJw1Po5bTZiEIIjSPaTJw5LjKImIw4tpqKdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOQ+wYyl0J6OmvL72tDzLKXsBQgXm5ZSKZiJMUZ6LdAkjawW2gp58/SNAH+ApujJh83z43nPmUwbe+dEnROYbZkRyxuIR5EN8CZipyaxzVzjlzY74/UbA6oOaIAynjSkry1gM00O4Wq6nefotRW+xXqzTwt6VHBJnCDZNl/VL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4R/Kp0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7433C4CEE3;
	Fri,  4 Jul 2025 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637846;
	bh=uDK0VCJtJw1Po5bTZiEIIjSPaTJw5LjKImIw4tpqKdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4R/Kp0CmPsvqMfVotJ+TYNfN4KRWkDLt4BqqqQes6gkJlujp5lcFiID91dlQw2nJ
	 0Y82hyPpwtDeDMYG2myxRST94My3KHmIdYdbJS31xHGPswKii7yWE+4ZsAeqRxq2qD
	 ULlqWgGiqA2wyGO+QYwYxfoSM0dvmkvZwjNu0bQ+QI3KKpuhhYQr4rs9Ff3xJ/WuGC
	 4SMeVRKup+jeWaKxRn7UYISakjLEPI5QQAG4+cRu8jzQXP2OHR19wewUg4MAyV73LP
	 gRsAvQ4caOZfGasjSo7rXNLiC7m/GdxCRFLcWQovITGlmT/yoSqJvvzogsNHL9qGS3
	 OLlvt9kDKzDXg==
Date: Fri, 4 Jul 2025 17:04:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Prachotan Bathi <prachotan.bathi@arm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <aGffUrDSjNH6w6rB@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-3-prachotan.bathi@arm.com>
 <aGWvtzhs5ksKgaYo@kernel.org>
 <151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
 <aGdAMg43nHPwgeKn@kernel.org>
 <aGdC8gyO00AB_aPr@kernel.org>
 <20250704114010.0d210c31@pumpkin>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704114010.0d210c31@pumpkin>

On Fri, Jul 04, 2025 at 11:40:10AM +0100, David Laight wrote:
> On Fri, 4 Jul 2025 05:56:50 +0300
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > On Fri, Jul 04, 2025 at 05:45:11AM +0300, Jarkko Sakkinen wrote:
> ...
> > > Well, that was some truly misguided advice from my side so all the shame
> > > here is on me :-) There's no global memzero() and neither explicit
> > > version makes much sense here. Sorry about that.
> > > 
> > > I gave it now (actual) thought, and here's what I'd propose:
> > > 
> > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > index 96746d5b03e3..e769f6143a7c 100644
> > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > @@ -203,26 +203,20 @@ static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
> > >  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> > >  
> > >  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > > -		memzero(&tpm_crb_ffa->direct_msg_data2,
> > > -		       sizeof(struct ffa_send_direct_data2));
> > > -
> > > -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > > -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> > > -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> > > -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> > > +		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
> > > +			.data = { func_id, a0, a1, a2 },
> > > +		};
> 
> clang has a habit of compiling that as an un-named on-stack structure that
> is initialised and then memcpy() used to copy it into place.
> Often not was intended and blows the stack when the structure is large.
> 
> So probably not a pattern that should be encouraged.

This is interesting observation so I had to do some compilation tests to
verify the claim just to see how it plays out (and for the sake of
learning while doing it).

Note that I use GCC for the examples but I have high doubts that clang
would do worse. Please share the insight if that is a wrong assumption.

OK, so... here's the dissembly (using objdump) for the  unchanged version:

ffff8000801805a0:	8b020260 	add	x0, x19, x2
ffff8000801805a4:	94011819 	bl	ffff8000801c6608 <__memset>
ffff8000801805a8:	a9035a75 	stp	x21, x22, [x19, #48]
ffff8000801805ac:	aa1a03e1 	mov	x1, x26
ffff8000801805b0:	aa1903e0 	mov	x0, x25
ffff8000801805b4:	a9047e77 	stp	x23, xzr, [x19, #64]

[ Off-topic: note that how a2 gets optimized out with the zero register
  so that it is probably a parameter that we don't need at all in the
  first place? ]

However, in the changed version the matching snippet looks factors
better:

ffff800080180620:	a9017c7f 	stp	xzr, xzr, [x3, #16]
ffff800080180624:	f900107f 	str	xzr, [x3, #32]

Further, look at the stack size in the original version:

ffff800080180524 <__tpm_crb_ffa_send_receive.constprop.0>:
ffff800080180524:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!

On the other hand, in the changed version:

ffff800080180524 <__tpm_crb_ffa_send_receive.constprop.0>:
ffff800080180524:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!

I don't know, at least the figures I'm able to measure with my limited
ARM assembly knowledge look way better.

BR, Jarkko`


