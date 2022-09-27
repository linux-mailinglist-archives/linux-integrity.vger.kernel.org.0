Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4E5ECA1C
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiI0Qvq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiI0Quu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:50:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5BA7675B
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:50:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v1so9591349plo.9
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8xPJVfvtY0Vre6T8sLQpiwo/TlsYOEXjgjjpEdLGd7I=;
        b=KA0zxwE8oLsIjjdK+yd3bCQrz+rXCwKQmChZKj4lWWOBeWoRUo7Cm1kPq0ETEDzw4W
         tXW6Bm3NST4bV3q3lvqSYkqkCwnpBN21Mehv/pCI/dEBNQJLI+sashVrkSABqP5Kj6WA
         WH9LZP05vL/A70Hb44WnlY1KlSRudbiwr8MDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8xPJVfvtY0Vre6T8sLQpiwo/TlsYOEXjgjjpEdLGd7I=;
        b=0iWgHqQ3T+hhNhwFHNYF7uH6A6MHEqbFu+GA3aY2Ch0x+wmoXGzzgWVs1ZJZYVovPq
         rgsQo3Nd0mpzp6AqSdbhz/1mZjDEFCNZY7lDLFwicaq2i5J/kQ1GfgAVP5emXcA90qOn
         ow3R0WflB+QWl0ZIq2Alti8UyQ29CjA/wEiHp0QgSfKSZif8CaCoqIiazlKkrt0F/Pft
         UVwa/0cUR5EKT4Fd7a0WsZWv/UbRjBOpUGZtLJ1uiv2mzDk8j/lmuRVrIITTp6x3Brz0
         fy2KIaUkvilmysW9W5AQPUvX/YfC09NzzoRd8jvQeZz/1uoQZUpCPYhLyJCSUFhhKBHv
         Kq+A==
X-Gm-Message-State: ACrzQf3OdGGLdW2zGPEMuBSE+eFH3spH0m0nAIKg7UdtrBWAo9n3aIsP
        IgQFqEZkrblxw2fwtQ+8Wu3RLg==
X-Google-Smtp-Source: AMsMyM4NqrOOxy13OgvGUoNidvS0w8+pqdYG34NUyozHh6ucQibSAG19SaC9hyz+wDmf+bBHGnR6aw==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5c with SMTP id z2-20020a170902ccc200b0017829f95c5cmr27498261ple.19.1664297433127;
        Tue, 27 Sep 2022 09:50:33 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:50:32 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>, Hao Wu <hao.wu@rubrik.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, axelj <axelj@axis.com>
Subject: [PATCH v3 11/11] PM: hibernate: seal the encryption key with a PCR policy
Date:   Tue, 27 Sep 2022 09:49:22 -0700
Message-Id: <20220927094559.v3.11.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The key blob is not secret, and by default the TPM will happily unseal
it regardless of system state. We can protect against that by sealing
the secret with a PCR policy - if the current PCR state doesn't match,
the TPM will refuse to release the secret. For now let's just seal it to
PCR 23. In the long term we may want a more flexible policy around this,
such as including PCR 7 for PCs or 0 for Chrome OS.

Link: https://lore.kernel.org/all/20210220013255.1083202-10-matthewgarrett@google.com/
Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v3:
 - Changed funky tag to Co-developed-by (Kees)

Changes in v2:
 - Fix sparse warnings
 - Fix session type comment (Andrey)
 - Eliminate extra label in get/create_kernel_key() (Andrey)
 - Call tpm_try_get_ops() before calling tpm2_flush_context().

 include/linux/tpm.h    |   4 +
 kernel/power/snapenc.c | 164 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 438f8bc0a50582..cd520efc515bca 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -233,18 +233,22 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_START_AUTH_SESSION      = 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
 	TPM2_CC_PCR_READ	        = 0x017E,
+	TPM2_CC_POLICY_PCR              = 0x017F,
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_POLICY_GET_DIGEST       = 0x0189,
 	TPM2_CC_CREATE_LOADED           = 0x0191,
 	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 1f08942450775a..02d25f9500cb7f 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -433,6 +433,111 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 	memset(data->user_key, 0, sizeof(data->user_key));
 }
 
