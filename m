Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C540B57B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhINQ7d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 12:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhINQ7c (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 12:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B40610E6;
        Tue, 14 Sep 2021 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631638695;
        bh=Zn3JMalaQqbdRp33++4pXq7te8PElXoiceo6RKrR+4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eYmv1cUPnPP9+FUvdjdlyoAy8PdD8a6LsbDOp17T+HguMrlE0sqQJDwGSAwV/UypZ
         qcFFhCypIP22A5RTp2bF4i7ctfprY/TDzKx4mXHjfao7MfTmukU9f/VC2KPNtYRsDB
         MxvhPT5l613syVJApgYhHB9yb8nHc/H/hgGR9jxsiMlvVzBqM5ZjekrNlwsy264Jwn
         hNW5VDAvDM0B71KndGtCM92lagkfYyik5veRUPCnc5RwVprOTJ/B7fv39nty4iky1B
         QoudhUml5RvmK0wTC9wzoMc7fnx+RwUcla+mwTGsaN0a4/9Uek+Fz78idOuK8MUMHX
         jMXEKrr3DKd1A==
Message-ID: <d9082b1b4c2e358c97bbc815c1b06e1b05011b0e.camel@kernel.org>
Subject: Re: [PATCH v15 1/6] tpm_tis: Fix expected bit handling and send all
 bytes in one shot without last byte in exception
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Tue, 14 Sep 2021 19:58:12 +0300
In-Reply-To: <20210914151032.216122-2-amirmizi6@gmail.com>
References: <20210914151032.216122-1-amirmizi6@gmail.com>
         <20210914151032.216122-2-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-14 at 18:10 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Detected an incorrect implementation of the send command.
> Currently, the driver polls the TPM_STS.stsValid field until TRUE; then i=
t
> reads TPM_STS register again to verify only that TPM_STS.expect field is
> FALSE (i.e., it ignores TPM_STS.stsValid).
> Since TPM_STS.stsValid represents the TPM_STS.expect validity, both field=
s
> fields should be checked in the same TPM_STS register read value.

This is missing description of what kind of error/consquence this caused.
Perhaps you got something to the klog, or how did you find out about the
issue? Since you have reproduced, please connect it to the reality.

> Modify the signature of 'wait_for_tpm_stat()', add an additional
> "mask_result" parameter to its call and rename it to
> 'tpm_tis_wait_for_stat()' for better alignment with other naming.
> 'tpm_tis_wait_for_stat()' is now polling the TPM_STS with a mask and wait=
s
> for the value in mask_result. Add the ability to check if certain TPM_STS
> bits have been cleared.

The commit description is probably out of sync (not only rename, there is n=
o
parameter called mask_result).

It's also lacking description, how this new parameter is taken advantage of=
.

E.g.

"Use the new parameter to check that status TPM_STS_VALID is set,
 in addition that TPM_STS_EXPECT is zeroed. This prevents a racy
 checkk


> In addition, the send command was changed to comply with
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
> - send all command bytes in one loop
> - remove special handling of the last byte
>=20
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++++++--------------------=
------
>  1 file changed, 25 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 69579ef..7d5854b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -44,9 +44,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chi=
p, u8 mask,
>  	return false;
>  }
> =20
> -static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> -		unsigned long timeout, wait_queue_head_t *queue,
> -		bool check_cancel)
> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, u8 stat,
> +				 unsigned long timeout,
> +				 wait_queue_head_t *queue, bool check_cancel)

This naming is not too great, considering that there is already local varia=
ble
called status.


>  {
>  	unsigned long stop;
>  	long rc;
> @@ -55,7 +55,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 =
mask,
> =20
>  	/* check current status */
>  	status =3D chip->ops->status(chip);
> -	if ((status & mask) =3D=3D mask)
> +	if ((status & mask) =3D=3D stat)
>  		return 0;
> =20
>  	stop =3D jiffies + timeout;
> @@ -83,7 +83,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 =
mask,
>  			usleep_range(TPM_TIMEOUT_USECS_MIN,
>  				     TPM_TIMEOUT_USECS_MAX);
>  			status =3D chip->ops->status(chip);
> -			if ((status & mask) =3D=3D mask)
> +			if ((status & mask) =3D=3D stat)
>  				return 0;
>  		} while (time_before(jiffies, stop));
>  	}
> @@ -260,9 +260,10 @@ static int recv_data(struct tpm_chip *chip, u8 *buf,=
 size_t count)
