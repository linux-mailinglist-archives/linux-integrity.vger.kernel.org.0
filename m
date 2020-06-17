Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0064E1FD949
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQW4q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 18:56:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:36418 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgFQW4p (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 18:56:45 -0400
IronPort-SDR: t4usw9bBVcB9h2lxfeCENm7g2YjkonnCyEv1n5Je5bVqLGGuLLvdFGNYeqJQgC8RgGSL5u8dfR
 bOp+QbIPYChw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 15:56:44 -0700
IronPort-SDR: 7A0ui6M7SUYXBS5DbEqjMX/6BRcr62wkMKtZjlalHtDncJRgW0qB1O1l6SJCbBfv25JcN3PXwP
 /vARZav9oDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="352233390"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2020 15:56:41 -0700
Date:   Thu, 18 Jun 2020 01:56:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200617225626.GA62794@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200604091712.qvcqkkhhtcqoorpd@cantor>
 <456f3660-8609-ba86-de68-f8cbd1e79e55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456f3660-8609-ba86-de68-f8cbd1e79e55@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 10:24:21AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/4/20 11:17 AM, Jerry Snitselaar wrote:
> > On Thu May 07 20, Hans de Goede wrote:
> > > Hi All,
> > > 
> > > On 4/10/20 11:06 PM, Jarkko Sakkinen wrote:
> > > > On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > > > > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > > > > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > > > > the TPM_CHIP_FLAG_IRQ ever.
> > > > > 
> > > > > So the whole IRQ probing code is not useful, worse we rely on the
> > > > > IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> > > > > interrupts do not work, but that path never gets entered because we
> > > > > never set the TPM_CHIP_FLAG_IRQ.
> > > > > 
> > > > > So the remaining IRQ probe code calls request_irq() and never calls
> > > > > free_irq() even when the interrupt is not working.
> > > > > 
> > > > > On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> > > > > to use and never free creates an interrupt storm followed by
> > > > > an "irq XX: nobody cared" oops.
> > > > > 
> > > > > Since it is non-functional at the moment anyways, lets just completely
> > > > > disable the IRQ code in tpm_tis_core for now.
> > > > > 
> > > > > Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > ---
> > > > > Note I'm working with Lenovo to try and get to the bottom of this.
> > > > > ---
> > > > 
> > > > OK if I recall correctly the reason for reverting was that the fixes
> > > > Stefan was sending were broken and no access to hardware were the
> > > > issues would be visible. The reason for not doing anything til this
> > > > day is that we don't have T490 available.
> > > 
> > > So as promised I have been in contact with Lenovo about this.
> > > 
> > > Specifically I have been in contact with Lenovo about seeing an
> > > IRQ storm when the tpm_tis code tries to use the IRQ on a X1 carbon
> > > 8th gen (X1C8), because of the now public plan that Lenovo will
> > > offer ordering this model with Fedora pre-installed:
> > > https://lwn.net/Articles/818595/
> > > 
> > > On the X1C8 the problem has been diagnosed to be a misconfigured
> > > GPIO pin on the CPU (the SoC). The X1C8 uses an SPI connected
> > > TPM chip with its IRQ connected to a GPIO on the SoC which is
> > > configured in Direct IRQ mode, so that it directly asserts
> > > IRQs on one of the APIC IRQs.  The problem is that due to the
> > > misconfiguration as soon as the IRQ is enabled it fires
> > > continuously.
> > > 
> > > For the X1C8 this should be fixed in the BIOS of the first
> > > batch which gets shipped out to customers so there we should
> > > not have to worry about this.
> > > 
> > > It is likely (but not yet confirmed) that the issue on the T490
> > > is the same, although on my test X1C8 device I got an IRQ storm,
> > > followed by the kernel disabling the IRQ, not a non booting system.
> > > I guess this might be due to kernel configuration differences.
> > > 
> > > Assuming that the issue on the T490 is the same, we might see a
> > > BIOS update fixing this, but given that non-booting is
> > > 'not good ("tm")' even if there will be a BIOS fix we should
> > > still do something at the kernel level to also work with the
> > > older unfixed BIOS which is already out there.
> > > 
> > > I've been thinking about this and I'm afraid that the only thing
> > > what we can do is add a DMI product-name (product-version for Lenovo)
> > > string based blacklist for IRQ usage to drivers/char/tpm/tpm_tis.c
> > > and set tpm_info.irq = -1 for devices on that list.
> > > 
> > > My plan is to prepare a RFC patch of such a blacklist, while we
> > > wait for confirmation that the root cause on the T490 is the same
> > > as on the X1C8, but before I work on that I'm wondering if
> > > people agree that that is the best approach, or if there are
> > > other suggestions for dealing with this ?
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > 
> > Jarrko,
> > 
> > Any thoughts about how we should move forward on dealing with this?
> > I've got a report about the original problem Stefan was dealing with,
> > where the tpm isn't powered on when it tries to send a command to
> > generate an interrupt. The tpm is functioning so it isn't urgent,
> > but it would be good to get this cleaned up so users aren't getting
> > transmit errors and firmware bug messages. Hans did you make any
> > progress on the blacklist patch?
> 
> Not really. I wanted to confirm on the X1C8 which I have on loan
> from Lenovo that it indeed was the GPIO pin misconfiguration which
> was the issue. But even though the Lenovo BIOS team claimed that they
> have fixed the root cause now, the workaround of not listing any
> IRQ for the TPM is also still in place in the latest BIOS I have.
> 
> So I cannot test that the IRQ storm is gone with the newer BIOS :|
> 
> Still the GPIO pin misconfiguration likely was the issue of the
> storm I was seeing on the X1C8 and also the T490s likely has the
> same issue. I should actually receive a T490s loaner soon-ish,
> because of some unrelated (Builtin privacy screen) work I'm doing.
> 
> Once I have received the T490s then I can test things on the T490s:
> 1. Revert the reverts so that in theory we get working TPM IRQ
>    support in the kernel again
> 2. Check that the T490s does not like this
> 3. Write and test a blacklist patch
> 
> I'll ping my colleague who has arranged the loaner to ask what
> the status is on it.

Thanks alot. Does not make sense to rush with this now that the
tree is not completely broken.

/Jarkko
