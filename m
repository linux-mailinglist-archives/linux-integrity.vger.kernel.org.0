Return-Path: <linux-integrity+bounces-6067-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87BAA3B41
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 00:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5584C8789
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC9274FCA;
	Tue, 29 Apr 2025 22:15:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2A84E1C;
	Tue, 29 Apr 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964931; cv=none; b=IHchlCCzgGAUZA8JI44/PJRZdhYMIaIPykuocDYKcDKVlVxCUXMKZ3FUks5tR76N2s2A5q48VttRNFRLbL4QCa/I7Wi9UUmlnLlQ+bg+a/l43UAXIqZNmK+K49bIowRG65uvNZMeBwGXBhgweH2M06gx+xD+9lk0Ni/H61p6dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964931; c=relaxed/simple;
	bh=wrBHs/aqHxzTH+bd+y8ax+TSaJ65FScsY+QL7p5N2eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyfjyvgOMMQZbplvST/KAkt4Bsc9lw7hFQZXAu7Oz0jc2kKy8QKpzOISbF4wP97l6TewKOgHXn4KwlzGIzQCKpvHHoZKM7hqo4/I8kSWoh+E1tRK+P/D64kgfmBrnnwkTr9kg5E6aVlSDbsrqRxqyJ8cWVstmBy/nckIBOo2OFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8FE175A;
	Tue, 29 Apr 2025 15:15:20 -0700 (PDT)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBDEE3F66E;
	Tue, 29 Apr 2025 15:15:27 -0700 (PDT)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tpm_crb: ffa_tpm: update comment to include 64-bit calling convention
Date: Tue, 29 Apr 2025 17:15:19 -0500
Message-Id: <20250429221519.1022170-3-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429221519.1022170-1-stuart.yoder@arm.com>
References: <20250429221519.1022170-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for DIRECT_REQ and DIRECT_RESP only mentioned AArch32
and listed 32-bit function IDs.  Update to include 64-bit.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 65b01a46d4b88..134747911ba38 100644
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
-- 
2.34.1


