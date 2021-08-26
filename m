Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0E3F8724
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbhHZMTK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 08:19:10 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:41642 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242404AbhHZMTK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 08:19:10 -0400
X-Greylist: delayed 3347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 08:19:09 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 17QBJY8M025250;
        Thu, 26 Aug 2021 14:19:34 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id F075963A1C; Thu, 26 Aug 2021 14:19:43 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v13 4/7] tpm: Handle an exception for TPM Firmware Update  mode.
Date:   Thu, 26 Aug 2021 14:19:05 +0300
Message-Id: <20210826111908.117278-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210826111908.117278-1-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

An extra precaution for TPM Firmware Update Mode.
For example if TPM power was cut while in Firmware update, platform
should ignore "selftest" failure and skip TPM initialization sequence.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
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

