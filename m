Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874313A3589
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFJVLs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60524 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhFJVLs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:48 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3745220B83CB;
        Thu, 10 Jun 2021 14:09:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3745220B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359391;
        bh=rS0KO2g5L8Xhkc4V95Ph1/HTme6zsuqiHbL+4FmEy0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HC7WlPPbsJsawizQdIikbgX8/Ami2E6QH32qPb8NDJsoE7jpuSCVaEbYFYL4cauXO
         Ap/uC7IemAfkJGODp5MtlIrJlIEjFQfbPzWusP36l4j3NMZ6hutk+LyPe+EA9qe+JX
         L3fLgCBt4ixF/jVzATUibqkw5o5ohs+Z5b6GdnJM=
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
Subject: [PATCH v4 5/8] tee: add tee_shm_alloc_kernel_buf()
Date:   Thu, 10 Jun 2021 16:09:10 -0500
Message-Id: <20210610210913.536081-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
from a kernel driver. This function can later be made more lightweight
by unnecessary dma-buf export.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
 include/linux/tee_drv.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 00472f5ce22e..c65e44707cd6 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -193,6 +193,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
 
+/**
+ * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * The returned memory registered in secure world and is suitable to be
+ * passed as a memory buffer in parameter argument to
+ * tee_client_invoke_func(). The memory allocated is later freed with a
+ * call to tee_shm_free().
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
+{
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 54269e47ac9a..8990f7628387 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -332,6 +332,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
  * @returns a pointer to 'struct tee_shm'
  */
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
 /**
  * tee_shm_register() - Register shared memory buffer
-- 
2.25.1

