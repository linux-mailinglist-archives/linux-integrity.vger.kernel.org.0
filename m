Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BF13BA1F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 08:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOHJc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 02:09:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgAOHJc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 02:09:32 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DDFA057CB3E9AF955BB7;
        Wed, 15 Jan 2020 15:09:29 +0800 (CST)
Received: from huawei.com (10.175.107.192) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 15:09:20 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangchenfeng1@huawei.com>, <wanghongzhe@huawei.com>
Subject: [PATCH] tpm:tpm_tis_spi: set cs_change = 0 when timesout
Date:   Wed, 15 Jan 2020 15:09:24 +0800
Message-ID: <1579072164-23423-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.107.192]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Wang Hongzhe <wanghongzhe@huawei.com>

when i reach TPM_RETRY, the cs cannot  change back to 'high'.
So the TPM chips thinks this communication is not over.
And next times communication cannot be effective because the
communications mixed up with the last time.

Signed-off-by: Wang Hongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..27e57bf 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -66,8 +66,15 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 				break;
 		}
 
-		if (i == TPM_RETRY)
+		if (i == TPM_RETRY) {
+			spi_xfer->len = 1;
+			spi_xfer->cs_change = 0;
+			spi_message_init(&m);
+			spi_message_add_tail(spi_xfer, &m);
+			if (ret < 0)
+				return ret;
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
-- 
1.7.12.4

