Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164E622305
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 05:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKIETR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 23:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKIETM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 23:19:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684B15704
        for <linux-integrity@vger.kernel.org>; Tue,  8 Nov 2022 20:18:49 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6WtN1311z15MRp;
        Wed,  9 Nov 2022 12:18:36 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 12:18:48 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 12:18:47 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/3] tpm: acpi: Call acpi_put_table() to fix memory leak
Date:   Wed, 9 Nov 2022 12:03:40 +0800
Message-ID: <1667966622-19711-2-git-send-email-guohanjun@huawei.com>
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

The start and length of the event log area are obtained from
TPM2 or TCPA table, so we call acpi_get_table() to get the
ACPI information, but the acpi_get_table() should be coupled with
acpi_put_table() to release the ACPI memory, add the acpi_put_table()
properly to fix the memory leak.

While we are at it, remove the redundant empty line at the
end of the tpm_read_log_acpi().

Fixes: 0bfb23746052 ("tpm: Move eventlog files to a subdirectory")
Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/char/tpm/eventlog/acpi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 1b18ce5..0913d3eb 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -90,16 +90,21 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 			return -ENODEV;
 
 		if (tbl->header.length <
-				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
+				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy)) {
+			acpi_put_table((struct acpi_table_header *)tbl);
 			return -ENODEV;
+		}
 
 		tpm2_phy = (void *)tbl + sizeof(*tbl);
 		len = tpm2_phy->log_area_minimum_length;
 
 		start = tpm2_phy->log_area_start_address;
-		if (!start || !len)
+		if (!start || !len) {
+			acpi_put_table((struct acpi_table_header *)tbl);
 			return -ENODEV;
+		}
 
+		acpi_put_table((struct acpi_table_header *)tbl);
 		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	} else {
 		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
@@ -120,8 +125,10 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 			break;
 		}
 
+		acpi_put_table((struct acpi_table_header *)buff);
 		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
 	}
+
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
 		return -EIO;
@@ -156,5 +163,4 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	kfree(log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
-
 }
-- 
1.7.12.4

