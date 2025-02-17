Return-Path: <linux-integrity+bounces-4855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA037A38F3D
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 23:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C98216C21F
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4491ACEDE;
	Mon, 17 Feb 2025 22:50:00 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A71A9B3B;
	Mon, 17 Feb 2025 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832600; cv=none; b=t4sscGPbPfzrge+d8CjFuumCsy2lWsTJ7/XSuJ0xJhi8bmPqeSqVqt/DwGKaAbqIbvJjM2WGc2yHE4pGVPSNI9wzRFvK8msoeIVyVJW9PNG7I3B0tN7X4sfaz54lH4nanqEH7A3vI54g2KAW8Y5eywTAAgJlqgbERZVj2gm5kGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832600; c=relaxed/simple;
	bh=SvYIUsvI5FBjGU4eAJImdjcnKIvJmowA4jxSaBrpb2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdYbGoHm98439/9rwO2yg1MA+hGSSTFalJLXwxm1lreF7+gIylr57J0yhtEVlT586h/sbw8Zzvzu7BdM+wbC0aZc7uhBbWNMr6BUjbqbuJqc8RNSLjNij22pRC8w6edJUtXHDTz4pDq6dIZbaElMU8n0ztosi9fau+Kg/UT4Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005BE1EDB;
	Mon, 17 Feb 2025 14:50:17 -0800 (PST)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 989183F5A1;
	Mon, 17 Feb 2025 14:49:57 -0800 (PST)
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
Subject: [PATCH v4 3/5] ACPICA: add start method for Arm FF-A
Date: Mon, 17 Feb 2025 16:49:44 -0600
Message-Id: <20250217224946.113951-4-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217224946.113951-1-stuart.yoder@arm.com>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
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


