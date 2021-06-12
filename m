Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEFC3A4D84
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Jun 2021 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFLIXD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Jun 2021 04:23:03 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34573 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLIXC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Jun 2021 04:23:02 -0400
Received: by mail-lf1-f52.google.com with SMTP id f30so12230499lfj.1
        for <linux-integrity@vger.kernel.org>; Sat, 12 Jun 2021 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2SpUEzOky83sMYBnEdAjJxCHRE/WrgH62z28bh+deo=;
        b=i6F7HLFg8E8xfiEjsnOSwSKOgq843AFv4vi8Lh8ZUieNfZqXbpIAuGmbfNRmdkzHWc
         wge+qCVyz0UVtAm8jQWQaLSyE5K/O1tzqVSDSQUzlkdLaUBBox+FlPZpUBGZJmWiNP8/
         yfu63vXT8qHxVdAiKmJSsF0LAzIJ648thUndEQylNurKMqBnkescj0CioCbQW/v3XD0Y
         1tlWRTYMw0ggYpvCcIH7YsAJ55gSfg1NcTtPyH9idknN3btNylxJmYUk2NHPswxR9I/Z
         bep/jf/ClilCaOAdh/WR35rIE9RfSpy6eXG42ZoIawDtEIdTAYX1BJI7940OjK+JDYbB
         xicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2SpUEzOky83sMYBnEdAjJxCHRE/WrgH62z28bh+deo=;
        b=q917HK8RO9tTsD7dPFHI0eDRohT2JgX/Nt88l0hwNGijRpBSz/7LbMQ232GLNAf1fJ
         c8YiMn6dpys+AZCgzUL6TCf7ARX2WdqkOHC7laltmE61WqRcZ+Nv3qvrRQz4I2XW9e8r
         PbHv55KtFEJVbZRdrbSH34iNQCjGsGGAaHCammgU82cu9Buv6Qd0jOMhLwsVa0UPPmH9
         6GmF+UQPgvAA+m1dQBe2U8qKsWr8OaUvAzPGjCplQWYgNOBpDZWfXW5xJJAQCCW3B45K
         OGszUSTT2+N4rrdsUI3c+WsEZzxaHWu7TC5oj1LeIQK4tNcPFaeluyPtsGgWe64+ENEe
         f0Nw==
X-Gm-Message-State: AOAM530FNQFerPEIsTj4dbAETItQl+qI7Lt82farC+gW+2fjQssCK3Ae
        7f3ZVqfltUmEwh9iZYSGwmeAzRFbZFxQcHn+vSifoQ==
X-Google-Smtp-Source: ABdhPJwTfzav8fvWHPLtVsosT1mgeoONXmjLwQj80P6pZxt1YmozJhSvoRpLR9QNdvYulStXupFXTgwi8VJxlUDPbyc=
X-Received: by 2002:a19:8641:: with SMTP id i62mr5230170lfd.546.1623485989617;
 Sat, 12 Jun 2021 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-7-tyhicks@linux.microsoft.com> <CAFA6WYMcGGkAAWxK2vmM8CNsgTKJpegkZZjJZy4pvXhKe9WGvA@mail.gmail.com>
 <20210611130958.GR4910@sequoia> <20210611131619.GS4910@sequoia>
In-Reply-To: <20210611131619.GS4910@sequoia>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Sat, 12 Jun 2021 13:49:38 +0530
Message-ID: <CAFA6WYPJXmeepe=4EiiA0_MUz=KsAGnbwY98FfEm1Z2EaGxz-w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
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

