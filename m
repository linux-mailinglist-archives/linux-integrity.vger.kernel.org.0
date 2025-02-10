Return-Path: <linux-integrity+bounces-4774-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C1A2FE53
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 00:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BE01886B5E
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE94261384;
	Mon, 10 Feb 2025 23:22:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3207264607;
	Mon, 10 Feb 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229762; cv=none; b=LrfpVK8DaIcgqIJ7VHbWcQrR2r4cjjQ10G1xeiRbqSqadubJRlVz6MikE/xSNhCURO3U8rMJtUBQLVyoSpKTIUN2Ksg+UtMUCjDIiyc74NRHle5NolhDL5JBZ4MwrSF6O6/SVDXlFNJq8coWw56NHyncTbgzdMZkB/nkO4ILlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229762; c=relaxed/simple;
	bh=7fRdcNE7xXsaASuPRp2rHOGLwkB9bid5/zMvjIkOD9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDhKB+NusR2cIyKfNeXmQlvdLAhhnqxvZ9y6OZN6JuMMBo8d6SS3qcwn99mcRNNq2zyzGmFUqpX/NT4xQ2nx4OZmgnq0heKHsG4WoUmHxuWH8G6s379Wy5uL5rlYPwHAaT6+zcI4fClTsNnkoY4knM2oL2HfJGqYAT2vINmmOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D12142381;
	Mon, 10 Feb 2025 15:23:01 -0800 (PST)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD90D3F6A8;
	Mon, 10 Feb 2025 15:22:39 -0800 (PST)
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
Subject: [PATCH 3/4] ACPICA: add start method for Arm FF-A
Date: Mon, 10 Feb 2025 17:22:26 -0600
Message-Id: <20250210232227.97761-4-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210232227.97761-1-stuart.yoder@arm.com>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TPM start method for Arm FF-A defined in the TCG ACPI
specification v1.4.

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


