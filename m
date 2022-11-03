Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594261870B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKCSFh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKCSEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438923E94
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so2344770pfg.2
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfsRuzUO5GLP1zW6AyT7/m3TZFGZZvZuTGTusTKfICE=;
        b=A1RKpE7yH4+y1aR4/Pz7oxVQPNq2pDcOQXYwYk8Vur37noDZ52R8ef4ZcYJGv7LrTs
         MgItuNd3tKWBjhvirNsfIiVRIxP+QlTRo+mIfQTYYXhMpjgIB6VE18HnonowDzWGjXLN
         wm5LyLwopRycLWBnHhuYh8+aco+LfdC4wRfL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfsRuzUO5GLP1zW6AyT7/m3TZFGZZvZuTGTusTKfICE=;
        b=DJ9ZVC5drVfpLR0CUxJcEgXgTaez28ZaRA8OSYw+n2zSZQ4P/W8ivpvsbXvEBfymL+
         p/XFkgd2bt45hZI9LXkn/Qtmk/BA30Nua62w3HytlsvdpNdB4yupAD2nklgz0O4eTENc
         QGKruJvx8gxJ/WCCqjad7/ad2IYA6gcyNAa70yOp/hWPPpL4UVFMucxUEnZPn9tH7isG
         dTcqDgk2ykK/PHw3klbWxD+uvH4thSngFEfJ2A3N//O8crilB5h9nHcHJVaHTglGtYRN
         Uj8UL+yKdmYSJyPYkYbCMwnYunuGorFbMCGAkt65KQpW+IHKtwqlaUfxvzC/bZJLgUHf
         Ck7A==
X-Gm-Message-State: ACrzQf3Fw4/iPdO0JLAnLpZ3fA5a0Tni0ibD51HXFGhMvpYtA/20zlFr
        NqdjI712dpaFzsbA63TvVRtRkw==
X-Google-Smtp-Source: AMsMyM7TyqDnv1YbntPAADx/j/4AUEuR2qMr1YRP3T2ectcFiSVFXvKyzofQ/SX4dK8CYafJYWcHsA==
X-Received: by 2002:aa7:809a:0:b0:567:6e2c:2e2a with SMTP id v26-20020aa7809a000000b005676e2c2e2amr31896423pff.56.1667498518982;
        Thu, 03 Nov 2022 11:01:58 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:58 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, axelj <axelj@axis.com>
Subject: [PATCH v4 11/11] PM: hibernate: seal the encryption key with a PCR policy
Date:   Thu,  3 Nov 2022 11:01:19 -0700
Message-Id: <20221103105558.v4.11.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v4:
 - Local variable ordering (Jarkko)

Changes in v3:
 - Changed funky tag to Co-developed-by (Kees)

Changes in v2:
 - Fix sparse warnings
 - Fix session type comment (Andrey)
 - Eliminate extra label in get/create_kernel_key() (Andrey)
 - Call tpm_try_get_ops() before calling tpm2_flush_context().

 include/linux/tpm.h    |   4 +
 kernel/power/snapenc.c | 166 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 9c2ee3e30ffa5d..252a8a92a7ff5b 100644
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
index 2f421061498246..23f4d09ced578b 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -438,6 +438,111 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
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
@@ -492,11 +597,16 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 static int snapshot_create_kernel_key(struct snapshot_data *data)
 {
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
+	const char *keytemplate =
+		"new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000\tpolicydigest=%s";
 	const struct cred *cred = current_cred();
 	struct tpm_digest *digests = NULL;
+	char policy[SHA256_DIGEST_SIZE];
+	char *policydigest = NULL;
+	int session_handle = -1;
 	struct key *key = NULL;
 	struct tpm_chip *chip;
+	char *keyinfo = NULL;
 	int ret, i;
 
 	chip = tpm_default_chip();
@@ -529,6 +639,28 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
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
@@ -539,7 +671,7 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 		goto out;
 	}
 
-	ret = key_instantiate_and_link(key, keyinfo, sizeof(keyinfo), NULL,
+	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
 				       NULL);
 	if (ret != 0)
 		goto out;
@@ -553,7 +685,16 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
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
 	tpm2_pcr_reset(chip, 23);
 
 out_dev:
@@ -617,12 +758,13 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 				    struct uswsusp_key_blob *blob)
 {
 
-	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000000\tpolicyhandle=0x%x";
 	const struct cred *cred = current_cred();
 	struct trusted_key_payload *payload;
 	char certhash[SHA256_DIGEST_SIZE];
 	struct tpm_digest *digests = NULL;
 	char *blobstring = NULL;
+	int session_handle = -1;
 	struct key *key = NULL;
 	struct tpm_chip *chip;
 	char *keyinfo = NULL;
@@ -658,14 +800,21 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
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
@@ -748,6 +897,13 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
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
2.38.1.431.g37b22c650d-goog

