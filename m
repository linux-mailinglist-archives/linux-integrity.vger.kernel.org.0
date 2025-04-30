Return-Path: <linux-integrity+bounces-6098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E38AA50AD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E5E3A5EF0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0C25DD0A;
	Wed, 30 Apr 2025 15:47:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38F19C556;
	Wed, 30 Apr 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028050; cv=none; b=UNaQxtE931Os0MZwSwNSLKOqQj6uce0w2FyigmwQTUJL2sIDOI94DNiMcPWO+jbTczUhXoQC5++oUfBDSsgac1sdNzktSUneaQhNcq++8d1ksONZ8hjUfjGjVda5ZG1l313aPS1CpGA/sqY4VoUYGGn+v3ycuecDQI4R6jRm+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028050; c=relaxed/simple;
	bh=ahui+q9/P4ykIV2+I5zWINb2R8LLzsTOV2mfFGCgVuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HEcjZ3zm+/DZsIyVd9RBzzxwxPVsnysNUdT6BH2g5t+l+WMSqjqRHZEpUad0XoD+A20D/Ibh5KywahFat9HoWb8NKfHRQikznU4XGTeAUxsEh6YTylLMMLsptZMcM887TtqlL1C3gUb1Iwz8aOmHGMztzkaad7mlUYhSZ+rQJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE5A1063;
	Wed, 30 Apr 2025 08:47:21 -0700 (PDT)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E8C53F5A1;
	Wed, 30 Apr 2025 08:47:28 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm_crb: ffa_tpm: fix/update comments describing the CRB over FFA ABI
Date: Wed, 30 Apr 2025 10:47:23 -0500
Message-Id: <20250430154723.1025101-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Fix the comment describing the 'start' function, which was a cut/paste
 mistake for a different function.

-The comment for DIRECT_REQ and DIRECT_RESP only mentioned AArch32
 and listed 32-bit function IDs.  Update to include 64-bit.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
v2:
  -squashed the two comment updates into a single patch

 drivers/char/tpm/tpm_crb_ffa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 3169a87a56b60..134747911ba38 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -38,9 +38,11 @@
  * messages.
  *
  * All requests with FFA_MSG_SEND_DIRECT_REQ and FFA_MSG_SEND_DIRECT_RESP
- * are using the AArch32 SMC calling convention with register usage as
- * defined in FF-A specification:
- * w0:    Function ID (0x8400006F or 0x84000070)
+ * are using the AArch32 or AArch64 SMC calling convention with register usage
+ * as defined in FF-A specification:
+ * w0:    Function ID
+ *          -for 32-bit: 0x8400006F or 0x84000070
+ *          -for 64-bit: 0xC400006F or 0xC4000070
  * w1:    Source/Destination IDs
  * w2:    Reserved (MBZ)
  * w3-w7: Implementation defined, free to be used below
@@ -68,7 +70,8 @@
 #define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
 
 /*
- * Return information on a given feature of the TPM service
+ * Notifies the TPM service that a TPM command or TPM locality request is
+ * ready to be processed, and allows the TPM service to process it.
  * Call register usage:
  * w3:    Not used (MBZ)
  * w4:    TPM service function ID, CRB_FFA_START
-- 
2.34.1


