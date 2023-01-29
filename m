Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E734B67FD4E
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Jan 2023 08:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjA2HI4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Jan 2023 02:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjA2HI4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jan 2023 02:08:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821422A12
        for <linux-integrity@vger.kernel.org>; Sat, 28 Jan 2023 23:08:54 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P4MqK1L9wzfZ5q;
        Sun, 29 Jan 2023 15:08:45 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 29 Jan
 2023 15:08:51 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <eajames@linux.ibm.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] tpm: of: fix return value check in tpm_read_log_memory_region()
Date:   Sun, 29 Jan 2023 15:26:37 +0800
Message-ID: <20230129072637.279576-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

devm_memremap() never returns NULL pointer, it will return
ERR_PTR() when it fails, so replace the check with IS_ERR().

Fixes: b0474a20b153 ("tpm: Add reserved memory event log")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/char/tpm/eventlog/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index c815cadf00a4..6a818a026c94 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -43,7 +43,7 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
 
 	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
 						 MEMREMAP_WB);
-	if (!chip->log.bios_event_log) {
+	if (IS_ERR(chip->log.bios_event_log)) {
 		dev_info(&chip->dev, "err memremap\n");
 		return -ENOMEM;
 	}
-- 
2.25.1

