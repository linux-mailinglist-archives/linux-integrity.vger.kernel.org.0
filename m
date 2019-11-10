Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37EFF6A27
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Nov 2019 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKJQdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Nov 2019 11:33:19 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:44397 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbfKJQdT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Nov 2019 11:33:19 -0500
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Nov 2019 11:33:15 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xAAGMNgb013906;
        Sun, 10 Nov 2019 18:22:23 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 9E0C560275; Sun, 10 Nov 2019 18:22:23 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1 3/5] char: tpm: rewrite "tpm_tis_req_canceled()"
Date:   Sun, 10 Nov 2019 18:21:35 +0200
Message-Id: <20191110162137.230913-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191110162137.230913-1-amirmizi6@gmail.com>
References: <20191110162137.230913-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

using this function while read/write data resulted in aborted operation.
after investigating according to TCG TPM Profile (PTP) Specifications,
i found cancel should happen only if TPM_STS.commandReady bit is lit
and couldn't find a case when the current condition is valid.
also only cmdReady bit need to be compared instead of the full lower status register byte.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index ce7f8a1..9016f06 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -627,17 +627,7 @@ static int probe_itpm(struct tpm_chip *chip)
 
 static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 {
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-
-	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
-	case TPM_VID_STM:
-		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
-	default:
-		return (status == TPM_STS_COMMAND_READY);
-	}
+	return ((status & TPM_STS_COMMAND_READY) == TPM_STS_COMMAND_READY);
 }
 
 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
-- 
2.7.4

