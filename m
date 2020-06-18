Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBC1FECB3
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgFRHog (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgFRHof (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:44:35 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC66C061755
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 00:44:34 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id k18so2623333ybm.13
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1V6PUODlcGEDi8aIH/E2hPEHAyYyK6vPY8h7Z/71Ro=;
        b=gKtk9wZ/yS93Zt8oUcPIWUy6/SabjtFppGw/CFS0q/mSNzvWzCL+9yZUOwxjjka7Ir
         hI7FmfntK0K0RgZWWC3xcq+IzWmkUnJiJ7jJWopv5BR9K1sMNICClnqx6codNnJM7Teg
         tSPJ6aeFGeTLhraho8t3aWh75hdCvffjMHCp/bN4lTBLYF0O+QhiTDLfczDUn3Hx57yE
         /Ip99COz1PmX4UUmUdb7hR+O1BoIpARhCCZ6z8tgNlcEYDWyB/oRgHwdOIOielQWan1e
         wR39234G6y7QH2BgBNkZTslUEmLECYLmrMp6oGKY8U+SfUNVqE67T2QntFAW+ctyTubf
         mxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1V6PUODlcGEDi8aIH/E2hPEHAyYyK6vPY8h7Z/71Ro=;
        b=U28yeVRAMwY4mkQrQUnGxCvUVpWxNw+5s4OUMwxvbNrereAovOwRSFY0TMvB1gvzs9
         V4Qkyxgpu3SdPGSmbYE3bEzS5DHlnPDMYAohatKFCal0Nf8KvUGMIPOiEr+sRQLbNKFs
         YE5ER1nHFtGbnjx38cpVcjIbmCjY7D846ogPpbRwuqVm9keDBvVryw+sIzfroWKjTbA1
         /7HFhNmTdDgnnumIU5ya3xl9JXzYrHZHJe1CmLGqCLE8wnwJio5MIamijvpt31lU7xYz
         8my1oHVHciHJdITc/W+ttVvRt9VjhdTfBfNJu0sXnRn9c2j7/BdiLf/LL/lBlXyzb5wi
         gmYg==
X-Gm-Message-State: AOAM532oIWusDs5z8+UyQWao7HnuoBjHBaJJqbR9fvsWDe+FqZWTa5tM
        5G3D6Dv7qE3BJe8KSZa8FBXN6iWxZ913fGxCL8Ea8A==
X-Google-Smtp-Source: ABdhPJwDldk7wG6VclMUJbOGUeamqryW+XBYhBQREiA+8YAwYz9CJHWjHwk40PxP4WY5byYSGC4r97AXO94NLzjrJZs=
X-Received: by 2002:a25:be81:: with SMTP id i1mr4411162ybk.243.1592466273392;
 Thu, 18 Jun 2020 00:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <6b67cd00-a302-55a1-1e56-d1f1e7a06cef@forissier.org>
In-Reply-To: <6b67cd00-a302-55a1-1e56-d1f1e7a06cef@forissier.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 18 Jun 2020 10:44:22 +0300
Message-ID: <CAD8XO3YBmivv21Cb-AuUBkrFDyWZR5h6aq8gyec15B0exZ7=Bw@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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

There was a comment about a new mailing list address in Documentation.
Which one I should specify now?

On Thu, 18 Jun 2020 at 09:57, Jerome Forissier <jerome@forissier.org> wrote:
>
> On 6/18/20 6:59 AM, Sumit Garg wrote:
> > Hi Jerome,
> >
> > On Wed, 17 Jun 2020 at 20:46, Jerome Forissier <jerome@forissier.org> wrote:
> >>
> >>
> >>
> >> On 6/17/20 3:58 PM, Sumit Garg wrote:
> >>> Hi Maxim,
> >>>
> >>> On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >>>>
> >>>> With the evolving use-cases for TEE bus, now it's required to support
> >>>> multi-stage enumeration process. But using a simple index doesn't
> >>>> suffice this requirement and instead leads to duplicate sysfs entries.
> >>>> So instead switch to use more informative device UUID for sysfs entry
> >>>> like:
> >>>> /sys/bus/tee/devices/optee-ta-<uuid>
> >>>>
> >>>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >>>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >>>> ---
> >>>>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >>>>  MAINTAINERS                                       | 1 +
> >>>>  drivers/tee/optee/device.c                        | 9 ++++++---
> >>>>  3 files changed, 15 insertions(+), 3 deletions(-)
> >>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >>>> new file mode 100644
> >>>> index 000000000000..0ae04ae5374a
> >>>> --- /dev/null
> >>>> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >>>> @@ -0,0 +1,8 @@
> >>>> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> >>>> +Date:           May 2020
> >>>> +KernelVersion   5.7
> >>>> +Contact:        tee-dev@lists.linaro.org
> >>>> +Description:
> >>>> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> >>>> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> >>>> +               are free to create needed API under optee-ta-<uuid> directory.
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index ecc0749810b0..6717afef2de3 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >>>>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> >>>>  L:     tee-dev@lists.linaro.org
> >>>>  S:     Maintained
> >>>> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> >>>>  F:     drivers/tee/optee/
> >>>>
> >>>>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> >>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >>>> index e3a148521ec1..23d264c8146e 100644
> >>>> --- a/drivers/tee/optee/device.c
> >>>> +++ b/drivers/tee/optee/device.c
> >>>> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >>>> +static int optee_register_device(const uuid_t *device_uuid)
> >>>>  {
> >>>>         struct tee_client_device *optee_device = NULL;
> >>>>         int rc;
> >>>> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >>>>                 return -ENOMEM;
> >>>>
> >>>>         optee_device->dev.bus = &tee_bus_type;
> >>>> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> >>>> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
> >>>
> >>> You should be using format specifier as: "%pUb" instead of "%pUl" as
> >>> UUID representation for TAs is in big endian format. See below:
> >>
> >> Where does device_uuid come from? If it comes directly from OP-TEE, then
> >> it should be a pointer to the following struct:
> >>
> >> typedef struct
> >> {
> >>         uint32_t timeLow;
> >>         uint16_t timeMid;
> >>         uint16_t timeHiAndVersion;
> >>         uint8_t clockSeqAndNode[8];
> >> } TEE_UUID;
> >>
> >> (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
> >>
> >> - The spec does not mandate any particular endianness and simply warns
> >> about possible issues if secure and non-secure worlds differ in endianness.
> >> - OP-TEE uses %pUl assuming that host order is little endian (that is
> >> true for the Arm platforms that run OP-TEE currently). By the same logic
> >> %pUl should be fine in the kernel.
> >> - On the other hand, the UUID in a Trusted App header is always encoded
> >> big endian by the Python script that signs and optionally encrypts the
> >> TA. This should not have any visible impact on UUIDs exchanged between
> >> the secure and non-secure world though.
> >>
> >> So I am wondering why you had to use %pUb. There must be some
> >> inconsistency somewhere :-/
> >
> > Yes there is. Linux stores UUID in big endian format (16 byte octets)
> > and OP-TEE stores UUID in little endian format (in form of struct you
> > referenced above).
> >
> > And format conversion APIs [1] in OP-TEE OS are used while passing
> > UUID among Linux and OP-TEE.
> >
> > So we need to use %pUb in case of Linux and %pUl in case of OP-TEE.
> >
> > [1] https://github.com/OP-TEE/optee_os/blob/master/core/tee/uuid.c
>
>
> Got it now. The TA enumeration function in OP-TEE performs  the
> conversion here:
> https://github.com/OP-TEE/optee_os/blob/3.9.0/core/pta/device.c#L34
>
> Thanks for clarifying.
>
> --
> Jerome
