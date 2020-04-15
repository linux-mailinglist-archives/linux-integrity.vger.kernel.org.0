Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED41A97AF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2020 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408195AbgDOI5V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 04:57:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50137 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408190AbgDOI5Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 04:57:16 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jOdqx-0005eL-B9; Wed, 15 Apr 2020 10:57:03 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jOdqv-0000wl-L6; Wed, 15 Apr 2020 10:57:01 +0200
Message-ID: <71a4f99edb960e0f04ec5e7d8276282f3da95c21.camel@pengutronix.de>
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Date:   Wed, 15 Apr 2020 10:57:01 +0200
In-Reply-To: <20200414174433.r54hawtqxlgo3d7y@cantor>
References: <20200409211044.21625-1-hdegoede@redhat.com>
         <20200410163826.GM11886@ziepe.ca> <20200414174433.r54hawtqxlgo3d7y@cantor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-14 at 10:44 -0700, Jerry Snitselaar wrote:
> On Fri Apr 10 20, Jason Gunthorpe wrote:
> 
> > On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > > the TPM_CHIP_FLAG_IRQ ever.
> > This all used to work..
> 
> 
> IIRC this goes all the way back to 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
> when the flag was added. There was never anything initially setting it in the tpm_tis code.
> There were checks added, but the only place it got set was where it did the interrupt test in
> tpm_tis_send, and it can only get down to that code if the flag is set. Stefan's patch was enabling
> the flag, but with the flag enabled some systems were seeing interrupt storms. I believe it has
> been seen with both the t490 and an internal system that Dan Williams was working on at Intel.
> Without access to hw seeing the problem the decision was to revert Stefan's patches while
> we try to figure out the issues.

I stumbled across this when debugging a sporadic "tpm tpm0:
tpm_try_transmit: send(): error -62 (-ETIME)" we see on a i.MX6 board
with a TPM2 connected via SPI. It seems that comes from down in
wait_for_tpm_stat() when the TPM doesn't become ready quickly enough.

As this board actually has the IRQ connected, but is falling back to
polling, I took another look and what's wrong with the IRQ support. I
don't have it working yet, but have found some things I'd like to share
(and maybe get some fresh ideas).

I used Stefan Berger's "tpm_tis_core: Turn on the TPM before probing
IRQ's" and "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
interrupts" to get it into the IRQ verification code in tpm_tis_send().

Then I changed the IRQ to threaded with IRQF_ONESHOT, as the handler is
calling into the SPI stack (which can sleep). A related problem exists
in wait_for_tpm_stat(), which uses the potentially sleeping
wait_for_tpm_stat_cond() as the condition check in
wait_event_interruptible_timeout(). This leads to a:
[   41.799086] do not call blocking ops when !TASK_RUNNING; state=1 set at [<f02406bc>] prepare_to_wait_event+0x84/0x1a4
seems to lead to working transfers, but nevertheless needs to be
changed to be compatible with sleeping busses.

So I think this probably only worked on systems which don't use SPI.

What still confuses me, is that after a few successful transfers I keep
getting IRQs with TPM_INTF_CMD_READY_INT set, although the handler
clear that bit. If i read the TIS spec correctly, it should only be
asserted by a 0->1 transition of
TPM_INT_STATUS_x.commandReadyIntOccured flag, which shouldn't happend
so often.

Regards,
Jan

