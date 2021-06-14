Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2E3A71F9
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFNWfe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 18:35:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56010 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFNWfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:32 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5608220B83C2;
        Mon, 14 Jun 2021 15:33:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5608220B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623710009;
        bh=Y4l5Eb0jMhbuFaFiH+NBNQfRAt8W+tz1Is8aRW5byMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sZSJ7QuEMJFLTSTNlwOr9J1DqJVkpVouzuCEMjnBxUyKTKij59pRaCC+9v3xPiDYl
         waF0MSv2wBrPxnHxML0jl5H4CmykTRL0CvUnHkJwfQbmRe2szN7CBJ5xHigxX00eYq
         I0ZMenqMc1BkODau2bvxXnpTgbu61RZDFe70IAfc=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Date:   Mon, 14 Jun 2021 17:33:09 -0500
Message-Id: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v5:
- Picked up Reviewed-by's from Jens.
- Added 'Cc: stable@vger.kernel.org' to all commits as this is intended
  to be a bug fix series. I'm happy to sort out backports with the
  stable team.
- Got rid of the bool is_mapped parameter of optee_disable_shm_cache()
  by abstracting out the function with two wrappers. One
  (optee_disable_shm_cache()) for normal case where the shm cache is
  fully mapped and another (optee_disable_unmapped_shm_cache()) for the
  unusual case of the shm cache having potentially invalid entries.
- Replaced my previous 'tee: Support kernel shm registration without
  dma-buf' patch with a cleaner implementation ('tee: Correct
  inappropriate usage of TEE_SHM_DMA_BUF flag') from Sumit Garg.
v4: https://lore.kernel.org/lkml/20210610210913.536081-1-tyhicks@linux.microsoft.com/
v3: https://lore.kernel.org/lkml/20210609002326.210024-1-tyhicks@linux.microsoft.com/
v2: https://lore.kernel.org/lkml/20210225090610.242623-1-allen.lkml@gmail.com/
v1: https://lore.kernel.org/lkml/20210217092714.121297-1-allen.lkml@gmail.com/

This series fixes several bugs uncovered while exercising the OP-TEE
(Open Portable Trusted Execution Environment), ftpm (firmware TPM), and
tee_bnxt_fw (Broadcom BNXT firmware manager) drivers with kexec and
kdump (emergency kexec) based workflows.

The majority of the problems are caused by missing .shutdown hooks in
the drivers. The .shutdown hooks are used by the normal kexec code path
to let the drivers clean up prior to executing the target kernel. The
.remove hooks, which are already implemented in these drivers, are not
called as part of the kexec code path. This resulted in shared memory
regions, that were cached and/or registered with OP-TEE, not being
cleared/unregistered prior to kexec. The new kernel would then run into
problems when handling the previously cached virtual addresses or trying
to register newly allocated shared memory objects that overlapped with
the previously registered virtual addresses. The TEE didn't receive
notification that the old virtual addresses were no longer meaningful
and that a new kernel, with a new address space, would soon be running.

However, implementing .shutdown hooks was not enough for supporting
kexec. There was an additional problem caused by the TEE driver's
reliance on the dma-buf subsystem for multi-page shared memory objects
that were registered with the TEE. Shared memory objects backed by a
dma-buf use a different mechanism for reference counting. When the final
reference is released, work is scheduled to be executed to unregister
the shared memory with the TEE but that work is only completed prior to
the current task returning the userspace. In the case of a kexec
operation, the current task that's calling the driver .shutdown hooks
never returns to userspace prior to the kexec operation so the shared
memory was never unregistered. This eventually caused problems from
overlapping shared memory regions that were registered with the TEE
after several kexec operations. The large 4M contiguous region
allocated by the tee_bnxt_fw driver reliably ran into this issue on the
fourth kexec on a system with 8G of RAM.

The use of dma-buf makes sense for shared memory that's in use by
userspace but dma-buf's aren't needed for shared memory that will only
used by the driver. This series separates dma-buf backed shared memory
allocated by the kernel from multi-page shared memory that the kernel
simply needs registered with the TEE for private use.

One other noteworthy change in this series is to completely refuse to
load the OP-TEE driver in the kdump kernel. This is needed because the
secure world may have had all of its threads in suspended state when the
regular kernel crashed. The kdump kernel would then hang during boot
because the OP-TEE driver's .probe function would attempt to use a
secure world thread when they're all in suspended state. Another problem
is that shared memory allocations could fail under the kdump kernel
because the previously registered were not unregistered (the .shutdown
hook is not called when kexec'ing into the kdump kernel).

The first patch in the series fixes potential memory leaks that are not
directly related to kexec or kdump but were noticed during the
development of this series.

Tyler

Allen Pais (2):
  optee: fix tee out of memory failure seen during kexec reboot
  firmware: tee_bnxt: Release TEE shm, session, and context during kexec

Jens Wiklander (1):
  tee: add tee_shm_alloc_kernel_buf()

Sumit Garg (1):
  tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Tyler Hicks (4):
  optee: Fix memory leak when failing to register shm pages
  optee: Refuse to load the driver under the kdump kernel
  optee: Clear stale cache entries during initialization
  tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

 drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 ++++++--
 drivers/tee/optee/call.c                | 38 +++++++++++++++++++---
 drivers/tee/optee/core.c                | 43 ++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h       |  1 +
 drivers/tee/optee/rpc.c                 |  5 +--
 drivers/tee/optee/shm_pool.c            | 20 +++++++++---
 drivers/tee/tee_shm.c                   | 20 +++++++++++-
 include/linux/tee_drv.h                 |  2 ++
 9 files changed, 132 insertions(+), 19 deletions(-)

-- 
2.25.1

