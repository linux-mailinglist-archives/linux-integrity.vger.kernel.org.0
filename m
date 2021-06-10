Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2A3A2B33
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJMRG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJMRF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:17:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A5C061574
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 05:15:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r198so2878933lff.11
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEHGV38tYEPn87F7ElGb2eufRjx+4X3yWFCCfxgeqDk=;
        b=Ln6RW2k/ezYgUxzfevzOB7aA62Gl4OBWbiCqXt7hsqErTgvEh4iYeu8GBZbc5xLP6W
         xW2NA29qk/4xxoHrXYO9DH/A8JKq1XANimnfGoicLulDRjN7ZD5gBPiZ/LtF0L6t7J+r
         J6VT/I9oxzSCnmzVM/dZWH1CHRQxRZBS7gcF4EPn+OGtzngGBFvJdJB+YUJ1xZZLSB/a
         pXa9ju508CJ/8yjqly2u5tGrLQRcvfRWY8lIf7TZpzIWiu/B/c8i/5q/9oJNWsQSUWmW
         azX1kTMRL/AdnvdLCmoeA1fUZYlJ1yydIoL8dc5r3IuI3dZGrRYGpHIQSLGIdOp77cwy
         ZkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEHGV38tYEPn87F7ElGb2eufRjx+4X3yWFCCfxgeqDk=;
        b=samogxri+yQxjIt31fZSGtp+Soy+5jKTRiXDNeUTlfk4Ke2jKmIkf4fxpGMdS+10+W
         a+zMlVWIzjpyWv7HqvWG4Lp1/lDrmpqjgwuUA/jjUodTx7e1Kg5re/9vBqbd3HN5qgmH
         IcXvxuBS6XaT8lzdNjufzdFCLZYbhjAnz1KdyVr3jW9IZNVisMo9Cjz+x7+W3G6UwGSl
         gc/845UK4h11ob/zcsu3Fv3R5ZuCpXmBE16XRI2/9z19pgubu5ig50lsyg2yK43B9iz3
         5bOoZmipr0/9MlMnY2/283kgFaY7XZyUdygZifidBNBnAdvmCY7pVkwN9nmYfMp+Afsq
         Phyw==
X-Gm-Message-State: AOAM532k1pW1BKL05vY8JtIY/zIqaYTZulA8O5DPYQdcif2+SvB0cUXr
        Dq7Bwsl+h1zM+NpTNhlRPKD2OkVcNm8G32UJV8RMiQ==
X-Google-Smtp-Source: ABdhPJyMCbkh9CFAVVhBBJsx2k/zNGlXYWTroK3U0XkVnEVH3PrhM6l6hkBIxL2RP+m0uiesanfs7OadlWe6WPxkz9Q=
X-Received: by 2002:a19:7d89:: with SMTP id y131mr1714908lfc.108.1623327307719;
 Thu, 10 Jun 2021 05:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com> <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia> <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210610071812.GA2753553@jade>
In-Reply-To: <20210610071812.GA2753553@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 10 Jun 2021 17:44:56 +0530
Message-ID: <CAFA6WYMXPHvm1tGcCJkTejAa23WCz=_D3E69-i-5+9A8sydE3g@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Rijo-john.Thomas@amd.com, Allen Pais <apais@linux.microsoft.com>,
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

Hi Jens,

