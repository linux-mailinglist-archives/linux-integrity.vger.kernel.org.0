Return-Path: <linux-integrity+bounces-3765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9D997116
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628422863F7
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D11E0B9A;
	Wed,  9 Oct 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2RaawLL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CF1E0B95
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489998; cv=none; b=douycPwAI+DzwJ7StOPAJOJVDceIYI4WkpuvKY9nbPSaoZmb5ec6bWsaydG1SoGzcbYUBsfjqckNXQzIrrhfR4hYrGULxnMj8FSUE351bOD3Y9TomXvoAasUruUbuVsdb+hLlIk0L7XP7sjQpSkodNu7KuDGcvrENUz79iGsVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489998; c=relaxed/simple;
	bh=+b/9GSY1ojDsrBjDNUWoUOQQPhX5wOnNtpRFpSHk9vc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mg3s3ER96+nuEe6Bp78h+ZaR7O1L8v8230LCm+j+FAEgo6JbXzHsV92dhAm5JRrVpxQy92cNw5nxIWhdhke5fhaSC5GGL3rEmljrzVzhU93/PIOi7HUrl384mFtpHby6Nptm6ARtlMyOnzwugwbaLX5aiSvs9Y4YdnosHaHWpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2RaawLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0BC4CEC3;
	Wed,  9 Oct 2024 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489997;
	bh=+b/9GSY1ojDsrBjDNUWoUOQQPhX5wOnNtpRFpSHk9vc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n2RaawLLutGtw8K/jm65yyPHP8ZM540xxCxc9kJbbljXCFycSI1/nTmwhCqH+NoMM
	 0brIWgd3vAasaPzlRRZgOkIrvKsw6m30C510y5PKy89utHy2HKMfpQimYKq72ex1Lm
	 tpWXRR4z5yEP/5fzbj0yXEX1x1av0iTPXJR3LRYzIoyyeFCU/JLboPoJoxTtCg0u9c
	 k8++iZ2rRyPVhm3OvedJEiyNtDo0fcNZ4Nz47qOudICrfKvSB8lFy8kIA4gQH3Z8OQ
	 DhjMH1Tm81LgdEvxO2T2Rsp+IZ0Ov46Ch3DdGpFSZUTZP7munDGFgzpQpNlZ30Aa/6
	 1Ozaf/MHKCVxA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 19:06:33 +0300
Message-Id: <D4REKCPW4RKY.ELMLOB6EC6AL@kernel.org>
Cc: <apronin@google.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, <mw@semihalf.com>,
 <peterhuewe@gmx.de>, <rrangel@chromium.org>, <timvp@google.com>
Subject: Re: [PATCH V2 1/2] char: tpm: cr50: Use generic request/relinquish
 locality ops
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Grzegorz Bernacki" <bernacki@chromium.org>, <jsd@semihalf.com>
X-Mailer: aerc 0.18.2
References: <20221101020352.939691-1-jsd@semihalf.com>
 <20241009094207.2897048-1-bernacki@google.com>
 <20241009094207.2897048-2-bernacki@google.com>
In-Reply-To: <20241009094207.2897048-2-bernacki@google.com>

