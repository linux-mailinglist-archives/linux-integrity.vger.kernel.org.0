Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A01626572
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiKKXUr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiKKXUP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:20:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD816836B0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l6so5655476pjj.0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTqq7bj67dKUZy2JWRPDzRoAYcrjvnq9cNYv9+r3eEg=;
        b=fewZUJmDaI+21iNMyn8KBwBHljNN/o8Ly2dpBGbna92wAfpHrUX7UEEAR6BPqMEKvi
         dE0KEbKy6y8sAPK3ZTpv2TOyO2MO2gcwUEPuBldL9+AiNcwt477o+bvWx0yLOxxFtnSe
         R8VtXP7Xywx33YF6XK3cwSYHQjOI2eW8tCXUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTqq7bj67dKUZy2JWRPDzRoAYcrjvnq9cNYv9+r3eEg=;
        b=AqDB+LRhZ5goIOmUiABAJQ2imKGVEXhJ7uE22/68Fq91kG6zz4R71QUT4wgcVmYc5r
         UhxlywiSY2I1X6teMe2ZkOopv0At0DV1rvsqbYVvoYpxzfeN1pjQismjcZXZpujltHhb
         drB9WJPzs5Vep+I6I7yTdzEeRMVLkMqa3AZjl6feNJqGwIjJMPRSg4Vg0mgzcyccm1rk
         MaTAO4b0YNGEuVUrme6SFrRlFkcjiF6r83QnkmvLv+Ju3PJpawWpC8gSo9VTUS2l2doS
         dtiHRW/6XRWyndz3UpDxpKGygRfjqhcL1UqkqhZAP2iwUk6m7vfvBPsDs9E0Ad063pjW
         GnuQ==
X-Gm-Message-State: ANoB5pnseG5nOQovVi8YKPFXETpH86DpF1UdXYthwNeZv3veyqmRrfPF
        QPOXPhFI4DogkXqTCbEGEp76PQ==
X-Google-Smtp-Source: AA0mqf5quuWkoqyZw23YhINKkV90+YrXus3svr+jBa8IvjXKvBw9/E6wtj1s6XEDo82AlCRzjkYNvg==
X-Received: by 2002:a17:902:eac6:b0:187:3932:6422 with SMTP id p6-20020a170902eac600b0018739326422mr4471754pld.135.1668208795320;
        Fri, 11 Nov 2022 15:19:55 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:54 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v5 08/11] PM: hibernate: Use TPM-backed keys to encrypt image
Date:   Fri, 11 Nov 2022 15:16:33 -0800
Message-Id: <20221111151451.v5.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221111231636.3748636-1-evgreen@chromium.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
Matthew's incarnation of this patch is at:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

Changes in v5:
 - Use Suggested-by tag instead of made up Sourced-from (Kees)
 - ENCRYPTED_HIBERNATION should depend on TCG_TPM2_RESTRCT_PCR

Changes in v4:
 - s/tpm_pcr_reset/tpm2_pcr_reset/ due to change in other patch
 - Variable ordering and whitespace fixes (Jarkko)
 - Add NULL check explanation in teardown (Jarkko)
 - Change strlen+1 to sizeof for static buffer (Jarkko)
 - Fix nr_allocated_banks loop overflow (found via KASAN)

Changes in v3:
 - ENCRYPTED_HIBERNATION needs TRUSTED_KEYS builtin for
   key_type_trusted.
 - Remove KEYS dependency since it's covered by TRUSTED_KEYS (Kees)

Changes in v2:
 - Rework load/create_kernel_key() to eliminate a label (Andrey)
 - Call put_device() needed from calling tpm_default_chip().

 kernel/power/Kconfig   |   2 +
 kernel/power/snapenc.c | 211 +++++++++++++++++++++++++++++++++++++++--
 kernel/power/user.h    |   1 +
 3 files changed, 205 insertions(+), 9 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 2bde64bddae403..420024f46992b2 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -96,6 +96,8 @@ config ENCRYPTED_HIBERNATION
 	bool "Encryption support for userspace snapshots"
 	depends on HIBERNATION_SNAPSHOT_DEV
 	depends on CRYPTO_AEAD2=y
