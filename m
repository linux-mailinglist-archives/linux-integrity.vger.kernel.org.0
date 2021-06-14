Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F143A7202
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 00:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhFNWfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 18:35:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56098 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhFNWfj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:39 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A65820B83C2;
        Mon, 14 Jun 2021 15:33:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A65820B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623710016;
        bh=f+eL8pK9p2IL+p45rhOk41ve8PrQYT9LbO9wgCJTmOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNSe4ezIfk0AYcN2wHCS4Pfet2a3Au6ekROvMM7aKHYGOLXvkaylSikcDoZxCrHkC
         yCLwBIgvG6jSlEvWNkvAsAnExkFpbg8MNvEhQn58oTXXDBhCZblX+4KypncgvI/GHi
         2ZpW5am9fz4gQ+ut9fartJ+rPCKtWEJ2qXREfSxc=
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
Subject: [PATCH v5 3/8] optee: fix tee out of memory failure seen during kexec reboot
Date:   Mon, 14 Jun 2021 17:33:12 -0500
Message-Id: <20210614223317.999867-4-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

The following out of memory errors are seen on kexec reboot
from the optee core.

[    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
[    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22

tee_shm_release() is not invoked on dma shm buffer.

Implement .shutdown() method to handle the release of the buffers
correctly.

More info:
https://github.com/OP-TEE/optee_os/issues/3637

Cc: stable@vger.kernel.org
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5288cd767d82..0987074d7ed0 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -573,6 +573,13 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+/* optee_remove - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * optee_remove is called by platform subsystem to alert the driver
+ * that it should release the device
+ */
+
 static int optee_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
@@ -603,6 +610,18 @@ static int optee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* optee_shutdown - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * platform_shutdown is called by the platform subsystem to alert
+ * the driver that a shutdown, reboot, or kexec is happening and
+ * device must be disabled.
+ */
+static void optee_shutdown(struct platform_device *pdev)
+{
+	optee_disable_shm_cache(platform_get_drvdata(pdev));
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -739,6 +758,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
+	.shutdown = optee_shutdown,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
-- 
2.25.1

