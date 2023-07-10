Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7923E74DBD4
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGJRAg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGJRAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 13:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A64D7;
        Mon, 10 Jul 2023 10:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB9961063;
        Mon, 10 Jul 2023 17:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BEBC433C7;
        Mon, 10 Jul 2023 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008433;
        bh=olt/eE72Fe/WemTa8hX4qWzKexWxP3mHF33PZCU7i9I=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=myb7n+TDAMq+1aoTOqi2avGRFtbWQ0Xwo2eeJDzqim66ZnirfK67FwKBqW7Q8PBVR
         Y1KmAjtfvL+d1MlUYOD54vWBG7KNDuLtIPYhbPCtyVyPXHrjbe5wWQRjWNn4qVlN8f
         F/t/3gimacqsqfL46+vXf/Mhkc2iIe7oCYXO+mTc4d2sc3kaKiWnAOE8WIzHrlNuFY
         XtwZgvJR+I2qXtk1CCIogxqOy/YWRfvb1g5PSNR4RCCjHWKlBtMR3xOu+Ddnw1g7BF
         jTrqA+h1kxzLg7n0lPjAJVu91ykBZHxdOHZBc5gH+QgQLzmjHa+fhpoCN7CE2ZI32s
         T7WnBRuNQFqhQ==
Message-ID: <d380ea85b375c861067d01a2561150039e8c3491.camel@kernel.org>
Subject: Re: [PATCH v3 4/4] tpm_tis: Resend command to recover from data
 transfer errors
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Jul 2023 20:00:29 +0300
In-Reply-To: <20230613180259.3525-5-Alexander.Steffen@infineon.com>
References: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
         <20230613180259.3525-5-Alexander.Steffen@infineon.com>
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
> Similar to the transmission of TPM responses, also the transmission of TP=
M
> commands may become corrupted. Instead of aborting when detecting such
> issues, try resending the command again.
>=20
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index a6d1396413a7..7b13ad4bd6dd 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -532,10 +532,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip,=
 const u8 *buf, size_t len)
>  	int rc;
>  	u32 ordinal;
>  	unsigned long dur;
> +	unsigned int try;
> =20
> -	rc =3D tpm_tis_send_data(chip, buf, len);
> -	if (rc < 0)
> -		return rc;
> +	for (try =3D 0; try < TPM_RETRY; try++) {
> +		rc =3D tpm_tis_send_data(chip, buf, len);
> +		if (rc >=3D 0)
> +			/* Data transfer done successfully */
> +			break;
> +		else if (rc !=3D -EIO)
> +			/* Data transfer failed, not recoverable */
> +			return rc;
> +	}
> =20
>  	/* go and do it */
>  	rc =3D tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
