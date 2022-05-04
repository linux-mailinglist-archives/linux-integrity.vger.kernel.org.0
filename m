Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30E51B446
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiEEABg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384593AbiEDXZW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E904DF49
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so4805519pjb.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukx11OTQFppBtUrbpfc9Q/EXYRYpQsmqVC+p8pc1mPA=;
        b=A1ZAuax7aaJRT8g7Q33B2GF/NpAbFcshxTmfG2dNhWIrtu8jeC1wCRTxKSTGKLpUJF
         7/oOtgwmXyU9B5Q2nKyOBusu7QHKGl/9Mw91pB5EpKZVlhSenrTRu3J+DZZJfKgnc4EN
         6zJxuutWZnmrdiGxZaSeHuSMSwWNFuRgaSqcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukx11OTQFppBtUrbpfc9Q/EXYRYpQsmqVC+p8pc1mPA=;
        b=J9lfflb2S+YtD9/rmBa56TdJ5QNAdzbqdYZOKumFxoiz1W4bINiLPJJ8fMmObDD/Ta
         A4F/RURkf1aBJyTLnhGu/r3769eTj6RmkiyDEp/UhZE1ZdQoPl6oY9k63xzzt3NzhOX+
         ULAodgJwXiC0gdt94phmhrD+WcJvqXXwkAoUKlI9g1m7raLfdRtkrLXQWl5QBRewW2VA
         ToXaUI2d0K+N0DJ+ryUpNhuAAuFtJx6t0Hjk2HIF+EA0c9uLW3K3VqZoQgX+r9Md5syZ
         iRsW9PR06gJx0qidM1HFQaF5uTXF/b+duajhDIjcWLg8b+aGOTBeHo0HF/tpscfB7fPX
         BoUQ==
X-Gm-Message-State: AOAM531rbOQip8ZVUpS7ptraM+UWGZR4yzv5Wz6lw5PN/UtJwYVEAxX6
        dInwmGMnDf1pzK/yyUrxhb97ug==
X-Google-Smtp-Source: ABdhPJyrm+ytdeYzHKKmwWQLVjMhBvOyLbtdiZMk+wZGCf2/Pt1spCxhC4KxjAuo9j3uolZZtb+K1Q==
X-Received: by 2002:a17:90b:35cb:b0:1dc:7905:c4c1 with SMTP id nb11-20020a17090b35cb00b001dc7905c4c1mr2341829pjb.95.1651706503980;
        Wed, 04 May 2022 16:21:43 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:43 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 07/10] PM: hibernate: Use TPM-backed keys to encrypt image
Date:   Wed,  4 May 2022 16:20:59 -0700
Message-Id: <20220504161439.7.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When using encrypted hibernate images, have the TPM create a key for us
and seal it. By handing back a sealed blob instead of the raw key, we
prevent usermode from being able to decrypt and tamper with the
hibernate image on a different machine.

We'll also go through the motions of having PCR23 set to a known value at
the time of key creation and unsealing. Currently there's nothing that
enforces the contents of PCR23 as a condition to unseal the key blob,
that will come in a later change.

Sourced-from: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---
Matthew's incarnation of this patch is at:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

 kernel/power/Kconfig   |   2 +
 kernel/power/snapenc.c | 195 +++++++++++++++++++++++++++++++++++++++--
 kernel/power/user.h    |   1 +
 3 files changed, 189 insertions(+), 9 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 8249968962bcd5..d8077391feb290 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -96,6 +96,8 @@ config ENCRYPTED_HIBERNATION
 	bool "Encryption support for userspace snapshots"
 	depends on HIBERNATION_SNAPSHOT_DEV
 	depends on CRYPTO_AEAD2=y
+	depends on KEYS
+	depends on TRUSTED_KEYS
 	default n
 	help
 	  Enable support for kernel-based encryption of hibernation snapshots
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index cb90692d6ab83a..2bd5fe05a321e7 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -4,13 +4,23 @@
 #include <linux/crypto.h>
 #include <crypto/aead.h>
 #include <crypto/gcm.h>
+#include <keys/trusted-type.h>
+#include <linux/key-type.h>
 #include <linux/random.h>
 #include <linux/mm.h>
+#include <linux/tpm.h>
 #include <linux/uaccess.h>
 
 #include "power.h"
 #include "user.h"
 
