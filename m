Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073511FD593
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQTxC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgFQTxB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 15:53:01 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCDC061755
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 12:53:01 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h39so1883818ybj.3
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPskS7YpIsPAtpdB17fH8j2IFkcePv+bE+bCBlKpQgA=;
        b=ed78ea9RokhBOXQQ/ED3VOjQZToVMPxDUom8KiKg5uE4VRuDoKvec1i6HhYrvYiZAm
         wZd3dYvSePB4ScyYhFUTNLjsyj7tiRh7Lun2SEyHVltevLCD+9NLBfKhgA69UWrR6kLo
         rcpbvcFdMYJOTv4/UwFdeNkY3iYNOAWGVZnpaxa/FGfwMIlNKBfwDLTkazu4+XjZcuHu
         mm5GkAb/0wxwQl7jwtZpeCLytbVzmVRdPwcfFIxlUOoXCbpc9HtscXrcE3qqnskzNjk7
         lnwT2EFpbPot/QidmLPNNnZduY4XMlQ6yrXBovQg4BKKQF9PFZ7kHt0XvHuAizAeeOQc
         4UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPskS7YpIsPAtpdB17fH8j2IFkcePv+bE+bCBlKpQgA=;
        b=BVHm1UfqmKr3T8E/7dvemTuvtklpyU4nqgFu2HjA9GO+mStPVDUJYbarTlS62q1b3t
         4VM5w3+Y7f5BpzO/7bu+52VH1mld+mbk38lNJXaIz4SSbRwFiUfhW4eDjIhjW2QjUhYX
         tup8bdOzwFJP9sp2KeKpnQtX6I5XEujxThOUNQdcCXHlziuE+9CPaFwYvbFeQ/bGiSFQ
         uM+dcFsSJu2ILNk4JpKrai45UxKpJHf0mksd2A/F/PlqC5uAjLS/lGczwnosiNj6YMPw
         y1rW5tkE4Aj/pnQ0b0vdFFc2U7U/Al6RatX8qwuQNgFJnJ5lVnT0BjRz9/6GVzgOEwCS
         9MtA==
X-Gm-Message-State: AOAM531QkqH+pfoCPi62vL3l4Efly3z0QZ4ZjbOhrsUtDxMWMjGVMyGV
        J3sPOiZ6iUa+0/BsfQYn3XXnRIgHeo+/K+OlGqzqbg==
X-Google-Smtp-Source: ABdhPJyKk4gruxlTdqkE8fe2I1IShHeFFl7/1k/kyn3YfVRFS+u6GplnznRO3HsGs2I6XGIw/XWU6lSpzHqfriEshgw=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr941798ybb.125.1592423580614;
 Wed, 17 Jun 2020 12:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com> <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
In-Reply-To: <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 17 Jun 2020 22:52:49 +0300
Message-ID: <CAD8XO3bSsgeWjB7SxwR9+=h1PiGeNwCo1UM66-poruRu846L2g@mail.gmail.com>
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

