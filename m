Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFF1FEAB1
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 07:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgFRFNM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 01:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgFRFNM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 01:13:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C9C06174E
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 22:13:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so2683402lfi.7
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvxlJ8MJOTtQ2bxtVg+4CXGx6Kghs6ATIZsVNUgE9Is=;
        b=BXNK9T7tBEl9Eo4iTxlFhm8Sf9CYQdy/+rI8AjVR8TYbQZbnUCHGjOtH5WWTaH/pWq
         XG7p9bCn8bB/Mnvtj/t3DyKVpznJKpZefFttVDXNVeNSV808uUr6gLZ/ysaMQ2BeqHs9
         KLgLwO+xJbej5eBVy/dbqJp59zXgbHj1htNHeUev9VnHiWVk9XuUdb1EII/8SVrIjvgy
         +EsebLebkklslWEJNXG95KjVyyaHIQmuQgnbO3AMdyyIuyXz6osI7XPKY0wQX0+2d8BP
         UKAUW29DHX1RE3CLjUSk0gjLpDSzNRlglO4ScjgB9IUPL2e/fT+WS5udMNLPRdIkMo7i
         I8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvxlJ8MJOTtQ2bxtVg+4CXGx6Kghs6ATIZsVNUgE9Is=;
        b=DTZo0mMQNHx1Dsig3NtxEme0lf7sl0XXejUY9haDP62gJBbmjVtGqpnGeBvrkRjN+J
         +17oEIeAr7um9mSd0+2wvfdFaw8yaCKeOZAlw6D61doOrQRIP2+de9EG0FAjXq6PfsJ6
         dX/0DMSImHVGekiHEjuVzua+K3HvuKD6xuKqEbZ+fS4IeCuVw/xCI8JWD4R2Fj1OgNoN
         osC7KxFP9tWVbJPCEGxDjkg7TLopeZnQPcOc3YmjpKCvYLWtjETMF3BXST2Xxr1Lx1eW
         jj3KaMIyyzQJfLr1tQl3vgxnnXiPQ2fEH+0CpnFc3LiQHcNgGSuuT3g04u/cQxnbTRDY
         sBPw==
X-Gm-Message-State: AOAM5301mjnwBz3Vk/B55BLS54uKgwuuY8hbKBCCZ+kPDafYPwpMAfYu
        +5XhBkyr90aA5KI+uMCDLJ17w7xqNxO6sqQZXJyFUA==
X-Google-Smtp-Source: ABdhPJzY8JWY4fIDRMNNK52ScCIPJ+zPG8oxSDCj5LwyaS/eEB1O3nnjp2vk9dm7qVRWLdZ23YMasMyMJuA9xOCbO7c=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr1306319lfi.204.1592457190051;
 Wed, 17 Jun 2020 22:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
