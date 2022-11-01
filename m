Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344676142B2
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKABLA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiKABK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2450DEE0C;
        Mon, 31 Oct 2022 18:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5C161519;
        Tue,  1 Nov 2022 01:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85917C433D6;
        Tue,  1 Nov 2022 01:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265057;
        bh=E9tDPlGMSYHBswA14cGsgL7Le44ZO8NaHmzcY0vJyLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNFHHJxv33E3jdaoc4X76QzbquSIC4hiENGXQ/LA/Xas6x7QSi6RfRgDYtwpwG262
         56EXGdrlEdQBtmvaufWlcyIs03CnlLhuzj1l/GcMFaOPqqWAazBbYSbJPNH+xYN/+/
         jynB3NxQ8E5ekYtTpdo6QtRKwaOZvI8WbENoT9ip486qVVcwG70W/lEQy/jSJy05An
         rcVQIXGIjqQbwPo0mQwYgkMghIuDHdx6rX27WVjbNTUZbxKfeEMuY4V+tbdTM4A9mD
         RFbZrb3fRF7EpdkF/ge4b/tvDfS7ubAllThpSJ9BgpgQwhg4/nbRXfE/gX8pWM6av1
         VapLKCB5BnAFg==
Date:   Tue, 1 Nov 2022 03:10:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] tpm: st33zp24: remove pointless checks on probe
Message-ID: <Y2ByHKkX8mHJK7EL@kernel.org>
References: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
 <20221027071349.991730-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027071349.991730-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 27, 2022 at 12:13:49AM -0700, Dmitry Torokhov wrote:
> Remove tests for SPI device or I2C client to be non-NULL because
> driver core will never call driver's probe method without having
> a valid device structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v3: no changes
> v2: reworked commit message
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
> index 25b0e7994d27..c249d3f964fd 100644
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
> 2.38.0.135.g90850a2211-goog
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
