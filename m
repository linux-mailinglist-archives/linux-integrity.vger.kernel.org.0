Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE41EA58A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAOHC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAOHC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 10:07:02 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98DC05BD43
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 07:07:01 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j8so5217301ybj.12
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoRvuHjTf7o1scixwGpIQ61G+IH077lS+/oIqFSJ+Tk=;
        b=KKS3GUAtAB2uhjdFNbZB8SNlHptK6rbsPrRZICefS8v6CosCWLsW+VXO7g9lTwpIJy
         tGUs2uaUfM0f0RtsVqpLGHTIrfMR0QN5Tnd8/nxdQnqwjHUE7Fb4Ii70SyQI+tpV9TWw
         6TCnP1/6H+QtnHJpxNyVocTAjEzZKndEBiTiz/UlJLwIm4234cZYZXIy6zD+r3yUDlvU
         6rf4g5iGxXT1oLd7HIPy4Z6FPcFt/Wmr5Ps/1LtFo1k1Qq95Gz+XMCW1BM9Wj52SyFj2
         HJaAr972W5Sl8dNdQu05FCJKuyySd3gK2UEmraXOr4NqTSd68gSGzit6TpPqiATmnYFt
         PYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoRvuHjTf7o1scixwGpIQ61G+IH077lS+/oIqFSJ+Tk=;
        b=Pm8LqOYOw/f0ijNKl3oeTVYLGfH1hLURAZ0gQS/ye8VPoqltUF+j0j6dSFALsJ2Hn/
         8IZoMk5a7yrOKOpPJEPzUlkqTi2FDYRbyzgNalLJT9HofFfyn3cWehgvzeHFp3ykNf7K
         FhFk3NrpIaAcr673GVHaYktC2bAze/OOSUf23nEjnRVDsQfJCDLYGMqxiOuqljyqbFhz
         wuvSqmOdC4XyckrUFcGhKy1bCpzwbjpoXWfm71EAQ0OqahRafh5YVfyDTSEeYODoLWEQ
         UvecdTgrWsAmDXMG0ygoStq6if0V6ErR8nH9KEZGJwaIA+J0agOZ2z+PYJ5RD/3WCAWW
         MMtw==
X-Gm-Message-State: AOAM531lAdv1dzJefRLkISuTDblbnfwsye8GrPmGAArSESEi9ImJ/o/h
        q1FVORWCOmFTduSXP4C0YcyEXRcB1Am/E4cra3RdqIrx
X-Google-Smtp-Source: ABdhPJxo0s5+anf5DcECVl0XgeKKBRxRSjsbkmYirvZN/E0fDGEdt2w9d3QKe9EL1j2CZ10gY3SOVDX8HtB+QHNbZtY=
X-Received: by 2002:a5b:c08:: with SMTP id f8mr14805344ybq.153.1591020420230;
 Mon, 01 Jun 2020 07:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
 <20200529082701.13457-4-maxim.uvarov@linaro.org> <CAFA6WYM56ec-V0vv=4pVcu02FhR==1B+jMMDkU5WSjLdbP4kTw@mail.gmail.com>
In-Reply-To: <CAFA6WYM56ec-V0vv=4pVcu02FhR==1B+jMMDkU5WSjLdbP4kTw@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 1 Jun 2020 17:06:49 +0300
Message-ID: <CAD8XO3ahKTFt54w71ECtDrnD=WH0d_opptdM24kUcHPZUi-xMQ@mail.gmail.com>
Subject: Re: [PATCHv5 3/3] tpm_ftpm_tee: register driver on TEE bus
To:     Sumit Garg <sumit.garg@linaro.org>
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

thanks, will send an updated version soon.

