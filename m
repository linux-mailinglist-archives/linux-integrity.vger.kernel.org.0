Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999DC7040F3
	for <lists+linux-integrity@lfdr.de>; Tue, 16 May 2023 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbjEOW0F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 May 2023 18:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjEOW0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 May 2023 18:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D2A3;
        Mon, 15 May 2023 15:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E23623F6;
        Mon, 15 May 2023 22:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644E7C433D2;
        Mon, 15 May 2023 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684189562;
        bh=mgXb0mwxaOmdxBcgoHsqCUvWmllYoas8WLQZmW80/0U=;
        h=From:To:Cc:Subject:Date:From;
        b=tljRDJNRgEs51+Df/dmJVTibiTt1wcAE1beiT9OvcO/Cm+pyikMJrPEY7Ow/IoO2d
         bUGy2qRQc6S0rEP10IdJk5MKv+FffbtjlIMNKpOWdMyMUGuS/s9z0zPSFiDWcAz6h2
         JMl0WdK67n5pWI2IQgtE5jaUJyz61CK2XH2Y3QSQX0r/mveGntgl/kUYHds+phMic9
         blq8A1GjpsF6reZQaCYe2I66VDmCXsGpQHOhsNOXQdfM/AeFcPn/hEl5QCodVAjM0F
         kIcB7I0KbNEvbnaLGiacadd+aMGNiIjO9xqbmqMkqRubhauD8tjKp+NKg3joFabTnJ
         S5ws7+8XA/xEQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation
Date:   Tue, 16 May 2023 01:25:54 +0300
Message-Id: <20230515222554.2783592-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>

/dev/vtpmx is made visible before 'workqueue' is initialized, which can
lead to a memory corruption in the worst case scenario.

Address this by initializing 'workqueue' as the very first step of the
driver initialization.

Cc: stable@vger.kernel.org
Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
---
v2:
- Replace vtpmx_cleanup() with destroy_workqueue():
  https://lore.kernel.org/linux-integrity/CSLCEYDKKWWE.36POIXVT65SLE@suppilovahvero/
- Fix typo:
  https://lore.kernel.org/linux-integrity/4651cf1c-423d-05c2-b4c3-9d829a2eadf4@linux.ibm.com/
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 5c865987ba5c..30e953988cab 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -683,37 +683,21 @@ static struct miscdevice vtpmx_miscdev = {
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -721,7 +705,7 @@ static int __init vtpm_module_init(void)
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);
-- 
2.39.2

