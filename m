Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874E54D0BD
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbiFOSON (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358326AbiFOSOE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:14:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC33DDC9;
        Wed, 15 Jun 2022 11:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44601B820FE;
        Wed, 15 Jun 2022 18:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED90C3411C;
        Wed, 15 Jun 2022 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655316840;
        bh=6lDvbFvHvn80IflfO9FEcBhFgYYpeJ+mAlZpmlJeM6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgbSXRLixAXKtsy7Wc1OmaIsx6ykSuSqlJ35go/AzyCXkORxm0PwFmCM+ylvtzYW0
         nn918/T3Olnc4k/uV6M26in01V/ii4OK4DFXm6ECuz0dO5Xdiz+d6lSEMgT4k6vWFI
         DRzaxxsuOh7K7xEo/mAMEYmPLA2R+L0ubIGaQ15N0HM4oZTI65H2P4c59ulsBI2CgD
         j3dOqGDUJ/3n3nYARaXI2q2oqggFZmpMMm+bAuaYTDLB2+9Ergn8FcvuhvCS/ckzXO
         4shdYloJzqO/zxe/YaIParIhWWGZ+qjAyA/rSz/qOClfdQmUiFX3juP0z/oUVzdovY
         nepeSY01f8pwA==
Date:   Wed, 15 Jun 2022 21:11:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 03/10] tpm, tpm_tis: Disable interrupts if
 tpm_tis_probe_irq() failed
Message-ID: <Yqog6Jp/544X0cbD@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-4-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-4-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:39PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Both functions tpm_tis_probe_irq_single() and tpm_tis_probe_irq() may setup
> the interrupts and then return with an error. This case is indicated by a
> missing TPM_CHIP_FLAG_IRQ flag in chips->flags.
> Currently the interrupt setup is only undone if tpm_tis_probe_irq_single()
> fails. Undo the setup also if tpm_tis_probe_irq() fails.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index ee6b48c55ac9..dee701609b80 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1077,21 +1077,21 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  			goto out_err;
>  		}
>  
> -		if (irq) {
> +		if (irq)
>  			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>  						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> -				dev_err(&chip->dev, FW_BUG
> +		else
> +			tpm_tis_probe_irq(chip, intmask);
> +
> +		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +			dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> -				rc = request_locality(chip, 0);
> -				if (rc < 0)
> -					goto out_err;
> -				disable_interrupts(chip);
> -				release_locality(chip, 0);
> -			}
> -		} else {
> -			tpm_tis_probe_irq(chip, intmask);
> +			rc = request_locality(chip, 0);
> +			if (rc < 0)
> +				goto out_err;
> +			disable_interrupts(chip);
> +			release_locality(chip, 0);
>  		}
>  	}
>  
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
