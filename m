Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2661D2116
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2020 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgEMVbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 17:31:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:2436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgEMVbq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 17:31:46 -0400
IronPort-SDR: 6hIasgKj95sDiuDySXMzi2ePXGvVn0K7lnyhDUCtkixlRSM4kY3LlC2rzPF7UW0OaDKUG2WLD/
 BiIYkDF7ZPPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 14:31:44 -0700
IronPort-SDR: HmR9/vmwmZv46JOdreYyGbIj6PA977YaS8eFYkh/8qDJJvDaspd2JDMkRtaIZ6I3OyZPVyGdJ1
 Gn+uhU7ODC/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="266017890"
Received: from rthurerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.107])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2020 14:31:38 -0700
Date:   Thu, 14 May 2020 00:31:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200513213114.GA31974@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200507141707.pltaa6dxkqkopjoa@cantor>
 <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 07, 2020 at 02:51:43PM -0700, Dan Williams wrote:
> On Thu, May 7, 2020 at 7:17 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > On Thu May 07 20, Hans de Goede wrote:
> > >Hi All,
> > >
> > >On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
> > >>On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > >>>Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > >>>TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > >>>the TPM_CHIP_FLAG_IRQ ever.
> > >>>
> > >>>So the whole IRQ probing code is not useful, worse we rely on the
> > >>>IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> > >>>interrupts do not work, but that path never gets entered because we
> > >>>never set the TPM_CHIP_FLAG_IRQ.
> > >>>
> > >>>So the remaining IRQ probe code calls request_irq() and never calls
> > >>>free_irq() even when the interrupt is not working.
> > >>>
> > >>>On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> > >>>to use and never free creates an interrupt storm followed by
> > >>>an "irq XX: nobody cared" oops.
> > >>>
> > >>>Since it is non-functional at the moment anyways, lets just completely
> > >>>disable the IRQ code in tpm_tis_core for now.
> > >>>
> > >>>Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> > >>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >>>---
> > >>>Note I'm working with Lenovo to try and get to the bottom of this.
> > >>>---
> > >>
> > >>OK if I recall correctly the reason for reverting was that the fixes
> > >>Stefan was sending were broken and no access to hardware were the
> > >>issues would be visible. The reason for not doing anything til this
> > >>day is that we don't have T490 available.
> > >
> > >So as promised I have been in contact with Lenovo about this.
> > >
> > >Specifically I have been in contact with Lenovo about seeing an
> > >IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
> > >8th gen (X1C8), because of the now public plan that Lenovo will
> > >offer ordering this model with Fedora pre-installed:
> > >https://lwn.net/Articles/818595/
> > >
> > >On the X1C8 the problem has been diagnosed to be a misconfigured
> > >GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
> > >TPM chip with its IRQ connected to a GPIO on the SoC which is
> > >configured in Direct IRQ mode, so that it directly asserts
> > >IRQs on one of the APIC IRQs.  The problem is that due to the
> > >misconfiguration as soon as the IRQ is enabled it fires
> > >continuously.
> > >
> > >For the X1C8 this should be fixed in the BIOS of the first
> > >batch which gets shipped out to customers so there we should
> > >not have to worry about this.
> > >
> > >It is likely (but not yet confirmed) that the issue on the T490
> > >is the same, although on my test X1C8 device I got an IRQ storm,
> > >followed by the kernel disabling the IRQ, not a non booting system.
> > >I guess this might be due to kernel configuration differences.
> > >
> > >Assuming that the issue on the T490 is the same, we might see a
> > >BIOS update fixing this, but given that non-booting is
> > >'not good ("tm")' even if there will be a BIOS fix we should
> > >still do something at the kernel level to also work with the
> > >older unfixed BIOS which is already out there.
> > >
> > >I've been thinking about this and I'm afraid that the only thing
> > >what we can do is add a DMI product-name (product-version for Lenovo)
> > >string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
> > >and set tpm_info.irq = -1 for devices on that list.
> > >
> > >My plan is to prepare a RFC patch of such a blacklist, while we
> > >wait for confirmation that the root cause on the T490 is the same
> > >as on the X1C8, but before I work on that I'm wondering if
> > >people agree that that is the best approach, or if there are
> > >other suggestions for dealing with this ?
> > >
> > >Regards,
> > >
> > >Hans
> > >
> >
> > Dan,
> >
> > Could this be the cause of the problem on the system you were
> > seeing the issue with, or was that using PTT?
> 
> It sounds similar, I'm just not immediately aware of where I can find
> out how the GPIOs are routed on that development board. I'll poke
> around.
> 
> What's PTT?

Intel fTPM.

/Jarkko
