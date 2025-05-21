Return-Path: <linux-integrity+bounces-6264-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCBABF111
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6501895D6C
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0C25A353;
	Wed, 21 May 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLXOzE9H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C80250BED;
	Wed, 21 May 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822344; cv=none; b=Kjd/6/ncJD9W6+FQSVdt4jnsxZxxyU30mZp863u/SlIQ3o0TFYzp9U9pBJ3Qplb7B5bmsXg2naR4i3eD1W9bEZNabBbqLuqBEwFgysp/c1F5LFZ4CtTOKOwZ+snUy/8FDjfy6BgQTV71gunRTpxEf/OdjUH4cc/9xf/vcAREX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822344; c=relaxed/simple;
	bh=21cNdzYwUJJBEkAHlt7+sFsml8d7DmKbNlD2kUZGKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uys+MivWxrDAhKCtWUm7m5uPR0nGz5eTY/C7hFJ98swMXV9jS2JREOrlyDQ1nkly9ztqPsmSgP/aev6P9cph8iWJiWhRu/tU6pF0I1I3pjWukgR0XgHro0BnSWtupWccRpTOmb9r5RkOtlQINEAggjZw6YwMC20cNSzQMdEUXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLXOzE9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E2C4CEED;
	Wed, 21 May 2025 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747822344;
	bh=21cNdzYwUJJBEkAHlt7+sFsml8d7DmKbNlD2kUZGKoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLXOzE9HyCy+kC79+nUGLtvp+0cxfR2TUqkZ6h0MDnnvdFk9pskQlEjRl/46ec7W2
	 TH/x2jlNbam+Us8NSZrtDSx/HbFXHChCs8KdGoSNvyu+6GIK/tABEAfZ5EIJ9jmwiU
	 W1JLhNCmMAminpUveLFmvUvUzyFGZbmBJ7QRISsH67ON2Eldjw5CzZuxmWFFKjhaMG
	 5hnpVMxcr0ovTQjUkq13+jJoGGK4Rsio37/Sc3vS01CWAzkYtLStJsFev+cYzyIB6D
	 cA1Q961SLiRbMcoD6c9XC2jiHOXhz5nQrAyKFReCRaKuiywBNVKDMxR59cSAmmioWM
	 B1TrXzju+oOcQ==
Date: Wed, 21 May 2025 13:12:20 +0300
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
Message-ID: <aC2nBCxkvWWz5y5E@kernel.org>
References: <20250514134630.137621-1-sgarzare@redhat.com>
 <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org>
 <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org>
 <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>

On Wed, May 21, 2025 at 09:13:34AM +0200, Stefano Garzarella wrote:
> On Tue, 20 May 2025 at 22:02, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Tue, May 20, 2025 at 06:06:50PM +0200, Stefano Garzarella wrote:
> > > On Thu, 15 May 2025 at 03:45, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > On Wed, May 14, 2025 at 03:46:30PM +0200, Stefano Garzarella wrote:
> > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > >
> > > > > This driver does not support interrupts, and receiving the response is
> > > > > synchronous with sending the command.
> > > > >
> > > > > Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> > > > > ->send() already fills the provided buffer with a response, and ->recv()
> > > > > is not implemented.
> > > > >
> > > > > Keep using the same pre-allocated buffer to avoid having to allocate
> > > > > it for each command. We need the buffer to have the header required by
> > > > > the SVSM protocol and the command contiguous in memory.
> > > > >
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > > v5:
> > > > > - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> > > > > v4:
> > > > > - reworked commit description [Jarkko]
> > > > > ---
> > > > >  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
> > > > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > > >
> 
> [...]
> 
> > > >
> > > > I can pick this for 6.16.
> > >
> > > Great, thanks!
> >
> > Can you rebase this on top of my next branch and send one more version
> > of the series (fake ancestor crap)?
> 
> I tried, but the last patch (this one) is based on the series merged
> on the tip tree, where I introduced tpm_svsm.
> I can see that series in linux-next merged with commit
> 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
> but I can't see it in your next tree [1].
> 
> How do we proceed in such cases?
> 
> Just to be sure, did I use the right tree?

Thanks for the remark. Lemme check tonight. Hold on doing
anything ;-) We'll get there...

> 
> Thanks,
> Stefano
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=next
> 
> 

BR, Jarkko

