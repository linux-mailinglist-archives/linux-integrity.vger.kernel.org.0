Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3565758919
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jul 2023 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGRXji (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jul 2023 19:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRXji (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jul 2023 19:39:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C41EC
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jul 2023 16:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954BB612C5
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jul 2023 23:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31085C433C8;
        Tue, 18 Jul 2023 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689723572;
        bh=xbSfCumD8B2VKJnjvl3kRtZnWmIkW+3s3jFeuWj94SM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=T680gBsdZH10WxjsxxMBw1U5zXJkdbzeNCaJNFgfROhvGPEu3C6NiN75tAcvfr88x
         5wdHlQ5TFuopFvh2ksmitDhE0k8g76SV2Drit2qpB4BnLc0wSViiv1TSobZzI4hHTW
         Ph5HjB8n/kCu33oVuHxgaDuYRO7TWmJ/L0Yw0B6D6c/ipmTJx1DnhH3CeR9UohEy3K
         hyImTl+QnwTyMIFBLgiF9LJxCDXZN1RaLIMoSyVbzapet65NJOeOqlIxAHg0Tniid6
         l4bKoXFihGhL5KRqMl7wBBrht+RYq8FLVv2coYVwSvJ0o87nDPczjtIrtx8dEsi36S
         id3PoU9u/x3pA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 19 Jul 2023 02:38:32 +0300
Message-Id: <CU5OZTFCHAAK.2PFDUJD0CY2RE@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Peter Senna Tschudin" <peter.senna@gmail.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <kernel@pengutronix.de>, <linux-integrity@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tpm: Switch i2c drivers back to use .probe()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        <cgzones@googlemail.com>
X-Mailer: aerc 0.14.0
References: <20230525202424.630260-1-u.kleine-koenig@pengutronix.de>
 <CT8AVI0MBB8R.U6HPYA37GZTK@suppilovahvero>
 <20230718203449.dsnrbzcdsoogbqp2@pengutronix.de>
In-Reply-To: <20230718203449.dsnrbzcdsoogbqp2@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jul 18, 2023 at 11:34 PM EEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Fri, Jun 09, 2023 at 08:36:40PM +0300, Jarkko Sakkinen wrote:
> > On Thu May 25, 2023 at 11:24 PM EEST, Uwe Kleine-K=C3=B6nig wrote:
> > > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > > call-back type"), all drivers being converted to .probe_new() and the=
n
> > > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> > > convert back to (the new) .probe() to be able to eventually drop
> > > .probe_new() from struct i2c_driver.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/char/tpm/st33zp24/i2c.c     | 2 +-
> > >  drivers/char/tpm/tpm_i2c_atmel.c    | 2 +-
> > >  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
> > >  drivers/char/tpm/tpm_i2c_nuvoton.c  | 2 +-
> > >  drivers/char/tpm/tpm_tis_i2c.c      | 2 +-
> > >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33z=
p24/i2c.c
> > > index 2d28f55ef490..661574bb0acf 100644
> > > --- a/drivers/char/tpm/st33zp24/i2c.c
> > > +++ b/drivers/char/tpm/st33zp24/i2c.c
> > > @@ -160,7 +160,7 @@ static struct i2c_driver st33zp24_i2c_driver =3D =
{
> > >  		.of_match_table =3D of_match_ptr(of_st33zp24_i2c_match),
> > >  		.acpi_match_table =3D ACPI_PTR(st33zp24_i2c_acpi_match),
> > >  	},
> > > -	.probe_new =3D st33zp24_i2c_probe,
> > > +	.probe =3D st33zp24_i2c_probe,
> > >  	.remove =3D st33zp24_i2c_remove,
> > >  	.id_table =3D st33zp24_i2c_id
> > >  };
> > > diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_=
i2c_atmel.c
> > > index 8f77154e0550..301a95b3734f 100644
> > > --- a/drivers/char/tpm/tpm_i2c_atmel.c
> > > +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> > > @@ -203,7 +203,7 @@ static SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm=
_suspend, tpm_pm_resume);
> > > =20
> > >  static struct i2c_driver i2c_atmel_driver =3D {
> > >  	.id_table =3D i2c_atmel_id,
> > > -	.probe_new =3D i2c_atmel_probe,
> > > +	.probe =3D i2c_atmel_probe,
> > >  	.remove =3D i2c_atmel_remove,
> > >  	.driver =3D {
> > >  		.name =3D I2C_DRIVER_NAME,
> > > diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/t=
pm_i2c_infineon.c
> > > index 7cdaff52a96d..81d8a78dc655 100644
> > > --- a/drivers/char/tpm/tpm_i2c_infineon.c
> > > +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> > > @@ -716,7 +716,7 @@ static void tpm_tis_i2c_remove(struct i2c_client =
*client)
> > > =20
> > >  static struct i2c_driver tpm_tis_i2c_driver =3D {
> > >  	.id_table =3D tpm_tis_i2c_table,
> > > -	.probe_new =3D tpm_tis_i2c_probe,
> > > +	.probe =3D tpm_tis_i2c_probe,
> > >  	.remove =3D tpm_tis_i2c_remove,
> > >  	.driver =3D {
> > >  		   .name =3D "tpm_i2c_infineon",
> > > diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tp=
m_i2c_nuvoton.c
> > > index a026e98add50..d7be03c41098 100644
> > > --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> > > +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> > > @@ -650,7 +650,7 @@ static SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_=
pm_suspend, tpm_pm_resume);
> > > =20
> > >  static struct i2c_driver i2c_nuvoton_driver =3D {
> > >  	.id_table =3D i2c_nuvoton_id,
> > > -	.probe_new =3D i2c_nuvoton_probe,
> > > +	.probe =3D i2c_nuvoton_probe,
> > >  	.remove =3D i2c_nuvoton_remove,
> > >  	.driver =3D {
> > >  		.name =3D "tpm_i2c_nuvoton",
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_ti=
s_i2c.c
> > > index c8c34adc14c0..11b4196b7136 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > > @@ -379,7 +379,7 @@ static struct i2c_driver tpm_tis_i2c_driver =3D {
> > >  		.pm =3D &tpm_tis_pm,
> > >  		.of_match_table =3D of_match_ptr(of_tis_i2c_match),
> > >  	},
> > > -	.probe_new =3D tpm_tis_i2c_probe,
> > > +	.probe =3D tpm_tis_i2c_probe,
> > >  	.remove =3D tpm_tis_i2c_remove,
> > >  	.id_table =3D tpm_tis_i2c_id,
> > >  };
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/t=
pm_tis_i2c_cr50.c
> > > index 376ae18a04eb..e70abd69e1ae 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > @@ -779,7 +779,7 @@ static void tpm_cr50_i2c_remove(struct i2c_client=
 *client)
> > >  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume)=
;
> > > =20
> > >  static struct i2c_driver cr50_i2c_driver =3D {
> > > -	.probe_new =3D tpm_cr50_i2c_probe,
> > > +	.probe =3D tpm_cr50_i2c_probe,
> > >  	.remove =3D tpm_cr50_i2c_remove,
> > >  	.driver =3D {
> > >  		.name =3D "cr50_i2c",
> > > --=20
> > > 2.39.2
> >=20
> >=20
> > Thanks, applied!
>
> This was was in next up to next-20230717, it's not included in
> next-20230718 any more. The branch pulled into next from=20
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git#nex=
t
>
> changed from 0ec1b5bea32bce719ebdab253462f9c9cb0aca3e to
> 481c2d14627de8ecbb54dd125466e4b4a5069b47. This is a rebase to v6.5-rc2
> dropping some more patches:
>
> 	$ git log --oneline 481c2d14627de8ecbb54dd125466e4b4a5069b47...0ec1b5bea=
32bce719ebdab253462f9c9cb0aca3e --cherry-pick --right-only
> 	5a29fb0d959a tpm: make all 'class' structures const
> 	17222dfebab1 tpm: remove redundant variable len
> 	dfd6ecc2066c tpm_tis: Resend command to recover from data transfer error=
s
> 	8458b36c647c tpm_tis: Use responseRetry to recover from data transfer er=
rors
> 	a5dd583aa98b tpm_tis: Move CRC check to generic send routine
> 	126f3df1f03c tpm_tis: Explicitly check for error code
> 	dfba6d4ad558 tpm: Switch i2c drivers back to use .probe()
> 	bed72785706c tpm_tis-spi: Add hardware wait polling
> 	2afb9c102761 integrity: Enforce digitalSignature usage in the ima and ev=
m keyrings
> 	0d8f1c250285 KEYS: DigitalSignature link restriction
> 	41e4e488742e KEYS: Replace all non-returning strlcpy with strscpy
> 	e2e51b64f0c8 security: keys: perform capable check only on privileged op=
erations
>
> These all apply just fine on top of next-20230718, so I wonder what made
> you drop them. Can you please reapply at least dfba6d4ad558?
>
> Best regards
> Uwe
>
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

I was a bit stalled because of tpm_tis irq issue [1]. The two [2] requested
patches are now mirrored again to linux-next [3].

I'll create rc4 pull request after rc3 comes out.

[1] https://lkml.org/lkml/2023/7/18/1123
[2] https://lore.kernel.org/keyrings/CAJ2a_Dd-piQ51dqptuhJ8pXm+4HrFAcdbA-ES=
d8YwNO3qHnJrA@mail.gmail.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/=
log/?h=3Dnext

BR, Jarkko