+static int tpm_setup_policy(struct tpm_chip *chip, int *session_handle)
+{
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	char nonce[32] = {0x00};
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
+			  TPM2_CC_START_AUTH_SESSION);
+	if (rc)
+		return rc;
+
+	/* Decrypt key */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+
+	/* Auth entity */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+
+	/* Nonce - blank is fine here */
+	tpm_buf_append_u16(&buf, sizeof(nonce));
+	tpm_buf_append(&buf, nonce, sizeof(nonce));
+
+	/* Encrypted secret - empty */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Session type - policy */
+	tpm_buf_append_u8(&buf, 0x01);
+
+	/* Encryption type - NULL */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* Hash type - SHA256 */
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+	if (be32_to_cpu(head->length) != sizeof(struct tpm_header) +
+	    sizeof(u32) + sizeof(u16) + sizeof(nonce)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*session_handle = be32_to_cpu(*(__be32 *)&buf.data[10]);
+	memcpy(nonce, &buf.data[16], sizeof(nonce));
+	tpm_buf_destroy(&buf);
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_PCR);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, *session_handle);
+
+	/* PCR digest - read from the PCR, we'll verify creation data later */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* One PCR */
+	tpm_buf_append_u32(&buf, 1);
+
+	/* SHA256 banks */
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	/* Select PCR 23 */
+	tpm_buf_append_u32(&buf, 0x03000080);
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc)
+		goto out;
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+static int tpm_policy_get_digest(struct tpm_chip *chip, int handle,
+				 char *digest)
+{
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_GET_DIGEST);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+	if (be32_to_cpu(head->length) != sizeof(struct tpm_header) +
+	    sizeof(u16) + SHA256_DIGEST_SIZE) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	memcpy(digest, &buf.data[12], SHA256_DIGEST_SIZE);
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 static int snapshot_setup_encryption_common(struct snapshot_data *data)
 {
 	int i, rc;
@@ -492,7 +597,12 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	struct key *key = NULL;
 	int ret, i;
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
+	char *keyinfo = NULL;
+	const char *keytemplate =
+		"new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000\tpolicydigest=%s";
+	char policy[SHA256_DIGEST_SIZE];
+	char *policydigest = NULL;
+	int session_handle = -1;
 
 	chip = tpm_default_chip();
 	if (!chip)
@@ -524,6 +634,28 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	if (ret != 0)
 		goto out;
 
+	policydigest = kmalloc(SHA256_DIGEST_SIZE * 2 + 1, GFP_KERNEL);
+	if (!policydigest) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = tpm_setup_policy(chip, &session_handle);
+	if (ret != 0)
+		goto out;
+
+	ret = tpm_policy_get_digest(chip, session_handle, policy);
+	if (ret != 0)
+		goto out;
+
+	bin2hex(policydigest, policy, SHA256_DIGEST_SIZE);
+	policydigest[SHA256_DIGEST_SIZE * 2] = '\0';
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, policydigest);
+	if (!keyinfo) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
 			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
 			NULL);
@@ -548,7 +680,16 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 		key_put(key);
 	}
 
+	if (session_handle != -1) {
+		if (tpm_try_get_ops(chip) == 0) {
+			tpm2_flush_context(chip, session_handle);
+			tpm_put_ops(chip);
+		}
+	}
+
 	kfree(digests);
+	kfree(keyinfo);
+	kfree(policydigest);
 	tpm_pcr_reset(chip, 23);
 
 out_dev:
@@ -613,13 +754,14 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	char certhash[SHA256_DIGEST_SIZE];
 	const struct cred *cred = current_cred();
-	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000000\tpolicyhandle=0x%x";
 	struct tpm_digest *digests = NULL;
 	char *blobstring = NULL;
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
 	struct key *key = NULL;
 	struct trusted_key_payload *payload;
+	int session_handle = -1;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -652,14 +794,21 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret != 0)
 		goto out;
 
-	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
+	ret = tpm_setup_policy(chip, &session_handle);
+	if (ret != 0)
+		goto out;
+
+	blobstring = kmalloc(blob->blob_len * 2 + 1, GFP_KERNEL);
 	if (!blobstring) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	bin2hex(blobstring, blob->blob, blob->blob_len);
-	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
+	blobstring[blob->blob_len * 2] = '\0';
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring,
+			    session_handle);
+
 	if (!keyinfo) {
 		ret = -ENOMEM;
 		goto out;
@@ -742,6 +891,13 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 		key_put(key);
 	}
 
+	if (session_handle != -1) {
+		if (tpm_try_get_ops(chip) == 0) {
+			tpm2_flush_context(chip, session_handle);
+			tpm_put_ops(chip);
+		}
+	}
+
 	kfree(keyinfo);
 	kfree(blobstring);
 	kfree(digests);
-- 
2.31.0

