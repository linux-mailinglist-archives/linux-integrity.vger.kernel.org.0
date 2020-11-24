Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED092C1C0B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 04:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKXD37 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 22:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgKXD36 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 22:29:58 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1297A20857;
        Tue, 24 Nov 2020 03:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606188597;
        bh=KxuNoYem00459KvpZFX2tDubg4MIGBJzs3eCzDnYQIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6dCqSOPQODQMM+UdWvJAfQpIX4qtvHlBZQkqos0RND4VxaBYgt7MGh1gTjGe5cfR
         /zeZsf2W4XNTLgdqEXS15a8sy2VwCcmRtCcSaa8SVBpDYXqUTBETOax8ihw5v2q+L6
         0b0dnCut/JwI4K1qfe0z8LKanjCayaKy9nqbLJjo=
Date:   Tue, 24 Nov 2020 05:29:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Message-ID: <20201124032952.GA40270@kernel.org>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com>
 <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
 <20201124032725.GB40007@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124032725.GB40007@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 24, 2020 at 05:27:30AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 19, 2020 at 03:42:35PM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 11/19/20 7:36 AM, Jerry Snitselaar wrote:
> > > 
> > > Matthew Garrett @ 2020-10-15 15:39 MST:
> > > 
> > >> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > >>>
> > >>> There is a misconfiguration in the bios of the gpio pin used for the
> > >>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
> > >>> driver code this results in an interrupt storm. This was initially
> > >>> reported when we attempted to enable the interrupt code in the tpm_tis
> > >>> driver, which previously wasn't setting a flag to enable it. Due to
> > >>> the reports of the interrupt storm that code was reverted and we went back
> > >>> to polling instead of using interrupts. Now that we know the T490s problem
> > >>> is a firmware issue, add code to check if the system is a T490s and
> > >>> disable interrupts if that is the case. This will allow us to enable
> > >>> interrupts for everyone else. If the user has a fixed bios they can
> > >>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
> > >>> kernel command line.
> > >>
> > >> I think an implication of this is that systems haven't been
> > >> well-tested with interrupts enabled. In general when we've found a
> > >> firmware issue in one place it ends up happening elsewhere as well, so
> > >> it wouldn't surprise me if there are other machines that will also be
> > >> unhappy with interrupts enabled. Would it be possible to automatically
> > >> detect this case (eg, if we get more than a certain number of
> > >> interrupts in a certain timeframe immediately after enabling the
> > >> interrupt) and automatically fall back to polling in that case? It
> > >> would also mean that users with fixed firmware wouldn't need to pass a
> > >> parameter.
> > > 
> > > I believe Matthew is correct here. I found another system today
> > > with completely different vendor for both the system and the tpm chip.
> > > In addition another Lenovo model, the L490, has the issue.
> > > 
> > > This initial attempt at a solution like Matthew suggested works on
> > > the system I found today, but I imagine it is all sorts of wrong.
> > > In the 2 systems where I've seen it, there are about 100000 interrupts
> > > in around 1.5 seconds, and then the irq code shuts down the interrupt
> > > because they aren't being handled.
> > 
> > Is that with your patch? The IRQ should be silenced as soon as
> > devm_free_irq(chip->dev.parent, priv->irq, chip); is called.
> > 
> > Depending on if we can get your storm-detection to work or not,
> > we might also choose to just never try to use the IRQ (at least on
> > x86 systems). AFAIK the TPM is never used for high-throughput stuff
> > so the polling overhead should not be a big deal (and I'm getting the feeling
> > that Windows always polls).
> > 
> > Regards,
> > 
> > Hans
> 
> Yeah, this is what I've been wondering for a while. Why could not we
> just strip off IRQ code? Why does it matter?

And we DO NOT use interrupts in tpm_crb and nobody has ever complained.

/Jarkko