On Wed, 17 Jun 2020 at 18:16, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 6/17/20 3:58 PM, Sumit Garg wrote:
> > Hi Maxim,
> >
> > On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >>
> >> With the evolving use-cases for TEE bus, now it's required to support
> >> multi-stage enumeration process. But using a simple index doesn't
> >> suffice this requirement and instead leads to duplicate sysfs entries.
> >> So instead switch to use more informative device UUID for sysfs entry
> >> like:
> >> /sys/bus/tee/devices/optee-ta-<uuid>
> >>
> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >>  MAINTAINERS                                       | 1 +
> >>  drivers/tee/optee/device.c                        | 9 ++++++---
> >>  3 files changed, 15 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >> new file mode 100644
> >> index 000000000000..0ae04ae5374a
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >> @@ -0,0 +1,8 @@
> >> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> >> +Date:           May 2020
> >> +KernelVersion   5.7
> >> +Contact:        tee-dev@lists.linaro.org
> >> +Description:
> >> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> >> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> >> +               are free to create needed API under optee-ta-<uuid> directory.
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index ecc0749810b0..6717afef2de3 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> >>  L:     tee-dev@lists.linaro.org
> >>  S:     Maintained
> >> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> >>  F:     drivers/tee/optee/
> >>
> >>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> >> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >> index e3a148521ec1..23d264c8146e 100644
> >> --- a/drivers/tee/optee/device.c
> >> +++ b/drivers/tee/optee/device.c
> >> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >>         return 0;
> >>  }
> >>
> >> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >> +static int optee_register_device(const uuid_t *device_uuid)
> >>  {
> >>         struct tee_client_device *optee_device = NULL;
> >>         int rc;
> >> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >>                 return -ENOMEM;
> >>
> >>         optee_device->dev.bus = &tee_bus_type;
> >> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> >> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
> >
> > You should be using format specifier as: "%pUb" instead of "%pUl" as
> > UUID representation for TAs is in big endian format. See below:
>
> Where does device_uuid come from? If it comes directly from OP-TEE, then
> it should be a pointer to the following struct:
>
> typedef struct
> {
>         uint32_t timeLow;
>         uint16_t timeMid;
>         uint16_t timeHiAndVersion;
>         uint8_t clockSeqAndNode[8];
> } TEE_UUID;
>
> (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
>
> - The spec does not mandate any particular endianness and simply warns
> about possible issues if secure and non-secure worlds differ in endianness.
> - OP-TEE uses %pUl assuming that host order is little endian (that is
> true for the Arm platforms that run OP-TEE currently). By the same logic
> %pUl should be fine in the kernel.
> - On the other hand, the UUID in a Trusted App header is always encoded
> big endian by the Python script that signs and optionally encrypts the
> TA. This should not have any visible impact on UUIDs exchanged between
> the secure and non-secure world though.
>
> So I am wondering why you had to use %pUb. There must be some
> inconsistency somewhere :-/
>
> --
> Jerome

From  linux side it is for example:

static const struct tee_client_device_id optee_ftpm_id_table[] = {
        {UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
                   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
        {}
};

static struct tee_client_driver ftpm_tee_driver = {
        .id_table       = optee_ftpm_id_table,
        .driver         = {

So sysfs name has to be the same as the driver has. And  UUD is simple
16 bytes:#define UUID_SIZE 16
typedef struct {
        __u8 b[UUID_SIZE];
} uuid_t;

From TA it also:
#define TA_UUID  { 0xBC50D971, 0xD4C9, 0x42C4, \
        {0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96}}

Compare uuid from optee and kernel driver version is simple:
static inline bool uuid_equal(const uuid_t *u1, const uuid_t *u2)
{
        return memcmp(u1, u2, sizeof(uuid_t)) == 0;
}

So to support better code navigation. For example grep sources for
0xBC50D971, or find in sysfs  "*bc50d971-*" I would say we need to use
BE format.
optee might also need to switch to BE prints for the same reason.

Maxim.

>
> >
> > # ls /sys/bus/tee/devices/
> > optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
> > optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
> > optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c
> >
> > While UUID for fTPM TA is in big endian format:
> > bc50d971-d4c9-42c4-82cb-343fb7f37896
> >
> > Sorry that I missed it during review and noticed this while testing.
> >
> > With the above fix included, I tested this series using fTPM early TA
> > on Qemu for aarch64 and used basic random number generation test using
> > tpm2-tools. So feel free to add:
> >
> > Tested-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > -Sumit
> >
> >> +               kfree(optee_device);
> >> +               return -ENOMEM;
> >> +       }
> >>         uuid_copy(&optee_device->id.uuid, device_uuid);
> >>
> >>         rc = device_register(&optee_device->dev);
> >> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
> >>         num_devices = shm_size / sizeof(uuid_t);
> >>
> >>         for (idx = 0; idx < num_devices; idx++) {
> >> -               rc = optee_register_device(&device_uuid[idx], idx);
> >> +               rc = optee_register_device(&device_uuid[idx]);
> >>                 if (rc)
> >>                         goto out_shm;
> >>         }
> >> --
> >> 2.17.1
> >>
> > _______________________________________________
> > Tee-dev mailing list
> > Tee-dev@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/tee-dev
> >
