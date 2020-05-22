Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374E1DE6B9
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEVMXl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgEVMXk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 08:23:40 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A699C061A0E
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 05:23:40 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a10so4525875ybc.3
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsdReYatT6a5FIcGkwI//zLnddXShKcRngV1orCIFPw=;
        b=HV/+hdOSIDErNcmwp5+kBkvzrlpKxIGRZqBF7uT0PaL1CJLzcT58T4CEipkfqnyQBK
         U8DaKpKiKEGtbTpB8KPfGiadcw324OdUz00DN3MfY5duKkyElMVlotTsPZdx/2BcENZY
         rowJfUE+xSOVxe24qbCVm08tZVx3o4+9HSgGjCJlFLKxw2MGew1Y7njKQC1/sQnrijFo
         5pZ5IIYIT34w9KsXWlyewKAYmUU+dskGI7imfHoFmOaipcNFiFC7HoJvSPIeOG5JAanx
         cgxqPh5ILfF3s/kS807bSB+zROnjLiXPQmdM0ls8resLUDNFRVwp+0U2ivGZcm1hL0jT
         LOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsdReYatT6a5FIcGkwI//zLnddXShKcRngV1orCIFPw=;
        b=IU8MC+l1aPbU41Wxbecm6yDBuYhIBFjY9eEGii2hmYrBhP/9uSdYQaj6EAgWXqN8gx
         l0y/G4gO2I5bTAMnGLqusWIe4Y7I4zwd8LCHa73wEZkt4OeoVD/UMwgbVSlZe+j3jsD/
         TJMmmBEInQ8B18Uu8YovUv4byD+pi6lYcBMxgdP0dmEyiXzBXxQyCGq1AD9LqGyAUWaI
         a1DDoF1/hK2QY06n6auCD0F3VKg5Erzj7fqF6NYIT8C98uQlGkZJGgZbs6Mmu7O8Dm5G
         vnPYT9T3YnyZNtfcP+Ira+ub8ryGAiN1z7CRW4Ee4Ks62nPckNSDYR6t0c6LoQebOaHE
         Dlhg==
X-Gm-Message-State: AOAM531OtN+iByaRzJ/yMjG4uHPOvrHxcLPz1i0sHMhlDz7r3D1xptls
        Bo/5dSMMaX+sb3esqiLPlbcrSzAMTYDkFnyU3aKWaw==
X-Google-Smtp-Source: ABdhPJyyKCJBaSzdS67vlq+99wPNUQ8mM7QYWURPYR70sXhf5tCpRnyvXYSajpt/63syeEUjjGjRJI79/CETKdMt6rM=
X-Received: by 2002:a25:ba92:: with SMTP id s18mr22072283ybg.291.1590150219374;
 Fri, 22 May 2020 05:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-2-maxim.uvarov@linaro.org> <CAFA6WYOWj4umG+c7nDxeH-dm+W9uMxQPKvT_hKrYTd81af7HLA@mail.gmail.com>
In-Reply-To: <CAFA6WYOWj4umG+c7nDxeH-dm+W9uMxQPKvT_hKrYTd81af7HLA@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Fri, 22 May 2020 15:23:28 +0300
Message-ID: <CAD8XO3adZ5g+8_T4t7=T+pTWDNRr_ydY3PQs50yVOwsphC5HBg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] optee: do drivers initialization before and after
 tee-supplicant run
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Fri, 22 May 2020 at 14:40, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Maxim,
>
> On Thu, 21 May 2020 at 12:17, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > Some drivers (like ftpm) can operate only after tee-supplicant
> > runs becase of tee-supplicant provides things like storage
> > services.  This patch splits probe of non tee-supplicant dependable
> > drivers to early stage, and after tee-supplicant run probe other
> > drivers.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> > Suggested-by: Arnd Bergmann <arnd@linaro.org>
> > ---
> >  drivers/tee/optee/core.c          | 25 ++++++++++++++++++++++---
> >  drivers/tee/optee/device.c        | 17 +++++++++++------
> >  drivers/tee/optee/optee_private.h |  8 +++++++-
> >  3 files changed, 40 insertions(+), 10 deletions(-)
> >
>
> This patch still doesn't seem to address the issue (duplicate devices
> leading to sysfs registration failure) that was pointed during OP-TEE
> patch review [1].
>
> You could reproduce it simply with one TA having TA_FLAG_DEVICE_ENUM
> flag and other TA having TA_FLAG_DEVICE_ENUM_SUPP flag.
>
> [1] https://github.com/OP-TEE/optee_os/pull/3840#discussion_r425144487
>
> -Sumit

Ah, yes. I will send an updated version.

Maxim.

