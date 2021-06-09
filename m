Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B63A0BF0
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhFIFsT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Jun 2021 01:48:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38882 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFIFsT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Jun 2021 01:48:19 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id E27FA20B7188;
        Tue,  8 Jun 2021 22:46:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E27FA20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623217584;
        bh=Yy1Z01l6fmBdA5WxLEx26t5fbzEqPko8tRZCEEhLhho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQZMCdxcM9s6uLlAub8NQGqtgpUhIWWby5ndzCH38PO5Q9g6Q9U9vaK+JxmioEBJa
         7elEeXpj4zUetLFmPkXeKP9sETHyqgjOruaHIIHxqFMhXRXXeDJLhE/93pPL09YnLW
         yCRN5bXyOOYhSXIgrAONZQ4dR7a5up3eAq0AxgJc=
Date:   Wed, 9 Jun 2021 00:46:21 -0500
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
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf
 backing
Message-ID: <20210609054621.GB4910@sequoia>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-09 09:59:04, Sumit Garg wrote:
> Hi Tyler,

Hey Sumit - Thanks for the review. 

> 
> On Wed, 9 Jun 2021 at 05:55, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > Uncouple the registration of dynamic shared memory buffers from the
> > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate dynamic shared memory
> > regions but do not need them to be backed by a dma-buf when the memory
> > region is private to the driver.
> 
> In this case drivers should use tee_shm_register() instead where the
> memory allocated is actually private to the driver. However, you need
> to remove TEE_SHM_DMA_BUF as a mandatory flag for tee_shm_register().
> Have a look at an example here [1]. So modifying tee_shm_alloc() for
> this purpose doesn't look appropriate to me.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/keys/trusted-keys/trusted_tee.c#n73

I noticed what you did in commit 2a6ba3f794e8 ("tee: enable support to
register kernel memory") and considered moving ftpm and tee_bnxt_fw over
to tee_shm_register(). I think that's likely the right long term
approach but I decided against it since this series is a minimal set of
bug fixes that will hopefully go to stable (I'm affected by these bugs
in 5.4). Here are my reasons for feeling like moving to
tee_shm_register() isn't minimal in terms of a stable-focused fix:

- tee_shm_alloc() looks like it should work fine with AMD-TEE today.
  tee_shm_register() definitely does not since AMD-TEE doesn't provide a
  .shm_register or .shm_unregister hook. This may break existing users
  of AMD-TEE?
- tee_shm_register() has not historically been used for kernel
  allocations and is not fixed wrt the bug that Jens fixed in commit
  f1bbacedb0af ("tee: don't assign shm id for private shms").
- tee_shm_alloc() performs allocations using contiguous pages
  from alloc_pages() while tee_shm_register() performs non-contiguous
  allocations with kcalloc(). I suspect this would be fine but I don't
  know the secure world side of these things well enough to assess the
  risk involved with such a change on the kernel side.

I should have mentioned this in the cover letter but my hope was that
these minimal changes would be accepted and then additional work could
be done to merge tee_shm_alloc() and tee_shm_register() in a way that
would allow the caller to request contiguous or non-contiguous pages,
fix up the additional issues mentioned above, and then adjust the
call sites in ftpm and tee_bnxt_fw as appropriate.

I think that's a bigger set of changes because there are several things
that still confuse/concern me:

- Why does tee_shm_alloc() use TEE_SHM_MAPPED while tee_shm_register()
  uses TEE_SHM_KERNEL_MAPPED or TEE_SHM_USER_MAPPED? Why do all three
  exist?
- Why does tee_shm_register() unconditionally use non-contiguous
  allocations without ever taking into account whether or not
  OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's required
  from my reading of https://optee.readthedocs.io/en/latest/architecture/core.html#noncontiguous-shared-buffers.
- Why is TEE_SHM_REGISTER implemented at the TEE driver level when it is
  specific to OP-TEE? How to better abstract that away?

Let me know if you agree with the more minimal approach that I took for
these bug fix series or still feel like tee_shm_register() should be
fixed up so that it is usable. Thanks!

Tyler

> 
> -Sumit
> 
> >
> > Allow callers of tee_shm_alloc() to specify the TEE_SHM_REGISTER flag to
> > request registration. If the TEE implementation does not require dynamic
> > shared memory to be registered, clear the flag prior to calling the
> > corresponding pool alloc function. Update the OP-TEE driver to respect
> > TEE_SHM_REGISTER, rather than TEE_SHM_DMA_BUF, when deciding whether to
> > (un)register on alloc/free operations. The AMD-TEE driver continues to
> > ignore the TEE_SHM_REGISTER flag.
> >
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/tee/optee/shm_pool.c |  5 ++---
> >  drivers/tee/tee_shm.c        | 11 ++++++++++-
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
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
> >                 unsigned int nr_pages = 1 << order, i;
> >                 struct page **pages;
> >
> > @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >                         page++;
> >                 }
> >
> > -               shm->flags |= TEE_SHM_REGISTER;
> >                 rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
> >                                         (unsigned long)shm->kaddr);
> >                 kfree(pages);
> > @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> >                          struct tee_shm *shm)
> >  {
> > -       if (shm->flags & TEE_SHM_DMA_BUF)
> > +       if (shm->flags & TEE_SHM_REGISTER)
> >                 optee_shm_unregister(shm->ctx, shm);
> >
> >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 00472f5ce22e..1c0176550b9c 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> > +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER))) {
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
> >         shm->flags = flags | TEE_SHM_POOL;
> >         shm->ctx = ctx;
> >         if (flags & TEE_SHM_DMA_BUF)
> > --
> > 2.25.1
> >
> 
