Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2281E078C
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgEYHMu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbgEYHMu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 03:12:50 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCEC05BD43
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 00:12:50 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s7so1983148ybo.9
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=292tWDL47tGEqgK2JctPEJkS/zY0hjJfayYxskKKbQs=;
        b=UT+WyGrJr9gNCmGkG4RpI6lIzTgFOgWWzHOe8L+3VGY4M5XR9ierZ09vHle/HdTPem
         pl8ksQeCmwxCIfw+43mxVaVz1s67zN/EN7cgcpj/7uHjltG5isSSMESInnoAm3CI25C4
         5e1kTQqe4mG7o+DnfvQqvDeCulFoIFDvakkJBCsT0AvhTig5slDNgan6ySQawKtRKavz
         Fs2GU3b5es2ThJ/v+KnJp9S2EW79VnqCbPD6AHT68LGXuczWmP7omjXAMISOh4UpmE9n
         H87z0hcaufOXMX31PXS4X1EE94WGYDIJn+qvyo1G4bh5qDROQxzrEyc1OVELwZ8bi5tS
         Q+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=292tWDL47tGEqgK2JctPEJkS/zY0hjJfayYxskKKbQs=;
        b=PeBQujyG6iy8Lp3pf8445+oxYGriMWEBPAX6wFJY9Ge3HaQTzZ0c8+W8RPbPv2/tBQ
         CjuqtbISgyPJ/CEbvdJW1k4SjVVEjOr2mn/iv7LSEM2IM7lDxbA4LkKfr5fmVSYKwmXV
         LN4AvBwmyQ9C4+7XndQGrq/eF7JOmPf1+V0jvHJlIFZl2Q9I0YcV0cyDLd1uSd7VfcMk
         ZHE7NhGHD/QSTHLIOmeAOAIvLjXkMF+/hqVOK73FjEkNV2d8aX0U1mRHIiTv2yr9nO83
         8Ophh7rZ1ieM9x268DYArQ03P1Q5O2FgoK5HvhOEoYYslPeW3VqCnFc/u0/XD3yNGtP6
         1TfQ==
X-Gm-Message-State: AOAM531bF+kQTtnXNft+rhgqg+l6bnfD+P2d14Hy/0wd7AU2VCojrwa0
        ouTOX3QDd2m40VXWrwnDEIo4mmQ+OqNUhP2pK+gInA==
X-Google-Smtp-Source: ABdhPJw3DxYP9XOLSjG+cThbyioB44yNFpnUFuVYqTQCi+SvRxOEts/9n97d8NFFXhwwDit1GYIbNFcSCVQVgR/vDv4=
X-Received: by 2002:a25:209:: with SMTP id 9mr29992243ybc.153.1590390768506;
 Mon, 25 May 2020 00:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-2-maxim.uvarov@linaro.org> <CAHUa44Fp0e0Q_ZPX_5RuX+6xO_yGQ0n_+Kh207ZV1GZteXKf1w@mail.gmail.com>
In-Reply-To: <CAHUa44Fp0e0Q_ZPX_5RuX+6xO_yGQ0n_+Kh207ZV1GZteXKf1w@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 10:12:36 +0300
Message-ID: <CAD8XO3bDeGHPgZj8qkW5Q5NxMKvRZ-Kg+5rnb+46xDLZA+aRHA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] optee: do drivers initialization before and after
 tee-supplicant run
To:     Jens Wiklander <jens.wiklander@linaro.org>
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

On Sun, 24 May 2020 at 09:22, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Maxim,
>
> On Thu, May 21, 2020 at 8:47 AM Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
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
>
> Shouldn't this be done only the first time tee-supplicant opens the
> device? Normally tee-supplicant only does this once, but it might get
> restarted for some reason.
>

Yes, thanks. I will add this to the next version.

Maxim.

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
