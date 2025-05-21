Return-Path: <linux-integrity+bounces-6263-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA85ABECD6
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9A21BA5109
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FA235079;
	Wed, 21 May 2025 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgMLgfBm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCE231A32
	for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811632; cv=none; b=FRfNNxbCc5sN8kX712ZRkFLyEUxwngnDV/GZHZGc0b02+yofIphFplL+UQqyiCeRW0P9x/TeipD3yvE45X0tqJWE5mqGy2nhqn6LGCQyOnyyRfgvN7r9JaY5O2tS/4c+CyHc4qqiDg8JdNH0rKOvY0wwXn6a1P1EQklN46Jexpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811632; c=relaxed/simple;
	bh=9VQ346ebPIpVRMm6f9y5EgRDO2obIT85xOV3Gw2udo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqmihvMpzM/eszynaQTaxZpIszIFgHaNPQAYbnjfYEkZY4Q3D88dud6Cg/QqVFgws6EnZPu+Hr9V8WBnwfW4QQyni+86zuPWg2svCbxa6eYNlUoRm3jH5BZD2V1UNdxFU5udvhMg+KKmA95h0vKg2N8xzlYa64bESGtx6faBEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgMLgfBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747811630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4uXFki3RXaBZTP7u7kZxHdvFx0pW0nGcDYfjm3cMQc=;
	b=QgMLgfBmW1+7+BilbdnkP98ESJMUCgsdabLQeTiCDcKl0QxdM+WOnmrh3kkHbm0amLJhxl
	INKxQ3ZUdbpGdgYB4pt28gHhMKeiri+Mc7QdlL6cEWNys0oMT4kHsZ7mWiRMih8IKLvc/s
	skgQEZ7vixDNoGrJW8wt2ImOHwmoE9c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-XH8pBsS_Nn6ZznquP0yLMw-1; Wed, 21 May 2025 03:13:46 -0400
X-MC-Unique: XH8pBsS_Nn6ZznquP0yLMw-1
X-Mimecast-MFC-AGG-ID: XH8pBsS_Nn6ZznquP0yLMw_1747811626
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e7b9115c1b4so5391995276.2
        for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 00:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747811626; x=1748416426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4uXFki3RXaBZTP7u7kZxHdvFx0pW0nGcDYfjm3cMQc=;
        b=m4XsmoX31tngMtfklFlNATc8E75fpeg2J4hxkJ3SlJ8BQbDf1+v+iDlBMWCa6mHhy2
         m0NWMjyTIhTp2qWdf4phjfx8jFRM9cOpwWgdwxRwYAz7jnAiL57nblw9OI73TNLXG/22
         V5dyNG0zYIu8m3GSBIct1N0sSRxR670cKcuSS20MDFUWFg+K/44uqvdFxHOZw4hX0IPO
         tz2AzSp6jbZGXE/F3tehNn1jquTsoULsJE4lFhtc6y5oe9fKkQhvw6/cfLk0gzb9FkRN
         2vXMC0TaJ3jMz8KW6SnLJRtcrMI3pOAFl5p5TA20Q54u7AB0tmX/RLbrTjQZtV9QW+me
         Znlw==
X-Forwarded-Encrypted: i=1; AJvYcCUM1rTkdYtWnshceryfHlp9CyoFBaEVw2uiZu3kE2jnLwbhty8n01voABnt6EEnyqgT04Y1QwmDQ3n4gNfpjn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcWkQacAV7qCwe4cfBPba078evmAPfRLQ31DgV7SBOZQRL0ue
	4XWPKZvEU8x7/7kDVhPkRVFfaMgwqxH4FUauHhfitAwnj0o0g+Il5hDw9JpkGlgaJPa/+Jzqlxg
	7MXf9re+Yg8zWd333eWZ0IbEvPoOK6l+ImyzIhFXCZunXLrx2xa2pm5fbbLCQRd1IYRheu3i0nq
	DBKCH6C282IT5ynkpEBqPo3xZomMNmEsqU4D6AqIPFmw0k
X-Gm-Gg: ASbGncuLRe6H1x1TtHgb+DwDZFx/7ptMabqExpyzTtvJN8s/dJYlaUI0kTpI8g2onLT
	+8PUxl2IyRhzpOHE9owiNQBORL3+f63rQmXg6qYCu39TVUTsQhde8JurY23NYmq8mJMs=
X-Received: by 2002:a05:6902:1287:b0:e6d:ec5e:b5ed with SMTP id 3f1490d57ef6-e7b6a08f421mr26886354276.21.1747811626137;
        Wed, 21 May 2025 00:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKNo15Oi/QZ/k66bSnuQxE6bf08k4qaU0blNDQ7dnxZLVMy+YcQ+rT1+Lvnu8ha0WE5sLFghYmv/ZaOBdZByk=
X-Received: by 2002:a05:6902:1287:b0:e6d:ec5e:b5ed with SMTP id
 3f1490d57ef6-e7b6a08f421mr26886312276.21.1747811625773; Wed, 21 May 2025
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514134630.137621-1-sgarzare@redhat.com> <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org> <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org>
In-Reply-To: <aCzf6aoJAC-IdS_n@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 21 May 2025 09:13:34 +0200
X-Gm-Features: AX0GCFtXE4dDeCn9cUTuVG4Gx57oa8NEQ7aSl0jUrOWZcTyJncPcrt8z6mYPIQQ
Message-ID: <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jens Wiklander <jens.wiklander@linaro.org>, linux-integrity@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 22:02, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, May 20, 2025 at 06:06:50PM +0200, Stefano Garzarella wrote:
> > On Thu, 15 May 2025 at 03:45, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > On Wed, May 14, 2025 at 03:46:30PM +0200, Stefano Garzarella wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > This driver does not support interrupts, and receiving the response is
> > > > synchronous with sending the command.
> > > >
> > > > Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> > > > ->send() already fills the provided buffer with a response, and ->recv()
> > > > is not implemented.
> > > >
> > > > Keep using the same pre-allocated buffer to avoid having to allocate
> > > > it for each command. We need the buffer to have the header required by
> > > > the SVSM protocol and the command contiguous in memory.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > v5:
> > > > - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> > > > v4:
> > > > - reworked commit description [Jarkko]
> > > > ---
> > > >  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
> > > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > >

[...]

> > >
> > > I can pick this for 6.16.
> >
> > Great, thanks!
>
> Can you rebase this on top of my next branch and send one more version
> of the series (fake ancestor crap)?

I tried, but the last patch (this one) is based on the series merged
on the tip tree, where I introduced tpm_svsm.
I can see that series in linux-next merged with commit
16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
but I can't see it in your next tree [1].

How do we proceed in such cases?

Just to be sure, did I use the right tree?

Thanks,
Stefano

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=next


