Return-Path: <linux-integrity+bounces-7848-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E611CAC0BA
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 06:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3180D300CE8F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9A25743D;
	Mon,  8 Dec 2025 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXcZxR/k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39E23A9B0;
	Mon,  8 Dec 2025 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170390; cv=none; b=OV2zlnUNy2zG6VXZ/h0SjRjG+u1eXJ+zqUVbtX3GIoKz9vJSeysKUNOlDlI4w+snbU4DpZ4cQjmPGATTZc6fwFQT8+B/GGuNrLWJfa4HtwmDPdMptiLh/X2BxO2KtCj3Mk5WMTbeLcfw8EDG6EM3Z1w13z2xf1IfYFhRYuKj2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170390; c=relaxed/simple;
	bh=rn7oNe5ZHhS8yS682p3UklD29G+Fs+9xn3bIAUJXr1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+V5fCagZXuzR/0uG5bBzTNgXOVHp8ig0bIR24SvA0rrYsuf77UTXcXAFzA0PZFvmsGyrXR7c7je7hTEQVmD+XGBldWh4O9CEP8prOigb6flesWwgVn+N5t7FzCZ0YUGFkbgYoh3sYyzz0UHHiz3+V1djS83uQ8kAPlYlfvesJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXcZxR/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3EC116B1;
	Mon,  8 Dec 2025 05:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765170390;
	bh=rn7oNe5ZHhS8yS682p3UklD29G+Fs+9xn3bIAUJXr1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXcZxR/ketj2mW3nF7SV3zI59iVgfbB7rJ8CEiR3FnsScHO78R3tymvjVwzjeeOs5
	 bxOI/JJSCMaY2I3g8X/hYP/FbS9OWx9wOn3lldfeQ7Y7CQTCkGQQtTrekX4PZu7ujY
	 V8rwDHara09etR9MKZ+SViYyB36sslCn55O9UNfOwXBmyN3Q8GDgC+F1RV7UBXLPoo
	 2R0YyiYWdxDxqpzendrRyP6f/KNYGRinzewRPAcX73TA03yzBYGMbA4mFv0wiueqsS
	 arCl+m23AZBEtb5K377iHm19YPPn3eQh8IfVbBadGBd8/MdvGOO8FNZE/FMgx5RcDU
	 Vin3ohpwy/w3A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 1/3] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Mon,  8 Dec 2025 07:06:17 +0200
Message-Id: <20251208050620.339408-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251208050620.339408-1-jarkko@kernel.org>
References: <20251208050620.339408-1-jarkko@kernel.org>
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
v7:
- A new patch.
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
2.39.5


