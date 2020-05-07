Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B949F1C8D57
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEGOCo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 10:02:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59504 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbgEGOCo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 10:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588860162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJAQX97h/73fz6F5oJeyWiUgnE5xCKILGZxmqYUzLLw=;
        b=dT6Ih1uzP9kLmkaZKw+MnlCSnQbmwFYL27Ft0fjTHT7Hsj0XL3w/qjuTM02ml1mZWMVmg4
        nmXsDBnsYokme8ZJpFu0jV8JFEnGSG2ibeP5Rt08cbRnlsm6xBuxs8VGL9WGVEIsAHY3i+
        KeHBZa2CGcE7ZebEz4PLdmHKmXDkn/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-UM6Lm_u3OdeDBM7_v5Md6A-1; Thu, 07 May 2020 10:02:36 -0400
X-MC-Unique: UM6Lm_u3OdeDBM7_v5Md6A-1
Received: by mail-wm1-f71.google.com with SMTP id l21so3453710wmh.2
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 07:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FJAQX97h/73fz6F5oJeyWiUgnE5xCKILGZxmqYUzLLw=;
        b=HZILdXQfVy5xqPi0w/IySyqMk0yDUwTUgfdbmghIPRfg7648y1Y45OxbcwZ+Acgyag
         anyPSYTHqTdauzcIjQu4c1pGbJPu9Gwh6f18o6PQGsCNCa/M5DxgqnL2++MiBYWTSq0l
         3qqLxPoBav2RbIBlAvP2okzJsYe5rOQ5ZLYhp2OTIyO597SKPuiwJ+i26SbE+i78zitn
         Ulhz/H8xT3EGSJzwm17C/v0pPW0e6QUpyz5wBkZSo6wB+/ENcS9AsSUPiMEqqlHj/15w
         8rHkqff0ekT1ur7ocCqBPp7tp6T2q22AKpUkAXTc8IDInL3uC7fUHPujr7JDcUUsdG8C
         CFeA==
X-Gm-Message-State: AGi0PuaEhJlSa6tKrFEqZzI4aSrAkBDBbwF/1vY3wPnaRohRQ56A8eAX
        BqXJm8AYdi7PmC55czPb3p0wMC0CydYKwlwHo6JcUNkl24vMYtXWECjiEgaGkEHwV9jLd6Z7CQA
        fU9ezCwLL9AsIRc2G/Jurx2EvJNny
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr15545732wrp.304.1588860154892;
        Thu, 07 May 2020 07:02:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjK3s4MPodWh8D9FIW0+i/ROF0Ztx0GYV4Jo7FVNYI5hkK6TbsbSdZaJiQffY3WzwnIVfxog==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr15545655wrp.304.1588860154206;
        Thu, 07 May 2020 07:02:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v5sm8387076wrr.93.2020.05.07.07.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 07:02:33 -0700 (PDT)
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
Message-ID: <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
Date:   Thu, 7 May 2020 16:02:32 +0200
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

