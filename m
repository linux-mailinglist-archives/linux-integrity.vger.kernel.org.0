Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508021FCF32
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQONK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFQONJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 10:13:09 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FAC061755
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 07:13:08 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id t9so1332883ybk.9
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7Sk4BmGiurLqmgxw2Dzz1OAQhCbcvIbUaVFjs9AqkE=;
        b=Awadm/m6rOqaV6Y5mlaX9Gfsg4s6zvEHdiKJzd33cFxAGPhfc6fxVxk9vji8B76pwn
         WI6WLVUJuJer03q0E2LmtIdQ8qom8Bpcu4BUFhOGFqkZALehT38njMGF6IkdOKPIhpV+
         FXkzC77+bRqUllloHbP2B9aNgjd6kT3yq/C+LJcQKBgJ+3WbFgloQetLZa2Hy4C3hTui
         1L6MC/UioAkNRtWg0mFoBwH0sfwbY69FC/wS6CfAO6hivd0RhfyRVQyaN8FPYD55ruzx
         D1uGYEMQKSp0QnHfz4ehko8OIfs71dlk/238m6xXPl/bytH0wg00cHZQcat8+7VINud1
         Ke+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7Sk4BmGiurLqmgxw2Dzz1OAQhCbcvIbUaVFjs9AqkE=;
        b=tldEVbc5LxwZ/59MA97t8PfHjfhIRpGkQ+BU3Ym7lZfW3j5H8oe0GCw/29YaySQDNe
         cl5aIVUBHCcsHS3IS4qCco+Hwsw5/b3OTajU6WGMSKsrjZttxf+dsZ89rsqs111tZP9V
         XL/PqYKF3CsLy7auqZDO5IOBM49FLMRKOFbTWWLacbECPoxIN3P9ABmjN6lfajHsMxhp
         YYLGAwZKy2Slg0ChfWsFDklESdgx0QIPE4wyKG4iupspbops7K0vgY8yRwwRBZhSmiaS
         sN4dsOncdY9prSdQcbo+CYL/9m5qBnawzq7NNV7kBuQ+G1/XjEVB3uzvrYsucBbjdqZ6
         hrMQ==
X-Gm-Message-State: AOAM532YPKDTFSG0GNsk/AoDiQMc/+IkmRSnxU7n0THy+mhzAbtsbtfN
        L12zDVdi4KcjTZcDzL6ygp61i5QBy3oyNFgazFm0aQ==
X-Google-Smtp-Source: ABdhPJxR5WKL9bWfdzNlZuOGFZs0xv21TnQVWWVSPRx/9BSk+4es74k7/DHIIHxLcqG0kL7DixeloEZGAQDnq/R0wsQ=
X-Received: by 2002:a25:be81:: with SMTP id i1mr12981047ybk.243.1592403187417;
 Wed, 17 Jun 2020 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
In-Reply-To: <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 17 Jun 2020 17:12:56 +0300
Message-ID: <CAD8XO3axk-_BP1Nk_vT=u08OSuLmuEzXoSnmdB8pHKR_G2A1dw@mail.gmail.com>
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
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

On Wed, 17 Jun 2020 at 16:58, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Maxim,
>
> On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > With the evolving use-cases for TEE bus, now it's required to support
> > multi-stage enumeration process. But using a simple index doesn't
> > suffice this requirement and instead leads to duplicate sysfs entries.
> > So instead switch to use more informative device UUID for sysfs entry
> > like:
> > /sys/bus/tee/devices/optee-ta-<uuid>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >  MAINTAINERS                                       | 1 +
> >  drivers/tee/optee/device.c                        | 9 ++++++---
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > new file mode 100644
> > index 000000000000..0ae04ae5374a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > @@ -0,0 +1,8 @@
> > +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> > +Date:           May 2020
> > +KernelVersion   5.7
> > +Contact:        tee-dev@lists.linaro.org
> > +Description:
> > +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> > +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> > +               are free to create needed API under optee-ta-<uuid> directory.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ecc0749810b0..6717afef2de3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >  M:     Jens Wiklander <jens.wiklander@linaro.org>
> >  L:     tee-dev@lists.linaro.org
> >  S:     Maintained
> > +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> >  F:     drivers/tee/optee/
> >
> >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index e3a148521ec1..23d264c8146e 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >         return 0;
> >  }
> >
> > -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > +static int optee_register_device(const uuid_t *device_uuid)
> >  {
> >         struct tee_client_device *optee_device = NULL;
> >         int rc;
> > @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >                 return -ENOMEM;
> >
> >         optee_device->dev.bus = &tee_bus_type;
> > -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
>
> You should be using format specifier as: "%pUb" instead of "%pUl" as
> UUID representation for TAs is in big endian format. See below:
>
> # ls /sys/bus/tee/devices/
> optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
> optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
> optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c
>
> While UUID for fTPM TA is in big endian format:
> bc50d971-d4c9-42c4-82cb-343fb7f37896
>
> Sorry that I missed it during review and noticed this while testing.
>
> With the above fix included, I tested this series using fTPM early TA
> on Qemu for aarch64 and used basic random number generation test using
> tpm2-tools. So feel free to add:
>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
Oh, thanks. I will do v9 with this change and mailing list change.
Probalby you also need to check which prints are inside optee-os. I
think I copypasted this print from somewhere.

Maxim.

> > +               kfree(optee_device);
> > +               return -ENOMEM;
> > +       }
> >         uuid_copy(&optee_device->id.uuid, device_uuid);
> >
> >         rc = device_register(&optee_device->dev);
> > @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
> >         num_devices = shm_size / sizeof(uuid_t);
> >
> >         for (idx = 0; idx < num_devices; idx++) {
> > -               rc = optee_register_device(&device_uuid[idx], idx);
> > +               rc = optee_register_device(&device_uuid[idx]);
> >                 if (rc)
> >                         goto out_shm;
> >         }
> > --
> > 2.17.1
> >