+	depends on TCG_TPM2_RESTRICT_PCR
+	depends on TRUSTED_KEYS=y
 	help
 	  Enable support for kernel-based encryption of hibernation snapshots
 	  created by uswsusp tools.
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 0d055ea6203a5b..f1db4eddb3c34c 100644
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
@@ -313,6 +323,16 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 {
 	int i;
 
+	/*
+	 * Do NULL checks so this function can safely be called from error paths
+	 * and other places where this context may not be fully set up.
+	 */
+	if (data->key) {
+		key_revoke(data->key);
+		key_put(data->key);
+		data->key = NULL;
+	}
+
 	if (data->aead_req) {
 		aead_request_free(data->aead_req);
 		data->aead_req = NULL;
@@ -381,10 +401,82 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 	return rc;
 }
 
+static int snapshot_create_kernel_key(struct snapshot_data *data)
+{
+	/* Create a key sealed by the SRK. */
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
+	const struct cred *cred = current_cred();
+	struct tpm_digest *digests = NULL;
+	struct key *key = NULL;
+	struct tpm_chip *chip;
+	int ret, i;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	if (!(tpm_is_tpm2(chip))) {
+		ret = -ENODEV;
+		goto out_dev;
+	}
+
+	ret = tpm2_pcr_reset(chip, 23);
+	if (ret)
+		goto out;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
+			  GFP_KERNEL);
+	if (!digests) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+		if (digests[i].alg_id == known_digest.alg_id)
+			memcpy(&digests[i], &known_digest, sizeof(known_digest));
+	}
+
+	ret = tpm_pcr_extend(chip, 23, digests);
+	if (ret != 0)
+		goto out;
+
+	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
+			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
+			NULL);
+
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		key = NULL;
+		goto out;
+	}
+
+	ret = key_instantiate_and_link(key, keyinfo, sizeof(keyinfo), NULL,
+				       NULL);
+	if (ret != 0)
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
+
+	kfree(digests);
+	tpm2_pcr_reset(chip, 23);
+
+out_dev:
+	put_device(&chip->dev);
+	return ret;
+}
+
 int snapshot_get_encryption_key(struct snapshot_data *data,
 				struct uswsusp_key_blob __user *key)
 {
-	u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
+	struct trusted_key_payload *payload;
 	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
 	int rc;
 
@@ -400,21 +492,28 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
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
@@ -426,10 +525,99 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 	return rc;
 }
 
+static int snapshot_load_kernel_key(struct snapshot_data *data,
+				    struct uswsusp_key_blob *blob)
+{
+
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	const struct cred *cred = current_cred();
+	struct tpm_digest *digests = NULL;
+	char *blobstring = NULL;
+	struct key *key = NULL;
+	struct tpm_chip *chip;
+	char *keyinfo = NULL;
+	int i, ret;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	if (!(tpm_is_tpm2(chip))) {
+		ret = -ENODEV;
+		goto out_dev;
+	}
+
+	ret = tpm2_pcr_reset(chip, 23);
+	if (ret)
+		goto out;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
+			  GFP_KERNEL);
+	if (!digests)
+		goto out;
+
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+		if (digests[i].alg_id == known_digest.alg_id)
+			memcpy(&digests[i], &known_digest, sizeof(known_digest));
+	}
+
+	ret = tpm_pcr_extend(chip, 23, digests);
+	if (ret != 0)
+		goto out;
+
+	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
+	if (!blobstring) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	bin2hex(blobstring, blob->blob, blob->blob_len);
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
+	if (!keyinfo) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
+			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
+			NULL);
+
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		key = NULL;
+		goto out;
+	}
+
+	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
+				       NULL);
+	if (ret != 0)
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
+
+	kfree(keyinfo);
+	kfree(blobstring);
+	kfree(digests);
+	tpm2_pcr_reset(chip, 23);
+
+out_dev:
+	put_device(&chip->dev);
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
@@ -445,13 +633,18 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
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
index ac429782abff85..6c86fb64ebe13e 100644
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
2.38.1.431.g37b22c650d-goog

