Return-Path: <linux-integrity+bounces-4803-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB19A33200
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F250188AE15
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E520408D;
	Wed, 12 Feb 2025 22:06:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3812036ED;
	Wed, 12 Feb 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397961; cv=none; b=WsCv5ZWatlrmxA3ZWMWqePOYP57fnAKbxtjnMYwGP7ybO8tklg78tjES495ewygq38Yxuv9JdOjSH74BnSHSgIYs0TEotGRkjH/D77m/kBDsZIRO4wNpD3Fpf26/IjXvw7oirGjzdPHPkxyt1G9N2q5TeA89zFVTshaJNe4cc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397961; c=relaxed/simple;
	bh=ZGhydeZxTvcnRna3S1bP4MtIhyq1lqgmB9PIFRWKoUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAzaVUL86oFPf3dyKKYP2KVJP2cDkUiNEJgduHYVaoznnVHCpY+YsEC4lBN5Y/qH0uH2EDpw7L8LcuiWa8e1foob2EhhzzdofIWecfmdfe6SULCFFRYFrQDzWF/PHJ6nWQ/qIuTSj1LaPkOaX9uZQuydRlFBcCkWJcNFkUx5g6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC0961EDB;
	Wed, 12 Feb 2025 14:06:19 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7E983F58B;
	Wed, 12 Feb 2025 14:05:58 -0800 (PST)
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
Subject: [PATCH v2 2/5] tpm_crb: refactor check for idle support into TPM into inline function
Date: Wed, 12 Feb 2025 16:05:45 -0600
Message-Id: <20250212220548.400447-3-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212220548.400447-1-stuart.yoder@arm.com>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
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
index ea085b14ab7c..87d69e990249 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
 	u64 reply_addr;
 };
 
+static inline bool does_tpm_support_idle(u32 start_method)
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
+	if (!does_tpm_support_idle(priv->sm))
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
@@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	int rc;
 
-	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
-	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
+	if (!does_tpm_support_idle(priv->sm))
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
-- 
2.34.1


