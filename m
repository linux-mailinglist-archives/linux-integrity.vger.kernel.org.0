Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC402C2F5D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 18:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbgKXRxF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Nov 2020 12:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404201AbgKXRxF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Nov 2020 12:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606240383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRULtG4744uyd3kyq7DHeWDL/Spp1XajpIHhK764cQA=;
        b=gR4NmtTcXLvvAuBXvkH2sE0MGfYW2E2DaM+lWx5NTS375adZ1H9sX4mO8Tm8KUdQG8k4iY
        IEdbBysrJDOMB9By0MxV0vUdcJF9pckGKwxEFDCtg8rFURfyoeeJljkd3CALpkSje90kqx
        ugWTZ8leO4n0zB23ny82XdpjYHuBvps=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-kcaikh0YOKqAzYExlpnlkQ-1; Tue, 24 Nov 2020 12:53:00 -0500
X-MC-Unique: kcaikh0YOKqAzYExlpnlkQ-1
Received: by mail-qt1-f199.google.com with SMTP id t22so12120784qtq.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2020 09:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HRULtG4744uyd3kyq7DHeWDL/Spp1XajpIHhK764cQA=;
        b=brQGJwGW2KyeESi69gng+7dcfPU5ajqOQ4gUAyYtHC4E8vs6UW/OnxID+yXUcro8U3
         gWb05SFcLPU5tgFjyzRsfG2LeFZXgTRfPic6dLnB8k4QpTHt5W38+c3iwH0fLf2kYLQ9
         8nfJPh0qie90qIZ8po7hoNzVb1m24iP5GYPNQ/pvmatNOsz6GOiHIcmuyCo6Qd5U747R
         +YXSXSEzZ5noW9xCbUkAfVccCha6xkoVqerJCfi8MwCsxkO+24L/i4PQsNdvFOJJCSdy
         zySG7AMdRoQpzmhFqa9t8qzAYtHDVl5dVHbGpVVefe0L2x+cLMbZmoQJonZraQ+YtozV
         y83w==
X-Gm-Message-State: AOAM5314mWpX6/eMwV8h7AjDUz+J8srI/qSX/r6zMjqM2Tp5wx86+qX8
        2uO1kku0dMREzPxcIwanp90Vth/92zJw1ydevtJ+0okwuhfsFkycKqxSnzgRTcvUp2UI0pMDBNN
        PgoR4iC8EYtyHDgaV6T4GEHsETw+A
X-Received: by 2002:ac8:1c28:: with SMTP id a37mr5392857qtk.356.1606240379732;
        Tue, 24 Nov 2020 09:52:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKFk1D3ZsI2a2wUawGcIgF1P2EvZlvD2L1n/Gjc3fkb1AXJp0lph8rq7+KclKndjca7MfVOA==
X-Received: by 2002:ac8:1c28:: with SMTP id a37mr5392828qtk.356.1606240379408;
        Tue, 24 Nov 2020 09:52:59 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z73sm9834479qkb.112.2020.11.24.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:52:58 -0800 (PST)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com> <20201124032623.GA40007@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <20201124032623.GA40007@kernel.org>
Date:   Tue, 24 Nov 2020 10:52:56 -0700
Message-ID: <871rgiod53.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-11-23 20:26 MST:

