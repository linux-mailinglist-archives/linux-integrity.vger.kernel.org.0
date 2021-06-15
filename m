Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531793A77EA
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFOHZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFOHZo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 03:25:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C8C061767
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jun 2021 00:23:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c9so17112870wrt.5
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jun 2021 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+UTvS88khTZNXDF+y6Ps9tqeyz2Uy/4nnjR+qNnvTE=;
        b=qGhVX4FJqo0aZ9xI+lU7yDAtZ/zmAB3uU4LZHpxTVSZA30nq6Fnv/N7ef+0mhEZF14
         4902DVJqMqKUIlgYG5yIQlhwGi6qVXHZcCFS9tpos8Ip6nGG6vMMdGoYd+Wlo9tnEifa
         y8r/OsUdyvRUrrSUgyVkaT6b36cfeH+aAdrfKmyHaJeQ9fX+O1orbt7cwz39xbAqTtWk
         wCYNVDBAPTuI5iZ4wGZZLhASKHJEkIZ8QKLY2MdDy9kL/pUBqxK5589lIf9op7FP6eNJ
         1UXPRWk4ICbHdWlJI4C6rZ25BKlBeaHzFhKn51wSiEzI5CGdaM1AZFzSf36Bm5vaQHfq
         jL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+UTvS88khTZNXDF+y6Ps9tqeyz2Uy/4nnjR+qNnvTE=;
        b=sft4bdTg5Fh0XDJ4rzx9hob19LbriJ9nhUsO/RQeTGKyYQoAFya+j6iFaczay+yhEX
         C5spWNyUVLDEhxxLQRIrrn8rhl2x8z8QTV9UdkXYFwWV23Zv38aV1isPnmy2xBV00+i7
         jyb4uQZFirzlWM+Kso+TCuNWwkN0R2H7GcGamRjfg1bv7dbcyIuy70FeppcVjt3BK/IB
         lK8ds70LQ2MdQk4XdEzrek4NLti/Q6ITP//+8C8UHdobHAXJGMErHoO+YP1Nfi2wuZXx
         HtCvpQtEbTQxUwU/6tRGE6Ztg5cK+ziRfydylTaxdGjr7wTX2fIOh9EVx1PANYEExKCW
         ed1A==
X-Gm-Message-State: AOAM531JSGdU+MZCeuN2z/M045v4FYJfk6TD8aAwUQiEIus5QWFuijq+
        O8u+eQ3ns1ECnjfVECxbowQ4NbhkcZ9FlxcsjNrV2A==
X-Google-Smtp-Source: ABdhPJyWRpNiJOhhrt9OoInk4hONQHxKx40cBuyw3GTOzH9U6tCvFlzHy/ZBsckfW3YXlH2SXbnm2b8R8ipPKguOZfg=
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr23084963wrz.350.1623741816400;
 Tue, 15 Jun 2021 00:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 15 Jun 2021 09:23:25 +0200
Message-ID: <CAHUa44ErgoxT3L1W-ouoQwUg1fNC-zagOOgy=KBuGN_pETnYaw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tyler,

