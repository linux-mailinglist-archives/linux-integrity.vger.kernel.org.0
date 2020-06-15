Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCA1FA32F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 00:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFOWGb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 18:06:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:20447 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgFOWGa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 18:06:30 -0400
IronPort-SDR: YZR7bszmZI5zPaSEhXr2UsYzaWvHvpYegJKhzJcmA354T3UqMxNWavX+6MAQlRFoEGKNVibGCa
 kELfQO3JrhVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 15:06:29 -0700
IronPort-SDR: g7pM/5WnFQJIjyB0RQlgJAmGUH6fUjSCqY4dAyK4mygQS7uo9hM8YJMDe3fnmMNIYehiwGlHkK
 acMDTWqric+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="476183583"
Received: from ifaivilx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.251])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 15:06:24 -0700
Date:   Tue, 16 Jun 2020 01:06:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200615220625.GA25252@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200604091712.qvcqkkhhtcqoorpd@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604091712.qvcqkkhhtcqoorpd@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 02:17:12AM -0700, Jerry Snitselaar wrote:
> On Thu May 07 20, Hans de Goede wrote:
> > Hi All,
> > 
> > On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
> > > On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > > > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > > > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > > > the TPM_CHIP_FLAG_IRQ ever.
> > > > 
> > > > So the whole IRQ probing code is not useful, worse we rely on the
> > > > IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> > > > interrupts do not work, but that path never gets entered because we
> > > > never set the TPM_CHIP_FLAG_IRQ.
> > > > 
> > > > So the remaining IRQ probe code calls request_irq() and never calls
> > > > free_irq() even when the interrupt is not working.
> > > > 
> > > > On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> > > > to use and never free creates an interrupt storm followed by
> > > > an "irq XX: nobody cared" oops.
> > > > 
> > > > Since it is non-functional at the moment anyways, lets just completely
> > > > disable the IRQ code in tpm_tis_core for now.
> > > > 
> > > > Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > ---
> > > > Note I'm working with Lenovo to try and get to the bottom of this.
> > > > ---
> > > 
> > > OK if I recall correctly the reason for reverting was that the fixes
> > > Stefan was sending were broken and no access to hardware were the
> > > issues would be visible. The reason for not doing anything til this
> > > day is that we don't have T490 available.
> > 
> > So as promised I have been in contact with Lenovo about this.
> > 
> > Specifically I have been in contact with Lenovo about seeing an
> > IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
> > 8th gen (X1C8), because of the now public plan that Lenovo will
> > offer ordering this model with Fedora pre-installed:
> > https://lwn.net/Articles/818595/
> > 
> > On the X1C8 the problem has been diagnosed to be a misconfigured
> > GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
> > TPM chip with its IRQ connected to a GPIO on the SoC which is
> > configured in Direct IRQ mode, so that it directly asserts
> > IRQs on one of the APIC IRQs.  The problem is that due to the
> > misconfiguration as soon as the IRQ is enabled it fires
> > continuously.
> > 
> > For the X1C8 this should be fixed in the BIOS of the first
> > batch which gets shipped out to customers so there we should
> > not have to worry about this.
> > 
> > It is likely (but not yet confirmed) that the issue on the T490
> > is the same, although on my test X1C8 device I got an IRQ storm,
> > followed by the kernel disabling the IRQ, not a non booting system.
> > I guess this might be due to kernel configuration differences.
> > 
> > Assuming that the issue on the T490 is the same, we might see a
> > BIOS update fixing this, but given that non-booting is
> > 'not good ("tm")' even if there will be a BIOS fix we should
> > still do something at the kernel level to also work with the
> > older unfixed BIOS which is already out there.
> > 
> > I've been thinking about this and I'm afraid that the only thing
> > what we can do is add a DMI product-name (product-version for Lenovo)
> > string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
> > and set tpm_info.irq = -1 for devices on that list.
> > 
> > My plan is to prepare a RFC patch of such a blacklist, while we
> > wait for confirmation that the root cause on the T490 is the same
> > as on the X1C8, but before I work on that I'm wondering if
> > people agree that that is the best approach, or if there are
> > other suggestions for dealing with this ?
> > 
> > Regards,
> > 
> > Hans
> > 
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

We need the blacklist. Up until that warnings is the best we can do.

/Jarkko
