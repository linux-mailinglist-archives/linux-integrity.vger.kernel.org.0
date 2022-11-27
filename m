Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72107639B93
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiK0PrP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 10:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK0PrO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 10:47:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2DDEC0;
        Sun, 27 Nov 2022 07:47:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3567CB80B0E;
        Sun, 27 Nov 2022 15:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DD3C433D6;
        Sun, 27 Nov 2022 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669564030;
        bh=LD1YKON3zFK4mG5HlyRH/MyGGwYEkQUzCSS1PsDLugw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqnEQgq6+MI5qH/iq/zewhEN+UWTUcGLro+2ThPBjtRpkQMIXviACZZ1gTKVtLK5C
         WlrrLK9Yj3eafY0ftTQzsMc7eVzWzRM5KuR/zQ5CkFX7rk22tM450EA+wrozJyO0od
         YTEppawNlJYmiS8ylhZIKEWgWnLN+av+Ys7KYoxKuJuQ+T9Ij8znyeGmTxYef8ASr7
         zd2ILbx4yN6sXBtwNusS8nTwx6mIwike1UCN2Wn7QUsQcCMvt1UDKTmYHvD7dHm5KN
         uHa4dFW2l6px77EGhz+6v+u0CX4mbvoh59EymVSur3Kfc95GkUrpxu8RIM7smcu3Ji
         +vLoJ/Lswol0Q==
Date:   Sun, 27 Nov 2022 17:47:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, joel@jms.id.au
Subject: Re: [PATCH v2] tpm: Add flag to use default cancellation policy
Message-ID: <Y4OGetuMVlweFRir@kernel.org>
References: <20221107171423.51019-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107171423.51019-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 07, 2022 at 11:14:23AM -0600, Eddie James wrote:
> The check for cancelled request depends on the VID of the chip, but
> some chips share VID which shouldn't share their cancellation
> behavior. This is the case for the Nuvoton NPCT75X, which should use
> the default cancellation check, not the Winbond one.
> To avoid changing the existing behavior, add a new flag to indicate
> that the chip should use the default cancellation check and set it
> for the I2C TPM2 TIS driver.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Update switch statement with default: break;
> 
>  drivers/char/tpm/tpm_tis_core.c | 20 ++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  drivers/char/tpm/tpm_tis_i2c.c  |  1 +
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 757623bacfd5..3f98e587b3e8 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -682,15 +682,19 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	switch (priv->manufacturer_id) {
> -	case TPM_VID_WINBOND:
> -		return ((status == TPM_STS_VALID) ||
> -			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> -	case TPM_VID_STM:
> -		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> -	default:
> -		return (status == TPM_STS_COMMAND_READY);
> +	if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
> +		switch (priv->manufacturer_id) {
> +		case TPM_VID_WINBOND:
> +			return ((status == TPM_STS_VALID) ||
> +				(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> +		case TPM_VID_STM:
> +			return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> +		default:
> +			break;
> +		}
>  	}
> +
> +	return status == TPM_STS_COMMAND_READY;
>  }
>  
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 66a5a13cd1df..b68479e0de10 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -86,6 +86,7 @@ enum tis_defaults {
>  enum tpm_tis_flags {
>  	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
>  	TPM_TIS_INVALID_STATUS		= BIT(1),
> +	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
>  };
>  
>  struct tpm_tis_data {
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 45f388127f4b..91451ee1ef8d 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
>  	if (!phy->io_buf)
>  		return -ENOMEM;
>  
> +	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
>  	phy->i2c_client = dev;
>  
>  	/* must precede all communication with the tpm */
> -- 
> 2.31.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
