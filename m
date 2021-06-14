Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8403A720B
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 00:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhFNWfr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 18:35:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhFNWfq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:46 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFEEF20B83C5;
        Mon, 14 Jun 2021 15:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFEEF20B83C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623710022;
        bh=Tl/p2tGxM6IrZJQb02DL6qvvXW35MjdSvBm9pBSwJbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwK26bNSv07YR68gmqo7+Na9IYLTsD9xsUTsvPaPBysEcafwLw60LQTTer77lItY5
         X7hyczaPH3k/H/rtjY+gI3o218d2AbjrLufDWbg0p0s6U+xzKbSnwJBoELO6Idknrd
         TmlqQDmoBEmer4YHmE/q3X8vi2y4BHSLUTYBU6Tc=
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
Subject: [PATCH v5 7/8] tpm_ftpm_tee: Free and unregister TEE shared memory during kexec
Date:   Mon, 14 Jun 2021 17:33:16 -0500
Message-Id: <20210614223317.999867-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
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
Cc: stable@vger.kernel.org
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

