Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F441DE51
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbhI3QEk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 12:04:40 -0400
Received: from smtp2.axis.com ([195.60.68.18]:15716 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347439AbhI3QEk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 12:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633017777;
  x=1664553777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QXhC5KFMX8tQBn1qtEN1Tt+Sn3XS99KDnjTP/m8fU+o=;
  b=BQSurFJ6yHMZizvv7sqxo/TgtVgRnuvr6UAvVej1RFysxdtQzG7Mdf9N
   VF+WjEITkmfRBAtIpbM6NJEoOOwlW2/hn4yr2sGeGf3IYBYzkC3CRjl6i
   z/EYr6r+v0waBQa3gvfuwpuOiTw+AFwdbRPfyOFTGH4ZEbIzHqBN5/58B
   mQdF4wKANKSzHPI1aAV82Y5jEmSsnniitsbNwipKpo7Xl7GEK/nCZDEWF
   9bLEmTP93SCrdPt0EHo88CvYxEOnw7evy92b+yNohbinuAnt5vUVQ/9L/
   sf1cr85g34T+n8rcHOF6WM0df1PzMUuZyocBy4v65Lhouv40nPBv/wFzJ
   A==;
From:   Borys Movchan <borysmn@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <kernel@axis.com>, Borys Movchan <borysmn@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Date:   Thu, 30 Sep 2021 18:02:40 +0200
Message-ID: <20210930160241.9691-1-borysmn@axis.com>
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
running mode of the TPM by adding the following checks.  If
tpm2_do_selftest() call returns TPM2_RC_UPGRADE, the TPM is in Upgrade
mode.
If the TPM is in Failure mode, it will successfully respond to both
tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM is
in Failure mode.

If detected that the TPM is in the Upgrade or Failure mode, the function
sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag.

The limited mode flag is used later during driver
initialization/deinitialization to disable functionality which makes no
sense or will fail in the current TPM state. Following functionality is
affected:
 * do not register TPM as a hwrng
 * do not register sysfs entries which provide information impossible to
   obtain in limited mode
 * do not register resource managed character device

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
    
    v5:
     * Introduce global flag: TPM_CHIP_FLAG_LIMITED_MODE.
     * Add checks for the flag in places that will not work properly when TPM
       functionality is limited.
     * Avoid registering sysfs and character device entries that have no useful
       function in limited mode.
     * Do not register TPM as a hwrng.
     * Do not try to obtain any crypto-related properties from TPM as it will fail
       in limited mode.
    
    v6:
     * Rename the TPM_CHIP_FLAG_LIMITED_MODE to TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE
       to reduce confusion. Update info messages.

 drivers/char/tpm/tpm-chip.c  | 23 ++++++++++++++++-------
 drivers/char/tpm/tpm-sysfs.c |  3 +++
 drivers/char/tpm/tpm2-cmd.c  | 14 +++++++++++++-
 include/linux/tpm.h          |  2 ++
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..3378bfe06006 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -444,7 +444,8 @@ static int tpm_add_char_device(struct tpm_chip *chip)
 		return rc;
 	}
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
+	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)) {
 		rc = cdev_device_add(&chip->cdevs, &chip->devs);
 		if (rc) {
 			dev_err(&chip->devs,
@@ -488,7 +489,8 @@ static void tpm_del_legacy_sysfs(struct tpm_chip *chip)
 {
 	struct attribute **i;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
+	    chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
 		return;
 
 	sysfs_remove_link(&chip->dev.parent->kobj, "ppi");
@@ -506,7 +508,8 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	struct attribute **i;
 	int rc;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
+		chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
 		return 0;
 
 	rc = compat_only_sysfs_link_entry_to_kobj(
@@ -536,7 +539,8 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
-	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) ||
+	    chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -550,6 +554,9 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 {
 	int rc;
 
+	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
+		return 0;
+
 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
 	     tpm2_get_pcr_allocation(chip) :
 	     tpm1_get_pcr_allocation(chip);
@@ -612,7 +619,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -637,10 +644,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) &&
+	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
+	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE))
 		cdev_device_del(&chip->cdevs, &chip->devs);
 	tpm_del_char_device(chip);
 }
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 63f03cfb8e6a..2842f3c667a5 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -480,6 +480,9 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
 
 	WARN_ON(chip->groups_cnt != 0);
 
+	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
+		return;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 	else
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a25815a6f625..76245c861e59 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -729,7 +729,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc && rc != TPM2_RC_INITIALIZE)
+	if (rc == TPM2_RC_UPGRADE) {
+		dev_info(&chip->dev, "TPM requires firmware upgrade\n");
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
+		rc = 0;
+		goto out;
+	} else if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
@@ -743,6 +748,13 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	if (rc) {
+		dev_info(&chip->dev,
+			 "TPM requires firmware recovery/upgrade\n");
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
+		rc = 0;
+		goto out;
+	}
 
 out:
 	if (rc > 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..498f487d786f 100644
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
@@ -277,6 +278,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
+	TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE	= BIT(7),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.20.1