On Mon, 1 Jun 2020 at 14:12, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 29 May 2020 at 13:57, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > Register driver on the TEE bus. The module tee registers bus,
> > and module optee calls optee_enumerate_devices() to scan
> > all devices on the bus. Trusted Application for this driver
> > can be Early TA's (can be compiled into optee-os). In that
> > case it will be on OPTEE bus before linux booting. Also
> > optee-suplicant application is needed to be loaded between
> > OPTEE module and ftpm module to maintain functionality
> > for fTPM driver.
>
> I think this description merely describes the functioning of TEE bus
> and misses what value add does TEE bus provide compared to platform
> bus.
>
> Consider:
>
> ====
> OP-TEE based fTPM Trusted Application depends on tee-supplicant to
> provide NV RAM implementation based on RPMB secure storage. So this
> dependency can be resolved via TEE bus where we only invoke fTPM
> driver probe once fTPM device is registered on the bus which is only
> true after the tee-supplicant is up and running. Additionally, TEE bus
> provides auto device enumeration.
> ====
>
> With that, implementation looks good to me. So feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> > Suggested-by: Arnd Bergmann <arnd@linaro.org>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
> >  1 file changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 22bf553ccf9d..28da638360d8 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
> >   * Return:
> >   *     On success, 0. On failure, -errno.
> >   */
> > -static int ftpm_tee_probe(struct platform_device *pdev)
> > +static int ftpm_tee_probe(struct device *dev)
> >  {
> >         int rc;
> >         struct tpm_chip *chip;
> > -       struct device *dev = &pdev->dev;
> >         struct ftpm_tee_private *pvt_data = NULL;
> >         struct tee_ioctl_open_session_arg sess_arg;
> >
> > @@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
> >         return rc;
> >  }
> >
> > +static int ftpm_plat_tee_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +
> > +       return ftpm_tee_probe(dev);
> > +}
> > +
> >  /**
> >   * ftpm_tee_remove() - remove the TPM device
> >   * @pdev: the platform_device description.
> > @@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
> >   * Return:
> >   *     0 always.
> >   */
> > -static int ftpm_tee_remove(struct platform_device *pdev)
> > +static int ftpm_tee_remove(struct device *dev)
> >  {
> > -       struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> > +       struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
> >
> >         /* Release the chip */
> >         tpm_chip_unregister(pvt_data->chip);
> > @@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int ftpm_plat_tee_remove(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +
> > +       return ftpm_tee_remove(dev);
> > +}
> > +
> >  /**
> >   * ftpm_tee_shutdown() - shutdown the TPM device
> >   * @pdev: the platform_device description.
> >   */
> > -static void ftpm_tee_shutdown(struct platform_device *pdev)
> > +static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
> >  {
> >         struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> >
> > @@ -347,17 +360,54 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> >
> > -static struct platform_driver ftpm_tee_driver = {
> > +static struct platform_driver ftpm_tee_plat_driver = {
> >         .driver = {
> >                 .name = "ftpm-tee",
> >                 .of_match_table = of_match_ptr(of_ftpm_tee_ids),
> >         },
> > -       .probe = ftpm_tee_probe,
> > -       .remove = ftpm_tee_remove,
> > -       .shutdown = ftpm_tee_shutdown,
> > +       .shutdown = ftpm_plat_tee_shutdown,
> > +       .probe = ftpm_plat_tee_probe,
> > +       .remove = ftpm_plat_tee_remove,
> > +};
> > +
> > +/* UUID of the fTPM TA */
> > +static const struct tee_client_device_id optee_ftpm_id_table[] = {
> > +       {UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
> > +                  0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
> > +       {}
> >  };
> >
> > -module_platform_driver(ftpm_tee_driver);
> > +MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
> > +
> > +static struct tee_client_driver ftpm_tee_driver = {
> > +       .id_table       = optee_ftpm_id_table,
> > +       .driver         = {
> > +               .name           = "optee-ftpm",
> > +               .bus            = &tee_bus_type,
> > +               .probe          = ftpm_tee_probe,
> > +               .remove         = ftpm_tee_remove,
> > +       },
> > +};
> > +
> > +static int __init ftpm_mod_init(void)
> > +{
> > +       int rc;
> > +
> > +       rc = platform_driver_register(&ftpm_tee_plat_driver);
> > +       if (rc)
> > +               return rc;
> > +
> > +       return driver_register(&ftpm_tee_driver.driver);
> > +}
> > +
> > +static void __exit ftpm_mod_exit(void)
> > +{
> > +       platform_driver_unregister(&ftpm_tee_plat_driver);
> > +       driver_unregister(&ftpm_tee_driver.driver);
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
