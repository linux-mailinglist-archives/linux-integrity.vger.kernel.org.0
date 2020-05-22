Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF51DF000
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgEVT35 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgEVT34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 15:29:56 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B8C05BD43
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 12:29:56 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id u73so2712547ybi.2
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxyDI4KhsqdDlPkuSmkhUHOJKiG6K9Cqyhd9HAyDtUY=;
        b=Ai7DHhpie7RQugUd57wRx/wM4CE24dLCXDX6vSinkbgPGRZ1iRkg56WJ59+7Lf5q7s
         47+7CVGsUoJrwJYBHC2UkcGz2VXmUYNCU59OYg4HdWifIyLSZ1YIrq5io/DJjv0S0JO/
         O3tq3pcFLg42X8AXWbpA8Dz5qfsJbADa/XlCzTCbeQ+hw7srne74lQyUu4N7ruEGemMg
         i1er2cLnV76zGpQD2X/cXN9zerh2Ow4ojTl4GdFWnnawqREKt4aeSihpE/dgqtQ8OJQQ
         Ywr5qWk7bgML66b2EnxJi7Zt9KHzga1thrw2ghVl+ctb6ngtEAjys97At035Vyh/OM8I
         +wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxyDI4KhsqdDlPkuSmkhUHOJKiG6K9Cqyhd9HAyDtUY=;
        b=bQSGjNX6fDHBf1AnMreZcim5Ls7hj4ZdhWc51ZoCInfsGgwwDpKunyfgJ1sjaXjExk
         Tb7JFMhvW6hpaeMan1/x9g5enya7NhUebKjbbEkvPmr3g64nub6bj2sELpn32NJ28baT
         7Slb3u+zIvCwfiTh2CgH6gWq4yZxHy09+PfXawimvKE/fsUxDy4u2MrazOsoy2uNdWIk
         mB8LhTpzvbrvy5n6HwyUSqC5GbiZk+V49rzmWW0OPShSvPsU/oyjbZVhd8++/0z1t/uz
         KBtrlkszxHtfrjvxIZflbDmlhOYlcrlr74nDojUK9ggSqgnPYnc6ZP6cP1d5ispwG6DZ
         Yebw==
X-Gm-Message-State: AOAM531gzhGyx3k5Tt6jwKB2/2pf86rmQ2OpGcVOQe5WQ3t1Mokcea9V
        Tw+yO7pr8EZYRAEY8VcsExsPeRyQX6a5N+ZluvaxJA==
X-Google-Smtp-Source: ABdhPJzWUTzw0sVh/Mb6whsHSjzKB3O2GIvhjGBp/VzxEYiC+6oFh6e5LBIivl5m60HZj+xADahn4zl9QqXPV+QrEjE=
X-Received: by 2002:a5b:345:: with SMTP id q5mr25316283ybp.494.1590175795569;
 Fri, 22 May 2020 12:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
In-Reply-To: <20200522171451.GD10319@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Fri, 22 May 2020 22:29:44 +0300
Message-ID: <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > Register driver on TEE bus. module tee registers bus,
>
> "on the TEE bus"
>
> "The module tee"
>
> > and module optee calls optee_enumerate_devices() to scan
> > all devices on the bus. Trusted Application for this driver
>
> Looking at drivers/tee, it shows that tee and optee are in fact the same
> module as opposed to what your commit message says.
>

In the current kernel it's 2 different modules.

> > can be Early TA's (can be compiled into optee-os). In that
> > case it will be on OPTEE bus before linux booting. Also
> > optee-suplicant application is needed to be loaded between
> > OPTEE module and ftpm module to maintain functionality
> > for fTPM driver.
>
> Why is this needed and why things worked before having this?
>

Before these changes user space has to drive boot sequence. I.e.  tee
and optee modules loads, then application tee-supplicant has to start
and only then module ftpm can be loaded. The reason for that is
storage services are implemented in userspace and driver needs them.
To make it work needed some tricky systemd scenario with black list
driver mode.  That really  did not look well. From the over side ftpm
might be used by uboot so it can be compiled inside firmware
(bl32/optee-os). On the other hand there are drivers like tee-rng
which do not need tee-supplicant and can run immediately after tee and
optee modules. So the solution as I described in the commit is to make
tee bus work for both types of drivers.

