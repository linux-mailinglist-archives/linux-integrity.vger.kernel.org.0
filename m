Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D92C3374
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 22:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgKXVpK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Nov 2020 16:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgKXVpJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Nov 2020 16:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606254307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/01D88jyTMdO8ru48uxIMGQv6yUqBjrpOvNUgxnu8cM=;
        b=g0OTq0uli4XZqS82Ml07DxjQ1Iz5GHI8t284/FvKAXJnVoWKPWww0UU5nNY7oQd4IHuxJy
        Rr+GONgBH4DIUOID2pckEiHMTh3Cay/sRuZDXuTSC2MADVl8aydVPHLoK7L3Nnezx596BS
        3PSZK0i5ZNsoZwVPKxGtBHEBLJ5XYWI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-lYtpuxuhP_27LncFYHcKeQ-1; Tue, 24 Nov 2020 16:45:03 -0500
X-MC-Unique: lYtpuxuhP_27LncFYHcKeQ-1
Received: by mail-ed1-f70.google.com with SMTP id i1so162138edt.19
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2020 13:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/01D88jyTMdO8ru48uxIMGQv6yUqBjrpOvNUgxnu8cM=;
        b=YLb1mSZg8B1BGMWtu+DM0mUxm37akD54gYBaruevX1w5Y1QTvZM4ysdcHXX2dBV376
         Bm0jMH2r/I6mqISxm2l2VHJGIFj6eRtvNM74Hc/WOdjWbMHy1MIRBeA+o6uJK+QCMbsF
         OIQ18MwMqF8AuaML5Qhznxpt5TgL1od+No5vzL3fyshwtc0PGKzbYYP1ns4j4OL7fQaZ
         /bWk4qXXVk5eyB9hKZ29f3L6m7AlhJ3qsufaptTeGND3xXxdXUaqqEGi/s7JKNfW8vQo
         mjOUB3GodO7vI0CXNddIGXi+TGXCgHaxLVnQzS/NeJyop1/GNxo8RJz/iXcD+QWbL9fQ
         mS8Q==
X-Gm-Message-State: AOAM532bylsnqDhPFsi1po9vG2naiHd+LTUpVlrohER9tzHDeYAc1tB2
        lYZF+D+qCLio+KUSRmOvplCaG7ZpPjpy5u3YuMtEA3l96EUr7ETHbgEeaE5vd5Lsfnvu84X7cAO
        GZABYSZdtpP6S0QXV4EB8uF2eVRsU
X-Received: by 2002:a17:906:86ca:: with SMTP id j10mr385031ejy.507.1606254302670;
        Tue, 24 Nov 2020 13:45:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgUr/8n9j9f3MJR095+6mF/OIbHa1SPfLLggt7GZEZ7hiAVDFRG9jf5/qfU/S2TuZyF/Hw2Q==
X-Received: by 2002:a17:906:86ca:: with SMTP id j10mr385018ejy.507.1606254302453;
        Tue, 24 Nov 2020 13:45:02 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id y24sm88296edt.15.2020.11.24.13.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 13:45:01 -0800 (PST)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com> <20201124032623.GA40007@kernel.org>
 <871rgiod53.fsf@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7779bfbc-f96b-dd81-313f-36f451ce9c32@redhat.com>
