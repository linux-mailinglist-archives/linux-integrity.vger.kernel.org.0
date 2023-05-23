Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEA70E51B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjEWTHx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjEWTHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C8119;
        Tue, 23 May 2023 12:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1407601D7;
        Tue, 23 May 2023 19:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737D4C433EF;
        Tue, 23 May 2023 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684868868;
        bh=UjoI8KoEuWKKny/a0/2Y5UC4GhbSgwmY9f8yoNGDBVE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=HsU4mJiq0+kQivmSwVpMkf5uxpXXhoM+pBA1jUMtHg5go78AmqSu7l72l92zJRXpv
         RJDDMwBOfFz/CMHXXIo7nw/p0IR76yzwBSAQHGT+YpvEYdq5kR6jiFQdNlP3aY6fWG
         fS7oB7GkQF8kmMaALLK7SQVAlHbOYD4SZPNVZxrMIXLMFWSxVz7EibcX9xCtyERUtD
         VRHWI0/3US9byvmSj06WSC17q7A7FutLewiIrWw/99uoSyvNf+fclRo2Ot8VD0qtjo
         QjuRcKLW2Fy4Kd66uIecU9w9pGA/kNL4iLARhPA+Cq4f/Jwwl6E4ThioYaT0FOqoMR
         w42g9stpb0+dA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 22:07:43 +0300
Message-Id: <CSTW5YGZ50O1.16RYO14HOQRH2@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 2/2] tpm, tpm_tis: reuse code in disable_interrupts()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <20230522143105.8617-2-LinoSanfilippo@gmx.de>
In-Reply-To: <20230522143105.8617-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> Avoid code redundancy by shifting part of the code in disable_interrupts(=
)
> into a subfunction and reusing this function in tpm_tis_handle_irq_storm(=
).
> Make sure that in the subfunction the INT_ENABLE register is written with=
 a
> claimed locality even if the caller did not claim it before.
>
> In the shifted code get rid of the variable "rc" by initializing the
> interrupt mask to zero at variable declaration.
>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 36 ++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 458ebf8c2f16..8f4f2cb5520f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *chip,=
 const u8 *buf, size_t len)
>  	return rc;
>  }
> =20
> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	u32 intmask =3D 0;
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> +}
> +
>  static void disable_interrupts(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	u32 intmask;
> -	int rc;
> =20
>  	if (priv->irq =3D=3D 0)
>  		return;
> =20
> -	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		intmask =3D 0;
> -
> -	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> -	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	__tpm_tis_disable_interrupts(chip);
> =20
>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>  	priv->irq =3D 0;
> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>  }
> =20
>  /*
> @@ -755,20 +762,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *c=
hip, u8 status)
>  static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	int intmask =3D 0;
> =20
>  	dev_err(&chip->dev, HW_ERR
>  		"TPM interrupt storm detected, polling instead\n");
> =20
> -	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -
> -	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> -
> -	tpm_tis_request_locality(chip, 0);
> -	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -	tpm_tis_relinquish_locality(chip, 0);
> -
> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> +	__tpm_tis_disable_interrupts(chip);
> =20
>  	/*
>  	 * We must not call devm_free_irq() from within the interrupt handler,
> --=20
> 2.40.1

NAK as invidual change w/o further discussion.

Would need to be seen in context. This does not change kernel for
better.

If you want to wrap, please do it in 1/2 and then we can evaluate
whether it makes sense or not.

BR, Jarkko
