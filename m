Return-Path: <linux-integrity+bounces-6909-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DFB34D2C
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 23:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5EB203E54
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8029B20A;
	Mon, 25 Aug 2025 20:59:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142E29AAFA;
	Mon, 25 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155598; cv=none; b=lWrSv7KStktQhsJiXgQ84uWOlVHkoyFZj5y+4HYivF7j84Wr4Sw6j/SE7tuVYbld+W80659rnujL1vsx8/rRQdVjNoggSQFREiERMzuCPyPJz/0n9+UwG6oXKa6HPm3gf1811G63QvBwhVz9dwMPf26+hoeifn8KERhVzvxuQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155598; c=relaxed/simple;
	bh=8rnIOqfs8LS68mVn1JICAyY+ZlmXShsrkgyAAXOYJ/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOytchcm/W9MMnKZm42cxlinX6cp133TqidJGehmtV7g5jduNlWF6p61RN31bcgadV9KNpQBKrnaejq1CkjH3+pJbVLm5sN37L2yM5p2C43JdWohUg/yKOB9dbZrAmSKCr0g4KUt9wLRCFjRF8heSwssh4kRbCHqd1uhUmFWN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B081E32;
	Mon, 25 Aug 2025 13:59:45 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 544F13F63F;
	Mon, 25 Aug 2025 13:59:53 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_crb: Add idle support for the Arm FF-A start method
Date: Mon, 25 Aug 2025 15:59:43 -0500
Message-Id: <20250825205943.1225599-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the CRB over FF-A specification [1], a TPM that implements
the ABI must comply with the TCG PTP specification. This requires support
for the Idle and Ready states.

This patch implements CRB control area requests for goIdle and
cmdReady on FF-A based TPMs.

The FF-A message used to notify the TPM of CRB updates includes a
locality parameter, which provides a hint to the TPM about which
locality modified the CRB.  This patch adds a locality parameter
to __crb_go_idle() and __crb_cmd_ready() to support this.

[1] https://developer.arm.com/documentation/den0138/latest/

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 876edf2705abb..a18bae0a53717 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -133,8 +133,7 @@ static inline bool tpm_crb_has_idle(u32 start_method)
 {
 	return !(start_method == ACPI_TPM2_START_METHOD ||
 	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
-	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC ||
-	       start_method == ACPI_TPM2_CRB_WITH_ARM_FFA);
+	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
 }
 
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
@@ -191,7 +190,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
  *
  * Return: 0 always
  */
-static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
@@ -200,6 +199,12 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
 
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
+		if (rc)
+			return rc;
+	}
+
 	rc = crb_try_pluton_doorbell(priv, true);
 	if (rc)
 		return rc;
@@ -220,7 +225,7 @@ static int crb_go_idle(struct tpm_chip *chip)
 	struct device *dev = &chip->dev;
 	struct crb_priv *priv = dev_get_drvdata(dev);
 
-	return __crb_go_idle(dev, priv);
+	return __crb_go_idle(dev, priv, chip->locality);
 }
 
 /**
@@ -238,7 +243,7 @@ static int crb_go_idle(struct tpm_chip *chip)
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
+static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
@@ -247,6 +252,12 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
 
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
+		if (rc)
+			return rc;
+	}
+
 	rc = crb_try_pluton_doorbell(priv, true);
 	if (rc)
 		return rc;
@@ -267,7 +278,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
 	struct device *dev = &chip->dev;
 	struct crb_priv *priv = dev_get_drvdata(dev);
 
-	return __crb_cmd_ready(dev, priv);
+	return __crb_cmd_ready(dev, priv, chip->locality);
 }
 
 static int __crb_request_locality(struct device *dev,
@@ -444,7 +455,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
 
 	/* Seems to be necessary for every command */
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
-		__crb_cmd_ready(&chip->dev, priv);
+		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
 	memcpy_toio(priv->cmd, buf, len);
 
@@ -672,7 +683,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 * PTT HW bug w/a: wake up the device to access
 	 * possibly not retained registers.
 	 */
-	ret = __crb_cmd_ready(dev, priv);
+	ret = __crb_cmd_ready(dev, priv, 0);
 	if (ret)
 		goto out_relinquish_locality;
 
@@ -744,7 +755,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	if (!ret)
 		priv->cmd_size = cmd_size;
 
-	__crb_go_idle(dev, priv);
+	__crb_go_idle(dev, priv, 0);
 
 out_relinquish_locality:
 
-- 
2.34.1


