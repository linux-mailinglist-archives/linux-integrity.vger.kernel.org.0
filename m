Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E242CAF21
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 22:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgLAVso (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 16:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728614AbgLAVsn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 16:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606859236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/soQd5paAGtsC+Ucl/RB+lxOX1sTWIxr6snR+ODgDiw=;
        b=Zhv5x+65H+Bieo8rSgb6U/Z5EdPXPNM5AmQXYMuBQ7EDE3W8BKujcfDGrI5mUVB+rxJ/y4
        nQkmQXcbTFnxtFc2JW5FLJJx0UwCEBy2GT/R/VCxhq+A5MFMhYcAoQTOTty5rtGP3xCrZd
        5CM3RybDA854UoJS6CqTfPyxXvNsehk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-P7m0y_DMPhO_syurVxoF1w-1; Tue, 01 Dec 2020 16:47:15 -0500
X-MC-Unique: P7m0y_DMPhO_syurVxoF1w-1
Received: by mail-qk1-f200.google.com with SMTP id g28so2486959qka.4
        for <linux-integrity@vger.kernel.org>; Tue, 01 Dec 2020 13:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/soQd5paAGtsC+Ucl/RB+lxOX1sTWIxr6snR+ODgDiw=;
        b=gq51S4ncWXDYJqnwZ2XFUrxdrzVwY4KucYZqJeOuHxe68HUj4Qu50rwcktw3RFA8zt
         dSRQTH6DNNCRN+Sq7jFwDpK8xqNUsI3ZwjcIzan8lf5ZTmMZK37pqDvKDXOIar16n45S
         GnrqUsyTcRyoU5n3zThqMQmWadcjvgviASvbA0/BRwhDzKCNK1zTJs+6SKR8V73Hu0C9
         pBX49iXsMJXoivpdrz2rJSe4yU9/VHr3Q1b0JpPKcy3PvA5i0f6wPH6yf0xLXXi6Hsg/
         UFRLqSEPk+zBoS36rN94M7yhXLkdo95HAES2O/AT80sEwFVY3/dN3BavdUP8CHmDAD83
         20eg==
X-Gm-Message-State: AOAM532jhbZuV719vHe8tl7Oh90PyWzWgnw5u3IUzGL4ChIbSrNbtXnf
        daLkDCdjCzwQsvBByMYFQoTT1yATuKtqJBCNzuPj737Lo7cNSyJXujGFX+ZzFeWYd5t7M2UXqlV
        lxJg+qVOTWuf15IZNwozb4nY33zoh
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr5152215qkw.194.1606859234657;
        Tue, 01 Dec 2020 13:47:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyttxx7fhA1D/CmhS3ifIpgxK5JvNV1GNBD6gPTYjcFT2ZW4zwfZFvXz1DJ6BOPf9YlU6BI5A==
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr5152196qkw.194.1606859234422;
        Tue, 01 Dec 2020 13:47:14 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k188sm1014751qkd.98.2020.12.01.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:47:13 -0800 (PST)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
 <87h7p5mm3g.fsf@redhat.com> <87blfdmhm8.fsf@redhat.com>
 <2bf904f16673c4443bfc95f19d7fb49b97b9b159.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 3/5] tpm_tis: Fix interrupts for TIS TPMs without
 legacy cycles
In-reply-to: <2bf904f16673c4443bfc95f19d7fb49b97b9b159.camel@HansenPartnership.com>
Date:   Tue, 01 Dec 2020 14:47:12 -0700
Message-ID: <87zh2xkxlr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-12-01 14:06 MST:

