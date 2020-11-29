Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38702C7762
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Nov 2020 04:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgK2DWa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Nov 2020 22:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgK2DWa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Nov 2020 22:22:30 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A4E2080D;
        Sun, 29 Nov 2020 03:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606620110;
        bh=a0dnwKDwXjeMn4C1Jlj2bDl46iCpyKZhmmn0q37W3no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyIDy5u/qEKPBn0xLfk009rNwxzCBZYpKjABQ1wUSocRbz91BSGFNbSy0v0oVwUM8
         D9Fdose1xfCgRGvI11AZeOsDUipVVuUy3cFnACuSrJVP2/33c5DhfulnAmkmY1g92j
         Dy2IJyPsjBoTzWBwWGG5jWKOoC25dtSObCCW1IiE=
Date:   Sun, 29 Nov 2020 05:21:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Message-ID: <20201129032145.GC39488@kernel.org>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com>
 <20201124032623.GA40007@kernel.org>
 <871rgiod53.fsf@redhat.com>
 <67628c88a9ddc85d9957c1847514afe24a6fcebf.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67628c88a9ddc85d9957c1847514afe24a6fcebf.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 24, 2020 at 10:10:21AM -0800, James Bottomley wrote:
> On Tue, 2020-11-24 at 10:52 -0700, Jerry Snitselaar wrote:
> > Before diving further into that though, does anyone else have an
> > opinion on ripping out the irq code, and just using polling? We've
> > been only polling since 2015 anyways.
> 
> Well only a biased one, obviously: polling causes large amounts of busy
> waiting, which is a waste of CPU resources and does increase the time
> it takes us to do TPM operations ... not a concern if you're doing long
> computation ones, like signatures, but it is a problem for short
> operations like bulk updates of PCRs.  The other potential issue, as we
> saw with atmel is that if you prod the chip too often (which you have
> to do with polling) you risk upsetting it.  We've spent ages trying to
> tune the polling parameters to balance reduction of busy wait with chip
> upset and still, apparently, not quite got it right.  If the TPM has a
> functioning IRQ then it gets us out of the whole polling mess entirely.
> The big question is how many chips that report an IRQ actually have a
> malfunctioning one?
> 
> James

Do we have a way to know is Windows TPM code using IRQ's?

/Jarkko
