Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08561A113F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Apr 2020 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgDGQWS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Apr 2020 12:22:18 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40622 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727707AbgDGQWR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Apr 2020 12:22:17 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 037GKs1W002269;
        Tue, 7 Apr 2020 19:20:54 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id A8684639B0; Tue,  7 Apr 2020 19:20:54 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v6 3/7] tpm: tpm_tis: rewrite "tpm_tis_req_canceled()"
Date:   Tue,  7 Apr 2020 19:20:40 +0300
Message-Id: <20200407162044.168890-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200407162044.168890-1-amirmizi6@gmail.com>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Using this function while read/write data resulted in aborted operation.
After investigating according to TCG TPM Profile (PTP) Specifications,
i found cancel should happen only if TPM_STS.commandReady bit is lit and
couldn't find a case when the current condition is valid.
So i'm removing the case for "TPM_VID_WINBOND" since we have no need for it

Also default comparison is wrong. only cmdReady bit need to be compared
instead of the full lower status register byte.

Fixes: 1f86605 (tpm: Fix cancellation of TPM commands (polling mode))
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6c4f232..453d7ef 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -713,13 +713,10 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
 	case TPM_VID_STM:
 		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
 	default:
-		return (status == TPM_STS_COMMAND_READY);
+		return ((status & TPM_STS_COMMAND_READY) == TPM_STS_COMMAND_READY);
 	}
 }
 
-- 
2.7.4