On Wed Oct 9, 2024 at 12:42 PM EEST, Grzegorz Bernacki wrote:
> From: Jan Dabros <jsd@semihalf.com>
>
> Instead of using static functions tpm_cr50_request_locality and
> tpm_cr50_release_locality register callbacks from tpm class chip->ops
> created for this purpose.
>
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> Signed-off-by: Grzegorz Bernacki <bernacki@chromium.org>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 112 ++++++++++++++++++----------
>  1 file changed, 73 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..1b1e403383fc 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -17,6 +17,7 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/bug.h>
>  #include <linux/completion.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -35,6 +36,7 @@
>  #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on =
I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on =
I2C */
> +#define TPM_CR50_I2C_DEFAULT_LOC	0
> =20
>  #define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
>  #define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
> @@ -285,25 +287,26 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip=
, u8 addr, u8 *buffer,
>  }
> =20
>  /**
> - * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
> + * tpm_cr50_check_locality() - Verify if required TPM locality is active=
.
>   * @chip: A TPM chip.
> + * @loc: Locality to be verified
>   *
>   * Return:
> - * - 0:		Success.
> + * - loc:	Success.
>   * - -errno:	A POSIX error code.
>   */
> -static int tpm_cr50_check_locality(struct tpm_chip *chip)
> +static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
>  {
>  	u8 mask =3D TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
>  	u8 buf;
>  	int rc;
> =20
> -	rc =3D tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	rc =3D tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
>  	if (rc < 0)
>  		return rc;
> =20
>  	if ((buf & mask) =3D=3D mask)
> -		return 0;
> +		return loc;
> =20
>  	return -EIO;
>  }
> @@ -311,48 +314,57 @@ static int tpm_cr50_check_locality(struct tpm_chip =
*chip)
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
>  	u8 mask =3D TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
> -	u8 addr =3D TPM_I2C_ACCESS(0);
> +	u8 addr =3D TPM_I2C_ACCESS(loc);
>  	u8 buf;
> +	int rc;
> =20
> -	if (tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
> -		return;
> +	rc =3D tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
> +	if (rc < 0)
> +		return rc;
> =20
> -	if (force || (buf & mask) =3D=3D mask) {
> +	if ((buf & mask) =3D=3D mask) {
>  		buf =3D TPM_ACCESS_ACTIVE_LOCALITY;
> -		tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
> +		rc =3D tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
>  	}
> +
> +	return rc;
>  }
> =20
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
>  	u8 buf =3D TPM_ACCESS_REQUEST_USE;
>  	unsigned long stop;
>  	int rc;
> =20
> -	if (!tpm_cr50_check_locality(chip))
> -		return 0;
> +	if (tpm_cr50_check_locality(chip, loc) =3D=3D loc)
> +		return loc;
> =20
> -	rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf))=
;
>  	if (rc < 0)
>  		return rc;
> =20
>  	stop =3D jiffies + chip->timeout_a;
>  	do {
> -		if (!tpm_cr50_check_locality(chip))
> -			return 0;
> +		if (tpm_cr50_check_locality(chip, loc) =3D=3D loc)
> +			return loc;
> =20
>  		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  	} while (time_before(jiffies, stop));
> @@ -373,7 +385,12 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *c=
hip)
>  {
>  	u8 buf[4];
> =20
> -	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
> +	if (chip->locality < 0) {
> +		dev_err(&chip->dev, "Incorrect tpm locality value\n");
> +		return 0;
> +	}
> +
> +	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(bu=
f)) < 0)
>  		return 0;
> =20
>  	return buf[0];
> @@ -389,7 +406,12 @@ static void tpm_cr50_i2c_tis_set_ready(struct tpm_ch=
ip *chip)
>  {
>  	u8 buf[4] =3D { TPM_STS_COMMAND_READY };
> =20
> -	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
> +	if (chip->locality < 0) {
> +		dev_err(&chip->dev, "Incorrect tpm locality value\n");
> +		return;
> +	}
> +
> +	tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf))=
;
>  	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  }
> =20
> @@ -419,7 +441,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct t=
pm_chip *chip, u8 mask,
>  	stop =3D jiffies + chip->timeout_b;
> =20
>  	do {
> -		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
> +		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(b=
uf)) < 0) {
>  			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  			continue;
>  		}
> @@ -453,10 +475,15 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *c=
hip, u8 *buf, size_t buf_len)
> =20
>  	u8 mask =3D TPM_STS_VALID | TPM_STS_DATA_AVAIL;
>  	size_t burstcnt, cur, len, expected;
> -	u8 addr =3D TPM_I2C_DATA_FIFO(0);
> +	u8 addr =3D TPM_I2C_DATA_FIFO(chip->locality);
>  	u32 status;
>  	int rc;
> =20
> +	if (chip->locality < 0) {
> +		dev_err(&chip->dev, "Incorrect tpm locality value\n");
> +		return -EACCES;
> +	}
> +
>  	if (buf_len < TPM_HEADER_SIZE)
>  		return -EINVAL;
> =20
> @@ -515,7 +542,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chi=
p, u8 *buf, size_t buf_len)
>  		goto out_err;
>  	}
> =20
> -	tpm_cr50_release_locality(chip, false);
>  	return cur;
> =20
>  out_err:
> @@ -523,7 +549,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chi=
p, u8 *buf, size_t buf_len)
>  	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
>  		tpm_cr50_i2c_tis_set_ready(chip);
> =20
> -	tpm_cr50_release_locality(chip, false);
>  	return rc;
>  }
> =20
> @@ -545,9 +570,10 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *ch=
ip, u8 *buf, size_t len)
>  	u32 status;
>  	int rc;
> =20
> -	rc =3D tpm_cr50_request_locality(chip);
> -	if (rc < 0)
> -		return rc;
> +	if (chip->locality < 0) {
> +		dev_err(&chip->dev, "Incorrect tpm locality value\n");
> +		return -EACCES;
> +	}
> =20
>  	/* Wait until TPM is ready for a command */
>  	stop =3D jiffies + chip->timeout_b;
> @@ -577,7 +603,8 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chi=
p, u8 *buf, size_t len)
>  		 * that is inserted by tpm_cr50_i2c_write()
>  		 */
>  		limit =3D min_t(size_t, burstcnt - 1, len);
> -		rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limi=
t);
> +		rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(chip->locality),
> +					&buf[sent], limit);
>  		if (rc < 0) {
>  			dev_err(&chip->dev, "Write failed\n");
>  			goto out_err;
> @@ -598,7 +625,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chi=
p, u8 *buf, size_t len)
>  	}
> =20
>  	/* Start the TPM command */
> -	rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
> +	rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), tpm_go,
>  				sizeof(tpm_go));
>  	if (rc < 0) {
>  		dev_err(&chip->dev, "Start command failed\n");
> @@ -611,7 +638,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chi=
p, u8 *buf, size_t len)
>  	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
>  		tpm_cr50_i2c_tis_set_ready(chip);
> =20
> -	tpm_cr50_release_locality(chip, false);
>  	return rc;
>  }
> =20
> @@ -650,6 +676,8 @@ static const struct tpm_class_ops cr50_i2c =3D {
>  	.req_complete_mask =3D TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_complete_val =3D TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_canceled =3D &tpm_cr50_i2c_req_canceled,
> +	.request_locality =3D &tpm_cr50_request_locality,
> +	.relinquish_locality =3D &tpm_cr50_release_locality,
>  };
> =20
>  #ifdef CONFIG_ACPI
> @@ -684,6 +712,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *clie=
nt)
>  	u32 vendor;
>  	u8 buf[4];
>  	int rc;
> +	int loc;
> =20
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
> @@ -726,24 +755,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
ient)
>  			 TPM_CR50_TIMEOUT_NOIRQ_MS);
>  	}
> =20
> -	rc =3D tpm_cr50_request_locality(chip);
> -	if (rc < 0) {
> +	loc =3D tpm_cr50_request_locality(chip, TPM_CR50_I2C_DEFAULT_LOC);
> +	if (loc < 0) {
>  		dev_err(dev, "Could not request locality\n");
> -		return rc;
> +		return loc;
>  	}
> =20
>  	/* Read four bytes from DID_VID register */
> -	rc =3D tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(0), buf, sizeof(buf));
> +	rc =3D tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(loc), buf, sizeof(buf));
>  	if (rc < 0) {
>  		dev_err(dev, "Could not read vendor id\n");
> -		tpm_cr50_release_locality(chip, true);
> +		if (tpm_cr50_release_locality(chip, loc))
> +			dev_err(dev, "Could not release locality\n");
> +		return rc;
> +	}
> +
> +	rc =3D tpm_cr50_release_locality(chip, loc);
> +	if (rc) {
> +		dev_err(dev, "Could not release locality\n");
>  		return rc;
>  	}
> =20
>  	vendor =3D le32_to_cpup((__le32 *)buf);
>  	if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2C_DID_VI=
D) {
>  		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> -		tpm_cr50_release_locality(chip, true);
>  		return -ENODEV;
>  	}
> =20
> @@ -772,7 +807,6 @@ static void tpm_cr50_i2c_remove(struct i2c_client *cl=
ient)
>  	}
> =20
>  	tpm_chip_unregister(chip);
> -	tpm_cr50_release_locality(chip, true);
>  }
> =20
>  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);

I'd suggest to simply remove locality checks, which are sprinkled all
over the patch (with two different return values).

BR, Jarkko

