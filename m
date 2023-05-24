Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704070FAA2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjEXPmw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjEXPma (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 11:42:30 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C61716
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 08:41:51 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305241540502efe19dc95d03e040e
        for <linux-integrity@vger.kernel.org>;
        Wed, 24 May 2023 17:40:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZleL3ST0XPNGt2fgQSXW/cK2rv3FOpZbAigNjtSUHpo=;
 b=Whtsf3wsUzZRPWC2b2MKrRj//aDpTZWpoxk2yrNtcz6L2rzh/g89piOB6KxKvavL21nSHz
 H2M2xfC1o48MyIri4KaltHmlHri2QW9AceMgY1TEkDff5jc/PpLq3EI9egyJtLl06LSE7sf2
 lGKVRAr4qK8c0oNPgaeke9XMNG3XQ=;
From:   "A. Sverdlin" <alexander.sverdlin@siemens.com>
To:     linux-integrity@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Michael Haener <michael.haener@siemens.com>
Subject: [PATCH 1/2] tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
Date:   Wed, 24 May 2023 17:40:39 +0200
Message-Id: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
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
imx-lpi2c for instance doesn't. SLB 9673 offers 427-bytes packets.

Visible symptoms are:

tpm tpm0: Error left over data
tpm tpm0: tpm_transmit: tpm_recv: error -5
tpm_tis_i2c: probe of 1-002e failed with error -5

Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
Tested-by: Michael Haener <michael.haener@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 37 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index c8c34adc14c0..106fd20d94e4 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -189,21 +189,28 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 
 	for (i = 0; i < TPM_RETRY; i++) {
-		/* write register */
-		msg.len = sizeof(reg);
-		msg.buf = &reg;
-		msg.flags = 0;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
-
-		/* read data */
-		msg.buf = result;
-		msg.len = len;
-		msg.flags = I2C_M_RD;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
+		u16 read = 0;
+
+		while (read < len) {
+			/* write register */
+			msg.len = sizeof(reg);
+			msg.buf = &reg;
+			msg.flags = 0;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+
+			/* read data */
+			msg.buf = result + read;
+			msg.len = len - read;
+			msg.flags = I2C_M_RD;
+			if (msg.len > I2C_SMBUS_BLOCK_MAX)
+				msg.len = I2C_SMBUS_BLOCK_MAX;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+			read += msg.len;
+		}
 
 		ret = tpm_tis_i2c_sanity_check_read(reg, len, result);
 		if (ret == 0)
-- 
2.40.1

