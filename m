Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C34A096E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfH1S3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 14:29:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48698 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfH1S3F (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 14:29:05 -0400
Received: from [104.132.1.107] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i32go-0000Zu-BI; Wed, 28 Aug 2019 20:29:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v5 4/4] tpm: tpm_tis_spi: Support cr50 devices
Date:   Wed, 28 Aug 2019 20:28:58 +0200
Message-ID: <9117556.gNfTgloEly@phil>
In-Reply-To: <5d66c2df.1c69fb81.b094.745d@mx.google.com>
References: <20190828082150.42194-1-swboyd@chromium.org> <3003195.OAk3N042hN@phil> <5d66c2df.1c69fb81.b094.745d@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am Mittwoch, 28. August 2019, 20:07:26 CEST schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2019-08-28 10:36:29)
> > Am Mittwoch, 28. August 2019, 10:21:50 CEST schrieb Stephen Boyd:
> > > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > > firmware. The firmware running on the currently supported H1 Secure
> > > Microcontroller requires a special driver to handle its specifics:
> > > 
> > >  - need to ensure a certain delay between SPI transactions, or else
> > >    the chip may miss some part of the next transaction
> > >  - if there is no SPI activity for some time, it may go to sleep,
> > >    and needs to be waken up before sending further commands
> > >  - access to vendor-specific registers
> > > 
> > > Cr50 firmware has a requirement to wait for the TPM to wakeup before
> > > sending commands over the SPI bus. Otherwise, the firmware could be in
> > > deep sleep and not respond. The method to wait for the device to wakeup
> > > is slightly different than the usual flow control mechanism described in
> > > the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> > > start a SPI transfer so we can keep track of the last time the TPM
> > > driver accessed the SPI bus to support the flow control mechanism.
> > 
> > While the previous version did run just fine on my mainline gru-scarlet,
> > this v5 very persistently runs into a panic on every boot:
> > 
> > [    6.625500] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > [    6.632983] tpm_tis_spi spi1.0: Timeout waiting for TPM ready IRQ
> > [    6.637415] Mem abort info:
> > [    6.637417]   ESR = 0x96000004
> > [    6.637419]   Exception class = DABT (current EL), IL = 32 bits
> > [    6.637423]   SET = 0, FnV = 0
> > [    6.644235] tpm_tis_spi spi1.0: TPM ready IRQ confirmed on attempt 1
> > [    6.647350]   EA = 0, S1PTW = 0
> > [    6.647352] Data abort info:
> > [    6.647353]   ISV = 0, ISS = 0x00000004
> > [    6.647354]   CM = 0, WnR = 0
> > [    6.647357] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000eacc4000
> > [    6.647361] [0000000000000000] pgd=0000000000000000
> > [    6.694812] Internal error: Oops: 96000004 [#1] SMP
> > [    6.700258] Modules linked in: tpm_tis_spi_mod(+) dw_mipi_dsi industrialio_triggered_buffer panfrost(+) drm_kms_helper videobuf2_memops kfifo_buf tpm_tis_core ov2685 ov5695 cros_ec_sensors_core videobuf2_v4l2 gpu_sched tpm videobuf2_common v4l2_common v4l2_fwnode crct10dif_ce drm videodev phy_rockchip_pcie phy_rockchip_dphy dw_wdt rng_core cros_ec_dev rockchip_thermal i2c_hid elants_i2c mc drm_panel_orientation_quirks pwm_bl ipv6
> > [    6.742857] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc6-02924-gef15fcdb727f-dirty #1308
> > [    6.752580] Hardware name: Google Scarlet (DT)
> > [    6.757542] pstate: a0000085 (NzCv daIf -PAN -UAO)
> > [    6.762901] pc : __wake_up_common+0x58/0x170
> > [    6.767670] lr : __wake_up_locked+0x18/0x20
> > [    6.772340] sp : ffff000010003d40
> > [    6.776038] x29: ffff000010003d40 x28: 0000000000000060 
> > [    6.781972] x27: 0000000000000000 x26: ffff000010e4fcef 
> > [    6.787905] x25: 0000000000000001 x24: 0000000000000000 
> > [    6.793838] x23: 0000000000000000 x22: 0000000000000000 
> > [    6.799772] x21: 0000000000000003 x20: ffff8000f0431308 
> > [    6.804944] dwmmc_rockchip fe320000.dwmmc: Unexpected data interrupt latency
> > [    6.805707] x19: ffff8000f04312f8 x18: 0000000000000000 
> > [    6.819504] x17: 0000000000000000 x16: 0000000000000000 
> > [    6.825437] x15: 0000000000000000 x14: 0000000000000000 
> > [    6.831370] x13: 0000000000000000 x12: ffff000010dc9688 
> > [    6.837304] x11: 071c71c71c71c71c x10: 0000000000000040 
> > [    6.843237] x9 : ffff000010de15d8 x8 : ffff000010de15d0 
> > [    6.849171] x7 : ffffffffffffffe8 x6 : 0000000000000000 
> > [    6.855104] x5 : 0000000000000000 x4 : 0000000000000000 
> > [    6.856947] tpm_tis_spi spi1.0: SPI transfer timed out
> > [    6.861037] x3 : 0000000000000000 x2 : 0000000000000001 
> > [    6.861040] x1 : 0000000000000003 x0 : 0000000000000000 
> > [    6.861045] Call trace:
> > [    6.866794] spi_master spi1: failed to transfer one message from queue
> > [    6.872724]  __wake_up_common+0x58/0x170
> > [    6.872727]  __wake_up_locked+0x18/0x20
> > [    6.872732]  complete+0x74/0xa8
> > [    6.900836]  cr50_spi_irq_handler+0x18/0x28 [tpm_tis_spi_mod]
> 
> Thanks! I forgot about pending interrupts and got a little overzealous
> in consolidating that line of code. Can you try this patch?

With that change the tpm is happy again, probes and talks to me.

Heiko


> ---8<-----
> diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> index 535674f4b02a..24b1fb514161 100644
> --- a/drivers/char/tpm/cr50_spi.c
> +++ b/drivers/char/tpm/cr50_spi.c
> @@ -259,12 +259,12 @@ int cr50_spi_probe(struct spi_device *spi)
>  	phy = &cr50_phy->spi_phy;
>  	phy->flow_control = cr50_spi_flow_control;
>  	phy->is_cr50 = true;
> +	init_completion(&phy->ready);
>  
>  	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
> -
> -	mutex_init(&cr50_phy->time_track_mutex);
>  	cr50_phy->wake_after = jiffies;
>  	cr50_phy->last_access = jiffies;
> +	mutex_init(&cr50_phy->time_track_mutex);
>  
>  	if (spi->irq > 0) {
>  		ret = devm_request_irq(&spi->dev, spi->irq, cr50_spi_irq_handler,
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index fdac842a61ed..2f120ddce2d2 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -201,7 +201,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>  	if (!phy->iobuf)
>  		return -ENOMEM;
>  
> -	init_completion(&phy->ready);
>  	phy->spi_device = spi;
>  
>  	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
> @@ -239,6 +238,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  	else
>  		irq = -1;
>  
> +	init_completion(&phy->ready);
>  	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
>  }
>  




