Return-Path: <linux-integrity+bounces-7965-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F4CBBCAB
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE3C5300EF1A
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F8280329;
	Sun, 14 Dec 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQyu572a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53E1DF75B;
	Sun, 14 Dec 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726705; cv=none; b=u6wnGI0v92fvzApdduT4jhpech/mKo3+pDi2lDflPndg2tOgP3gPy2JJi43UfvF56zI3XVk38pY3Ux2l5orBDQs/6Ubf10PfEUW+Yj3RSMy1ug6gJ8awBz/tmeZlVp5pgaOzVqQtukRF6TYDn5Bj0rxvPUsbChqSWZNiBzqGwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726705; c=relaxed/simple;
	bh=hA8zNSxUO04oiGoLyUyUfoyhO2bJOaezJ7Z2BJID+po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fO5vcaEykpbmAegUROOj6OJ6gmwDkov9zcxBJ9KEPqzD/rHgGtDdVByAnkSq+SVcB5XiBCqtiqzLNWwjSsIqbhhQBzU7fAKFm7MKXfaEZ83+qMljGTnGtEunAV++2DvaKDjk6kQRMoRVZNTVX4cbfkcBczTVxtClfRScqAAj6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQyu572a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB1CC4CEFB;
	Sun, 14 Dec 2025 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726704;
	bh=hA8zNSxUO04oiGoLyUyUfoyhO2bJOaezJ7Z2BJID+po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQyu572aWOKs6aM5tyy9/kO3Lc3MepkL5S+CjlhTP1iBQ9+AjC+0l2MS7InMpQAUK
	 MbAcsNg11ZzlN18KJ/s928/B5iyXb7+pIYjhoS9FIYvplaORJmp7IAXZ7/mSRIKSTt
	 GzQ7MxZ1uNtap6iiGvj1eZ92t834ms4QO0Sy61orGIjx7T628e2u5mbzb/TTY/2kz3
	 SPR5/eynPOYGcVbfGz3JmrvtsGLYXUwaIaig4qkkIXrEiAxFzGdtUDaT9vRsRtyCb8
	 7vE2JncN4tmhmqo9dx0cCHdQsoBXpCWm6mtk6t6pQ5Yi9EUGe7GFp7zP5vdQarGeo7
	 AksaXMOB++VXQ==
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
Subject: [PATCH v6 01/11] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Date: Sun, 14 Dec 2025 17:37:58 +0200
Message-Id: <20251214153808.73831-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251214153808.73831-1-jarkko@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define TPM2_NAME_MAX_SIZE, which describes the maximum size for hashes
encoded as TPMT_HA, which the prime identifier used for persistent and
transient keys in TPM2 protocol.

Set its value to 'SHA512_DIGEST_SIZE + 2', as SHA512 has the largest
digest size of the algorithms in TCG algorithm repository.

In additionl, rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE in order to
avoid any possible confusion.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
- Rewrote the commit message.
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


