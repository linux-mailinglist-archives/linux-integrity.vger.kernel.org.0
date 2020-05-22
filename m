Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A431DEDF8
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEVRPF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 13:15:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:64859 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbgEVRPE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 13:15:04 -0400
IronPort-SDR: 28T3tujKi3940NK6es/PDXBlXKY+SjupDjuQlzMx4EX506YA6CmOvo3nYlNruw2QDhMLrc1+Bu
 djqj3U5eZgIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 10:14:52 -0700
IronPort-SDR: 6KtMaaIKf3OSwhO1CHA60d8rGhaG7j6u6omYnzsBCYuGXhkMWEHqCe4zh7Chi15nj1s+or54cI
 x2KfgdmmCdkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="255641140"
Received: from omillerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.59])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2020 10:14:49 -0700
Date:   Fri, 22 May 2020 20:14:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
Message-ID: <20200522171451.GD10319@linux.intel.com>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521064743.4769-4-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> Register driver on TEE bus. module tee registers bus,

"on the TEE bus"

"The module tee"

> and module optee calls optee_enumerate_devices() to scan
> all devices on the bus. Trusted Application for this driver

Looking at drivers/tee, it shows that tee and optee are in fact the same
module as opposed to what your commit message says.

> can be Early TA's (can be compiled into optee-os). In that
> case it will be on OPTEE bus before linux booting. Also
> optee-suplicant application is needed to be loaded between
> OPTEE module and ftpm module to maintain functionality
> for fTPM driver.

Why is this needed and why things worked before having this?

> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 69 ++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 22bf553ccf9d..7bb4ce281050 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
>   * Return:
>   *	On success, 0. On failure, -errno.
>   */
> -static int ftpm_tee_probe(struct platform_device *pdev)
> +static int ftpm_tee_probe(struct device *dev)
>  {
>  	int rc;
>  	struct tpm_chip *chip;
> -	struct device *dev = &pdev->dev;
>  	struct ftpm_tee_private *pvt_data = NULL;
>  	struct tee_ioctl_open_session_arg sess_arg;
>  
> @@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> +static int ftpm_plat_tee_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	return ftpm_tee_probe(dev);
> +}
> +
>  /**
>   * ftpm_tee_remove() - remove the TPM device
>   * @pdev: the platform_device description.
> @@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
>   * Return:
>   *	0 always.
>   */
> -static int ftpm_tee_remove(struct platform_device *pdev)
> +static int ftpm_tee_remove(struct device *dev)
>  {
> -	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
>  
>  	/* Release the chip */
>  	tpm_chip_unregister(pvt_data->chip);
> @@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int ftpm_plat_tee_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	return ftpm_tee_remove(dev);
> +}
> +
>  /**
>   * ftpm_tee_shutdown() - shutdown the TPM device
>   * @pdev: the platform_device description.
>   */
> -static void ftpm_tee_shutdown(struct platform_device *pdev)
> +static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
>  {
>  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
>  
> @@ -347,17 +360,53 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
>  
> -static struct platform_driver ftpm_tee_driver = {
> +static struct platform_driver ftpm_tee_plat_driver = {
>  	.driver = {
>  		.name = "ftpm-tee",
>  		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
>  	},
> -	.probe = ftpm_tee_probe,
> -	.remove = ftpm_tee_remove,
> -	.shutdown = ftpm_tee_shutdown,
> +	.shutdown = ftpm_plat_tee_shutdown,
> +	.probe = ftpm_plat_tee_probe,
> +	.remove = ftpm_plat_tee_remove,
> +};
> +
> +static const struct tee_client_device_id optee_ftpm_id_table[] = {
> +	{UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
> +		   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
> +	{}

Please put a comment describing what this is.

>  };
>  
> -module_platform_driver(ftpm_tee_driver);
> +MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
> +
> +static struct tee_client_driver ftpm_tee_driver = {
> +	.id_table	= optee_ftpm_id_table,
> +	.driver		= {
> +		.name		= "optee-ftpm",
> +		.bus		= &tee_bus_type,
> +		.probe		= ftpm_tee_probe,
> +		.remove		= ftpm_tee_remove,
> +	},
> +};
> +
> +static int __init ftpm_mod_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_driver_register(&ftpm_tee_plat_driver);
> +	if (rc)
> +		return rc;
> +
> +	return driver_register(&ftpm_tee_driver.driver);
> +}
> +
> +static void __exit ftpm_mod_exit(void)
> +{
> +	platform_driver_unregister(&ftpm_tee_plat_driver);
> +	driver_unregister(&ftpm_tee_driver.driver);
> +}
> +
> +module_init(ftpm_mod_init);
> +module_exit(ftpm_mod_exit);
>  
>  MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
>  MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
> -- 
> 2.17.1
> 

Wondering if MODULE_AUTHOR() is still equired given that the GIT log
has objectively better log of authorship.

/Jarkko
