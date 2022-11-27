Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BD639BEF
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiK0RTe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0RTc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 12:19:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C5E03A;
        Sun, 27 Nov 2022 09:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC6A60DED;
        Sun, 27 Nov 2022 17:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF88C433D6;
        Sun, 27 Nov 2022 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569570;
        bh=yZ964mW8DiXRoTdrTQmPqfWOXK/x1rcbHg+kfHCB/5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCZLr5oPYTeIyfSeRDcMXJiuKnwPU5Wziubq7WQq05qIvMj/UdJS//W4JrRJASMNS
         jqgWWtLMz38inEuqxUxyAlGsReioQ1bhliHb7XxhgFX9kQkDSujvSDrz/w0hIHs3ig
         6R23MW3CXMaSTreO86R2Gw2VGX5FU0uiwGWGb1qJQdNq6c+ooU84vbFzYozYuHCWtK
         u+y5WaugA18QbK6LXLfzHsNrBQFbhm6QOBpy3zIOzYBHq/3rkeo5fb6g3xN3a50XY8
         82BQSdRyZPqccenOX6vxIStxBM1pWHAxyZIW7uf4kihxPOqfozC7QXM4EGsIPPgnry
         5RBNXeNhqPbWw==
Date:   Sun, 27 Nov 2022 19:19:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tpm: tpm_crb: Add the missed acpi_put_table() to
 fix memory leak
Message-ID: <Y4OcHiLMaVGNkM3E@kernel.org>
References: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
 <1668684222-38457-3-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668684222-38457-3-git-send-email-guohanjun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 17, 2022 at 07:23:41PM +0800, Hanjun Guo wrote:
> In crb_acpi_add(), we get the TPM2 table to retrieve information
> like start method, and then assign them to the priv data, so the
> TPM2 table is not used after the init, should be freed, call
> acpi_put_table() to fix the memory leak.
> 
> Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> Cc: stable@vger.kernel.org
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
