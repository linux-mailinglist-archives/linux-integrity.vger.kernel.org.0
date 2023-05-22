Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDC70B5EC
	for <lists+linux-integrity@lfdr.de>; Mon, 22 May 2023 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEVHKX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjEVHJm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 03:09:42 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 00:08:29 PDT
Received: from smtp.cecloud.com (sg-smtp01.cecloud.com [13.251.65.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACABCA
        for <linux-integrity@vger.kernel.org>; Mon, 22 May 2023 00:08:29 -0700 (PDT)
Received: from smtp.cecloud.com (unknown [103.166.174.66])
        by smtp.cecloud.com (Postfix) with ESMTP id AC7CB167
        for <linux-integrity@vger.kernel.org>; Mon, 22 May 2023 07:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by smtp.cecloud.com (Postfix) with ESMTP id 17E69900113;
        Mon, 22 May 2023 15:01:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.11])
        by smtp.cecloud.com (postfix) whith ESMTP id P2917246T281458643890544S1684738912085108_;
        Mon, 22 May 2023 15:01:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cc80ce2c510edff53b2dd528a9553ba8>
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: jarkko@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 111.48.58.11
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   shaopeijie@cestc.cn
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH v2] tpm_tis_spi: fix:release chip select when flow control fails
Date:   Mon, 22 May 2023 15:01:40 +0800
Message-Id: <20230522070140.33719-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Peijie Shao <shaopeijie@cestc.cn>

The failure paths in tpm_tis_spi_transfer() do not deactivate
chip select. Send an empty message (cs_select == 0) to overcome
this.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
Changes since v1:
    1. Deactive cs all of the failure path, not only flow control.
    2. change and update comments.
---
 drivers/char/tpm/tpm_tis_spi_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 1f5207974..9bfaba092 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -136,6 +136,14 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 	}
 
 exit:
+	if (ret < 0) {
+		/* Deactivate chip select */
+		memset(&spi_xfer, 0, sizeof(spi_xfer));
+		spi_message_init(&m);
+		spi_message_add_tail(&spi_xfer, &m);
+		spi_sync_locked(phy->spi_device, &m);
+	}
+
 	spi_bus_unlock(phy->spi_device->master);
 	return ret;
 }
-- 
2.39.1



