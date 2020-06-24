Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF722096A3
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbgFXXBA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 19:01:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:28947 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbgFXXA7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 19:00:59 -0400
IronPort-SDR: +b9gquAbtwdaK5Uxeo/VykBfgZ7lMQWTpypFL4NIOW0G8eGrl1sSiiZyBRCFTSovoi+lMvoApZ
 iBOjG1t7Od6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124911233"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="124911233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 16:00:58 -0700
IronPort-SDR: G0hLA6N6Yk1nM47CgFNu/GWReiR2LY6URhVxZeEWSGe1pLRFzy0J5I/WsZ3bQqNiiNQTEfmMYV
 S5TpLuIwnAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="311804932"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2020 16:00:51 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm_tis: Remove the HID IFX0102
Date:   Thu, 25 Jun 2020 02:00:33 +0300
Message-Id: <20200624230037.21192-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Acer C720 running Linux v5.3 reports this in klog:

tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
tpm_tis tpm_tis: Could not get TPM timeouts and durations
tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
tpm_tis 00:08: Could not get TPM timeouts and durations
ima: No TPM chip found, activating TPM-bypass!
tpm_inf_pnp 00:08: Found TPM with ID IFX0102

% git --no-pager grep IFX0102 drivers/char/tpm
drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */

Obviously IFX0102 was added to the HID table for the TCG TIS driver by
mistake.

Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
Cc: Kylene Jo Hall <kjhall@us.ibm.com>
Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-space.c | 14 ++++++++++----
 drivers/char/tpm/tpm_tis.c    |  1 -
 include/linux/tpm.h           |  6 ++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..c9817930eb23 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -47,9 +47,13 @@ int tpm2_init_space(struct tpm_space *space)
 	space->session_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (space->session_buf == NULL) {
 		kfree(space->context_buf);
+		space->context_buf = NULL;
 		return -ENOMEM;
 	}
 
+	space->context_size = PAGE_SIZE;
+	space->session_size = PAGE_SIZE;
+
 	return 0;
 }
 
@@ -311,8 +315,10 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 	       sizeof(space->context_tbl));
 	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
 	       sizeof(space->session_tbl));
-	memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
-	memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);
+	memcpy(chip->work_space.context_buf, space->context_buf,
+	       space->context_size);
+	memcpy(chip->work_space.session_buf, space->session_buf,
+	       space->session_size);
 
 	rc = tpm2_load_space(chip);
 	if (rc) {
@@ -492,7 +498,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			continue;
 
 		rc = tpm2_save_context(chip, space->context_tbl[i],
-				       space->context_buf, PAGE_SIZE,
+				       space->context_buf, space->context_size,
 				       &offset);
 		if (rc == -ENOENT) {
 			space->context_tbl[i] = 0;
@@ -509,7 +515,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			continue;
 
 		rc = tpm2_save_context(chip, space->session_tbl[i],
-				       space->session_buf, PAGE_SIZE,
+				       space->session_buf, space->session_size,
 				       &offset);
 
 		if (rc == -ENOENT) {
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..c58ea10fc92f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -238,7 +238,6 @@ static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 static struct pnp_device_id tpm_pnp_tbl[] = {
 	{"PNP0C31", 0},		/* TPM */
 	{"ATM1200", 0},		/* Atmel */
-	{"IFX0102", 0},		/* Infineon */
 	{"BCM0101", 0},		/* Broadcom */
 	{"BCM0102", 0},		/* Broadcom */
 	{"NSC1200", 0},		/* National */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 03e9b184411b..9ea39e8f7162 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -92,10 +92,12 @@ enum tpm_duration {
 #define TPM_PPI_VERSION_LEN		3
 
 struct tpm_space {
+	u8  *context_buf;
+	u8  *session_buf;
+	u32 context_size;
+	u32 session_size;
 	u32 context_tbl[3];
-	u8 *context_buf;
 	u32 session_tbl[3];
-	u8 *session_buf;
 };
 
 struct tpm_bios_log {
-- 
2.25.1

