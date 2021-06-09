Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587D53A0B4B
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 06:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhFIEb3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Jun 2021 00:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhFIEb3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Jun 2021 00:31:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1AC06175F
        for <linux-integrity@vger.kernel.org>; Tue,  8 Jun 2021 21:29:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j20so6495736lfe.8
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jun 2021 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s49P6l+xu1vflFN4QLmJCfSZvBVyezq9InIWh0eoZY8=;
        b=rblvkurEZ17edKlzUlvor2BKX1S4M5Ir5iIXrAatPAyVLSAunLl8VWTIpV5DJCZu48
         4f3X/0WA+TpUlXW9X6yrguwaOAmXWPhjqMe0i9cQcFEvKwhVZeTh61elv+26TbxKGt6i
         rKDj9Ea/1cgs6kMr7FS9VRPl6T13GIUzdUMAYA3Nt13cLwFoi4akncoOJuMJjLo3VqrB
         kdRvKZL0NdxQm4OsqgcroTxcosrvqKNdJmbeQ+cE+aK1AqoXtdXv0dEuoU9k6dKQDDmI
         GOK4D1YBsDLWk5XaOUsMJVu4ytaz6QYHMBJ1y2atqTBdkyUiBKKAq3vwyzDW2ta+zwrv
         l9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s49P6l+xu1vflFN4QLmJCfSZvBVyezq9InIWh0eoZY8=;
        b=JQblgIBisWz6wf64ks9QfivXMcnSYwZwfeJP7pGlatuA0EDTsKvEh/Yf/YwVkdoi0J
         XwhF9sZy4whK5OrGinsxbwrP0zTwBIcBYjx0QztKAn610UPq560g2EEh894KRSHOFNkX
         vyTp7BQxIOU+RHe3bWxw4AqqFBEiPr/UWoIyJpgopIh1UZrOFW467/wdnOsJw6P6tnKQ
         DNYhDckLzeQq9Wlg7sWmFJxrxnLjCvdLm4APwNJ0dMWvGhnxVaEsYizLb+CdlSibSCUl
         3UR7CKWLfbh3h0wPvNM5Pn1WNRJcvD0EYcJ8FacqlbFp0hJ/YxWBhtZlgnMqhMHI5SZM
         iG8A==
X-Gm-Message-State: AOAM53021083WWMoDgxrsI8liX0FEYHcq6Nb9Ll864qRdyUf1+Hd82hG
        jjgdUzFxHIYdTeQgJdJSQ4x932IzuerTcCuxPjFjrw==
X-Google-Smtp-Source: ABdhPJxUXeDd5DBVTOvA07F2QFaCIqI6h2pUgfRQof32+ULWRrzJ2a8Kg2QT/2i1lEyQfjE3cHAhrQv8M0sgzMtaWpE=
X-Received: by 2002:a19:484d:: with SMTP id v74mr17541890lfa.396.1623212957298;
 Tue, 08 Jun 2021 21:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com> <20210609002326.210024-6-tyhicks@linux.microsoft.com>
In-Reply-To: <20210609002326.210024-6-tyhicks@linux.microsoft.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 9 Jun 2021 09:59:04 +0530
Message-ID: <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tyler,

On Wed, 9 Jun 2021 at 05:55, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> Uncouple the registration of dynamic shared memory buffers from the
> TEE_SHM_DMA_BUF flag. Drivers may wish to allocate dynamic shared memory
> regions but do not need them to be backed by a dma-buf when the memory
> region is private to the driver.

In this case drivers should use tee_shm_register() instead where the
memory allocated is actually private to the driver. However, you need
to remove TEE_SHM_DMA_BUF as a mandatory flag for tee_shm_register().
Have a look at an example here [1]. So modifying tee_shm_alloc() for
this purpose doesn't look appropriate to me.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/keys/trusted-keys/trusted_tee.c#n73

-Sumit

>
> Allow callers of tee_shm_alloc() to specify the TEE_SHM_REGISTER flag to
> request registration. If the TEE implementation does not require dynamic
> shared memory to be registered, clear the flag prior to calling the
> corresponding pool alloc function. Update the OP-TEE driver to respect
> TEE_SHM_REGISTER, rather than TEE_SHM_DMA_BUF, when deciding whether to
> (un)register on alloc/free operations. The AMD-TEE driver continues to
> ignore the TEE_SHM_REGISTER flag.
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c |  5 ++---
>  drivers/tee/tee_shm.c        | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index da06ce9b9313..6054343a29fb 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>         shm->paddr = page_to_phys(page);
>         shm->size = PAGE_SIZE << order;
>
> -       if (shm->flags & TEE_SHM_DMA_BUF) {
> +       if (shm->flags & TEE_SHM_REGISTER) {
>                 unsigned int nr_pages = 1 << order, i;
>                 struct page **pages;
>
> @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                         page++;
>                 }
>
> -               shm->flags |= TEE_SHM_REGISTER;
>                 rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
>                                         (unsigned long)shm->kaddr);
>                 kfree(pages);
> @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
>                          struct tee_shm *shm)
>  {
> -       if (shm->flags & TEE_SHM_DMA_BUF)
> +       if (shm->flags & TEE_SHM_REGISTER)
>                 optee_shm_unregister(shm->ctx, shm);
>
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 00472f5ce22e..1c0176550b9c 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER))) {
>                 dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>                 goto err_dev_put;
>         }
>
> +       if (!teedev->desc->ops->shm_register ||
> +           !teedev->desc->ops->shm_unregister) {
> +               /* registration is not required by the TEE implementation */
> +               flags &= ~TEE_SHM_REGISTER;
> +       } else if (flags & TEE_SHM_DMA_BUF) {
> +               /* all dma-buf backed shm allocations are registered */
> +               flags |= TEE_SHM_REGISTER;
> +       }
> +
>         shm->flags = flags | TEE_SHM_POOL;
>         shm->ctx = ctx;
>         if (flags & TEE_SHM_DMA_BUF)
> --
> 2.25.1
>
