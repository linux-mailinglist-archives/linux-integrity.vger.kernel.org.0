Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026FB70D18E
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 04:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjEWCpz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 22:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjEWCpy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 22:45:54 -0400
Received: from smtp.cecloud.com (unknown [1.203.97.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64962FD;
        Mon, 22 May 2023 19:45:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.cecloud.com (Postfix) with ESMTP id 903DF7C0112;
        Tue, 23 May 2023 10:45:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.11])
        by smtp.cecloud.com (postfix) whith ESMTP id P3330305T281460531392880S1684809949402733_;
        Tue, 23 May 2023 10:45:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <eb57533e096ba56c113cb7df8f34e952>
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: pmenzel@molgen.mpg.de
X-RCPT-COUNT: 7
X-SENDER-IP: 111.48.58.11
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   shaopeijie@cestc.cn
To:     pmenzel@molgen.mpg.de
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH v3] tpm_tis_spi: Release chip select when flow control fails
Date:   Tue, 23 May 2023 10:45:36 +0800
Message-Id: <20230523024536.4294-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230522070140.33719-1-shaopeijie@cestc.cn>
References: <20230522070140.33719-1-shaopeijie@cestc.cn>
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

The patch is tested by two ways.
One way needs to touch hardware:
   1. force pull MISO pin down to GND, it emulates a forever
      'WAIT' timing.
   2. probe cs pin by an oscilloscope.
   3. load tpm_tis_spi.ko.
After loading, dmesg prints:
    "probe of spi0.0 failed with error -110"
and oscilloscope shows cs pin goes high(deactivated) after
the failure. Before the patch, cs pin keeps low.

Second way is by writing a fake spi controller.
   1. implement .transfer_one method, fill all rx buf with 0.
   2. implement .set_cs method, print the state of cs pin.
   we can see cs goes high after the failure.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
Changes since v1:
    Thanks to BR, Jarkko's suggestions.
    1. Deactivate cs all of the failure path, not only flow control.
    2. change and update comments.
---
Changes since v2:
    Thanks to Paul?Menzel's suggestions.
    1. common commit tag and correct spelling mistakes.
    2. add test steps.
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



