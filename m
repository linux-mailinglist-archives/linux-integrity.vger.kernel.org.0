Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87411DE5B5
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgEVLk4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgEVLk4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 07:40:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A7C05BD43
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 04:40:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z6so12188271ljm.13
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUwB/tVghw1PL8fq6ymw9A75C4zIH3EAQS0ayEAhcaY=;
        b=GP/2uSzOJ5Xdhl1GiicY1jD4Ht9ry3PDrBxBNLqGEAahNyk75j/3NtvzIHa+vxd26b
         Eb6OmYOiFuitsr4hcMhmmV+6pBUzsLzpEDu1XBPVEl+X691d6xJ2p0HMKpP6+NryBVvv
         x66KssNrQduxm6XixWqeFR+oWK4C7m6lovuZ2jIz6r3H/nVpPaIl2QVF3qKT20mWUpdm
         SY7HP+YIM7lnfiBxq5hcVmb5Nbyg5rlJeI6dDbkrzT2TjqLO77EdIvbVP34VDQNarp6U
         UtXXyOB5kSjqUomewz3qOAM0pUczwNmNMRUZcR8A0/I5c5nYCRyNZsXB1qIybsooJkJj
         LBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUwB/tVghw1PL8fq6ymw9A75C4zIH3EAQS0ayEAhcaY=;
        b=JIVvRRuOIxIjm5KG1D0sVcC72eCWElVHK0YJAQyLFf+pnS5xBD8wJoi3tCKbMs3Mfc
         W8rOUFL/To39v7TiZPVYuMmZeqXcFDhdScVDZY2aw135+rjKVUWygEUtllixextK6Gy0
         VKveF5KpQMeiEm++vIIbtbPEl2MKyZU8trVvn9rsIOvOCIcZgr238WuBimgonBn8Zjr3
         NODLDSpL4NhHCNliDLHRJ8tmBa3o4AXiT+2os1eEmuIxHppSkiKi341bmcgZ1b6BAUcF
         ZOLUYf8yMhhMFzw5a9S+n2vO/l56mAR1iyn+PSSw4dM9DZpWTCUOnG2XB2A2pwqOyGSH
         ZRIA==
X-Gm-Message-State: AOAM530NpaVUGJSWK/ZABacylTcYj1ZXglYGIWqrfoEvLkEuEIIpKGYu
        xnLOXl0xiH2LDyBNOWXoyUFhw7aGWUNSkb1fN19n2g==
X-Google-Smtp-Source: ABdhPJzBIV47w1ACWmbkYZ508hhcV22uCHwdu61X3pIJ8OKcHkRhzkMSP8t97aAYgWiFB/dzQXagtBbwQvHA3FM5zIk=
X-Received: by 2002:a2e:9490:: with SMTP id c16mr7788930ljh.110.1590147654044;
 Fri, 22 May 2020 04:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org> <20200521064743.4769-2-maxim.uvarov@linaro.org>
In-Reply-To: <20200521064743.4769-2-maxim.uvarov@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 22 May 2020 17:10:42 +0530
Message-ID: <CAFA6WYOWj4umG+c7nDxeH-dm+W9uMxQPKvT_hKrYTd81af7HLA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] optee: do drivers initialization before and after
 tee-supplicant run
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maxim,

On Thu, 21 May 2020 at 12:17, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
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

This patch still doesn't seem to address the issue (duplicate devices
leading to sysfs registration failure) that was pointed during OP-TEE
patch review [1].

You could reproduce it simply with one TA having TA_FLAG_DEVICE_ENUM
flag and other TA having TA_FLAG_DEVICE_ENUM_SUPP flag.

[1] https://github.com/OP-TEE/optee_os/pull/3840#discussion_r425144487

-Sumit

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
