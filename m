Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60365F4BA1
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 00:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiJDWKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiJDWKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 18:10:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8885A82A;
        Tue,  4 Oct 2022 15:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D073AB819BB;
        Tue,  4 Oct 2022 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3044DC433D6;
        Tue,  4 Oct 2022 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664921409;
        bh=4CHXrVC/Q/65wJkINb6iDLY9xkcKh4155g97IujP8NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QN/kJREdrq7GoWnL8ZLADMrzC2AtJBxqhRJsO3E/7G4nIKUz4wxhVItiT8wG8kcCU
         sYiTY3kYmJllj764Ge93pjulnDC/7FHrwCbmUBq4l8L5o+fvqLsonjA7HPGJSZHjdC
         P+0TssUOaw0uhRYOCDEtOLANT2bs1hjSeXDr9G9n2HnCr5apR3Hcbc6mWhwTEQWGgb
         EiersK6QXNhXi9hgI09UY3zkfDvH//pTfrReoxXkArFReJiDKYLOtGcCgYngzYDUKh
         2sVUddHaR5Dc3XgjefpZOPTaUs5AlWdr66lE8lIeG245zvACbGELdu4Sk8SGsInKmo
         Kx2hkgjcxsPyA==
Date:   Wed, 5 Oct 2022 01:10:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tpm: st33zp24: drop support for platform data
Message-ID: <YzyvPq/VYiuvz6LS@kernel.org>
References: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 10:51:40PM -0700, Dmitry Torokhov wrote:
> Drop support for platform data from the driver because there are no
> users of st33zp24_platform_data structure in the mainline kernel.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> -		.name = TPM_ST33_SPI,
> +		.name = "st33zp24-spi",
>  		.pm = &st33zp24_spi_ops,
>  		.of_match_table = of_match_ptr(of_st33zp24_spi_match),
>  		.acpi_match_table = ACPI_PTR(st33zp24_spi_acpi_match),
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
> index b387a476c555..6a26dbc3206b 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.h
> +++ b/drivers/char/tpm/st33zp24/st33zp24.h
> @@ -7,6 +7,9 @@
>  #ifndef __LOCAL_ST33ZP24_H__
>  #define __LOCAL_ST33ZP24_H__
>  
> +#define TPM_ST33_I2C		"st33zp24-i2c"
> +#define TPM_ST33_SPI		"st33zp24-spi"
> +
>  #define TPM_WRITE_DIRECTION	0x80
>  #define ST33ZP24_BUFSIZE	2048

Sorry I missed this. Why don't you use TPM_ST33_SPI constant above
since you are anyway re-defining it?

BR, Jarkko
