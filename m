Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE04D005F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 14:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiCGNrS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 08:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbiCGNrR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 08:47:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E58C7D0;
        Mon,  7 Mar 2022 05:46:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D048B81240;
        Mon,  7 Mar 2022 13:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8768BC340E9;
        Mon,  7 Mar 2022 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646660779;
        bh=lS/OPCoHfVOEsXyzTtf0B3Ua3GfsuGvGlHz7Xory8S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7U0s8PZ98rV142USqp5u6HkvXsUGgwidIdoY3fNfGQ8VjyBfWQWPX8d0+jCDWMin
         tTod77LhMhL5BNjtLdDsZIIfTQW4tLrENCsiIgFeClpAzXZZzVs1PnekE4UeYY5Ggv
         hWs92B6NyHq4VtHClvf/GVl22alXmOP+yB58BwbIiqrlVEHE7Yf7fBBeX5flcNQ9bz
         tfB5wva4blFQHOOKEB+rixyYXzTk8/j9Tpxoh8NscjvTKW+Na/sUdPsvx6Mas0tJd2
         gv2ZuFx474+4yDhci/z86WN85FRlBHUUeUGJSZseUftpJYNQGyGO10AHEvbFelAglU
         Je9mOFVRYQHHQ==
Date:   Mon, 7 Mar 2022 15:45:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, weiyongjun1@huawei.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Message-ID: <YiYMgnpnf3Y6l8IY@iki.fi>
References: <20220307104827.40843-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307104827.40843-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
> Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
> call put_device on error, while tpm->devs is left untouched. Call
> put_device on tpm->devs as well if devm_add_action_or_reset returns an
> error.
> 
> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index b009e7479b70..0a92334e8c40 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
>  	return 0;
>  }
>  
> +static void tpm_chip_free(struct tpm_chip *chip)
> +{
> +	put_device(&chip->devs);
> +	put_device(&chip->dev);
> +}
> +
>  /**
>   * tpm_chip_alloc() - allocate a new struct tpm_chip instance
>   * @pdev: device to which the chip is associated
> @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	return chip;
>  
>  out:
> -	put_device(&chip->devs);
> -	put_device(&chip->dev);
> +	tpm_chip_free(chip);
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_alloc);
> @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  		return chip;
>  
>  	rc = devm_add_action_or_reset(pdev,
> -				      (void (*)(void *)) put_device,
> -				      &chip->dev);
> +				      (void (*)(void *)) tpm_chip_free,
> +				      chip);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -- 
> 2.17.1
> 

Please test against the latest in

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

and share your results.

BR, Jarkko
