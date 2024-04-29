Return-Path: <linux-integrity+bounces-2270-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894628B639D
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC87A1C21C92
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0032145FED;
	Mon, 29 Apr 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VOMAL8u0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A292205E20;
	Mon, 29 Apr 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422623; cv=none; b=n4lM6G9lt+JL6YysyVbB0KvrD63MY0gME///J1RMgEHklCF6gR+/WcEQYZsXO9W7De/NmWwSpdpqN14a6HE4oLwH+KpMBIXj6txJp6JktArcPeI/xUCn+n1LK7X09WD0pIyfcC53HeGdGs/E4ykt3tq1JqoFtdH6rNvWiy0PeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422623; c=relaxed/simple;
	bh=ADbyj/D4/GRL6pC11KrRKdy77pnDq0Ht/S916BJH0OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcVYAbXXFZvK7LRXElE6frcFEHUakCPx5FOYgVxuxwi1jZ9xEMzajGCHQGJRnKsxMbO/HjUJ7T5Qn0rO8mqHwiPdIDtjf4Tm2LFK9cAEXXjL+VBlt0eezIKZ+HUeI22V2r20aKTK5d6GdaEXD2qMcDxWqk5dj8WnIQwrc14X4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VOMAL8u0; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422621;
	bh=ADbyj/D4/GRL6pC11KrRKdy77pnDq0Ht/S916BJH0OY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=VOMAL8u0Z24UNX95UxT1OBioGkyORt8puovdhIT2zO1B+N6zpb/9TS1TqoOrL673o
	 QZ3Q6e5SUautgdKDIHgTaE9MToUiTS5RRd1mY+9nmXjGFAg2RNoyrBfiVlN42OhGTK
	 t08kkkKmY+R3AbET2xCl5UOF8BBDvR6zjU3zviIQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E639B1281D87;
	Mon, 29 Apr 2024 16:30:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id O4A1gon0sOp1; Mon, 29 Apr 2024 16:30:21 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 52F3412819F3;
	Mon, 29 Apr 2024 16:30:21 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 13/22] tpm: Add TCG mandated Key Derivation Functions (KDFs)
Date: Mon, 29 Apr 2024 16:28:02 -0400
Message-Id: <20240429202811.13643-14-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCG mandates two Key derivation functions called KDFa and KDFe
used to derive keys from seeds and elliptic curve points respectively.
The definitions for these functions are found in the TPM 2.0 Library
Specification Part 1 - Architecture Guide

https://trustedcomputinggroup.org/resource/tpm-library-specification/

Implement a cut down version of each of these functions sufficient to
support the key derivation needs of HMAC sessions.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v8: Add new patch containing KDFs
---
 drivers/char/tpm/Kconfig         |   1 +
 drivers/char/tpm/tpm2-sessions.c | 105 +++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index ab16d347579f..4873e6eae255 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -30,6 +30,7 @@ if TCG_TPM
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
 	default y
+	select CRYPTO_LIB_SHA256
 	help
 	  Setting this causes us to deploy a scheme which uses request
 	  and response HMACs in addition to encryption for
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index fc3f032df467..8429e596f1eb 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -7,6 +7,111 @@
 
 #include "tpm.h"
 #include <asm/unaligned.h>
+#include <crypto/hash.h>
+#include <crypto/hmac.h>
+
+/*
+ * It turns out the crypto hmac(sha256) is hard for us to consume
+ * because it assumes a fixed key and the TPM seems to change the key
+ * on every operation, so we weld the hmac init and final functions in
+ * here to give it the same usage characteristics as a regular hash
+ */
+static void tpm2_hmac_init(struct sha256_state *sctx, u8 *key, u32 key_len)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	sha256_init(sctx);
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < key_len)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_IPAD_VALUE;
+	}
+	sha256_update(sctx, pad, sizeof(pad));
+}
+
+static void tpm2_hmac_final(struct sha256_state *sctx, u8 *key, u32 key_len,
+			    u8 *out)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < key_len)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	/* collect the final hash;  use out as temporary storage */
+	sha256_final(sctx, out);
+
+	sha256_init(sctx);
+	sha256_update(sctx, pad, sizeof(pad));
+	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
+	sha256_final(sctx, out);
+}
+
+/*
+ * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
+ * otherwise standard tpm2_KDFa.  Note output is in bytes not bits.
+ */
+static void tpm2_KDFa(u8 *key, u32 key_len, const char *label, u8 *u,
+		      u8 *v, u32 bytes, u8 *out)
+{
+	u32 counter = 1;
+	const __be32 bits = cpu_to_be32(bytes * 8);
+
+	while (bytes > 0) {
+		struct sha256_state sctx;
+		__be32 c = cpu_to_be32(counter);
+
+		tpm2_hmac_init(&sctx, key, key_len);
+		sha256_update(&sctx, (u8 *)&c, sizeof(c));
+		sha256_update(&sctx, label, strlen(label)+1);
+		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
+		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
+		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
+		tpm2_hmac_final(&sctx, key, key_len, out);
+
+		bytes -= SHA256_DIGEST_SIZE;
+		counter++;
+		out += SHA256_DIGEST_SIZE;
+	}
+}
+
+/*
+ * Somewhat of a bastardization of the real KDFe.  We're assuming
+ * we're working with known point sizes for the input parameters and
+ * the hash algorithm is fixed at sha256.  Because we know that the
+ * point size is 32 bytes like the hash size, there's no need to loop
+ * in this KDF.
+ */
+static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
+		      u8 *out)
+{
+	struct sha256_state sctx;
+	/*
+	 * this should be an iterative counter, but because we know
+	 *  we're only taking 32 bytes for the point using a sha256
+	 *  hash which is also 32 bytes, there's only one loop
+	 */
+	__be32 c = cpu_to_be32(1);
+
+	sha256_init(&sctx);
+	/* counter (BE) */
+	sha256_update(&sctx, (u8 *)&c, sizeof(c));
+	/* secret value */
+	sha256_update(&sctx, z, EC_PT_SZ);
+	/* string including trailing zero */
+	sha256_update(&sctx, str, strlen(str)+1);
+	sha256_update(&sctx, pt_u, EC_PT_SZ);
+	sha256_update(&sctx, pt_v, EC_PT_SZ);
+	sha256_final(&sctx, out);
+}
 
 /**
  * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CREATE_PRIMARY
-- 
2.35.3


