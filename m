Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC16AB8B1
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2019 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbfIFM7m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Sep 2019 08:59:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59273 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392749AbfIFM7k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Sep 2019 08:59:40 -0400
Received: from rettich.hi.pengutronix.de ([2001:67c:670:100:1d::c3] helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1i6DUB-0007mY-8L; Fri, 06 Sep 2019 14:37:07 +0200
Received: from jlu by rettich with local (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1i6DUA-0005wJ-FU; Fri, 06 Sep 2019 14:37:06 +0200
Message-ID: <b19179168421eb511856f0ec5fd328d97f06a68c.camel@pengutronix.de>
Subject: Re: [PATCH] tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
 interrupts
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-stable@vger.kernel.org
Date:   Fri, 06 Sep 2019 14:37:06 +0200
In-Reply-To: <20190830000906.2369009-1-stefanb@linux.vnet.ibm.com>
References: <20190830000906.2369009-1-stefanb@linux.vnet.ibm.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c3
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-29 at 20:09 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The tpm_tis_core has to set the TPM_CHIP_FLAG_IRQ before probing for
> interrupts since there is no other place in the code that would set
> it.

Thanks for this patch! I tested it to fix a
  [   13.198129] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
we've been seeing, but received this scheduling error:
  [   13.241831] tpm_tis_spi spi0.0: 2.0 TPM (device-id 0x1B, rev-id 16)
  [   13.249450] BUG: scheduling while atomic: swapper/0/0/0x00010002
  [   13.255537] Modules linked in:
  [   13.258669] Preemption disabled at:
  [   13.258686] [<c07d10ec>] schedule_preempt_disabled+0x1c/0x20
  [   13.268050] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.21-20190905-1-development #1
  [   13.276106] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  [   13.282788] [<c010fe00>] (unwind_backtrace) from [<c010cc04>] (show_stack+0x10/0x14)
  [   13.290621] [<c010cc04>] (show_stack) from [<c07b7bc8>] (dump_stack+0x78/0x8c)
  [   13.297994] [<c07b7bc8>] (dump_stack) from [<c0147f9c>] (__schedule_bug+0x88/0xd8)
  [   13.305711] [<c0147f9c>] (__schedule_bug) from [<c07d0948>] (__schedule+0x5b0/0x750)
  [   13.313535] [<c07d0948>] (__schedule) from [<c07d0b30>] (schedule+0x48/0xa0)
  [   13.320731] [<c07d0b30>] (schedule) from [<c07d452c>] (schedule_timeout+0x170/0x2a8)
  [   13.328622] [<c07d452c>] (schedule_timeout) from [<c07d1818>] (wait_for_common+0xa4/0x160)
  [   13.336974] [<c07d1818>] (wait_for_common) from [<c05126ec>] (spi_imx_transfer+0xc4/0x5c4)
  [   13.345385] [<c05126ec>] (spi_imx_transfer) from [<c0511644>] (spi_bitbang_transfer_one+0x50/0xa0)
  [   13.354496] [<c0511644>] (spi_bitbang_transfer_one) from [<c050a4a4>] (spi_transfer_one_message+0x18c/0x3cc)
  [   13.364474] [<c050a4a4>] (spi_transfer_one_message) from [<c050aa34>] (__spi_pump_messages+0x350/0x474)
  [   13.374012] [<c050aa34>] (__spi_pump_messages) from [<c050acfc>] (__spi_sync+0x198/0x1a0)
  [   13.382275] [<c050acfc>] (__spi_sync) from [<c04972d4>] (tpm_tis_spi_transfer+0x124/0x300)
  [   13.390683] [<c04972d4>] (tpm_tis_spi_transfer) from [<c04974e0>] (tpm_tis_spi_read_bytes+0x14/0x1c)
  [   13.399957] [<c04974e0>] (tpm_tis_spi_read_bytes) from [<c0497088>] (tpm_tis_spi_read32+0x30/0x58)
  [   13.409057] [<c0497088>] (tpm_tis_spi_read32) from [<c0496614>] (tis_int_handler+0x40/0x13c)
  [   13.417586] [<c0496614>] (tis_int_handler) from [<c01708e4>] (__handle_irq_event_percpu+0x50/0x11c)
  [   13.426783] [<c01708e4>] (__handle_irq_event_percpu) from [<c01709dc>] (handle_irq_event_percpu+0x2c/0x7c)
  [   13.436582] [<c01709dc>] (handle_irq_event_percpu) from [<c0170a64>] (handle_irq_event+0x38/0x5c)
  [   13.445603] [<c0170a64>] (handle_irq_event) from [<c0174b34>] (handle_level_irq+0xcc/0x170)
  [   13.454098] [<c0174b34>] (handle_level_irq) from [<c016fac8>] (generic_handle_irq+0x24/0x34)
  [   13.462625] [<c016fac8>] (generic_handle_irq) from [<c0453ce0>] (mxc_gpio_irq_handler+0x48/0x164)
  [   13.471643] [<c0453ce0>] (mxc_gpio_irq_handler) from [<c0453e5c>] (mx3_gpio_irq_handler+0x60/0xac)
  [   13.480748] [<c0453e5c>] (mx3_gpio_irq_handler) from [<c016fac8>] (generic_handle_irq+0x24/0x34) 
  [   13.489678] [<c016fac8>] (generic_handle_irq) from [<c01700a8>] (__handle_domain_irq+0x7c/0xec)  
  [   13.498459] [<c01700a8>] (__handle_domain_irq) from [<c0443744>] (gic_handle_irq+0x4c/0x90)
  [   13.506956] [<c0443744>] (gic_handle_irq) from [<c0101a8c>] (__irq_svc+0x6c/0xa8)
  [   13.514577] Exception stack(0xc0b01f30 to 0xc0b01f78)
  [   13.519708] 1f20:                                     00000000 00009e08 dfebb360 c0118e20
  [   13.528029] 1f40: ffffe000 c0b09cf0 c0b09d30 00000001 c0b3ff37 c08d0e78 00000001 c0a38a38
  [   13.536346] 1f60: 00000000 c0b01f80 c010988c c0109890 60010013 ffffffff
  [   13.543047] [<c0101a8c>] (__irq_svc) from [<c0109890>] (arch_cpu_idle+0x38/0x3c)
  [   13.550590] [<c0109890>] (arch_cpu_idle) from [<c014f9bc>] (do_idle+0xe0/0x150)
  [   13.558046] [<c014f9bc>] (do_idle) from [<c014fcf4>] (cpu_startup_entry+0x18/0x1c)
  [   13.565699] [<c014fcf4>] (cpu_startup_entry) from [<c0a00dd0>] (start_kernel+0x450/0x484)
  [   13.574017] [<c0a00dd0>] (start_kernel) from [<00000000>] (  (null))
  [   13.580513] bad: scheduling from the idle thread!

This is due to the SPI accesses performed by tis_int_handler (which
will sleep). Switching to devm_request_threaded_irq fixes this and
leads to a successful IRQ probe.

But: It seems that the IRQ is not acked correctly, as the interrupt
line stays low. I suspect this is because the tpm_chip_stop from
http://git.infradead.org/users/jjs/linux-tpmdd.git/commitdiff/9b558deab2c5d7dc23d5f7a4064892ede482ad32
happens before the threaded handler runs. I'm currently unable to
verify that though, as my build machine's disk just died. :/

Regards,
Jan

> Cc: linux-stable@vger.kernel.org
> Fixes: 570a36097f30 ("tpm: drop 'irq' from struct
> tpm_vendor_specific")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c
> b/drivers/char/tpm/tpm_tis_core.c
> index ffa9048d8f6c..270f43acbb77 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -981,6 +981,7 @@ int tpm_tis_core_init(struct device *dev, struct
> tpm_tis_data *priv, int irq,
>  		}
>  
>  		tpm_chip_start(chip);
> +		chip->flags |= TPM_CHIP_FLAG_IRQ;
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, intmask,
> IRQF_SHARED,
>  						 irq);
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

