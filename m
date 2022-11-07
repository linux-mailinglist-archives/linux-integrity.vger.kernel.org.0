Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6361EEB9
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiKGJWy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 04:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiKGJWq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 04:22:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705F167F2
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 01:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4D4EB80E9A
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 09:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F98BC433B5;
        Mon,  7 Nov 2022 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812962;
        bh=d9mVdSb4Mpd/JBrlSe0Ugl4RgC6BXZYt+a93CN9QQUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJ1uIb1uUcn4SKphZ2q4uGM1/rXZXunLD9D5QZavBAQMbj9lXXPUJrG30tFRZ6p2Q
         BRsBQBPQVaDsGNRcWwHIeDXvMmH76cz+syIWS2y0CsF/jfyPStYknFkA+bFLD+sYtI
         ovfKj7TybkArunlPTfhAfUIaYhVvUhLvwZsBsbKx/+sCHt3RmWEXxhs5CZez7AIgLy
         vkAQDkuIxOgtNpSFqANZyg7MvuEU93ezawV+aiC/8h0YZGA7KihBlp/jg9fqhTzSeJ
         lo4nxUkY9xeCNUqJnKRKtRQEYdvOKXtKmj7E0U2Fp3UlnFRdEsUG+kPQ2VfT7Vwas/
         sLH48eRsKpCwg==
Date:   Mon, 7 Nov 2022 11:22:37 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH v2 3/3] char: tpm: cr50: Move i2c locking to
 request/relinquish locality ops
Message-ID: <Y2jOXcsXCGyYtCR9@kernel.org>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-4-jsd@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103145450.1409273-4-jsd@semihalf.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 03:54:50PM +0100, Jan Dabros wrote:
> Move i2c locking primitives to request_locality and relinquish_locality
> callbacks, what effectively blocks TPM bus for the whole duration of
> logical TPM operation.
> 
> With this in place, cr50-equipped TPM may be shared with external CPUs -
> assuming that underneath i2c controller driver is aware of this setup
> (see i2c-designware-amdpsp as an example).

Nit: s/CPUs/peripherals/ ? I'm not sure why you want to emphasize external
chips having CPU.

> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index 517d8410d7da0..f8a67fc2382cc 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -202,8 +202,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
>  	};
>  	int rc;
>  
> -	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> -
>  	/* Prepare for completion interrupt */
>  	tpm_cr50_i2c_enable_tpm_irq(chip);
>  
> @@ -222,7 +220,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
>  
>  out:
>  	tpm_cr50_i2c_disable_tpm_irq(chip);
> -	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
>  
>  	if (rc < 0)
>  		return rc;
> @@ -264,8 +261,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
>  	priv->buf[0] = addr;
>  	memcpy(priv->buf + 1, buffer, len);
>  
> -	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> -
>  	/* Prepare for completion interrupt */
>  	tpm_cr50_i2c_enable_tpm_irq(chip);
>  
> @@ -279,7 +274,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
>  
>  out:
>  	tpm_cr50_i2c_disable_tpm_irq(chip);
> -	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
>  
>  	if (rc < 0)
>  		return rc;
> @@ -323,6 +317,7 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
>   */
>  static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
>  {
> +	struct i2c_client *client = to_i2c_client(chip->dev.parent);
>  	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
>  	u8 addr = TPM_I2C_ACCESS(loc);
>  	u8 buf;
> @@ -330,13 +325,15 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
>  
>  	rc = tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
>  	if (rc < 0)
> -		return rc;
> +		goto unlock_out;
>  
>  	if ((buf & mask) == mask) {
>  		buf = TPM_ACCESS_ACTIVE_LOCALITY;
>  		rc = tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
>  	}
>  
> +unlock_out:
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
>  	return rc;
>  }
>  
> @@ -351,16 +348,19 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
>   */
>  static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
>  {
> +	struct i2c_client *client = to_i2c_client(chip->dev.parent);
>  	u8 buf = TPM_ACCESS_REQUEST_USE;
>  	unsigned long stop;
>  	int rc;
>  
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
>  	if (!tpm_cr50_check_locality(chip, loc))
>  		return loc;
>  
>  	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
>  	if (rc < 0)
> -		return rc;
> +		goto unlock_out;
>  
>  	stop = jiffies + chip->timeout_a;
>  	do {
> @@ -370,7 +370,11 @@ static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
>  		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  	} while (time_before(jiffies, stop));
>  
> -	return -ETIMEDOUT;
> +	rc = -ETIMEDOUT;
> +
> +unlock_out:
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	return rc;
>  }
>  
>  /**
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 

BR, Jarkko
