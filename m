Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B2959EF1D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiHWW1V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiHWW0d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21478709B
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pm13so6362756pjb.5
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BUHuWOJLiFCZxjF2IJK0QGpDwXsuGlCQ6w5K7saDjcg=;
        b=fED9NOGt5sYow4RkQwQE3fq/JYbJCLveXK+ythf3HwJ7dWtfWZSfiFJd98G9tZnc/8
         WQmDuIRDOw/Qc3J4UxxhODwPAstXt0dVf/ehTYw4DNrfw6lS19m5aVSEwv16jawTVI7q
         CIlCQoHiE6xp6bziESQQ32k7cgx1meoLAv4r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BUHuWOJLiFCZxjF2IJK0QGpDwXsuGlCQ6w5K7saDjcg=;
        b=m3/q3B17+JK5F9E3Uo77E7G5NcbQGlPh50BPmoPJvk1gOeN5OTC443INNBJT7VE3ns
         6TP4vRZk9/fHTjUdKvhG5f305yRuvyrkkPXYSixgCc66ECyUknWe9PmlduqFBX72O+IJ
         W/FBTuoMiv6rWmgM7bgoT+daXxZXjdwi+F2dWNtEsLcgC+Tzim0MZ8vaTdOvQ5i53Ccg
         3qsdzhdCfNQT2e3rap24JUIjU0tvyPUoI1w2l5fCrhjEsXxU5L+xVc2QqCAWpPYaw6/P
         2TMStB5fOwgLwoZH74qqCFomv8V2evXob8WItkK1lONSTUBerm9mG8Vdjm9HIUEThuQ+
         T3eA==
X-Gm-Message-State: ACgBeo2SK/j7WuQhB4EQ1zLjo/QYR+GWJkNcT1lmgtSnjFmUPG/o3k0Z
        Q6gBkhEpYpmfp0eM2v9YP0lrQA==
X-Google-Smtp-Source: AA6agR4kKvjvFNbqdNjGdSYFSZKFH8q6i71i5vg2idYcJxCaeDVWbp3XMBvBGLp0hn/cmsrtKy6+Gw==
X-Received: by 2002:a17:90a:604e:b0:1fa:c865:eabb with SMTP id h14-20020a17090a604e00b001fac865eabbmr5294116pjm.46.1661293578332;
        Tue, 23 Aug 2022 15:26:18 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:18 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 07/10] PM: hibernate: Use TPM-backed keys to encrypt image
Date:   Tue, 23 Aug 2022 15:25:23 -0700
Message-Id: <20220823152108.v2.7.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v2:
 - Rework load/create_kernel_key() to eliminate a label (Andrey)
 - Call put_device() needed from calling tpm_default_chip().

 kernel/power/Kconfig   |   2 +
 kernel/power/snapenc.c | 207 +++++++++++++++++++++++++++++++++++++++--
 kernel/power/user.h    |   1 +
 3 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index cd574af0b43379..ff15361c5d8fad 100644
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
index cb90692d6ab83a..90079f6d4f184b 100644
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
@@ -381,11 +397,83 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 	return rc;
 }
 
+static int snapshot_create_kernel_key(struct snapshot_data *data)
+{
+	const struct cred *cred = current_cred();
+	struct tpm_digest *digests = NULL;
+	struct tpm_chip *chip;
+	struct key *key = NULL;
+	int ret, i;
+	/* Create a key sealed by the SRK. */
+	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
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
+	ret = tpm_pcr_reset(chip, 23);
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
+	for (i = 0; i <= chip->nr_allocated_banks; i++) {
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
+	kfree(digests);
+	tpm_pcr_reset(chip, 23);
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
 	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
+	struct trusted_key_payload *payload;
 	int rc;
 	/* Don't pull a random key from a world that can be reset. */
 	if (data->ready)
@@ -399,21 +487,28 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
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
@@ -425,10 +520,99 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
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
+	struct key *key = NULL;
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
+	ret = tpm_pcr_reset(chip, 23);
+	if (ret)
+		goto out;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
+			  GFP_KERNEL);
+	if (!digests)
+		goto out;
+
+	for (i = 0; i <= chip->nr_allocated_banks; i++) {
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
+	tpm_pcr_reset(chip, 23);
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
@@ -444,13 +628,18 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
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

