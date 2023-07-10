Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7274DBD0
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGJQ76 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGJQ75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 12:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692CC0;
        Mon, 10 Jul 2023 09:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2346161063;
        Mon, 10 Jul 2023 16:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A805C433C8;
        Mon, 10 Jul 2023 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008395;
        bh=wmfsXW7B/YZGN21md4uFFTb+UK7dFNWzwEMuj9c0dO8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=opkC/EdxOnIdN/lG++IGm29PeszDoAVEWbyRDjwOIjiXk+7MX/U7fOkBOQTvLpWV0
         3eUrXl+HVxJvja82aF9XTcrXgHuYL8x4mcFWGhL6dmy1SPO7Qz3lR/vudRlth4bueJ
         Xl7XjUUJScS32Nxox4lbs4HT8/CO2cVh7cldn5sEBzuwsRLNiqBvuK3mjUGtRJukzd
         IblWzE5WCUJ68UwcNc5QwYlJemAI/BYLOqPyaBtcve79ZiiK8r6Fugr2xKlPq2hJUc
         VI+8mgNLDK2cSP+AgIg3JL4KVeym7LRB6tK+M+V8gZ3s33UJPYAPon0xaKZZvdayGo
         PdZoNNS4uJi2Q==
Message-ID: <65fc7c2867b630dad97030a6dda0695fce9330d3.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Jul 2023 19:59:52 +0300
In-Reply-To: <20230613180259.3525-4-Alexander.Steffen@infineon.com>
References: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
         <20230613180259.3525-4-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-06-13 at 20:02 +0200, Alexander Steffen wrote:
> TPM responses may become damaged during transmission, for example due to
> bit flips on the wire. Instead of aborting when detecting such issues, th=
e
> responseRetry functionality can be used to make the TPM retransmit its
> response and receive it again without errors.
>=20
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 37 ++++++++++++++++++++++++++-------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 5ddaf24518be..a6d1396413a7 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -337,7 +337,7 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, =
size_t count)
>  	return size;
>  }
> =20
> -static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int tpm_tis_try_recv(struct tpm_chip *chip, u8 *buf, size_t count=
)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>  	int size =3D 0;
> @@ -345,11 +345,6 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *b=
uf, size_t count)
>  	u32 expected;
>  	int rc;
> =20
> -	if (count < TPM_HEADER_SIZE) {
> -		size =3D -EIO;
> -		goto out;
> -	}
> -
>  	size =3D recv_data(chip, buf, TPM_HEADER_SIZE);
>  	/* read first 10 bytes, including tag, paramsize, and result */
>  	if (size < TPM_HEADER_SIZE) {
> @@ -382,7 +377,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *bu=
f, size_t count)
>  		goto out;
>  	}
>  	status =3D tpm_tis_status(chip);
> -	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
> +	if (status & TPM_STS_DATA_AVAIL) {
>  		dev_err(&chip->dev, "Error left over data\n");
>  		size =3D -EIO;
>  		goto out;
> @@ -396,10 +391,36 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *=
buf, size_t count)
>  	}
> =20
>  out:
> -	tpm_tis_ready(chip);
>  	return size;
>  }
> =20
> +static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	unsigned int try;
> +	int rc =3D 0;
> +
> +	if (count < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	for (try =3D 0; try < TPM_RETRY; try++) {
> +		rc =3D tpm_tis_try_recv(chip, buf, count);
> +
> +		if (rc =3D=3D -EIO)
> +			/* Data transfer errors, indicated by EIO, can be
> +			 * recovered by rereading the response.
> +			 */
> +			tpm_tis_write8(priv, TPM_STS(priv->locality),
> +				       TPM_STS_RESPONSE_RETRY);
> +		else
> +			break;
> +	}
> +
> +	tpm_tis_ready(chip);
> +
> +	return rc;
> +}
> +
>  /*
>   * If interrupts are used (signaled by an irq set in the vendor structur=
e)
>   * tpm.c can skip polling for the data to be available as the interrupt =
is
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index 610bfadb6acf..3a6b600d22ba 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -34,6 +34,7 @@ enum tis_status {
>  	TPM_STS_GO =3D 0x20,
>  	TPM_STS_DATA_AVAIL =3D 0x10,
>  	TPM_STS_DATA_EXPECT =3D 0x08,
> +	TPM_STS_RESPONSE_RETRY =3D 0x02,
>  	TPM_STS_READ_ZERO =3D 0x23, /* bits that must be zero on read */
>  };
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
