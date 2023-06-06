Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2117724E85
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjFFVKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFFVKc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30853171D;
        Tue,  6 Jun 2023 14:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82D662FC7;
        Tue,  6 Jun 2023 21:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F4C433EF;
        Tue,  6 Jun 2023 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686085831;
        bh=29s3VwULHt/or99UmP4xe8ouFwwgxuwFanN/l3kgc7c=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=B7U2uNJGyW1nydKLZFAE6oyM6y5KTEpAk0Hb5CKE0cN7mcfnGPELK+DjWHbMe+CKX
         Ahcx7t1EsbPp7OsCaBaNaU1ofDz1LNqHnYzi0LgAWkKsa7nYrLGCdlVVnvDmpIIigZ
         8X06v6NsIZVrHDiJlHqmB2mXwc/C5kcn6ksDUnXKNEb35Ev/rissac4kaVzJq83DDL
         Jj5/lqCR3FTKEkFmbkLikzGzuqS4FaXAWRE0aCiOjUuCh2Yjv0v75gc2BhojNPo1Tk
         auJguRO9LWZ8spVXSXh/N8ToWE0aPo0uUJoD2l9f+/bi82BPQ77dnih/HYsv9lS54B
         SUPxii+c2M1/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:10:28 +0300
Message-Id: <CT5VJKCFVQVT.3J6KJMTN0YSZW@suppilovahvero>
Subject: Re: [PATCH v2 2/4] tpm_tis: Move CRC check to generic send routine
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-3-Alexander.Steffen@infineon.com>
In-Reply-To: <20230605175959.2131-3-Alexander.Steffen@infineon.com>
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
> The CRC functionality is initialized before tpm_tis_core, so it can be us=
ed
> on all code paths within the module. Therefore, move the CRC check to the
> generic send routine, that also contains all other checks for successful
> command transmission, so that all those checks are in one place.
>
> Also, this ensures that tpm_tis_ready is called when a CRC failure is
> detected, to clear the invalid data from the TPM, which did not happen
> previously.
>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index aaaa136044ae..5ddaf24518be 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -466,6 +466,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, =
const u8 *buf, size_t len)
>  		goto out_err;
>  	}
> =20
> +	rc =3D tpm_tis_verify_crc(priv, len, buf);
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "CRC mismatch for command.\n");
> +		goto out_err;
> +	}
> +
>  	return 0;
> =20
>  out_err:
> @@ -510,12 +516,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, =
const u8 *buf, size_t len)
>  	if (rc < 0)
>  		return rc;
> =20
> -	rc =3D tpm_tis_verify_crc(priv, len, buf);
> -	if (rc < 0) {
> -		dev_err(&chip->dev, "CRC mismatch for command.\n");
> -		return rc;
> -	}
> -
>  	/* go and do it */
>  	rc =3D tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>  	if (rc < 0)
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
