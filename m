Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A433D8C4E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 12:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhG1K4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 06:56:00 -0400
Received: from smtp1.axis.com ([195.60.68.17]:42319 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236069AbhG1Kzw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 06:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1627469751;
  x=1659005751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=exMO1CjlI492RauDLoVsuVOqHJtnXLvleQim1mQfQRs=;
  b=ayVldceoAEqJ8nxvFNiVjo0tbTER0iD+BH6nh5uYFJpHTqmnc1ZVIB4i
   D6q7Kx/tN43ku0sOthD/q0pA3VSBJaAXsHdYc5HWtklsdwjZWgrP0CV+F
   zj6xPV17n+E8GaECtEwGMt0y6uVm3SJjO4A2h98atMTGUHW3TtBpp6KfG
   18DfPjp5kTngCYLLTvZQzqv9PM5Cx2cTosA3vU8sFA4J2yZsn4jHHsWVu
   HYvhbtm6LVscNnhlV294bDZT8MQNn1XFzi0ZxEeIBTI8l4JPGoi7g+4Zo
   BeS1zZQp70/mIoyuOlgG461+w97Yi236c6PIHUCYdvcQCeq9Zr91tV5Pp
   w==;
From:   Borys Movchan <borysmn@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <kernel@axis.com>, Borys Movchan <borysmn@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Date:   Wed, 28 Jul 2021 12:57:30 +0200
Message-ID: <20210728105730.10170-1-borysmn@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If something went wrong during the TPM firmware upgrade,
like power failure or the firmware image file get corrupted,
the TPM might end up in Upgrade or Failure mode upon the
next start. The state is persistent between the TPM power
cycle/restart.

According to TPM specification:
 * If the TPM is in Upgrade mode, it will answer with
   TPM2_RC_UPGRADE to all commands except Field Upgrade
   related ones.
 * If the TPM is in Failure mode, it will allow performing
   TPM initialization but will not provide any crypto
   operations. Will happily respond to Field Upgrade calls.

The fix adds the possibility to detect an active state of
the TPM and gives the user-space a chance to finish the
firmware upgrade/recover the TPM.

Signed-off-by: Borys Movchan <borysmn@axis.com>
---

Notes:
    v2: The terms are changed to match the ones used in the TPM specification.
    Rework the commit message to provide more details regarding TPM
    behavior in Failure/Upgrade mode.

    The TPM specification describes TPM behavior in Upgrade mode very clearly.
    Things are a bit more complex if we are talking about Failure mode.
    The TPM behavior in this mode is highly vendor-specific. Although, there
    is one thing clearly described in the TPM specification and can be relied
    on to detect the Failure state: in Failure mode, the TPM doesn't provide
    any crypto operations. Including access to attributes and configuration
    registers.
    It seems persistent between different TPM manufacturers, at least to the
    degree I was able to verify.

 drivers/char/tpm/tpm-chip.c | 23 +++++++++++++++--------
 drivers/char/tpm/tpm2-cmd.c | 12 ++++++++++--
 include/linux/tpm.h         |  1 +
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..ff2367c447fb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -574,20 +574,25 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
+	bool limited_mode = false;
 
 	rc = tpm_chip_start(chip);
 	if (rc)
 		return rc;
 	rc = tpm_auto_startup(chip);
-	if (rc) {
+	if (rc == -EIO) {
+		limited_mode = true;
+	} else if (rc) {
 		tpm_chip_stop(chip);
 		return rc;
 	}
 
-	rc = tpm_get_pcr_allocation(chip);
-	tpm_chip_stop(chip);
-	if (rc)
-		return rc;
+	if (!limited_mode) {
+		rc = tpm_get_pcr_allocation(chip);
+		tpm_chip_stop(chip);
+		if (rc)
+			return rc;
+	}
 
 	tpm_sysfs_add_device(chip);
 
@@ -595,9 +600,11 @@ int tpm_chip_register(struct tpm_chip *chip)
 
 	tpm_add_ppi(chip);
 
-	rc = tpm_add_hwrng(chip);
-	if (rc)
-		goto out_ppi;
+	if (!limited_mode) {
+		rc = tpm_add_hwrng(chip);
+		if (rc)
+			goto out_ppi;
+	}
 
 	rc = tpm_add_char_device(chip);
 	if (rc)
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a25815a6f625..7468353ed67d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -718,7 +718,8 @@ static int tpm2_startup(struct tpm_chip *chip)
  *                     sequence
  * @chip: TPM chip to use
  *
- * Returns 0 on success, < 0 in case of fatal error.
+ * Returns 0 on success, -ENODEV in case of fatal error,
+ *	    -EIO in case of Reduced/Upgrade mode
  */
 int tpm2_auto_startup(struct tpm_chip *chip)
 {
@@ -729,7 +730,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc && rc != TPM2_RC_INITIALIZE)
+	if (rc == TPM2_RC_UPGRADE) {
+		rc = -EIO;
+		goto out;
+	} else if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
@@ -743,6 +747,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	if (rc) { /* Succeeded until here, but failed -> reduced mode */
+		rc = -EIO;
+		goto out;
+	}
 
 out:
 	if (rc > 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..e873c42907f0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -207,6 +207,7 @@ enum tpm2_return_codes {
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_UPGRADE		= 0x012D,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
-- 
2.20.1

