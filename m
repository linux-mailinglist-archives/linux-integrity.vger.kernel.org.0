Return-Path: <linux-integrity+bounces-4807-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F6A3320D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 23:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D7D188AEAC
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AA261566;
	Wed, 12 Feb 2025 22:06:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2471204081;
	Wed, 12 Feb 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397962; cv=none; b=PTl3438dKhjRCzFqY6nWCXFxwmjDYb9CqpQuJmb+o77QAwFXC1Vxed6yF0H4GqhYZlV5yRQsDgwaKNmNWUBx4solzWyhKw3ktrCajpx+ZExfmmL8bq5o3hM8gtX3pxQmNTIyfmmhgQbp1tGvkBCbdDXCtpNfQD/YQownc/0+B28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397962; c=relaxed/simple;
	bh=SvYIUsvI5FBjGU4eAJImdjcnKIvJmowA4jxSaBrpb2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Plo1mpmMdc/AkwSSfxP/KztU+r4FO02P9LZYEcY+OBph30iFtJyHGAuOIEqmLTHvDVDXNDb0/LucaREdmjJTh0KAt3HoAsIUQzP41sZJSfwSctxlcNtq8ub5jiQqe/VWj6GZxHcxJ3kku2LV6rQzoBGgoSbYr4Z+TxVmI8TGhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E800C1F02;
	Wed, 12 Feb 2025 14:06:19 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAACD3F792;
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
Subject: [PATCH v2 3/5] ACPICA: add start method for Arm FF-A
Date: Wed, 12 Feb 2025 16:05:46 -0600
Message-Id: <20250212220548.400447-4-stuart.yoder@arm.com>
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

Add TPM start method for Arm FF-A defined in the TCG ACPI
specification v1.4.

Link: https://github.com/acpica/acpica/pull/1000
Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 include/acpi/actbl3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 5cd755143b7d..a97b1dbab975 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -466,6 +466,7 @@ struct acpi_tpm2_phy {
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC       11	/* V1.2 Rev 8 */
 #define ACPI_TPM2_RESERVED                          12
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON        13
+#define ACPI_TPM2_CRB_WITH_ARM_FFA                  15
 
 /* Optional trailer appears after any start_method subtables */
 
-- 
2.34.1