+/* sha256("To sleep, perchance to dream") */
+static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
+	.digest = {0x92, 0x78, 0x3d, 0x79, 0x2d, 0x00, 0x31, 0xb0, 0x55, 0xf9,
+		   0x1e, 0x0d, 0xce, 0x83, 0xde, 0x1d, 0xc4, 0xc5, 0x8e, 0x8c,
+		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
+		   0x5f, 0x49}};
+
 /* Encrypt more data from the snapshot into the staging area. */
 static int snapshot_encrypt_refill(struct snapshot_data *data)
 {
@@ -313,6 +323,12 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 {
 	int i;
 
+	if (data->key) {
+		key_revoke(data->key);
+		key_put(data->key);
+		data->key = NULL;
+	}
+
 	if (data->aead_req) {
 		aead_request_free(data->aead_req);
 		data->aead_req = NULL;
@@ -381,11 +397,77 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 	return rc;
 }
 
+static int snapshot_create_kernel_key(struct snapshot_data *data)
+{
+	const struct cred *cred = current_cred();
+	struct tpm_digest *digests = NULL;
+	struct tpm_chip *chip;
+	struct key *key;
+	int ret, i;
+	/* Create a key sealed by the SRK. */
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	if (!(tpm_is_tpm2(chip)))
+		return -ENODEV;
+
+	ret = tpm_pcr_reset(chip, 23);
+	if (ret != 0)
+		return ret;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
+			  GFP_KERNEL);
+	if (!digests) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
+	for (i = 0; i <= chip->nr_allocated_banks; i++) {
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+		if (digests[i].alg_id == known_digest.alg_id)
+			memcpy(&digests[i], &known_digest, sizeof(known_digest));
+	}
+
+	ret = tpm_pcr_extend(chip, 23, digests);
+	if (ret != 0)
+		goto reset;
+
+	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
+			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
+			NULL);
+
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		goto reset;
+	}
+
+	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
+				       NULL);
+	if (ret < 0)
+		goto out;
+
+	data->key = key;
+	key = NULL;
+
+out:
+	if (key) {
+		key_revoke(key);
+		key_put(key);
+	}
+reset:
+	kfree(digests);
+	tpm_pcr_reset(chip, 23);
+	return ret;
+}
+
 int snapshot_get_encryption_key(struct snapshot_data *data,
 	struct uswsusp_key_blob __user *key)
 {
-	u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
 	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
+	struct trusted_key_payload *payload;
 	int rc;
 	/* Don't pull a random key from a world that can be reset. */
 	if (data->ready)
@@ -399,21 +481,28 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 	get_random_bytes(nonce, sizeof(nonce));
 	memcpy(&data->nonce_low, &nonce[0], sizeof(data->nonce_low));
 	memcpy(&data->nonce_high, &nonce[8], sizeof(data->nonce_high));
-	/* Build a random key */
-	get_random_bytes(aead_key, sizeof(aead_key));
-	rc = crypto_aead_setkey(data->aead_tfm, aead_key, sizeof(aead_key));
+
+	/* Create a kernel key, and set it. */
+	rc = snapshot_create_kernel_key(data);
+	if (rc)
+		goto fail;
+
+	payload = data->key->payload.data[0];
+	/* Install the key */
+	rc = crypto_aead_setkey(data->aead_tfm, payload->key, SNAPSHOT_ENCRYPTION_KEY_SIZE);
 	if (rc)
 		goto fail;
 
-	/* Hand the key back to user mode (to be changed!) */
-	rc = put_user(sizeof(struct uswsusp_key_blob), &key->blob_len);
+	/* Hand the key back to user mode in sealed form. */
+	rc = put_user(payload->blob_len, &key->blob_len);
 	if (rc)
 		goto fail;
 
-	rc = copy_to_user(&key->blob, &aead_key, sizeof(aead_key));
+	rc = copy_to_user(&key->blob, &payload->blob, payload->blob_len);
 	if (rc)
 		goto fail;
 
+	/* The nonce just gets handed back in the clear. */
 	rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
 	if (rc)
 		goto fail;
@@ -425,10 +514,93 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 	return rc;
 }
 
+static int snapshot_load_kernel_key(struct snapshot_data *data,
+	struct uswsusp_key_blob *blob)
+{
+
+	const struct cred *cred = current_cred();
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	struct tpm_digest *digests = NULL;
+	char *blobstring = NULL;
+	char *keyinfo = NULL;
+	struct tpm_chip *chip;
+	struct key *key;
+	int i, ret;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	if (!(tpm_is_tpm2(chip)))
+		return -ENODEV;
+
+	ret = tpm_pcr_reset(chip, 23);
+	if (ret != 0)
+		return ret;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
+			  GFP_KERNEL);
+	if (!digests)
+		goto reset;
+
+	for (i = 0; i <= chip->nr_allocated_banks; i++) {
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+		if (digests[i].alg_id == known_digest.alg_id)
+			memcpy(&digests[i], &known_digest, sizeof(known_digest));
+	}
+
+	ret = tpm_pcr_extend(chip, 23, digests);
+	if (ret != 0)
+		goto reset;
+
+	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
+	if (!blobstring) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
+	bin2hex(blobstring, blob->blob, blob->blob_len);
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
+	if (!keyinfo) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
+	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
+			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
+			NULL);
+
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		goto out;
+	}
+
+	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
+				       NULL);
+	if (ret < 0)
+		goto out;
+
+	data->key = key;
+	key = NULL;
+
+out:
+	if (key) {
+		key_revoke(key);
+		key_put(key);
+	}
+reset:
+	kfree(keyinfo);
+	kfree(blobstring);
+	kfree(digests);
+	tpm_pcr_reset(chip, 23);
+	return ret;
+}
+
 int snapshot_set_encryption_key(struct snapshot_data *data,
 	struct uswsusp_key_blob __user *key)
 {
 	struct uswsusp_key_blob blob;
+	struct trusted_key_payload *payload;
 	int rc;
 
 	/* It's too late if data's been pushed in. */
@@ -444,13 +616,18 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
 	if (rc)
 		goto crypto_setup_fail;
 
-	if (blob.blob_len != sizeof(struct uswsusp_key_blob)) {
+	if (blob.blob_len > sizeof(key->blob)) {
 		rc = -EINVAL;
 		goto crypto_setup_fail;
 	}
 
+	rc = snapshot_load_kernel_key(data, &blob);
+	if (rc)
+		goto crypto_setup_fail;
+
+	payload = data->key->payload.data[0];
 	rc = crypto_aead_setkey(data->aead_tfm,
-				blob.blob,
+				payload->key,
 				SNAPSHOT_ENCRYPTION_KEY_SIZE);
 
 	if (rc)
diff --git a/kernel/power/user.h b/kernel/power/user.h
index 6823e2eba7ec53..591b30bb213349 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -31,6 +31,7 @@ struct snapshot_data {
 	uint64_t crypt_total;
 	uint64_t nonce_low;
 	uint64_t nonce_high;
+	struct key *key;
 #endif
 
 };
-- 
2.31.0