> =20
>  	while (size < count) {
>  		rc =3D wait_for_tpm_stat(chip,
> -				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> -				 chip->timeout_c,
> -				 &priv->read_queue, true);
> +					   TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +					   TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +					   chip->timeout_c, &priv->read_queue,
> +					   true);
>  		if (rc < 0)
>  			return rc;
>  		burstcnt =3D get_burstcount(chip);
> @@ -315,8 +316,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *bu=
f, size_t count)
>  		goto out;
>  	}
> =20
> -	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -				&priv->int_queue, false) < 0) {
> +	if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
> +				  chip->timeout_c, &priv->int_queue,
> +				  false) < 0) {
>  		size =3D -ETIME;
>  		goto out;
>  	}
> @@ -342,61 +344,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip,=
 const u8 *buf, size_t len)
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>  	int rc, status, burstcnt;
>  	size_t count =3D 0;
> -	bool itpm =3D priv->flags & TPM_TIS_ITPM_WORKAROUND;
> =20
>  	status =3D tpm_tis_status(chip);
>  	if ((status & TPM_STS_COMMAND_READY) =3D=3D 0) {
>  		tpm_tis_ready(chip);
> -		if (wait_for_tpm_stat
> -		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> -		     &priv->int_queue, false) < 0) {
> +		if (wait_for_tpm_stat(chip, TPM_STS_COMMAND_READY,
> +					  TPM_STS_COMMAND_READY,
> +					  chip->timeout_b, &priv->int_queue,
> +					  false) < 0) {
>  			rc =3D -ETIME;
>  			goto out_err;
>  		}
>  	}
> =20
> -	while (count < len - 1) {
> +	while (count < len) {

This.

>  		burstcnt =3D get_burstcount(chip);
>  		if (burstcnt < 0) {
>  			dev_err(&chip->dev, "Unable to read burstcount\n");
>  			rc =3D burstcnt;
>  			goto out_err;
>  		}
> -		burstcnt =3D min_t(int, burstcnt, len - count - 1);
> +		burstcnt =3D min_t(int, burstcnt, len - count);

What are these two changes (loop condition and the right above change)?

>  		rc =3D tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>  					 burstcnt, buf + count);
>  		if (rc < 0)
>  			goto out_err;
> =20
>  		count +=3D burstcnt;
> -
> -		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -					&priv->int_queue, false) < 0) {
> -			rc =3D -ETIME;
> -			goto out_err;
> -		}
> -		status =3D tpm_tis_status(chip);
> -		if (!itpm && (status & TPM_STS_DATA_EXPECT) =3D=3D 0) {
> -			rc =3D -EIO;
> -			goto out_err;
> -		}
>  	}
> -
> -	/* write last byte */
> -	rc =3D tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
> -	if (rc < 0)
> -		goto out_err;
> -
> -	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -				&priv->int_queue, false) < 0) {
> +	if (wait_for_tpm_stat(chip, TPM_STS_VALID | TPM_STS_DATA_EXPECT,
> +				  TPM_STS_VALID, chip->timeout_a,
> +				  &priv->int_queue, false) < 0) {
>  		rc =3D -ETIME;
>  		goto out_err;
>  	}
> -	status =3D tpm_tis_status(chip);
> -	if (!itpm && (status & TPM_STS_DATA_EXPECT) !=3D 0) {
> -		rc =3D -EIO;
> -		goto out_err;
> -	}
> =20
>  	return 0;
> =20
> @@ -451,9 +432,10 @@ static int tpm_tis_send_main(struct tpm_chip *chip, =
const u8 *buf, size_t len)
>  		ordinal =3D be32_to_cpu(*((__be32 *) (buf + 6)));
> =20
>  		dur =3D tpm_calc_ordinal_duration(chip, ordinal);
> -		if (wait_for_tpm_stat
> -		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> -		     &priv->read_queue, false) < 0) {
> +		if (wait_for_tpm_stat(chip,
> +					  TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +					  TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +					  dur, &priv->read_queue, false) < 0) {
>  			rc =3D -ETIME;
>  			goto out_err;
>  		}

/Jarkko

