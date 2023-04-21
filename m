Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708786EAF79
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjDUQuT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjDUQuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 12:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42413C2C;
        Fri, 21 Apr 2023 09:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB8E640BD;
        Fri, 21 Apr 2023 16:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F92C433EF;
        Fri, 21 Apr 2023 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682095814;
        bh=LyRIlKIUBzFN2a/R04+4tESPBPT8fUianNIT4d+AFxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bwe8dS98ALqvvFCpt0IaK5LQnwugqNuMDCR9WcCaOWlzKcb57aUgLioGS4YzOh3cA
         LmUiESVzyUhs4DQdlIK4WkMhx31ZVZtGpJanTUh4BtJJJE8RxRxg4sVcnnQR7YToZd
         ZZtiAjeNmjRpRqmLfAYW/3+nQGsAtobSkqHtfWU0X6+xFD2tdT31a1HxaO4RUGZYXe
         HFDB1HG185oSfboNxg7pwaqgouX90uo5pGcjPHt7yzQog23+TvlASkRcd49K/UQDtd
         R/iglAyNviQsWBaPy9S+W6/KfKfi5xRLRpXD5yzPAfZeywG7LLFBWNZjn3B8U0a38S
         qZdNcnpDSWIug==
Date:   Fri, 21 Apr 2023 19:50:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
Message-ID: <ZEK+w3Q++vu4Kl5x@kernel.org>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
 <c02493fac223707de39e44d51b0a0ce512565250.camel@mniewoehner.de>
 <20230319135338.c7k6r3ws6lby5qgv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319135338.c7k6r3ws6lby5qgv@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 19, 2023 at 03:53:38PM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 16, 2023 at 06:18:11PM +0100, Michael Niewöhner wrote:
