Return-Path: <linux-integrity+bounces-3766-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A142D99711A
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92531C2093F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650661E0E15;
	Wed,  9 Oct 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxu8hRs1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EB1E0E07
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490045; cv=none; b=jtiQMbu7NWskPBvS4URUOmtwvGCy9eIrMX9RuQQd8//bZ8I4bFBmikhlDeshDDFLcQvLRalxyTionu+Ewfdpl1/tzVPq4ukTSnbgpc80ZviNHKwVLzyEWUj/ZYhtux2qy2eWgYLe0uEefE8Pgly1LAaSV2vkzHeOb15UuJ0IPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490045; c=relaxed/simple;
	bh=BpAIYPb9L+rpAmaprtX9jLjFzmTJc34CNzOHY+P765w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PoX0EOKsHf5q8lEGGFUBR1PgZDHzd4TAIdkjlluEWHDcIrZSLucVTZsrRnbNw2nOLe7i+iZFlK4vh6gxRiCci+hRi4nY3csngq40RVr+4YoNkXiBgvWvOctyUZzCNDBe8ngz1zO/ApNNkct8abIeLtCo8Ch+98fkRPhOulEHaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxu8hRs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4463DC4CEC3;
	Wed,  9 Oct 2024 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490044;
	bh=BpAIYPb9L+rpAmaprtX9jLjFzmTJc34CNzOHY+P765w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Xxu8hRs1OtY+e8u7ydvehh19A7Lpr5ZStjgvChntlo/mRoOv0qW461CtkRRySD5b3
	 ApcAEeJnlRu7d0HphKfOaJT1+SGMzk90+Kj9mPSDDlHoIXGnnNmhdSI5sCWldPCDrq
	 FTZ/tkw1qfkNZv5CvPXB2Pe5dsHznQUpAl5H11qEV1P1cNHYZz/OQL/9jGhdSSRfwR
	 TC9Mrygswb+R8iz66CGxyJefaanlF5ZXjpJcC8zSjh5KuOp2fc1ANUz4wCItOKX3Cm
	 9ds+Rh7EpaodZ3w4IMj3/cwpURex8SnvHI/hwzmSJAuO0fN0PppK5Xqeuu9b+lJ6oh
	 1Yruq2vFNnkdQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 19:07:20 +0300
Message-Id: <D4REKYJJQT5Z.1CUF2XM163E3F@kernel.org>
Cc: <apronin@google.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, <mw@semihalf.com>,
 <peterhuewe@gmx.de>, <rrangel@chromium.org>, <timvp@google.com>
Subject: Re: [PATCH V2 2/2] char: tpm: cr50: Move i2c locking to
 request/relinquish locality ops
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Grzegorz Bernacki" <bernacki@chromium.org>, <jsd@semihalf.com>
X-Mailer: aerc 0.18.2
References: <20221101020352.939691-1-jsd@semihalf.com>
 <20241009094207.2897048-1-bernacki@google.com>
 <20241009094207.2897048-3-bernacki@google.com>
In-Reply-To: <20241009094207.2897048-3-bernacki@google.com>

On Wed Oct 9, 2024 at 12:42 PM EEST, Grzegorz Bernacki wrote:
> From: Jan Dabros <jsd@semihalf.com>
>
> Move i2c locking primitives to request_locality and relinquish_locality
> callbacks, what effectively blocks TPM bus for the whole duration of
> logical TPM operation.
>
> With this in place, cr50-equipped TPM may be shared with external CPUs -
> assuming that underneath i2c controller driver is aware of this setup
> (see i2c-designware-amdpsp as an example).
>
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index 1b1e403383fc..104ef6c7f11c 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -201,8 +201,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u=
8 addr, u8 *buffer, size_t
>  	};
>  	int rc;
> =20
> -	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> -
>  	/* Prepare for completion interrupt */
>  	tpm_cr50_i2c_enable_tpm_irq(chip);
> =20
> @@ -221,7 +219,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u=
8 addr, u8 *buffer, size_t
> =20
>  out:
>  	tpm_cr50_i2c_disable_tpm_irq(chip);
> -	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> =20
>  	if (rc < 0)
>  		return rc;
> @@ -263,8 +260,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, =
u8 addr, u8 *buffer,
>  	priv->buf[0] =3D addr;
>  	memcpy(priv->buf + 1, buffer, len);
> =20
> -	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> -
>  	/* Prepare for completion interrupt */
>  	tpm_cr50_i2c_enable_tpm_irq(chip);
> =20
> @@ -278,7 +273,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, =
u8 addr, u8 *buffer,
> =20
>  out:
>  	tpm_cr50_i2c_disable_tpm_irq(chip);
> -	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> =20
>  	if (rc < 0)
>  		return rc;
> @@ -322,6 +316,7 @@ static int tpm_cr50_check_locality(struct tpm_chip *c=
hip, int loc)
>   */
>  static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
>  {
> +	struct i2c_client *client =3D to_i2c_client(chip->dev.parent);
>  	u8 mask =3D TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
>  	u8 addr =3D TPM_I2C_ACCESS(loc);
>  	u8 buf;
> @@ -329,13 +324,15 @@ static int tpm_cr50_release_locality(struct tpm_chi=
p *chip, int loc)
> =20
>  	rc =3D tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
>  	if (rc < 0)
> -		return rc;
> +		goto unlock_out;
> =20
>  	if ((buf & mask) =3D=3D mask) {
>  		buf =3D TPM_ACCESS_ACTIVE_LOCALITY;
>  		rc =3D tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
>  	}
> =20
> +unlock_out:
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
>  	return rc;
>  }
> =20
> @@ -350,16 +347,19 @@ static int tpm_cr50_release_locality(struct tpm_chi=
p *chip, int loc)
>   */
>  static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
>  {
> +	struct i2c_client *client =3D to_i2c_client(chip->dev.parent);
>  	u8 buf =3D TPM_ACCESS_REQUEST_USE;
>  	unsigned long stop;
>  	int rc;
> =20
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
>  	if (tpm_cr50_check_locality(chip, loc) =3D=3D loc)
>  		return loc;
> =20
>  	rc =3D tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf))=
;
>  	if (rc < 0)
> -		return rc;
> +		goto unlock_out;
> =20
>  	stop =3D jiffies + chip->timeout_a;
>  	do {
> @@ -369,7 +369,11 @@ static int tpm_cr50_request_locality(struct tpm_chip=
 *chip, int loc)
>  		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
>  	} while (time_before(jiffies, stop));
> =20
> -	return -ETIMEDOUT;
> +	rc =3D -ETIMEDOUT;
> +
> +unlock_out:
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	return rc;
>  }
> =20
>  /**

Nothing apparently wrong in this. Will re-check after 1/2 is good.

BR, Jarkko

