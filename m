Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26EC3D6C55
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhG0C1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234516AbhG0C1x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:27:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F7BA60FEE;
        Tue, 27 Jul 2021 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627355301;
        bh=4JcmYf9yQOk4SGrGEp1jDRemvLHZJ4SNBZt4xnH8nCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3mnfYhcP52GEd8Y8HdttjQGCzfzhFQiop1ajcThX5zzF1MaK5MBMeGtL4gQjJ2S8
         Oq1mksbp0uux3rl3KFNc+r3Y4gsz4qjad0LTMdtb2AmmTACengmXjQThWN4GF7TcJT
         0mBth4wFewcgBUYh6DEi0/n0bBiNg2dLV+vqvwf3ngbFw7fKaczpFhMg3srjozaw1m
         GK4lagUiYtUb0uvJ2fYsmLHYgo0vNImn0TjaPyC/MgmMl36jKQm075NkyR88Gs0K6h
         E19B5JgTvBQDFss02bleGn8Us3i7xKS8jx8E3XKHBZvcsvyE7clcO8RM6O/IzOIKIk
         Ugdor2kMovcNg==
Date:   Tue, 27 Jul 2021 06:08:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/2] char: tpm: cr50_i2c: convert to new probe interface
Message-ID: <20210727030818.m5opmt7h2r4boh7s@kernel.org>
References: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
 <20210723184150.2596604-2-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723184150.2596604-2-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 23, 2021 at 09:41:50PM +0300, Adrian Ratiu wrote:
> Way back when this driver was written the i2c framework

Nit: I2C (not i2c)

> used to insist an ID table be defined even if the driver
> did not use it in favor of ACPI/OF matching, so it was
> added just to placate the hard i2c framework requirement.

Ditto.

> This is no longer the case so we can drop the table and
> also convert the driver to the new probe interface.
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index 44dde2fbe2fb..c89278103703 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -639,12 +639,6 @@ static const struct tpm_class_ops cr50_i2c = {
>  	.req_canceled = &tpm_cr50_i2c_req_canceled,
>  };
>  
> -static const struct i2c_device_id cr50_i2c_table[] = {
> -	{"cr50_i2c", 0},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, cr50_i2c_table);
> -
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cr50_i2c_acpi_id[] = {
>  	{ "GOOG0005", 0 },
> @@ -670,8 +664,7 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
>   * - 0:		Success.
>   * - -errno:	A POSIX error code.
>   */
> -static int tpm_cr50_i2c_probe(struct i2c_client *client,
> -			      const struct i2c_device_id *id)
> +static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  {
>  	struct tpm_i2c_cr50_priv_data *priv;
>  	struct device *dev = &client->dev;
> @@ -774,8 +767,7 @@ static int tpm_cr50_i2c_remove(struct i2c_client *client)
>  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
>  
>  static struct i2c_driver cr50_i2c_driver = {
> -	.id_table = cr50_i2c_table,
> -	.probe = tpm_cr50_i2c_probe,
> +	.probe_new = tpm_cr50_i2c_probe,
>  	.remove = tpm_cr50_i2c_remove,
>  	.driver = {
>  		.name = "cr50_i2c",
> -- 
> 2.32.0
> 
> 

Otherwise, LGTM

/Jarkko
