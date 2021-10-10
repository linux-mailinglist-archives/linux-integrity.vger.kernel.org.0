Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874D542826C
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Oct 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJJQEK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Oct 2021 12:04:10 -0400
Received: from mx22.baidu.com ([220.181.50.185]:53692 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230271AbhJJQEK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Oct 2021 12:04:10 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id B652381AFE1D5BE5BBF5;
        Mon, 11 Oct 2021 00:02:09 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 11 Oct 2021 00:02:09 +0800
Received: from localhost.localdomain (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 11 Oct 2021 00:02:08 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
Date:   Mon, 11 Oct 2021 00:01:45 +0800
Message-ID: <20211010160147.590-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
helps to reduce code size, and simplify the code, and coherent
DMA will not clear the cache every time.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 61 ++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 3af4c07a9342..5f55a14ee824 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -356,15 +356,12 @@ static void tpm_ibmvtpm_remove(struct vio_dev *vdev)
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 
-	dma_unmap_single(ibmvtpm->dev, ibmvtpm->crq_dma_handle,
-			 CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
-	free_page((unsigned long)ibmvtpm->crq_queue.crq_addr);
-
-	if (ibmvtpm->rtce_buf) {
-		dma_unmap_single(ibmvtpm->dev, ibmvtpm->rtce_dma_handle,
-				 ibmvtpm->rtce_size, DMA_BIDIRECTIONAL);
-		kfree(ibmvtpm->rtce_buf);
-	}
+	dma_free_coherent(ibmvtpm->dev, CRQ_RES_BUF_SIZE,
+			  crq_q->crq_addr, crq_q->crq_dma_handle);
+
+	if (ibmvtpm->rtce_buf)
+		dma_free_coherent(ibmvtpm->dev, ibmvtpm->rtce_size,
+				  ibmvtpm->rtce_buf, ibmvtpm->rtce_dma_handle);
 
 	kfree(ibmvtpm);
 	/* For tpm_ibmvtpm_get_desired_dma */
@@ -522,23 +519,12 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 				return;
 			}
 			ibmvtpm->rtce_size = be16_to_cpu(crq->len);
-			ibmvtpm->rtce_buf = kmalloc(ibmvtpm->rtce_size,
-						    GFP_ATOMIC);
-			if (!ibmvtpm->rtce_buf) {
-				dev_err(ibmvtpm->dev, "Failed to allocate memory for rtce buffer\n");
-				return;
-			}
-
-			ibmvtpm->rtce_dma_handle = dma_map_single(ibmvtpm->dev,
-				ibmvtpm->rtce_buf, ibmvtpm->rtce_size,
-				DMA_BIDIRECTIONAL);
-
-			if (dma_mapping_error(ibmvtpm->dev,
-					      ibmvtpm->rtce_dma_handle)) {
-				kfree(ibmvtpm->rtce_buf);
-				ibmvtpm->rtce_buf = NULL;
-				dev_err(ibmvtpm->dev, "Failed to dma map rtce buffer\n");
-			}
+			ibmvtpm->rtce_buf = dma_alloc_coherent(ibmvtpm->dev,
+							       ibmvtpm->rtce_size,
+							       &ibmvtpm->rtce_dma_handle,
+							       GFP_ATOMIC);
+			if (!ibmvtpm->rtce_buf)
+				dev_err(ibmvtpm->dev, "Failed to dma allocate rtce buffer\n");
 
 			return;
 		case VTPM_GET_VERSION_RES:
@@ -618,22 +604,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	ibmvtpm->vdev = vio_dev;
 
 	crq_q = &ibmvtpm->crq_queue;
-	crq_q->crq_addr = (struct ibmvtpm_crq *)get_zeroed_page(GFP_KERNEL);
-	if (!crq_q->crq_addr) {
-		dev_err(dev, "Unable to allocate memory for crq_addr\n");
-		goto cleanup;
-	}
 
 	crq_q->num_entry = CRQ_RES_BUF_SIZE / sizeof(*crq_q->crq_addr);
 	init_waitqueue_head(&crq_q->wq);
-	ibmvtpm->crq_dma_handle = dma_map_single(dev, crq_q->crq_addr,
-						 CRQ_RES_BUF_SIZE,
-						 DMA_BIDIRECTIONAL);
-
-	if (dma_mapping_error(dev, ibmvtpm->crq_dma_handle)) {
-		dev_err(dev, "dma mapping failed\n");
+	crq_q->crq_addr = dma_alloc_coherent(dev, CRQ_RES_BUF_SIZE,
+					    &ibmvtpm->crq_dma_handle, GFP_KERNEL);
+	if (!crq_q->crq_addr)
 		goto cleanup;
-	}
 
 	rc = plpar_hcall_norets(H_REG_CRQ, vio_dev->unit_address,
 				ibmvtpm->crq_dma_handle, CRQ_RES_BUF_SIZE);
@@ -642,7 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 
 	if (rc) {
 		dev_err(dev, "Unable to register CRQ rc=%d\n", rc);
-		goto reg_crq_cleanup;
+		goto cleanup;
 	}
 
 	rc = request_irq(vio_dev->irq, ibmvtpm_interrupt, 0,
@@ -704,13 +681,11 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	do {
 		rc1 = plpar_hcall_norets(H_FREE_CRQ, vio_dev->unit_address);
 	} while (rc1 == H_BUSY || H_IS_LONG_BUSY(rc1));
-reg_crq_cleanup:
-	dma_unmap_single(dev, ibmvtpm->crq_dma_handle, CRQ_RES_BUF_SIZE,
-			 DMA_BIDIRECTIONAL);
 cleanup:
 	if (ibmvtpm) {
 		if (crq_q->crq_addr)
-			free_page((unsigned long)crq_q->crq_addr);
+			dma_free_coherent(dev, CRQ_RES_BUF_SIZE,
+					  crq_q->crq_addr, crq_q->crq_dma_handle);
 		kfree(ibmvtpm);
 	}
 
-- 
2.25.1

