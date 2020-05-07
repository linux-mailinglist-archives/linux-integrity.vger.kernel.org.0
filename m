Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E824F1C8E38
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgEGORR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 10:17:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726093AbgEGORR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588861035;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=MkVjBpFB+K39VBpb0bY5Pdj1N9GI4auTevm5oLBvRZY=;
        b=Y5b6OQBevsNttVOhr+GBrS7aemU62O+R243GcxmonPubj/zfjseloJgveu8V0OMUYIiZGn
        rEU3bKhVgKV64FhizWGATJkfLkwegTa9cMBAu6mimKc7h/9VtiFFGMzketFz//NLsexn4S
        GbIac4HReLg+cHeOWXa6WVpEVTgSf4s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-dbbPHNqlOimLDEErtR_U2A-1; Thu, 07 May 2020 10:17:11 -0400
X-MC-Unique: dbbPHNqlOimLDEErtR_U2A-1
Received: by mail-qv1-f72.google.com with SMTP id ce16so6008298qvb.15
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=MkVjBpFB+K39VBpb0bY5Pdj1N9GI4auTevm5oLBvRZY=;
        b=krql70nO0dF9Lsogw9TLXFvIuWv7v3mHIF6sfiMLyzj4zoeTcUptjLsFFEZxR6hI2O
         5X8WjbxkQ/zOF1qE7T+8rf52Bn/rlbazQl8+5vhH31y5rkDySmP0pm5eSSglSos5X9+n
         jnAXh1/rh9cN2Rz+T69cPzFWsSFjmJLOxt7jPDV0AWVkllf90LtWDexLCJWFNRkWDCIM
         dAV37HxXJBp9gjWbxh/6ggqpY5jLR3eS0LSQMCHTNFDl4caxLYEPV6CeEP9yltr/A2/q
         raxtTW2IP0BGOWhb63nPHcIcFzH0rvfFyKxxeRfHJQH9AgugT1B+6Wt0VLj7rPCZLddD
         kTZg==
X-Gm-Message-State: AGi0PuZZctXp0rOTSKqL97sS7LwwNjQ4cdgpZySJKDtBgX8G/eaynI3O
        guNZWrzu4lFYOqHZLMwpNwK0YvD/dbAgoqjEJwecIEJO4pnTEuHwla2o8hATgR0IIXEWNwvmMsD
        Ofg5GZdmKPDFzKXe0UmyvKB7NryX9
X-Received: by 2002:a37:b587:: with SMTP id e129mr14485439qkf.226.1588861030398;
        Thu, 07 May 2020 07:17:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJkopxidOuO0GycucYmYGFtO57cMU0f8nNVuhONMx6MVth9caui97OMsRePesD0vNonSYVaXg==
X-Received: by 2002:a37:b587:: with SMTP id e129mr14485408qkf.226.1588861030126;
        Thu, 07 May 2020 07:17:10 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id i5sm4186653qtw.97.2020.05.07.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:17:09 -0700 (PDT)
Date:   Thu, 7 May 2020 07:17:07 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Mark Pearson <mpearson@lenovo.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200507141707.pltaa6dxkqkopjoa@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 07 20, Hans de Goede wrote:
>Hi All,
>
>On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
>>On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
>>>Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
>>>TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
>>>the TPM_CHIP_FLAG_IRQ ever.
>>>
>>>So the whole IRQ probing code is not useful, worse we rely on the
>>>IRQ-test path of tpm_tis_send() to call disable_interrupts() if
>>>interrupts do not work, but that path never gets entered because we
>>>never set the TPM_CHIP_FLAG_IRQ.
>>>
>>>So the remaining IRQ probe code calls request_irq() and never calls
>>>free_irq() even when the interrupt is not working.
>>>
>>>On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
>>>to use and never free creates an interrupt storm followed by
>>>an "irq XX: nobody cared" oops.
>>>
>>>Since it is non-functional at the moment anyways, lets just completely
>>>disable the IRQ code in tpm_tis_core for now.
>>>
>>>Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
>>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>---
>>>Note I'm working with Lenovo to try and get to the bottom of this.
>>>---
>>
>>OK if I recall correctly the reason for reverting was that the fixes
>>Stefan was sending were broken and no access to hardware were the
>>issues would be visible. The reason for not doing anything til this
>>day is that we don't have T490 available.
>
>So as promised I have been in contact with Lenovo about this.
>
>Specifically I have been in contact with Lenovo about seeing an
>IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
>8th gen (X1C8), because of the now public plan that Lenovo will
>offer ordering this model with Fedora pre-installed:
>https://lwn.net/Articles/818595/
>
>On the X1C8 the problem has been diagnosed to be a misconfigured
>GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
>TPM chip with its IRQ connected to a GPIO on the SoC which is
>configured in Direct IRQ mode, so that it directly asserts
>IRQs on one of the APIC IRQs.  The problem is that due to the
>misconfiguration as soon as the IRQ is enabled it fires
>continuously.
>
>For the X1C8 this should be fixed in the BIOS of the first
>batch which gets shipped out to customers so there we should
>not have to worry about this.
>
>It is likely (but not yet confirmed) that the issue on the T490
>is the same, although on my test X1C8 device I got an IRQ storm,
>followed by the kernel disabling the IRQ, not a non booting system.
>I guess this might be due to kernel configuration differences.
>
>Assuming that the issue on the T490 is the same, we might see a
>BIOS update fixing this, but given that non-booting is
>'not good ("tm")' even if there will be a BIOS fix we should
>still do something at the kernel level to also work with the
>older unfixed BIOS which is already out there.
>
>I've been thinking about this and I'm afraid that the only thing
>what we can do is add a DMI product-name (product-version for Lenovo)
>string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
>and set tpm_info.irq = -1 for devices on that list.
>
>My plan is to prepare a RFC patch of such a blacklist, while we
>wait for confirmation that the root cause on the T490 is the same
>as on the X1C8, but before I work on that I'm wondering if
>people agree that that is the best approach, or if there are
>other suggestions for dealing with this ?
>
>Regards,
>
>Hans
>

Dan,

Could this be the cause of the problem on the system you were
seeing the issue with, or was that using PTT?

Regards,
Jerry

