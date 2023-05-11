Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3A6FF404
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbjEKOYF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbjEKOXt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 10:23:49 -0400
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 07:23:45 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3544E66;
        Thu, 11 May 2023 07:23:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 95419100EEFFE;
        Thu, 11 May 2023 16:16:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7102E261A98; Thu, 11 May 2023 16:16:07 +0200 (CEST)
Date:   Thu, 11 May 2023 16:16:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        jsnitsel@redhat.com, peterz@infradead.org
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
Message-ID: <20230511141607.GA32208@wunner.de>
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
 <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
 <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 11, 2023 at 01:22:19PM +0200, Lino Sanfilippo wrote:
> Since beside the one reported by Peter Zijlstra 
> (https://lore.kernel.org/linux-integrity/CSJ0AD1CFYQP.T6T68M6ZVK49@suppilovahvero/T/#t)
> we have another interrupt storm here, it is probably the best to handle those in general
> and to disable interrupts in this case to fall back to polling (this is also what Jerry
> suggested in the thread above).
> 
> I will try to provide a patch for this.

In tpm_tis_probe_irq_single(), after you've requested the irq,
you could convert it to a struct irq_desc (via irq_to_desc()
from <linux/irqnr.h>) and cache that pointer in priv.

Then in tis_int_handler(), you could access the irqs_unhandled
member of struct irq_desc (from <linux/irqdesc.h>) and check
if it exceeds, say, 5000.

If it does, schedule a work_struct which calls disable_interrupts().
You can't call that from the IRQ handler because devm_free_irq()
waits for the IRQ handler to finish, so you'd deadlock.  You *can*
of course clear the TPM_GLOBAL_INT_ENABLE bit from the IRQ handler,
though it's unclear to me if that's sufficient to quiesce the
interrupt line.

By reusing the genirq subsystem's irqs_unhandled infrastructure,
you avoid having to reimplement all of that.

Thanks,

Lukas
