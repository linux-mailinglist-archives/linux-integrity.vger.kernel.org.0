Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D464CFC9B
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiCGLXI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiCGLWl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8A33379;
        Mon,  7 Mar 2022 02:48:56 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBwC93sP0zdfml;
        Mon,  7 Mar 2022 18:47:33 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 18:48:54 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <wangweiyang2@huawei.com>, <xiujianfeng@huawei.com>,
        <weiyongjun1@huawei.com>, <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Date:   Mon, 7 Mar 2022 18:48:27 +0800
Message-ID: <20220307104827.40843-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
call put_device on error, while tpm->devs is left untouched. Call
put_device on tpm->devs as well if devm_add_action_or_reset returns an
error.

Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/char/tpm/tpm-chip.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index b009e7479b70..0a92334e8c40 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
 	return 0;
 }
 
+static void tpm_chip_free(struct tpm_chip *chip)
+{
+	put_device(&chip->devs);
+	put_device(&chip->dev);
+}
+
 /**
  * tpm_chip_alloc() - allocate a new struct tpm_chip instance
  * @pdev: device to which the chip is associated
@@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	return chip;
 
 out:
-	put_device(&chip->devs);
-	put_device(&chip->dev);
+	tpm_chip_free(chip);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_alloc);
@@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
 		return chip;
 
 	rc = devm_add_action_or_reset(pdev,
-				      (void (*)(void *)) put_device,
-				      &chip->dev);
+				      (void (*)(void *)) tpm_chip_free,
+				      chip);
 	if (rc)
 		return ERR_PTR(rc);
 
-- 
2.17.1

