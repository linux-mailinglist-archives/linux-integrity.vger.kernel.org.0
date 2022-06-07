Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147253FA9C
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiFGJ6I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbiFGJ6D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 05:58:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67C5D66C;
        Tue,  7 Jun 2022 02:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 508EEB81E76;
        Tue,  7 Jun 2022 09:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077FC34119;
        Tue,  7 Jun 2022 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654595879;
        bh=8DV3QorSxkeJRTn5hPB/RoqUQHP9TqR0CTiN1ZWTd7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHF4JmLsS4wcyUwv3x/x5naQH4qzhoLntzhoE4++JsHKkk5oRm1ubNBYHFmUUK4OH
         iR+S4ZdVd5h1GZj3pDsVb8H3blhhjgI9jxWigqHchP9TvxLtZd1L5LUXq+1McQ1Kjc
         /TypvtfiL61k+ym5ggOG9nzgpbAYj7dcyUhEIGHwOD5Y3xQIXYszMHYVZYCgwFCYJI
         D0ylC6ifHylo4JMxwk+FBj/ub/F01XYkl3rr6hx4ouvK7ZRAW6UDz3Z11uGKXW4HVg
         Zmyfw7qQ1l4DjD5JBk+WFkQCkT6Q+TniyZvbCoxyFB3g/JVkxTTC3RbHYkbwyh19JD
         2ItrIHMhfSv4A==
Date:   Tue, 7 Jun 2022 12:56:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v5 2/3] tpm: Add tpm_tis_verify_crc to the
 tpm_tis_phy_ops protocol layer
Message-ID: <Yp8gsy2vv4Y0luYQ@iki.fi>
References: <20220603143532.8202-1-Alexander.Steffen@infineon.com>
 <20220603143532.8202-3-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603143532.8202-3-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 03, 2022 at 04:35:31PM +0200, Alexander Steffen wrote:
> Some TPMs, e.g. those implementing the I2C variant of TIS, can verify
> data transfers to/from the FIFO with a CRC. The CRC is calculated over
> the entirety of the FIFO register. Since the phy_ops layer is not aware
> when the core layer is done reading/writing the FIFO, CRC verification
> must be triggered from the core layer. To this end, add an optional
> phy_ops API call.
> 
> Co-developed-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Change-Id: I43716c8d45f62c0fcdaabfc3366f8deb89fd1f32

Strip off Change-Id.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
>  drivers/char/tpm/tpm_tis_core.h | 10 ++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dc56b976d816..757623bacfd5 100644
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
> +		dev_err(&chip->dev, "CRC mismatch for response.\n");
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
> +		dev_err(&chip->dev, "CRC mismatch for command.\n");
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

I think it would be more readable to have one empty line here.

> +	return data->phy_ops->verify_crc(data, len, value);
> +}
> +
>  static inline bool is_bsw(void)
>  {
>  #ifdef CONFIG_X86
> -- 
> 2.25.1
> 

Other than that LGTM.

BR, Jarkko
