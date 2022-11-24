Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839963729A
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 07:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKXG7j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 01:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKXG7b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 01:59:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A344AF2C;
        Wed, 23 Nov 2022 22:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B7EB825F3;
        Thu, 24 Nov 2022 06:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758EEC433D6;
        Thu, 24 Nov 2022 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669273121;
        bh=AtMgp6YQ0svYopGMoZzIO5oo1FDIYgBnF1TdUtmlmg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkUZbEu3lHlLXya1ia+KJLXMexRcWeKht5ED8XY5nwxwYQIFZ9Hh54wwAQR5IjRb2
         XuwhStPPYMfyM4NfCsiGthRv1RnFMY3/sew+j0vL8J35s4+6ExBhTvVHsqDXUw+Tx/
         J/AMoBPjglNq8gA+I36SU3vhSd7ffCPZ3ABMRTdymX7GD5oUIrGT7TrGYf6BRBDO+R
         FFdLUVfrv0k0qtAdcirZWFH0x8jJgmQ/obpj7fTeV0zu6qGv692dq5z/JEsQXe0xiU
         YYwkAZg1Q8OvkjRMRUanBmNcW4+3xLGCMoNiaQnq7GYDOgkSkKPKrNzn4BBOVlG3Rd
         0FJp3Ko5cKWHA==
Date:   Thu, 24 Nov 2022 08:58:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v10 04/14] tpm, tpm_tis: Do not skip reset of original
 interrupt vector
Message-ID: <Y38V/7kXkWt9Fhy0@kernel.org>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
 <20221120133134.28926-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120133134.28926-5-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 20, 2022 at 02:31:24PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> If in tpm_tis_probe_irq_single() an error occurs after the original
> interrupt vector has been read, restore the interrupts before the error is
> returned.
> 
> Since the caller does not check the error value, return -1 in any case that
> the TPM_CHIP_FLAG_IRQ flag is not set. Since the return value of function
> tpm_tis_gen_interrupt() is not longer used, make it a void function.
> 
> Fixes: 1107d065fdf1 ("tpm_tis: Introduce intermediate layer for TPM access")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 603b82ca56da..1eac1279594d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -729,7 +729,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
> +static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  {
>  	const char *desc = "attempting to generate an interrupt";
>  	u32 cap2;
> @@ -738,16 +738,14 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  
>  	ret = request_locality(chip, 0);
>  	if (ret < 0)
> -		return ret;
> +		return;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> +		tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);

In a successive patch:

-               tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
+               ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
`

BR, Jarkko 
