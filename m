Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23C72A15C
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFIRgw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjFIRgt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 13:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6091FDC
        for <linux-integrity@vger.kernel.org>; Fri,  9 Jun 2023 10:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAA265A6E
        for <linux-integrity@vger.kernel.org>; Fri,  9 Jun 2023 17:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F50C433D2;
        Fri,  9 Jun 2023 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686332206;
        bh=grgo+iXV4RGQ/0XgEhlJdpNlyDAks/t3r4xyMVIvJdw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=X6cNNHup/1CWjXJaN2FDPtZfbSeEI7LeUXLXkt5O0lToxGKeYmfKXsGY0oet0Taez
         ph35ZtyUcK2zA4xFp3GzxQV4Zb09KaN12v2Onrs8MC/Pwarmx68dKlOdA0uDWM3VTm
         WNjGNRXTSmNMIivNfOB4/0Hip4TuEcRANzwGUPNIkuJWa4QepjRM/ezOQCesBx9LQ3
         zpaXReN1SAMzBVSewBEB5UAMRd6NqGMSUeEnESCPsuYLZWFxXaG5zmyqKoA2cCNr2W
         sXj7npSsZoCzRZYCda/LGvAGx8zJ4uQmc/nyGIZ0nNJzMmk/BxtYWh4C5S8ENYmbSt
         wYcrZBKCaM//A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 20:36:40 +0300
Message-Id: <CT8AVI0MBB8R.U6HPYA37GZTK@suppilovahvero>
Subject: Re: [PATCH] tpm: Switch i2c drivers back to use .probe()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Peter Huewe" <peterhuewe@gmx.de>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Peter Senna Tschudin" <peter.senna@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-integrity@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.14.0
References: <20230525202424.630260-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230525202424.630260-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 25, 2023 at 11:24 PM EEST, Uwe Kleine-K=C3=B6nig wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/char/tpm/st33zp24/i2c.c     | 2 +-
>  drivers/char/tpm/tpm_i2c_atmel.c    | 2 +-
>  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
>  drivers/char/tpm/tpm_i2c_nuvoton.c  | 2 +-
>  drivers/char/tpm/tpm_tis_i2c.c      | 2 +-
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/=
i2c.c
> index 2d28f55ef490..661574bb0acf 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -160,7 +160,7 @@ static struct i2c_driver st33zp24_i2c_driver =3D {
>  		.of_match_table =3D of_match_ptr(of_st33zp24_i2c_match),
>  		.acpi_match_table =3D ACPI_PTR(st33zp24_i2c_acpi_match),
>  	},
> -	.probe_new =3D st33zp24_i2c_probe,
> +	.probe =3D st33zp24_i2c_probe,
>  	.remove =3D st33zp24_i2c_remove,
>  	.id_table =3D st33zp24_i2c_id
>  };
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_=
atmel.c
> index 8f77154e0550..301a95b3734f 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -203,7 +203,7 @@ static SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm_sus=
pend, tpm_pm_resume);
> =20
>  static struct i2c_driver i2c_atmel_driver =3D {
>  	.id_table =3D i2c_atmel_id,
> -	.probe_new =3D i2c_atmel_probe,
> +	.probe =3D i2c_atmel_probe,
>  	.remove =3D i2c_atmel_remove,
>  	.driver =3D {
>  		.name =3D I2C_DRIVER_NAME,
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i=
2c_infineon.c
> index 7cdaff52a96d..81d8a78dc655 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -716,7 +716,7 @@ static void tpm_tis_i2c_remove(struct i2c_client *cli=
ent)
> =20
>  static struct i2c_driver tpm_tis_i2c_driver =3D {
>  	.id_table =3D tpm_tis_i2c_table,
> -	.probe_new =3D tpm_tis_i2c_probe,
> +	.probe =3D tpm_tis_i2c_probe,
>  	.remove =3D tpm_tis_i2c_remove,
>  	.driver =3D {
>  		   .name =3D "tpm_i2c_infineon",
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2=
c_nuvoton.c
> index a026e98add50..d7be03c41098 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -650,7 +650,7 @@ static SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_pm_s=
uspend, tpm_pm_resume);
> =20
>  static struct i2c_driver i2c_nuvoton_driver =3D {
>  	.id_table =3D i2c_nuvoton_id,
> -	.probe_new =3D i2c_nuvoton_probe,
> +	.probe =3D i2c_nuvoton_probe,
>  	.remove =3D i2c_nuvoton_remove,
>  	.driver =3D {
>  		.name =3D "tpm_i2c_nuvoton",
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index c8c34adc14c0..11b4196b7136 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -379,7 +379,7 @@ static struct i2c_driver tpm_tis_i2c_driver =3D {
>  		.pm =3D &tpm_tis_pm,
>  		.of_match_table =3D of_match_ptr(of_tis_i2c_match),
>  	},
> -	.probe_new =3D tpm_tis_i2c_probe,
> +	.probe =3D tpm_tis_i2c_probe,
>  	.remove =3D tpm_tis_i2c_remove,
>  	.id_table =3D tpm_tis_i2c_id,
>  };
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index 376ae18a04eb..e70abd69e1ae 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -779,7 +779,7 @@ static void tpm_cr50_i2c_remove(struct i2c_client *cl=
ient)
>  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
> =20
>  static struct i2c_driver cr50_i2c_driver =3D {
> -	.probe_new =3D tpm_cr50_i2c_probe,
> +	.probe =3D tpm_cr50_i2c_probe,
>  	.remove =3D tpm_cr50_i2c_remove,
>  	.driver =3D {
>  		.name =3D "cr50_i2c",
> --=20
> 2.39.2


Thanks, applied!

BR, Jarkko
