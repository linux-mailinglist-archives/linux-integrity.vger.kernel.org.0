Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED140443193
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhKBP17 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 11:27:59 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:47453 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234447AbhKBP15 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 11:27:57 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 1A2FMYmV005892;
        Tue, 2 Nov 2021 17:22:34 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id F05DF63A1E; Tue,  2 Nov 2021 17:22:45 +0200 (IST)
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
Subject: [PATCH v18 2/6] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
Date:   Tue,  2 Nov 2021 17:20:52 +0200
Message-Id: <20211102152056.241769-3-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211102152056.241769-1-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
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

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f833f35..90d92a1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -661,13 +661,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
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

