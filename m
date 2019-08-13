Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE7E8B193
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHMHyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 03:54:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39758 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHMHyj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 03:54:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so47135809pfn.6
        for <linux-integrity@vger.kernel.org>; Tue, 13 Aug 2019 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/6GszB9sj0hWKj+kaLwjfcR80qoXC6NcpFiphrG3mY=;
        b=xqQvXFU5pHlQDztbofOSmhKGzz9e0T6Qi0PrUMdcdf/sxw/4v659/OzUPYbEVaqlOm
         I4lJusOwruYgiFDr0kJxlTuvWJkm7EZ742FZd2eKjokTxLlp4DBh8V/x9xt+b/YQvbbP
         vImQYrPQW3hxZ5rHqngiqLECJiBC+9tIwMprfwyUw2uFBmlt7w1PsXGW8NaouymODwfq
         Nd+oCVaqfGzlzdgPZ8nc7UTTEfKsz2IDrZ9VXEqxmkyaPIZv38UOL6BFtG3faI6ijMBm
         dO/E6BIGq4yXkF01sjBknadFAmqP8yrmeYVsewUuF7DFobVGPsJKzrn3A95gj2sBJeAK
         VjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/6GszB9sj0hWKj+kaLwjfcR80qoXC6NcpFiphrG3mY=;
        b=MkflFkmMYgKTR7v9M7Weii2JmgtlT/Zie6TS52iAvP4A7jm55OxQbn7m4OkFpb5PA9
         a4/VJNZ/+WgvbzIbMQJyoykw4jBCfp54Oig+hZz/ztSn/kOa+stVbqtp5YNKMlsBfZNE
         fURUdcP3OYTVfSIWF+mXrLYE7+YQf7WkacTsYZkzFQLPAvbccJJ5Yk/Yc/rDPbWXl94K
         D6RYc5UBXvRJTv8B4y0pMtr1zkyFp9iqULyW9NpKH5rrPC68JbQ5DijV5z15vZR3DRKl
         rgwuca6WacVqAXWbu5eigsgNqYOoqapPg7wl03Q3HKPDK/CrM7QpGZuF90p5iSbNmzHh
         g58w==
X-Gm-Message-State: APjAAAX8UU4o3X8C3Bef2xeFkXcM37E8qj1mbke0Nbk+zXGCFAeN2Aih
        kEBLze8sq0rPBZe0y5HQ7xohrg==
X-Google-Smtp-Source: APXvYqw4npY13CrdNPZrCr5nHasYtdWyDa3/334sHsI7QXh/PxIsy93xdqM+wTwaPh7dMFt5Dg7W7g==
X-Received: by 2002:a63:6c7:: with SMTP id 190mr33153720pgg.7.1565682878134;
        Tue, 13 Aug 2019 00:54:38 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.100])
        by smtp.gmail.com with ESMTPSA id l25sm131462563pff.143.2019.08.13.00.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 00:54:37 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v4 4/5] KEYS: trusted: move tpm2 trusted keys code
Date:   Tue, 13 Aug 2019 13:23:03 +0530
Message-Id: <1565682784-10234-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move TPM2 trusted keys code to trusted keys subsystem. The reason
being it's better to consolidate all the trusted keys code to a single
location so that it can be maintained sanely.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/tpm/tpm-chip.c               |   1 +
 drivers/char/tpm/tpm-interface.c          |  56 -----
 drivers/char/tpm/tpm.h                    |  16 --
 drivers/char/tpm/tpm2-cmd.c               | 308 +-----------------------
 include/keys/trusted_tpm.h                |   7 +
 include/linux/tpm.h                       |  56 +++--
 security/keys/trusted-keys/Makefile       |   1 +
 security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
 8 files changed, 429 insertions(+), 394 deletions(-)
 create mode 100644 security/keys/trusted-keys/trusted-tpm2.c

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index d47ad10..49450c1 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -243,6 +243,7 @@ struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 		return NULL;
 	return chip;
 }
