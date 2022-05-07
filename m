Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410051E9C6
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiEGT4N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 15:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiEGT4M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 15:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085E101E6;
        Sat,  7 May 2022 12:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02A8DB80839;
        Sat,  7 May 2022 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C4C385A6;
        Sat,  7 May 2022 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651953141;
        bh=X/O4y/aRdXYaFetNBd9mMfz0q2LnvF4V1KFVjT57NfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXkd/hckRQqHEB1FqapYuyS2+P8NmVLo57OzPwrzxOVK0WZn0nzFRhGXgvnN7Vuef
         1PJTYqBsIRsYckOwtfiKCpFCa5BBkKSsfFcaDU46euo90WSw3ew4sh7y3v9W0Kyjf3
         T6XSo/Rzk8K2JrIrF2q/qZhu1cCW3CzpCOPvQqQUU7gcG49ELMi4ucVf6Kt6Uie+gM
         azg67ZXatSFDwyo/YauiWHjeKx5ooTs1NbrG5sH/D1AKEZGWLoDvdpZn2AT3ydwDbw
         3Kuj8nz4Z8Od89cah+KiDe0IbI554Rgh6SZExdUkvDVazickc6CLHt7nhk66OkDltt
         6a5RM4d3Dg5Uw==
Date:   Sat, 7 May 2022 22:53:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/4] tpm: Add tpm_tis_verify_crc to the
 tpm_tis_phy_ops protocol layer
Message-ID: <YnbOVFBWZVsjkdxQ@iki.fi>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
 <20220506170013.22598-2-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506170013.22598-2-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 06, 2022 at 07:00:13PM +0200, Johannes Holland wrote:
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
> index 34d12f78e7ab..5bae8374b877 100644
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
> @@ -253,6 +255,24 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
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
> @@ -286,12 +306,14 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
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
> @@ -316,6 +338,12 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
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
> 2.34.1
> 

This looks quite finished patch, hold on with ack tho because I'd
like ack prepending patches first.

BR, Jarkko
