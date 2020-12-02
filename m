Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA262CC30A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgLBRHk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Dec 2020 12:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgLBRHk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Dec 2020 12:07:40 -0500
Date:   Wed, 2 Dec 2020 19:06:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606928818;
        bh=erzBmx7mDxpVxZlbI/ey56oFt86ALNg3K4J7JVsrYe4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9E8/rPz9CHXmX5f9N9BnYhpungErfM7FuTCpxq0/ldpVvn8xjMIifUuJzUNklqGP
         jvnChIGCrThPQyWmtil4E+SwMdCr1Upj5jBVzYtgqHSCeBuXV2QXQaZXTHvgqnGWxO
         PmEFcSIvBBG1vt1oHORqOuiyAfmJURnq+yeOWQXo=
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        benh@kernel.crashing.org, paulus@samba.org,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] drivers: char: tpm: remove unneeded MODULE_VERSION()
 usage
Message-ID: <20201202170653.GA91741@kernel.org>
References: <20201202121553.9383-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202121553.9383-1-info@metux.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 02, 2020 at 01:15:53PM +0100, Enrico Weigelt, metux IT consult wrote:
> Remove MODULE_VERSION(), as it isn't needed at all: the only version
> making sense is the kernel version.

Kernel version neither does make sense here. Why are mentioning it
in the commit message? Please just derive the commit message from
the one that Greg wrote.

> Link: https://lkml.org/lkml/2017/11/22/480
>

Remove the spurious empty line.

> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/char/tpm/st33zp24/i2c.c      | 1 -
>  drivers/char/tpm/st33zp24/spi.c      | 1 -
>  drivers/char/tpm/st33zp24/st33zp24.c | 1 -
>  drivers/char/tpm/tpm-interface.c     | 1 -
>  drivers/char/tpm/tpm_atmel.c         | 1 -
>  drivers/char/tpm/tpm_crb.c           | 1 -
>  drivers/char/tpm/tpm_i2c_infineon.c  | 1 -
>  drivers/char/tpm/tpm_ibmvtpm.c       | 1 -
>  drivers/char/tpm/tpm_infineon.c      | 1 -
>  drivers/char/tpm/tpm_nsc.c           | 1 -
>  drivers/char/tpm/tpm_tis.c           | 1 -
>  drivers/char/tpm/tpm_tis_core.c      | 1 -
>  drivers/char/tpm/tpm_vtpm_proxy.c    | 1 -
>  13 files changed, 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index 7c617edff4ca..7ed9829cacc4 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -313,5 +313,4 @@ module_i2c_driver(st33zp24_i2c_driver);
>  
>  MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
>  MODULE_DESCRIPTION("STM TPM 1.2 I2C ST33 Driver");
> -MODULE_VERSION("1.3.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index a75dafd39445..147efea4eb05 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -430,5 +430,4 @@ module_spi_driver(st33zp24_spi_driver);
>  
>  MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
>  MODULE_DESCRIPTION("STM TPM 1.2 SPI ST33 Driver");
> -MODULE_VERSION("1.3.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index 4ec10ab5e576..e0f1a5828993 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -646,5 +646,4 @@ EXPORT_SYMBOL(st33zp24_pm_resume);
>  
>  MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
>  MODULE_DESCRIPTION("ST33ZP24 TPM 1.2 driver");
> -MODULE_VERSION("1.3.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..dfdc68b8bf88 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -514,5 +514,4 @@ module_exit(tpm_exit);
>  
>  MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
>  MODULE_DESCRIPTION("TPM Driver");
> -MODULE_VERSION("2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index 54a6750a6757..35bf249cc95a 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -231,5 +231,4 @@ module_exit(cleanup_atmel);
>  
>  MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
>  MODULE_DESCRIPTION("TPM Driver");
> -MODULE_VERSION("2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index a9dcf31eadd2..3e72b7b99cce 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -748,5 +748,4 @@ static struct acpi_driver crb_acpi_driver = {
>  module_acpi_driver(crb_acpi_driver);
>  MODULE_AUTHOR("Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>");
>  MODULE_DESCRIPTION("TPM2 Driver");
> -MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index a19d32cb4e94..8920b7c19fcb 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -731,5 +731,4 @@ static struct i2c_driver tpm_tis_i2c_driver = {
>  module_i2c_driver(tpm_tis_i2c_driver);
>  MODULE_AUTHOR("Peter Huewe <peter.huewe@infineon.com>");
>  MODULE_DESCRIPTION("TPM TIS I2C Infineon Driver");
> -MODULE_VERSION("2.2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 994385bf37c0..5b04d113f634 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -750,5 +750,4 @@ module_exit(ibmvtpm_module_exit);
>  
>  MODULE_AUTHOR("adlai@us.ibm.com");
>  MODULE_DESCRIPTION("IBM vTPM Driver");
> -MODULE_VERSION("1.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 9c924a1440a9..8a58966c5c9b 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -621,5 +621,4 @@ module_pnp_driver(tpm_inf_pnp_driver);
>  
>  MODULE_AUTHOR("Marcel Selhorst <tpmdd@sirrix.com>");
>  MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
> -MODULE_VERSION("1.9.2");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> index 038701d48351..6ab2fe7e8782 100644
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -412,5 +412,4 @@ module_exit(cleanup_nsc);
>  
>  MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
>  MODULE_DESCRIPTION("TPM Driver");
> -MODULE_VERSION("2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 4ed6e660273a..3074235b405d 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -429,5 +429,4 @@ module_init(init_tis);
>  module_exit(cleanup_tis);
>  MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
>  MODULE_DESCRIPTION("TPM Driver");
> -MODULE_VERSION("2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..20f4b2c7ea52 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1164,5 +1164,4 @@ EXPORT_SYMBOL_GPL(tpm_tis_resume);
>  
>  MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
>  MODULE_DESCRIPTION("TPM Driver");
> -MODULE_VERSION("2.0");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 91c772e38bb5..18f14162d1c1 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -729,5 +729,4 @@ module_exit(vtpm_module_exit);
>  
>  MODULE_AUTHOR("Stefan Berger (stefanb@us.ibm.com)");
>  MODULE_DESCRIPTION("vTPM Driver");
> -MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
> -- 
> 2.11.0
> 
> 

Thanks.

/Jarkko
