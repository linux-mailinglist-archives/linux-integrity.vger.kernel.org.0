Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382C6C13EE
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCTNtR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTNtR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 09:49:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623D19A7;
        Mon, 20 Mar 2023 06:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 920F9B80E8D;
        Mon, 20 Mar 2023 13:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01961C4339B;
        Mon, 20 Mar 2023 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320153;
        bh=VmTUm29g5fQJPCFkHOsQO97gEWW99IjKMVbBlfj6YX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmcKMQhxEKcBKSlnbH2T4ohyXCCjpzDmCqKWiTSs6x8tT+90SSTGOixouiWziZzgJ
         vA08B9kbWilbhQhdkVtaheAZnq4hLQCEZKG35Xj1kVrd8z5U3oJ0bSQvnsFvCpV/kS
         /9E11NH4egkYPND9gl/jlpAemq7JfC1BqXcZKX98eoZgIsigu75cc7Simu2KV0y8EX
         Xo9sj1mRrMuaGtj1W/q7jr0QH9y4MUqdda1fMHS8i4mIr61oSxniRdUp/whDZVwlvm
         gnIUdg5TSL1nw2ubWBlYpZ8IFLiIbsrN1WoaUY5gk5tBi0etuiVlt4f2DyntpJLpsz
         ejNU5zIefsvpw==
Date:   Mon, 20 Mar 2023 15:49:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: st33zp24: Mark ACPI and OF related data as
 maybe unused
Message-ID: <20230320134909.kzemkumkibiu7bwe@kernel.org>
References: <20230319141354.22907-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319141354.22907-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 19, 2023 at 03:13:53PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> unused.  This fixes compile tests with W=1 by annotating device ID table
> as possibly unused:
> 
>   drivers/char/tpm/st33zp24/i2c.c:141:34: error: ‘of_st33zp24_i2c_match’ defined but not used [-Werror=unused-const-variable=]
>   drivers/char/tpm/st33zp24/spi.c:258:34: error: ‘of_st33zp24_spi_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Enhance commit msg.
> ---
>  drivers/char/tpm/st33zp24/i2c.c | 4 ++--
>  drivers/char/tpm/st33zp24/spi.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index c4d0b744e3cc..2d28f55ef490 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -138,13 +138,13 @@ static const struct i2c_device_id st33zp24_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
>  
> -static const struct of_device_id of_st33zp24_i2c_match[] = {
> +static const struct of_device_id of_st33zp24_i2c_match[] __maybe_unused = {
>  	{ .compatible = "st,st33zp24-i2c", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_st33zp24_i2c_match);
>  
> -static const struct acpi_device_id st33zp24_i2c_acpi_match[] = {
> +static const struct acpi_device_id st33zp24_i2c_acpi_match[] __maybe_unused = {
>  	{"SMO3324"},
>  	{}
>  };
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index 2154059f0235..f5811b301d3b 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -255,13 +255,13 @@ static const struct spi_device_id st33zp24_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, st33zp24_spi_id);
>  
> -static const struct of_device_id of_st33zp24_spi_match[] = {
> +static const struct of_device_id of_st33zp24_spi_match[] __maybe_unused = {
>  	{ .compatible = "st,st33zp24-spi", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_st33zp24_spi_match);
>  
> -static const struct acpi_device_id st33zp24_spi_acpi_match[] = {
> +static const struct acpi_device_id st33zp24_spi_acpi_match[] __maybe_unused = {
>  	{"SMO3324"},
>  	{}
>  };
> -- 
> 2.34.1
> 

To both:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