In-Reply-To: <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 Jun 2020 10:42:58 +0530
Message-ID: <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 18 Jun 2020 at 10:29, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jerome,
>
> On Wed, 17 Jun 2020 at 20:46, Jerome Forissier <jerome@forissier.org> wrote:
> >
> >
> >
> > On 6/17/20 3:58 PM, Sumit Garg wrote:
> > > Hi Maxim,
> > >
> > > On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > >>
> > >> With the evolving use-cases for TEE bus, now it's required to support
> > >> multi-stage enumeration process. But using a simple index doesn't
> > >> suffice this requirement and instead leads to duplicate sysfs entries.
> > >> So instead switch to use more informative device UUID for sysfs entry
> > >> like:
> > >> /sys/bus/tee/devices/optee-ta-<uuid>
> > >>
> > >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > >> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > >> ---
> > >>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> > >>  MAINTAINERS                                       | 1 +
> > >>  drivers/tee/optee/device.c                        | 9 ++++++---
> > >>  3 files changed, 15 insertions(+), 3 deletions(-)
> > >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> > >>
> > >> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > >> new file mode 100644
> > >> index 000000000000..0ae04ae5374a
> > >> --- /dev/null
> > >> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > >> @@ -0,0 +1,8 @@
> > >> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> > >> +Date:           May 2020
> > >> +KernelVersion   5.7
> > >> +Contact:        tee-dev@lists.linaro.org
> > >> +Description:
> > >> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> > >> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> > >> +               are free to create needed API under optee-ta-<uuid> directory.
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index ecc0749810b0..6717afef2de3 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> > >>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> > >>  L:     tee-dev@lists.linaro.org
> > >>  S:     Maintained
> > >> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> > >>  F:     drivers/tee/optee/
> > >>
> > >>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> > >> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > >> index e3a148521ec1..23d264c8146e 100644
> > >> --- a/drivers/tee/optee/device.c
> > >> +++ b/drivers/tee/optee/device.c
> > >> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> > >>         return 0;
> > >>  }
> > >>
> > >> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > >> +static int optee_register_device(const uuid_t *device_uuid)
> > >>  {
> > >>         struct tee_client_device *optee_device = NULL;
> > >>         int rc;
> > >> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > >>                 return -ENOMEM;
> > >>
> > >>         optee_device->dev.bus = &tee_bus_type;
> > >> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > >> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
> > >
> > > You should be using format specifier as: "%pUb" instead of "%pUl" as
> > > UUID representation for TAs is in big endian format. See below:
> >
> > Where does device_uuid come from? If it comes directly from OP-TEE, then
> > it should be a pointer to the following struct:
> >
> > typedef struct
> > {
> >         uint32_t timeLow;
> >         uint16_t timeMid;
> >         uint16_t timeHiAndVersion;
> >         uint8_t clockSeqAndNode[8];
> > } TEE_UUID;
> >
> > (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
> >
> > - The spec does not mandate any particular endianness and simply warns
> > about possible issues if secure and non-secure worlds differ in endianness.
> > - OP-TEE uses %pUl assuming that host order is little endian (that is
> > true for the Arm platforms that run OP-TEE currently). By the same logic
> > %pUl should be fine in the kernel.

I think Linux adheres to this RFC [1] for UUID byte order. See below
snippet from section: "Layout and Byte Order":

   The fields are encoded as 16 octets, with the sizes and order of the
   fields defined above, and with each field encoded with the Most
   Significant Byte first (known as network byte order).  Note that the
   field names, particularly for multiplexed fields, follow historical
   practice.

-Sumit

[1] https://tools.ietf.org/html/rfc4122

> > - On the other hand, the UUID in a Trusted App header is always encoded
> > big endian by the Python script that signs and optionally encrypts the
> > TA. This should not have any visible impact on UUIDs exchanged between
> > the secure and non-secure world though.
> >
> > So I am wondering why you had to use %pUb. There must be some
> > inconsistency somewhere :-/
>
> Yes there is. Linux stores UUID in big endian format (16 byte octets)
> and OP-TEE stores UUID in little endian format (in form of struct you
> referenced above).
>
> And format conversion APIs [1] in OP-TEE OS are used while passing
> UUID among Linux and OP-TEE.
>
> So we need to use %pUb in case of Linux and %pUl in case of OP-TEE.
>
> [1] https://github.com/OP-TEE/optee_os/blob/master/core/tee/uuid.c
>
> -Sumit
>
> >
> > --
> > Jerome
> >
> > >
> > > # ls /sys/bus/tee/devices/
> > > optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
> > > optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
> > > optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c
> > >
> > > While UUID for fTPM TA is in big endian format:
> > > bc50d971-d4c9-42c4-82cb-343fb7f37896
> > >
> > > Sorry that I missed it during review and noticed this while testing.
> > >
> > > With the above fix included, I tested this series using fTPM early TA
> > > on Qemu for aarch64 and used basic random number generation test using
> > > tpm2-tools. So feel free to add:
> > >
> > > Tested-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > -Sumit
> > >
> > >> +               kfree(optee_device);
> > >> +               return -ENOMEM;
> > >> +       }
> > >>         uuid_copy(&optee_device->id.uuid, device_uuid);
> > >>
> > >>         rc = device_register(&optee_device->dev);
> > >> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
> > >>         num_devices = shm_size / sizeof(uuid_t);
> > >>
> > >>         for (idx = 0; idx < num_devices; idx++) {
> > >> -               rc = optee_register_device(&device_uuid[idx], idx);
> > >> +               rc = optee_register_device(&device_uuid[idx]);
> > >>                 if (rc)
> > >>                         goto out_shm;
> > >>         }
> > >> --
> > >> 2.17.1
> > >>
> > > _______________________________________________
> > > Tee-dev mailing list
> > > Tee-dev@lists.linaro.org
> > > https://lists.linaro.org/mailman/listinfo/tee-dev
> > >
