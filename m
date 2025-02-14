Return-Path: <linux-integrity+bounces-4827-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43ACA352D9
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 01:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C38516BAB7
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3731FC08;
	Fri, 14 Feb 2025 00:27:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533ED53BE;
	Fri, 14 Feb 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492878; cv=none; b=D8dgTlkzT5dvD5jlVSAEYAxWlm3zOFFg14nAQI7m/08F5Lp5QJUNDvmmSZTQsYjpJSvSpka+rwljU75/i5OLasQnbxj/7BF70qf8EixhPk0frJCm7OTrMKOXNMnFx6+zf/53H+S9Mq8hSNNXJVml7+Fe9Pu1UjcX7s1yEeQhoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492878; c=relaxed/simple;
	bh=erurvnKCndlcZUUX0TdrNA0ewd1gfKnrKe9z/7uPwPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bklr+JqnqOLjKgwHqEuUZcs5wBI5sEIfI1viDcFno9Yv4t2QmCTnCNJ/RRrz0KkxzazuF5p2AT5uD1emrX04BUnQJzIzLl3I45AwWbuEGOjrlGpjBCXzV7VBHU4FsCvrQi78E47Cem5Tu+X+mWPsZXDIj2XtCqoihjL+2vt9Gik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 427151AED;
	Thu, 13 Feb 2025 16:28:16 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B089C3F5A1;
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
Subject: [PATCH v3 2/5] tpm_crb: refactor check for idle support into TPM into inline function
Date: Thu, 13 Feb 2025 18:27:42 -0600
Message-Id: <20250214002745.878890-3-stuart.yoder@arm.com>
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

Refactor the two checks for whether the TPM supports idle into a single
inline function.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ea085b14ab7c..d696226906a2 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
 	u64 reply_addr;
 };
 
+static inline bool tpm_crb_has_idle(u32 start_method)
+{
+	if ((start_method == ACPI_TPM2_START_METHOD) ||
+	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
+	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
+		return false;
+	else
+		return true;
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
-- 
2.34.1


