Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF933A0856
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 02:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhFIA1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 20:27:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55182 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhFIA1t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:49 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1180720B83C2;
        Tue,  8 Jun 2021 17:25:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1180720B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623198355;
        bh=WCM9QAmULKtEkV7NKiiY40B+irrtT4ERGiTIj727er4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWE1KYV2DTcwn+JEUo2ZMfJ8F38uLRlflhpuKq3kBotxeT31VZiCGa7VWwXlUllq2
         qxMv9tUZ3mGSEM4JFNBY2JUDEwWhNo0lxd81N4GEyUHK2afPlN1tGirg8o/PfLib21
         3cjwv4s1XFfmy7QiRZPnuJOrLCE2+w7NvFI3WaxA=
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
Subject: [PATCH v3 7/7] firmware: tee_bnxt: Release shm, session, and context during kexec
Date:   Tue,  8 Jun 2021 19:23:26 -0500
Message-Id: <20210609002326.210024-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

Implement a .shutdown hook that will be called during a kexec operation
so that the TEE shared memory, session, and context that were set up
during .probe can be properly freed/closed.

Additionally, don't use dma-buf backed shared memory for the multi-page
dynamic shm that's private to the driver. dma-buf backed shared memory
cannot be reliably freed and unregistered during a kexec operation even
when tee_shm_free() is called on the shm from a .shutdown hook. The
problem occurs because dma_buf_put() calls fput() which then uses
task_work_add(), with the TWA_RESUME parameter, to queue
tee_shm_release() to be called before the current task returns to user
mode. However, the current task never returns to user mode before the
kexec completes so the memory is never freed nor unregistered.

Continue to register the multi-page dynamic shm with the TEE so that all
4K chunks can be used.

Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w manager")
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..c496723e9e8d 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -213,7 +213,7 @@ static int tee_bnxt_fw_probe(struct device *dev)
 	pvt_data.dev = dev;
 
 	fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
-				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+				    TEE_SHM_MAPPED | TEE_SHM_REGISTER);
 	if (IS_ERR(fw_shm_pool)) {
 		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
 		err = PTR_ERR(fw_shm_pool);
@@ -242,6 +242,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
 	return 0;
 }
 
+static void tee_bnxt_fw_shutdown(struct device *dev)
+{
+	tee_shm_free(pvt_data.fw_shm_pool);
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+	pvt_data.ctx = NULL;
+}
+
 static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
 	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
 		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
@@ -257,6 +265,7 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
 		.bus		= &tee_bus_type,
 		.probe		= tee_bnxt_fw_probe,
 		.remove		= tee_bnxt_fw_remove,
+		.shutdown	= tee_bnxt_fw_shutdown,
 	},
 };
 
-- 
2.25.1

