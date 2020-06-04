Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5F1EE0FA
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFDJQe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgFDJQd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 05:16:33 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0CC03E96D
        for <linux-integrity@vger.kernel.org>; Thu,  4 Jun 2020 02:16:33 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j202so1360791ybg.6
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ/1OA1lIfkBZzGhY/7MgoW8R4VpB8ChGNgUuwxq9eI=;
        b=lpIhailSAHTDLeRhiB9ZtjJ0QiY2pjYaNPivllIVOQxUjafhECX7wzRtPm4wt7ocGZ
         yIbe1HyFhPgCisQUbqfx4i5UTJ5spb9z0ySzBeeyPv+gXmwFG3ZYC5kRwNQZxS+D+UZI
         IMiV4/wQ2SnGXxUM6FCEj+n7rkLfLw9Z29pOzfpC+U+ceurlbYVa3XM5eQMD+mLTtp1U
         YRXfrfrG+RfHNQvtuSIfDBxFFe1Ep8fBxsXs5+t9LnbPCo+SYJ6fRBE+r+MMyW12hmw6
         KRVkpIYXpAX8/yW8Ywf2uKYpf2mAW8DZwzfMfFsI1F2qMHFeFIsnQG0cc0xzdfsQogyL
         JyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ/1OA1lIfkBZzGhY/7MgoW8R4VpB8ChGNgUuwxq9eI=;
        b=jgR7b8MXf6Ahg4NhCn/eUyIFhjzbpdgfXNlFkUgCM2CR3wuHRGYwYX4qP7aS+vw5g2
         b0hzy3EB4XJldvag1IhX7KLYtU1bPK7nK5L+f2irNSjsjD0pPZ5TUyInpro+pR5VVBOW
         RPZJPZfHaYOk2o4+IfIFBAnw3NHbHD29qfMM/oj76jy48cunPQWcGcg81eVX1nd78BKf
         9XFLnai9YiDjl7Ag8VehfhVQlBvjcTEM10zEMXugVpYrcRCZwVoTilCThDtdya2bshzd
         XIQ/4zHF8vvKQTl1fyKl4NyDT8/EZ0e3/LiiLj47u14eISkCroZSpinYPNSTZJT09Kvw
         5Iqg==
X-Gm-Message-State: AOAM531X2l2BzWBG1tvvd2HwXip0NMDYzDTcB0zpw/Y3vagtYfbSTjaf
        hYEisshUjhUlqsTJFQqH3eJsP7meCydBrFTNill73g==
X-Google-Smtp-Source: ABdhPJznz7G/EiOx2AkWCjZzyX47+72QghNX17aKbkdplodgFQ31LTBq32m8EB6m6azYa8JVUqYhyHay+txWPeD0zw0=
X-Received: by 2002:a5b:345:: with SMTP id q5mr6093715ybp.494.1591262192787;
 Thu, 04 Jun 2020 02:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
 <20200601150645.13412-2-maxim.uvarov@linaro.org> <20200604083655.GA4026@linux.intel.com>
In-Reply-To: <20200604083655.GA4026@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 4 Jun 2020 12:16:21 +0300
Message-ID: <CAD8XO3b4K6ozHwKf2NDJ482JQY6CPXKKxRuZgo5snP16i_5E=Q@mail.gmail.com>
Subject: Re: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 4 Jun 2020 at 11:37, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 06:06:43PM +0300, Maxim Uvarov wrote:
> > With the evolving use-cases for TEE bus, now it's required to support
> > multi-stage enumeration process. But using a simple index doesn't
> > suffice this requirement and instead leads to duplicate sysfs entries.
> > So instead switch to use more informative device UUID for sysfs entry
> > like:
> > /sys/bus/tee/devices/optee-ta-<uuid>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> Why do you mean by duplicate sysfs entries?
>

Without this change it will try to register something like that:
first stage w/o tee-supplicant:
/sys/bus/tee/devices/optee-clnt0
/sys/bus/tee/devices/optee-clnt1
/sys/bus/tee/devices/optee-clnt3
Then with tee-supplicant also index started with 0. I.e.
/sys/bus/tee/devices/optee-clnt0
/sys/bus/tee/devices/optee-clnt1
...

So we need to increase global index or use some other unique names.



> > ---
> >  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >  MAINTAINERS                                       | 1 +
> >  drivers/tee/optee/device.c                        | 6 +++---
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > new file mode 100644
> > index 000000000000..0ae04ae5374a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > @@ -0,0 +1,8 @@
> > +What:                /sys/bus/tee/devices/optee-ta-<uuid>/
> > +Date:           May 2020
> > +KernelVersion   5.7
> > +Contact:        tee-dev@lists.linaro.org
> > +Description:
> > +             OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> > +             matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> > +             are free to create needed API under optee-ta-<uuid> directory.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ecc0749810b0..6717afef2de3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >  M:   Jens Wiklander <jens.wiklander@linaro.org>
> >  L:   tee-dev@lists.linaro.org
> >  S:   Maintained
> > +F:   Documentation/ABI/testing/sysfs-bus-optee-devices
> >  F:   drivers/tee/optee/
> >
> >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index e3a148521ec1..ed3d1ddfa52b 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >       return 0;
> >  }
> >
> > -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > +static int optee_register_device(const uuid_t *device_uuid)
> >  {
> >       struct tee_client_device *optee_device = NULL;
> >       int rc;
> > @@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >               return -ENOMEM;
> >
> >       optee_device->dev.bus = &tee_bus_type;
> > -     dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > +     dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
>
> This code is and already was broken. If dev_set_name() returns -ENOMEM,
> the name will be a null pointer.
>

Well in the current code base only 1% of drivers check the return code
of dev_set_name(). But I don't  mind adding this check.


> Also, I don't get how you can just swap the name without potentially
> breaking the backwards compatiblity towards the user space.
>
> /Jarkko

Backwards compatibility to what? API (stable, testing) are defined in
Documentation. There was no doc for that. And user get notifications
on uevent, so it's udev deal how to find proper sysfs entry.

Regards,
Maxim.
