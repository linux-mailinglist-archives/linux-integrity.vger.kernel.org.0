Return-Path: <linux-integrity+bounces-6304-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11566AC2710
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 18:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13025454CC
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5F221DA0;
	Fri, 23 May 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1cJjoD2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23628382;
	Fri, 23 May 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016129; cv=none; b=rAZF4yNXkqL+fLtKjsOob1PgR1eepRTxOEKzC7sDYuj7iEQ4Tf35v0cApma5UaHXtwY53Vw/dJXHkYLbgBdcIncqJsar/tcMua24SsolmOFOMsyaQE8ia7EYFvDML+hZLzcr2FA22d66VgHPIHAmeLs6R0ReIEwGmAtiyc65+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016129; c=relaxed/simple;
	bh=qgYSTT9XcSyqI+DBeYRkhP8s0z5sSZV+A60zwa1m+G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm2YWOWXnVN0A4G1LSep4V1kp8H1j1OkGXcRE6mWfstTCBuP/+Cy6jJ6Twq9rmLLbVG590A+kuwJ8p8lJu/pBrgFAbl7mnSj/cxNvIYJqU7oAgOTQR3kNYSBWN6ymcUV0JEK9oyNifkPdQWGF1vGeSsBQEROUfqadxUPiborWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1cJjoD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF2C4CEE9;
	Fri, 23 May 2025 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748016128;
	bh=qgYSTT9XcSyqI+DBeYRkhP8s0z5sSZV+A60zwa1m+G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1cJjoD22VVrq7n3ZjtSjCKVoJHel3VRZawP05ZnRpXIj+3lQiQJUxTt1+DGwjiXj
	 qiD93PYBeFeRoR4Y3uogSidZFUVxB7MStQE+euuIHup4TCaudxawDUawpio9ybD3fV
	 AhaIZCgcDC/8VysRupdDwrUkEyvyKG0zpXtpASfDrEGSCKnxvivqTg5i0KP3P9b+FB
	 mmLwMGNrE7wvYDNWfWFIHneeun9Yry7a5r75iW1d1T3oepXmg2ZnV6I2Usv1sfwjVf
	 xTzDLnpyvW96MaSXDzQ9odJXIZZEAHIUziVTI2IlbG+IwS5CJij5MfbH4ZTOpxNbdp
	 qxaXWEl1wc40g==
Date: Fri, 23 May 2025 19:02:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aDCb-wkHGoLQ-IGg@kernel.org>
References: <20250514134630.137621-1-sgarzare@redhat.com>
 <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org>
 <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org>
 <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
 <aC2nBCxkvWWz5y5E@kernel.org>
 <aC4CVUXpThAyKQdf@kernel.org>
 <CAGxU2F5zQJR4GvZ9ovtQBqMFGs-wBMoCRks=JYQ1JF6qMKK-6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5zQJR4GvZ9ovtQBqMFGs-wBMoCRks=JYQ1JF6qMKK-6g@mail.gmail.com>

On Thu, May 22, 2025 at 10:26:34AM +0200, Stefano Garzarella wrote:
> On Wed, 21 May 2025 at 18:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 01:12:20PM +0300, Jarkko Sakkinen wrote:
> > > > I tried, but the last patch (this one) is based on the series merged
> > > > on the tip tree, where I introduced tpm_svsm.
> > > > I can see that series in linux-next merged with commit
> > > > 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
> > > > but I can't see it in your next tree [1].
> > > >
> > > > How do we proceed in such cases?
> > > >
> > > > Just to be sure, did I use the right tree?
> > >
> > > Thanks for the remark. Lemme check tonight. Hold on doing
> > > anything ;-) We'll get there...
> >
> > I just rebased my branches on top of latest from Linus. That is what I
> > need base PR also on, and:
> >
> > $ git show 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
> > fatal: bad object 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
> >
> > I'd use git cherry-pick on a range to take them from linux-next to a
> > mainline tip...
> 
> I see, let me know if I can help in some way.
> 
> We can also wait the next cycle if it simplifies your work, definitely
> no rush on my side.

Let's do it. At least it will then get a full round of testing before
ending up to a release.

Thank you!

> 
> Thanks,
> Stefano

BR, Jarkko

