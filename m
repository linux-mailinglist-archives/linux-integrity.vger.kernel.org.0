Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45CB1E9BAD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 04:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFACXN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 May 2020 22:23:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:23151 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFACXM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 May 2020 22:23:12 -0400
IronPort-SDR: wi5LGNmf34ObJfPOGYU9gQ/v0L+Lz7yrsLzGuKJ98rwhPcF/aK/rV31LzrNwF+j0tbO1KY/mTl
 9zuHUXUJqniQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 19:23:12 -0700
IronPort-SDR: jogtF6iv/8NEwGKYG3+f05QlTBYhhBSaft+mnrY0kd7bx1YGqNImp2DR755dWtdve6cnxsXWo8
 yk/ZWw8Z898w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="286129401"
Received: from dytagah-mobl.amr.corp.intel.com (HELO localhost) ([10.252.58.236])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2020 19:23:03 -0700
Date:   Mon, 1 Jun 2020 05:23:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v9 1/8] tpm: tpm_tis: Make implementation of read16,
 read32 and write32 optional
Message-ID: <20200601022301.GA796332@linux.intel.com>
References: <20200526141658.157801-1-amirmizi6@gmail.com>
 <20200526141658.157801-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526141658.157801-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Plese, write the short summary as

tpm: Make read{16, 32}() and write32() in tpm_tis_phy_ops optional

On Tue, May 26, 2020 at 05:16:51PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Only tpm_tis can use memory-mapped I/O, which is truly mapped into
> the kernel's memory space. Therefore, using ioread16/ioread32/iowrite32
> turns into a straightforward pointer dereference.
> Every other driver requires more complicated operations to read more than
> one byte at a time and will just fall back to read_bytes/write_bytes.
> Therefore, move this common code out of tpm_tis_spi and into tpm_tis_core
> so that it is used automatically when low-level drivers do not implement
> the specialized methods.
> 
> Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.h     | 38 +++++++++++++++++++++++++++++++---
>  drivers/char/tpm/tpm_tis_spi.h      |  4 ----
>  drivers/char/tpm/tpm_tis_spi_cr50.c |  3 ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 41 -------------------------------------
>  4 files changed, 35 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 7337819..d06c65b 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -122,13 +122,35 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
>  static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
>  				 u16 *result)
>  {
> -	return data->phy_ops->read16(data, addr, result);
> +	__le16 result_le;
> +	int rc;
> +
> +	if (data->phy_ops->read16)
> +		return data->phy_ops->read16(data, addr, result);
> +
> +	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
> +				       (u8 *)&result_le);
> +	if (!rc)
> +		*result = le16_to_cpu(result_le);
> +
> +	return rc;
>  }
>  
>  static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
>  				 u32 *result)
>  {
> -	return data->phy_ops->read32(data, addr, result);
> +	__le32 result_le;
> +	int rc;
> +
> +	if (data->phy_ops->read32)
> +		return data->phy_ops->read32(data, addr, result);
> +
> +	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
> +				       (u8 *)&result_le);
> +	if (!rc)
> +		*result = le32_to_cpu(result_le);
> +
> +	return rc;
>  }
>  
>  static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
> @@ -145,7 +167,17 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
>  static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
>  				  u32 value)
>  {
> -	return data->phy_ops->write32(data, addr, value);
> +	__le32 value_le;
> +	int rc;
> +
> +	if (data->phy_ops->write32)
> +		return data->phy_ops->write32(data, addr, value);
> +
> +	value_le = cpu_to_le32(value);
> +	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
> +					(u8 *)&value_le);
> +
> +	return rc;
>  }
>  
>  static inline bool is_bsw(void)
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> index bba7397..d0f66f6 100644
> --- a/drivers/char/tpm/tpm_tis_spi.h
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -31,10 +31,6 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>  extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  				u8 *in, const u8 *out);
>  
> -extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result);
> -extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result);
> -extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value);
> -
>  #ifdef CONFIG_TCG_TIS_SPI_CR50
>  extern int cr50_spi_probe(struct spi_device *spi);
>  #else
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> index 37d72e8..f339d20 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -215,9 +215,6 @@ static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 addr,
>  static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops = {
>  	.read_bytes = tpm_tis_spi_cr50_read_bytes,
>  	.write_bytes = tpm_tis_spi_cr50_write_bytes,
> -	.read16 = tpm_tis_spi_read16,
> -	.read32 = tpm_tis_spi_read32,
> -	.write32 = tpm_tis_spi_write32,
>  };
>  
>  static void cr50_print_fw_version(struct tpm_tis_data *data)
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index d1754fd..95fef9d 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -152,44 +152,6 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
>  	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
>  }
>  
> -int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
> -{
> -	__le16 result_le;
> -	int rc;
> -
> -	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
> -				       (u8 *)&result_le);
> -	if (!rc)
> -		*result = le16_to_cpu(result_le);
> -
> -	return rc;
> -}
> -
> -int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
> -{
> -	__le32 result_le;
> -	int rc;
> -
> -	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
> -				       (u8 *)&result_le);
> -	if (!rc)
> -		*result = le32_to_cpu(result_le);
> -
> -	return rc;
> -}
> -
> -int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
> -{
> -	__le32 value_le;
> -	int rc;
> -
> -	value_le = cpu_to_le32(value);
> -	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
> -					(u8 *)&value_le);
> -
> -	return rc;
> -}
> -
>  int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>  		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>  {
> @@ -205,9 +167,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
>  static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
>  	.read_bytes = tpm_tis_spi_read_bytes,
>  	.write_bytes = tpm_tis_spi_write_bytes,
> -	.read16 = tpm_tis_spi_read16,
> -	.read32 = tpm_tis_spi_read32,
> -	.write32 = tpm_tis_spi_write32,
>  };
>  
>  static int tpm_tis_spi_probe(struct spi_device *dev)
> -- 
> 2.7.4

Other than that looks good.

/Jarkko
> 
