Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BF41A54C
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Sep 2021 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhI1CYs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Sep 2021 22:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238529AbhI1CYs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Sep 2021 22:24:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF9A9611CE;
        Tue, 28 Sep 2021 02:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632795789;
        bh=Ofp+zR1uQ91kwXFQ1ADyRc2oAcX/ts5LmqQvwzIPMwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e/dYO3f7j+dQd64jRHsLj1Xd6bMXOjUFfByMincXpXgruBrZR3M01MCG9FlfIkWg6
         dU/JxRRYCU9fIwrXbxpScIA97Mb/UIT/iH02d/TZQ6r9JJqNlWU38k36S0WJXXnlBz
         q3kTMn5iR99Ixx1Cd3APR6nD1RYE+zoydXvVZhwl4cYAYQaBG9nqcVewyRtGlBxCsE
         OP9+htq3w4c6ERFtcOEnFNis23sly1/CiLrM94vYqXyoCeWPaKKqDidOCT50iCnylC
         3o3CptJLD09ql/pD5olYS2rP4tpRrpx31JaBBVELFGDcfcNXHv+pgDJncGHKwC1vg3
         aAHk0796gLJyw==
Message-ID: <b25fa9f5f287bcec3d67cb0d236244ec62370543.camel@kernel.org>
Subject: Re: [PATCH v2] tpm_tis_spi: Add missing SPI ID
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Date:   Tue, 28 Sep 2021 05:23:07 +0300
In-Reply-To: <20210924144111.15267-1-broonie@kernel.org>
References: <20210924144111.15267-1-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-09-24 at 15:41 +0100, Mark Brown wrote:
> In commit c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> we added SPI IDs for all the DT aliases to handle the fact that we always
> use SPI modaliases to load modules even when probed via DT however the
> mentioned commit missed that the SPI and OF device ID entries did not
> match and were different and so DT nodes with compatible
> "tcg,tpm_tis-spi" will not match.  Add an extra ID for tpm_tis-spi
> rather than just fix the existing one since what's currently there is
> going to be better for anyone actually using SPI IDs to instantiate.
>=20
> Fixes: c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> v2:
>  - Tweak commit message with suggestion from Javier.
>=20
>  drivers/char/tpm/tpm_tis_spi_main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index 54584b4b00d1..aaa59a00eeae 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -267,6 +267,7 @@ static const struct spi_device_id tpm_tis_spi_id[] =
=3D {
>  	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
>  	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
>  	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
> +	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
>  	{ "cr50", (unsigned long)cr50_spi_probe },
>  	{}
>  };

I replaced the previous patch with this in my GIT tree.

/Jarkko
