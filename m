Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8688F29AAF0
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411656AbgJ0LdZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 07:33:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6398 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411573AbgJ0LdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 07:33:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CL8j15Flkz6yjG;
        Tue, 27 Oct 2020 19:33:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:33:17 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm_tis_core: Add the error log when the chip startup failed
Date:   Tue, 27 Oct 2020 19:33:57 +0800
Message-ID: <1603798437-54591-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM does not print any log when the startup fails, if there is a
problem with the hardware, wait_wartup is the first place to go wrong,
so add error log when wait_wartup fails to locate the problem.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6..660c0a93 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -991,6 +991,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		chip->ops->clk_enable(chip, true);
 
 	if (wait_startup(chip, 0) != 0) {
+		dev_err(dev, "Could not startup the TPM Chip\n");
 		rc = -ENODEV;
 		goto out_err;
 	}
-- 
2.7.4

