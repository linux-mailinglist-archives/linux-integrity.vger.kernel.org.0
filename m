Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C534FD87F0
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 07:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfJPFP7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 01:15:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45969 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfJPFP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 01:15:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so12352359pgj.12
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y7XKv6lwpnVXIBOBfSDj9mLToyVChDub1Adjv6hE7JI=;
        b=ureGRx9jgnI4Pbo4YUO/Pp6FCn0P6ToXIP++4R4nQPPuiJ5Voqbo60rLiFaRuMg4CR
         cSJcgo4Tu9oX7e1Oj8udp6XkGwLxdWnIu88TmSDWB9mff0Jtve5BqbrPeAAQNxqc6BaP
         6oTZu8ZMYjEOXEoKX/kvXBzFvmHvUWpxlWOHeiiUk14lPXbBqPJAoWRZrV925/nYQkMd
         KXYDZJJL+FDpkQjUXo5xLfDKNWUoM/diD6eyymTllT6j1nDFCCZilpG7qiVVbGlJOZRQ
         t/LakiL08cEwlvPeqCoUXO06VWIRUTTahAf61nGPuA2y5O1OQtqHSdS/Gn65Ad5lo1km
         Q3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y7XKv6lwpnVXIBOBfSDj9mLToyVChDub1Adjv6hE7JI=;
        b=H48qb1Vc6ylODZvBGacMXQs8fCy3lIPJG64IDQ5cWzlf7j0PGUlm4MkfF0Ep6xSYVW
         F3VcgLaD1qCrIk4Czxm0+3J2Yw0Im/1FPYNF6u2tetluDwsRIxWiN3RAeG0dKfb0nMlI
         vIC3p2gn8Qfq4CbDumhlsu6WXRRuyfSMB24dxQqAUZvvL54zcT2C9C3k4SavySMNsGUC
         +hgVJXSHufHPrkaN7cWFHRSsN/QSp1T1UrLspIzkl1RsriefeDJ++GVHSsx7X3vVq1W3
         empE2bVfD29+eiTyfHtGB2QYeTDzJ39kelpdIX0kKqoOa1HIHPkZ424+R/Al7OpH6EGR
         75Pg==
X-Gm-Message-State: APjAAAXNR1YhCY+kmu7R20vIMnH7MJIvwKZtgHo1aeVS/V68D8VgAZ5j
        j072DWokyXNHM/8G9OvdfMRUOD7NmaA=
X-Google-Smtp-Source: APXvYqwLusWWSzENMe7Eeq4SmUiPZbZE42t/01YmfhsY7q8fKYanJK4TNjlsVjOklX7f2sMt7IVEzg==
X-Received: by 2002:a62:b405:: with SMTP id h5mr43023685pfn.234.1571202954118;
        Tue, 15 Oct 2019 22:15:54 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id r81sm953297pgr.17.2019.10.15.22.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 22:15:53 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v8 4/4] KEYS: trusted: Move TPM2 trusted keys code
Date:   Wed, 16 Oct 2019 10:44:55 +0530
Message-Id: <1571202895-32651-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571202895-32651-1-git-send-email-sumit.garg@linaro.org>
References: <1571202895-32651-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move TPM2 trusted keys code to trusted keys subsystem. The reason
being it's better to consolidate all the trusted keys code to a single
location so that it can be maintained sanely.

Also, utilize existing tpm_send() exported API which wraps the internal
tpm_transmit_cmd() API.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c          |  56 ------
 drivers/char/tpm/tpm.h                    |  11 --
 drivers/char/tpm/tpm2-cmd.c               | 307 -----------------------------
 include/keys/trusted_tpm.h                |   7 +
 include/linux/tpm.h                       |  36 ++--
 security/keys/trusted-keys/Makefile       |   1 +
 security/keys/trusted-keys/trusted_tpm1.c |   4 +-
 security/keys/trusted-keys/trusted_tpm2.c | 314 ++++++++++++++++++++++++++++++
 8 files changed, 342 insertions(+), 394 deletions(-)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7f10549..a438b12 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -459,62 +459,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
