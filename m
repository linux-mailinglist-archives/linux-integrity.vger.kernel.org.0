Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A562AFAF
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKOXwS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKOXwR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:52:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FED2FF
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 15:52:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACA2617E4
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 23:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532C4C433D6;
        Tue, 15 Nov 2022 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556334;
        bh=im1NapafqKVB7hz1Aa3k/EPFsIe1vHuWpfXjqSBe8Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1zCL6y7tUdH/hg1gR3yhGYlajpXPlxEoCI1Aq0kaWUIvmPP1BLOdYwFelZGSvUoh
         S96gZIUVH7o3kf4yAOED0tmus7gi4qlhx3FSkVvIpxrMysdtCSOLPMSnX+jielaXP8
         uIMxS4no4GZL0A58r8kCZErDtaM5rElAg+U8OO2fQxZDx7ndKPaCVLsJt897uzQlO/
         0/qNIgnHx7DDA4omG14+NB+Wzz4vCBr/5WJ88MAfBe0a+JPq49FhkFw1yDZHoUjY8E
         xalzTCxrhmtiSTut/JCvRS52gzfmLn5fb43sZwHD7vEG8OA5lqFgHBjV5cAMqyfKBC
         0tfG9E6xoY5cQ==
Date:   Wed, 16 Nov 2022 01:52:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 2/3] tpm: tpm_crb: Add the missed acpi_put_table() to fix
 memory leak
Message-ID: <Y3QmKyVPCLDuYwSH@kernel.org>
References: <1667966622-19711-1-git-send-email-guohanjun@huawei.com>
 <1667966622-19711-3-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667966622-19711-3-git-send-email-guohanjun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 09, 2022 at 12:03:41PM +0800, Hanjun Guo wrote:
> In crb_acpi_add(), we get the TPM2 table to retrieve information
> like start method, and then assign them to the priv data, so the
> TPM2 table is not used after the init, should be freed, call
> acpi_put_table() to fix the memory leak.
> 
> Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 1860665..5bfb00f 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -676,12 +676,16 @@ static int crb_acpi_add(struct acpi_device *device)
>  
>  	/* Should the FIFO driver handle this? */
>  	sm = buf->start_method;
> -	if (sm == ACPI_TPM2_MEMORY_MAPPED)
> -		return -ENODEV;
> +	if (sm == ACPI_TPM2_MEMORY_MAPPED) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
>  
>  	priv = devm_kzalloc(dev, sizeof(struct crb_priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	if (!priv) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
>  	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
>  		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
> @@ -689,7 +693,8 @@ static int crb_acpi_add(struct acpi_device *device)
>  				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
>  				buf->header.length,
>  				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto out;
>  		}
>  		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
>  		priv->smc_func_id = crb_smc->smc_func_id;
> @@ -700,17 +705,23 @@ static int crb_acpi_add(struct acpi_device *device)
>  
>  	rc = crb_map_io(device, priv, buf);
>  	if (rc)
> -		return rc;
> +		goto out;
>  
>  	chip = tpmm_chip_alloc(dev, &tpm_crb);
> -	if (IS_ERR(chip))
> -		return PTR_ERR(chip);
> +	if (IS_ERR(chip)) {
> +		rc = PTR_ERR(chip);
> +		goto out;
> +	}
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  	chip->acpi_dev_handle = device->handle;
>  	chip->flags = TPM_CHIP_FLAG_TPM2;
>  
> -	return tpm_chip_register(chip);
> +	rc = tpm_chip_register(chip);
> +
> +out:
> +	acpi_put_table((struct acpi_table_header *)buf);
> +	return rc;
>  }
>  
>  static int crb_acpi_remove(struct acpi_device *device)
> -- 
> 1.7.12.4
> 

Same comments apply, as for the first patch.

BR, Jarkko
