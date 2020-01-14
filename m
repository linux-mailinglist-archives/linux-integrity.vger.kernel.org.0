Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D345F13A883
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANLhZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 06:37:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgANLhY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 06:37:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5D383837EBCFFFE14AA6;
        Tue, 14 Jan 2020 19:37:22 +0800 (CST)
Received: from huawei.com (10.175.107.192) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 19:37:12 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangchenfeng1@huawei.com>
Subject: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Date:   Tue, 14 Jan 2020 20:12:31 +0800
Message-ID: <1579003951-16029-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.107.192]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

when i reach TPM_RETRY, the cs cannot  change back to 'high'.So the TPM chips thinks this communication is not over. 
And next times communication cannot be effective because the communications mixed up with the last time.

Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..a1ae4f6 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -67,7 +67,14 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 		}
 
 		if (i == TPM_RETRY)
+        {
+            spi_xfer.cs_change = 0;
+            spi_xfer->len = 1;
+            spi_message_init(&m);
+            spi_message_add_tail(spi_xfer, &m);
+            ret = spi_sync_locked(phy->spi_device, &m);
 			return -ETIMEDOUT;
+        }
 	}
 
 	return 0;
-- 
1.7.12.4

