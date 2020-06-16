Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D851B1FAB05
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgFPIYe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 04:24:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726064AbgFPIYb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592295869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0Zi+XUh6dCe2WhR9eyPyJ7ExDAg3gBx4gjsjwR0/38=;
        b=Me1agnp4feK0YRMLdkUK84mqzp8tZ1dglqsqqAB4jJz4F+D+dgl05TjcjFNUuEo1BaEDwQ
        KBWW/fh3Wuetd+tSj53XARnvjhYBAMT4nHuokEL+xqdqKjPVI/uKz6pRZqD1B89g8DICxN
        r4V0fWhJRVdW90xreVCZDcTkV3h0aEY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-grBp3SXWMuO5cayPVrMhmQ-1; Tue, 16 Jun 2020 04:24:26 -0400
X-MC-Unique: grBp3SXWMuO5cayPVrMhmQ-1
Received: by mail-ej1-f71.google.com with SMTP id bg25so4188356ejb.12
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 01:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0Zi+XUh6dCe2WhR9eyPyJ7ExDAg3gBx4gjsjwR0/38=;
        b=O2W6EjgsJLJirUXpiyOO3x6YU7A5y2hnEP2MvDYYMwMgXCzKZidEmBwz9xJ7Oq45uL
         5VaOAfPtbzBOMN7cuO5oW9vKqvTDr5H72kXsZqZDyASIiWORs0X3cRYg3t47xwFwSjq3
         2Wo8eL+J/QweerFqIcg4gHxVLpLCSbbYzRltAprkT3enMgpj9SUfwXrsdsZopC1wV+ex
         ygWguvXAQ9cWQJxqPSRHhXkQkA94rbrquPjSqOXv7iVkxD4f/6FL0vSOFeHOVE9cpKSh
         FWMH5hV/2Lh2ii5aBOn+rbkwxT04tbTPiuS8DMq5H49DQ1Sg0xWY/BZ/pCfBQLr7jvFc
         K6PQ==
X-Gm-Message-State: AOAM530PxAXllhgxvd9YTGqRrWe0H7wTay1yxhhUnqJ1bv78JmDTvJvk
        kjXAloqliqyTv0E4JOrPbnWeQvwUjUZ+3PEF5KdyP81ZNfF/+qlw7ohOM//FaICgSfMvdxAtfG6
        H7cxi3eHjkbdeF0jpkD62LvxlEuP7
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr1494237edx.159.1592295865038;
        Tue, 16 Jun 2020 01:24:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ5GJhs5R+y9nqYXgRTbM4M/JaY1ro3OCnHdIOkjPnM6eUTC/jARHsnt5bhzv6Ebeb03k4zw==
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr1494223edx.159.1592295864771;
        Tue, 16 Jun 2020 01:24:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k22sm9613413edr.93.2020.06.16.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:24:23 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200604091712.qvcqkkhhtcqoorpd@cantor>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <456f3660-8609-ba86-de68-f8cbd1e79e55@redhat.com>
Date:   Tue, 16 Jun 2020 10:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604091712.qvcqkkhhtcqoorpd@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/4/20 11:17 AM, Jerry Snitselaar wrote:
> On Thu May 07 20, Hans de Goede wrote:
>> Hi All,
>>
>> On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
>>> On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
>>>> Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
>>>> TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
>>>> the TPM_CHIP_FLAG_IRQ ever.
>>>>
>>>> So the whole IRQ probing code is not useful, worse we rely on the
>>>> IRQ-test path of tpm_tis_send() to call disable_interrupts() if
>>>> interrupts do not work, but that path never gets entered because we
>>>> never set the TPM_CHIP_FLAG_IRQ.
>>>>
>>>> So the remaining IRQ probe code calls request_irq() and never calls
>>>> free_irq() even when the interrupt is not working.
>>>>
>>>> On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
>>>> to use and never free creates an interrupt storm followed by
>>>> an "irq XX: nobody cared" oops.
>>>>
>>>> Since it is non-functional at the moment anyways, lets just completely
>>>> disable the IRQ code in tpm_tis_core for now.
>>>>
>>>> Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Note I'm working with Lenovo to try and get to the bottom of this.
>>>> ---
>>>
>>> OK if I recall correctly the reason for reverting was that the fixes
>>> Stefan was sending were broken and no access to hardware were the
>>> issues would be visible. The reason for not doing anything til this
>>> day is that we don't have T490 available.
>>
>> So as promised I have been in contact with Lenovo about this.
>>
>> Specifically I have been in contact with Lenovo about seeing an
>> IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
>> 8th gen (X1C8), because of the now public plan that Lenovo will
>> offer ordering this model with Fedora pre-installed:
>> https://lwn.net/Articles/818595/
>>
>> On the X1C8 the problem has been diagnosed to be a misconfigured
>> GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
>> TPM chip with its IRQ connected to a GPIO on the SoC which is
>> configured in Direct IRQ mode, so that it directly asserts
>> IRQs on one of the APIC IRQs.  The problem is that due to the
>> misconfiguration as soon as the IRQ is enabled it fires
>> continuously.
>>
>> For the X1C8 this should be fixed in the BIOS of the first
>> batch which gets shipped out to customers so there we should
>> not have to worry about this.
>>
>> It is likely (but not yet confirmed) that the issue on the T490
>> is the same, although on my test X1C8 device I got an IRQ storm,
>> followed by the kernel disabling the IRQ, not a non booting system.
>> I guess this might be due to kernel configuration differences.
>>
>> Assuming that the issue on the T490 is the same, we might see a
>> BIOS update fixing this, but given that non-booting is
>> 'not good ("tm")' even if there will be a BIOS fix we should
>> still do something at the kernel level to also work with the
>> older unfixed BIOS which is already out there.
>>
>> I've been thinking about this and I'm afraid that the only thing
>> what we can do is add a DMI product-name (product-version for Lenovo)
>> string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
>> and set tpm_info.irq = -1 for devices on that list.
>>
>> My plan is to prepare a RFC patch of such a blacklist, while we
>> wait for confirmation that the root cause on the T490 is the same
>> as on the X1C8, but before I work on that I'm wondering if
>> people agree that that is the best approach, or if there are
>> other suggestions for dealing with this ?
>>
>> Regards,
>>
>> Hans
>>
> 
> Jarrko,
> 
> Any thoughts about how we should move forward on dealing with this?
> I've got a report about the original problem Stefan was dealing with,
> where the tpm isn't powered on when it tries to send a command to
> generate an interrupt. The tpm is functioning so it isn't urgent,
> but it would be good to get this cleaned up so users aren't getting
> transmit errors and firmware bug messages. Hans did you make any
> progress on the blacklist patch?

Not really. I wanted to confirm on the X1C8 which I have on loan
from Lenovo that it indeed was the GPIO pin misconfiguration which
was the issue. But even though the Lenovo BIOS team claimed that they
have fixed the root cause now, the workaround of not listing any
IRQ for the TPM is also still in place in the latest BIOS I have.

So I cannot test that the IRQ storm is gone with the newer BIOS :|

Still the GPIO pin misconfiguration likely was the issue of the
storm I was seeing on the X1C8 and also the T490s likely has the
same issue. I should actually receive a T490s loaner soon-ish,
because of some unrelated (Builtin privacy screen) work I'm doing.

Once I have received the T490s then I can test things on the T490s:
1. Revert the reverts so that in theory we get working TPM IRQ
    support in the kernel again
2. Check that the T490s does not like this
3. Write and test a blacklist patch

I'll ping my colleague who has arranged the loaner to ask what
the status is on it.

Regards,

Hans