+EXPORT_SYMBOL_GPL(tpm_find_get_ops);
 
 /**
  * tpm_dev_release() - free chip memory and the device number
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c..208e5ba 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -454,62 +454,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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
index 0b5498a..1c07ce6 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -164,8 +164,6 @@ extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
 ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
-ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-			 size_t min_rsp_body_length, const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
@@ -192,9 +190,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
-struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
-void tpm_put_ops(struct tpm_chip *chip);
 
 struct tpm_chip *tpm_chip_alloc(struct device *dev,
 				const struct tpm_class_ops *ops);
@@ -214,24 +210,12 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
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
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
-void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
-int tpm2_seal_trusted(struct tpm_chip *chip,
-		      struct trusted_key_payload *payload,
-		      struct trusted_key_options *options);
-int tpm2_unseal_trusted(struct tpm_chip *chip,
-			struct trusted_key_payload *payload,
-			struct trusted_key_options *options);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index d103545..8bb34890 100644
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
@@ -376,299 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
 	tpm_buf_destroy(&buf);
 }
-
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
+EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
 struct tpm2_get_cap_out {
 	u8 more_data;
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 9bdf5f4..0d72106 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -37,6 +37,13 @@ int TSS_checkhmac1(unsigned char *buffer,
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
 int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
 
+int tpm_seal_trusted(struct tpm_chip *chip,
+		     struct trusted_key_payload *payload,
+		     struct trusted_key_options *options);
+int tpm_unseal_trusted(struct tpm_chip *chip,
+		       struct trusted_key_payload *payload,
+		       struct trusted_key_options *options);
+
 #define TPM_DEBUG 0
 
 #if TPM_DEBUG
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 130c167..895179f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -294,6 +294,19 @@ struct tpm_buf {
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
@@ -384,13 +402,12 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
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
+extern struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
+extern void tpm_put_ops(struct tpm_chip *chip);
+extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
+				size_t min_rsp_body_length, const char *desc);
+extern void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -418,21 +435,30 @@ static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
 	return -ENODEV;
 }
 
-static inline int tpm_seal_trusted(struct tpm_chip *chip,
-				   struct trusted_key_payload *payload,
-				   struct trusted_key_options *options)
+static inline struct tpm_chip *tpm_default_chip(void)
 {
-	return -ENODEV;
+	return NULL;
 }
-static inline int tpm_unseal_trusted(struct tpm_chip *chip,
-				     struct trusted_key_payload *payload,
-				     struct trusted_key_options *options)
+
+static inline struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
+{
+	return NULL;
+}
+
+static inline void tpm_put_ops(struct tpm_chip *chip)
+{
+}
+
+static inline ssize_t tpm_transmit_cmd(struct tpm_chip *chip,
+				       struct tpm_buf *buf,
+				       size_t min_rsp_body_length,
+				       const char *desc)
 {
 	return -ENODEV;
 }
-static inline struct tpm_chip *tpm_default_chip(void)
+
+static inline void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
-	return NULL;
 }
 #endif
 #endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 4e8963a..fb42e94 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted-tpm.o
+trusted-y += trusted-tpm2.o
diff --git a/security/keys/trusted-keys/trusted-tpm2.c b/security/keys/trusted-keys/trusted-tpm2.c
new file mode 100644
index 0000000..98892ed7
--- /dev/null
+++ b/security/keys/trusted-keys/trusted-tpm2.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2004 IBM Corporation
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
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
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
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
+ * tpm_seal_trusted() - seal a trusted key payload
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @options:	authentication values and other options
+ * @payload:	the key data in clear and encrypted form
+ *
+ * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
+ * the keyring subsystem.
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
+		     struct trusted_key_options *options)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	rc = tpm2_seal_trusted(chip, payload, options);
+
+	tpm_put_ops(chip);
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
+ *        < 0 error from tpm_transmit_cmd.
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
+	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
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
+ *         < 0 error from tpm_transmit_cmd
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
+	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
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
+ * Return: Same as with tpm_transmit_cmd.
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
+	tpm2_flush_context(chip, blob_handle);
+	return rc;
+}
+
+/**
+ * tpm_unseal_trusted() - unseal a trusted key
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @options:	authentication values and other options
+ * @payload:	the key data in clear and encrypted form
+ *
+ * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
+ * the keyring subsystem.
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_unseal_trusted(struct tpm_chip *chip,
+		       struct trusted_key_payload *payload,
+		       struct trusted_key_options *options)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	rc = tpm2_unseal_trusted(chip, payload, options);
+
+	tpm_put_ops(chip);
+
+	return rc;
+}
-- 
2.7.4

