Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FC724EA9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjFFVRe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjFFVRb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6FD10EC;
        Tue,  6 Jun 2023 14:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 013E860A08;
        Tue,  6 Jun 2023 21:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D731C433EF;
        Tue,  6 Jun 2023 21:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086249;
        bh=nA4njeqbzFPc6HQV74+hVXJqx8F8pmcobJmLOunIhiQ=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=D1dlCZcIWFx68M+XTAwOAAaUoY2NNAJSZnQh56zqcURuFrTwmwbj9VIRFJsGawilh
         1uOd96WyK1SBT7BPq6XIg2JfNVR7R4IqQVwQSOx+7uiwOQy4C+mMzfakSuRBTVnYyU
         +Ye8SgKtqXnUTgorGUXq8eRvTS9HjrBYJo7SqJ+nnFsNAbskxAiWxc+ayzfaKtEIA0
         6LbIvG/PWuUslDbSPdHl9y/DCT4tsPNPjHIABm7nOrZZxXedUcEYEwCaGOZt4m8cVd
         NpeYwZo11yQLRu5FflmrWIfUFNHSMgY9/szhWNm+l7mAhdGjz6spyE/k2/P9K3wN0u
         NKFvL60XDXbNg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:17:26 +0300
Message-Id: <CT5VOWDNIK5S.1549VUD23JWWB@suppilovahvero>
Subject: Re: [PATCH v2 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-4-Alexander.Steffen@infineon.com>
In-Reply-To: <20230605175959.2131-4-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jun 5, 2023 at 8:59 PM EEST, Alexander Steffen wrote:
> TPM responses may become damaged during transmission, for example due to
> bit flips on the wire. Instead of aborting when detecting such issues, th=
e
> responseRetry functionality can be used to make the TPM retransmit its
> response and receive it again without errors.
>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 40 ++++++++++++++++++++++++++-------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 5ddaf24518be..a08768e55803 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
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

Please remove (no-op).

>  		dev_err(&chip->dev, "Error left over data\n");
>  		size =3D -EIO;
>  		goto out;
> @@ -396,10 +391,39 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *=
buf, size_t count)
>  	}
> =20
>  out:
> -	tpm_tis_ready(chip);
>  	return size;
>  }
> =20
> +static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, siz=
e_t count)

This *substitutes* the curent tpm_tis_recv(), right?

So it *is* tpm_tis_recv(), i.e. no renames thank you :-)

> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	unsigned int try;
> +	int rc =3D 0;
> +
> +	if (count < TPM_HEADER_SIZE) {
> +		rc =3D -EIO;
> +		goto out;
> +	}
> +
> +	for (try =3D 0; try < TPM_RETRY; try++) {
> +		rc =3D tpm_tis_recv(chip, buf, count);

I would rename single shot tpm_tis_recv() as tpm_tis_try_recv().

> +
> +		if (rc =3D=3D -EIO) {
> +			/* Data transfer errors, indicated by EIO, can be
> +			 * recovered by rereading the response.
> +			 */
> +			tpm_tis_write8(priv, TPM_STS(priv->locality),
> +				       TPM_STS_RESPONSE_RETRY);
> +		} else {
> +			break;
> +		}

And if this should really be managed inside tpm_tis_try_recv(), and
then return zero (as the code block consumes the return value).

> +	}
> +
> +out:
> +	tpm_tis_ready(chip);

Empty line here (nit).

> +	return rc;
> +}
> +
>  /*
>   * If interrupts are used (signaled by an irq set in the vendor structur=
e)
>   * tpm.c can skip polling for the data to be available as the interrupt =
is
> @@ -986,7 +1010,7 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *c=
hip, bool value)
>  static const struct tpm_class_ops tpm_tis =3D {
>  	.flags =3D TPM_OPS_AUTO_STARTUP,
>  	.status =3D tpm_tis_status,
> -	.recv =3D tpm_tis_recv,
> +	.recv =3D tpm_tis_recv_with_retries,
>  	.send =3D tpm_tis_send,
>  	.cancel =3D tpm_tis_ready,
>  	.update_timeouts =3D tpm_tis_update_timeouts,
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index e978f457fd4d..8458cd4a84ec 100644
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
> --=20
> 2.34.1

BR, Jarkko
