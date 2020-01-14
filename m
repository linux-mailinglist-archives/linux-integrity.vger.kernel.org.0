Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17213A94D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANMbm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 07:31:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2925 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgANMbm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 07:31:42 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 67401374DF5D604B224B;
        Tue, 14 Jan 2020 20:31:38 +0800 (CST)
Received: from dggeme754-chm.china.huawei.com (10.3.19.100) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 20:31:38 +0800
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 14 Jan 2020 20:31:37 +0800
Received: from dggeme758-chm.china.huawei.com ([10.6.80.69]) by
 dggeme758-chm.china.huawei.com ([10.6.80.69]) with mapi id 15.01.1713.004;
 Tue, 14 Jan 2020 20:31:37 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhangchenfeng (EulerOS)" <zhangchenfeng1@huawei.com>
Subject: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Thread-Topic: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Thread-Index: AdXK1n6po1qzPnzORvy+SMMsyUhiWA==
Date:   Tue, 14 Jan 2020 12:31:37 +0000
Message-ID: <f3ff613761f345859d131e96bcd037ff@huawei.com>
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

when i reach TPM_RETRY, the cs cannot  change back to 'high'.So the TPM chips thinks this communication is not over. 
And next times communication cannot be effective because the communications mixed up with the last time.

Signed-off-by: Wang Hongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c index d1754fd..a1ae4f6 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -67,7 +67,14 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 		}
 
 		if (i == TPM_RETRY)
+ 		{
+ 			spi_xfer.cs_change = 0;
+ 			spi_xfer->len = 1;
+ 			spi_message_init(&m);
+ 			spi_message_add_tail(spi_xfer, &m);
+ 			ret = spi_sync_locked(phy->spi_device, &m);
 			return -ETIMEDOUT;
+ 		}
 	}
 
 	return 0;
--
1.7.12.4