On Tue, Jun 15, 2021 at 12:33 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> v5:
> - Picked up Reviewed-by's from Jens.
> - Added 'Cc: stable@vger.kernel.org' to all commits as this is intended
>   to be a bug fix series. I'm happy to sort out backports with the
>   stable team.
> - Got rid of the bool is_mapped parameter of optee_disable_shm_cache()
>   by abstracting out the function with two wrappers. One
>   (optee_disable_shm_cache()) for normal case where the shm cache is
>   fully mapped and another (optee_disable_unmapped_shm_cache()) for the
>   unusual case of the shm cache having potentially invalid entries.
> - Replaced my previous 'tee: Support kernel shm registration without
>   dma-buf' patch with a cleaner implementation ('tee: Correct
>   inappropriate usage of TEE_SHM_DMA_BUF flag') from Sumit Garg.
> v4: https://lore.kernel.org/lkml/20210610210913.536081-1-tyhicks@linux.microsoft.com/
> v3: https://lore.kernel.org/lkml/20210609002326.210024-1-tyhicks@linux.microsoft.com/
> v2: https://lore.kernel.org/lkml/20210225090610.242623-1-allen.lkml@gmail.com/
> v1: https://lore.kernel.org/lkml/20210217092714.121297-1-allen.lkml@gmail.com/
>
> This series fixes several bugs uncovered while exercising the OP-TEE
> (Open Portable Trusted Execution Environment), ftpm (firmware TPM), and
> tee_bnxt_fw (Broadcom BNXT firmware manager) drivers with kexec and
> kdump (emergency kexec) based workflows.
>
> The majority of the problems are caused by missing .shutdown hooks in
> the drivers. The .shutdown hooks are used by the normal kexec code path
> to let the drivers clean up prior to executing the target kernel. The
> .remove hooks, which are already implemented in these drivers, are not
> called as part of the kexec code path. This resulted in shared memory
> regions, that were cached and/or registered with OP-TEE, not being
> cleared/unregistered prior to kexec. The new kernel would then run into
> problems when handling the previously cached virtual addresses or trying
> to register newly allocated shared memory objects that overlapped with
> the previously registered virtual addresses. The TEE didn't receive
> notification that the old virtual addresses were no longer meaningful
> and that a new kernel, with a new address space, would soon be running.
>
> However, implementing .shutdown hooks was not enough for supporting
> kexec. There was an additional problem caused by the TEE driver's
> reliance on the dma-buf subsystem for multi-page shared memory objects
> that were registered with the TEE. Shared memory objects backed by a
> dma-buf use a different mechanism for reference counting. When the final
> reference is released, work is scheduled to be executed to unregister
> the shared memory with the TEE but that work is only completed prior to
> the current task returning the userspace. In the case of a kexec
> operation, the current task that's calling the driver .shutdown hooks
> never returns to userspace prior to the kexec operation so the shared
> memory was never unregistered. This eventually caused problems from
> overlapping shared memory regions that were registered with the TEE
> after several kexec operations. The large 4M contiguous region
> allocated by the tee_bnxt_fw driver reliably ran into this issue on the
> fourth kexec on a system with 8G of RAM.
>
> The use of dma-buf makes sense for shared memory that's in use by
> userspace but dma-buf's aren't needed for shared memory that will only
> used by the driver. This series separates dma-buf backed shared memory
> allocated by the kernel from multi-page shared memory that the kernel
> simply needs registered with the TEE for private use.
>
> One other noteworthy change in this series is to completely refuse to
> load the OP-TEE driver in the kdump kernel. This is needed because the
> secure world may have had all of its threads in suspended state when the
> regular kernel crashed. The kdump kernel would then hang during boot
> because the OP-TEE driver's .probe function would attempt to use a
> secure world thread when they're all in suspended state. Another problem
> is that shared memory allocations could fail under the kdump kernel
> because the previously registered were not unregistered (the .shutdown
> hook is not called when kexec'ing into the kdump kernel).
>
> The first patch in the series fixes potential memory leaks that are not
> directly related to kexec or kdump but were noticed during the
> development of this series.
>
> Tyler
>
> Allen Pais (2):
>   optee: fix tee out of memory failure seen during kexec reboot
>   firmware: tee_bnxt: Release TEE shm, session, and context during kexec
>
> Jens Wiklander (1):
>   tee: add tee_shm_alloc_kernel_buf()
>
> Sumit Garg (1):
>   tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag
>
> Tyler Hicks (4):
>   optee: Fix memory leak when failing to register shm pages
>   optee: Refuse to load the driver under the kdump kernel
>   optee: Clear stale cache entries during initialization
>   tpm_ftpm_tee: Free and unregister TEE shared memory during kexec
>
>  drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 ++++++--
>  drivers/tee/optee/call.c                | 38 +++++++++++++++++++---
>  drivers/tee/optee/core.c                | 43 ++++++++++++++++++++++++-
>  drivers/tee/optee/optee_private.h       |  1 +
>  drivers/tee/optee/rpc.c                 |  5 +--
>  drivers/tee/optee/shm_pool.c            | 20 +++++++++---
>  drivers/tee/tee_shm.c                   | 20 +++++++++++-
>  include/linux/tee_drv.h                 |  2 ++
>  9 files changed, 132 insertions(+), 19 deletions(-)
>
> --
 > 2.25.1
>

It looks like we're almost done now. Thanks for your patience to see
this through.

I suppose it makes most sense to take this via my tree, but before I
can do that I'll need acks from the maintainers of
drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
TEE shared memory during kexec") and
drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
TEE shm, session, and context during kexec").

Cheers,
Jens
