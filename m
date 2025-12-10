Return-Path: <linux-integrity+bounces-7896-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C515FCB395E
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 085FF30012D9
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DE326950;
	Wed, 10 Dec 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1r9MKXz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663F7260F;
	Wed, 10 Dec 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387248; cv=none; b=Uf53D8nJP0nIj68NUBHt/2SDoyfUIWYAY0rKey8d0bCg1bCDAT0ERwh6DtPW4erGR6mKRbA0SnL1dmzArfh1pPd+WnJYoQI4QPqE7W12Mw15AJqiBH17GE3nAZChiJ35+96dl3tfnS8M8TcSdZ7xaZNCJ/vke6ekjXwm5Rgw/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387248; c=relaxed/simple;
	bh=YLxoju7ac/XDRjKgxiY9Rq9+9lm1HK2m5estBbEKcmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFOlU80E7p7LeMHW16Cmf/OwL4o93KCiUyAkgn7RcMLmee8nYbLGFTfJoollE3xhT8LjDRPnFwNMzBQk9PwdCPywUs+YlE++3pGHjomU0VdduTshZVBVCTx8mt5OcUJdzzxyKOR18grV6ih3DY7izMgZ6hayYNw56PgyN4vczx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1r9MKXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F72AC4CEF1;
	Wed, 10 Dec 2025 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765387246;
	bh=YLxoju7ac/XDRjKgxiY9Rq9+9lm1HK2m5estBbEKcmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1r9MKXz/MJc65c5Ch56fTRwFLK2bpH781ed11ziVtpocg728QetQ1ydbQG2jXSR5
	 C3oDSkfbmag7lYku3hrmHZrfu5CDf+dPWLWck9U7iYlEc0bozpr5ULX7GZunl1zmVv
	 QGC2dnFEiZkVO94sHQgzp027DPKj3gzI8fzhhY5zNNbhHBzuzLPG0X7ahCNhtv7iT3
	 3BeinH5JnJvsOfCgIx8+MbYE8AYd4QnhULNZBW8G4nppRTfjuthkEIe+VRzlkSuB75
	 SxqtvL+gg1s1WX21JVLBQxKlVGyyvusDp9/Aj+lau6X4vUy9/Lv8IP+LCtKOa5ADtt
	 moD9pmzPPSNoA==
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
Subject: [PATCH v4 2/8] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Wed, 10 Dec 2025 19:20:20 +0200
Message-Id: <20251210172027.109938-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251210172027.109938-1-jarkko@kernel.org>
References: <20251210172027.109938-1-jarkko@kernel.org>
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
2.39.5