On Thu, 10 Jun 2021 at 12:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Wed, Jun 09, 2021 at 04:22:49PM +0530, Sumit Garg wrote:
> > + Rijo
> >
> > On Wed, 9 Jun 2021 at 11:16, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> [snip]
> >
> > > - tee_shm_alloc() performs allocations using contiguous pages
> > >   from alloc_pages() while tee_shm_register() performs non-contiguous
> > >   allocations with kcalloc(). I suspect this would be fine but I don't
> > >   know the secure world side of these things well enough to assess the
> > >   risk involved with such a change on the kernel side.
> > >
> >
> > I don't think that would make any difference.
>
> Agree.
>
> >
> > > I should have mentioned this in the cover letter but my hope was that
> > > these minimal changes would be accepted and then additional work could
> > > be done to merge tee_shm_alloc() and tee_shm_register() in a way that
> > > would allow the caller to request contiguous or non-contiguous pages,
> > > fix up the additional issues mentioned above, and then adjust the
> > > call sites in ftpm and tee_bnxt_fw as appropriate.
> > >
> > > I think that's a bigger set of changes because there are several things
> > > that still confuse/concern me:
> > >
> > > - Why does tee_shm_alloc() use TEE_SHM_MAPPED while tee_shm_register()
> > >   uses TEE_SHM_KERNEL_MAPPED or TEE_SHM_USER_MAPPED? Why do all three
> > >   exist?
> >
> > AFAIK, its due the the inherent nature of tee_shm_alloc() and
> > tee_shm_register() where tee_shm_alloc() doesn't need to know whether
> > its a kernel or user-space memory since it is the one that allocates
> > whereas tee_shm_register() need to know that since it has to register
> > pre-allocated client memory.
> >
> > > - Why does tee_shm_register() unconditionally use non-contiguous
> > >   allocations without ever taking into account whether or not
> > >   OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's required
> > >   from my reading of https://optee.readthedocs.io/en/latest/architecture/core.html#noncontiguous-shared-buffers.
> >
> > Yeah, but do we have platforms in OP-TEE that don't support dynamic
> > shared memory? I guess it has become the sane default which is a
> > mandatory requirement when it comes to OP-TEE driver in u-boot.
> >
> > > - Why is TEE_SHM_REGISTER implemented at the TEE driver level when it is
> > >   specific to OP-TEE? How to better abstract that away?
> > >
> >
> > I would like you to go through Section "3.2.4. Shared Memory" in TEE
> > Client API Specification. There are two standard ways for shared
> > memory approach with TEE:
> >
> > 1. A Shared Memory block can either be existing Client Application
> > memory (kernel driver in our case) which is subsequently registered
> > with the TEE Client API (using tee_shm_register() in our case).
> >
> > 2. Or memory which is allocated on behalf of the Client Application
> > using the TEE
> > Client API (using tee_shm_alloc() in our case).
> >
> > > Let me know if you agree with the more minimal approach that I took for
> > > these bug fix series or still feel like tee_shm_register() should be
> > > fixed up so that it is usable. Thanks!
> >
> > From drivers perspective I think the change should be:
> >
> > tee_shm_alloc()
> >
> > to
> >
> > kcalloc()
> > tee_shm_register()
>
> I had another approach in mind in "[PATCH 0/7] tee: shared memory updates",
> https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/
>
> The flags needed by tee_shm_alloc() and tee_shm_register() aren't
> very intuitive and in fact only accept quite few combinations. So my
> idea was to hide those flags from callers outside of the TEE subsystem
> with tee_shm_alloc_kernel_buf().
>

That looks like a good idea to hide flags from users. BTW, my only
objection earlier with Tyler's and your patch-set is the usage of
TEE_SHM_REGISTER flag in generic TEE methods: tee_shm_alloc*. AFAIU,
the only reason for such an additional flag is in case of OP-TEE only
because the OP-TEE driver could implement allocated shared memory via
re-using dynamic shared memory approach as well. And that additional
flag is only needed to differentiate that OP-TEE driver's private
memory shouldn't be registered with OP-TEE. If this understanding is
correct then we should introduce a separate flag as TEE_SHM_PRIV that
should only be set inside tee_shm_alloc_anon_kernel_buf().

As otherwise passing TEE_SHM_REGISTER flag for shared memory alloc API
for other TEEs like AMD-TEE etc. would be useless.

> The approach with tee_shm_register() you suggest above has the drawback
> that the TEE driver is forced to be able to handle any kernel memory.

That's the value-add in the problem that Tyler is trying to resolve
that driver should be able to free up the memory as needed as a
private buffer.

> This is OK with OP-TEE and dynamic shared memory enabled, but there are
> platforms where dynamic shared memory isn't enabled. In those case must
> the memory be allocated from a special pool.

Is there any limitation for those platforms to not support dynamic
shared memory in OP-TEE? If there isn't then we should able to handle
this via match for TEE_GEN_CAP_REG_MEM in the ftpm_tee_match() and
optee_ctx_match() APIs.

>
> Do you see any problem with instead replacing tee_shm_alloc()
> with tee_shm_alloc_kernel_buf()?

I don't see any problems apart from one mentioned above.

-Sumit

>
> Cheers,
> Jens
