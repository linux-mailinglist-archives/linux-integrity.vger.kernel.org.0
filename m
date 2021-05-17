Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE138227E
	for <lists+linux-integrity@lfdr.de>; Mon, 17 May 2021 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhEQBUP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 May 2021 21:20:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2980 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhEQBUP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 May 2021 21:20:15 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fk1Qq1VZGzQpQt;
        Mon, 17 May 2021 09:15:31 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 09:18:45 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 09:18:45 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [RESEND PATCH v2 1/1] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Mon, 17 May 2021 09:18:44 +0800
Message-ID: <1621214324-55965-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable because of requesting.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Link: https://lore.kernel.org/patchwork/patch/1388765/

v2: add the Link.
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f19c227..44dde2f 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -706,14 +706,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
 
 	if (client->irq > 0) {
 		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+				      IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
 			return rc;
 		}
 
-		disable_irq(client->irq);
 		priv->irq = client->irq;
 	} else {
 		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
-- 
2.7.4

