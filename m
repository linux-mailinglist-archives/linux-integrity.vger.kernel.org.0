Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035F1EA1B0
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFAKSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 06:18:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B0C03E96F
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 03:18:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u10so6186520ljj.9
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HquwRVf5iVAHizexA8wd0ew/QtbdnQ1DuDuzxnJDRok=;
        b=lkl7jVn6/AB7y8qR8D0U9TeHOhfWLC0G8/FqxkdaC6D9rxR3FjmD5jMcdCYZORPND9
         /oajDXm/DMm28amG/0qmtSSTp/tH0RGQEdarpo/aVn4Sty7m3AL4oA0w6BLIbtL1+u6Z
         PiuVeemRlIFITsz8+xbiULxWUzg5/KCpZb5B7FoDj1Lc3NTLZIspw+vWXPmWE4D9gdqA
         ScX0eNNNETGG2FtSmakcaFdP1arH+l242QQ0U51cHuhgSoWugUHqpIxDZyhGaggKVySB
         T1+cHvjTe2MIroL7RwlQ7a8zFw5r+/tMfVlMDvrSaWwYaVBRX7gjO/yRCgHwV6dmdxZz
         gIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HquwRVf5iVAHizexA8wd0ew/QtbdnQ1DuDuzxnJDRok=;
        b=ZNWlJi//NQ+kkp4YXSDz3SGo1edVDrcEYb7PPxnMEBjXp/LVCwAwutS4CG+DVdF2vf
         neZDYWxq7XPlTeLZPMWaGKiXsb+wRuWltE+YcP/wUD2BUHQWBIuU1zUSAF6/wqnieKex
         SPCG3Qb+jFxblTbgMTmkBlHqj7vKvitb2ZfKdxly12kwd71SEecvj5O5v3aEkWmpQXNc
         Z+3YqAdhTuz7G0XxFP6QXVwKaKSuk4cs0G5g7VsozLNW/76h5tXUd+SzCcL+CMaAF837
         JvvHRjcfw8/8BCMf445khrqJIUh5cbyq2HwMEgi2JhXufnViPElU61c5Rl2jkA3Agdi8
         Hm5g==
X-Gm-Message-State: AOAM533vHOgmZXi30bhQByUixeRPN9ay+z/+vpw97h2JLTVvzmtaH2Jr
        teVy33zCj6UZxXAhJtlFNx6SFIQzqzIxfvx2q7mmeg==
X-Google-Smtp-Source: ABdhPJwXW9FGc4nu18gFE4dR+dMU9RwFvaEw15ZRkWgGU/NnYA8gSgVJ7FTjzNEBBc1QpY4/CLUPtwyp6yCrsr2ScuE=
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr9797163ljk.4.1591006680658;
 Mon, 01 Jun 2020 03:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200529082701.13457-1-maxim.uvarov@linaro.org> <20200529082701.13457-3-maxim.uvarov@linaro.org>
In-Reply-To: <20200529082701.13457-3-maxim.uvarov@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 15:47:49 +0530
Message-ID: <CAFA6WYM3cg2Z2aB=0oO5mp6tXhVtvGZSTr5DTeaBvnpekH8aBA@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] optee: use uuid for sysfs driver entry
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
> OP-TEE device names for sysfs need to be unique
> and it's better if they will mean something. UUID for name
> looks like good solution:
> /sys/bus/tee/devices/optee-ta-<uuid>
>

I think this description is a little vague here which fails to explain
why we are doing this. How about:

=======
With the evolving use-cases for TEE bus, now it's required to support
multi-stage enumeration process. But using a simple index doesn't
suffice this requirement and instead leads to duplicate sysfs entries.
So instead switch to use more informative device UUID for sysfs entry
like:

/sys/bus/tee/devices/optee-ta-<uuid>
========

> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>  MAINTAINERS                                       | 2 ++
>  drivers/tee/optee/device.c                        | 6 +++---
>  3 files changed, 13 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>

I think this patch belongs as patch #1 in this series given the dependency.

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
> index ecc0749810b0..52717ede29fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12516,8 +12516,10 @@ OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>  L:     tee-dev@lists.linaro.org
>  S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:     drivers/tee/optee/
>
> +

Unnecessary blank line.

-Sumit

>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:     Sumit Garg <sumit.garg@linaro.org>
>  L:     tee-dev@lists.linaro.org
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index d4931dad07aa..2eb1c0283aec 100644
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
> @@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>                 return -ENOMEM;
>
>         optee_device->dev.bus = &tee_bus_type;
> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> +       dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
>         uuid_copy(&optee_device->id.uuid, device_uuid);
>
>         rc = device_register(&optee_device->dev);
> @@ -144,7 +144,7 @@ static int __optee_enumerate_devices(u32 func)
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
