Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D7D3A3586
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFJVLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60478 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhFJVLo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:44 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 130EC20B83C2;
        Thu, 10 Jun 2021 14:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 130EC20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359388;
        bh=vHXNCzPH6vP65w3gRv4QZZVovB1oVYvISDjQp48lif0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WScSuzy266P0Px2xDr1yh+1BTBosX/Zq1zy0vz23Z9w9dutLlYSfo46yNUf2ulKPd
         JdLAVC5TaynHNwTz+LKp/RIjeDHVduFBo4HC6uuL7zTUlZgv25xYzVkE2QyFlq9XEu
         kb2uD9O+P0EkJfpdjBLB5kf8E+3Qv+/Tf9TCqygs=
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
Subject: [PATCH v4 3/8] optee: fix tee out of memory failure seen during kexec reboot
Date:   Thu, 10 Jun 2021 16:09:08 -0500
Message-Id: <20210610210913.536081-4-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
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

Signed-off-by: Allen Pais <apais@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
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