On Fri, 11 Jun 2021 at 18:46, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> On 2021-06-11 08:10:01, Tyler Hicks wrote:
> > On 2021-06-11 10:46:20, Sumit Garg wrote:
> > > On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > > >
> > > > Uncouple the registration of kernel shared memory buffers from the
> > > > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
> > > > shared memory regions but do not need them to be backed by a dma-buf
> > > > when the memory region is only used by the driver.
> > > >
> > > > If the TEE implementation does not require shared memory to be
> > > > registered, clear the flag prior to calling the corresponding pool alloc
> > > > function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
> > > > than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> > > > alloc/free operations.
> > >
> > > > The AMD-TEE driver continues to ignore the
> > > > TEE_SHM_REGISTER flag.
> > > >
> > >
> > > That's the main point that no other TEE implementation would honour
> > > TEE_SHM_REGISTER and I think it's just the incorrect usage of
> > > TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.
> > >
> > > > Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
> > > > shared memory region without the backing of dma-buf.
> > > >
> > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > >  drivers/tee/optee/shm_pool.c |  5 ++---
> > > >  drivers/tee/tee_shm.c        | 13 +++++++++++--
> > > >  2 files changed, 13 insertions(+), 5 deletions(-)
> > > >
> > >
> > > This patch is just mixing two separate approaches to TEE shared
> > > memory. Have a look at alternative suggestions below.
> > >
> > > > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > > > index da06ce9b9313..6054343a29fb 100644
> > > > --- a/drivers/tee/optee/shm_pool.c
> > > > +++ b/drivers/tee/optee/shm_pool.c
> > > > @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > > >         shm->paddr = page_to_phys(page);
> > > >         shm->size = PAGE_SIZE << order;
> > > >
> > > > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +       if (shm->flags & TEE_SHM_REGISTER) {
> > >
> > > Here you can just do following check instead:
> > >
> > >        if (!(shm->flags & TEE_SHM_PRIV)) {
> >
> > This is a bug fix series that's intended to fix the current and older
> > kernels. tee_shm_alloc_anon_kernel_buf()/TEE_SHM_PRIV is not present in
> > older kernels and isn't required to fix these kexec/kdump bugs. Your
> > suggestion feels like something that should be done in the allocator
> > rewrite that Jens is working on to clean all of this up going forward.
>
> I want to add that I do fully agree with you that TEE_SHM_REGISTER is an
> OP-TEE thing and not a TEE thing. Ideally, it wouldn't be defined in
> tee_drv.h and would be completely private to the OP-TEE driver.
> Likewise, I don't think that tee_shm_register() should exist (certainly
> not at the TEE level) because it only works with OP-TEE.

I think there is some confusion going on. tee_shm_register() is a
standard interface that is listed in TEE client API specification as
an alternative approach to tee_shm_alloc(). As I earlier mentioned,
please read through "3.2.4. Shared Memory" in TEE Client API
Specification.

In the initial times, OP-TEE only supported tee_shm_alloc() approach
but with the addition of dynamic shared memory feature it became
possible to support tee_shm_register() as well but we had to add new
capability as TEE_GEN_CAP_REG_MEM in order to maintain OP-TEE
backwards compatibility. It can very well be the same case for AMD-TEE
which currently only supports tee_shm_alloc() approach.

The reason for confusion here seems to be that OP-TEE driver is
providing a way to leverage dynamic shared memory approach in order to
implement tee_shm_alloc() but that doesn't mean at TEE level we should
intermix both approaches via using TEE_SHM_REGISTER to implement
tee_shm_alloc().

>
> That said, I think the first step is to fix the kexec/kdump bugs and the
> second step is to clean up the code to remove the layering violation of
> exposing shm registration from the TEE interfaces.
>

Doesn't the following patch sound suitable to be backported to a
stable kernel? It has even less changes compared to your patch as well
:).

-Sumit

-------------------------------------------
Subject: [PATCH] tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Currently TEE_SHM_DMA_BUF flag has been inappropriately used to not
register shared memory allocated for private usage by underlying TEE
driver: OP-TEE in this case. So rather add a new flag as TEE_SHM_PRIV
that can be utilized by underlying TEE drivers for private allocation
and usage of shared memory.

With this corrected, allow tee_shm_alloc_kernel_buf() to allocate a
shared memory region without the backing of dma-buf.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/call.c     | 2 +-
 drivers/tee/optee/core.c     | 3 ++-
 drivers/tee/optee/shm_pool.c | 8 ++++++--
 drivers/tee/tee_shm.c        | 2 +-
 include/linux/tee_drv.h      | 1 +
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..faaa13c9172b 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -184,7 +184,7 @@ static struct tee_shm *get_msg_arg(struct
tee_context *ctx, size_t num_params,
        struct optee_msg_arg *ma;

        shm = tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
-                           TEE_SHM_MAPPED);
+                           TEE_SHM_MAPPED | TEE_SHM_PRIV);
        if (IS_ERR(shm))
                return shm;

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ddb8f9ecf307..eac0e91ec559 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -277,7 +277,8 @@ static void optee_release(struct tee_context *ctx)
        if (!ctxdata)
                return;

-       shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
+       shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg),
+                           TEE_SHM_MAPPED | TEE_SHM_PRIV);
        if (!IS_ERR(shm)) {
                arg = tee_shm_get_va(shm, 0);
                /*
diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..3b4a3853a10f 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -27,7 +27,11 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
        shm->paddr = page_to_phys(page);
        shm->size = PAGE_SIZE << order;

-       if (shm->flags & TEE_SHM_DMA_BUF) {
+       /*
+        * Shared memory private to the OP-TEE driver doesn't need
+        * to be registered with OP-TEE.
+        */
+       if (!(shm->flags & TEE_SHM_PRIV)) {
                unsigned int nr_pages = 1 << order, i;
                struct page **pages;

@@ -52,7 +56,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
                         struct tee_shm *shm)
 {
-       if (shm->flags & TEE_SHM_DMA_BUF)
+       if (!(shm->flags & TEE_SHM_PRIV))
                optee_shm_unregister(shm->ctx, shm);

        free_pages((unsigned long)shm->kaddr, get_order(shm->size));
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c425ad80d6a6..f8b73e734094 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
-       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 8990f7628387..3ebfea0781f1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -27,6 +27,7 @@
 #define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
 #define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space */
+#define TEE_SHM_PRIV           BIT(7)  /* Memory private to TEE driver */

 struct device;
 struct tee_device;
