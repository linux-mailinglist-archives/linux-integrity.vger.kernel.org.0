Return-Path: <linux-integrity+bounces-5864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A22A8860A
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1121668EC
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCF2750EB;
	Mon, 14 Apr 2025 14:52:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C727584E;
	Mon, 14 Apr 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642368; cv=none; b=hJLNMKwkM9P1Z2IIri2BmPOHzhZDOzWwS0BW8JwVBdp4ughHyOZVSQbQjU5QOK8M3Prr8A47KeeWe5YwVK7I7Ym0u70NPKSx0R7us232yGOMzY15hokts4/JCzvkU/wRPgJmtXmli6ZXnltH7Xqn70XAwqfQSyH/Sm4Qj3olQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642368; c=relaxed/simple;
	bh=3z35RHlYA8l/55pToxzmS76Xt3n0sP16nS4Sa9GIr1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIDPFpVtmH7pE8XCGkqpmwGxtc2szrqdBEGFPKqF+si4wtZWXvTj8a+OnqLnsOqoFXoQiuFx5cOoS8sV94BWO7TNDgZ3qMydGWd/uWi4TyE7/KSXZ0t8qsokxA4k0LitlAuv3FzHND1ztkCTMd+nOyFhMRog6A0bVSGDlcnefbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810201007;
	Mon, 14 Apr 2025 07:52:43 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC8433F66E;
	Mon, 14 Apr 2025 07:52:44 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_crb: ffa_tpm: return errors from interface functions if no ffa-crb driver
Date: Mon, 14 Apr 2025 09:52:35 -0500
Message-Id: <20250414145235.938924-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ACPI advertises an FF-A based TPM but the tpm_crb_ffa driver is not
enabled via Kconfig, inline stub versions of the interface functions
are used. These functions incorrectly return 0, which indicates success.
The result is that the tpm_crb probe function continues execution and
eventually detects a timeout at the TPM.

Change the inline functions to return errors, so that probe() sees that
tpm_crb_ffa is not present and aborts the probe.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.h b/drivers/char/tpm/tpm_crb_ffa.h
index 645c41ede10ed..c006403e2f14b 100644
--- a/drivers/char/tpm/tpm_crb_ffa.h
+++ b/drivers/char/tpm/tpm_crb_ffa.h
@@ -14,9 +14,9 @@ int tpm_crb_ffa_init(void);
 int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor);
 int tpm_crb_ffa_start(int request_type, int locality);
 #else
-static inline int tpm_crb_ffa_init(void) { return 0; }
-static inline int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor) { return 0; }
-static inline int tpm_crb_ffa_start(int request_type, int locality) { return 0; }
+static inline int tpm_crb_ffa_init(void) { return -ENODEV; }
+static inline int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor) { return -ENODEV; }
+static inline int tpm_crb_ffa_start(int request_type, int locality) { return -ENODEV; }
 #endif
 
 #define CRB_FFA_START_TYPE_COMMAND 0
-- 
2.34.1


