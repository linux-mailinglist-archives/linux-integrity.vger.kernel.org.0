Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA41EA274
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFALMG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 07:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFALMG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 07:12:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49BDC03E96F
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 04:12:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so7641179ljo.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2/0YsNA83Geikdg8xSFtPuXls8VUpH1woVTNt2k/XQ=;
        b=rDNeF1PmlxvWMhdfbZKW1PZGqHjTG7y5cui4e7iPNLi/OXCOtkGeoy2MjsEofQd1DN
         6Qpzk3rrq8wO6B6cLiLlTyQdphyPVcYF+rAAyqiVO9rxtwGB5SP5SAktv6Imy/zbIyrz
         eishvUB9UYR2zobnj65m/YAsIvBco0GiXsR4e9c1XhE0l7dV5vljP+mpGWrjooS8w/8Z
         SQ2faxkxBc7YeY+qqs1n/dOo9f7ftMeORBus7WvbdCU3TkCwaUE5XOPY6sFV/DwsZcKU
         1Irsohtk49cWrvi9wDTB3x7Uj3bwiAegCN9vhaqLBScviAsyrLx7DtnYellshrWE1bQh
         vVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2/0YsNA83Geikdg8xSFtPuXls8VUpH1woVTNt2k/XQ=;
        b=S5UMiavS7BlTz1hPPyAT8i4vqI7keJr+7SZsac1MWZSfVuHV5dhTq4nu7uUXSiysw/
         dQgcvnTwL3hdssnu8+jajCUBUbsYv/L4CrA36nGo4nJZlbezCCoro/U9Dvh+72V8tKXJ
         D1bjXUf3wgurHC9ggowOn/X+th9/5B5svrg3cscB2+DMy7kPkcvJ67rcGfhGxZRuJoLG
         XQQpYLqaBDWQBM5+E1yMgqTXUrgi9ejn6MCiDmR4cy5KYKfPCrW3gO43cmbvzY8whx80
         qq++QMjsZ+Pb1wvhYIGoMC6IYRFZheiCREtKvZilFRVlBaE3pD4Rjr1RUB3YGraOGpR8
         VXAw==
X-Gm-Message-State: AOAM533VgfaGPdxPIsmORhSrqTtrSdZAySkspEWQyMPwSG1MWtIaaUXr
        h76tvsTB496F/mgzPpFH8uZrWyMCCO6pNSF04fmu6g==
X-Google-Smtp-Source: ABdhPJxLsB373tBnVYRgJ1vn7dn1tWlACfXtQ9stWrdwoQ4Gydq3ce5Qc0OlbTI8U2eXMzT08WfqhvRWLDvFRIaosSw=
X-Received: by 2002:a2e:7504:: with SMTP id q4mr9613507ljc.339.1591009923893;
 Mon, 01 Jun 2020 04:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200529082701.13457-1-maxim.uvarov@linaro.org> <20200529082701.13457-4-maxim.uvarov@linaro.org>
In-Reply-To: <20200529082701.13457-4-maxim.uvarov@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 16:41:51 +0530
Message-ID: <CAFA6WYM56ec-V0vv=4pVcu02FhR==1B+jMMDkU5WSjLdbP4kTw@mail.gmail.com>
Subject: Re: [PATCHv5 3/3] tpm_ftpm_tee: register driver on TEE bus
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 29 May 2020 at 13:57, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Register driver on the TEE bus. The module tee registers bus,
> and module optee calls optee_enumerate_devices() to scan
> all devices on the bus. Trusted Application for this driver
> can be Early TA's (can be compiled into optee-os). In that
> case it will be on OPTEE bus before linux booting. Also
> optee-suplicant application is needed to be loaded between
> OPTEE module and ftpm module to maintain functionality
> for fTPM driver.

I think this description merely describes the functioning of TEE bus
and misses what value add does TEE bus provide compared to platform
bus.

Consider:

====
OP-TEE based fTPM Trusted Application depends on tee-supplicant to
provide NV RAM implementation based on RPMB secure storage. So this
dependency can be resolved via TEE bus where we only invoke fTPM
driver probe once fTPM device is registered on the bus which is only
true after the tee-supplicant is up and running. Additionally, TEE bus
provides auto device enumeration.
====

With that, implementation looks good to me. So feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 22bf553ccf9d..28da638360d8 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
>   * Return:
>   *     On success, 0. On failure, -errno.
>   */
> -static int ftpm_tee_probe(struct platform_device *pdev)
> +static int ftpm_tee_probe(struct device *dev)
>  {
>         int rc;
>         struct tpm_chip *chip;
> -       struct device *dev = &pdev->dev;
>         struct ftpm_tee_private *pvt_data = NULL;
>         struct tee_ioctl_open_session_arg sess_arg;
>
> @@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
>         return rc;
>  }
>
> +static int ftpm_plat_tee_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +
> +       return ftpm_tee_probe(dev);
> +}
> +
>  /**
>   * ftpm_tee_remove() - remove the TPM device
>   * @pdev: the platform_device description.
> @@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
>   * Return:
>   *     0 always.
>   */
> -static int ftpm_tee_remove(struct platform_device *pdev)
> +static int ftpm_tee_remove(struct device *dev)
>  {
> -       struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> +       struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
>
>         /* Release the chip */
>         tpm_chip_unregister(pvt_data->chip);
> @@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int ftpm_plat_tee_remove(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +
> +       return ftpm_tee_remove(dev);
> +}
> +
>  /**
>   * ftpm_tee_shutdown() - shutdown the TPM device
>   * @pdev: the platform_device description.
>   */
> -static void ftpm_tee_shutdown(struct platform_device *pdev)
> +static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
>  {
>         struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
>
> @@ -347,17 +360,54 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
>
> -static struct platform_driver ftpm_tee_driver = {
> +static struct platform_driver ftpm_tee_plat_driver = {
>         .driver = {
>                 .name = "ftpm-tee",
>                 .of_match_table = of_match_ptr(of_ftpm_tee_ids),
>         },
> -       .probe = ftpm_tee_probe,
> -       .remove = ftpm_tee_remove,
> -       .shutdown = ftpm_tee_shutdown,
> +       .shutdown = ftpm_plat_tee_shutdown,
> +       .probe = ftpm_plat_tee_probe,
> +       .remove = ftpm_plat_tee_remove,
> +};
> +
> +/* UUID of the fTPM TA */
> +static const struct tee_client_device_id optee_ftpm_id_table[] = {
> +       {UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
> +                  0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
> +       {}
>  };
>
> -module_platform_driver(ftpm_tee_driver);
> +MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
> +
> +static struct tee_client_driver ftpm_tee_driver = {
> +       .id_table       = optee_ftpm_id_table,
> +       .driver         = {
> +               .name           = "optee-ftpm",
> +               .bus            = &tee_bus_type,
> +               .probe          = ftpm_tee_probe,
> +               .remove         = ftpm_tee_remove,
> +       },
> +};
> +
> +static int __init ftpm_mod_init(void)
> +{
> +       int rc;
> +
> +       rc = platform_driver_register(&ftpm_tee_plat_driver);
> +       if (rc)
> +               return rc;
> +
> +       return driver_register(&ftpm_tee_driver.driver);
> +}
> +
> +static void __exit ftpm_mod_exit(void)
> +{
> +       platform_driver_unregister(&ftpm_tee_plat_driver);
> +       driver_unregister(&ftpm_tee_driver.driver);
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
