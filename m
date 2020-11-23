Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A802C0563
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgKWMT7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 07:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729294AbgKWMT7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 07:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606133997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeeoAM4hcE2Tqdj1kMierMvn1UuzyrNRXJg0gIbWESE=;
        b=A9aclAGorfxswmzI8hYIV0Rrqba5CTkPzRqiVRr5ySWgc+qNPForxotX44dvttEbq9VG6f
        zIoCIdnN6jphjiGFU5Ai5phVxiK2sNrIily6I6FkDQpii63Fgd2FxWJ//5szCj1u0lJl9O
        bklba/Q11L2IXSSPZLlm3n087ICuQYI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-iWEZJlFQO1m5vNUbsnnk7Q-1; Mon, 23 Nov 2020 07:19:56 -0500
X-MC-Unique: iWEZJlFQO1m5vNUbsnnk7Q-1
Received: by mail-ed1-f70.google.com with SMTP id f20so6450106edx.23
        for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2020 04:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qeeoAM4hcE2Tqdj1kMierMvn1UuzyrNRXJg0gIbWESE=;
        b=qjHqd2wKelDR7MeFLMELatqqfEBJSdzdvMpOQu/va4p+Ca2cmEVyISIkOasoL51m7b
         kLCfi6Uk6xcTM0dvyV9qp5QfZO36j9los29QfYREkxGfYf6JXqMBJzF0HyCzqhDEp8+0
         Dp4HtkbqaYj6vsFhgvZjbo0RwpCVSn/QUC+K5ex9+ro4xIaVcPpgoR/LLJB5PvM+Hpmc
         4pzomHKBkA9FMTSjeSuHAkne07UhJ2uKMaGUf+RJ7wIPi43vu1YC545oqfq60drCSlcI
         IOlI7at+DFTJDO5+kBpy7zuMU7jdxxdQdPa/6VAPB5+282mLFtfESeLnE4VXIoFi8Rk8
         gLjQ==
X-Gm-Message-State: AOAM531h24cNNb4ly+Q4we+erqjhi0WvMpOIGdALj3+U4lLzKj8wdjof
        SytvMDA5xoFR7eDxlC/dqx65F2OiKIkXG6zSSQO34yDTiUQQMhMJZit103ibk9d1kM7D6GveZky
        C2zdl/OwiSStgseTgF8KeIV/cqKMO
X-Received: by 2002:a17:907:20ac:: with SMTP id pw12mr15813615ejb.245.1606133994792;
        Mon, 23 Nov 2020 04:19:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCl6Est+5O33dD1/yIKWd+wwfQ8dObfaPnfKKKa4No6mpzqBFG+RaxPcyjk/JdrcxX1xjM2Q==
X-Received: by 2002:a17:907:20ac:: with SMTP id pw12mr15813584ejb.245.1606133994369;
        Mon, 23 Nov 2020 04:19:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id u7sm4196388ejt.33.2020.11.23.04.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:19:53 -0800 (PST)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
 <87d009c0pn.fsf@redhat.com> <77498b10-cf2c-690b-8dad-78cbd61712ba@redhat.com>
 <87a6vdb7l2.fsf@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <161ade15-5e13-361a-572b-78dbbd1f764a@redhat.com>
Date:   Mon, 23 Nov 2020 13:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87a6vdb7l2.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11/19/20 6:05 PM, Jerry Snitselaar wrote:
> 
> Hans de Goede @ 2020-11-19 07:42 MST:
> 
>> Hi,
>>
>> On 11/19/20 7:36 AM, Jerry Snitselaar wrote:
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
>>
>> Is that with your patch? The IRQ should be silenced as soon as
>> devm_free_irq(chip->dev.parent, priv->irq, chip); is called.
>>
> 
> No that is just with James' patchset that enables interrupts for
> tpm_tis. It looks like the irq is firing, but the tpm's int_status
> register is clear, so the handler immediately returns IRQ_NONE. After
> that happens 100000 times the core irq code shuts down the irq, but it
> isn't released so I could still see the stats in /proc/interrupts.

I see, yes I have seen this behavior on the X1C8 with a pre-production BIOS.

> With
> my attempt below on top of that patchset it releases the irq. I had to
> stick the check prior to it checking the int_status register because it
> is cleared and the handler returns,

Ack.

> and I couldn't do the devm_free_irq
> directly in tis_int_handler, so I tried sticking it in tpm_tis_send
> where the other odd irq testing code was already located. I'm not sure
> if there is another place that would work better for calling the
> devm_free_irq.

Adding it together with the other IRQ testing related code seems fine
to me.

>> Depending on if we can get your storm-detection to work or not,
>> we might also choose to just never try to use the IRQ (at least on
>> x86 systems). AFAIK the TPM is never used for high-throughput stuff
>> so the polling overhead should not be a big deal (and I'm getting the feeling
>> that Windows always polls).
>>
> 
> I was wondering about Windows as well. In addition to the Lenovo systems
> which the T490s had Nuvoton tpm, the system I found yesterday was a development
> system we have from a partner with an Infineon tpm. Dan Williams has
> seen it internally at Intel as well on some system.

Sounds to me like Windows never uses the IRQ, so we get the fun of finding
all the untested firmware bugs.

So if we cannot get this detection code to work reliable, maybe we should
just not use the IRQ at all, at least on X86 + ACPI systems?

Anyways lets try this storm-detection thing first, but I have the feeling
we should not spend too much time on this. Just outright disabling IRQ
support might be better.

REgards,

Hans

