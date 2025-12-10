Return-Path: <linux-integrity+bounces-7888-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DAECB32DD
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BA530A1F00
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADE22B5AC;
	Wed, 10 Dec 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xya1WqHH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3931E3DED;
	Wed, 10 Dec 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377596; cv=none; b=fe7wuTf8eZtEKPJPxius+LWUhrvY3wBaXwyNB1xVC7wE4LSpX7gHW2VWBuHJ64IeWGJtG8iiRnqq9cCuL3PPoNx5AzdVEE6KFmRCP/6rekyGfk6KH0zR8Vx+7TULdms2WK4bZFm1TbwzNITeDle70kfK4aNV6sK1HRZBk7lIyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377596; c=relaxed/simple;
	bh=+/iE2nY+wCSKxR3DAC0xcgYWEXR/x9Hj89HmjeyMfS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omsDQAm0z90gbiPEvdHR7UKfOgKO2xJJ5vG1WFKw2qgO9sMR9fps1cMvqH9RmqPFFqIK2CchtKVT4hbZb0QQKA1+xOJ2lBWc+HOjl5Xm3Utgz1VYbh0mCTIZQvEoCwlcXydZEeIP319MG29ZImzFbgPzggEmhKDHjICg9lCbC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xya1WqHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87ACC113D0;
	Wed, 10 Dec 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377596;
	bh=+/iE2nY+wCSKxR3DAC0xcgYWEXR/x9Hj89HmjeyMfS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xya1WqHHlOyI/RjPadfwjhmYaIvzLxy5tbsdp34fFdLNA8eWYEQQkp1S98eaHPluF
	 kjgQQqfIsrPLQCkWVeDMykM7CLPSZRwmL9ZFzK9aIng3P4PesBF97aRIg7Kx4qpb9I
	 JpalTFS8UixZzPwlhQEVy3sPweqC9f2Q6FXYEIIF4mTykOl9j5tn8nLoWRY2epGErN
	 mh4nKFCuWZ5NbDoAGT9uqzh7ltzi8yv7gLtmb1x0RszU66v4W4G+TdFI3SKCsBPC3h
	 HIiQ4VIWJkiUWThKuV00AaUN+I1ei7frVs5DNiTi4bv6SFp2q12r44cL8NT83uX4wK
	 IfoHeCqzCbFkg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 2/7] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Wed, 10 Dec 2025 16:39:34 +0200
Message-ID: <20251210143940.264191-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210143940.264191-1-jarkko@kernel.org>
References: <20251210143940.264191-1-jarkko@kernel.org>
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


