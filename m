Return-Path: <linux-integrity+bounces-5122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40604A50673
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 18:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F3C17219A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D8250C06;
	Wed,  5 Mar 2025 17:36:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB61957E4;
	Wed,  5 Mar 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196183; cv=none; b=Zrm1eGk2exvKYb+/S4fzhQLO9IU5FHDv72tUltlK6j4ukol2uZHVxJlTWYELxlfRbGCYXQQzQ3dasR2veL/s46ToaOyJHorXG9d8L6e79+qg2oo+rIyAnmVsgv/xn8J4uqjpvDoYChAmUl9p7Yf1ChqoC2VKpLdFGOAWcv5wHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196183; c=relaxed/simple;
	bh=B7DiRQvXT5D+JOioD/pxfSeyiGbHzo9IR3jcSEirGaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUJfwYiUK6+hYimyEpgIteMl+52LS1+SS5vqWJvVQMNa0M56hOoLnUFkL5MqWqzZPjSNjp7u2QKt39V2GkfYyyUhyf6um6Xg9kG2MzwJQaF/0rBcmCUILuBzBSVEBycXsUJKiBH/X7YExi0qDtEn6wM3lKwEvCj2bH5iZh2iTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB3E1FC7;
	Wed,  5 Mar 2025 09:36:34 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A442D3F792;
	Wed,  5 Mar 2025 09:36:20 -0800 (PST)
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
Subject: [PATCH v6 2/5] tpm_crb: clean-up and refactor check for idle support
Date: Wed,  5 Mar 2025 11:36:08 -0600
Message-Id: <20250305173611.74548-3-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305173611.74548-1-stuart.yoder@arm.com>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor TPM idle check to tpm_crb_has_idle(), and reduce paraentheses
usage in start method checks

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ea085b14ab7c..c6898710a66b 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
 	u64 reply_addr;
 };
 
+/*
+ * Returns true if the start method supports idle.
+ */
+static inline bool tpm_crb_has_idle(u32 start_method)
+{
+	return !(start_method == ACPI_TPM2_START_METHOD ||
+	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
+	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
+}
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -173,9 +183,7 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
 	int rc;
 
-	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
+	if (!tpm_crb_has_idle(priv->sm))
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
@@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	int rc;
 
-	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
+	if (!tpm_crb_has_idle(priv->sm))
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
@@ -423,13 +429,13 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	 * report only ACPI start but in practice seems to require both
 	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
 	 */
-	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
-	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED) ||
-	    (!strcmp(priv->hid, "MSFT0101")))
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	    !strcmp(priv->hid, "MSFT0101"))
 		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
 
-	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD))
+	if (priv->sm == ACPI_TPM2_START_METHOD ||
+	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		rc = crb_do_acpi_start(chip);
 
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
@@ -449,8 +455,8 @@ static void crb_cancel(struct tpm_chip *chip)
 
 	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
 
-	if (((priv->sm == ACPI_TPM2_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
+	if ((priv->sm == ACPI_TPM2_START_METHOD ||
+	     priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
 	     crb_do_acpi_start(chip))
 		dev_err(&chip->dev, "ACPI Start failed\n");
 }
@@ -609,8 +615,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 * the control area, as one nice sane region except for some older
 	 * stuff that puts the control area outside the ACPI IO region.
 	 */
-	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
-	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED) {
 		if (iores &&
 		    buf->control_address == iores->start +
 		    sizeof(*priv->regs_h))
-- 
2.34.1


