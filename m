Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86840B2A6
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhINPOi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 11:14:38 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:43279 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233617AbhINPOh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 11:14:37 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 18EFAlxd031447;
        Tue, 14 Sep 2021 18:10:47 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 2A7D863A1E; Tue, 14 Sep 2021 18:10:58 +0300 (IDT)
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
Subject: [PATCH v15 3/6] tpm: Handle an exception for TPM Firmware Update  mode.
Date:   Tue, 14 Sep 2021 18:10:29 +0300
Message-Id: <20210914151032.216122-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210914151032.216122-1-amirmizi6@gmail.com>
References: <20210914151032.216122-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Add a condition to enable communication with the TPM while the TPM is in
firmware update mode.
In such a case if power was cut during the TPM firmware update, the driver
should ignore the "selftest" command return code (TPM2_RC_UPGRADE or
TPM2_RC_COMMAND_CODE) and skip the rest of the TPM initialization
sequence.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>tpm: Handle an exception for TPM Firmware Update
 mode.
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 4 ++++
 include/linux/tpm.h         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a25815a..c2b541d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -729,6 +729,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
+
+	if (rc == TPM2_RC_UPGRADE || rc == TPM2_RC_COMMAND_CODE)
+		return 0;
+
 	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe3..c5bf934 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -207,6 +207,7 @@ enum tpm2_return_codes {
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_UPGRADE         = 0x012D,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
-- 
2.7.4

