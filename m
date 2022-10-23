Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9230660912B
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 06:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJWEdq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 00:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJWEdp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 00:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893D785A9;
        Sat, 22 Oct 2022 21:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B38B60023;
        Sun, 23 Oct 2022 04:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86281C433C1;
        Sun, 23 Oct 2022 04:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666499621;
        bh=yVmCehrys/VM8FyWaDMdaRcKpIpUE20oqYBea8J+z/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0Tt76XCalm79uabTsTv4PwMli3Mwt2SZVrRiPJcNw1qFE23D9b1JeysMhXFOAUQP
         duem4KAClU6sPc18It4SDJNCmgPdALVtg/dbmZ7u/0RH/HBcMF5oQlxqKELAOfgkN4
         RXGN2z6kyGrMO81I9UesLh2it4SiTuRKY2okX7KWYPhma6y5Jq51hld24hx+sy6l2W
         yxOs8cssxb9o/TsiIfoQ5cCbwLt6Gb6olFRppW+tI6zxdLtsDHy+QJ0mH7hJ4d+6Ss
         iuCZG6oRp7xynMFvLLX9TBO8tdvn5lnNE3/UpDxgzUgsxV3dCDjw6IoHYbKYnJcwpn
         rhdcPvte55ULA==
Date:   Sun, 23 Oct 2022 07:33:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 11/11] tpm, tpm_tis: Enable interrupt test
Message-ID: <Y1TEHy74MN4a+VfO@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-12-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017235732.10145-12-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 01:57:32AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The test for interrupts in tpm_tis_send() is skipped if the flag
> TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> initially the test is never executed.
> 
> Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> interrupts have been enabled and before the test is executed.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niewöhner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 42f628e52cde..9778860e1598 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -793,11 +793,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	if (ret < 0)
>  		return ret;
>  
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>  	else
>  		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>  
> +	if (ret)
> +		chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +
>  	tpm_tis_release_locality(chip, 0);
>  
>  	return ret;
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
