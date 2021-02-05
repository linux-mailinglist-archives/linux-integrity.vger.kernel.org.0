Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9B31061B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 08:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBEH5F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 02:57:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12838 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhBEH5F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 02:57:05 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX74Q622Gz7hQV;
        Fri,  5 Feb 2021 15:55:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 15:56:21 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tpm_tis_spi_main: set cs_change = 0 when timesout
Date:   Fri, 5 Feb 2021 16:41:09 +0800
Message-ID: <1612514469-4002-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

when i reach TPM_RETRY, the cs cannot  change back to 'high'.
So the TPM chips thinks this communication is not over.
And next times communication cannot be effective because
the communications mixed up with the last time.

v1 -> v2:
 - fix spi_xfer->cs_change error

Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3856f6ebcb34..6c52cbb28881 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -64,8 +64,18 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 				break;
 		}
 
-		if (i == TPM_RETRY)
+		if (i == TPM_RETRY) {
+			/* change back to 'high',
+			 * So the TPM chips thinks the last communication
+			 * is done.
+			 */
+			spi_xfer->cs_change = 0;
+			spi_xfer->len = 1;
+			spi_message_init(&m);
+			spi_message_add_tail(spi_xfer, &m);
+			ret = spi_sync_locked(phy->spi_device, &m);
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
-- 
2.19.1

