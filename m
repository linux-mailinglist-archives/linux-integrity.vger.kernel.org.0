Return-Path: <linux-integrity+bounces-7522-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB4C07908
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8E13B2ABC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741D31B807;
	Fri, 24 Oct 2025 17:42:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA12D6401;
	Fri, 24 Oct 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327733; cv=none; b=Uv0L9jp5WcUYq8ppSkTN8tqRXOUMu5AEGDlG/8CR6qBQ88DojNnaTpFa7GV86YLFzdy1ZxmD6YioJZG4rjbhNXmCrHyuaTWpfwJoZjmDPdhbWoOl41+GllU9kgsTo4D4fDIdnjZiQkFeKVdgsgyrYdnfd2hyXzfkq+kKYnFxH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327733; c=relaxed/simple;
	bh=tObqE6de3gXg94CWYyQkTpkbhYWwtJDUVxRZXBU+ZM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGrV1tVn8clEEf8rC8LgQy4ZPqaha38Fp/doU5iuTTKTtLus4r1DBNibCKKs82xt8NOue8jZvSrnRciVeK0EEoXsQMXwJRnbtqyAAsRlMt2wD0ealpP6JzkFdL2nK9NOg+1iRqhxphPtOM6u4glMDNU2pPLOY1ixi5xU1vfx0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ECA9175A;
	Fri, 24 Oct 2025 10:42:01 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DD0A3F63F;
	Fri, 24 Oct 2025 10:42:09 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm_crb: Add idle support for the Arm FF-A start method
Date: Fri, 24 Oct 2025 12:42:00 -0500
Message-Id: <20251024174200.1974090-1-stuart.yoder@arm.com>
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
-v2: add kernel doc inf for new loc parameter in __crb_go_idle
     and __crb_cmd_ready

 drivers/char/tpm/tpm_crb.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 876edf2705ab..6b89bd183a3a 100644
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
@@ -180,6 +179,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
  *
  * @dev:  crb device
  * @priv: crb private data
+ * @loc:  locality
  *
  * Write CRB_CTRL_REQ_GO_IDLE to TPM_CRB_CTRL_REQ
  * The device should respond within TIMEOUT_C by clearing the bit.
@@ -191,7 +191,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
  *
  * Return: 0 always
  */
-static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
@@ -200,6 +200,12 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 
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
@@ -220,7 +226,7 @@ static int crb_go_idle(struct tpm_chip *chip)
 	struct device *dev = &chip->dev;
 	struct crb_priv *priv = dev_get_drvdata(dev);
 
-	return __crb_go_idle(dev, priv);
+	return __crb_go_idle(dev, priv, chip->locality);
 }
 
 /**
@@ -228,6 +234,7 @@ static int crb_go_idle(struct tpm_chip *chip)
  *
  * @dev:  crb device
  * @priv: crb private data
+ * @loc:  locality
  *
  * Write CRB_CTRL_REQ_CMD_READY to TPM_CRB_CTRL_REQ
  * and poll till the device acknowledge it by clearing the bit.
@@ -238,7 +245,7 @@ static int crb_go_idle(struct tpm_chip *chip)
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
+static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
@@ -247,6 +254,12 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 
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
@@ -267,7 +280,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
 	struct device *dev = &chip->dev;
 	struct crb_priv *priv = dev_get_drvdata(dev);
 
-	return __crb_cmd_ready(dev, priv);
+	return __crb_cmd_ready(dev, priv, chip->locality);
 }
 
 static int __crb_request_locality(struct device *dev,
@@ -444,7 +457,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
 
 	/* Seems to be necessary for every command */
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
-		__crb_cmd_ready(&chip->dev, priv);
+		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
 	memcpy_toio(priv->cmd, buf, len);
 
@@ -672,7 +685,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 * PTT HW bug w/a: wake up the device to access
 	 * possibly not retained registers.
 	 */
-	ret = __crb_cmd_ready(dev, priv);
+	ret = __crb_cmd_ready(dev, priv, 0);
 	if (ret)
 		goto out_relinquish_locality;
 
@@ -744,7 +757,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	if (!ret)
 		priv->cmd_size = cmd_size;
 
-	__crb_go_idle(dev, priv);
+	__crb_go_idle(dev, priv, 0);
 
 out_relinquish_locality:
 
-- 
2.34.1


