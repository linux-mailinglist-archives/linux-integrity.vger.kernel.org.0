Return-Path: <linux-integrity+bounces-7954-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D1CBB366
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C3B300D41B
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80C2356BE;
	Sat, 13 Dec 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUyc7dnW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FE22A7E9;
	Sat, 13 Dec 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657970; cv=none; b=dEM5BZ0LGC5JxKWshUc+sySzhe1MsU2pjgqh/5Zgznq4HMxFTB3YSX2n3sz3kJCEKSSM85DrjULLU4eh+kxUUweXWwXZCgXFbb9PnipqBWYUKll9CyMoSnXWqSmLw8xd0tOdPU3+sF3Z/Opt9g+JJep/KmfIR39xQe2lZsKBiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657970; c=relaxed/simple;
	bh=nGKm7oLZL4b0PSBY0Mxqcx5h/zT9PHSVe2EpwiDSduI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APYpUAb1OH4pGKa9oKlkXdgnnIMJrWOZXx5vxL8BQdbh6PPfIyr3uJbHaC0Uwvv9K/NeoPN11QtzsjwxEQfqwp8QPuu7wBpKGIMb4ni6Hm1Um3QCtq9dT1N+XcNDittefZtwyGjK/z25T1lyMjYYIjG9TeLgAwECMCMt4hwTDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUyc7dnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6303C4CEF7;
	Sat, 13 Dec 2025 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657970;
	bh=nGKm7oLZL4b0PSBY0Mxqcx5h/zT9PHSVe2EpwiDSduI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUyc7dnWfw1A4U3RTFLDVP1UUSzwgoLEukomJqFpOM0GjW03xKg1AwFctz8fYxgkr
	 6TJwC/MhUASrd6OF0MJaWwvKtR/TOG8ytQyc+vIuYOFRMolZngntzdsx04xjqyMMpB
	 pcMmT+tSGpFXKpjau3H5qeDZY8bo2pP9Gsmt8qG+lwKX4S8dj//0b6Dc0/ay9r4zzS
	 o2rtQ2E2EI/CRVLd31puKSEN7iAhOPP9uDWic+OXHZ3p4Z8cU4W5yjKoGrT3dbB7Rp
	 bLtNWSHMZD6tUMettJxQUiZbOub/LxEGVOoaM3UfwBUfxwh0uv0pltB6lJOToEItJ4
	 a3CiZyjkbax+w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 03/12] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Sat, 13 Dec 2025 22:32:10 +0200
Message-Id: <20251213203220.317498-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251213203220.317498-1-jarkko@kernel.org>
References: <20251213203220.317498-1-jarkko@kernel.org>
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
v2:
- Rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE.
---
 drivers/char/tpm/tpm-sysfs.c     |  2 +-
 drivers/char/tpm/tpm2-sessions.c |  2 +-
 include/linux/tpm.h              | 37 +++++++++++++++++++++-----------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..4a6a27ee295d 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -314,7 +314,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
-	int size = TPM2_NAME_SIZE;
+	int size = TPM2_NULL_NAME_SIZE;
 
 	bin2hex(buf, chip->null_key_name, size);
 	size *= 2;
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 4149379665c4..525b8622d1c3 100644
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
index 202da079d500..e10f2096eae7 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,9 +27,33 @@
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
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
+
+/*
+ * The maximum number of PCR banks.
+ */
 #define TPM2_MAX_PCR_BANKS	8
 
+/*
+ * fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NULL_NAME_SIZE	34
+
+/*
+ * The maximum size for an object context
+ */
+#define TPM2_MAX_CONTEXT_SIZE	4096
+
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
@@ -139,17 +163,6 @@ struct tpm_chip_seqops {
 /* fixed define for the curve we use which is NIST_P256 */
 #define EC_PT_SZ	32
 
-/*
- * fixed define for the size of a name.  This is actually HASHALG size
- * plus 2, so 32 for SHA256
- */
-#define TPM2_NAME_SIZE	34
-
-/*
- * The maximum size for an object context
- */
-#define TPM2_MAX_CONTEXT_SIZE 4096
-
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -211,7 +224,7 @@ struct tpm_chip {
 	/* saved context for NULL seed */
 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
 	 /* name of NULL seed */
-	u8 null_key_name[TPM2_NAME_SIZE];
+	u8 null_key_name[TPM2_NULL_NAME_SIZE];
 	u8 null_ec_key_x[EC_PT_SZ];
 	u8 null_ec_key_y[EC_PT_SZ];
 	struct tpm2_auth *auth;
-- 
2.39.5


