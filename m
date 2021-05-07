Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1148376747
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhEGOyI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 10:54:08 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58752 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234601AbhEGOyI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 10:54:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY3o8YN_1620399176;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UY3o8YN_1620399176)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 22:53:06 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] tpm_tis_spi: set default probe function if device id not match
Date:   Fri,  7 May 2021 22:52:55 +0800
Message-Id: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
causes device probe fails. In order to make newer kernel to be
compatible with the older acpi definition, it would be best set default
probe function.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3856f6ebcb34..da632a582621 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
 	tpm_tis_spi_probe_func probe_func;
 
 	probe_func = of_device_get_match_data(&spi->dev);
-	if (!probe_func && spi_dev_id)
-		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
-	if (!probe_func)
-		return -ENODEV;
+	if (!probe_func) {
+		if (spi_dev_id) {
+			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
+			if (!probe_func)
+				return -ENODEV;
+		} else
+			probe_func = tpm_tis_spi_probe;
+	}
 
 	return probe_func(spi);
 }
-- 
2.19.1.6.gb485710b

