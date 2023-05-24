Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A456770FAD5
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 17:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjEXPxD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjEXPxB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 11:53:01 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0FE123
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 08:52:53 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202305241540510b7b92b56f4b37b023
        for <linux-integrity@vger.kernel.org>;
        Wed, 24 May 2023 17:40:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=coJpn8U6z2x97kEFfrICTEQTl92SE2XRXQx6exsZAqM=;
 b=BUA/DdWzc7rEe3lYXp9KD4jdoYwek3zamt0lpwZVkzkadUr/5cSjD76ElToTT6sH7k964n
 4WQZKNvunFVT07rTFrbVwOMgxDh2RgRfuLnV0rR13dSNMsStLs9EszlkEXwFqO7OIOGZwQjE
 wdfCb0OJa4LC9l/DcUNXIgo60G4hE=;
From:   "A. Sverdlin" <alexander.sverdlin@siemens.com>
To:     linux-integrity@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Michael Haener <michael.haener@siemens.com>
Subject: [PATCH 2/2] tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
Date:   Wed, 24 May 2023 17:40:40 +0200
Message-Id: <20230524154040.1204030-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Underlying I2C bus drivers not always support longer transfers and
imx-lpi2c for instance doesn't. The fix is symmetric to previous patch
which fixed the read direction.

Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
Tested-by: Michael Haener <michael.haener@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 106fd20d94e4..82fda488e98b 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -230,19 +230,27 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
 	u8 reg = tpm_tis_i2c_address_to_register(addr);
 	int ret;
+	u16 wrote = 0;
 
 	if (len > TPM_BUFSIZE - 1)
 		return -EIO;
 
-	/* write register and data in one go */
 	phy->io_buf[0] = reg;
-	memcpy(phy->io_buf + sizeof(reg), value, len);
-
-	msg.len = sizeof(reg) + len;
 	msg.buf = phy->io_buf;
-	ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-	if (ret < 0)
-		return ret;
+	while (wrote < len) {
+		/* write register and data in one go */
+		msg.len = sizeof(reg) + len - wrote;
+		if (msg.len > I2C_SMBUS_BLOCK_MAX)
+			msg.len = I2C_SMBUS_BLOCK_MAX;
+
+		memcpy(phy->io_buf + sizeof(reg), value + wrote,
+		       msg.len - sizeof(reg));
+
+		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+		if (ret < 0)
+			return ret;
+		wrote += msg.len - sizeof(reg);
+	}
 
 	return 0;
 }
-- 
2.40.1

