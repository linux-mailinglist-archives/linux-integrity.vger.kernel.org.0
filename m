Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C342B70E
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhJMG3V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 02:29:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23373 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhJMG3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 02:29:19 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTjBb4xtbzbd0K;
        Wed, 13 Oct 2021 14:22:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 14:27:15 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 14:27:15 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <rui.xiang@huawei.com>
Subject: [PATCH v2 1/1] tpm: add request_locality before write TPM_INT_ENABLE
Date:   Wed, 13 Oct 2021 06:25:56 +0000
Message-ID: <20211013062556.116504-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Locality is not appropriately requested before writing the int mask.
Add the missing boilerplate.

Fixes: e6aef069b6e9 ("tpm_tis: convert to using locality callbacks")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---

 v2: rewrite the commit message.

 drivers/char/tpm/tpm_tis_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 69579efb247b..bea587301917 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -978,7 +978,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
 		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
+
+	rc = request_locality(chip, 0);
+	if (rc < 0) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+	release_locality(chip, 0);
 
 	rc = tpm_chip_start(chip);
 	if (rc)
-- 
2.17.1

