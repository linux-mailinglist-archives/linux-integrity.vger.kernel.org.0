Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D2E1DFD6C
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2020 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgEXGWY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 May 2020 02:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgEXGWY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 May 2020 02:22:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34784C05BD43
        for <linux-integrity@vger.kernel.org>; Sat, 23 May 2020 23:22:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m67so2895691oif.4
        for <linux-integrity@vger.kernel.org>; Sat, 23 May 2020 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qlSjb7Ei/x9qd8KQ7QRxYOlpQIZj8+odUUmDu647yk=;
        b=q/S5yvkVVybx5H6i1wV1gnfaS6TRnh7d6B/tfdUnmCqhQ/dLDhQ4THaUZf8gFPxU1u
         jPWhHfJ7DnUL2gJhmrcYbRv3vvipdx8Y0nScRt4ZDDaO/UwZdHC4l52UhdWRvNowItdb
         6zPlSL4Qg9K4Y2zhdO4jYwvOe6oiTh9A6c7gtoknWGJSPibaK2MIJF1qLa9DEqTVXECG
         +eoIDwNvztQd+jh7FFvu2stnuzDCt93mZ0ZE048GDdS0ffASXuiaL2TikJ/pMwcGXSZC
         jzd+B8tVveq1H7yKhBmCC2KRvRsjPH41K5nB2NV44KzF+i6txo7BFcGtXOjjbSJ6htDE
         K/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qlSjb7Ei/x9qd8KQ7QRxYOlpQIZj8+odUUmDu647yk=;
        b=LHT1EtFR5nD/Fa4VxYApH9j7V3vdhmqd52SVnyKtLmc1+bjHMQF4TXkvFH1P/TVqv3
         i6df9nNZQAGIXEQ3/AlbBr33VUcr7aOQ0rrHChxJZVEeyR5mBUQXPSQ55cftzUaaJwet
         HGoV+hTfA2C/GYv3iQ3U9obTOYeAVKY2ob1uOJ6VnrXezi6L8XaCZKYvO9q81+vYz3Jt
         vS9G3I4/ioEDGMK6BeOBr6suJgiCj8pfZ1yQs7yv9CmWj+hmgZGT5DbYjCaWIIVbodeP
         DGIU0mIs967CImIz1JcHoa/VKOG/Ck5SfB9hY0kmrDd0H1DRvJBtPytnwLeRLwYDbemC
         g00Q==
X-Gm-Message-State: AOAM533V/Qju7ree5VLOuo2EsEtz4VH7jmitbkZLpoRYsRqqrIQGpcmu
        lEZj8ajZ0MpJ+uPuOz7GEa7O6H7TG0sO6qDxAH3GBw==
X-Google-Smtp-Source: ABdhPJwwOmnAuUFeqjFIXuR6p5rPR3A+H/vEznsVop4gc7BgeJ0Hcd2A31vi6oM8POELfmx/7i+VND9YRq3KOCNayK0=
X-Received: by 2002:aca:c341:: with SMTP id t62mr8042580oif.5.1590301343183;
 Sat, 23 May 2020 23:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org> <20200521064743.4769-2-maxim.uvarov@linaro.org>
In-Reply-To: <20200521064743.4769-2-maxim.uvarov@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Sun, 24 May 2020 08:22:12 +0200
Message-ID: <CAHUa44Fp0e0Q_ZPX_5RuX+6xO_yGQ0n_+Kh207ZV1GZteXKf1w@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] optee: do drivers initialization before and after
 tee-supplicant run
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maxim,

On Thu, May 21, 2020 at 8:47 AM Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Some drivers (like ftpm) can operate only after tee-supplicant
> runs becase of tee-supplicant provides things like storage
> services.  This patch splits probe of non tee-supplicant dependable
> drivers to early stage, and after tee-supplicant run probe other
> drivers.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 25 ++++++++++++++++++++++---
>  drivers/tee/optee/device.c        | 17 +++++++++++------
>  drivers/tee/optee/optee_private.h |  8 +++++++-
>  3 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 99698b8a3a74..dd2265c44907 100644
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
> @@ -218,6 +219,15 @@ static void optee_get_version(struct tee_device *teedev,
>         *vers = v;
>  }
>
> +static void optee_bus_scan(struct work_struct *work)
> +{
> +       int rc;
> +
> +       rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP);
> +       if (rc)
> +               pr_err("optee_enumerate_devices failed %d\n", rc);
> +}
> +
>  static int optee_open(struct tee_context *ctx)
>  {
>         struct optee_context_data *ctxdata;
> @@ -241,8 +251,15 @@ static int optee_open(struct tee_context *ctx)
>                         kfree(ctxdata);
>                         return -EBUSY;
>                 }
> -       }
>
> +               INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> +               optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> +               if (!optee->scan_bus_wq) {
> +                       pr_err("optee: couldn't create workqueue\n");
> +                       return -ECHILD;
> +               }
> +               queue_work(optee->scan_bus_wq, &optee->scan_bus_work);

Shouldn't this be done only the first time tee-supplicant opens the
device? Normally tee-supplicant only does this once, but it might get
restarted for some reason.

> +       }
>         mutex_init(&ctxdata->mutex);
>         INIT_LIST_HEAD(&ctxdata->sess_list);
>
> @@ -296,8 +313,10 @@ static void optee_release(struct tee_context *ctx)
>
>         ctx->data = NULL;
>
> -       if (teedev == optee->supp_teedev)
> +       if (teedev == optee->supp_teedev) {
> +               destroy_workqueue(optee->scan_bus_wq);
>                 optee_supp_release(&optee->supp);
> +       }
>  }
>
>  static const struct tee_driver_ops optee_ops = {
> @@ -675,7 +694,7 @@ static int optee_probe(struct platform_device *pdev)
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
> index d9c5037b4e03..6cdac4bb7253 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -78,6 +78,8 @@ struct optee_supp {
>   * @memremaped_shm     virtual address of memory in shared memory pool
>   * @sec_caps:          secure world capabilities defined by
>   *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> + * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
> + * @scan_bus_work      workq to scan optee bus and register optee drivers
>   */
>  struct optee {
>         struct tee_device *supp_teedev;
> @@ -89,6 +91,8 @@ struct optee {
>         struct tee_shm_pool *pool;
>         void *memremaped_shm;
>         u32 sec_caps;
> +       struct workqueue_struct *scan_bus_wq;
> +       struct work_struct scan_bus_work;
>  };
>
>  struct optee_session {
> @@ -173,7 +177,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
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
