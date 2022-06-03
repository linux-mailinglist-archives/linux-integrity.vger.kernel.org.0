Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CF53C3BF
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiFCE2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 00:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiFCE2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 00:28:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EC65F4;
        Thu,  2 Jun 2022 21:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84406B821C5;
        Fri,  3 Jun 2022 04:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1501C385A9;
        Fri,  3 Jun 2022 04:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654230516;
        bh=TDep2ZD1xO4DJlmrgaXkqq3uZa8dLlF0VXlkv4ea818=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFX3ysr0QVzY8bYj5xpxjrpgo60nRcssK4/JQrZk902y8kqmGGCj5Y7X6vUqStEQz
         RBZ9qe7ukTr/yHosA2xX+kV/+2ww5PLiXJbrcSxpmR1kRX1E6SKUiWrAosXoIwmwgk
         gg4+mF875B9oA7Q1T2Jo4O57VxotQpOYQMrbF5T+cLsmPabJVASijE0qxeN8PbB6GX
         Vu2cWlzDvDXzT1tWRgO6dE03dkRlsgEg3IkLAOKsn4gpRs0qM8b7H3KYoHes2Ob/I/
         pMG5J6A09wbD0CsTW1NYqcTiYP1Ef2gBj0A9CyubymnKZcYaDwvhbJU+K9lyDJbK0h
         v1zqESOhu3T4w==
Date:   Fri, 3 Jun 2022 07:26:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v2] tpm: Add upgrade/reduced mode support for TPM1.2
 modules
Message-ID: <YpmNg+SNxFa4d8ml@iki.fi>
References: <20220602161301.4281-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602161301.4281-1-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 02, 2022 at 06:13:01PM +0200, Stefan Mahnke-Hartmann wrote:
> In case a TPM in failure mode is detected, the TPM should be accessible
> through a transparent communication channel for analysing purposes (e.g.
> TPM_GetTestResult) or a field upgrade. Since a TPM in failure mode has
> similar reduced functionality as in field upgrade mode, the flag
> TPM_CHIP_FLAG_FIRMWARE_UPGRADE is also valid.
> 
> As described in TCG TPM Main Part1 Design Principles, Revision 116,
> chapter 9.2.1. the TPM also allows an update function in case a TPM is
> in failure mode.
> 
> If the TPM in failure mode is detected, the function tpm1_auto_startup()
> sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE flag, which is used later during
> driver initialization/deinitialization to disable functionality which
> makes no sense or will fail in the current TPM state. The following
> functionality is affected:
>  * Do not register TPM as a hwrng
>  * Do not get pcr allocation
>  * Do not register sysfs entries which provide information impossible to
>    obtain in limited mode
> 
> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
> Changelog:
>  * v2:
>    * Commit message updated.
>    * Error handling for failed self test and other errors seperated.
> .
>  drivers/char/tpm/tpm.h      | 1 +
>  drivers/char/tpm/tpm1-cmd.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2163c6ee0d36..c0778498bc41 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -56,6 +56,7 @@ enum tpm_addr {
>  #define TPM_ERR_DEACTIVATED     0x6
>  #define TPM_ERR_DISABLED        0x7
>  #define TPM_ERR_INVALID_POSTINIT 38
> +#define TPM_ERR_FAILEDSELFTEST  0x1C
>  
>  #define TPM_TAG_RQU_COMMAND 193
>  
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index f7dc986fa4a0..fe21679ba0b6 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -709,8 +709,13 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  	if (rc)
>  		goto out;
>  	rc = tpm1_do_selftest(chip);
> -	if (rc) {
> -		dev_err(&chip->dev, "TPM self test failed\n");
> +	if (rc == TPM_ERR_FAILEDSELFTEST) {
> +		dev_err(&chip->dev, "TPM self test failed, so the TPM has limited functionality\n");

Given that returning to a legit state, as far as driver is concerned,
i.e. firmware upgrade mode, I would use the following warn here instead:

dev_warn(&chip->dev, "TPM self test failed, switching to the firmware upgrade mode\n");

It's a success state because you are returning zero.


> +		/* A TPM in this state possibly allows or needs a firmware upgrade */
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> +		return 0;
> +	} else if (rc) {
> +		dev_err(&chip->dev, "TPM self test not successful\n");

Why did you change the error message?

>  		goto out;
>  	}
>  
> -- 
> 2.25.1
> 

BR, Jarkko
