Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940793A3577
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFJVLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60390 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFJVLg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:36 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id B2DF320B7188;
        Thu, 10 Jun 2021 14:09:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2DF320B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359379;
        bh=QMN/+TpHdMpcC0h+c75GxaUojxMi3iQPGhRZ8PsKTHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mz5cpn3eN5otr/jZWMJdiCZvIPzxr3dvCjB424ogGNwv4kxXQNZDsw6udU/COjZnT
         bBunt9ZR2JVRY9As0eUglxIAVfr7RkGLvG0oLicRsugm8Fc/xabXVnGfSF6sH9A8U0
         kvXrdlfuVyPmcbxTyJMF8WIco41JLX3Ya8ryzEkg=
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
Subject: [PATCH v4 0/8] tee: Improve support for kexec and kdump
Date:   Thu, 10 Jun 2021 16:09:05 -0500
Message-Id: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v4:
- Incorporated 'tee: add tee_shm_alloc_kernel_buf()' from Jens to remove
  the need to expose TEE_SHM_REGISTER to callers of tee_shm_alloc()
- Updated 'tee: Support kernel shm registration without dma-buf backing'
  to drop the TEE_SHM_DMA_BUF flag when tee_shm_alloc_kernel_buf() calls
  tee_shm_alloc()
- Updated the final two patches, against ftpm and tee_bnxt_fw, to use
  tee_shm_alloc_kernel_buf() instead of tee_shm_alloc()
- Minor cleanups to the commit messages of the updates patches
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

Tyler Hicks (5):
  optee: Fix memory leak when failing to register shm pages
  optee: Refuse to load the driver under the kdump kernel
  optee: Clear stale cache entries during initialization
  tee: Support kernel shm registration without dma-buf backing
  tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

 drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +++++++--
 drivers/tee/optee/call.c                | 11 ++++++-
 drivers/tee/optee/core.c                | 42 ++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h       |  2 +-
 drivers/tee/optee/shm_pool.c            | 17 +++++++---
 drivers/tee/tee_shm.c                   | 29 ++++++++++++++++-
 include/linux/tee_drv.h                 |  1 +
 8 files changed, 108 insertions(+), 16 deletions(-)

-- 
2.25.1

