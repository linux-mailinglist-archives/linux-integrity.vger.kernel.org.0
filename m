Return-Path: <linux-integrity+bounces-4826-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE64A352CF
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 01:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA35188FF52
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AB8472;
	Fri, 14 Feb 2025 00:27:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975496FC5;
	Fri, 14 Feb 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492878; cv=none; b=GjbVzh2AjiQLkol2Sb4Bs+doQfNag5VFyDR3jbqxz0kSlp2KssY1KclfrGeGS/wcd2c8j2gJ22OVF4IwP6iuHXD0PICKY/rbjPbwIaJaAmVl9D6AM3OAnecgzkwA+/ESm3VfARsNijF5QmXatA0ksh1epzoDuuDuWxQn058ueD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492878; c=relaxed/simple;
	bh=OqYUk/Qg81szF76C0zKm3qqVF4r6kYELaEc6i/c3Qjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPXQKh2ejMS+tlv0aJ4RrL7ho5ao89lig3Y0peeHDc01coBdBHZwxogGdqDDWobsC37ljb9dUVohtsV47wO1cuZqpqwaPSSNas9kEERQz2PVKBHrXgQEL22nbaZF6ijgjZ1vsY3km3QtjbAPw6ImQhl2g+XCjIK4Vz+whT/jOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7241E26BE;
	Thu, 13 Feb 2025 16:28:16 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFF5A3F5A1;
	Thu, 13 Feb 2025 16:27:55 -0800 (PST)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] tpm_crb: add support for the Arm FF-A start method
Date: Thu, 13 Feb 2025 18:27:44 -0600
Message-Id: <20250214002745.878890-5-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214002745.878890-1-stuart.yoder@arm.com>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCG ACPI spec v1.4 defines a start method for the
TPMs implemented with the Arm CRB over FF-A ABI.

Add support for the FF-A start method, and use interfaces
provided by the ffa_crb driver to interact with the
FF-A based TPM.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb.c | 65 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index d696226906a2..486be5ea82bb 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_ARM64
 #include <linux/arm-smccc.h>
 #endif
+#include "tpm_crb_ffa.h"
 #include "tpm.h"
 
 #define ACPI_SIG_TPM2 "TPM2"
@@ -100,6 +101,8 @@ struct crb_priv {
 	u32 smc_func_id;
 	u32 __iomem *pluton_start_addr;
 	u32 __iomem *pluton_reply_addr;
+	u8 ffa_flags;
+	u8 ffa_attributes;
 };
 
 struct tpm2_crb_smc {
@@ -110,6 +113,14 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+/* CRB over FFA start method parameters in TCG2 ACPI table */
+struct tpm2_crb_ffa {
+	u8 flags;
+	u8 attributes;
+	u16 partition_id;
+	u8 reserved[8];
+};
+
 struct tpm2_crb_pluton {
 	u64 start_addr;
 	u64 reply_addr;
@@ -119,7 +130,8 @@ static inline bool tpm_crb_has_idle(u32 start_method)
 {
 	if ((start_method == ACPI_TPM2_START_METHOD) ||
 	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
-	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
+	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) ||
+	    (start_method == ACPI_TPM2_CRB_WITH_ARM_FFA))
 		return false;
 	else
 		return true;
@@ -261,6 +273,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
 static int __crb_request_locality(struct device *dev,
 				  struct crb_priv *priv, int loc)
 {
+	int rc;
 	u32 value = CRB_LOC_STATE_LOC_ASSIGNED |
 		    CRB_LOC_STATE_TPM_REG_VALID_STS;
 
@@ -268,6 +281,13 @@ static int __crb_request_locality(struct device *dev,
 		return 0;
 
 	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
+
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
+		if (rc)
+			return rc;
+	}
+
 	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
 				 TPM2_TIMEOUT_C)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
@@ -287,6 +307,7 @@ static int crb_request_locality(struct tpm_chip *chip, int loc)
 static int __crb_relinquish_locality(struct device *dev,
 				     struct crb_priv *priv, int loc)
 {
+	int rc;
 	u32 mask = CRB_LOC_STATE_LOC_ASSIGNED |
 		   CRB_LOC_STATE_TPM_REG_VALID_STS;
 	u32 value = CRB_LOC_STATE_TPM_REG_VALID_STS;
@@ -295,6 +316,13 @@ static int __crb_relinquish_locality(struct device *dev,
 		return 0;
 
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
+
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
+		if (rc)
+			return rc;
+	}
+
 	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
 				 TPM2_TIMEOUT_C)) {
 		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
@@ -443,6 +471,11 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
 
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+	}
+
 	if (rc)
 		return rc;
 
@@ -451,6 +484,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
 
 static void crb_cancel(struct tpm_chip *chip)
 {
+	int rc;
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 
 	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
@@ -459,6 +493,12 @@ static void crb_cancel(struct tpm_chip *chip)
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
 	     crb_do_acpi_start(chip))
 		dev_err(&chip->dev, "ACPI Start failed\n");
+
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+		if (rc)
+			dev_err(&chip->dev, "FF-A Start failed\n");
+	}
 }
 
 static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
@@ -616,6 +656,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 * stuff that puts the control area outside the ACPI IO region.
 	 */
 	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
+	    (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) ||
 	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
 		if (iores &&
 		    buf->control_address == iores->start +
@@ -737,6 +778,7 @@ static int crb_acpi_add(struct acpi_device *device)
 	struct tpm_chip *chip;
 	struct device *dev = &device->dev;
 	struct tpm2_crb_smc *crb_smc;
+	struct tpm2_crb_ffa *crb_ffa;
 	struct tpm2_crb_pluton *crb_pluton;
 	acpi_status status;
 	u32 sm;
@@ -775,6 +817,27 @@ static int crb_acpi_add(struct acpi_device *device)
 		priv->smc_func_id = crb_smc->smc_func_id;
 	}
 
+	if (sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_ffa))) {
+			dev_err(dev,
+				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
+				buf->header.length,
+				ACPI_TPM2_CRB_WITH_ARM_FFA);
+			rc = -EINVAL;
+			goto out;
+		}
+		crb_ffa = ACPI_ADD_PTR(struct tpm2_crb_ffa, buf, sizeof(*buf));
+		priv->ffa_flags = crb_ffa->flags;
+		priv->ffa_attributes = crb_ffa->attributes;
+		rc = tpm_crb_ffa_init();
+		if (rc) {
+			if (rc == -ENOENT) {  // FF-A driver is not available yet
+				rc = -EPROBE_DEFER;
+			}
+			goto out;
+		}
+	}
+
 	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_pluton))) {
 			dev_err(dev,
-- 
2.34.1


