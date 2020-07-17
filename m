Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8814C223AD0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQLwi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 07:52:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgGQLwi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 07:52:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7AD5A89B4757263A6469;
        Fri, 17 Jul 2020 19:52:36 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 19:52:26 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/3] tpm: Put the TCPA table buf after using it
Date:   Fri, 17 Jul 2020 19:45:46 +0800
Message-ID: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used for runtime to release the table
mapping, put the TCPA table buf after using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/char/tpm/eventlog/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e..e8ac30b 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -79,6 +79,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		start = buff->client.log_start_addr;
 		break;
 	}
+
+	acpi_put_table((struct acpi_table_header *)buff);
+
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
 		return -EIO;
-- 
1.7.12.4

