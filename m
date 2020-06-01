Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26351EA21A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgFAKqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKqH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 06:46:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE60C061A0E
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 03:46:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so3611825lff.13
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjhmAPEKNow7E1vW8s3ASEs0uGQtIO9UoGk5GAxoJ48=;
        b=Mod4ncWfP0u3c9DVUfv0x5U7NxZj4ctI1Zutm0PEe9JCAjok93XNX1N88SQ20xWLU+
         2ZJilDZ7kW/91hV4FSWulFzF2TuqLJznMbjcOYqp6GJf/Na9gcftf8IX8u5ZJgWMxJAY
         2sfh1CDLU+mbGuMUW15FOy224F8LEHACUOS4wsw6O1HJN+nb0TDh2ZvshdVuB4+MnOCK
         dkoWnL1CSx882omRa1xxe85IalpJgZm3tuczHlG8kjtX8Zx+LsTLxxDu7ByVyrxg9ovU
         qHudTXnjrLU4IXgBWuf1t1Tutif0lZZxEFXQ9LmpXl81aK+yoA/MD0KoGettgDxPi1FE
         PANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjhmAPEKNow7E1vW8s3ASEs0uGQtIO9UoGk5GAxoJ48=;
        b=BeuH6qImJqt8Bw8QWlu80AT+KABv625oZdFTmarjffcklduWHnBv5SRv1bJP2UTIYn
         XJw2ZRG/CH+7ahk8s3IhuhTiCclp9SDf+SKLusoFoSBEqY1jKm+MjrpwG9OVw0aOqLgk
         P9NKSljQsVnrxbsn3VHYGuFXi67hOCL+LsZ8tpNQ93jl/QahQ+6P21kheZ51PhY0tfT9
         gnfefEITjhaNqzFmsUktmqlmwv6rkPXUg3bnWuywXqtylCrCTj7aHltDOsSeXWViD4tG
         rxttDeK1le3q5N2MIBm54vHfaepOqjhtOuziK9hlJomP0S+J9FANxBeJz83CA+fVyHM/
         Y96w==
X-Gm-Message-State: AOAM530YF+638G9mwNr0BGvO5SnPfNwtAjriXndN8uIhzlJXijaqK3BG
        /FIbmMZszLdav3kSZ/ByfAfrkddW++2IGoEYN6QrHsfLBbc=
X-Google-Smtp-Source: ABdhPJzC8ARUtRKcCeGMzGx9R8piBFDgHvxT1yEWYNe6pCqFfY5ck8AQhTqj2ZcKnel00mrL2z1oZBjL1EaaY6rE7Wc=
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr11290775lfm.59.1591008365696;
 Mon, 01 Jun 2020 03:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200529082701.13457-1-maxim.uvarov@linaro.org> <20200529082701.13457-2-maxim.uvarov@linaro.org>
In-Reply-To: <20200529082701.13457-2-maxim.uvarov@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 16:15:53 +0530
Message-ID: <CAFA6WYOoZMUMVJbUrxRyYZKPPD-tfaioWqaCkuFs4+g7jmhY5Q@mail.gmail.com>
Subject: Re: [PATCHv5 1/3] optee: do drivers initialization before and after
 tee-supplicant run
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
> Some drivers (like ftpm) can operate only after tee-supplicant
> runs because of tee-supplicant provides things like storage
> services.  This patch splits probe of non tee-supplicant dependable
> drivers to the early stage, and after tee-supplicant run probe other
> drivers.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 24 +++++++++++++++++++++---
>  drivers/tee/optee/device.c        | 17 +++++++++++------
>  drivers/tee/optee/optee_private.h | 10 +++++++++-
>  3 files changed, 41 insertions(+), 10 deletions(-)
>

Commit subject sounds a little vague, so how about:

====
optee: enable support for multi-stage bus enumeration
====

