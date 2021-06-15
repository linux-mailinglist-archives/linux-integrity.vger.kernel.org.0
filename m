Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216E63A819A
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFOOBQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 10:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhFOOBP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 10:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623765551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whaAfWBlrtWLHs4ZTBEBoBf3QtoKUXqNOGfoDcnk5nE=;
        b=c4Im6Pk2+42Tb+Ah1TN54tR4WWP53cRHAwu+4+c8tv02oGlgZtn0HhLtaPJpE4gUafxC/P
        TdCLgINpGfzAtSci3nVeK30cxfRagzoQWdcx/YPH41wSFJFiNZMlSDj6T69+3nhB/HDm6h
        E6zt1/ZE/joYjprtoHgk0txoSS2rMxY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-PgpARgZBPwKKmKumaKmbSg-1; Tue, 15 Jun 2021 09:59:09 -0400
X-MC-Unique: PgpARgZBPwKKmKumaKmbSg-1
Received: by mail-ed1-f72.google.com with SMTP id y16-20020a0564024410b0290394293f6816so4911218eda.20
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jun 2021 06:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whaAfWBlrtWLHs4ZTBEBoBf3QtoKUXqNOGfoDcnk5nE=;
        b=Lg4hFHpJ8+Az+3ZtefDgRHt1bnXQ/TIJ1h03MZ7QSCMQjBuvVLoUwsG8QmINqW81AT
         BGRifcYBeGx/RkhBtqC4Ih/LsX/qxxbXI8vnmr/n/TkqeaQN2doF/926Rs2oR1SpJvIR
         UYJhULbq4C0APbuqNztsQxZQavlL1Yf61jQ/inDRF1WgbzsiuK1JCUx4Iwi3hJpehKCJ
         RMJDeW2uAMUVkPMuNvi4zpDtYAvYbeEsoNDk6uIF1FXilkPbfJx7It0nF/iqRPrXye8Y
         95y8K0fbIe6fhYQwi5R8ZpDEL+oqngNvjJGZi/yDSkvTeQEKCayciOLko/DSTrqgK1kL
         6rBg==
X-Gm-Message-State: AOAM5304lxF+tWL+V29fDgXiqLvxY/ibz1JSksFPU/OVFXxM1/flJLL/
        mIVNP6x+wO8kZ5lK492USW7Y8NZRsZ5l0QgG8jBcQyCiJEDEeUHx5fXhDkhJgHRfywmdE0jcmxy
        EMAzmmVAJbAMyfV5Fzzv5+6ljMjQP
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr23150009edv.34.1623765548363;
        Tue, 15 Jun 2021 06:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAizlAmoh6i+yDnjnW8WnV63FWSYdzG092bg+Fde/kDS3AcTFjUiCvDZY6mydebsifiZC6Dw==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr23149986edv.34.1623765548222;
        Tue, 15 Jun 2021 06:59:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id du7sm12029157edb.1.2021.06.15.06.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:59:07 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <20210615130103.sln2s6hq4fkufi5a@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <62da92c6-b54e-379e-216c-be0b8eec82f0@redhat.com>
Date:   Tue, 15 Jun 2021 15:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615130103.sln2s6hq4fkufi5a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/15/21 3:01 PM, Jarkko Sakkinen wrote:
> On Mon, Jun 14, 2021 at 03:33:33PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/1/21 6:04 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>>>> Interestingly enough the first backtrace is also happening on a:
>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>>>
>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>>>> all reports are about the XPS 13 9310. I wonder if there is an
>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>>>
>>>> This is helpful for sure that these all are happening on matching hardware.
>>>
>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
>>>
>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>>
>>> 2. Backtrace starting with a call to tpm_dev_async_work:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>>> (note this one is not easily reproducible)
>>>
>>> 3. Backtrace starting with a call to rng_dev_read:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>
>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
>>
>> Quick status update, I've got a response from a XPS 13 9310 user in:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>
>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
>> (I expected this because all the bug-reports started when the interrupt
>> code got fixed/re-enabled a while ago).
>>
>> Si I think that there just is something broken wrt the interrupt setup
>> on the XPS 13 9310 and that we should probably add an antry for the
>> XPS 13 9310 to the already existing tpm_tis_dmi_table pointing to the
>> also already existing tpm_tis_disable_irq callback.
>>
>> If other people agree that that is probably the best way forward ?
>> then I can prepare a patch and ask the user to test this.
>>
>> Regards,
>>
>> Hans
> 
> I think it all roots down to the use of TPM before tpm2_probe(), i.e.
> TPM is not in expected state when tpm_chip_start() is called. I
> suggested to try out adding tpm_chip_stop() right before
> tpm_chip_start() in another response.
> 
> That's only thing that makes logically sense to me at least.

Shouldn't there the be some completion somewhere with get completed
at the end of probe(), with the read-path which is involved in this
case blocking on this?

If you can prepare a kernel-patch to test, then I can build a Fedora
kernel rpm with the patch added for the user to test.

Regards,

Hans

