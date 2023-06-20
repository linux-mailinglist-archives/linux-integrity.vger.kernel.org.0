Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6914E736F05
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjFTOqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTOqs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 10:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875D94;
        Tue, 20 Jun 2023 07:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA8A612B1;
        Tue, 20 Jun 2023 14:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D3C433C0;
        Tue, 20 Jun 2023 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272406;
        bh=9h3moI3hmvBROUz5q1Axpk+rEonTaQjmob+V2t6yt90=;
        h=From:To:Cc:Subject:Date:From;
        b=Fv0FEULdwBVbcEb671R5392C7XGGHBM0hp/i2kxDhDumnr/REFDULU3rWv256UmVA
         mbeat6mvRL09BNYFa4dZ+9uVgCNElfJX/mEfdnLa+5dpx4GcbcY4oyq95ZT6b2B3Hl
         VEAKule0pTJzhUP82W0sHNN1cNP5PPpd+bHrz/eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tpm: make all 'class' structures const
Date:   Tue, 20 Jun 2023 16:46:43 +0200
Message-ID: <20230620144642.584926-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4180; i=gregkh@linuxfoundation.org; h=from:subject; bh=VN6hocl/5QvlNrgSmEWZE73DMjrqR59jHD2825Axci0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd1/aXCjzKFjv09M+Tf2UeU0+Aiyf9yr1/p07s7Tm3 xVmV6OtHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRrGsMc4WXMMlV/592ZvuT s3WOu3Y6T2e9eoNhfqXQJwZLz/uv57P5ynqUalwx4d5XBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c      | 11 ++++++++---
 drivers/char/tpm/tpm-interface.c | 21 +++++++++------------
 drivers/char/tpm/tpm.h           |  4 ++--
 drivers/char/tpm/tpm2-space.c    |  2 +-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cd48033b804a..7c028f0b9d38 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -28,8 +28,13 @@
 DEFINE_IDR(dev_nums_idr);
 static DEFINE_MUTEX(idr_lock);
 
-struct class *tpm_class;
-struct class *tpmrm_class;
+const struct class tpm_class = {
+	.name = "tpm",
+	.shutdown_pre = tpm_class_shutdown,
+};
+const struct class tpmrm_class = {
+	.name = "tmprm",
+};
 dev_t tpm_devt;
 
 static int tpm_request_locality(struct tpm_chip *chip)
@@ -336,7 +341,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 
 	device_initialize(&chip->dev);
 
-	chip->dev.class = tpm_class;
+	chip->dev.class = &tpm_class;
 	chip->dev.release = tpm_dev_release;
 	chip->dev.parent = pdev;
 	chip->dev.groups = chip->groups;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 586ca10b0d72..66b16d26eecc 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -476,18 +476,15 @@ static int __init tpm_init(void)
 {
 	int rc;
 
-	tpm_class = class_create("tpm");
-	if (IS_ERR(tpm_class)) {
+	rc = class_register(&tpm_class);
+	if (rc) {
 		pr_err("couldn't create tpm class\n");
-		return PTR_ERR(tpm_class);
+		return rc;
 	}
 
-	tpm_class->shutdown_pre = tpm_class_shutdown;
-
-	tpmrm_class = class_create("tpmrm");
-	if (IS_ERR(tpmrm_class)) {
+	rc = class_register(&tpmrm_class);
+	if (rc) {
 		pr_err("couldn't create tpmrm class\n");
-		rc = PTR_ERR(tpmrm_class);
 		goto out_destroy_tpm_class;
 	}
 
@@ -508,9 +505,9 @@ static int __init tpm_init(void)
 out_unreg_chrdev:
 	unregister_chrdev_region(tpm_devt, 2 * TPM_NUM_DEVICES);
 out_destroy_tpmrm_class:
-	class_destroy(tpmrm_class);
+	class_unregister(&tpmrm_class);
 out_destroy_tpm_class:
-	class_destroy(tpm_class);
+	class_unregister(&tpm_class);
 
 	return rc;
 }
@@ -518,8 +515,8 @@ static int __init tpm_init(void)
 static void __exit tpm_exit(void)
 {
 	idr_destroy(&dev_nums_idr);
-	class_destroy(tpm_class);
-	class_destroy(tpmrm_class);
+	class_unregister(&tpm_class);
+	class_unregister(&tpmrm_class);
 	unregister_chrdev_region(tpm_devt, 2*TPM_NUM_DEVICES);
 	tpm_dev_common_exit();
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 460bb85dd142..61445f1dc46d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -230,8 +230,8 @@ enum tpm2_pt_props {
  * compiler warnings about stack frame size. */
 #define TPM_MAX_RNG_DATA	128
 
-extern struct class *tpm_class;
-extern struct class *tpmrm_class;
+extern const struct class tpm_class;
+extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
 extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index ffb35f0154c1..363afdd4d1d3 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -606,7 +606,7 @@ int tpm_devs_add(struct tpm_chip *chip)
 
 	device_initialize(&chip->devs);
 	chip->devs.parent = chip->dev.parent;
-	chip->devs.class = tpmrm_class;
+	chip->devs.class = &tpmrm_class;
 
 	/*
 	 * Get extra reference on main device to hold on behalf of devs.
-- 
2.41.0

