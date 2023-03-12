Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8246B62C3
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Mar 2023 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCLBxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 20:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLBxs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 20:53:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C92BEC4;
        Sat, 11 Mar 2023 17:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE01AB801BC;
        Sun, 12 Mar 2023 01:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A05C433D2;
        Sun, 12 Mar 2023 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678586021;
        bh=Jr0TCWVtnr0wBrUGBTPMCwE+/Ah/WegiwRPHWL99yMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYyUbr+32tE2RrqBnLB+bpDR6Q9QOhqR7CEzoFI0XvBcjDFncwq+ZIadNNVU3g+G7
         yJJ8kwQuacbJe7xj7qV8IWgQoO1spRcZjvrOAHZzE/stRECRaeOvFTkxv+oc3jdkjD
         5mQ200xt4G48oWMsGXPo7G9qYP93kNKxbpKMjSWSKVUlMARH0kP7sqdwW/ZrSJqQDA
         U4WOU0mVvUZfybA3maiB2kablrVvXzpOOQo/XuAbuXT9cR8vLiIGvMX5NYJFwqlSaa
         PgjjKZT+JzB/Y6pH5IqEzOq48gXVj4TxqOEnbTAuLroEpnO5SwIdAmO3CyQenmjPBM
         HlxzOLn1eds6Q==
Date:   Sun, 12 Mar 2023 03:53:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_tis_spi: Mark ACPI and OF related data as
 maybe unused
Message-ID: <ZA0wor67TlOdBOs/@kernel.org>
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
 <20230311173541.262949-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173541.262949-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:41PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> unused:
> 
>   drivers/char/tpm/tpm_tis_spi_main.c:234:34: error: ‘of_tis_spi_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..1f5207974a17 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -231,7 +231,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
>  
> -static const struct of_device_id of_tis_spi_match[] = {
> +static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
>  	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
>  	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
>  	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
> @@ -240,7 +240,7 @@ static const struct of_device_id of_tis_spi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_spi_match);
>  
> -static const struct acpi_device_id acpi_tis_spi_match[] = {
> +static const struct acpi_device_id acpi_tis_spi_match[] __maybe_unused = {
>  	{"SMO0768", 0},
>  	{}
>  };
> -- 
> 2.34.1
> 

Ditto.

BR, Jarkko
