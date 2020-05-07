Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A857C1C9DEC
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 23:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGVv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVv4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 17:51:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA4C05BD43
        for <linux-integrity@vger.kernel.org>; Thu,  7 May 2020 14:51:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so5921536ejx.5
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80odJHq5iNnD4K/PwadcA419/qQfhCPstKrgbgDEwTI=;
        b=troJMdqMQUJ1T2WLPStS5iGPMi8Be2mPb93HwA0lSHHHCXx0xPhnOoGsno4Q179Iwj
         SBuE3gkGyHChGGbs8UV+Oko8hOB0csfG3RSizv9MjDlDbDEy6Y0o3s1Hs9gzz++Yns7f
         Od7bB+1n+xAqAobDs46x5+Wf52YhTxall7CaYi9gpiQ4S/v33Cwm3ykC5hYQlKa+a7Ra
         MTssJXOBv691jHRI3GIn9bfktjSpd2xW+kxblMKFdTu2ZP2WtJgxqaBItziiJVeO2pNg
         psgPsfbBsf53qUP3qKY5WD/V1hQu7DdUZPyUn0Lf29vdsqAc41Jt35ItxlTacHplae1I
         DXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80odJHq5iNnD4K/PwadcA419/qQfhCPstKrgbgDEwTI=;
        b=D0/nkUC7YwAn833KtGpESsCDnUWtWQMOQnQdFaj9gg6A3RqvBaxfCsc9C2UXagIjB6
         YNhgjDW6CtrJFc/5MmpGwLz92/Xk+puFNih/LBnfMBt2oe094mNDHNV5cJgGrTQr0EzE
         JAMJKyXJnqEg8Nk2FO7N4b3+Pv9Zqp9po/OxTEF7Ixv3wdv6A12w+YYhu/CTA/B4FZVI
         MBIYfN50qTP3/oKyqKt/SWPSKlbHXRYTfgqYPQBuNPyaSkBC+Thgr1DtcCvcyqa1dSqd
         L6INe2c5DkoF70FsTtyj5TJxSjG10lwiB3FlVMqlhYxkLy+3vuuftzNEtA/paj4vCprJ
         voUQ==
X-Gm-Message-State: AGi0PuYgSQlJAT+CkptAfwMHlNSh4ntro01euBeBs3g4BPo26GKBVKgU
        OenMIH3zq/TAvkSnXNlDhv6nx/x+VgR1mgUpJDv2vg==
X-Google-Smtp-Source: APiQypIQP13MF6NvFhPpn4m/eD6P3j3XAGhd5JX5CgB5Pj+pyekGGwt33sQKVfcex2UoaL0UG/HdXFyvYZtaeb3DoEA=
X-Received: by 2002:a17:906:855a:: with SMTP id h26mr14608386ejy.56.1588888314504;
 Thu, 07 May 2020 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200409211044.21625-1-hdegoede@redhat.com> <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com> <20200507141707.pltaa6dxkqkopjoa@cantor>
In-Reply-To: <20200507141707.pltaa6dxkqkopjoa@cantor>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 May 2020 14:51:43 -0700
Message-ID: <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 7, 2020 at 7:17 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Thu May 07 20, Hans de Goede wrote:
> >Hi All,
> >
> >On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
> >>On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> >>>Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> >>>TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> >>>the TPM_CHIP_FLAG_IRQ ever.
> >>>
> >>>So the whole IRQ probing code is not useful, worse we rely on the
> >>>IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> >>>interrupts do not work, but that path never gets entered because we
> >>>never set the TPM_CHIP_FLAG_IRQ.
> >>>
> >>>So the remaining IRQ probe code calls request_irq() and never calls
> >>>free_irq() even when the interrupt is not working.
> >>>
> >>>On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> >>>to use and never free creates an interrupt storm followed by
> >>>an "irq XX: nobody cared" oops.
> >>>
> >>>Since it is non-functional at the moment anyways, lets just completely
> >>>disable the IRQ code in tpm_tis_core for now.
> >>>
> >>>Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> >>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>---
> >>>Note I'm working with Lenovo to try and get to the bottom of this.
> >>>---
> >>
> >>OK if I recall correctly the reason for reverting was that the fixes
> >>Stefan was sending were broken and no access to hardware were the
> >>issues would be visible. The reason for not doing anything til this
> >>day is that we don't have T490 available.
> >
> >So as promised I have been in contact with Lenovo about this.
> >
> >Specifically I have been in contact with Lenovo about seeing an
> >IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
> >8th gen (X1C8), because of the now public plan that Lenovo will
> >offer ordering this model with Fedora pre-installed:
> >https://lwn.net/Articles/818595/
> >
> >On the X1C8 the problem has been diagnosed to be a misconfigured
> >GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
> >TPM chip with its IRQ connected to a GPIO on the SoC which is
> >configured in Direct IRQ mode, so that it directly asserts
> >IRQs on one of the APIC IRQs.  The problem is that due to the
> >misconfiguration as soon as the IRQ is enabled it fires
> >continuously.
> >
> >For the X1C8 this should be fixed in the BIOS of the first
> >batch which gets shipped out to customers so there we should
> >not have to worry about this.
> >
> >It is likely (but not yet confirmed) that the issue on the T490
> >is the same, although on my test X1C8 device I got an IRQ storm,
> >followed by the kernel disabling the IRQ, not a non booting system.
> >I guess this might be due to kernel configuration differences.
> >
> >Assuming that the issue on the T490 is the same, we might see a
> >BIOS update fixing this, but given that non-booting is
> >'not good ("tm")' even if there will be a BIOS fix we should
> >still do something at the kernel level to also work with the
> >older unfixed BIOS which is already out there.
> >
> >I've been thinking about this and I'm afraid that the only thing
> >what we can do is add a DMI product-name (product-version for Lenovo)
> >string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
> >and set tpm_info.irq = -1 for devices on that list.
> >
> >My plan is to prepare a RFC patch of such a blacklist, while we
> >wait for confirmation that the root cause on the T490 is the same
> >as on the X1C8, but before I work on that I'm wondering if
> >people agree that that is the best approach, or if there are
> >other suggestions for dealing with this ?
> >
> >Regards,
> >
> >Hans
> >
>
> Dan,
>
> Could this be the cause of the problem on the system you were
> seeing the issue with, or was that using PTT?

It sounds similar, I'm just not immediately aware of where I can find
out how the GPIOs are routed on that development board. I'll poke
around.

What's PTT?

My concern with a blacklist is that the existing tpm_tis module
parameter to disable interrupts, IIRC, did not help mitigate this
problem. So I would think that if there is a blackilst it should at
least be amenable by module parameter for new platforms, or that
specifying "interrupts=0" to tpm_tis.ko behaves identically to the
device being placed on the list.