> > On Fri, 2023-02-24 at 15:48 +0100, Lino Sanfilippo wrote:
> > > On 24.11.22 at 14:55, Lino Sanfilippo wrote:
> > > > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > > 
> > > > This series enables IRQ support for the TPM TIS core. For this reason a
> > > > number of bugfixes around the interrupt handling are required (patches 1 to
> > > > 5).
> > > > 
> > > > Patch 6 takes into account that according to the TPM Interface
> > > > Specification stsValid and commandRead interrupts might not be supported
> > > > by the hardware. For this reason the supported interrupts are first queried
> > > > and stored. Then wait_for_tpm_stat() is adjusted to not wait for status
> > > > changes that are not reported by interrupts.
> > > > 
> > > > Patch 7 moves the interrupt flag checks into an own function as suggested
> > > > by Jarkko.
> > > > 
> > > > Patch 8 Removes the possibility that tpm_tis_data->locality can be changed
> > > > at driver runtime so this variable can be read without the need to protect
> > > > it against concurrent modification.
> > > > 
> > > > Patch 9 addresses the issue with concurrent locality handling:
> > > > Since the interrupt handler writes the interrupt status registers it needs
> > > > to hold the locality. However it runs concurrently to the thread which
> > > > triggered the interrupt (e.g. by reading or writing data to the TPM). So
> > > > it must take care when claiming and releasing the locality itself,
> > > > because it may race with the concurrent running thread which also claims
> > > > and releases the locality.
> > > > To avoid that both interrupt and concurrent running thread interfere with
> > > > each other a locality counter is used which guarantees that at any time
> > > > the locality is held as long as it is required by one of both execution
> > > > paths.
> > > > 
> > > > Patch 10 implements the request of a threaded interrupt handler. This is
> > > > needed since SPI uses a mutex for data transmission and since we access the
> > > > interrupt status register via SPI in the irq handler we need a sleepable
> > > > context.
> > > > 
> > > > Patch 11 makes sure that writes to the interrupt register are effective if
> > > > done in the interrupt handler.
> > > > 
> > > > Patch 12 makes sure that writes to the interrupt and INTERRUPT_VECTOR
> > > > and INTERRUPT_ENABLE registers are effective by holding the locality.
> > > > 
> > > > Patch 13 makes sure that the TPM is properly initialized after power cycle
> > > > before the irq test is done.
> > > > 
> > > > Patch 14 enables the test for interrupts by setting the required flag
> > > > before the test is executed.
> > > > 
> > > > Changes in v11:
> > > > - adjust patches 4,5 and 14 slightly to void the consecutive removal and
> > > >   re-addition of the "ret" variable in tpm_tis_gen_interrupt()
> > > > 
> > > > Changes in v10:
> > > > - fix typo in subject line as pointed out by Jason Andryuk
> > > > - improve patch "tpm, tpm_tis: Claim locality before writing interrupt
> > > >   registers" by extending the scope with held locality". For this reason
> > > >   the "Reviewed-by" tag by Jarko and the "Tested-by" tag by Michael have
> > > >   been removed.
> > > > - add fix to avoid TPM_RC_INITIALIZE after power cycle when testing irqs
> > > >   (PATCH 13)
> > > > - add fix to restore the old interrupt vector at error (PATCH 4)
> > > > 
> > > > 
> > > > Changes in v9:
> > > > - add a fix for an issue when interrupts are reenabled on resume (PATCH 11)
> > > > - improve the commit message for patch 8 as requested by Jarkko
> > > > - improved functions naming
> > > > - changed patch 12 (tpm, tpm_tis: Enable interrupt test) to not delete the
> > > >   TPM_CHIP_FLAG_IRQ flag any more when tpm2_get_tpm_pt() fails. Due to this
> > > >   change the 'Tested-by' tag from Michael and the 'Reviewed-by:' tag from
> > > >   Jarko has been removed
> > > > 
> > > > Changes in v8:
> > > > - tpm_tis_data->locality is not changed at runtime any more so that it can
> > > > be read without any protection against concurrent modification.
> > > > - add missing brackets as pointed out by Jason Andryuk
> > > > 
> > > > Changes in v7:
> > > > - moved interrupt flag checks into an own function as suggested by Jarkko
> > > > - added "Tested-by" tags for Tests from Michael Niewöhner
> > > > - fixed one comment
> > > > 
> > > > Changes in v6:
> > > > - set TPM_TIS_IRQ_TESTED in flag member of the tpm_tis_data struct instead
> > > > in an own bitfield
> > > > - improve commit messages
> > > > - use int_mask instead of irqs_in_use as variable name
> > > > - use sts_mask instead of active_irqs as variable name
> > > > - squash patch 5 and 6
> > > > - prefix functions with tpm_tis_
> > > > - remove "fixes" tag
> > > > 
> > > > Changes in v5:
> > > > - improve commit message of patch 1 as requested by Jarko
> > > > - drop patch that makes locality handling simpler by only claiming it at
> > > >   driver startup and releasing it at driver shutdown (requested by Jarko)
> > > > - drop patch that moves the interrupt test from tpm_tis_send()
> > > >   to tmp_tis_probe_irq_single() as requested by Jarko
> > > > - add patch to make locality handling threadsafe so that it can also be
> > > >   done by the irq handler
> > > > - separate logical changes into own patches
> > > > - always request threaded interrupt handler
> > > > 
> > > > Changes in v4:
> > > > - only request threaded irq in case of SPI as requested by Jarko.
> > > > - reimplement patch 2 to limit locality handling changes to the TIS core.
> > > > - separate fixes from cleanups as requested by Jarko.
> > > > - rephrase commit messages
> > > > 
> > > > Changes in v3:
> > > > - fixed compiler error reported by kernel test robot
> > > > - rephrased commit message as suggested by Jarko Sakkinen
> > > > - added Reviewed-by tag
> > > > 
> > > > Changes in v2:
> > > > - rebase against 5.12
> > > > - free irq on error path
> > > > 
> > > > 
> > > > Lino Sanfilippo (14):
> > > >   tpm, tpm_tis: Avoid cache incoherency in test for interrupts
> > > >   tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
> > > >   tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
> > > >   tpm, tpm_tis: Do not skip reset of original interrupt vector
> > > >   tpm, tpm_tis: Claim locality before writing interrupt registers
> > > >   tpm, tpm_tis: Only handle supported interrupts
> > > >   tpm, tpm_tis: Move interrupt mask checks into own function
> > > >   tpm, tpm_tis: do not check for the active locality in interrupt
> > > >     handler
> > > >   tpm, tpm: Implement usage counter for locality
> > > >   tpm, tpm_tis: Request threaded interrupt handler
> > > >   tpm, tpm_tis: Claim locality in interrupt handler
> > > >   tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
> > > >   tpm, tpm_tis: startup chip before testing for interrupts
> > > >   tpm, tpm_tis: Enable interrupt test
> > > > 
> > > >  drivers/char/tpm/tpm-chip.c     |  38 ++--
> > > >  drivers/char/tpm/tpm.h          |   1 +
> > > >  drivers/char/tpm/tpm_tis.c      |   2 +-
> > > >  drivers/char/tpm/tpm_tis_core.c | 299 ++++++++++++++++++++------------
> > > >  drivers/char/tpm/tpm_tis_core.h |   5 +-
> > > >  5 files changed, 214 insertions(+), 131 deletions(-)
> > > > 
> > > 
> > > Hi Jarkko,
> > > 
> > > its been a while now since the review of this series has been completed. Will
> > > it be merged in the
> > > near future? Or is there anything left to do (from my side)?
> > > 
> > > Regards,
> > > Lino
> > > 
> > 
> > @Jarkko ping ;)
> > 
> 
> Thanks for reminding. I was wondering this week what was the situation
> but latest version I had bookmarked from lore was 10.
> 
> Please ping earlier! I'll get on testing this, apologies.

I tested this with libvirt/QEMU/swtpm and did the following tests:

1. TPM 1.2 suspend/resume.
2. TPM 2.0 kselftest.
3. TPM 2.0 suspend/resume + kselftest.

I see no issues so I can pick this for my pull request.

Tests were performed on top of v6.3-rc7.

For all:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
