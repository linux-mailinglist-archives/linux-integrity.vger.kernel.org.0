Return-Path: <linux-integrity+bounces-7861-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5ACAF2D7
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 08:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA8E307C186
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A5256C70;
	Tue,  9 Dec 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9kWDKJr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2827F015;
	Tue,  9 Dec 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265956; cv=none; b=aVLpbQAJ1nBz593m3Ho++F8YuDfK96L4I3xfmcAk2a2EzWXCXwtyTRcHPpfaQO9m2TBlGJPIAQ61m4ItPFPE7bNc5p3kRR4C2yU9wAZ/GVeGu9SzgGpq8mugSR59IYQJbgBT2O40OvEZc00/r6F95HKjbHrxJ9ULLc53hCuXlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265956; c=relaxed/simple;
	bh=ztm1TpqE5Z71RcSkmDyFfN5kJE/eM01hp7rBZY1g174=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6QJJhrUPkwjoK79F6XITzw4sFNGACxe2i9Irrp6sfEc5m3xt9yPlr4GhKfDjl7CZXiq1U5c03D3UTnvLcro0C2VpaHTE6GYLzyQjgTa//hrEJjMt0oUrB8AZ6hMwKhWVDPVAmEti6bESxWxDtsTL+3ruNWmwsqS2faT4H7zKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9kWDKJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F8EC4CEF5;
	Tue,  9 Dec 2025 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265956;
	bh=ztm1TpqE5Z71RcSkmDyFfN5kJE/eM01hp7rBZY1g174=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9kWDKJrb8vomUvUkh/zBVXgoa5NBMkzDH9xO2p3IlDYflNYSvTFuRLd7X74jDNB7
	 rZu7BnihvWGK+QaARIE0PGVAHwvq2XF+oyvkkenfC7QczvGC+viLq1qaKQHN1XDCEQ
	 TRT3Y34egVpWcuYvbGCXVgnbFLJnQIaeFVYRSvPHi0DaOKIK2m66O6/sOnwRCBwTtb
	 Veawpps3RGIOVGB/rdE7s+2gbE+3g+ZQfqUjwuhv+BAetr9CvRYf7rItGHb4RzkXBT
	 Hw1Giuad5xn+abLwVaGNtZPXG8L4FJlD6z/HBCVbxcgdmS4Gek8AWsHk3J58wwYcNk
	 KvG7Ki1vP2fNw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Tue,  9 Dec 2025 09:38:59 +0200
Message-ID: <20251209073903.767518-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209073903.767518-1-jarkko@kernel.org>
References: <20251209073903.767518-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is somewhat cosmetic change but it does serve a purpose on tracking
the value set for the maximum length of TPM names, and to clearly states
what components it is composed of. It also anchors the value so that when
buffers are declared for this particular purpose, the same value is used
for the capacity.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 79f27a46bd7f..a0c88fb1804c 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -137,7 +137,7 @@ struct tpm2_auth {
 	 * we must compute and remember
 	 */
 	u32 name_h[AUTH_MAX_NAMES];
-	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
+	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 42e2a091f43d..b4b5bd586501 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -28,7 +28,16 @@
 #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
 #define TPM_BUFSIZE		4096
 
+/*
+ * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
+ */
 #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+
+/*
+ * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
+ * name algorithm and hash of TPMT_PUBLIC.
+ */
+#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
 #define TPM2_MAX_PCR_BANKS	8
 
 struct tpm_chip;
-- 
2.52.0


