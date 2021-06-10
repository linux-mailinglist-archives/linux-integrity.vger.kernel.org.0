Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89583A2530
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFJHUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHUN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 03:20:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964CC061574
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 00:18:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n17so3435856ljg.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5kcCRgSqcTyKNiNJobzPvsYTBfnwg3R0que6HtV/iA=;
        b=gOyVmQmkTb6Ht4MxUDwsPv+sgfc47kSAG/YUkq2lleF0q/dOq8uSIGGFMyN4q/919a
         vrJXYZGjINTU2nFw31tmzr7UDTqOrJJz80C+ggrqqVmA5YeKdVS6YnlKCutUlQvN8ys7
         PdCttBfPd8Cua8+a9j7SkMwppyzT2wfq2EtsMK0eY5Oy+NN9hQqPBG3uZSm73nZgL1N5
         BhVxxVkDqx6eIMkQFiJ16ncU+3RzDLkPJUn6QbS8U+36Vmbnsfum1QLFYtyd33zifNwj
         30Pw7cA4+dV2r8vNEYcmfBqHwmgg5NgA5fXbPYR+Pr++yb8uBu3+MmUp3tIUe5ktU+E7
         1mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5kcCRgSqcTyKNiNJobzPvsYTBfnwg3R0que6HtV/iA=;
        b=JyZ6tkFQlAhIlrwQ904Oyo2hQKCQEdmw1B+WT8EAUtaCWJMF1B2cKIFwo9R9jNKDLO
         SK8V+XsqvNfNQ6H3Z/kHy2FXQRxkKfFofI/dkSuwNgrpWtjUYrsecUwCs8b0D6iOP1LE
         2BzCb23w39Y0raECkOpsMN/9P4gy0/ziTcbmdhVE4Gdy25BAd6kGd/TqUrj0I6Uq4r5K
         eEEml+y/wiF1uh+OoPllt5dlGP2U6S6OOm+lTLBO3J+VBPafLKJA+HDSkCBdUnlx25ZN
         bbKDiSJZJw3IUkIjDJsZ5tLwhojiRk+pXlspaA5Uiwhr28ygxgpM8Eb3QT9Hh5AOfDkf
         u4Ww==
X-Gm-Message-State: AOAM5321v3EQX0HeCLu/DCJznVdITyXaMKf0WxbRNWSY7pJOsRsxQ0An
        e90tyOAK2imR395MtGZFNA0KyA==
X-Google-Smtp-Source: ABdhPJyMj9lGwOCH+acQAVtjCYP7GB+omoXpgU6UYPUc+PU0pXjGQscDFQVLqGLZ50u23iwL4TVVSg==
X-Received: by 2002:a2e:a605:: with SMTP id v5mr1129883ljp.128.1623309494502;
        Thu, 10 Jun 2021 00:18:14 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id i21sm238059ljb.10.2021.06.10.00.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:18:14 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:18:12 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Rijo-john.Thomas@amd.com, Allen Pais <apais@linux.microsoft.com>,
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
Message-ID: <20210610071812.GA2753553@jade>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 09, 2021 at 04:22:49PM +0530, Sumit Garg wrote:
> + Rijo
> 
> On Wed, 9 Jun 2021 at 11:16, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
[snip]
> 
> > - tee_shm_alloc() performs allocations using contiguous pages
> >   from alloc_pages() while tee_shm_register() performs non-contiguous
> >   allocations with kcalloc(). I suspect this would be fine but I don't
> >   know the secure world side of these things well enough to assess the
> >   risk involved with such a change on the kernel side.
> >
> 
> I don't think that would make any difference.

Agree.

> 
> > I should have mentioned this in the cover letter but my hope was that
> > these minimal changes would be accepted and then additional work could
> > be done to merge tee_shm_alloc() and tee_shm_register() in a way that
> > would allow the caller to request contiguous or non-contiguous pages,
> > fix up the additional issues mentioned above, and then adjust the
> > call sites in ftpm and tee_bnxt_fw as appropriate.
> >
> > I think that's a bigger set of changes because there are several things
> > that still confuse/concern me:
> >
> > - Why does tee_shm_alloc() use TEE_SHM_MAPPED while tee_shm_register()
> >   uses TEE_SHM_KERNEL_MAPPED or TEE_SHM_USER_MAPPED? Why do all three
> >   exist?
> 
> AFAIK, its due the the inherent nature of tee_shm_alloc() and
> tee_shm_register() where tee_shm_alloc() doesn't need to know whether
> its a kernel or user-space memory since it is the one that allocates
> whereas tee_shm_register() need to know that since it has to register
> pre-allocated client memory.
> 
> > - Why does tee_shm_register() unconditionally use non-contiguous
> >   allocations without ever taking into account whether or not
> >   OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's required
> >   from my reading of https://optee.readthedocs.io/en/latest/architecture/core.html#noncontiguous-shared-buffers.
> 
> Yeah, but do we have platforms in OP-TEE that don't support dynamic
> shared memory? I guess it has become the sane default which is a
> mandatory requirement when it comes to OP-TEE driver in u-boot.
> 
> > - Why is TEE_SHM_REGISTER implemented at the TEE driver level when it is
> >   specific to OP-TEE? How to better abstract that away?
> >
> 
> I would like you to go through Section "3.2.4. Shared Memory" in TEE
> Client API Specification. There are two standard ways for shared
> memory approach with TEE:
> 
> 1. A Shared Memory block can either be existing Client Application
> memory (kernel driver in our case) which is subsequently registered
> with the TEE Client API (using tee_shm_register() in our case).
> 
> 2. Or memory which is allocated on behalf of the Client Application
> using the TEE
> Client API (using tee_shm_alloc() in our case).
> 
> > Let me know if you agree with the more minimal approach that I took for
> > these bug fix series or still feel like tee_shm_register() should be
> > fixed up so that it is usable. Thanks!
> 
> From drivers perspective I think the change should be:
> 
> tee_shm_alloc()
> 
> to
> 
> kcalloc()
> tee_shm_register()

I had another approach in mind in "[PATCH 0/7] tee: shared memory updates",
https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/

The flags needed by tee_shm_alloc() and tee_shm_register() aren't
very intuitive and in fact only accept quite few combinations. So my
idea was to hide those flags from callers outside of the TEE subsystem
with tee_shm_alloc_kernel_buf().

The approach with tee_shm_register() you suggest above has the drawback
that the TEE driver is forced to be able to handle any kernel memory.
This is OK with OP-TEE and dynamic shared memory enabled, but there are
platforms where dynamic shared memory isn't enabled. In those case must
the memory be allocated from a special pool.

Do you see any problem with instead replacing tee_shm_alloc()
with tee_shm_alloc_kernel_buf()?

Cheers,
Jens
