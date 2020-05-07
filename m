Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C781C8D58
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGOCp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 10:02:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726913AbgEGOCo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 10:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588860163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJAQX97h/73fz6F5oJeyWiUgnE5xCKILGZxmqYUzLLw=;
        b=en7IuiTDS5/PSRhfwhjBNzr7TLOwqbCUhUzWL+yakbjRg1fENKIK9dsnV0CfmWhA8XKefA
        x83a23JQHSOO6c+wi2RXXEl2j91rk4H4Cd/xA/d1KheGhl2DV+m+1IlrmpnuZtPr6s/hN9
        GXEoYUa/K9DoY8rmOOb25ReQWiZbROI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uynt-HXVMwqmtKAwYH0Hsg-1; Thu, 07 May 2020 10:02:32 -0400
X-MC-Unique: uynt-HXVMwqmtKAwYH0Hsg-1
Received: by mail-wm1-f72.google.com with SMTP id f17so2580741wmm.5
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 07:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FJAQX97h/73fz6F5oJeyWiUgnE5xCKILGZxmqYUzLLw=;
        b=lO1pwwxpq9FBkNuSeNIpsKZtjqt3rJmW2M04ezx9Lz6wb5pEzkVbMZHsh4Q3/LpB04
         LJYYe06mYVxVNNZmsFpVp12Jox7vTj4HbotPmEIVUNZtxQ5fIlUEoEdRl/Mx2YPZZlBE
         7FlOcB8njv+EbA17H6e1vFUcrbTL/6lH9lx+xt9v0TRUEQ6um6RngoGijsmDjPCjtqUf
         E1cxFLFKzy6YPm2R7FBQqJC3iUnGHHMZAYCP5cNht7lfXqxPY4PKRDZf871XEkWdG3Hw
         AFcVk/YOcIomsSmXALaM9v763cJ+iOYGhKeeoxtm+LIDDdQxDhupdc6tZmdM91WQmfZL
         6bcw==
X-Gm-Message-State: AGi0PuYI2VHxYnEqk6q3PX8qXKq7t4Qs/btUCd0x6MGNsfuReEdZOvBt
        l6lANSNmVth+geSlZ2otwV/L9UH95uuT1I014joplJRSaNz3o6jPZnL9C5q+r1YdcX50MxUIaWO
        H3S71VI6L10K10auFNnP1CgG0SxHR
X-Received: by 2002:adf:ff89:: with SMTP id j9mr15492650wrr.245.1588860150949;
        Thu, 07 May 2020 07:02:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIPvoaYCurDekntvYlLb8+t0hGTWO84sSUT3CbR82pBqkKg39Q+0URvwlu0H+uaRnQnW4IjfQ==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr15492614wrr.245.1588860150652;
        Thu, 07 May 2020 07:02:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v5sm8386756wrr.93.2020.05.07.07.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 07:02:29 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2ac1770-56aa-0ce0-5451-6f1816abca73@redhat.com>
Date:   Thu, 7 May 2020 16:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410210652.GA16905@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi All,

On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
> On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
>> Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
>> TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
>> the TPM_CHIP_FLAG_IRQ ever.
>>
>> So the whole IRQ probing code is not useful, worse we rely on the
>> IRQ-test path of tpm_tis_send() to call disable_interrupts() if
>> interrupts do not work, but that path never gets entered because we
>> never set the TPM_CHIP_FLAG_IRQ.
>>
>> So the remaining IRQ probe code calls request_irq() and never calls
>> free_irq() even when the interrupt is not working.
>>
>> On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
>> to use and never free creates an interrupt storm followed by
>> an "irq XX: nobody cared" oops.
>>
>> Since it is non-functional at the moment anyways, lets just completely
>> disable the IRQ code in tpm_tis_core for now.
>>
>> Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note I'm working with Lenovo to try and get to the bottom of this.
>> ---
> 
> OK if I recall correctly the reason for reverting was that the fixes
> Stefan was sending were broken and no access to hardware were the
> issues would be visible. The reason for not doing anything til this
> day is that we don't have T490 available.

So as promised I have been in contact with Lenovo about this.

Specifically I have been in contact with Lenovo about seeing an
IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
8th gen (X1C8), because of the now public plan that Lenovo will
offer ordering this model with Fedora pre-installed:
https://lwn.net/Articles/818595/

On the X1C8 the problem has been diagnosed to be a misconfigured
GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
TPM chip with its IRQ connected to a GPIO on the SoC which is
configured in Direct IRQ mode, so that it directly asserts
IRQs on one of the APIC IRQs.  The problem is that due to the
misconfiguration as soon as the IRQ is enabled it fires
continuously.

For the X1C8 this should be fixed in the BIOS of the first
batch which gets shipped out to customers so there we should
not have to worry about this.

It is likely (but not yet confirmed) that the issue on the T490
is the same, although on my test X1C8 device I got an IRQ storm,
followed by the kernel disabling the IRQ, not a non booting system.
I guess this might be due to kernel configuration differences.

Assuming that the issue on the T490 is the same, we might see a
BIOS update fixing this, but given that non-booting is
'not good ("tm")' even if there will be a BIOS fix we should
still do something at the kernel level to also work with the
older unfixed BIOS which is already out there.

I've been thinking about this and I'm afraid that the only thing
what we can do is add a DMI product-name (product-version for Lenovo)
string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
and set tpm_info.irq = -1 for devices on that list.

My plan is to prepare a RFC patch of such a blacklist, while we
wait for confirmation that the root cause on the T490 is the same
as on the X1C8, but before I work on that I'm wondering if
people agree that that is the best approach, or if there are
other suggestions for dealing with this ?

Regards,

Hans

