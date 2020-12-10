Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32422D5C7C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgLJNz7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 08:55:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9179 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbgLJNzx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 08:55:53 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CsFlC2Ft3zkmDt;
        Thu, 10 Dec 2020 21:54:15 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:54:47 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] char/tpm: simplify the return expression of tpm_tis_synquacer_module_init()
Date:   Thu, 10 Dec 2020 21:55:15 +0800
Message-ID: <20201210135515.1310-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/char/tpm/tpm_tis_synquacer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index e47bdd272704..3b4ae2f23f09 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -188,13 +188,8 @@ static struct platform_driver tis_synquacer_drv = {
 
 static int __init tpm_tis_synquacer_module_init(void)
 {
-	int rc;
 
-	rc = platform_driver_register(&tis_synquacer_drv);
-	if (rc)
-		return rc;
-
-	return 0;
+	return platform_driver_register(&tis_synquacer_drv);
 }
 
 static void __exit tpm_tis_synquacer_module_exit(void)
-- 
2.22.0

