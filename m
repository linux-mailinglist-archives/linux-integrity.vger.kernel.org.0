Return-Path: <linux-integrity+bounces-7869-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2BCAF948
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2424A302F6B9
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EE32860C;
	Tue,  9 Dec 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8/z5N6L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DD328607;
	Tue,  9 Dec 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274756; cv=none; b=n58V0Uvx6Un65Egau9Lq2pTOiJVYfR/zZv7ffmvYiWoXILAa6IgV4lBrMyWuQr7kfBh+8+zft2vDrdvFjC2y4OnvHk8fAxWEb9BO8i0icLNv07joXpeibCt3VlBIJKK/wetiM2EtF/D33FPrXpndkO8yiNbDjX+11ngQoLaHhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274756; c=relaxed/simple;
	bh=+/iE2nY+wCSKxR3DAC0xcgYWEXR/x9Hj89HmjeyMfS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZQFcW/doUUBHovJCE7P/T91NJcQz/cRKpGqixBllkXaw/P9PTsDMdqcrK9nKWoVPVhn/MmccR1bQeEoatd4iknWiyZF+TYukG49IjCobcuDD9miFLuLssCFtDa4MRU9TzHc8B+VQbiL4Ux9tiIIeZeMsgTBZcaHmH+00jATFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8/z5N6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A769FC4CEF5;
	Tue,  9 Dec 2025 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765274756;
	bh=+/iE2nY+wCSKxR3DAC0xcgYWEXR/x9Hj89HmjeyMfS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8/z5N6L0j10ieqUEbbc46s1Hj258deq/aPK+WafbiToguLULjWeB50yRilfR6Hhr
	 5xkmUaHwC/ACEGoTW5VMOA807fzVwpHtLW7lkaHWTYM6M3qX/MVaxBRxceKVXksKNQ
	 9QMn5nCgnriB3jCMpE/eqOcwPY5ckJAxhKaxtuBJHJWqgJkAPSA2nEg0pqe7FGcFuH
	 1CjIrZX4M+TP6Of1oIn5gYgP7WxPjQPusAanyzZRF29Il0xZPsyEdWA1aaBhdz6MGv
	 i9X1oePB2k8Yr3V5zmEXNvJGN5DKaKB/nan60TbQfWPcvG6OhUv7ZfdPz9/htfYlpI
	 QfuACbr9aDtsg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Tue,  9 Dec 2025 12:05:25 +0200
Message-ID: <20251209100529.1700779-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209100529.1700779-1-jarkko@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
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
index f5dcadb1ab3c..0f321c307bc6 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -313,7 +313,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
-	int size = TPM2_NAME_SIZE;
+	int size = TPM2_NULL_NAME_SIZE;
 
 	bin2hex(buf, chip->null_key_name, size);
 	size *= 2;
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
index 42e2a091f43d..922a43ef23b5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -28,9 +28,33 @@
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
@@ -140,17 +164,6 @@ struct tpm_chip_seqops {
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
@@ -212,7 +225,7 @@ struct tpm_chip {
 	/* saved context for NULL seed */
 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
 	 /* name of NULL seed */
-	u8 null_key_name[TPM2_NAME_SIZE];
+	u8 null_key_name[TPM2_NULL_NAME_SIZE];
 	u8 null_ec_key_x[EC_PT_SZ];
 	u8 null_ec_key_y[EC_PT_SZ];
 	struct tpm2_auth *auth;
-- 
2.52.0


