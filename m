Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0F3A3590
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFJVLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60544 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFJVLt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:49 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C9EC220B7178;
        Thu, 10 Jun 2021 14:09:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9EC220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359392;
        bh=4Jxdj0Zq13CZ4E4lDiPPY/DfcrbN7WU2k1uwV++9ObE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7/+oUCk0b9gyw2nfSAh+jHP4B/+PV4qGqWJqoyrVvloc6PePZLypoD876sAPJzvr
         R0rtWgpjUwhMl65bAontHl5jq5FSx501Ug6LwRE6ES9PaoCkNhoyh4ZMapyxIHbCSs
         ffGTjznLJ/Xu7W0sZ5pj7/Ft7WmrIVX3uJRWSmqU=
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
Subject: [PATCH v4 6/8] tee: Support kernel shm registration without dma-buf backing
Date:   Thu, 10 Jun 2021 16:09:11 -0500
Message-Id: <20210610210913.536081-7-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Uncouple the registration of kernel shared memory buffers from the
TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
shared memory regions but do not need them to be backed by a dma-buf
when the memory region is only used by the driver.

If the TEE implementation does not require shared memory to be
registered, clear the flag prior to calling the corresponding pool alloc
function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
alloc/free operations. The AMD-TEE driver continues to ignore the
TEE_SHM_REGISTER flag.

Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
shared memory region without the backing of dma-buf.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/shm_pool.c |  5 ++---
 drivers/tee/tee_shm.c        | 13 +++++++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index da06ce9b9313..6054343a29fb 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	if (shm->flags & TEE_SHM_REGISTER) {
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
@@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 			page++;
 		}
 
-		shm->flags |= TEE_SHM_REGISTER;
 		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 		kfree(pages);
@@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
 			 struct tee_shm *shm)
 {
-	if (shm->flags & TEE_SHM_DMA_BUF)
+	if (shm->flags & TEE_SHM_REGISTER)
 		optee_shm_unregister(shm->ctx, shm);
 
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c65e44707cd6..26a76f817c57 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
+	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER))) {
 		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
 		return ERR_PTR(-EINVAL);
 	}
@@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 		goto err_dev_put;
 	}
 
+	if (!teedev->desc->ops->shm_register ||
+	    !teedev->desc->ops->shm_unregister) {
+		/* registration is not required by the TEE implementation */
+		flags &= ~TEE_SHM_REGISTER;
+	} else if (flags & TEE_SHM_DMA_BUF) {
+		/* all dma-buf backed shm allocations are registered */
+		flags |= TEE_SHM_REGISTER;
+	}
+
 	shm->flags = flags | TEE_SHM_POOL;
 	shm->ctx = ctx;
 	if (flags & TEE_SHM_DMA_BUF)
@@ -207,7 +216,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_REGISTER);
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
 
-- 
2.25.1

