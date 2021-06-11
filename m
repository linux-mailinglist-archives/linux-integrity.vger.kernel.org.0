Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2893A42B8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhFKNL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Jun 2021 09:11:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFKNL7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Jun 2021 09:11:59 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5925820B7178;
        Fri, 11 Jun 2021 06:10:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5925820B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623417001;
        bh=cFX671U3VAOO1rKKCXg5GJiP1xXGmaWRUIBcacFH4Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDBWxn+v1/ZN5jni0ww4GOIaqeO3d5q624qRAzW3D1nVwSY1HV57zrn7bNDIyH3pd
         lZbVg+25jFHx+WYu1VwF2Q40Afcw66VB+5ehLCnHQYfQQPfGX9vlJxRGP9VeoYcRXI
         wS+quQFJCZ1EqfH7fJnuDp90AfaeUTcYpDly50/g=
Date:   Fri, 11 Jun 2021 08:09:58 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
Message-ID: <20210611130958.GR4910@sequoia>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-7-tyhicks@linux.microsoft.com>
 <CAFA6WYMcGGkAAWxK2vmM8CNsgTKJpegkZZjJZy4pvXhKe9WGvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMcGGkAAWxK2vmM8CNsgTKJpegkZZjJZy4pvXhKe9WGvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-11 10:46:20, Sumit Garg wrote:
> On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > Uncouple the registration of kernel shared memory buffers from the
> > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
> > shared memory regions but do not need them to be backed by a dma-buf
> > when the memory region is only used by the driver.
> >
> > If the TEE implementation does not require shared memory to be
> > registered, clear the flag prior to calling the corresponding pool alloc
> > function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
> > than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> > alloc/free operations.
> 
> > The AMD-TEE driver continues to ignore the
> > TEE_SHM_REGISTER flag.
> >
> 
> That's the main point that no other TEE implementation would honour
> TEE_SHM_REGISTER and I think it's just the incorrect usage of
> TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.
> 
> > Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
> > shared memory region without the backing of dma-buf.
> >
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/tee/optee/shm_pool.c |  5 ++---
> >  drivers/tee/tee_shm.c        | 13 +++++++++++--
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> >
> 
> This patch is just mixing two separate approaches to TEE shared
> memory. Have a look at alternative suggestions below.
> 
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index da06ce9b9313..6054343a29fb 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >         shm->paddr = page_to_phys(page);
> >         shm->size = PAGE_SIZE << order;
> >
> > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> > +       if (shm->flags & TEE_SHM_REGISTER) {
> 
> Here you can just do following check instead:
> 
>        if (!(shm->flags & TEE_SHM_PRIV)) {

This is a bug fix series that's intended to fix the current and older
kernels. tee_shm_alloc_anon_kernel_buf()/TEE_SHM_PRIV is not present in
older kernels and isn't required to fix these kexec/kdump bugs. Your
suggestion feels like something that should be done in the allocator
rewrite that Jens is working on to clean all of this up going forward.

Tyler

> 
> And this flag needs to be passed from the call sites here [1] [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tee/optee/core.c#n280
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tee/optee/call.c#n186
> 
> >                 unsigned int nr_pages = 1 << order, i;
> >                 struct page **pages;
> >
> > @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >                         page++;
> >                 }
> >
> > -               shm->flags |= TEE_SHM_REGISTER;
> 
> This should remain as it is.
> 
> >                 rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
> >                                         (unsigned long)shm->kaddr);
> >                 kfree(pages);
> > @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> >                          struct tee_shm *shm)
> >  {
> > -       if (shm->flags & TEE_SHM_DMA_BUF)
> > +       if (shm->flags & TEE_SHM_REGISTER)
> 
> Same as above.
> 
> >                 optee_shm_unregister(shm->ctx, shm);
> >
> >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index c65e44707cd6..26a76f817c57 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> > +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER))) {
> 
> No need for this change.
> 
> >                 dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
> >                 return ERR_PTR(-EINVAL);
> >         }
> > @@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >                 goto err_dev_put;
> >         }
> >
> > +       if (!teedev->desc->ops->shm_register ||
> > +           !teedev->desc->ops->shm_unregister) {
> > +               /* registration is not required by the TEE implementation */
> > +               flags &= ~TEE_SHM_REGISTER;
> > +       } else if (flags & TEE_SHM_DMA_BUF) {
> > +               /* all dma-buf backed shm allocations are registered */
> > +               flags |= TEE_SHM_REGISTER;
> > +       }
> > +
> 
> This change isn't required as well as underlying TEE implementation:
> OP-TEE in this case knows how to implement shared memory allocation
> whether to use reserved shared memory pool or dynamic shared memory
> pool. For more details see shared memory pool creation in
> optee_probe().
> 
> >         shm->flags = flags | TEE_SHM_POOL;
> >         shm->ctx = ctx;
> >         if (flags & TEE_SHM_DMA_BUF)
> > @@ -207,7 +216,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
> >   */
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
> >  {
> > -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_REGISTER);
> 
> Here it could just be:
> 
>        return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
> 
> -Sumit
> 
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> >
> > --
> > 2.25.1
> >
> 
