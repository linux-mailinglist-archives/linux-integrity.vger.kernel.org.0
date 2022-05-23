Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DA531B84
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiEWUKV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiEWUKS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 16:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D05985A7;
        Mon, 23 May 2022 13:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C760861479;
        Mon, 23 May 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90F4C385A9;
        Mon, 23 May 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653336616;
        bh=UU0fBp4m/Kc4upC3LLpKWqipCuNVoU+UBTQcBS2V8qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rI2GIy/3W2Zn7SZ8GxvidQyy7gl9eQKNY2D3KO/F1T3vLw9dkAG0k2aVEaCcQIQ/k
         hhu0fAhah9Sp/ifzGNG4dyc5Oi56MKt7BpGnSteGnPhksvzVM+upqzp7PcUFDbQSap
         sv/BMgEO3eRcfNis464+N4fkL80Q6jjcf1wBm0cl4zAeil9f304T3ieYABIK0D9mSr
         Y2aISAVDca5994ptJ+s5jE5KjZGQocGnrXJnkcNNaOiq/edL+v+JbHWPcCHgDuzXdR
         FE9vidscSK5JmzQzqbYWETmn0qnfLqpAsHXT9shrlcfk8WHDrwAEiwqEsO1p+etj6s
         zLUNt3nrDTJ+Q==
Date:   Mon, 23 May 2022 23:08:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v3 2/2] tpm: Add tpm_tis_verify_crc to the
 tpm_tis_phy_ops protocol layer
Message-ID: <Yovpwl56Q2ChWzbE@kernel.org>
References: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
 <20220520172422.4309-3-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520172422.4309-3-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 20, 2022 at 07:24:22PM +0200, Alexander Steffen wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Other than SPI TPMs, I2C TPMs implement a CRC feature for command and
> response blobs. Add CRC validation to the TIS protocol according to the
> TCG PC Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
> revision 14
> 
> The CRC is calculated over the entirety of the FIFO register. Since the
> phy_ops layer is not aware when the core layer is done reading/writing
> the FIFO, CRC verification must be triggered from the core layer. To
> this end, add an optional phy_ops API call.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
>  drivers/char/tpm/tpm_tis_core.h | 10 ++++++++++
>  drivers/char/tpm/tpm_tis_i2c.c  | 28 ++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dc56b976d816..f1c893a5a38f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -289,6 +289,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	int size = 0;
>  	int status;
>  	u32 expected;
> +	int rc;
>  
>  	if (count < TPM_HEADER_SIZE) {
>  		size = -EIO;
> @@ -328,6 +329,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  		goto out;
>  	}
>  
> +	rc = tpm_tis_verify_crc(priv, (size_t)size, buf);
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "Error crc mismatch for response.\n");
> +		size = rc;
> +		goto out;
> +	}
> +
>  out:
>  	tpm_tis_ready(chip);
>  	return size;
> @@ -443,6 +451,12 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	if (rc < 0)
>  		return rc;
>  
> +	rc = tpm_tis_verify_crc(priv, len, buf);
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "Error crc mismatch for command.\n");
> +		return rc;
> +	}
> +
>  	/* go and do it */
>  	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>  	if (rc < 0)
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 6c203f36b8a1..66a5a13cd1df 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -121,6 +121,8 @@ struct tpm_tis_phy_ops {
>  			  u8 *result, enum tpm_tis_io_mode mode);
>  	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
>  			   const u8 *value, enum tpm_tis_io_mode mode);
> +	int (*verify_crc)(struct tpm_tis_data *data, size_t len,
> +			  const u8 *value);
>  };
>  
>  static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
> @@ -188,6 +190,14 @@ static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
>  	return rc;
>  }
>  
> +static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
> +				     const u8 *value)
> +{
> +	if (!data->phy_ops->verify_crc)
> +		return 0;
> +	return data->phy_ops->verify_crc(data, len, value);
> +}
> +
>  static inline bool is_bsw(void)
>  {
>  #ifdef CONFIG_X86
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 5375ebf57007..bfc26c2a4ed6 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -24,6 +24,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_gpio.h>
> +#include <linux/crc-ccitt.h>
>  #include <linux/tpm.h>
>  #include "tpm_tis_core.h"
>  
> @@ -33,6 +34,7 @@
>  #define TPM_I2C_INTERFACE_CAPABILITY 0x30
>  #define TPM_I2C_DEVICE_ADDRESS 0x38
>  #define TPM_I2C_DATA_CSUM_ENABLE 0x40
> +#define TPM_DATA_CSUM 0x44
>  #define TPM_I2C_DID_VID 0x48
>  #define TPM_I2C_RID 0x4C
>  
> @@ -269,6 +271,24 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>  	return 0;
>  }
>  
> +static int tpm_tis_i2c_verify_crc(struct tpm_tis_data *data, size_t len,
> +				  const u8 *value)
> +{
> +	u16 crc_tpm, crc_host;
> +	int rc;
> +
> +	rc = tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* reflect crc result, regardless of host endianness */
> +	crc_host = swab16(crc_ccitt(0, value, len));
> +	if (crc_tpm != crc_host)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static int init_guard_time(struct tpm_tis_i2c_phy *phy)
>  {
>  	u32 i2c_caps;
> @@ -302,12 +322,14 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>  static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
>  	.read_bytes = tpm_tis_i2c_read_bytes,
>  	.write_bytes = tpm_tis_i2c_write_bytes,
> +	.verify_crc = tpm_tis_i2c_verify_crc,
>  };
>  
>  static int tpm_tis_i2c_probe(struct i2c_client *dev,
>  			     const struct i2c_device_id *id)
>  {
>  	struct tpm_tis_i2c_phy *phy;
> +	const u8 crc_enable = 1;
>  	const u8 locality = 0;
>  	int ret;
>  
> @@ -332,6 +354,12 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
>  	if (ret)
>  		return ret;
>  
> +	ret = tpm_tis_i2c_write_bytes(&phy->priv, TPM_I2C_DATA_CSUM_ENABLE,
> +				      sizeof(crc_enable), &crc_enable,
> +				      TPM_TIS_PHYS_8);
> +	if (ret)
> +		return ret;
> +
>  	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
>  				 NULL);
>  }
> -- 
> 2.25.1
> 

Should be split to two patches: the hook and the implementation for I2C, as
per https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

BR, Jarkko