Date:   Tue, 24 Nov 2020 22:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <871rgiod53.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11/24/20 6:52 PM, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-11-23 20:26 MST:
> 
>> On Wed, Nov 18, 2020 at 11:36:20PM -0700, Jerry Snitselaar wrote:
>>>
>>> Matthew Garrett @ 2020-10-15 15:39 MST:
>>>
>>>> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>>>>
>>>>> There is a misconfiguration in the bios of the gpio pin used for the
>>>>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>>>>> driver code this results in an interrupt storm. This was initially
>>>>> reported when we attempted to enable the interrupt code in the tpm_tis
>>>>> driver, which previously wasn't setting a flag to enable it. Due to
>>>>> the reports of the interrupt storm that code was reverted and we went back
>>>>> to polling instead of using interrupts. Now that we know the T490s problem
>>>>> is a firmware issue, add code to check if the system is a T490s and
>>>>> disable interrupts if that is the case. This will allow us to enable
>>>>> interrupts for everyone else. If the user has a fixed bios they can
>>>>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>>>>> kernel command line.
>>>>
>>>> I think an implication of this is that systems haven't been
>>>> well-tested with interrupts enabled. In general when we've found a
>>>> firmware issue in one place it ends up happening elsewhere as well, so
>>>> it wouldn't surprise me if there are other machines that will also be
>>>> unhappy with interrupts enabled. Would it be possible to automatically
>>>> detect this case (eg, if we get more than a certain number of
>>>> interrupts in a certain timeframe immediately after enabling the
>>>> interrupt) and automatically fall back to polling in that case? It
>>>> would also mean that users with fixed firmware wouldn't need to pass a
>>>> parameter.
>>>
>>> I believe Matthew is correct here. I found another system today
>>> with completely different vendor for both the system and the tpm chip.
>>> In addition another Lenovo model, the L490, has the issue.
>>>
>>> This initial attempt at a solution like Matthew suggested works on
>>> the system I found today, but I imagine it is all sorts of wrong.
>>> In the 2 systems where I've seen it, there are about 100000 interrupts
>>> in around 1.5 seconds, and then the irq code shuts down the interrupt
>>> because they aren't being handled.
>>>
>>>
>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>> index 49ae09ac604f..478e9d02a3fa 100644
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -27,6 +27,11 @@
>>>  #include "tpm.h"
>>>  #include "tpm_tis_core.h"
>>>
>>> +static unsigned int time_start = 0;
>>> +static bool storm_check = true;
>>> +static bool storm_killed = false;
>>> +static u32 irqs_fired = 0;
>>
>> Maybe kstat_irqs() would be a better idea than ad hoc stats.
>>
> 
> Thanks, yes that would be better.
> 
>>> +
>>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>>
>>>  static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
>>> @@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>>>         return rc;
>>>  }
>>>
>>> -static void disable_interrupts(struct tpm_chip *chip)
>>> +static void __disable_interrupts(struct tpm_chip *chip)
>>>  {
>>>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>>         u32 intmask;
>>>         int rc;
>>>
>>> -       if (priv->irq == 0)
>>> -               return;
>>> -
>>>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>>         if (rc < 0)
>>>                 intmask = 0;
>>>
>>>         intmask &= ~TPM_GLOBAL_INT_ENABLE;
>>>         rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>>> +       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>> +}
>>> +
>>> +static void disable_interrupts(struct tpm_chip *chip)
>>> +{
>>> +       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>>
>>> +       if (priv->irq == 0)
>>> +               return;
>>> +
>>> +       __disable_interrupts(chip);
>>>         devm_free_irq(chip->dev.parent, priv->irq, chip);
>>>         priv->irq = 0;
>>> -       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>>  }
>>>
>>>  /*
>>> @@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>>         int rc, irq;
>>>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>>
>>> +       if (unlikely(storm_killed)) {
>>> +               devm_free_irq(chip->dev.parent, priv->irq, chip);
>>> +               priv->irq = 0;
>>> +               storm_killed = false;
>>> +       }
>>
>> OK this kind of bad solution because if tpm_tis_send() is not called,
>> then IRQ is never freed. AFAIK, devres_* do not sleep but use spin
>> lock, i.e. you could render out both storm_check and storm_killed.
>>
> 
> Is there a way to flag it for freeing later while in an interrupt
> context? I'm not sure where to clean it up since devm_free_irq can't be
> called in tis_int_handler.

You could add a workqueue work-struct just for this and queue that up
to do the free when you detect the storm. That will then run pretty much
immediately, avoiding the storm going on for (much) longer.

> Before diving further into that though, does anyone else have an opinion
> on ripping out the irq code, and just using polling? We've been only
> polling since 2015 anyways.

Given James Bottomley's reply I guess it would be worthwhile to get the
storm detection to work.

Regards,

Hans


> 
>>> +
>>>         if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>>>                 return tpm_tis_send_main(chip, buf, len);
>>>
>>> @@ -748,6 +765,21 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>>         u32 interrupt;
>>>         int i, rc;
>>>
>>> +       if (storm_check) {
>>> +               irqs_fired++;
>>> +
>>> +               if (!time_start) {
>>> +                       time_start = jiffies_to_msecs(jiffies);
>>> +               } else if ((irqs_fired > 1000) && (jiffies_to_msecs(jiffies) - jiffies < 500)) {
>>> +                       __disable_interrupts(chip);
>>> +                       storm_check = false;
>>> +                       storm_killed = true;
>>> +                       return IRQ_HANDLED;
>>> +               } else if ((jiffies_to_msecs(jiffies) - time_start > 500) && (irqs_fired < 1000)) {
>>> +                       storm_check = false;
>>> +               }
>>> +       }
>>> +
>>>         rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>>         if (rc < 0)
>>>                 return IRQ_NONE;
>>>
>>>
>>
>> /Jarkko
> 

