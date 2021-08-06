Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8923E2C51
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhHFOQM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 10:16:12 -0400
Received: from smtp1.axis.com ([195.60.68.17]:43318 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237635AbhHFOQL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1628259356;
  x=1659795356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8pCUOSIuKbxNqx46D22O+hfLVUOlEUUvEt9QjI8/HAQ=;
  b=LzHqmVMOQAbEBHxBziYEdIqt7ddycLKppL9lYW1Z0zlmW2bFpUUuk6mq
   Na/pZY1SDNsqvWQFUOV8xn+mhW0EUz/Vk0SyuhdVXL9cSO5UhzR04QeOV
   mXYAcV9bPe19MkrW2jqfgFO4F8CRMzyWE9ZeM2I0rRsaMsbOZoB+78zqn
   tv5VaVvJVpRa2BhdsmUYrvdE3aZhGmqS/jTIn9QKJu8s1KePFAkhxHfmS
   eeiNV3cJqTjIxblJ5j22zIKATYJlk0bvz3945isOkDuFV1HIfS4O68biB
   gSyz/kAN8hunGN/McTxhzC4frbP8pELk9/XgMtG2OO6zfdBeUiv9Q4UFC
   g==;
From:   Borys Movchan <borysmn@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <kernel@axis.com>, Borys Movchan <borysmn@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Date:   Fri, 6 Aug 2021 16:18:08 +0200
Message-ID: <20210806141808.6537-1-borysmn@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If something went wrong during the TPM firmware upgrade, like power
failure or the firmware image file get corrupted, the TPM might end
up in Upgrade or Failure mode upon the next start. The state is
persistent between the TPM power cycle/restart.

According to TPM specification:
 * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
   to all commands except Field Upgrade related ones.
 * If the TPM is in Failure mode, it will allow performing TPM
   initialization but will not provide any crypto operations.
   Will happily respond to Field Upgrade calls.

Change the behavior of the tpm2_auto_startup(), so it detects the active
running mode of the TPM.  It is easy to determine that TPM is in Upgrade
mode by relying on the fact that tpm2_do_selftest() will return
TPM2_RC_UPGRADE. In such a case, there is no point to finish the
start-up procedure as the TPM will not accept any commands, except
firmware upgrade related.

On the other hand, if the TPM is in Failure mode, it will successfully
respond to both tpm2_do_selftest() and tpm2_startup() calls. Although,
will fail to answer to tpm2_get_cc_attrs_tbl(). Use this fact to
conclude that TPM is in Failure mode.

If the chip is in the Upgrade or Failure mode, the function returns -EIO
error code.

The return value is checked in the tpm_chip_register() call to determine
the state of the TPM. If the TPM is not in normal operation mode, set
the `limited_mode` flag. If the flag is set then the TPM is not able to
provide any crypto functionality.  Correspondignly, the calls to
tpm2_get_cc_attrs_tbl(), tpm_add_hwrng() and tpm_get_pcr_allocation()
will fail. Use the flag to exclude them from the initialization
sequence.

Signed-off-by: Borys Movchan <borysmn@axis.com>
---

Notes:
    v2:
    * Commit message updated.
    
    v3:
    * Commit message reworked.
    
    v4:
    * Description of how tpm2_auto_startup() detects the mode added to
      commit message.

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

