Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7857D701875
	for <lists+linux-integrity@lfdr.de>; Sat, 13 May 2023 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjEMR20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 May 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEMR20 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 May 2023 13:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27D2D7F;
        Sat, 13 May 2023 10:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFECD60F7F;
        Sat, 13 May 2023 17:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5556C433D2;
        Sat, 13 May 2023 17:28:22 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
To:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_vtpm_proxy: fix race condition in /dev/vtpmx creation
Date:   Sat, 13 May 2023 20:28:18 +0300
Message-Id: <20230513172818.752712-1-jarkko.sakkinen@tuni.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

/dev/vtpmx is made visible before the workqueue exist, which can lead
memory corruption in the worst case, if workqueue is used before it has
been fully initialized. Address this by changing the call order.

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 5c865987ba5c..ef1367cf2f10 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -50,7 +50,7 @@ struct proxy_dev {
 /* all supported flags */
 #define VTPM_PROXY_FLAGS_ALL  (VTPM_PROXY_FLAG_TPM2)
 
-static struct workqueue_struct *workqueue;
+static struct workqueue_struct *vtpm_workqueue;
 
 static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
 
@@ -478,7 +478,7 @@ static void vtpm_proxy_work_stop(struct proxy_dev *proxy_dev)
  */
 static inline void vtpm_proxy_work_start(struct proxy_dev *proxy_dev)
 {
-	queue_work(workqueue, &proxy_dev->work);
+	queue_work(vtpm_workqueue, &proxy_dev->work);
 }
 
 /*
@@ -697,30 +697,24 @@ static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
+	vtpm_workqueue = create_workqueue("tpm-vtpm");
+	if (!vtpm_workqueue) {
+		rc = -ENOMEM;
 		return rc;
 	}
 
-	workqueue = create_workqueue("tpm-vtpm");
-	if (!workqueue) {
-		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+	rc = vtpmx_init();
+	if (rc) {
+		vtpmx_cleanup();
+		return rc;
 	}
 
 	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
-
-	return rc;
 }
 
 static void __exit vtpm_module_exit(void)
 {
-	destroy_workqueue(workqueue);
+	destroy_workqueue(vtpm_workqueue);
 	vtpmx_cleanup();
 }
 
-- 
2.39.2

