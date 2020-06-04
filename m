Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208DE1EE100
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFDJRV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 05:17:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbgFDJRU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 05:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591262238;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=+uzpgu8ggc0aWRwLEplmpN5UqevLP5ylXrIMt1zK2MY=;
        b=DsPJLs/DgUiyfD4XmsJWlTZ9XMqzIezftI9p5wDFtnK1XJ746QMqT2blOUTToGeGZ9Hfcv
        ry//SWwsHVykAEjwWtsv4+fw1X4QRSKMM+EEFfDKxZRQWj1TieM7opFYR/Fyg418oq0r3t
        Yv8GJzonsRTdRO0ndLY3V/SbXUTwYFA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Sg8l6y-jP8eFcIYQQXZr3Q-1; Thu, 04 Jun 2020 05:17:15 -0400
X-MC-Unique: Sg8l6y-jP8eFcIYQQXZr3Q-1
Received: by mail-qv1-f72.google.com with SMTP id h4so3878368qvr.21
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 02:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=+uzpgu8ggc0aWRwLEplmpN5UqevLP5ylXrIMt1zK2MY=;
        b=DF/4aCYcZ12PMEl+7YMtC0tSaJNEDvksawk8MsDwGgo0Iy1ZRYdYWhlftKoHjzZ9/W
         jBIyArPwbp6lTe901zTuK0Zllxpyd7u2frrfqG4XzpUrwPv0B19YyLdSyRdFNPWlPiDT
         xG1UEIyQ8J+UWlb6xiR2seUg7hxOnndM2LomabiNZEibLVhq2xzzOPgTRKKVBWTeyf2l
         4dHXmded2MwR4HQsQNGWglrygZ1M5RDPqNFl4vDku5mX3eNPDMxiwkv3ncarjTuf5T9J
         +wB+XdxO/5vjboSUzEx0MW4WRNhY9RK1U4rN3Tzt3z5ZfJJu3Xc+QHlrwErcrqAEhv9q
         ipdg==
X-Gm-Message-State: AOAM530CBiYGzR7dT5iMSqas6/hadlNye24Tu1td4fsFwfwh4/alolF/
        j6QdQB+0x+MmvF5M/7JFhKZpI1mFbZRtU6I4qeTcz0puD56OoGILSlxvxa8NebLpfL00MrcQs8I
        Oxh4UCsitFsViEFWGItWLNV3k+5Y/
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr3396137qtc.257.1591262235057;
        Thu, 04 Jun 2020 02:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsAnZijIV5CEgmKtWzfFl14be8Jr+zG4/czknyTHhWvzTNu4nT8Hwq2Y5ltH4IAybM7SBO6A==
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr3396118qtc.257.1591262234779;
        Thu, 04 Jun 2020 02:17:14 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id m53sm4568122qtb.64.2020.06.04.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 02:17:13 -0700 (PDT)
Date:   Thu, 4 Jun 2020 02:17:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200604091712.qvcqkkhhtcqoorpd@cantor>
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

Jarrko,

Any thoughts about how we should move forward on dealing with this?
I've got a report about the original problem Stefan was dealing with,
where the tpm isn't powered on when it tries to send a command to
generate an interrupt. The tpm is functioning so it isn't urgent,
but it would be good to get this cleaned up so users aren't getting
transmit errors and firmware bug messages. Hans did you make any
progress on the blacklist patch?

