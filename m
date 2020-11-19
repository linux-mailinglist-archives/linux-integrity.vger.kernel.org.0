Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2D2B98E6
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Nov 2020 18:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgKSRFi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 12:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbgKSRFh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 12:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605805535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7noBqjP7X7X7F1znylhK1IyBB+iXa4PXKrYGSK1I+Q4=;
        b=eAFuNuIqfn7+JfsZ26YSpy+TJyYK+mM4deUrVLapxMXI/HEqJXmLs/mO06oJ5oheGbUDm0
        GqBRXwCagmJalFSa+SQTqpRjHvQH2vYtPMtQEFtnmcXQ6zkWukEUDeh5uKP9cQwpRDuvSR
        oeBTbqwea8EpeAvPSLaAdyDbMcp1lTU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-jrM7ZouPOPeHWZpRwGHk-A-1; Thu, 19 Nov 2020 12:05:33 -0500
X-MC-Unique: jrM7ZouPOPeHWZpRwGHk-A-1
Received: by mail-qt1-f198.google.com with SMTP id y10so5197059qtw.5
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2020 09:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=7noBqjP7X7X7F1znylhK1IyBB+iXa4PXKrYGSK1I+Q4=;
        b=mxbuD7FtT3SgS7x3QTI9WuEGFWUsDyRFqwl3e2/OCBeG0WajSyozumUruzY2te6GjU
         4l+Vx8prhwE7jK/1szCXDsLmRFIV2wtwYxsYuxD42q44KW5rnQQJ9Ds5PaYj0hE8JUuQ
         Vnvh+IaVokraU6YkJv0JY8YzWGnprRqecO6Ty9YZsDxAcFhzgQk/Ed81ksGjrOkw1HiB
         bD5zYaiiLYkLEb33QXx6jDasTjwBHdUJUcmrkW9SXvmodubMEWPGYo3LliP3rKoPRf9x
         YJWiAzXjbSGEUaVpm5vhRT9dzkv1URX24RJx3REExW+tqk5U8ufwjgkScGB4N2pwxA1v
         i31g==
X-Gm-Message-State: AOAM5311sXTCV0joqd89o6pnBbAc7DuyYG7Ax2kvrmaeaPGvUfnWN78f
        /4MeKhweRMV/TQid4/wDUoxvr5UTxe7mrBhJsHIWvYyUvs29Q4z0OjmqLN0LwjmzV9y6FdkE11D
        mV8mvhYWw0/XCRfeuy/o22p40Kjy5
X-Received: by 2002:ac8:4914:: with SMTP id e20mr11079620qtq.210.1605805533031;
        Thu, 19 Nov 2020 09:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAdwWhaOkY9QamylGcjAqWf3ynrNhCJQ9K9PX56a0MzYhN2QPwW4BWl+yyq6EB/3J0DYRhsw==
X-Received: by 2002:ac8:4914:: with SMTP id e20mr11079589qtq.210.1605805532728;
        Thu, 19 Nov 2020 09:05:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c199sm226227qke.111.2020.11.19.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 09:05:31 -0800 (PST)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com>
 <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
Date:   Thu, 19 Nov 2020 10:05:29 -0700
Message-ID: <87a6vdb7l2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hans de Goede @ 2020-11-19 07:42 MST:

> Hi,
>
> On 11/19/20 7:36 AM, Jerry Snitselaar wrote:
>> 
>> Matthew Garrett @ 2020-10-15 15:39 MST:
>> 
>>> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>>>
>>>> There is a misconfiguration in the bios of the gpio pin used for the
>>>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>>>> driver code this results in an interrupt storm. This was initially
>>>> reported when we attempted to enable the interrupt code in the tpm_tis
>>>> driver, which previously wasn't setting a flag to enable it. Due to
>>>> the reports of the interrupt storm that code was reverted and we went back
>>>> to polling instead of using interrupts. Now that we know the T490s problem
>>>> is a firmware issue, add code to check if the system is a T490s and
>>>> disable interrupts if that is the case. This will allow us to enable
>>>> interrupts for everyone else. If the user has a fixed bios they can
>>>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>>>> kernel command line.
>>>
>>> I think an implication of this is that systems haven't been
>>> well-tested with interrupts enabled. In general when we've found a
>>> firmware issue in one place it ends up happening elsewhere as well, so
>>> it wouldn't surprise me if there are other machines that will also be
>>> unhappy with interrupts enabled. Would it be possible to automatically
>>> detect this case (eg, if we get more than a certain number of
>>> interrupts in a certain timeframe immediately after enabling the
>>> interrupt) and automatically fall back to polling in that case? It
>>> would also mean that users with fixed firmware wouldn't need to pass a
>>> parameter.
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
>
> Is that with your patch? The IRQ should be silenced as soon as
> devm_free_irq(chip->dev.parent, priv->irq, chip); is called.
>

No that is just with James' patchset that enables interrupts for
tpm_tis. It looks like the irq is firing, but the tpm's int_status
register is clear, so the handler immediately returns IRQ_NONE. After
that happens 100000 times the core irq code shuts down the irq, but it
isn't released so I could still see the stats in /proc/interrupts.  With
my attempt below on top of that patchset it releases the irq. I had to
stick the check prior to it checking the int_status register because it
is cleared and the handler returns, and I couldn't do the devm_free_irq
directly in tis_int_handler, so I tried sticking it in tpm_tis_send
where the other odd irq testing code was already located. I'm not sure
if there is another place that would work better for calling the
devm_free_irq.

> Depending on if we can get your storm-detection to work or not,
> we might also choose to just never try to use the IRQ (at least on
> x86 systems). AFAIK the TPM is never used for high-throughput stuff
> so the polling overhead should not be a big deal (and I'm getting the feeling
> that Windows always polls).
>

I was wondering about Windows as well. In addition to the Lenovo systems
which the T490s had Nuvoton tpm, the system I found yesterday was a development
system we have from a partner with an Infineon tpm. Dan Williams has
seen it internally at Intel as well on some system.

> Regards,
>
> Hans
>
>
>
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