Then in the commit description, you can elaborate on what it actually means.

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 99698b8a3a74..bf0851fdf108 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
>  #include "shm_pool.h"
> @@ -218,6 +219,11 @@ static void optee_get_version(struct tee_device *teedev,
>         *vers = v;
>  }
>
> +static void optee_bus_scan(struct work_struct *work)
> +{
> +       WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> +}
> +
>  static int optee_open(struct tee_context *ctx)
>  {
>         struct optee_context_data *ctxdata;
> @@ -241,8 +247,18 @@ static int optee_open(struct tee_context *ctx)
>                         kfree(ctxdata);
>                         return -EBUSY;
>                 }
> -       }
>
> +               if (!optee->scan_bus_done) {
> +                       INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> +                       optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> +                       if (!optee->scan_bus_wq) {
> +                               kfree(ctxdata);
> +                               return -ECHILD;
> +                       }
> +                       queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
> +                       optee->scan_bus_done = true;
> +               }
> +       }
>         mutex_init(&ctxdata->mutex);
>         INIT_LIST_HEAD(&ctxdata->sess_list);
>
> @@ -296,8 +312,10 @@ static void optee_release(struct tee_context *ctx)
>
>         ctx->data = NULL;
>
> -       if (teedev == optee->supp_teedev)
> +       if (teedev == optee->supp_teedev) {
> +               destroy_workqueue(optee->scan_bus_wq);

Doesn't it deserve a prior check "if(optee->scan_bus_wq)" as we only
allocate it once during multiple tee-supplicant instances?

>                 optee_supp_release(&optee->supp);
> +       }
>  }
>
>  static const struct tee_driver_ops optee_ops = {
> @@ -675,7 +693,7 @@ static int optee_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, optee);
>
> -       rc = optee_enumerate_devices();
> +       rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
>         if (rc) {
>                 optee_remove(pdev);
>                 return rc;
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index e3a148521ec1..d4931dad07aa 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -21,7 +21,6 @@
>   * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
>   * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
>   */

This comment needs to be moved as well.

> -#define PTA_CMD_GET_DEVICES            0x0
>
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> @@ -32,7 +31,8 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  }
>
>  static int get_devices(struct tee_context *ctx, u32 session,
> -                      struct tee_shm *device_shm, u32 *shm_size)
> +                      struct tee_shm *device_shm, u32 *shm_size,
> +                      u32 func)
>  {
>         int ret = 0;
>         struct tee_ioctl_invoke_arg inv_arg;
> @@ -42,7 +42,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>         memset(&param, 0, sizeof(param));
>
>         /* Invoke PTA_CMD_GET_DEVICES function */

You can get rid of this comment.

-Sumit

> -       inv_arg.func = PTA_CMD_GET_DEVICES;
> +       inv_arg.func = func;
>         inv_arg.session = session;
>         inv_arg.num_params = 4;
>
> @@ -87,7 +87,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>         return rc;
>  }
>
> -int optee_enumerate_devices(void)
> +static int __optee_enumerate_devices(u32 func)
>  {
>         const uuid_t pta_uuid =
>                 UUID_INIT(0x7011a688, 0xddde, 0x4053,
> @@ -118,7 +118,7 @@ int optee_enumerate_devices(void)
>                 goto out_ctx;
>         }
>
> -       rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
> +       rc = get_devices(ctx, sess_arg.session, NULL, &shm_size, func);
>         if (rc < 0 || !shm_size)
>                 goto out_sess;
>
> @@ -130,7 +130,7 @@ int optee_enumerate_devices(void)
>                 goto out_sess;
>         }
>
> -       rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> +       rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size, func);
>         if (rc < 0)
>                 goto out_shm;
>
> @@ -158,3 +158,8 @@ int optee_enumerate_devices(void)
>
>         return rc;
>  }
> +
> +int optee_enumerate_devices(u32 func)
> +{
> +       return  __optee_enumerate_devices(func);
> +}
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index d9c5037b4e03..8b71839a357e 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -78,6 +78,9 @@ struct optee_supp {
>   * @memremaped_shm     virtual address of memory in shared memory pool
>   * @sec_caps:          secure world capabilities defined by
>   *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> + * @scan_bus_done      flag if device registation was already done.
> + * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
> + * @scan_bus_work      workq to scan optee bus and register optee drivers
>   */
>  struct optee {
>         struct tee_device *supp_teedev;
> @@ -89,6 +92,9 @@ struct optee {
>         struct tee_shm_pool *pool;
>         void *memremaped_shm;
>         u32 sec_caps;
> +       bool   scan_bus_done;
> +       struct workqueue_struct *scan_bus_wq;
> +       struct work_struct scan_bus_work;
>  };
>
>  struct optee_session {
> @@ -173,7 +179,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
>  void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
>                            size_t page_offset);
>
> -int optee_enumerate_devices(void);
> +#define PTA_CMD_GET_DEVICES            0x0
> +#define PTA_CMD_GET_DEVICES_SUPP       0x1
> +int optee_enumerate_devices(u32 func);
>
>  /*
>   * Small helpers
> --
> 2.17.1
>
