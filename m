Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A943A0851
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 02:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhFIA1q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 20:27:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55132 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhFIA1p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:45 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C50EE20B83C2;
        Tue,  8 Jun 2021 17:25:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C50EE20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623198351;
        bh=PSTUxwpuCGKszi5NwhqCU2uRZ8ekFlqcbG+Gt351jK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMwbnw190SextzsTuVx9otUsb+GBoKHFvmGEG5lAfThCehsZaEMOo+kafl1lV4qcg
         YU4kj//eUjqL7cfLVMzzd4abIHdNN8S0euTVo+Tj4v/MMWhWS7lAfQdzgCeULDveID
         hazc/v4ZkiJZC747QNeCJMl0LD/lJ4IbX9/ojEI8=
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
Subject: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date:   Tue,  8 Jun 2021 19:23:24 -0500
Message-Id: <20210609002326.210024-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Uncouple the registration of dynamic shared memory buffers from the
TEE_SHM_DMA_BUF flag. Drivers may wish to allocate dynamic shared memory
regions but do not need them to be backed by a dma-buf when the memory
region is private to the driver.

Allow callers of tee_shm_alloc() to specify the TEE_SHM_REGISTER flag to
request registration. If the TEE implementation does not require dynamic
shared memory to be registered, clear the flag prior to calling the
corresponding pool alloc function. Update the OP-TEE driver to respect
TEE_SHM_REGISTER, rather than TEE_SHM_DMA_BUF, when deciding whether to
(un)register on alloc/free operations. The AMD-TEE driver continues to
ignore the TEE_SHM_REGISTER flag.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/shm_pool.c |  5 ++---
 drivers/tee/tee_shm.c        | 11 ++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

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
index 00472f5ce22e..1c0176550b9c 100644
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
-- 
2.25.1

