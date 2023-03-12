Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6076B62C0
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Mar 2023 02:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCLBxe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCLBxd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 20:53:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C224CA2;
        Sat, 11 Mar 2023 17:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE929B8074A;
        Sun, 12 Mar 2023 01:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF0C433EF;
        Sun, 12 Mar 2023 01:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678586008;
        bh=kJm4BkrdUcAyJ4jnkbQ4vmpEhnABwg6iqdQUrU/r1cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fx9CXkPUWBlOhshwZk5mWclBYJpNCw5EVdybFoA14XRgJynjOpB7jek4+g28Ry8oO
         4dV1Jmy8umDUcQSbxUqdxpTR1iKa00O5FX6Oy0D/g1EFG8d4NnBmGWdmfc0E3LPpuY
         Xx+WzuzRgwGLk1nYF7OkdfAOJ1jnIwWlI3al1ApolmQLNwKhjJBRLvf81S/fuPDdHW
         DVI5VrRkjtJgrG4k3N6lHXOChYpNRgw5zpqvKMQDB+TR8JVlv7BItPKMRaoRloHFEt
         rmTqKd63C4CQdlwtO528gDKyiqbpJhIy++YqbgxqmQ+/+67MwsY9uDNbITP0vb2L1F
         q+sOx7QqV4hWw==
Date:   Sun, 12 Mar 2023 03:53:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: st33zp24: Mark ACPI and OF related data as
 maybe unused
Message-ID: <ZA0wlYIh3KRV/QjW@kernel.org>
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:40PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> 
>   drivers/char/tpm/st33zp24/i2c.c:141:34: error: ‘of_st33zp24_i2c_match’ defined but not used [-Werror=unused-const-variable=]
>   drivers/char/tpm/st33zp24/spi.c:258:34: error: ‘of_st33zp24_spi_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Please also briefly describe the change.

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

BR, Jarkko
