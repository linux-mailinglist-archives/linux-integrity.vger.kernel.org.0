Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE341665B
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Sep 2021 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhIWUI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Sep 2021 16:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242979AbhIWUI0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Sep 2021 16:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A41060FC1;
        Thu, 23 Sep 2021 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632427614;
        bh=yyinDmbPbtw66r75n8Oqp2XOzOy08SPTZs7PmsP6Kfc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ROv4pYJfcgnqxeBozpzAspss9HnTmpHfiFahLswXk3dFXULmULsX+MxLaouNnwIBD
         TY8/nCUCLYBMrcws3Fj3VTORFJUnIDwMSdlFQwghREplOC7QsEn5+87veKD85QMnQf
         kOzMzoIUoff+32TxewelMefbSymMrCHTW4RVQg5Adbf5fkuCWnHzNCYZdVXzyd1dr6
         58OoHFM6K/ANI12hv0fMK07WgiMCq2ya2WjMlrk1uy2TLBd1+reLf+2Sr3r/AKpMs4
         0drunUp23JHCJuvOrq97OAw95wZotQ1A6r6jiszdI2n69EkofutYdI4borutNzv09M
         Gm8u4aIc0Y2fQ==
Message-ID: <10729a13e3105654601d5b937878920bed973ec8.camel@kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Add missing SPI ID
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 23 Sep 2021 23:06:52 +0300
In-Reply-To: <20210923181520.8680-1-broonie@kernel.org>
References: <20210923181520.8680-1-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-23 at 19:15 +0100, Mark Brown wrote:
> In commit c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> we added SPI IDs for all the DT aliases to handle the fact that we always
> use SPI modaliases to load modules even when probed via DT however this
> added an alias for the non-idiomatic tpm_tis-spi compatible as tpm_tis_sp=
i
> which doesn't actually match. Add an extra ID for tpm_tis-spi rather than
> just fix the existing one since what's currently there is going to be
> better for anyone actually using SPI IDs to instantiate.
>=20
> Fixes: c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
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



Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll apply this.

/Jarkko

