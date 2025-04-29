Return-Path: <linux-integrity+bounces-6065-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441AAA3B3D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 00:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F561B614F5
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 22:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1126D4F9;
	Tue, 29 Apr 2025 22:15:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF02144BC;
	Tue, 29 Apr 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964930; cv=none; b=YcV/TPafB//Ezj1WaWZTbJFViK4Nu5Zmy8kzdxHyNyrXJFY7Sbp8OKpx1wPxMuHrtKB10Vg7bxov8HKb6ngou3/SJfW4m9NAqR6s/RuO2DZO9Dp/m5Q9YgmrDqAoQlMyCtUKlAtMcVG7WaO2HobKO0IXUZM3PTAdhHQYgqDVtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964930; c=relaxed/simple;
	bh=vQkrv/x38AtAZ74jyhg1zSgAFNeO8N9HzwVBVY7Ki94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBzTDcHJALftgGREsV6SjJomG98HAmaqAkeqh84zHDiFoEE/WBlD96911q+D4AdlU9C79gQcQUR2RXizaCrlGWALWfcKMMKw7TrN7KAUPWYPLZ+cXz32deq4jpJdPcjjgvRXrRfc583FUz5PYKirqQy+NMjNg2CgjGxH2rB4078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FEE6150C;
	Tue, 29 Apr 2025 15:15:20 -0700 (PDT)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CB773F66E;
	Tue, 29 Apr 2025 15:15:27 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tpm_crb: ffa_tpm: fix cut/paste error in comment
Date: Tue, 29 Apr 2025 17:15:17 -0500
Message-Id: <20250429221519.1022170-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the comment for the 'start' function, which was a cut/paste
mistake for a different function.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 3169a87a56b60..65b01a46d4b88 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -68,7 +68,8 @@
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


