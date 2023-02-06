Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680B068BAE2
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 12:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFLDE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 06:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBFLDC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 06:03:02 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE812054;
        Mon,  6 Feb 2023 03:02:58 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B21761CC457B;
        Mon,  6 Feb 2023 12:02:57 +0100 (CET)
Message-ID: <d356a20f-629c-a534-7a80-b96d0940056d@molgen.mpg.de>
Date:   Mon, 6 Feb 2023 12:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch V2 2/4] tpm: tegra: Support SPI tpm wait state detect
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
 <20230203130133.32901-3-kyarlagadda@nvidia.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230203130133.32901-3-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Krishna,


Thank you for your patch.

Am 03.02.23 um 14:01 schrieb Krishna Yarlagadda:
> Tegra234 and Tegra241 chips have QSPI controller that supports TCG
> TIS hardware flow control. Since the controller only supports half
> duplex, sw wait polling method implemented in tpm_tis_spi does not
> suffice. Added extending driver to disable sw flow control and send

I’d use imperative mood and maybe use another verb:

Add dedicated Tegra driver …

> all transfers in single message.

Please add how you tested and benchmarked this patch.

> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   drivers/char/tpm/Makefile            |   1 +
>   drivers/char/tpm/tpm_tis_spi.h       |   1 +
>   drivers/char/tpm/tpm_tis_spi_main.c  |   4 +-
>   drivers/char/tpm/tpm_tis_spi_tegra.c | 123 +++++++++++++++++++++++++++
>   4 files changed, 128 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 0222b1ddb310..445b15493cb3 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
>   
>   obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
>   tpm_tis_spi-y := tpm_tis_spi_main.o
> +tpm_tis_spi-y += tpm_tis_spi_tegra.o
>   tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>   
>   obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> index d0f66f6f1931..feaea14b428b 100644
> --- a/drivers/char/tpm/tpm_tis_spi.h
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -31,6 +31,7 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>   extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>   				u8 *in, const u8 *out);
>   
> +extern int tegra_tpm_spi_probe(struct spi_device *spi);
>   #ifdef CONFIG_TCG_TIS_SPI_CR50
>   extern int cr50_spi_probe(struct spi_device *spi);
>   #else
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..5d4502a4461a 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -198,7 +198,7 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>   	const struct spi_device_id *spi_dev_id = spi_get_device_id(spi);
>   	tpm_tis_spi_probe_func probe_func;
>   
> -	probe_func = of_device_get_match_data(&spi->dev);
> +	probe_func = device_get_match_data(&spi->dev);
>   	if (!probe_func) {
>   		if (spi_dev_id) {
>   			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> @@ -227,6 +227,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
>   	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
>   	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
>   	{ "cr50", (unsigned long)cr50_spi_probe },
> +	{ "tegra-tpm-spi", (unsigned long)tegra_tpm_spi_probe },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> @@ -236,6 +237,7 @@ static const struct of_device_id of_tis_spi_match[] = {
>   	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
>   	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
>   	{ .compatible = "google,cr50", .data = cr50_spi_probe },
> +	{ .compatible = "nvidia,tegra-tpm-spi", .data = tegra_tpm_spi_probe },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, of_tis_spi_match);
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
> +	struct spi_message m;
> +	struct spi_transfer spi_xfer[3];
> +	u8 transfer_len;

Just use `unsigned int`? [1]

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
> +		if (in) {
> +			spi_xfer[2].tx_buf = NULL;
> +			spi_xfer[2].rx_buf = &phy->iobuf[4];
> +		}
> +		spi_xfer[2].len = transfer_len;
> +		spi_message_add_tail(&spi_xfer[2], &m);
> +
> +		reinit_completion(&phy->ready);
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

Use ternary operator?

     irq = dev->irq > 0 ? dev->irq : -1;

> +
> +	init_completion(&phy->ready);
> +	return tpm_tis_spi_init(dev, phy, irq, &tegra_tpm_spi_phy_ops);
> +}


Kind regards,

Paul


[1]: https://notabs.org/coding/smallIntsBigPenalty.htm
