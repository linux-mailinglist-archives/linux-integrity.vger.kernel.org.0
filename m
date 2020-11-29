Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320022C7760
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Nov 2020 04:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgK2DTp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Nov 2020 22:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgK2DTp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Nov 2020 22:19:45 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EF5206CB;
        Sun, 29 Nov 2020 03:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606619943;
        bh=pbRFxDArwnCUPLUu+gm70WqV0swkIAzhjUz7Jp3Uybs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msK2tFihoSFUEIZt2fDS/vBnWZH3cS/bev+RgqwZXSy1bTF5k19bcs5aK57FnmlmW
         g+HDBn4fGID5bSxgs6agjj8E8goyhASV1E1LjrUhEw7Y/hGFF3RfzX0H/NU8U6cFnx
         b5QHZsKmpIXwe411uoCyNkFdQvYB0xZNlQZCXQc8=
Date:   Sun, 29 Nov 2020 05:18:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Message-ID: <20201129031858.GB39488@kernel.org>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com>
 <20201124032623.GA40007@kernel.org>
 <871rgiod53.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rgiod53.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 24, 2020 at 10:52:56AM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-11-23 20:26 MST:
> 
> > On Wed, Nov 18, 2020 at 11:36:20PM -0700, Jerry Snitselaar wrote:
> >> 
> >> Matthew Garrett @ 2020-10-15 15:39 MST:
> >> 
> >> > On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >> >>
> >> >> There is a misconfiguration in the bios of the gpio pin used for the
> >> >> interrupt in the T490s. When interrupts are enabled in the tpm_tis
> >> >> driver code this results in an interrupt storm. This was initially
> >> >> reported when we attempted to enable the interrupt code in the tpm_tis
> >> >> driver, which previously wasn't setting a flag to enable it. Due to
> >> >> the reports of the interrupt storm that code was reverted and we went back
> >> >> to polling instead of using interrupts. Now that we know the T490s problem
> >> >> is a firmware issue, add code to check if the system is a T490s and
> >> >> disable interrupts if that is the case. This will allow us to enable
> >> >> interrupts for everyone else. If the user has a fixed bios they can
> >> >> force the enabling of interrupts with tpm_tis.interrupts=1 on the
> >> >> kernel command line.
> >> >
> >> > I think an implication of this is that systems haven't been
> >> > well-tested with interrupts enabled. In general when we've found a
> >> > firmware issue in one place it ends up happening elsewhere as well, so
> >> > it wouldn't surprise me if there are other machines that will also be
> >> > unhappy with interrupts enabled. Would it be possible to automatically
> >> > detect this case (eg, if we get more than a certain number of
> >> > interrupts in a certain timeframe immediately after enabling the
> >> > interrupt) and automatically fall back to polling in that case? It
> >> > would also mean that users with fixed firmware wouldn't need to pass a
> >> > parameter.
> >> 
> >> I believe Matthew is correct here. I found another system today
> >> with completely different vendor for both the system and the tpm chip.
> >> In addition another Lenovo model, the L490, has the issue.
> >> 
> >> This initial attempt at a solution like Matthew suggested works on
> >> the system I found today, but I imagine it is all sorts of wrong.
> >> In the 2 systems where I've seen it, there are about 100000 interrupts
> >> in around 1.5 seconds, and then the irq code shuts down the interrupt
> >> because they aren't being handled.
> >> 
> >> 
> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >> index 49ae09ac604f..478e9d02a3fa 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -27,6 +27,11 @@
> >>  #include "tpm.h"
> >>  #include "tpm_tis_core.h"
> >> 
> >> +static unsigned int time_start = 0;
> >> +static bool storm_check = true;
> >> +static bool storm_killed = false;
> >> +static u32 irqs_fired = 0;
> >
> > Maybe kstat_irqs() would be a better idea than ad hoc stats.
> >
> 
> Thanks, yes that would be better.
> 
> >> +
> >>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
> >> 
> >>  static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
> >> @@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >>         return rc;
> >>  }
> >> 
> >> -static void disable_interrupts(struct tpm_chip *chip)
> >> +static void __disable_interrupts(struct tpm_chip *chip)
> >>  {
> >>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >>         u32 intmask;
> >>         int rc;
> >> 
> >> -       if (priv->irq == 0)
> >> -               return;
> >> -
> >>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> >>         if (rc < 0)
> >>                 intmask = 0;
> >> 
> >>         intmask &= ~TPM_GLOBAL_INT_ENABLE;
> >>         rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> >> +       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> >> +}
> >> +
> >> +static void disable_interrupts(struct tpm_chip *chip)
> >> +{
> >> +       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >> 
> >> +       if (priv->irq == 0)
> >> +               return;
> >> +
> >> +       __disable_interrupts(chip);
> >>         devm_free_irq(chip->dev.parent, priv->irq, chip);
> >>         priv->irq = 0;
> >> -       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> >>  }
> >> 
> >>  /*
> >> @@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> >>         int rc, irq;
> >>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >> 
> >> +       if (unlikely(storm_killed)) {
> >> +               devm_free_irq(chip->dev.parent, priv->irq, chip);
> >> +               priv->irq = 0;
> >> +               storm_killed = false;
> >> +       }
> >
> > OK this kind of bad solution because if tpm_tis_send() is not called,
> > then IRQ is never freed. AFAIK, devres_* do not sleep but use spin
> > lock, i.e. you could render out both storm_check and storm_killed.
> >
> 
> Is there a way to flag it for freeing later while in an interrupt
> context? I'm not sure where to clean it up since devm_free_irq can't be
> called in tis_int_handler.
> 
> Before diving further into that though, does anyone else have an opinion
> on ripping out the irq code, and just using polling? We've been only
> polling since 2015 anyways.

Given these all these issues, it's quite obvious that Windows side is
just polling. I'll ack a patch that removes the IRQ code for sure.

/Jarkko
