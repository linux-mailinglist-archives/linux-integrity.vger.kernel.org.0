Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6E61EEA3
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 10:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKGJUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 04:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKGJUM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 04:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709F6567
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 01:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCE39B80E83
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 09:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E5AC433C1;
        Mon,  7 Nov 2022 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812808;
        bh=m/aWY3KBj5LxYWOiHFiTBawLqkANPvLdY8LW6pttRIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gH0/JlpLCluK+78ZFe7vphmKmBVIXo/5KLwQ0FAU/LaACeFNJntzB+2mprVZp6q1A
         QFUF/j/88dvti7MAEW/vf/vGOozW0uNQl1xqMQJ6B0c+TQxNUlfoCbko7lkOw7++Z1
         EepX+vN2Njl0f+8E6qHWG/FKQglm3571xPJxOukR+0UF4kqqOqpe4FR7/S2zdsivQH
         5lNLdx94bHx4gwzOrxFxpuPDu1YKi6aQTzw/vxhuCnEu2VhY7al1qWkT12HDOk2M29
         q0WhpwMScziOu4UG/ePwE3bUInrkinzqk0z3Ha/Xz2sbAfItC2TQCQIojRwWlVisss
         jW+rrg/rqu09w==
Date:   Mon, 7 Nov 2022 11:20:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH v2 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
Message-ID: <Y2jNw5JymJ+upOaQ@kernel.org>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-3-jsd@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103145450.1409273-3-jsd@semihalf.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 03:54:49PM +0100, Jan Dabros wrote:
> Instead of using static functions tpm_cr50_request_locality and
> tpm_cr50_release_locality register callbacks from tpm class chip->ops
> created for this purpose.
> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>

I get that architecturally using the standard callbacks is a good idea.
Still, you should explicitly document the gain because the existing code
is working and field tested.

> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 106 ++++++++++++++++++----------
>  1 file changed, 70 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index 77cea5b31c6e4..517d8410d7da0 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/bug.h>
>  #include <linux/completion.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -35,6 +36,7 @@
>  #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
> +#define TPM_CR50_I2C_DEFAULT_LOC	0
>  
>  #define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
>  #define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
> @@ -286,20 +288,21 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
>  }
>  
>  /**
> - * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
> + * tpm_cr50_check_locality() - Verify if required TPM locality is active.
>   * @chip: A TPM chip.
> + * @loc: Locality to be verified
>   *
>   * Return:
>   * - 0:		Success.
>   * - -errno:	A POSIX error code.
>   */
> -static int tpm_cr50_check_locality(struct tpm_chip *chip)
> +static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
>  {
>  	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
>  	u8 buf;
>  	int rc;
>  
> -	rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
>  	if (rc < 0)
>  		return rc;
>  
> @@ -312,48 +315,57 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip)
>  /**
>   * tpm_cr50_release_locality() - Release TPM locality.
>   * @chip:	A TPM chip.
> - * @force:	Flag to force release if set.
> + * @loc:	Locality to be released
> + *
> + * Return:
> + * - 0:		Success.
> + * - -errno:	A POSIX error code.
>   */
> -static void tpm_cr50_release_locality(struct tpm_chip *chip, bool force)
> +static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
>  {
>  	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
> -	u8 addr = TPM_I2C_ACCESS(0);
> +	u8 addr = TPM_I2C_ACCESS(loc);
>  	u8 buf;
> +	int rc;
>  
> -	if (tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
> -		return;
> +	rc = tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
> +	if (rc < 0)
> +		return rc;
>  
> -	if (force || (buf & mask) == mask) {
> +	if ((buf & mask) == mask) {
>  		buf = TPM_ACCESS_ACTIVE_LOCALITY;
> -		tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
> +		rc = tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
>  	}
> +
> +	return rc;
>  }
>  
>  /**
> - * tpm_cr50_request_locality() - Request TPM locality 0.
> + * tpm_cr50_request_locality() - Request TPM locality.
>   * @chip: A TPM chip.
> + * @loc: Locality to be requested.
>   *
>   * Return:
> - * - 0:		Success.
> + * - loc:	Success.
>   * - -errno:	A POSIX error code.
>   */
> -static int tpm_cr50_request_locality(struct tpm_chip *chip)
> +static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
>  {
>  	u8 buf = TPM_ACCESS_REQUEST_USE;
>  	unsigned long stop;
>  	int rc;
>  
> -	if (!tpm_cr50_check_locality(chip))
> -		return 0;
> +	if (!tpm_cr50_check_locality(chip, loc))
> +		return loc;
>  
> -	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
>  	if (rc < 0)
>  		return rc;
>  
>  	stop = jiffies + chip->timeout_a;
>  	do {
> -		if (!tpm_cr50_check_locality(chip))
> -			return 0;
> +		if (!tpm_cr50_check_locality(chip, loc))
> +			return loc;
>  
>  		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  	} while (time_before(jiffies, stop));
> @@ -374,7 +386,12 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
>  {
>  	u8 buf[4];
>  
> -	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
> +	if (chip->locality < 0){
> +		WARN_ONCE(1, "Incorrect tpm locality value\n");

Never ever add WARN() for a success case. It can ultimately crash the whole
system, if panic_on_warn is enabled.

Since this is a success case, judging from the return value, at most you
should use pr_info() here.

> +		return 0;
> +	}
> +
> +	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0)
>  		return 0;
>  
>  	return buf[0];
> @@ -390,7 +407,12 @@ static void tpm_cr50_i2c_tis_set_ready(struct tpm_chip *chip)
>  {
>  	u8 buf[4] = { TPM_STS_COMMAND_READY };
>  
> -	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
> +	if (chip->locality < 0) {
> +		WARN_ONCE(1, "Incorrect tpm locality value\n");
> +		return;
> +	}
> +
> +	tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf));
>  	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  }
>  
> @@ -420,7 +442,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
>  	stop = jiffies + chip->timeout_b;
>  
>  	do {
> -		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
> +		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0) {
>  			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  			continue;
>  		}
> @@ -454,10 +476,15 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>  
>  	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
>  	size_t burstcnt, cur, len, expected;
> -	u8 addr = TPM_I2C_DATA_FIFO(0);
> +	u8 addr = TPM_I2C_DATA_FIFO(chip->locality);
>  	u32 status;
>  	int rc;
>  
> +	if (chip->locality < 0) {
> +		WARN_ONCE(1, "Incorrect tpm locality value\n");
> +		return -EINVAL;
> +	}
> +
>  	if (buf_len < TPM_HEADER_SIZE)
>  		return -EINVAL;
>  
> @@ -516,7 +543,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>  		goto out_err;
>  	}
>  
> -	tpm_cr50_release_locality(chip, false);
>  	return cur;
>  
>  out_err:
> @@ -524,7 +550,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>  	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
>  		tpm_cr50_i2c_tis_set_ready(chip);
>  
> -	tpm_cr50_release_locality(chip, false);
>  	return rc;
>  }
>  
> @@ -546,9 +571,10 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	u32 status;
>  	int rc;
>  
> -	rc = tpm_cr50_request_locality(chip);
> -	if (rc < 0)
> -		return rc;
> +	if (chip->locality < 0) {
> +		WARN_ONCE(1, "Incorrect tpm locality value\n");
> +		return -EINVAL;
> +	}
>  
>  	/* Wait until TPM is ready for a command */
>  	stop = jiffies + chip->timeout_b;
> @@ -578,7 +604,8 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		 * that is inserted by tpm_cr50_i2c_write()
>  		 */
>  		limit = min_t(size_t, burstcnt - 1, len);
> -		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limit);
> +		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(chip->locality),
> +					&buf[sent], limit);
>  		if (rc < 0) {
>  			dev_err(&chip->dev, "Write failed\n");
>  			goto out_err;
> @@ -599,7 +626,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	}
>  
>  	/* Start the TPM command */
> -	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
> +	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), tpm_go,
>  				sizeof(tpm_go));
>  	if (rc < 0) {
>  		dev_err(&chip->dev, "Start command failed\n");
> @@ -612,7 +639,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
>  		tpm_cr50_i2c_tis_set_ready(chip);
>  
> -	tpm_cr50_release_locality(chip, false);
>  	return rc;
>  }
>  
> @@ -651,6 +677,8 @@ static const struct tpm_class_ops cr50_i2c = {
>  	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_canceled = &tpm_cr50_i2c_req_canceled,
> +	.request_locality = &tpm_cr50_request_locality,
> +	.relinquish_locality = &tpm_cr50_release_locality,
>  };
>  
>  #ifdef CONFIG_ACPI
> @@ -686,6 +714,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  	u32 vendor;
>  	u8 buf[4];
>  	int rc;
> +	int loc;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
> @@ -728,24 +757,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  			 TPM_CR50_TIMEOUT_NOIRQ_MS);
>  	}
>  
> -	rc = tpm_cr50_request_locality(chip);
> -	if (rc < 0) {
> +	loc = tpm_cr50_request_locality(chip, TPM_CR50_I2C_DEFAULT_LOC);
> +	if (loc < 0) {
>  		dev_err(dev, "Could not request locality\n");
>  		return rc;
>  	}
>  
>  	/* Read four bytes from DID_VID register */
> -	rc = tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(0), buf, sizeof(buf));
> +	rc = tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(loc), buf, sizeof(buf));
>  	if (rc < 0) {
>  		dev_err(dev, "Could not read vendor id\n");
> -		tpm_cr50_release_locality(chip, true);
> +		if (tpm_cr50_release_locality(chip, loc))
> +			dev_err(dev, "Could not release locality\n");
> +		return rc;
> +	}
> +
> +	rc = tpm_cr50_release_locality(chip, loc);
> +	if (rc) {
> +		dev_err(dev, "Could not release locality\n");
>  		return rc;
>  	}
>  
>  	vendor = le32_to_cpup((__le32 *)buf);
>  	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
>  		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> -		tpm_cr50_release_locality(chip, true);
>  		return -ENODEV;
>  	}
>  
> @@ -774,7 +809,6 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
>  	}
>  
>  	tpm_chip_unregister(chip);
> -	tpm_cr50_release_locality(chip, true);
>  }
>  
>  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 

BR, Jarkko
