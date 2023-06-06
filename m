Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15DB724EB2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFFVT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFFVT5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8090;
        Tue,  6 Jun 2023 14:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB8660A08;
        Tue,  6 Jun 2023 21:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF2C433D2;
        Tue,  6 Jun 2023 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086395;
        bh=XB3OSpbt1Wh7qOLjklztn/3tjGEC8OOxzcGdAsjKhU8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=skZ3JQeZPawyXL/3jZXjyrgpq9ClQ5e1b/Jb+xxwgBmu6I2XqWPXwyq3eVKyTf99E
         c6sBbLN7n94a0CQ0hlWFdgj0gpkvn+D9iSgysYcCCklrQC4448hLDGAsn9MMDRC0Yw
         jLwkejHFACurfREO2C8U644GlNLOEV+GpH0wJyIpLaS9OeUHOIwkUYE5eTEcf8QdTw
         ffEyLbEogWtlwmt5cb+HGDbnQJBtg2Ni6yFfGPFtPOfbx+PV+rVxKtKfC+Tb7VG3dm
         QvCbJz7oYY3PlDwlRZkfXnzfk2TU7Og+pAcO9rSM6GkC9khT0ZR7vYXCyrRdjCVxz2
         zJpalMvN1ak9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:19:52 +0300
Message-Id: <CT5VQRBK8CNQ.3CG1NPROERNSX@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] tpm_tis: Resend command to recover from data
 transfer errors
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-5-Alexander.Steffen@infineon.com>
In-Reply-To: <20230605175959.2131-5-Alexander.Steffen@infineon.com>
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
> Similar to the transmission of TPM responses, also the transmission of TP=
M
> commands may become corrupted. Instead of aborting when detecting such
> issues, try resending the command again.
>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index a08768e55803..47073cc79b51 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -535,10 +535,18 @@ static int tpm_tis_send_main(struct tpm_chip *chip,=
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
> +		if (rc >=3D 0) {
> +			/* Data transfer done successfully */
> +			break;
> +		} else if (rc !=3D -EIO) {
> +			/* Data transfer failed, not recoverable */
> +			return rc;
> +		}

Remove curly braces from the two statements above.

> +	}
> =20
>  	/* go and do it */
>  	rc =3D tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
> --=20
> 2.34.1


BR, Jarkko
