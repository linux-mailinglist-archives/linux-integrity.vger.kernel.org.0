Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF113B997
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOGbM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 01:31:12 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:37366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgAOGbM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 01:31:12 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 56960D6152FC346627E6;
        Wed, 15 Jan 2020 14:31:09 +0800 (CST)
Received: from dggeme701-chm.china.huawei.com (10.1.199.97) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 14:31:09 +0800
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 15 Jan 2020 14:31:08 +0800
Received: from dggeme758-chm.china.huawei.com ([10.6.80.69]) by
 dggeme758-chm.china.huawei.com ([10.6.80.69]) with mapi id 15.01.1713.004;
 Wed, 15 Jan 2020 14:31:08 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhangchenfeng (EulerOS)" <zhangchenfeng1@huawei.com>
Subject: [PATCH] tpm:tpm_tis_spi: set cs_change = 0 when timesout
Thread-Topic: [PATCH] tpm:tpm_tis_spi: set cs_change = 0 when timesout
Thread-Index: AQHVy2x8lmg/cN4ytUSguZDGUnST5KfrQkew
Date:   Wed, 15 Jan 2020 06:31:08 +0000
Message-ID: <d57b92c5ab2a44a4bac2626dcf1210f5@huawei.com>
References: <1579071543-22632-1-git-send-email-wanghongzhe@huawei.com>
In-Reply-To: <1579071543-22632-1-git-send-email-wanghongzhe@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.190.130]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

