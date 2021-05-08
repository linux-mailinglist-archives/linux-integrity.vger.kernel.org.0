Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD8376E53
	for <lists+linux-integrity@lfdr.de>; Sat,  8 May 2021 04:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhEHCCz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 22:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhEHCCy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 22:02:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC740611CA;
        Sat,  8 May 2021 02:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620439314;
        bh=2Ed/Cd2G9iaVVcr9VK9H7/YA80GAkjazsqK7Fk6/HY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGLHX2pFRuP4G8/+GTibOTHKjl/DdDRn6K9TeRZM+crrMI+9NZTlP2gY4WFETexpc
         X/JovFmdCiw00sF2a4ARDKkdKoShTk5BuOHnxnCeDKZv7JD5qLtBSXcQekOv3Jwo9h
         MHoWQYcJryyG+7wrj2kymuseI6v8mJZB6VuZqMCgb/tPh91iieCymQXF8TrovjW7JJ
         qoK+GDm9NmdlwFnv3Ei/CSfO5JFMaUfCfTo0wO1xRkKvU4zTcZRDIq4rPpwOv0FCaE
         GEWvzLwXn0b+RSu2BVOhpMzPulmln9NqP6/4SmvqaU5YokTyr0A0khAnWXK3EODBWO
         fN+EgDI+5cPvA==
Date:   Sat, 8 May 2021 05:01:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: set default probe function if device id not
 match
Message-ID: <YJXxDzougt3ZC01q@kernel.org>
References: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 07, 2021 at 10:52:55PM +0800, Liguang Zhang wrote:
> In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
> kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
> causes device probe fails. In order to make newer kernel to be
> compatible with the older acpi definition, it would be best set default
> probe function.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 3856f6ebcb34..da632a582621 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>  	tpm_tis_spi_probe_func probe_func;
>  
>  	probe_func = of_device_get_match_data(&spi->dev);
> -	if (!probe_func && spi_dev_id)
> -		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> -	if (!probe_func)
> -		return -ENODEV;
> +	if (!probe_func) {
> +		if (spi_dev_id) {
> +			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> +			if (!probe_func)
> +				return -ENODEV;

Perhaps also hear fallback to tpm_tis_spi_probe?

> +		} else
> +			probe_func = tpm_tis_spi_probe;
> +	}
>  
>  	return probe_func(spi);
>  }
> -- 
> 2.19.1.6.gb485710b
> 
> 

/Jarkko
