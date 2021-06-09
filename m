Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF983A0854
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 02:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhFIA1r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 20:27:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55168 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhFIA1r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:47 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6EE7E20B7188;
        Tue,  8 Jun 2021 17:25:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EE7E20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623198353;
        bh=mq0Ck7yTh8+8Nc2IyYejRlg2QHkP5yZIAoGTsSGCLHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJwJbyxbwDFqm67NB51vHnxXDycoYK//AcJVhdncqTNKMN8B+c+tQoSOjlgAYneQc
         zkYF5TKa5YQnUDr/2aPcJyYcsDzHTjl3Er0j+Kt+tW3zXvlnKBgLK+wQaqNrYdPY3+
         bqiLjyzgie/2yeGotgMlJ77nB81J8yCRJJUeSkKw=
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
Subject: [PATCH v3 6/7] tpm_ftpm_tee: Free and unregister dynamic shared memory during kexec
Date:   Tue,  8 Jun 2021 19:23:25 -0500
Message-Id: <20210609002326.210024-7-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

dma-buf backed shared memory cannot be reliably freed and unregistered
during a kexec operation even when tee_shm_free() is called on the shm
from a .shutdown hook. The problem occurs because dma_buf_put() calls
fput() which then uses task_work_add(), with the TWA_RESUME parameter,
to queue tee_shm_release() to be called before the current task returns
to user mode. However, the current task never returns to user mode
before the kexec completes so the memory is never freed nor
unregistered.

Don't use dma-buf backed shared memory for a multi-page dynamic shm
that's private to the driver. Not using a dma-buf backed shm will allow
tee_shm_free() to directly call tee_shm_release() so that the shared
memory can be freed and unregistered during a kexec operation.

Continue to register the multi-page dynamic shm with the TEE so that all
4K chunks can be used.

Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE")
Fixes: 1760eb689ed6 ("tpm/tpm_ftpm_tee: add shutdown call back")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..8f1155227506 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -256,7 +256,7 @@ static int ftpm_tee_probe(struct device *dev)
 	/* Allocate dynamic shared memory with fTPM TA */
 	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
 				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+				      TEE_SHM_MAPPED | TEE_SHM_REGISTER);
 	if (IS_ERR(pvt_data->shm)) {
 		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
 		rc = -ENOMEM;
-- 
2.25.1

