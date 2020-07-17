Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDA223AD1
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 13:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQLwl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 07:52:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgGQLwl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 07:52:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7EEFC9CEE36D5138D56B;
        Fri, 17 Jul 2020 19:52:36 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 19:52:28 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 3/3] tpm: tpm_tis: Put the TPM2 table after using it
Date:   Fri, 17 Jul 2020 19:45:48 +0800
Message-ID: <1594986348-52258-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
References: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ACPI table buffer should be put to release the table
mapping.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/char/tpm/tpm_tis.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342..59b25c1 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -102,6 +102,7 @@ static int check_acpi_tpm2(struct device *dev)
 	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
 	struct acpi_table_tpm2 *tbl;
 	acpi_status st;
+	int ret = 0;
 
 	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
 		return 0;
@@ -109,8 +110,7 @@ static int check_acpi_tpm2(struct device *dev)
 	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
 	 * table is mandatory
 	 */
-	st =
-	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
+	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
 	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
@@ -118,9 +118,10 @@ static int check_acpi_tpm2(struct device *dev)
 
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

