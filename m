Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DE622306
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 05:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKIETW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 23:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKIETP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 23:19:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFC167DC
        for <linux-integrity@vger.kernel.org>; Tue,  8 Nov 2022 20:18:53 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6WtV4BhSzRp5t;
        Wed,  9 Nov 2022 12:18:42 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 12:18:51 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 12:18:51 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/3] tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak
Date:   Wed, 9 Nov 2022 12:03:41 +0800
Message-ID: <1667966622-19711-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1667966622-19711-1-git-send-email-guohanjun@huawei.com>
References: <1667966622-19711-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In crb_acpi_add(), we get the TPM2 table to retrieve information
like start method, and then assign them to the priv data, so the
TPM2 table is not used after the init, should be freed, call
acpi_put_table() to fix the memory leak.

Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 1860665..5bfb00f 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -676,12 +676,16 @@ static int crb_acpi_add(struct acpi_device *device)
 
 	/* Should the FIFO driver handle this? */
 	sm = buf->start_method;
-	if (sm == ACPI_TPM2_MEMORY_MAPPED)
-		return -ENODEV;
+	if (sm == ACPI_TPM2_MEMORY_MAPPED) {
+		rc = -ENODEV;
+		goto out;
+	}
 
 	priv = devm_kzalloc(dev, sizeof(struct crb_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
@@ -689,7 +693,8 @@ static int crb_acpi_add(struct acpi_device *device)
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
 				buf->header.length,
 				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
 		priv->smc_func_id = crb_smc->smc_func_id;
@@ -700,17 +705,23 @@ static int crb_acpi_add(struct acpi_device *device)
 
 	rc = crb_map_io(device, priv, buf);
 	if (rc)
-		return rc;
+		goto out;
 
 	chip = tpmm_chip_alloc(dev, &tpm_crb);
-	if (IS_ERR(chip))
-		return PTR_ERR(chip);
+	if (IS_ERR(chip)) {
+		rc = PTR_ERR(chip);
+		goto out;
+	}
 
 	dev_set_drvdata(&chip->dev, priv);
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
-	return tpm_chip_register(chip);
+	rc = tpm_chip_register(chip);
+
+out:
+	acpi_put_table((struct acpi_table_header *)buf);
+	return rc;
 }
 
 static int crb_acpi_remove(struct acpi_device *device)
-- 
1.7.12.4

