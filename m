Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1762D99E
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbiKQLji (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 06:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiKQLjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 06:39:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A86828E;
        Thu, 17 Nov 2022 03:39:06 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCdGK5MZjzHvsd;
        Thu, 17 Nov 2022 19:38:33 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:39:05 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:39:04 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH v2 3/3] tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak
Date:   Thu, 17 Nov 2022 19:23:42 +0800
Message-ID: <1668684222-38457-4-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
References: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In check_acpi_tpm2(), we get the TPM2 table just to make
sure the table is there, not used after the init, so the
acpi_put_table() should be added to release the ACPI memory.

Fixes: 4cb586a188d4 ("tpm_tis: Consolidate the platform and acpi probe flow")
Cc: stable@vger.kernel.org
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/char/tpm/tpm_tis.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index bcff642..ed5dabd 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -125,6 +125,7 @@ static int check_acpi_tpm2(struct device *dev)
 	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
 	struct acpi_table_tpm2 *tbl;
 	acpi_status st;
+	int ret = 0;
 
 	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
 		return 0;
@@ -132,8 +133,7 @@ static int check_acpi_tpm2(struct device *dev)
 	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
 	 * table is mandatory
 	 */
-	st =
-	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
+	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
 	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
@@ -141,9 +141,10 @@ static int check_acpi_tpm2(struct device *dev)
 
 	/* The tpm2_crb driver handles this device */
 	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
-		return -ENODEV;
+		ret = -ENODEV;
 
-	return 0;
+	acpi_put_table((struct acpi_table_header *)tbl);
+	return ret;
 }
 #else
 static int check_acpi_tpm2(struct device *dev)
-- 
1.7.12.4

