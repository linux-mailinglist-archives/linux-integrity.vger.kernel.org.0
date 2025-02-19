Return-Path: <linux-integrity+bounces-4914-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80151A3C953
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED64177185
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893522E402;
	Wed, 19 Feb 2025 20:10:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92E22B5A5;
	Wed, 19 Feb 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995828; cv=none; b=Z3rLUm2PnLb1jhxkPMn8/M8+P7x68fWLyc9i1S+gucxDdVKEmQbSW9dSy3fOq8Av1M/Vjkxs2Rq4N2L0nAHnHplUFyD0NqCXF1OlR7iQD4J8djb2N2A1uNt4tfz8jyZU5mHKyygYXd6Itq5oGu/CiH6r9CDZfyzvW2wUvJ/tlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995828; c=relaxed/simple;
	bh=4cc+M6JKzI/LD+tbvHh7v3sbfLjn/hkgZQfZgQNBBQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQa1iqT+ADfMBhs5D9Gf6tKPozXhv26jNSmXkz0Kj4+AjwD5gTlhVrdjp+9dWl2KXx8Y/Pe/PEgsJgh0N1gZWx27Rt/msIAf1kTFJihPeA+80jgxw7ES6ZXAp5hibLwQANU6sP/j64ox5+dGJTjpEAiPCmK4S0VATDftAjLluhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96B51682;
	Wed, 19 Feb 2025 12:10:44 -0800 (PST)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1292C3F59E;
	Wed, 19 Feb 2025 12:10:26 -0800 (PST)
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
Subject: [PATCH v5 3/5] ACPICA: add start method for Arm FF-A
Date: Wed, 19 Feb 2025 14:10:12 -0600
Message-Id: <20250219201014.174344-4-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219201014.174344-1-stuart.yoder@arm.com>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
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


