Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE187472159
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 08:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhLMHJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 02:09:30 -0500
Received: from smtp2.axis.com ([195.60.68.18]:9630 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhLMHJ3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 02:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639379369;
  x=1670915369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pt6ek1djk0qiA73rQZEuZUrS1j54pL/Z3+RRRliLcjg=;
  b=agRxL4yP/Ro7Hh7i/eisFtgnk04gMeXB6ProQimZeK/CellKEB2xfZoF
   Sd7ZOvi/qJr65ZUUMeVBk9RSJQ9AbEwCcbIqo6Wxf5eGsRrSIg5bxKUJQ
   VYAPbMXWSKADEBEpCYP9Ny2p6O8cVdMnwyuXe02sjOrV7u8VOB9v1aXac
   ZVXkifh/i/p9SfVnpUlYEzXZvLq99fUbzTbj9jOPD+EdYvPNQn+DI/T2U
   DSgAU39hsQOiqiQtH5/JsoPEogdsdxmyUoVnAhnrVAzYUb4nhClQ4Tf0W
   Zk3sMtQm3GcdTlt848ryfonuXpgdDWEkcGGi8wfkKqigON4x9rqHD059v
   w==;
From:   Axel Jonsson <axelj@axis.com>
To:     <jarkko@kernel.org>
CC:     <axel.jonsson@axis.com>, <axelj@axis.com>, <borysmn@axis.com>,
        <jgg@ziepe.ca>, <kernel@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterhuewe@gmx.de>, <sergio.ruiz@axis.com>
Subject: [PATCH v8] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Date:   Mon, 13 Dec 2021 08:09:25 +0100
Message-ID: <20211213070925.3831-1-axelj@axis.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <5e5cbdd7db3d8f469f94607b823b8fd46e014051.camel@kernel.org>
References: <5e5cbdd7db3d8f469f94607b823b8fd46e014051.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: axelj <axelj@axis.com>

If something went wrong during the TPM firmware upgrade, like power
failure or the firmware image file get corrupted, the TPM might end
up in Upgrade or Failure mode upon the next start. The state is
persistent between the TPM power cycle/restart.

According to TPM specification:
 * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
   to all commands except TPM2_FieldUpgradeData(). It may also accept
   other commands if it is able to complete them using the previously
   installed firmware.
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

The TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag is used later during driver
initialization/deinitialization to disable functionality which makes no
sense or will fail in the current TPM state. Following functionality is
affected:
 * Do not register TPM as a hwrng
 * Do not register sysfs entries which provide information impossible to
   obtain in limited mode
 * Do not register resource managed character device

Signed-off-by: axelj <axelj@axis.com>
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
    
    v7:
     * Clarified in commit message which command can be run in firmware upgrade
     mode
     * Corrected info and style in commit message
     * Renamed TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE to TPM_CHIP_FLAG_FIRMWARE_MODE
     * Replaced TPM_CHIP_FLAG_FIRMWARE_MODE flag check with function from
     include/linux/tpm.h
    
    v8:
     * Fixed line formating.
     * Renamed TPM_CHIP_FLAG_FIRMWARE_MODE to TPM_CHIP_FLAG_FIRMWARE_UPGRADE.

 drivers/char/tpm/tpm-chip.c  | 19 ++++++++++++-------
 drivers/char/tpm/tpm-sysfs.c |  3 +++
 drivers/char/tpm/tpm2-cmd.c  |  6 ++++++
 include/linux/tpm.h          | 10 ++++++++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..b4ed3ae67a4b 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -444,7 +444,7 @@ static int tpm_add_char_device(struct tpm_chip *chip)
 		return rc;
 	}
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip)) {
 		rc = cdev_device_add(&chip->cdevs, &chip->devs);
 		if (rc) {
 			dev_err(&chip->devs,
@@ -488,7 +488,8 @@ static void tpm_del_legacy_sysfs(struct tpm_chip *chip)
 {
 	struct attribute **i;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
+	    tpm_is_firmware_upgrade(chip))
 		return;
 
 	sysfs_remove_link(&chip->dev.parent->kobj, "ppi");
@@ -506,7 +507,8 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	struct attribute **i;
 	int rc;
 
-	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
+	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
+		tpm_is_firmware_upgrade(chip))
 		return 0;
 
 	rc = compat_only_sysfs_link_entry_to_kobj(
@@ -536,7 +538,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
-	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip))
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -550,6 +552,9 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 {
 	int rc;
 
+	if (tpm_is_firmware_upgrade(chip))
+		return 0;
+
 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
 	     tpm2_get_pcr_allocation(chip) :
 	     tpm1_get_pcr_allocation(chip);
@@ -612,7 +617,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -637,10 +642,10 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
 		cdev_device_del(&chip->cdevs, &chip->devs);
 	tpm_del_char_device(chip);
 }
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 63f03cfb8e6a..54c71473aa29 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -480,6 +480,9 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
 
 	WARN_ON(chip->groups_cnt != 0);
 
+	if (tpm_is_firmware_upgrade(chip))
+		return;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 	else
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a25815a6f625..4704fa553098 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -745,6 +745,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
 out:
+	if (rc == TPM2_RC_UPGRADE) {
+		dev_info(&chip->dev, "TPM in field upgrade mode, requires firmware upgrade\n");
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		rc = 0;
+	}
+
 	if (rc > 0)
 		rc = -ENODEV;
 	return rc;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 12d827734686..dfeb25a0362d 100644
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
@@ -278,6 +279,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
+	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -399,6 +401,14 @@ static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *) &value2, 4);
 }
 
+/*
+ * Check if TPM device is in the firmware upgrade mode.
+ */
+static inline bool tpm_is_firmware_upgrade(struct tpm_chip *chip)
+{
+	return chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+}
+
 static inline u32 tpm2_rc_value(u32 rc)
 {
 	return (rc & BIT(7)) ? rc & 0xff : rc;
-- 
2.11.0

