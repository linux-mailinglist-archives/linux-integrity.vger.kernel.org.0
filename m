Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193B70E5C0
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjEWTiP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbjEWTiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:38:12 -0400
X-Greylist: delayed 42780 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 12:37:47 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66802E65;
        Tue, 23 May 2023 12:37:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 68FDE280074C9;
        Tue, 23 May 2023 21:37:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5D39122449; Tue, 23 May 2023 21:37:45 +0200 (CEST)
Date:   Tue, 23 May 2023 21:37:45 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, jsnitsel@redhat.com, hdegoede@redhat.com,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        peter.ujfalusi@linux.intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230523193745.GA5820@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 09:53:58PM +0300, Jarkko Sakkinen wrote:
> On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> > Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> > interrupts instead of polling on all capable TPMs. Unfortunately, on some
> > products the interrupt line is either never asserted or never deasserted.
> >
> > The former causes interrupt timeouts and is detected by
> > tpm_tis_core_init(). The latter results in interrupt storms.
[...]
> > The current approach to avoid those storms is to disable interrupts by
> > adding a DMI quirk for the concerned device.
> >
> > However this is a maintenance burden in the long run, so use a generic
> > approach:
> 
> I'm trying to comprehend how you evaluate, how big maintenance burden
> this would be. Adding even a few dozen table entries is not a
> maintenance burden.
> 
> On the other hand any new functionality is objectively a maintanance
> burden of some measure (applies to any functionality). So how do we know
> that taking this change is less of a maintenance burden than just add
> new table entries, as they come up?

That approach seems irresponsible to me as you force users to report
the issue, you force developers to add a quirk.  Users expect things
to just work.  And that's precisely what this patch will achieve.

Lino introduced the issues by universally enabling interrupts.
He acted responsibly by making the issue disappear most likely
for everyone.  I find it bewildering that you'd prefer the opposite
approach and rather inflict on every affected user to open a
bug report and hope that someone writes a patch for them.

So far interrupts are only enabled in an rc release and linux-next,
yet issue reports have popped up quickly.  My expectation is we'll
see a lot more reports once v6.4-final is released, doubly so when
the next stable kernel with that feature is released.


> > Detect an interrupt storm by counting the number of unhandled interrupts
> > within a 10 ms time interval. In case that more than 1000 were unhandled
> > deactivate interrupts, deregister the handler and fall back to polling.
> 
> I know it can be sometimes hard to evaluate but can you try to explain
> how you came up to the 10 ms sampling period and 1000 interrupt
> threshold? I just don't like abritrary numbers.

If you choose a too low number, you'll get false positives due to
regular interrupt assertion either by the TPM or by another device
sharing the interrupt.

Those numbers may have to be fine-tuned over time to eliminate
false positives and false negatives.  They're as good a number as
any to get that fine-tuning process started.


> > +unhandled:
> > +	tpm_tis_process_unhandled_interrupt(chip);
> > +	return IRQ_HANDLED;
> 
> Shouldn't the return value be IRQ_NONE?

No, absolutely not.  If you return IRQ_NONE here then genirq code
will increase the spurious interrupt counter.  That's bad because
the IRQ storm detection tpm_tis_core.c would race with the IRQ storm
detection in genirq code:

Note that disablement of the interrupt must happen in a work_struct
here to avoid a deadlock. (The deadlock would occur because
devm_free_irq() waits for the interrupt handler to finish.)

Now, let's say the 1000 unhandled interrupts limit has been reached
and the work_struct is scheduled.  If the work_struct isn't run
quickly enough, you may reach the 99900 limit in note_interrupt()
(see kernel/irq/spurious.c) and then genirq code will force the
interrupt off completely.

To avoid that you *have* to return IRQ_HANDLED here and thus pretend
towards genirq code that the interrupt was not spurious.


> >  struct tpm_tis_data {
> > +	struct tpm_chip *chip;
> >  	u16 manufacturer_id;
> >  	struct mutex locality_count_mutex;
> >  	unsigned int locality_count;
> >  	int locality;
> > +	/* Interrupts */
> 
> Not relevant change for a bug fix.

But not harmful either, is it?

Thanks,

Lukas
