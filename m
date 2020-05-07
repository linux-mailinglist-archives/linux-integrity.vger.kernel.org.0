Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EF1C9F07
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGXOA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 19:14:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726792AbgEGXOA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 19:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588893237;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=S3swpeKU7anYk/AhJX551amM33lErjjBBuezyw+S+iQ=;
        b=UsylxGh1Fz7fEBtGpDG1iba1iNJ4YzcEdI12e3SIJKYMNLImBUUlN8JOATqIBW7W3QzVVl
        VU77Mwx0JJ8gI47wEKicYE3jo/urTfD/B/oCVnGIKvJyh1+dIKaP8QpU43YfSJhufnjM8N
        4jyPJgEB8AfQqhn1orZJiJzNYYIbcoY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-mrHionEaNoKQFK10Z9xBEA-1; Thu, 07 May 2020 19:13:55 -0400
X-MC-Unique: mrHionEaNoKQFK10Z9xBEA-1
Received: by mail-qv1-f72.google.com with SMTP id m20so7535041qvy.13
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 16:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=S3swpeKU7anYk/AhJX551amM33lErjjBBuezyw+S+iQ=;
        b=atgwqPRUzN2Rty69H8i0PGjz9rGxFouljCAzEGNEb5h9N/LiS1LOLURoD1TEjmsrT0
         VOGsYvB7CktRnb29Mq/1tSg7qqCuNFhvNAwLqRn0tyGDhLrLJnTinnoh5hXoCVFr/pyl
         fyMUC15BhnVVt+G2XQrzrg97k9xNvD0HaWemTw043b1okw0olQTXZ9t+Agb6H3KUZ5Fg
         wV84xi9kYZ7U079fzC8v0RixeD2/G9zo1wWIENkCLoKjv3Su3iWXUCU9DXd/dfXU+zi1
         bPUDzVHjzNTacOGgrMWp0IZUVUF/G9x2wJ6y1u/+0+K+Y/W0gEap2v8fkuAZARJqqvS6
         KvfA==
X-Gm-Message-State: AGi0PuYM6K6hNYnrwNJD5oyuMKSAqwj1v1UMNIRGiOsZeR9EezHTxBFT
        va12SV6icZqzJSN4hGNR8Uo/ZThOaL2/5MOPP3sIv/472OgZlwy7Yo9QvAkuaIIhHah396Ftnro
        4hiQ8z8ONA/eot/6q6P46d0fPQwbW
X-Received: by 2002:aed:234f:: with SMTP id i15mr17772173qtc.249.1588893234325;
        Thu, 07 May 2020 16:13:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIl+sPOu/sBQVgRVXPE29Jn5kfL6yBTNamoh0rMTyvB4E/H5l4vePEseee0I765dyiPeejFlg==
X-Received: by 2002:aed:234f:: with SMTP id i15mr17772150qtc.249.1588893234086;
        Thu, 07 May 2020 16:13:54 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 127sm5422724qkj.59.2020.05.07.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:13:53 -0700 (PDT)
Date:   Thu, 7 May 2020 16:13:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200507231350.axzswbmc5v672mit@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200507141707.pltaa6dxkqkopjoa@cantor>
 <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 07 20, Dan Williams wrote:
>On Thu, May 7, 2020 at 7:17 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> On Thu May 07 20, Hans de Goede wrote:
>> >Hi All,
>> >
>> >On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
>> >>On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
>> >>>Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
>> >>>TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
>> >>>the TPM_CHIP_FLAG_IRQ ever.
>> >>>
>> >>>So the whole IRQ probing code is not useful, worse we rely on the
>> >>>IRQ-test path of tpm_tis_send() to call disable_interrupts() if
>> >>>interrupts do not work, but that path never gets entered because we
>> >>>never set the TPM_CHIP_FLAG_IRQ.
>> >>>
>> >>>So the remaining IRQ probe code calls request_irq() and never calls
>> >>>free_irq() even when the interrupt is not working.
>> >>>
>> >>>On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
>> >>>to use and never free creates an interrupt storm followed by
>> >>>an "irq XX: nobody cared" oops.
>> >>>
>> >>>Since it is non-functional at the moment anyways, lets just completely
>> >>>disable the IRQ code in tpm_tis_core for now.
>> >>>
>> >>>Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
>> >>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> >>>---
>> >>>Note I'm working with Lenovo to try and get to the bottom of this.
>> >>>---
>> >>
>> >>OK if I recall correctly the reason for reverting was that the fixes
>> >>Stefan was sending were broken and no access to hardware were the
>> >>issues would be visible. The reason for not doing anything til this
>> >>day is that we don't have T490 available.
>> >
>> >So as promised I have been in contact with Lenovo about this.
>> >
>> >Specifically I have been in contact with Lenovo about seeing an
>> >IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
>> >8th gen (X1C8), because of the now public plan that Lenovo will
>> >offer ordering this model with Fedora pre-installed:
>> >https://lwn.net/Articles/818595/
>> >
>> >On the X1C8 the problem has been diagnosed to be a misconfigured
>> >GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
>> >TPM chip with its IRQ connected to a GPIO on the SoC which is
>> >configured in Direct IRQ mode, so that it directly asserts
>> >IRQs on one of the APIC IRQs.  The problem is that due to the
>> >misconfiguration as soon as the IRQ is enabled it fires
>> >continuously.
>> >
>> >For the X1C8 this should be fixed in the BIOS of the first
>> >batch which gets shipped out to customers so there we should
>> >not have to worry about this.
>> >
>> >It is likely (but not yet confirmed) that the issue on the T490
>> >is the same, although on my test X1C8 device I got an IRQ storm,
>> >followed by the kernel disabling the IRQ, not a non booting system.
>> >I guess this might be due to kernel configuration differences.
>> >
>> >Assuming that the issue on the T490 is the same, we might see a
>> >BIOS update fixing this, but given that non-booting is
>> >'not good ("tm")' even if there will be a BIOS fix we should
>> >still do something at the kernel level to also work with the
>> >older unfixed BIOS which is already out there.
>> >
>> >I've been thinking about this and I'm afraid that the only thing
>> >what we can do is add a DMI product-name (product-version for Lenovo)
>> >string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
>> >and set tpm_info.irq = -1 for devices on that list.
>> >
>> >My plan is to prepare a RFC patch of such a blacklist, while we
>> >wait for confirmation that the root cause on the T490 is the same
>> >as on the X1C8, but before I work on that I'm wondering if
>> >people agree that that is the best approach, or if there are
>> >other suggestions for dealing with this ?
>> >
>> >Regards,
>> >
>> >Hans
>> >
>>
>> Dan,
>>
>> Could this be the cause of the problem on the system you were
>> seeing the issue with, or was that using PTT?
>
>It sounds similar, I'm just not immediately aware of where I can find
>out how the GPIOs are routed on that development board. I'll poke
>around.
>
>What's PTT?
>

PTT is Intel's firmware based TPM.

>My concern with a blacklist is that the existing tpm_tis module
>parameter to disable interrupts, IIRC, did not help mitigate this
>problem. So I would think that if there is a blackilst it should at
>least be amenable by module parameter for new platforms, or that
>specifying "interrupts=0" to tpm_tis.ko behaves identically to the
>device being placed on the list.
>

