Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8777C920
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 10:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjHOIHA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Aug 2023 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjHOIG6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Aug 2023 04:06:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523A172A
        for <linux-integrity@vger.kernel.org>; Tue, 15 Aug 2023 01:06:57 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ3g00PV0zNmmq;
        Tue, 15 Aug 2023 16:03:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 16:06:54 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC:     <lizetao1@huawei.com>, <linux-integrity@vger.kernel.org>
Subject: [PATCH -next] tpm/tpm_tis_synquacer: Use module_platform_driver macro to simplify the code
Date:   Tue, 15 Aug 2023 16:06:37 +0800
Message-ID: <20230815080637.1100650-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use the module_platform_driver macro to simplify the code, which is the
same as declaring with module_init() and module_exit().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/char/tpm/tpm_tis_synquacer.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 49278746b0e2..f7d5e76b505e 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -162,23 +162,7 @@ static struct platform_driver tis_synquacer_drv = {
 	},
 };
 
-static int __init tpm_tis_synquacer_module_init(void)
-{
-	int rc;
-
-	rc = platform_driver_register(&tis_synquacer_drv);
-	if (rc)
-		return rc;
-
-	return 0;
-}
-
-static void __exit tpm_tis_synquacer_module_exit(void)
-{
-	platform_driver_unregister(&tis_synquacer_drv);
-}
+module_platform_driver(tis_synquacer_drv);
 
-module_init(tpm_tis_synquacer_module_init);
-module_exit(tpm_tis_synquacer_module_exit);
 MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
 MODULE_LICENSE("GPL");
-- 
2.34.1

