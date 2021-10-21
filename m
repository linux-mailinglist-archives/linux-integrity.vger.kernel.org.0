Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2038436144
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Oct 2021 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhJUMU4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Oct 2021 08:20:56 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45859 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231628AbhJUMUq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Oct 2021 08:20:46 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 08:20:34 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 19LC6vgt003257;
        Thu, 21 Oct 2021 15:06:57 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 3A90863A1D; Thu, 21 Oct 2021 15:07:09 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v16 2/6] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
Date:   Thu, 21 Oct 2021 15:05:53 +0300
Message-Id: <20211021120557.69234-3-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211021120557.69234-1-amirmizi6@gmail.com>
References: <20211021120557.69234-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

tpm_tis_req_canceled() function is used to check if the caller requested
to abort the current operation. It was found that in some cases
tpm_tis_req_canceled() wrongly returned true.
Since a cancel request sets the TPM_STS.commandReady field to TRUE, the
tpm_tis_req_canceled() function should check only the TPM_STS.commandReady
field value.
The case for TPM_VID_WINBOND is wrong and was therefore removed.

Also, the default comparison is wrong. Only cmdReady bit needs to be
compared instead of the full lower status register byte.

Fixes: 1f866057291f (tpm: Fix cancellation of TPM commands (polling mode))
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 0985184..3e60072 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -650,13 +650,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
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

