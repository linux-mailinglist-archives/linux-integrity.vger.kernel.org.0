Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8260F4686E1
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Dec 2021 19:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385372AbhLDSIn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Dec 2021 13:08:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53872 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbhLDSIn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Dec 2021 13:08:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B88860EE0;
        Sat,  4 Dec 2021 18:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B0C341C2;
        Sat,  4 Dec 2021 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638641116;
        bh=rqKt3RP6sLw5VxbfcR41tPoPLKaXuZFLqSV5fbVcR8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+ky7iFHe55Do0zCNPHjX0hSXYLnHIM4Knql5XdLqPtwc8wkSICYu8JJcsYZKwqb5
         k3kc0dLzBqIQBtyZ37hjh9CL56W7SAmEHl+5FaMGWegrMIgVvFhy2eNabWn/4PPXsX
         aZfo/vzmqT5lgulbBWZKSl8U6XZVR20M9TC4bBTTn3VkWeGH7z49vJYNkDPO+kgjDB
         mYFJMJDu7sSISw1Ovc3DVCTK4zuZP8Nry0nOESkxV0nflQoe9mFveofRfh/ETdSKWR
         7G3zVYezepCg81n/jtqin9tvIu+btL/xMgAyr1XA1fH3KR5ydDWMSKt3q2e2SYHXEx
         r6LDzLuoTCbug==
Date:   Sat, 4 Dec 2021 20:05:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rob Barnes <robbarnes@google.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based
 on device property
Message-ID: <Yaut12SfSYPGcs6S@iki.fi>
References: <202112011433.QeYkYJE1-lkp@intel.com>
 <20211202200342.2430249-1-robbarnes@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202200342.2430249-1-robbarnes@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 02, 2021 at 08:03:40PM +0000, Rob Barnes wrote:
> Set TPM_FIRMWARE_POWER_MANAGED flag based on 'firmware-power-managed'
> ACPI DSD property. For the CR50 TPM, this flag defaults to true when
> the property is unset.
> 
> When this flag is set to false, the CR50 TPM driver will always send
> a shutdown command whenever the system suspends.
> 
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 14 +++++++++++++-
>  drivers/char/tpm/tpm_tis_spi_cr50.c | 14 +++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index c89278103703..70143cc4f4e8 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -628,6 +628,17 @@ static bool tpm_cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
>  	return status == TPM_STS_COMMAND_READY;
>  }
>  
> +static bool tpm_cr50_i2c_is_firmware_power_managed(struct device *dev)
> +{
> +	u8 val;
> +	int ret;

empty line here.

> +	/* This flag should default true when the device property is not present */
> +	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
> +	if (ret)
> +		return 1;

"return true;" and empty line here.

> +	return val;
> +}
> +
>  static const struct tpm_class_ops cr50_i2c = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.status = &tpm_cr50_i2c_tis_status,
> @@ -686,7 +697,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  
>  	/* cr50 is a TPM 2.0 chip */
>  	chip->flags |= TPM_CHIP_FLAG_TPM2;
> -	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +	if (tpm_cr50_i2c_is_firmware_power_managed(dev))
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
>  
>  	/* Default timeouts */
>  	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> index dae98dbeeeac..6c40ff99d3ea 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -185,6 +185,17 @@ static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
>  	return 0;
>  }
>  
> +static bool tpm_cr50_spi_is_firmware_power_managed(struct device *dev)
> +{
> +	u8 val;
> +	int ret;

Ditto.

> +	/* This flag should default true when the device property is not present */
> +	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
> +	if (ret)
> +		return 1;

Ditto.

> +	return val;
> +}
> +
>  static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  				     u8 *in, const u8 *out)
>  {
> @@ -309,7 +320,8 @@ int cr50_spi_probe(struct spi_device *spi)
>  	cr50_print_fw_version(&phy->priv);
>  
>  	chip = dev_get_drvdata(&spi->dev);
> -	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +	if (tpm_cr50_spi_is_firmware_power_managed(&spi->dev))
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
>  
>  	return 0;
>  }
> -- 
> 2.34.0.384.gca35af8252-goog
> 

/Jarkko