> On Tue, 2020-12-01 at 12:49 -0700, Jerry Snitselaar wrote:
>> Jerry Snitselaar @ 2020-12-01 11:12 MST:
>> 
>> > James Bottomley @ 2020-10-01 11:09 MST:
>> > 
>> > > If a TIS TPM doesn't have legacy cycles, any write to the
>> > > interrupt
>> > > registers is ignored unless a locality is active.  This means
>> > > even to
>> > > set up the interrupt vectors a locality must first be
>> > > activated.  Fix
>> > > this by activating the 0 locality in the interrupt probe setup.
>> > > 
>> > > Since the TPM_EOI signalling also requires an active locality,
>> > > the
>> > > interrupt routine cannot end an interrupt if the locality is
>> > > released.
>> > > This can lead to a situation where the TPM goes command ready
>> > > after
>> > > locality release and since the interrupt cannot be ended it
>> > > refires
>> > > continuously.  Fix this by disabling all interrupts except
>> > > locality
>> > > change when a locality is released (this only fires when a
>> > > locality
>> > > becomes active, meaning the TPM_EOI should work).
>> > > 
>> > > Finally, since we now disable all status based interrupts in the
>> > > locality release, they must be re-enabled before waiting to check
>> > > the
>> > > condition, so add interrupt enabling to the status wait.
>> > > 
>> > > Signed-off-by: James Bottomley <
>> > > James.Bottomley@HansenPartnership.com>
>> > > 
>> > > ---
>> > > 
>> > > v2: renamed functions
>> > > ---
>> > >  drivers/char/tpm/tpm_tis_core.c | 125
>> > > ++++++++++++++++++++++++++------
>> > >  1 file changed, 101 insertions(+), 24 deletions(-)
>> > > 
>> > > diff --git a/drivers/char/tpm/tpm_tis_core.c
>> > > b/drivers/char/tpm/tpm_tis_core.c
>> > > index 431919d5f48a..0c07da8cd680 100644
>> > > --- a/drivers/char/tpm/tpm_tis_core.c
>> > > +++ b/drivers/char/tpm/tpm_tis_core.c
>> > > @@ -29,6 +29,46 @@
>> > >  
>> > >  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool
>> > > value);
>> > >  
>> > > +static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8
>> > > mask)
>> > > +{
>> > > +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> > > +	u32 intmask;
>> > > +
>> > > +	/* Take control of the TPM's interrupt hardware and shut it off
>> > > */
>> > > +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> > > +
>> > > +	intmask |= mask | TPM_GLOBAL_INT_ENABLE;
>> > > +
>> > > +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> > > +}
>> > > +
>> > > +static void tpm_tis_disable_interrupt(struct tpm_chip *chip, u8
>> > > mask)
>> > > +{
>> > > +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> > > +	u32 intmask;
>> > > +
>> > > +	/* Take control of the TPM's interrupt hardware and shut it off
>> > > */
>> > > +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> > > +
>> > > +	intmask &= ~mask;
>> > > +
>> > > +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> > > +}
>> > > +
>> > > +static void tpm_tis_enable_stat_interrupts(struct tpm_chip
>> > > *chip, u8 stat)
>> > > +{
>> > > +	u32 mask = 0;
>> > > +
>> > > +	if (stat & TPM_STS_COMMAND_READY)
>> > > +		mask |= TPM_INTF_CMD_READY_INT;
>> > > +	if (stat & TPM_STS_VALID)
>> > > +		mask |= TPM_INTF_STS_VALID_INT;
>> > > +	if (stat & TPM_STS_DATA_AVAIL)
>> > > +		mask |= TPM_INTF_DATA_AVAIL_INT;
>> > > +
>> > > +	tpm_tis_enable_interrupt(chip, mask);
>> > > +}
>> > > +
>> > >  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8
>> > > mask,
>> > >  					bool check_cancel, bool
>> > > *canceled)
>> > >  {
>> > > @@ -65,11 +105,14 @@ static int wait_for_tpm_stat(struct tpm_chip
>> > > *chip, u8 mask,
>> > >  		timeout = stop - jiffies;
>> > >  		if ((long)timeout <= 0)
>> > >  			return -ETIME;
>> > > +		tpm_tis_enable_stat_interrupts(chip, mask);
>> > >  		rc = wait_event_interruptible_timeout(*queue,
>> > >  			wait_for_tpm_stat_cond(chip, mask,
>> > > check_cancel,
>> > >  					       &canceled),
>> > >  			timeout);
>> > >  		if (rc > 0) {
>> > > +			if (rc == 1)
>> > > +				dev_err(&chip->dev, "Lost Interrupt
>> > > waiting for TPM stat\n");
>> > 
>> > With my proposed patch to check for the interrupt storm condition I
>> > sometimes see this message. Do you think it would make sense to
>> > have a check here and in the request_locality location to see that
>> > TPM_CHIP_FLAG is still enabled? It will print a message about the
>> > interrupt storm being detected, and switching to polling, so I
>> > don't know if this will cause confusion for people to have this
>> > show up as well in that case.
>> > 
>> 
>> I guess it wouldn't be too confusing since the messages will appear
>> close together.
>
> But since we have a discriminator I'll try to use it and see if we can
> tidy up the messages.  I think the condition just becomes
>
> if (rc == 1 && (chip->flags & TPM_CHIP_FLAG_IRQ))
>
> because you'll have reset that if you found a storm?
>
> James


Yes, the worker calls disable_interrupts() and that clears the flag.

Jerry

