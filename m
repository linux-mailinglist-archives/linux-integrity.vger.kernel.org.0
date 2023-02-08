Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3968E620
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBHCkB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHCkA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:40:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE22528B;
        Tue,  7 Feb 2023 18:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91FC5B81B2C;
        Wed,  8 Feb 2023 02:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FA7C4339B;
        Wed,  8 Feb 2023 02:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675823996;
        bh=nW1JQejgpwxI/J74A+QINk7F8fZY6PLGrEawNBPPqsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cB9bu8lUhnQlJYEt9d86M5p4l0xf2pXte432mkrFvcTS01h/NzycHoNH1Uo49cqCw
         R98c2NEx51XgB04PCxLMpVJTjEhHEij9uuNADrAK2aR9FitMfONYp/ju3Tth/Nwvts
         H3Dsh5YU68SanFIe4h1jXdHWro7akfmgougCAFsuklOIqZdGvV/T6RZw9jKS2g9fP3
         tBCeW6ccsLSuUW1501ivUM30BBP7UugCWkwTQdfgXgNrhBdiq8shfsvcC9qw8z7nPB
         mpg9tezt6CqMM2qbevKDPGjqvTwQ8lRqWPrwRv5ms7pRo2hCCrpsZBWsfFki3+YaXJ
         2ch2/cvDibtvw==
Date:   Wed, 8 Feb 2023 04:39:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [PATCH 2/4] tpm: tegra: Support SPI tpm wait state detect
Message-ID: <Y+MLdjdjMvcLuhbC@kernel.org>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
 <20230202161750.21210-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202161750.21210-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 02, 2023 at 09:47:48PM +0530, Krishna Yarlagadda wrote:
> Tegra234 and Tegra241 chips have QSPI controller that supports TCG
> TIS hardware flow control. Since the controller only supports half
> duplex, sw wait polling method implemented in tpm_tis_spi does not
> suffice. Added extending driver to disable sw flow control and send

s/Added/Add/

> all transfers in single message.

I've never heard the term "extended driver" before.

> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/char/tpm/Makefile            |   1 +
>  drivers/char/tpm/tpm_tis_spi.h       |   1 +
>  drivers/char/tpm/tpm_tis_spi_main.c  |   4 +-
>  drivers/char/tpm/tpm_tis_spi_tegra.c | 123 +++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 0222b1ddb310..445b15493cb3 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
>  
>  obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
>  tpm_tis_spi-y := tpm_tis_spi_main.o
> +tpm_tis_spi-y += tpm_tis_spi_tegra.o
>  tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>  
>  obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> index d0f66f6f1931..feaea14b428b 100644
> --- a/drivers/char/tpm/tpm_tis_spi.h
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -31,6 +31,7 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>  extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  				u8 *in, const u8 *out);
>  
> +extern int tegra_tpm_spi_probe(struct spi_device *spi);
>  #ifdef CONFIG_TCG_TIS_SPI_CR50
>  extern int cr50_spi_probe(struct spi_device *spi);
>  #else
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..5d4502a4461a 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -198,7 +198,7 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>  	const struct spi_device_id *spi_dev_id = spi_get_device_id(spi);
>  	tpm_tis_spi_probe_func probe_func;
>  
> -	probe_func = of_device_get_match_data(&spi->dev);
> +	probe_func = device_get_match_data(&spi->dev);
>  	if (!probe_func) {
>  		if (spi_dev_id) {
>  			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> @@ -227,6 +227,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
>  	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
>  	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
>  	{ "cr50", (unsigned long)cr50_spi_probe },
> +	{ "tegra-tpm-spi", (unsigned long)tegra_tpm_spi_probe },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> @@ -236,6 +237,7 @@ static const struct of_device_id of_tis_spi_match[] = {
>  	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
>  	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
>  	{ .compatible = "google,cr50", .data = cr50_spi_probe },
> +	{ .compatible = "nvidia,tegra-tpm-spi", .data = tegra_tpm_spi_probe },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_spi_match);
> diff --git a/drivers/char/tpm/tpm_tis_spi_tegra.c b/drivers/char/tpm/tpm_tis_spi_tegra.c
> new file mode 100644
> index 000000000000..23f20684513d
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_spi_tegra.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 NVIDIA CORPORATION.
> + *
> + * This device driver implements TEGRA QSPI hw wait detection for chips
> + *
> + * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ricard.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +
> +#include "tpm_tis_core.h"
> +#include "tpm_tis_spi.h"
> +
> +#define MAX_SPI_FRAMESIZE 64
> +
> +int tpm_tis_spi_tegra_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +			       u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	int ret = 0;

Why do you need to initialize ret?

> +	struct spi_message m;
> +	struct spi_transfer spi_xfer[3];
> +	u8 transfer_len;

Please reorder declarations to reverse christmas tree order.

> +
> +	spi_bus_lock(phy->spi_device->master);
> +
> +	while (len) {
> +		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
> +
> +		spi_message_init(&m);
> +		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
> +		phy->iobuf[1] = 0xd4;
> +		phy->iobuf[2] = addr >> 8;
> +		phy->iobuf[3] = addr;
> +
> +		memset(&spi_xfer, 0, sizeof(spi_xfer));
> +
> +		spi_xfer[0].tx_buf = phy->iobuf;
> +		spi_xfer[0].len = 1;
> +		spi_message_add_tail(&spi_xfer[0], &m);
> +
> +		spi_xfer[1].tx_buf = phy->iobuf + 1;
> +		spi_xfer[1].len = 3;
> +		spi_message_add_tail(&spi_xfer[1], &m);
> +
> +		if (out) {
> +			spi_xfer[2].tx_buf = &phy->iobuf[4];
> +			spi_xfer[2].rx_buf = NULL;
> +			memcpy(&phy->iobuf[4], out, transfer_len);
> +			out += transfer_len;
> +		}

Empty line here.

> +		if (in) {
> +			spi_xfer[2].tx_buf = NULL;
> +			spi_xfer[2].rx_buf = &phy->iobuf[4];
> +		}

Ditto.

> +		spi_xfer[2].len = transfer_len;
> +		spi_message_add_tail(&spi_xfer[2], &m);
> +
> +		reinit_completion(&phy->ready);

Ditto.

> +		ret = spi_sync_locked(phy->spi_device, &m);
> +		if (ret < 0)
> +			goto exit;
> +
> +		if (in) {
> +			memcpy(in, &phy->iobuf[4], transfer_len);
> +			in += transfer_len;
> +		}
> +
> +		len -= transfer_len;
> +	}
> +
> +exit:
> +	spi_bus_unlock(phy->spi_device->master);
> +	return ret;
> +}
> +
> +static int tpm_tis_spi_tegra_read_bytes(struct tpm_tis_data *data, u32 addr,
> +					u16 len, u8 *result,
> +					enum tpm_tis_io_mode io_mode)
> +{
> +	return tpm_tis_spi_tegra_transfer(data, addr, len, result, NULL);
> +}
> +
> +static int tpm_tis_spi_tegra_write_bytes(struct tpm_tis_data *data, u32 addr,
> +					 u16 len, const u8 *value,
> +					 enum tpm_tis_io_mode io_mode)
> +{
> +	return tpm_tis_spi_tegra_transfer(data, addr, len, NULL, value);
> +}
> +
> +static const struct tpm_tis_phy_ops tegra_tpm_spi_phy_ops = {
> +	.read_bytes = tpm_tis_spi_tegra_read_bytes,
> +	.write_bytes = tpm_tis_spi_tegra_write_bytes,
> +};
> +
> +int tegra_tpm_spi_probe(struct spi_device *dev)
> +{
> +	struct tpm_tis_spi_phy *phy;
> +	int irq;
> +
> +	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->flow_control = NULL;
> +
> +	/* If the SPI device has an IRQ then use that */
> +	if (dev->irq > 0)
> +		irq = dev->irq;
> +	else
> +		irq = -1;
> +
> +	init_completion(&phy->ready);
> +	return tpm_tis_spi_init(dev, phy, irq, &tegra_tpm_spi_phy_ops);
> +}
> -- 
> 2.17.1
> 

BR, Jarkko
