Return-Path: <linux-integrity+bounces-4043-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6F9BFAE2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8506528325C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DF322E;
	Thu,  7 Nov 2024 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVEQbYHt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71F7E1;
	Thu,  7 Nov 2024 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940435; cv=none; b=qhc8VKILOfLnlB6EsujBRwQnD9FwahR4hOXTGBpqLcjI1RxixG+Bq7/MfWoXFj+ROU6qfGXbFXvQfonm6JVvK7gie2bPHncBVv0y7u7OBOJ7RfEqpsr2Cwk0a0ytSlidukjpyIYuDKIsz6v0Nmh4PVd4zL9GZHrI1ihjJI+KZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940435; c=relaxed/simple;
	bh=1k9bq21o3kYniMJw32NjowIHjtIg86EP5FgduFgkNBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmOzQTHSvKkTWSgo/iYVYPVdz0pnmPE2jFDrdxyz/vu0HHVbctfkRTgL0D38C/btaIgYw5LMJ2KzvAkr7ldv1mqhlUNhh1Zr+xI3JvlZY7Rd9Hd90I8T0luNhA4nbvJlX+gIkDp3vugG/ZUd4163ZidsCWeizbB8qZIQwoCwuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVEQbYHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC96C4CEC6;
	Thu,  7 Nov 2024 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730940434;
	bh=1k9bq21o3kYniMJw32NjowIHjtIg86EP5FgduFgkNBE=;
	h=From:To:Cc:Subject:Date:From;
	b=lVEQbYHtR+Dorbt7lcTI1fazhwhNffENyuUuoiPlRXj49Sj8y7vrvJ9Y3102bteIa
	 EKAxbtgx6xhmHwJ+ztAdx/StfNGi+9UX75vHgvYL1hC7hMLkxPWF93Nr8KALdLjjNZ
	 2TLwpzL4SXTHNfhsLXJ8RnaJoy130VB+IrQd+MPlNz7OsK/TzeW5f+vLvMTjydGj9a
	 qeg17rBe7/sUY7iT7pelDs1toJXp0u4kYP+Y3ax6hrvelv8HIHg4oUzkWE/ViwtIRF
	 Me6oYYuoCEzVq4TqRu+PnV4JQjbxap0N4yKlT+gtHSMV/lpqcI0KbAqFryBKPViDoV
	 i4EirL/tqrWFA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
Date: Thu,  7 Nov 2024 02:47:07 +0200
Message-ID: <20241107004708.108667-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mimi Zohar <zohar@linux.ibm.com>

The initial encrypted HMAC session feature added TPM bus encryption to
various in-kernel TPM operations. This can cause performance bottlenecks
with IMA, as it heavily utilizes PCR extend operations.

In order to address this performance issue, introduce disable_encrypt_pcrs
kernel command-line parameter to the TPM driver.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zohar@linux.ibm.com/
Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1:
- Derived from the earlier RFC patch with a different parameter scope,
  cleaner commit message and some other tweaks. I decided to create
  something because I did not noticed any progress. Note only compile
  tested as I wanted to get something quickly out.
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++
 drivers/char/tpm/tpm2-cmd.c                   | 33 ++++++++---
 drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
 include/linux/tpm.h                           |  4 ++
 4 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..e27517e1a26f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6727,6 +6727,16 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
+	tpm.disable_encrypt_pcrs= [HW,TPM]
+			Do not protect PCR registers from unintended physical
+			access, or interposers in the bus by the means of
+			having an encrypted and integrity protected session
+			wrapped around TPM2_PCR_Extend command. Consider this
+			in a situation where TPM is heavily utilized by
+			IMA, thus protection causing a major performance hit,
+			and the space where machines are deployed is by other
+			means guarded.
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1e856259219e..6ec307b1cb99 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -14,6 +14,10 @@
 #include "tpm.h"
 #include <crypto/hash_info.h>
 
+static bool disable_encrypt_pcrs;
+module_param(disable_encrypt_pcrs, bool, 0444);
+MODULE_PARM_DESC(disable_encrypt_pcrs, "Disable TPM2_PCR_Extend encryption");
+
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	rc = tpm2_start_auth_session(chip);
-	if (rc)
-		return rc;
+	if (!disable_encrypt_pcrs) {
+		rc = tpm2_start_auth_session(chip);
+		if (rc)
+			return rc;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc) {
-		tpm2_end_auth_session(chip);
+		if (!disable_encrypt_pcrs)
+			tpm2_end_auth_session(chip);
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
-	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	if (!disable_encrypt_pcrs) {
+		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	} else {
+		tpm_buf_append_handle(chip, &buf, pcr_idx, NULL);
+		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
@@ -253,9 +265,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	if (!disable_encrypt_pcrs)
+		tpm_buf_fill_hmac_session(chip, &buf);
+	rc = tpm_transmit_cmd(chip, &buf, 0,
+			      "attempting extend a PCR value");
+	if (!disable_encrypt_pcrs)
+		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
 	tpm_buf_destroy(&buf);
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 42df980168b6..02897debc3fa 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -205,6 +205,14 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
+			   u32 handle, u8 *name)
+{
+	tpm_buf_append_u32(buf, handle);
+	/* count the number of handles in the upper bits of flags */
+	buf->handles++;
+}
+
 /**
  * tpm_buf_append_name() - add a handle area to the buffer
  * @chip: the TPM chip structure
@@ -237,9 +245,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_u32(buf, handle);
-		/* count the number of handles in the upper bits of flags */
-		buf->handles++;
+		tpm_buf_append_handle(chip, buf, handle, name);
 		return;
 	}
 
@@ -272,6 +278,31 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphrase_len)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphrase_len;
+
+	if (tpm_buf_length(buf) != offset) {
+		/* not the first session so update the existing length */
+		len += get_unaligned_be32(&buf->data[offset]);
+		put_unaligned_be32(len, &buf->data[offset]);
+	} else {
+		tpm_buf_append_u32(buf, len);
+	}
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, passphrase_len);
+	tpm_buf_append(buf, passphrase, passphrase_len);
+}
+
 /**
  * tpm_buf_append_hmac_session() - Append a TPM session element
  * @chip: the TPM chip structure
@@ -309,26 +340,8 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		/* offset tells us where the sessions area begins */
-		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-		u32 len = 9 + passphrase_len;
-
-		if (tpm_buf_length(buf) != offset) {
-			/* not the first session so update the existing length */
-			len += get_unaligned_be32(&buf->data[offset]);
-			put_unaligned_be32(len, &buf->data[offset]);
-		} else {
-			tpm_buf_append_u32(buf, len);
-		}
-		/* auth handle */
-		tpm_buf_append_u32(buf, TPM2_RS_PW);
-		/* nonce */
-		tpm_buf_append_u16(buf, 0);
-		/* attributes */
-		tpm_buf_append_u8(buf, 0);
-		/* passphrase */
-		tpm_buf_append_u16(buf, passphrase_len);
-		tpm_buf_append(buf, passphrase, passphrase_len);
+		tpm_buf_append_auth(chip, buf, attributes, passphrase,
+				    passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 587b96b4418e..4892cd004530 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -502,9 +502,13 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
+			   u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.47.0


