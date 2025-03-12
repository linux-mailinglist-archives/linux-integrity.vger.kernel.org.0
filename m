Return-Path: <linux-integrity+bounces-5258-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06700A5E6DA
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 22:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15011890219
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 21:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837BF1F12F9;
	Wed, 12 Mar 2025 21:58:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A21EE7BE;
	Wed, 12 Mar 2025 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816721; cv=none; b=SqMJ7Lh4WXGbQscK5anZKoD4bwLoYT7LOKjQYqikULkQfoP3bmjLhDJ52XXT/fgLNleTudlsGI35KM+i/xnS9lMQqcBRHbS3WDlnn2LCtQk7N6qtUirVNEovpSKsaqv57+1lnoaTOH1T4ijgo6PoSpN/NaYHE9FfSj28dEipUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816721; c=relaxed/simple;
	bh=B7DiRQvXT5D+JOioD/pxfSeyiGbHzo9IR3jcSEirGaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty6Y/7p8djzTxwZ6wrwAjnnMheE3MzXOSlnx1D9DxvipEihUM/idM39r+uIegpX+RhyHyQjolRnfGaS727QsAuYKCTmUn2hormCI4RmvcActzAlbeVNeYVNzpujKle5ATsaTGCc1AS777vtRqv/+n4+Yz1XygmZP+6pbB4w64c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC07F1E5E;
	Wed, 12 Mar 2025 14:58:47 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05D623F86F;
	Wed, 12 Mar 2025 14:58:37 -0700 (PDT)
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
Subject: [PATCH v8 2/5] tpm_crb: clean-up and refactor check for idle support
Date: Wed, 12 Mar 2025 16:58:25 -0500
Message-Id: <20250312215828.664402-3-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312215828.664402-1-stuart.yoder@arm.com>
References: <20250312215828.664402-1-stuart.yoder@arm.com>
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


