Return-Path: <linux-integrity+bounces-5254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF5A5E6CC
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 22:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19A17A9536
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE531EFF8D;
	Wed, 12 Mar 2025 21:58:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57D1E5714;
	Wed, 12 Mar 2025 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816719; cv=none; b=U4lKiNKTMfZOzNmmAAhiJNhvhA7mUZ95BlBYVU/tWJ1/qguEkW0S+Gm8Bsy2lH2jGskI0miEWGSZTGSfZDoJvgK7ZjFlgEPt/pCwaUMDmk57XRzNeCuCO8KFqTs9xYzcRE+HjIsD+HNGC497yappVAUVSXnBJ4HNv1M2B/Vvd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816719; c=relaxed/simple;
	bh=4cc+M6JKzI/LD+tbvHh7v3sbfLjn/hkgZQfZgQNBBQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZNk9FzgYZI+7WmE2EMlex10klpeRFuIelT0Dgm7AO1wzN02a9DDTqHJMFTvg9aA15vz+TFu7FviJnKHlmoJB554r5q36f7/oPl8+rL4eHE3HS+vDCHTWOdt8MoNi54jLADtVqsLhKIW6JG1pQZ9AYia4uGJWG+/sCqkphD+Jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D721F1E8D;
	Wed, 12 Mar 2025 14:58:47 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 182783F5A1;
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
Subject: [PATCH v8 3/5] ACPICA: add start method for Arm FF-A
Date: Wed, 12 Mar 2025 16:58:26 -0500
Message-Id: <20250312215828.664402-4-stuart.yoder@arm.com>
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

Add TPM start method for Arm FF-A defined in the TCG ACPI
specification v1.4.

Link: https://github.com/acpica/acpica/pull/1000
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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


