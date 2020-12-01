Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572932CAE0E
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 22:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLAVH1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 16:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgLAVH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 16:07:27 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C265C0613CF
        for <linux-integrity@vger.kernel.org>; Tue,  1 Dec 2020 13:06:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F0EC1280A32;
        Tue,  1 Dec 2020 13:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606856806;
        bh=YHNjf92UMJR/sialed9anF9jmC4fMNPzepbKvCRTvvQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qSkTc4yJklvAeDqpb5sa7yOAlgFn3iSLcGRG8aT936Z4m+y+RcpV97C/TgVjQ0+bR
         6wjNgfhjC4MN8A5yfthWaV7PxI6UmXnK+31eawp7nRfaKITrevHYMv3gt/bTTG+etf
         0GU87fyIg+Loq8TE90wAgmWaw8aMTX2LkACI9PAg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WA5xJ9It0Ku0; Tue,  1 Dec 2020 13:06:46 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EED7C1280A30;
        Tue,  1 Dec 2020 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606856806;
        bh=YHNjf92UMJR/sialed9anF9jmC4fMNPzepbKvCRTvvQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qSkTc4yJklvAeDqpb5sa7yOAlgFn3iSLcGRG8aT936Z4m+y+RcpV97C/TgVjQ0+bR
         6wjNgfhjC4MN8A5yfthWaV7PxI6UmXnK+31eawp7nRfaKITrevHYMv3gt/bTTG+etf
         0GU87fyIg+Loq8TE90wAgmWaw8aMTX2LkACI9PAg=
Message-ID: <2bf904f16673c4443bfc95f19d7fb49b97b9b159.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 3/5] tpm_tis: Fix interrupts for TIS TPMs without
 legacy cycles
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Tue, 01 Dec 2020 13:06:44 -0800
In-Reply-To: <87blfdmhm8.fsf@redhat.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
         <87h7p5mm3g.fsf@redhat.com> <87blfdmhm8.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-01 at 12:49 -0700, Jerry Snitselaar wrote:
> Jerry Snitselaar @ 2020-12-01 11:12 MST:
> 
> > James Bottomley @ 2020-10-01 11:09 MST:
> > 
> > > If a TIS TPM doesn't have legacy cycles, any write to the
> > > interrupt
> > > registers is ignored unless a locality is active.  This means
> > > even to
> > > set up the interrupt vectors a locality must first be
> > > activated.  Fix
> > > this by activating the 0 locality in the interrupt probe setup.
> > > 
> > > Since the TPM_EOI signalling also requires an active locality,
> > > the
> > > interrupt routine cannot end an interrupt if the locality is
> > > released.
> > > This can lead to a situation where the TPM goes command ready
> > > after
> > > locality release and since the interrupt cannot be ended it
> > > refires
> > > continuously.  Fix this by disabling all interrupts except
> > > locality
> > > change when a locality is released (this only fires when a
> > > locality
> > > becomes active, meaning the TPM_EOI should work).
> > > 
> > > Finally, since we now disable all status based interrupts in the
> > > locality release, they must be re-enabled before waiting to check
> > > the
> > > condition, so add interrupt enabling to the status wait.
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > > 
> > > ---
> > > 
> > > v2: renamed functions
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 125
> > > ++++++++++++++++++++++++++------
> > >  1 file changed, 101 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > b/drivers/char/tpm/tpm_tis_core.c
> > > index 431919d5f48a..0c07da8cd680 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -29,6 +29,46 @@
> > >  
> > >  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool
> > > value);
> > >  
> > > +static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8
> > > mask)
> > > +{
> > > +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > > +	u32 intmask;
> > > +
> > > +	/* Take control of the TPM's interrupt hardware and shut it off
> > > */
> > > +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> > > +
> > > +	intmask |= mask | TPM_GLOBAL_INT_ENABLE;
> > > +
> > > +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> > > +}
> > > +
> > > +static void tpm_tis_disable_interrupt(struct tpm_chip *chip, u8
> > > mask)
> > > +{
> > > +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > > +	u32 intmask;
> > > +
> > > +	/* Take control of the TPM's interrupt hardware and shut it off
> > > */
> > > +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> > > +
> > > +	intmask &= ~mask;
> > > +
> > > +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> > > +}
> > > +
> > > +static void tpm_tis_enable_stat_interrupts(struct tpm_chip
> > > *chip, u8 stat)
> > > +{
> > > +	u32 mask = 0;
> > > +
> > > +	if (stat & TPM_STS_COMMAND_READY)
> > > +		mask |= TPM_INTF_CMD_READY_INT;
> > > +	if (stat & TPM_STS_VALID)
> > > +		mask |= TPM_INTF_STS_VALID_INT;
> > > +	if (stat & TPM_STS_DATA_AVAIL)
> > > +		mask |= TPM_INTF_DATA_AVAIL_INT;
> > > +
> > > +	tpm_tis_enable_interrupt(chip, mask);
> > > +}
> > > +
> > >  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8
> > > mask,
> > >  					bool check_cancel, bool
> > > *canceled)
> > >  {
> > > @@ -65,11 +105,14 @@ static int wait_for_tpm_stat(struct tpm_chip
> > > *chip, u8 mask,
> > >  		timeout = stop - jiffies;
> > >  		if ((long)timeout <= 0)
> > >  			return -ETIME;
> > > +		tpm_tis_enable_stat_interrupts(chip, mask);
> > >  		rc = wait_event_interruptible_timeout(*queue,
> > >  			wait_for_tpm_stat_cond(chip, mask,
> > > check_cancel,
> > >  					       &canceled),
> > >  			timeout);
> > >  		if (rc > 0) {
> > > +			if (rc == 1)
> > > +				dev_err(&chip->dev, "Lost Interrupt
> > > waiting for TPM stat\n");
> > 
> > With my proposed patch to check for the interrupt storm condition I
> > sometimes see this message. Do you think it would make sense to
> > have a check here and in the request_locality location to see that
> > TPM_CHIP_FLAG is still enabled? It will print a message about the
> > interrupt storm being detected, and switching to polling, so I
> > don't know if this will cause confusion for people to have this
> > show up as well in that case.
> > 
> 
> I guess it wouldn't be too confusing since the messages will appear
> close together.

But since we have a discriminator I'll try to use it and see if we can
tidy up the messages.  I think the condition just becomes

if (rc == 1 && (chip->flags & TPM_CHIP_FLAG_IRQ))

because you'll have reset that if you found a storm?

James


