Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318D646DB9
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Dec 2022 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLHLAi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Dec 2022 06:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLHLAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DFD6B;
        Thu,  8 Dec 2022 02:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FE461DE5;
        Thu,  8 Dec 2022 10:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67D5C433D6;
        Thu,  8 Dec 2022 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670496933;
        bh=iYeAEc4ZLYi0xIdQc68SWywlFEDmr+ZGN4S15o+/kgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/BSybCYR2Tu0ZEx+VCukVwHkkaLchDzgGRZj2JKU3nkzKGVVwzGD+/inbJb+c2hd
         Df5q7VL7eP/DSIVqxcCwNRkejqpzlv8PwGs7A3I+maLFu+b8807nKHtmj9Y8whtOaV
         gUE0kQwg3JXjGjxLlkgu/YQ7RDH8vucLI/Mu95lDLnxTct2fVAvmtzPm+e2DNnUTpw
         FN6ODNTVugf31y8OgMjJYZEmx+DLrTl3ToqXuer0ywymq1E5HFIUjNmYxVbm2L5+8h
         98OWoFlNv1F2JRCCCDO4QnN7YODjB2XkdP92CFnxGTWnxYuKzw+Wd8K1F/8X27DmSA
         iHtFg2/gnMAiA==
Date:   Thu, 8 Dec 2022 10:55:29 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] tpm: st33zp24: remove pointless checks on probe
Message-ID: <Y5HCoRxYxES0hiFd@kernel.org>
References: <Y4/wGWTgYfR/Jb9D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4/wGWTgYfR/Jb9D@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 06, 2022 at 05:44:57PM -0800, Dmitry Torokhov wrote:
> Remove tests for SPI device or I2C client to be non-NULL because
> driver core will never call driver's probe method without having
> a valid device structure.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v3: no changes
> v2: reworked commit message
> 
> This was a part of a 3-patch series, the first 2 dealt with dropping
> support for platform data and converting the driver to gpiod API, and
> were applied, this one got reviewed-by from Jarkko but for some reason
> was left out.
> 
>  drivers/char/tpm/st33zp24/i2c.c | 6 ------
>  drivers/char/tpm/st33zp24/spi.c | 7 -------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index 614c7d8ed84f..8156bb2af78c 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -106,12 +106,6 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
>  {
>  	struct st33zp24_i2c_phy *phy;
>  
> -	if (!client) {
> -		pr_info("%s: i2c client is NULL. Device not accessible.\n",
> -			__func__);
> -		return -ENODEV;
> -	}
> -
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		dev_info(&client->dev, "client not i2c capable\n");
>  		return -ENODEV;
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index ff4adbe104cf..2154059f0235 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -223,13 +223,6 @@ static int st33zp24_spi_probe(struct spi_device *dev)
>  {
>  	struct st33zp24_spi_phy *phy;
>  
> -	/* Check SPI platform functionnalities */
> -	if (!dev) {
> -		pr_info("%s: dev is NULL. Device is not accessible.\n",
> -			__func__);
> -		return -ENODEV;
> -	}
> -
>  	phy = devm_kzalloc(&dev->dev, sizeof(struct st33zp24_spi_phy),
>  			   GFP_KERNEL);
>  	if (!phy)
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
> 
> -- 
> Dmitry

Thanks, applied.

BR, Jarkko