Also in this driver I specially did not remove the old way of
registration using DT entry. To not break existence things.  And added
new registration from the platform driver.


> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> > Suggested-by: Arnd Bergmann <arnd@linaro.org>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 69 ++++++++++++++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 22bf553ccf9d..7bb4ce281050 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
> >   * Return:
> >   *   On success, 0. On failure, -errno.
> >   */
> > -static int ftpm_tee_probe(struct platform_device *pdev)
> > +static int ftpm_tee_probe(struct device *dev)
> >  {
> >       int rc;
> >       struct tpm_chip *chip;
> > -     struct device *dev = &pdev->dev;
> >       struct ftpm_tee_private *pvt_data = NULL;
> >       struct tee_ioctl_open_session_arg sess_arg;
> >
> > @@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
> >       return rc;
> >  }
> >
> > +static int ftpm_plat_tee_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +
> > +     return ftpm_tee_probe(dev);
> > +}
> > +
> >  /**
> >   * ftpm_tee_remove() - remove the TPM device
> >   * @pdev: the platform_device description.
> > @@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
> >   * Return:
> >   *   0 always.
> >   */
> > -static int ftpm_tee_remove(struct platform_device *pdev)
> > +static int ftpm_tee_remove(struct device *dev)
> >  {
> > -     struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> > +     struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
> >
> >       /* Release the chip */
> >       tpm_chip_unregister(pvt_data->chip);
> > @@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static int ftpm_plat_tee_remove(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +
> > +     return ftpm_tee_remove(dev);
> > +}
> > +
> >  /**
> >   * ftpm_tee_shutdown() - shutdown the TPM device
> >   * @pdev: the platform_device description.
> >   */
> > -static void ftpm_tee_shutdown(struct platform_device *pdev)
> > +static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
> >  {
> >       struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> >
> > @@ -347,17 +360,53 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> >
> > -static struct platform_driver ftpm_tee_driver = {
> > +static struct platform_driver ftpm_tee_plat_driver = {
> >       .driver = {
> >               .name = "ftpm-tee",
> >               .of_match_table = of_match_ptr(of_ftpm_tee_ids),
> >       },
> > -     .probe = ftpm_tee_probe,
> > -     .remove = ftpm_tee_remove,
> > -     .shutdown = ftpm_tee_shutdown,
> > +     .shutdown = ftpm_plat_tee_shutdown,
> > +     .probe = ftpm_plat_tee_probe,
> > +     .remove = ftpm_plat_tee_remove,
> > +};
> > +
> > +static const struct tee_client_device_id optee_ftpm_id_table[] = {
> > +     {UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
> > +                0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
> > +     {}
>
> Please put a comment describing what this is.
>
> >  };
> >
> > -module_platform_driver(ftpm_tee_driver);
> > +MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
> > +
> > +static struct tee_client_driver ftpm_tee_driver = {
> > +     .id_table       = optee_ftpm_id_table,
> > +     .driver         = {
> > +             .name           = "optee-ftpm",
> > +             .bus            = &tee_bus_type,
> > +             .probe          = ftpm_tee_probe,
> > +             .remove         = ftpm_tee_remove,
> > +     },
> > +};
> > +
> > +static int __init ftpm_mod_init(void)
> > +{
> > +     int rc;
> > +
> > +     rc = platform_driver_register(&ftpm_tee_plat_driver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     return driver_register(&ftpm_tee_driver.driver);
> > +}
> > +
> > +static void __exit ftpm_mod_exit(void)
> > +{
> > +     platform_driver_unregister(&ftpm_tee_plat_driver);
> > +     driver_unregister(&ftpm_tee_driver.driver);
> > +}
> > +
> > +module_init(ftpm_mod_init);
> > +module_exit(ftpm_mod_exit);
> >
> >  MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
> >  MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
> > --
> > 2.17.1
> >
>
> Wondering if MODULE_AUTHOR() is still equired given that the GIT log
> has objectively better log of authorship.
>
> /Jarkko

Yea, but I prefer to not touch such lines. It's up to maintainers how
they support the driver.

Best regards,
Maxim.
