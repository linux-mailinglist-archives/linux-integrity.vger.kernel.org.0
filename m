Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF1639EDF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiK1BYI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK1BXv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:23:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB01115D
        for <linux-integrity@vger.kernel.org>; Sun, 27 Nov 2022 17:23:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 662D3B80C80
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 01:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D4C433D6;
        Mon, 28 Nov 2022 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669598601;
        bh=ohaOchr+nD3M4m8e69lVn2snnKtlwtUwGtBEvS/rNXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/nDsTvfLMzzLzYZnt8v8HoIPhDKtWUeGayKxpNOnSr7VhomSVGZuoRO0Dwi70qDR
         4oDdG+G2IejDK2AZAzOk8h6YcAMXwQrIbxm23/mYhytU/k5AL4+0F+uzCCsa+wso5G
         oWH7irhKIAg86GjZtDJwfkpkZdlQGbAPSaslcvyS+jV+dhr+3QqvqZUz94bAcLvH7J
         2DeYsom7PWLSR/UQAdsL9sCmLClizMgvJ+VM+vC9ImKNH5OqQW4HueP4TXQRI1Rol3
         vcvsO50frnk6lJGyfAojJub7wWRAeUI8bzXrPePIapMZd1CFpYOzBpRJVJXdLMolkY
         cjQAldTmH3Gew==
Date:   Mon, 28 Nov 2022 03:23:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, maxim.uvarov@linaro.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix error handling in ftpm_mod_init()
Message-ID: <Y4QNhBTwC9M9hXm4@kernel.org>
References: <20221124031926.16963-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124031926.16963-1-yuancan@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 24, 2022 at 03:19:26AM +0000, Yuan Can wrote:
> The ftpm_mod_init() returns the driver_register() directly without checking
> its return value, if driver_register() failed, the ftpm_tee_plat_driver is
> not unregistered.
> 
> Fix by unregister ftpm_tee_plat_driver when driver_register() failed.
> 
> Fixes: 9f1944c23c8c ("tpm_ftpm_tee: register driver on TEE bus")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 5c233423c56f..deff23bb54bf 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -397,7 +397,13 @@ static int __init ftpm_mod_init(void)
>  	if (rc)
>  		return rc;
>  
> -	return driver_register(&ftpm_tee_driver.driver);
> +	rc = driver_register(&ftpm_tee_driver.driver);
> +	if (rc) {
> +		platform_driver_unregister(&ftpm_tee_plat_driver);
> +		return rc;
> +	}
> +
> +	return 0;
>  }
>  
>  static void __exit ftpm_mod_exit(void)
> -- 
> 2.17.1
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