> On Wed, Nov 18, 2020 at 11:36:20PM -0700, Jerry Snitselaar wrote:
>> 
>> Matthew Garrett @ 2020-10-15 15:39 MST:
>> 
>> > On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> >>
>> >> There is a misconfiguration in the bios of the gpio pin used for the
>> >> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>> >> driver code this results in an interrupt storm. This was initially
>> >> reported when we attempted to enable the interrupt code in the tpm_tis
>> >> driver, which previously wasn't setting a flag to enable it. Due to
>> >> the reports of the interrupt storm that code was reverted and we went back
>> >> to polling instead of using interrupts. Now that we know the T490s problem
>> >> is a firmware issue, add code to check if the system is a T490s and
>> >> disable interrupts if that is the case. This will allow us to enable
>> >> interrupts for everyone else. If the user has a fixed bios they can
>> >> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>> >> kernel command line.
>> >
>> > I think an implication of this is that systems haven't been
>> > well-tested with interrupts enabled. In general when we've found a
>> > firmware issue in one place it ends up happening elsewhere as well, so
>> > it wouldn't surprise me if there are other machines that will also be
>> > unhappy with interrupts enabled. Would it be possible to automatically
>> > detect this case (eg, if we get more than a certain number of
>> > interrupts in a certain timeframe immediately after enabling the
>> > interrupt) and automatically fall back to polling in that case? It
>> > would also mean that users with fixed firmware wouldn't need to pass a
>> > parameter.
>> 
>> I believe Matthew is correct here. I found another system today
>> with completely different vendor for both the system and the tpm chip.
>> In addition another Lenovo model, the L490, has the issue.
>> 
>> This initial attempt at a solution like Matthew suggested works on
>> the system I found today, but I imagine it is all sorts of wrong.
>> In the 2 systems where I've seen it, there are about 100000 interrupts
>> in around 1.5 seconds, and then the irq code shuts down the interrupt
>> because they aren't being handled.
>> 
>> 
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 49ae09ac604f..478e9d02a3fa 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -27,6 +27,11 @@
>>  #include "tpm.h"
>>  #include "tpm_tis_core.h"
>> 
>> +static unsigned int time_start = 0;
>> +static bool storm_check = true;
>> +static bool storm_killed = false;
>> +static u32 irqs_fired = 0;
>
> Maybe kstat_irqs() would be a better idea than ad hoc stats.
>

Thanks, yes that would be better.

>> +
>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>> 
>>  static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
>> @@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>>         return rc;
>>  }
>> 
>> -static void disable_interrupts(struct tpm_chip *chip)
>> +static void __disable_interrupts(struct tpm_chip *chip)
>>  {
>>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>         u32 intmask;
>>         int rc;
>> 
>> -       if (priv->irq == 0)
>> -               return;
>> -
>>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>         if (rc < 0)
>>                 intmask = 0;
>> 
>>         intmask &= ~TPM_GLOBAL_INT_ENABLE;
>>         rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>> +}
>> +
>> +static void disable_interrupts(struct tpm_chip *chip)
>> +{
>> +       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> 
>> +       if (priv->irq == 0)
>> +               return;
>> +
>> +       __disable_interrupts(chip);
>>         devm_free_irq(chip->dev.parent, priv->irq, chip);
>>         priv->irq = 0;
>> -       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>  }
>> 
>>  /*
>> @@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>         int rc, irq;
>>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> 
>> +       if (unlikely(storm_killed)) {
>> +               devm_free_irq(chip->dev.parent, priv->irq, chip);
>> +               priv->irq = 0;
>> +               storm_killed = false;
>> +       }
>
> OK this kind of bad solution because if tpm_tis_send() is not called,
> then IRQ is never freed. AFAIK, devres_* do not sleep but use spin
> lock, i.e. you could render out both storm_check and storm_killed.
>

Is there a way to flag it for freeing later while in an interrupt
context? I'm not sure where to clean it up since devm_free_irq can't be
called in tis_int_handler.

Before diving further into that though, does anyone else have an opinion
on ripping out the irq code, and just using polling? We've been only
polling since 2015 anyways.

>> +
>>         if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>>                 return tpm_tis_send_main(chip, buf, len);
>> 
>> @@ -748,6 +765,21 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>         u32 interrupt;
>>         int i, rc;
>> 
>> +       if (storm_check) {
>> +               irqs_fired++;
>> +
>> +               if (!time_start) {
>> +                       time_start = jiffies_to_msecs(jiffies);
>> +               } else if ((irqs_fired > 1000) && (jiffies_to_msecs(jiffies) - jiffies < 500)) {
>> +                       __disable_interrupts(chip);
>> +                       storm_check = false;
>> +                       storm_killed = true;
>> +                       return IRQ_HANDLED;
>> +               } else if ((jiffies_to_msecs(jiffies) - time_start > 500) && (irqs_fired < 1000)) {
>> +                       storm_check = false;
>> +               }
>> +       }
>> +
>>         rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>         if (rc < 0)
>>                 return IRQ_NONE;
>> 
>> 
>
> /Jarkko

