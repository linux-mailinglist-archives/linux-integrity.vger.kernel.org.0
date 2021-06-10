Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7679D3A3592
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFJVLx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60584 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhFJVLv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:51 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4925020B83C2;
        Thu, 10 Jun 2021 14:09:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4925020B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359394;
        bh=ULB0BKHQSYFGp7T9PPICfTiPkUhW2Osvmznih4NzdJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cpr1Jtvj+8v0iSRwpaXqNoA+md+Vg2WS4BHOoHKGlss03NGiId0IczrN2nRqWdLZ0
         yzLmKEiUmKXaIXXPWttgqgFxThAXhvTLIT8RfpFkgJdJv/8N5t31SxrohwhXuIu9H0
         0WF3zuB58Y443VE2PDD4xH6T+C0cveYu09/fA50s=
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
Subject: [PATCH v4 7/8] tpm_ftpm_tee: Free and unregister TEE shared memory during kexec
Date:   Thu, 10 Jun 2021 16:09:12 -0500
Message-Id: <20210610210913.536081-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
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

Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
allocation so that tee_shm_free() can directly call tee_shm_release().
This will ensure that the shm can be freed and unregistered during a
kexec operation.

Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE")
Fixes: 1760eb689ed6 ("tpm/tpm_ftpm_tee: add shutdown call back")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..6e3235565a4d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
 	pvt_data->session = sess_arg.session;
 
 	/* Allocate dynamic shared memory with fTPM TA */
-	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
-				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 MAX_COMMAND_SIZE +
+						 MAX_RESPONSE_SIZE);
 	if (IS_ERR(pvt_data->shm)) {
-		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
+		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
 		rc = -ENOMEM;
 		goto out_shm_alloc;
 	}
-- 
2.25.1