-/**
- * tpm_seal_trusted() - seal a trusted key payload
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @options:	authentication values and other options
- * @payload:	the key data in clear and encrypted form
- *
- * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
- * the keyring subsystem.
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
-		     struct trusted_key_options *options)
-{
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return -ENODEV;
-
-	rc = tpm2_seal_trusted(chip, payload, options);
-
-	tpm_put_ops(chip);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_seal_trusted);
-
-/**
- * tpm_unseal_trusted() - unseal a trusted key
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @options:	authentication values and other options
- * @payload:	the key data in clear and encrypted form
- *
- * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
- * the keyring subsystem.
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_unseal_trusted(struct tpm_chip *chip,
-		       struct trusted_key_payload *payload,
-		       struct trusted_key_options *options)
-{
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return -ENODEV;
-
-	rc = tpm2_unseal_trusted(chip, payload, options);
-
-	tpm_put_ops(chip);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_unseal_trusted);
-
 static int __init tpm_init(void)
 {
 	int rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b174cf4..b9e1547 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -212,11 +212,6 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
 }
 #endif
 
-static inline u32 tpm2_rc_value(u32 rc)
-{
-	return (rc & BIT(7)) ? rc & 0xff : rc;
-}
-
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
@@ -224,12 +219,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
-int tpm2_seal_trusted(struct tpm_chip *chip,
-		      struct trusted_key_payload *payload,
-		      struct trusted_key_options *options);
-int tpm2_unseal_trusted(struct tpm_chip *chip,
-			struct trusted_key_payload *payload,
-			struct trusted_key_options *options);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5817dfe..fdb4577 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -13,20 +13,6 @@
 
 #include "tpm.h"
 #include <crypto/hash_info.h>
-#include <keys/trusted-type.h>
-
-enum tpm2_object_attributes {
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-};
-
-struct tpm2_hash {
-	unsigned int crypto_id;
-	unsigned int tpm_id;
-};
 
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
@@ -377,299 +363,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_buf_destroy(&buf);
 }
 
-/**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
- *
- * @buf: an allocated tpm_buf instance
- * @session_handle: session handle
- * @nonce: the session nonce, may be NULL if not used
- * @nonce_len: the session nonce length, may be 0 if not used
- * @attributes: the session attributes
- * @hmac: the session HMAC or password, may be NULL if not used
- * @hmac_len: the session HMAC or password length, maybe 0 if not used
- */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
-{
-	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
-	tpm_buf_append_u32(buf, session_handle);
-	tpm_buf_append_u16(buf, nonce_len);
-
-	if (nonce && nonce_len)
-		tpm_buf_append(buf, nonce, nonce_len);
-
-	tpm_buf_append_u8(buf, attributes);
-	tpm_buf_append_u16(buf, hmac_len);
-
-	if (hmac && hmac_len)
-		tpm_buf_append(buf, hmac, hmac_len);
-}
-
-/**
- * tpm2_seal_trusted() - seal the payload of a trusted key
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- *
- * Return: < 0 on error and 0 on success.
- */
-int tpm2_seal_trusted(struct tpm_chip *chip,
-		      struct trusted_key_payload *payload,
-		      struct trusted_key_options *options)
-{
-	unsigned int blob_len;
-	struct tpm_buf buf;
-	u32 hash;
-	int i;
-	int rc;
-
-	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
-		if (options->hash == tpm2_hash_map[i].crypto_id) {
-			hash = tpm2_hash_map[i].tpm_id;
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(tpm2_hash_map))
-		return -EINVAL;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
-
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
-	tpm_buf_append_u16(&buf, payload->key_len + 1);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
-	tpm_buf_append_u8(&buf, payload->migratable);
-
-	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
-
-	/* policy */
-	if (options->policydigest_len) {
-		tpm_buf_append_u32(&buf, 0);
-		tpm_buf_append_u16(&buf, options->policydigest_len);
-		tpm_buf_append(&buf, options->policydigest,
-			       options->policydigest_len);
-	} else {
-		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
-		tpm_buf_append_u16(&buf, 0);
-	}
-
-	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
-
-	/* outside info */
-	tpm_buf_append_u16(&buf, 0);
-
-	/* creation PCR */
-	tpm_buf_append_u32(&buf, 0);
-
-	if (buf.flags & TPM_BUF_OVERFLOW) {
-		rc = -E2BIG;
-		goto out;
-	}
-
-	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
-	if (rc)
-		goto out;
-
-	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
-	if (blob_len > MAX_BLOB_SIZE) {
-		rc = -E2BIG;
-		goto out;
-	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
-		rc = -EFAULT;
-		goto out;
-	}
-
-	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
-	payload->blob_len = blob_len;
-
-out:
-	tpm_buf_destroy(&buf);
-
-	if (rc > 0) {
-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
-			rc = -EINVAL;
-		else
-			rc = -EPERM;
-	}
-
-	return rc;
-}
-
-/**
- * tpm2_load_cmd() - execute a TPM2_Load command
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: returned blob handle
- *
- * Return: 0 on success.
- *        -E2BIG on wrong payload size.
- *        -EPERM on tpm error status.
- *        < 0 error from tpm_transmit_cmd.
- */
-static int tpm2_load_cmd(struct tpm_chip *chip,
-			 struct trusted_key_payload *payload,
-			 struct trusted_key_options *options,
-			 u32 *blob_handle)
-{
-	struct tpm_buf buf;
-	unsigned int private_len;
-	unsigned int public_len;
-	unsigned int blob_len;
-	int rc;
-
-	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
-	if (private_len > (payload->blob_len - 2))
-		return -E2BIG;
-
-	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
-	blob_len = private_len + public_len + 4;
-	if (blob_len > payload->blob_len)
-		return -E2BIG;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	tpm_buf_append(&buf, payload->blob, blob_len);
-
-	if (buf.flags & TPM_BUF_OVERFLOW) {
-		rc = -E2BIG;
-		goto out;
-	}
-
-	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
-	if (!rc)
-		*blob_handle = be32_to_cpup(
-			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
-
-out:
-	tpm_buf_destroy(&buf);
-
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
-}
-
-/**
- * tpm2_unseal_cmd() - execute a TPM2_Unload command
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: blob handle
- *
- * Return: 0 on success
- *         -EPERM on tpm error status
- *         < 0 error from tpm_transmit_cmd
- */
-static int tpm2_unseal_cmd(struct tpm_chip *chip,
-			   struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u32 blob_handle)
-{
-	struct tpm_buf buf;
-	u16 data_len;
-	u8 *data;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, blob_handle);
-	tpm2_buf_append_auth(&buf,
-			     options->policyhandle ?
-			     options->policyhandle : TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     TPM2_SA_CONTINUE_SESSION,
-			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
-	if (rc > 0)
-		rc = -EPERM;
-
-	if (!rc) {
-		data_len = be16_to_cpup(
-			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
-			rc = -EFAULT;
-			goto out;
-		}
-
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
-			rc = -EFAULT;
-			goto out;
-		}
-		data = &buf.data[TPM_HEADER_SIZE + 6];
-
-		memcpy(payload->key, data, data_len - 1);
-		payload->key_len = data_len - 1;
-		payload->migratable = data[data_len - 1];
-	}
-
-out:
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
-/**
- * tpm2_unseal_trusted() - unseal the payload of a trusted key
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- *
- * Return: Same as with tpm_transmit_cmd.
- */
-int tpm2_unseal_trusted(struct tpm_chip *chip,
-			struct trusted_key_payload *payload,
-			struct trusted_key_options *options)
-{
-	u32 blob_handle;
-	int rc;
-
-	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
-	if (rc)
-		return rc;
-
-	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
-	tpm2_flush_context(chip, blob_handle);
-	return rc;
-}
-
 struct tpm2_get_cap_out {
 	u8 more_data;
 	__be32 subcap_id;
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 7b9d7b4..a56d8e1 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -40,6 +40,13 @@ int TSS_checkhmac1(unsigned char *buffer,
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
 int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
 
+int tpm2_seal_trusted(struct tpm_chip *chip,
+		      struct trusted_key_payload *payload,
+		      struct trusted_key_options *options);
+int tpm2_unseal_trusted(struct tpm_chip *chip,
+			struct trusted_key_payload *payload,
+			struct trusted_key_options *options);
+
 #define TPM_DEBUG 0
 
 #if TPM_DEBUG
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c78119f..0d6e949 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -296,6 +296,19 @@ struct tpm_buf {
 	u8 *data;
 };
 
+enum tpm2_object_attributes {
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+};
+
+struct tpm2_hash {
+	unsigned int crypto_id;
+	unsigned int tpm_id;
+};
+
 static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
@@ -375,6 +388,11 @@ static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *) &value2, 4);
 }
 
