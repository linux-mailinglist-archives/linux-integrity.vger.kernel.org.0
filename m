Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C656CF67C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 00:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC2Wkq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC2Wkp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 18:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87758DF;
        Wed, 29 Mar 2023 15:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2895661E7C;
        Wed, 29 Mar 2023 22:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BD9C433EF;
        Wed, 29 Mar 2023 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680129643;
        bh=r2Bu7SOHZYY6vqkwLuAPr4UshEnubGbGM1rQHHmqeGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmI/TUhkfQJ1NbA3bMrEIa1UXewlgGXwIglRtpY5ZAf1IwpasV7gKTfZshIfkbNxc
         suT9mkz2WlyJpFa7ajsjebqC6EImIQkJUkI2hipatLgCrKjhZTPm3d6xIHXWMJF7Gp
         GcN3YfZH45NHWm+ympobTODC/t2dUnxppDPwW6axEM+mYqbxhfCkZL9VjcxYfhI50T
         9vqrgRUu9xRZSlhnyZ3LkJ6MecH4QTxSRrKUZITzw5GBJr72qJhksxSmef4josT9op
         idPaD4XzGGPIVRd07sEXCazGCmuY8FZjBwTdeZLdeQLopj4KfiXEkNFA9YVyjq2OzI
         TWOU3NUevLYIw==
Date:   Thu, 30 Mar 2023 01:40:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V9 1/3] spi: Add TPM HW flow flag
Message-ID: <20230329224040.5junvjsyqwfcmbyc@kernel.org>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
 <20230325183409.7695-2-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325183409.7695-2-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 26, 2023 at 12:04:07AM +0530, Krishna Yarlagadda wrote:
> TPM specification [1] defines flow control over SPI. Client device can
> insert a wait state on MISO when address is transmitted by controller
> on MOSI. Detecting the wait state in software is only possible for
> full duplex controllers. For controllers that support only half-
> duplex, the wait state detection needs to be implemented in hardware.
> 
> Add a flag SPI_TPM_HW_FLOW for TPM device to set when software flow
> control is not possible and hardware flow control is expected from
> SPI controller.
> 
> Reference:
> [1] https://trustedcomputinggroup.org/resource/pc-client-work-group-
> pc-client-specific-tpm-interface-specification-tis/
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  include/linux/spi/spi.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 873ced6ae4ca..cfe42f8cd7a4 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -184,8 +184,18 @@ struct spi_device {
>  	u8			chip_select;
>  	u8			bits_per_word;
>  	bool			rt;
> -#define SPI_NO_TX	BIT(31)		/* No transmit wire */
> -#define SPI_NO_RX	BIT(30)		/* No receive wire */
> +#define SPI_NO_TX		BIT(31)		/* No transmit wire */
> +#define SPI_NO_RX		BIT(30)		/* No receive wire */
> +	/*
> +	 * TPM specification defines flow control over SPI. Client device
> +	 * can insert a wait state on MISO when address is transmitted by
> +	 * controller on MOSI. Detecting the wait state in software is only
> +	 * possible for full duplex controllers. For controllers that support
> +	 * only half-duplex, the wait state detection needs to be implemented
> +	 * in hardware. TPM devices would set this flag when hardware flow
> +	 * control is expected from SPI controller.
> +	 */
> +#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM HW flow control */
>  	/*
>  	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
>  	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
> @@ -195,7 +205,7 @@ struct spi_device {
>  	 * These bits must not overlap. A static assert check should make sure of that.
>  	 * If adding extra bits, make sure to decrease the bit index below as well.
>  	 */
> -#define SPI_MODE_KERNEL_MASK	(~(BIT(30) - 1))
> +#define SPI_MODE_KERNEL_MASK	(~(BIT(29) - 1))
>  	u32			mode;
>  	int			irq;
>  	void			*controller_state;
> -- 
> 2.17.1
> 


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
