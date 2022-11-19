Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9706A630E21
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Nov 2022 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKSKqs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Nov 2022 05:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSKqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Nov 2022 05:46:47 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661DC9BA24
        for <linux-integrity@vger.kernel.org>; Sat, 19 Nov 2022 02:46:45 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDqxv1xhGzFq83;
        Sat, 19 Nov 2022 18:43:31 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 18:46:42 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <peterhuewe@gmx.de>,
        <jarkko@kernel.org>, <jgg@ziepe.ca>, <adlai@linux.vnet.ibm.com>,
        <key@linux.vnet.ibm.com>, <cuigaosheng1@huawei.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
Subject: [PATCH] tpm: ibmvtpm: free irq on the error path in tpm_ibmvtpm_probe()
Date:   Sat, 19 Nov 2022 18:46:42 +0800
Message-ID: <20221119104642.3964551-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In tpm_ibmvtpm_probe(), vio_dev->irq has not been freed on the
init_irq_cleanup error path, we need to free it. Fix it.

Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index d3989b257f42..8c23aabdfc24 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -649,7 +649,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 			 tpm_ibmvtpm_driver_name, ibmvtpm);
 	if (rc) {
 		dev_err(dev, "Error %d register irq 0x%x\n", rc, vio_dev->irq);
-		goto init_irq_cleanup;
+		goto req_irq_cleanup;
 	}
 
 	rc = vio_enable_interrupts(vio_dev);
@@ -702,6 +702,8 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 
 	return tpm_chip_register(chip);
 init_irq_cleanup:
+	free_irq(vio_dev->irq, ibmvtpm);
+req_irq_cleanup:
 	do {
 		rc1 = plpar_hcall_norets(H_FREE_CRQ, vio_dev->unit_address);
 	} while (rc1 == H_BUSY || H_IS_LONG_BUSY(rc1));
-- 
2.25.1