>
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 99698b8a3a74..dd2265c44907 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/workqueue.h>
> >  #include "optee_private.h"
> >  #include "optee_smc.h"
> >  #include "shm_pool.h"
> > @@ -218,6 +219,15 @@ static void optee_get_version(struct tee_device *teedev,
> >         *vers = v;
> >  }
> >
> > +static void optee_bus_scan(struct work_struct *work)
> > +{
> > +       int rc;
> > +
> > +       rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP);
> > +       if (rc)
> > +               pr_err("optee_enumerate_devices failed %d\n", rc);
> > +}
> > +
> >  static int optee_open(struct tee_context *ctx)
> >  {
> >         struct optee_context_data *ctxdata;
> > @@ -241,8 +251,15 @@ static int optee_open(struct tee_context *ctx)
> >                         kfree(ctxdata);
> >                         return -EBUSY;
> >                 }
> > -       }
> >
> > +               INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> > +               optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> > +               if (!optee->scan_bus_wq) {
> > +                       pr_err("optee: couldn't create workqueue\n");
> > +                       return -ECHILD;
> > +               }
> > +               queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
> > +       }
> >         mutex_init(&ctxdata->mutex);
> >         INIT_LIST_HEAD(&ctxdata->sess_list);
> >
> > @@ -296,8 +313,10 @@ static void optee_release(struct tee_context *ctx)
> >
> >         ctx->data = NULL;
> >
> > -       if (teedev == optee->supp_teedev)
> > +       if (teedev == optee->supp_teedev) {
> > +               destroy_workqueue(optee->scan_bus_wq);
> >                 optee_supp_release(&optee->supp);
> > +       }
> >  }
> >
> >  static const struct tee_driver_ops optee_ops = {
> > @@ -675,7 +694,7 @@ static int optee_probe(struct platform_device *pdev)
> >
> >         platform_set_drvdata(pdev, optee);
> >
> > -       rc = optee_enumerate_devices();
> > +       rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
> >         if (rc) {
> >                 optee_remove(pdev);
> >                 return rc;
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index e3a148521ec1..d4931dad07aa 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -21,7 +21,6 @@
> >   * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> >   * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
> >   */
> > -#define PTA_CMD_GET_DEVICES            0x0
> >
> >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> >  {
> > @@ -32,7 +31,8 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> >  }
> >
> >  static int get_devices(struct tee_context *ctx, u32 session,
> > -                      struct tee_shm *device_shm, u32 *shm_size)
> > +                      struct tee_shm *device_shm, u32 *shm_size,
> > +                      u32 func)
> >  {
> >         int ret = 0;
> >         struct tee_ioctl_invoke_arg inv_arg;
> > @@ -42,7 +42,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >         memset(&param, 0, sizeof(param));
> >
> >         /* Invoke PTA_CMD_GET_DEVICES function */
> > -       inv_arg.func = PTA_CMD_GET_DEVICES;
> > +       inv_arg.func = func;
> >         inv_arg.session = session;
> >         inv_arg.num_params = 4;
> >
> > @@ -87,7 +87,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >         return rc;
> >  }
> >
> > -int optee_enumerate_devices(void)
> > +static int __optee_enumerate_devices(u32 func)
> >  {
> >         const uuid_t pta_uuid =
> >                 UUID_INIT(0x7011a688, 0xddde, 0x4053,
> > @@ -118,7 +118,7 @@ int optee_enumerate_devices(void)
> >                 goto out_ctx;
> >         }
> >
> > -       rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
> > +       rc = get_devices(ctx, sess_arg.session, NULL, &shm_size, func);
> >         if (rc < 0 || !shm_size)
> >                 goto out_sess;
> >
> > @@ -130,7 +130,7 @@ int optee_enumerate_devices(void)
> >                 goto out_sess;
> >         }
> >
> > -       rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > +       rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size, func);
> >         if (rc < 0)
> >                 goto out_shm;
> >
> > @@ -158,3 +158,8 @@ int optee_enumerate_devices(void)
> >
> >         return rc;
> >  }
> > +
> > +int optee_enumerate_devices(u32 func)
> > +{
> > +       return  __optee_enumerate_devices(func);
> > +}
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index d9c5037b4e03..6cdac4bb7253 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -78,6 +78,8 @@ struct optee_supp {
> >   * @memremaped_shm     virtual address of memory in shared memory pool
> >   * @sec_caps:          secure world capabilities defined by
> >   *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> > + * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
> > + * @scan_bus_work      workq to scan optee bus and register optee drivers
> >   */
> >  struct optee {
> >         struct tee_device *supp_teedev;
> > @@ -89,6 +91,8 @@ struct optee {
> >         struct tee_shm_pool *pool;
> >         void *memremaped_shm;
> >         u32 sec_caps;
> > +       struct workqueue_struct *scan_bus_wq;
> > +       struct work_struct scan_bus_work;
> >  };
> >
> >  struct optee_session {
> > @@ -173,7 +177,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
> >  void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
> >                            size_t page_offset);
> >
> > -int optee_enumerate_devices(void);
> > +#define PTA_CMD_GET_DEVICES            0x0
> > +#define PTA_CMD_GET_DEVICES_SUPP       0x1
> > +int optee_enumerate_devices(u32 func);
> >
> >  /*
> >   * Small helpers
> > --
> > 2.17.1
> >
