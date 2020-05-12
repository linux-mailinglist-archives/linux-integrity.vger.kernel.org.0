Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAF1CF6C2
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgELOPn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 10:15:43 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:48549 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729229AbgELOPn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 10:15:43 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 04CEFE44011249;
        Tue, 12 May 2020 17:15:14 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 5E69E639BE; Tue, 12 May 2020 17:15:14 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org,
        "benoit.houyere@st.com--to=mark.rutland"@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v8 3/8] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
Date:   Tue, 12 May 2020 17:14:26 +0300
Message-Id: <20200512141431.83833-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512141431.83833-1-amirmizi6@gmail.com>
References: <20200512141431.83833-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Using this function while reading/writing data resulted in an aborted
operation.
After investigating the issue according to the TCG TPM Profile (PTP)
Specifications, I found that "request to cancel" should occur only if
TPM_STS.commandReady bit is lit.
Note that i couldn't find a case where the present condition
(in the linux kernel) is valid, so I'm removing the case for
"TPM_VID_WINBOND" since we have no need for it.

Also, the default comparison is wrong. Only cmdReady bit needs to be
compared instead of the full lower status register byte.

Fixes: 1f866057291f (tpm: Fix cancellation of TPM commands (polling mode))
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5dd5604..682f950 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -715,13 +715,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
 	case TPM_VID_STM:
 		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
 	default:
-		return (status == TPM_STS_COMMAND_READY);
+		return ((status & TPM_STS_COMMAND_READY) ==
+			TPM_STS_COMMAND_READY);
 	}
 }
 
-- 
2.7.4

