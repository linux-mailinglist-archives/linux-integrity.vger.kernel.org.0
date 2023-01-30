Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3066680D50
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjA3MO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 07:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjA3MON (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 07:14:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB873527D
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 04:13:41 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P56TP4B9hz16NHb;
        Mon, 30 Jan 2023 20:10:49 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 20:12:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <eajames@linux.ibm.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2] tpm: of: fix return value check in tpm_read_log_memory_region()
Date:   Mon, 30 Jan 2023 20:12:40 +0800
Message-ID: <20230130121240.3344618-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
v1 -> v2:
  Change the return value to PTR_ERR().
---
 drivers/char/tpm/eventlog/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index c815cadf00a4..a25a5a2d4b35 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -43,9 +43,9 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
 
 	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
 						 MEMREMAP_WB);
-	if (!chip->log.bios_event_log) {
+	if (IS_ERR(chip->log.bios_event_log)) {
 		dev_info(&chip->dev, "err memremap\n");
-		return -ENOMEM;
+		return PTR_ERR(chip->log.bios_event_log);
 	}
 
 	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
-- 
2.25.1

