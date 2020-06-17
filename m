Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94601FCEEF
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQN6a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQN63 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 09:58:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46673C06174E
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 06:58:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so2953308lji.11
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLDiEuuNfJhWVK1I22iFWyRL9tqHD8cVwzgyE91Mz3s=;
        b=pX61bJji52z48r7wt+tWy3rQ+DH7PbhTwh06jxsDGu+mRiyZ3DZtqcDG+frmoxZt4c
         p/Rdh5X9077wQFDpuru7e8LbuLvGeZwGDlzoc2CWVwYwC+qj0MpehNyaz/kO6wu9FQwR
         pndgcwWzYmMSn0oMbVqTN1yG9ytkJmw2Lk+HT3hsfx0Sy3RWSE5wGAOLh/Sgj0ChQWPD
         qXJsd5G0osmuvnEZ+IfchDQZQ5FQfH7kCWSKT7nM5chmmyEoAdMNCUjE9LLKqGuvXue1
         cwD1xmTFnZElTyBAEqtNUnDvcbULj2cXsAUDmLECz2ke07KqZ23MEmVwqwVjNLUd2wSR
         wZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLDiEuuNfJhWVK1I22iFWyRL9tqHD8cVwzgyE91Mz3s=;
        b=HYGZG4yBHfXKOuduU1FF6MzeMzm5xCqdPAEMR9KSyFAo+q/zNh33snpmjpSq/jt725
         VXmiahMyAQ9zz3g1AED4pgPaTWqHNyCNiCj8VDsACwCO1U1NjMbM2WxRBz1ERffeAOFQ
         XNd47U1adqyQBlvBTzHb1aBDiQWLuz3hByXLFhLrt2ksL2YRpPlCSmz8rcFtAmzhHgF6
         SCF/KZS9dXGwA0uqs0SWcIMdCVJO/gwKk+arAFJ7Ch3uxzWBXUEYJb3inin3Ry5VVA4e
         kcSBxCQmbE4PtW8Sz5wmirIBIzpI1R9vrrBC0FTd7X6Uuo695gmOApP+4CGx427JlnMS
         +LwQ==
X-Gm-Message-State: AOAM53050PNATmMEY8OvcwgYbhlDMRDrEGtBRCGUy73zAk7CJsWRKFqw
        fv18zvqAst3X1cXtwnFAUbf7N2MQW8hVuW13pQTB+w==
X-Google-Smtp-Source: ABdhPJxZbnVS7dm8L9M8mgWbiYnE/qRK7G9n0TXltwJD9k3GVyoHe4++Q8DEIUTVAf5MSBMRAhHi+ho6FdlkYcVm+Ak=
X-Received: by 2002:a2e:7e08:: with SMTP id z8mr3803277ljc.339.1592402307692;
 Wed, 17 Jun 2020 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
In-Reply-To: <20200604175851.758-2-maxim.uvarov@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 Jun 2020 19:28:16 +0530
Message-ID: <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
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

Hi Maxim,

On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> With the evolving use-cases for TEE bus, now it's required to support
> multi-stage enumeration process. But using a simple index doesn't
> suffice this requirement and instead leads to duplicate sysfs entries.
> So instead switch to use more informative device UUID for sysfs entry
> like:
> /sys/bus/tee/devices/optee-ta-<uuid>
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>  MAINTAINERS                                       | 1 +
>  drivers/tee/optee/device.c                        | 9 ++++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> new file mode 100644
> index 000000000000..0ae04ae5374a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -0,0 +1,8 @@
> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> +Date:           May 2020
> +KernelVersion   5.7
> +Contact:        tee-dev@lists.linaro.org
> +Description:
> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> +               are free to create needed API under optee-ta-<uuid> directory.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..6717afef2de3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>  L:     tee-dev@lists.linaro.org
>  S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index e3a148521ec1..23d264c8146e 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>         return 0;
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> +static int optee_register_device(const uuid_t *device_uuid)
>  {
>         struct tee_client_device *optee_device = NULL;
>         int rc;
> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>                 return -ENOMEM;
>
>         optee_device->dev.bus = &tee_bus_type;
> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {

You should be using format specifier as: "%pUb" instead of "%pUl" as
UUID representation for TAs is in big endian format. See below:

# ls /sys/bus/tee/devices/
optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c

While UUID for fTPM TA is in big endian format:
bc50d971-d4c9-42c4-82cb-343fb7f37896

Sorry that I missed it during review and noticed this while testing.

With the above fix included, I tested this series using fTPM early TA
on Qemu for aarch64 and used basic random number generation test using
tpm2-tools. So feel free to add:

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> +               kfree(optee_device);
> +               return -ENOMEM;
> +       }
>         uuid_copy(&optee_device->id.uuid, device_uuid);
>
>         rc = device_register(&optee_device->dev);
> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
>         num_devices = shm_size / sizeof(uuid_t);
>
>         for (idx = 0; idx < num_devices; idx++) {
> -               rc = optee_register_device(&device_uuid[idx], idx);
> +               rc = optee_register_device(&device_uuid[idx]);
>                 if (rc)
>                         goto out_shm;
>         }
> --
> 2.17.1
>
