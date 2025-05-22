Return-Path: <linux-integrity+bounces-6294-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B2AC0708
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 10:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BA71898D7A
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA76264625;
	Thu, 22 May 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR1S0QnK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DD263F30
	for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902410; cv=none; b=iyVdRBZDu99dqfvmlbxUPOWAhvYkCWRlECYWMIGXOufbPjAUrXkARx2edoXlF/RUgYj5xhl0LthKHsMOegmwlmp7Ux6VfJ3mds1Jy0A1olUMmAE2To+SuwrkDtmj+FsoH6p+yODeuVMKNbD9cbPLANWXkfAdLTYKAa7VTfxDWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902410; c=relaxed/simple;
	bh=Dlp2azLQltfH6emKWYdlW4k16t8gyfKRpWtf3w9Dv60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvQUJN+6+WRuX9WZFX01ggjkh0bThKvUdUimmDa10kX6tp+nNI124ivIISt/TyJBrGAvCJgoaO82DBGhuvOaDo/vk4bhw0TfXk38KqtGl6/mGYLQXz7GNYnsmGGcW2NkWrvGpPR4sa18+PoEVUC3oomWlV77nytW/zheGjVEOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XR1S0QnK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747902408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dlp2azLQltfH6emKWYdlW4k16t8gyfKRpWtf3w9Dv60=;
	b=XR1S0QnKzJcKBXu7IM7mGIOqXTay76uaYTDvlcmNQ7PkjSCwCqr/qYMLXYtmtiKpknCMWp
	u/uirrerMwaekZk92AENuBU3bSA3ShAcRLGBJGwz7/7h6PJu/zUvn50mZF4E6ybkGKl1Po
	QmRy3ZjG6SIjY9SUhht4Qwi7eCg6dW0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-zJU4Nv1LMKqxQ-NPMNJBOA-1; Thu, 22 May 2025 04:26:46 -0400
X-MC-Unique: zJU4Nv1LMKqxQ-NPMNJBOA-1
X-Mimecast-MFC-AGG-ID: zJU4Nv1LMKqxQ-NPMNJBOA_1747902406
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70deb82de2fso29681487b3.0
        for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902406; x=1748507206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dlp2azLQltfH6emKWYdlW4k16t8gyfKRpWtf3w9Dv60=;
        b=aYzFBJp7jbla9b1mixM2HlOPxzhHxsR6OAjQbRWj3HgWn59mCUX2eYNPRDaU/AUfWT
         RYo/jbG+5A39Jy4WBzk5VtR3uQLVvXDLbub40dPiVH9iCuMsJP59FReODYjhfvDbvWDu
         Gbz7AkKlunt7kyJt+mxGWDteNc7kX+DYZ4veuE4ZG5vKyHOG0i2pZ960UchvfDaAdSyc
         LVMquM9vXMmxbi7KIA7fnhJO2wei6eaX3kUaf+AChEBX94f+G/XyofT6dEDUiOkYMvPj
         krTGBy3uFwZ0aVtNZypy+Fz+W1sLzHA1iMf20h+ISqJkoGQXSVmHUDNRnA8cOMWpQtcp
         Wlzg==
X-Forwarded-Encrypted: i=1; AJvYcCUaB0FABWbdp/hHoZiS9+jUXCr++9TiXJsScVGU9Tas1/ds0Zkjws7g+uxApMWUR4IHmSkCovnjbuX1CaN93WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloFId+4MIqDIySX25d9wAHmgDgH5IWgDFIIHYSNNjDuLL1evD
	AayG5X4dIsKWaJC4HKEZj1hB8TcMioJcQaqVLCnMTFX5BOicJJox+OJW1p2xiA2jXtuOQNeANYR
	vxWgUBKLgysRD1KyUljBDCG3+4NoNuBarct72ps+HQY0qE5QkkoCGIIKHrjB+OlBOW6yZe2S7ip
	2+1iU9a66LpQ2KrtAqJrYSUjSy8pEm7rQOjazh4dPdSXq4
X-Gm-Gg: ASbGncuT/+dHCFMt/IjYmWDK57oPPUVWqVJMNUuht9dwrNsZKyzKutfoRHa/TUPdimM
	IfGFWQP/X+bPHxexy2nEmET2WGUVP9w3zAsjEBVpz7nbFmlWF07ACnWLDJh6pW7VGnl4=
X-Received: by 2002:a05:690c:3393:b0:70d:f3bb:a731 with SMTP id 00721157ae682-70df3bba868mr78205667b3.9.1747902405936;
        Thu, 22 May 2025 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhVj8JhGJCK+zc7RP834KN5Eve5FMdd9QufZUZBEqDbkQHG8Gr0Mr3Ft0fdQAFQnebVlVVoTvKHtpXaHPSYY=
X-Received: by 2002:a05:690c:3393:b0:70d:f3bb:a731 with SMTP id
 00721157ae682-70df3bba868mr78205367b3.9.1747902405539; Thu, 22 May 2025
 01:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514134630.137621-1-sgarzare@redhat.com> <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org> <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
 <aCzf6aoJAC-IdS_n@kernel.org> <CAGxU2F6rfqGV_gJk-JxrCk3f9dWtYn_3o9RODh7cVG0X_oQWaA@mail.gmail.com>
 <aC2nBCxkvWWz5y5E@kernel.org> <aC4CVUXpThAyKQdf@kernel.org>
In-Reply-To: <aC4CVUXpThAyKQdf@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 22 May 2025 10:26:34 +0200
X-Gm-Features: AX0GCFvwBrY1Wuz2vdIMhJw7TkALKpOFZS5DJd8t4bfvvVGz5MJKErKjPBRbZJg
Message-ID: <CAGxU2F5zQJR4GvZ9ovtQBqMFGs-wBMoCRks=JYQ1JF6qMKK-6g@mail.gmail.com>
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

On Wed, 21 May 2025 at 18:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, May 21, 2025 at 01:12:20PM +0300, Jarkko Sakkinen wrote:
> > > I tried, but the last patch (this one) is based on the series merged
> > > on the tip tree, where I introduced tpm_svsm.
> > > I can see that series in linux-next merged with commit
> > > 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07,
> > > but I can't see it in your next tree [1].
> > >
> > > How do we proceed in such cases?
> > >
> > > Just to be sure, did I use the right tree?
> >
> > Thanks for the remark. Lemme check tonight. Hold on doing
> > anything ;-) We'll get there...
>
> I just rebased my branches on top of latest from Linus. That is what I
> need base PR also on, and:
>
> $ git show 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
> fatal: bad object 16a56ee59ab8ee05e67de35bbb5782ef9cfb4f07
>
> I'd use git cherry-pick on a range to take them from linux-next to a
> mainline tip...

I see, let me know if I can help in some way.

We can also wait the next cycle if it simplifies your work, definitely
no rush on my side.

Thanks,
Stefano


