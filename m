Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA854CB68
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiFOOdW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiFOOdV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 10:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58D31DD3;
        Wed, 15 Jun 2022 07:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB56660A72;
        Wed, 15 Jun 2022 14:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C656FC34115;
        Wed, 15 Jun 2022 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655303600;
        bh=7vMefsxEfPqWjUU6iDGb+XPXaNa4+dE4KbbW3gPldDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDYlw+oUBUELWeRUl5LKiGAfM7msnH+3xwmVB4M4ptH8YhnZcen1FYcwe+XHTeKf9
         n6GRa/hbttlVV7CmT7r4xiOn1gMoS1afp9T/LvXK/9KnDo7fu50wpvZdYE06kYHrpd
         vXQ5g1Hc9zGyJ/98wQU7SEvYtvR15vk4UvUY3KMI0clwWrA9yoDijvs+IvqDTjzl2d
         dQfIQHhlQRqg6xOSToCP9HaZTWiJ0llRZf+ekMIXHsy2UZZVhAxHDdU1ubxnaNeyK2
         ibzv3ShQYpj/sAgnvnO32KfSYC+AL2tfQckNNQvhBxtLi6U/DAsMsYlUxA+7Dv2Ztc
         Tk5H2aN/co8ZQ==
Date:   Wed, 15 Jun 2022 17:33:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 02/10] tpm, tpm_tis: Claim locality before writing
 TPM_INT_ENABLE register
Message-ID: <YqntrKqWD9mfqJlh@kernel.org>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-3-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:38PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In disable_interrupts() the TPM_GLOBAL_INT_ENABLE bit is unset in the
> TPM_INT_ENABLE register to shut the interrupts off. However modifying the
> register is only possible with a held locality. So claim the locality
> before disable_interrupts() is called.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 6f2cf75add8b..ee6b48c55ac9 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1084,7 +1084,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  				dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> +				rc = request_locality(chip, 0);
> +				if (rc < 0)
> +					goto out_err;
>  				disable_interrupts(chip);
> +				release_locality(chip, 0);
>  			}
>  		} else {
>  			tpm_tis_probe_irq(chip, intmask);
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