+static inline u32 tpm2_rc_value(u32 rc)
+{
+	return (rc & BIT(7)) ? rc & 0xff : rc;
+}
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
@@ -384,12 +402,6 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
-extern int tpm_seal_trusted(struct tpm_chip *chip,
-			    struct trusted_key_payload *payload,
-			    struct trusted_key_options *options);
-extern int tpm_unseal_trusted(struct tpm_chip *chip,
-			      struct trusted_key_payload *payload,
-			      struct trusted_key_options *options);
 extern struct tpm_chip *tpm_default_chip(void);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
@@ -418,18 +430,6 @@ static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
 	return -ENODEV;
 }
 
-static inline int tpm_seal_trusted(struct tpm_chip *chip,
-				   struct trusted_key_payload *payload,
-				   struct trusted_key_options *options)
-{
-	return -ENODEV;
-}
-static inline int tpm_unseal_trusted(struct tpm_chip *chip,
-				     struct trusted_key_payload *payload,
-				     struct trusted_key_options *options)
-{
-	return -ENODEV;
-}
 static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 1a24680..7b73ceb 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_tpm1.o
+trusted-y += trusted_tpm2.o
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index e3155fd..eb5074e 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1004,7 +1004,7 @@ static int trusted_instantiate(struct key *key,
 	switch (key_cmd) {
 	case Opt_load:
 		if (tpm2)
-			ret = tpm_unseal_trusted(chip, payload, options);
+			ret = tpm2_unseal_trusted(chip, payload, options);
 		else
 			ret = key_unseal(payload, options);
 		dump_payload(payload);
@@ -1020,7 +1020,7 @@ static int trusted_instantiate(struct key *key,
 			goto out;
 		}
 		if (tpm2)
-			ret = tpm_seal_trusted(chip, payload, options);
+			ret = tpm2_seal_trusted(chip, payload, options);
 		else
 			ret = key_seal(payload, options);
 		if (ret < 0)
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
new file mode 100644
index 0000000..a9810ac
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2004 IBM Corporation
+ * Copyright (C) 2014 Intel Corporation
+ */
+
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/tpm.h>
+#include <linux/tpm_command.h>
+
+#include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
+
+static struct tpm2_hash tpm2_hash_map[] = {
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+};
+
+/**
+ * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ *
+ * @buf: an allocated tpm_buf instance
+ * @session_handle: session handle
+ * @nonce: the session nonce, may be NULL if not used
+ * @nonce_len: the session nonce length, may be 0 if not used
+ * @attributes: the session attributes
+ * @hmac: the session HMAC or password, may be NULL if not used
+ * @hmac_len: the session HMAC or password length, maybe 0 if not used
+ */
+static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+				 const u8 *nonce, u16 nonce_len,
+				 u8 attributes,
+				 const u8 *hmac, u16 hmac_len)
+{
+	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
+	tpm_buf_append_u32(buf, session_handle);
+	tpm_buf_append_u16(buf, nonce_len);
+
+	if (nonce && nonce_len)
+		tpm_buf_append(buf, nonce, nonce_len);
+
+	tpm_buf_append_u8(buf, attributes);
+	tpm_buf_append_u16(buf, hmac_len);
+
+	if (hmac && hmac_len)
+		tpm_buf_append(buf, hmac, hmac_len);
+}
+
+/**
+ * tpm2_seal_trusted() - seal the payload of a trusted key
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ *
+ * Return: < 0 on error and 0 on success.
+ */
+int tpm2_seal_trusted(struct tpm_chip *chip,
+		      struct trusted_key_payload *payload,
+		      struct trusted_key_options *options)
+{
+	unsigned int blob_len;
+	struct tpm_buf buf;
+	u32 hash;
+	int i;
+	int rc;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (options->hash == tpm2_hash_map[i].crypto_id) {
+			hash = tpm2_hash_map[i].tpm_id;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(tpm2_hash_map))
+		return -EINVAL;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, options->keyhandle);
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     0 /* session_attributes */,
+			     options->keyauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	/* sensitive */
+	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+
+	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
+	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
+	tpm_buf_append_u16(&buf, payload->key_len + 1);
+	tpm_buf_append(&buf, payload->key, payload->key_len);
+	tpm_buf_append_u8(&buf, payload->migratable);
+
+	/* public */
+	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, hash);
+
+	/* policy */
+	if (options->policydigest_len) {
+		tpm_buf_append_u32(&buf, 0);
+		tpm_buf_append_u16(&buf, options->policydigest_len);
+		tpm_buf_append(&buf, options->policydigest,
+			       options->policydigest_len);
+	} else {
+		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
+		tpm_buf_append_u16(&buf, 0);
+	}
+
+	/* public parameters */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* outside info */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* creation PCR */
+	tpm_buf_append_u32(&buf, 0);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc)
+		goto out;
+
+	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
+	if (blob_len > MAX_BLOB_SIZE) {
+		rc = -E2BIG;
+		goto out;
+	}
+	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
+	payload->blob_len = blob_len;
+
+out:
+	tpm_buf_destroy(&buf);
+
+	if (rc > 0) {
+		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
+			rc = -EINVAL;
+		else
+			rc = -EPERM;
+	}
+
+	return rc;
+}
+
+/**
+ * tpm2_load_cmd() - execute a TPM2_Load command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ * @blob_handle: returned blob handle
+ *
+ * Return: 0 on success.
+ *        -E2BIG on wrong payload size.
+ *        -EPERM on tpm error status.
+ *        < 0 error from tpm_send.
+ */
+static int tpm2_load_cmd(struct tpm_chip *chip,
+			 struct trusted_key_payload *payload,
+			 struct trusted_key_options *options,
+			 u32 *blob_handle)
+{
+	struct tpm_buf buf;
+	unsigned int private_len;
+	unsigned int public_len;
+	unsigned int blob_len;
+	int rc;
+
+	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
+	if (private_len > (payload->blob_len - 2))
+		return -E2BIG;
+
+	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
+	blob_len = private_len + public_len + 4;
+	if (blob_len > payload->blob_len)
+		return -E2BIG;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, options->keyhandle);
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     0 /* session_attributes */,
+			     options->keyauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	tpm_buf_append(&buf, payload->blob, blob_len);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (!rc)
+		*blob_handle = be32_to_cpup(
+			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
+
+out:
+	tpm_buf_destroy(&buf);
+
+	if (rc > 0)
+		rc = -EPERM;
+
+	return rc;
+}
+
+/**
+ * tpm2_unseal_cmd() - execute a TPM2_Unload command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ * @blob_handle: blob handle
+ *
+ * Return: 0 on success
+ *         -EPERM on tpm error status
+ *         < 0 error from tpm_send
+ */
+static int tpm2_unseal_cmd(struct tpm_chip *chip,
+			   struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u32 blob_handle)
+{
+	struct tpm_buf buf;
+	u16 data_len;
+	u8 *data;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, blob_handle);
+	tpm2_buf_append_auth(&buf,
+			     options->policyhandle ?
+			     options->policyhandle : TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     TPM2_SA_CONTINUE_SESSION,
+			     options->blobauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc > 0)
+		rc = -EPERM;
+
+	if (!rc) {
+		data_len = be16_to_cpup(
+			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+			rc = -EFAULT;
+			goto out;
+		}
+
+		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
+			rc = -EFAULT;
+			goto out;
+		}
+		data = &buf.data[TPM_HEADER_SIZE + 6];
+
+		memcpy(payload->key, data, data_len - 1);
+		payload->key_len = data_len - 1;
+		payload->migratable = data[data_len - 1];
+	}
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+/**
+ * tpm2_unseal_trusted() - unseal the payload of a trusted key
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ *
+ * Return: Same as with tpm_send.
+ */
+int tpm2_unseal_trusted(struct tpm_chip *chip,
+			struct trusted_key_payload *payload,
+			struct trusted_key_options *options)
+{
+	u32 blob_handle;
+	int rc;
+
+	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
+	if (rc)
+		return rc;
+
+	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+
+	return rc;
+}
-- 
2.7.4

