Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4365B13FA
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIHFW1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Sep 2022 01:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIHFW0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Sep 2022 01:22:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA79C12D6;
        Wed,  7 Sep 2022 22:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ECCBB81F05;
        Thu,  8 Sep 2022 05:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3A1C433D6;
        Thu,  8 Sep 2022 05:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662614542;
        bh=5CZuXMLS2Xmn2LfsJi5dE6MOIatXtR4FI/XtacZfwjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcWYyYccadx5YzqBVd+0XQPm4pknP+rWGG6ChWWi5E5x8i2eiJhExf8U9gpfHNV1u
         VHJ76ykMFengA/rYA3s+cCln3TTvAyCdrMsaGMQUK7HwsSyllkHvAnNE2zoKR10Nwu
         gigJT/q2NzmpkBIc80/yd4B7zd78tssK92mUZQZ4EV6Qdqup1LJbl9aKzhUy/ii/nf
         +zoU4IAtpBlyDGhM8T7mx5ZokVtNcwimq56EOmkiGY+a9aYsSNOuzZaodyavE+fVyb
         aZqVa+IGxx+JzG5+UHKa+4uQGlLlOJgJnEf1LGHqDA7WdU544W2QUizEGQ5qV+k2/h
         oOzaT2xT4ph7A==
Date:   Thu, 8 Sep 2022 08:22:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.or, jgg@ziepe.ca, joel@jms.id.au,
        Alexander.Steffen@infineon.com
Subject: Re: [PATCH] tpm: Add flag to use default cancellation policy
Message-ID: <Yxl8CJBZiROgqhd6@kernel.org>
References: <20220907164317.80617-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907164317.80617-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 07, 2022 at 11:43:17AM -0500, Eddie James wrote:
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
>  drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  drivers/char/tpm/tpm_tis_i2c.c  |  1 +
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 757623bacfd5..175e75337395 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -682,15 +682,17 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
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
> +		}

Why there is no default: ?

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
> index 0692510dfcab..6722588e0217 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
>  	if (!phy->io_buf)
>  		return -ENOMEM;
>  
> +	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);

What if you just zeroed manufacturer ID?

>  	phy->i2c_client = dev;
>  
>  	/* must precede all communication with the tpm */
> -- 
> 2.31.1
> 

BR, Jarkko
