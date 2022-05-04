Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35751B417
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiEEAB2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385523AbiEDXZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD24DF4A
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x52so2281154pfu.11
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZes23V8D29o9o+3/8Wg3E/cTc0rQTuNxnYi5rLsric=;
        b=XrelHwAQ5nZclhDVNUhijM04rz+AIMdWor66LM+U6mT7FdbzNPxCB1jEHkolFtO4pA
         MhjNNy3YXQuvcea24SJHqpTqMomdy1jVehXiIhPxQ32FHx6DMgjDu5+wKs0EavqHS1ao
         4OTz4nqw6vO7eIYGX95TlNSpXeIVZrvpANGY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZes23V8D29o9o+3/8Wg3E/cTc0rQTuNxnYi5rLsric=;
        b=rK/JKWw1LnTNgtjc133CmpMpwGJYNYSE2JYkhSxbUvWTeiSjt/pvuYIIdEpO+nZEJH
         U/HLWDr1wEVTvQUTY5u1pIjbaqqohIDQSPTUJ87eU/8APcuCU+FrrGRvhjiABUSrOVNO
         zBLKBNFqnI+FpAvJ9gNUIWKWyzxZL/Uv/O8BsimAUSW/XOlf2yvh0jsbuzjXtD06CnzS
         d9nwTeg4m1AaPr2TCBDBTJnCngxgjmYfaiq1/KQpI4nn7Qze1DiO+8rf8gb23MDuYT6i
         4jyrm94Ockuqza7tvg623Vmk2SfCKrw911BDzmnhOpO5/qR5EZzbHBAQfnIPmfJlpocg
         u6Xw==
X-Gm-Message-State: AOAM531PIK1RMg/yc1MXc1f8tVyv/BqEbqwhIeduK2xbn9DomuxWpw5a
        ZxsR7AoIGvi8QnemdxFTW175Yg==
X-Google-Smtp-Source: ABdhPJxkwEzrHWGeAldGbUw4MtrMMRq8pNSoFW6ViiQ7UOM/5tnP8ce/RBsuczT6aEuLXMgf7vqdQA==
X-Received: by 2002:a63:91c4:0:b0:3c1:d47f:1a4c with SMTP id l187-20020a6391c4000000b003c1d47f1a4cmr18349062pge.396.1651706511488;
        Wed, 04 May 2022 16:21:51 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:51 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>, Hao Wu <hao.wu@rubrik.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>, axelj <axelj@axis.com>
Subject: [PATCH 10/10] PM: hibernate: seal the encryption key with a PCR policy
Date:   Wed,  4 May 2022 16:21:02 -0700
Message-Id: <20220504161439.10.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
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

The key blob is not secret, and by default the TPM will happily unseal
it regardless of system state. We can protect against that by sealing
the secret with a PCR policy - if the current PCR state doesn't match,
the TPM will refuse to release the secret. For now let's just seal it to
PCR 23. In the long term we may want a more flexible policy around this,
such as including PCR 7 for PCs or 0 for Chrome OS.

Sourced-from: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
---
The original version of this patch is here:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-10-matthewgarrett@google.com/

 include/linux/tpm.h    |   4 +
 kernel/power/snapenc.c | 163 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 160 insertions(+), 7 deletions(-)

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
index 38bc820f780d8b..9d140c62b49db1 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -495,6 +495,111 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
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
+	/* Policy type - session */
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
+	    sizeof(int) + sizeof(u16) + sizeof(nonce)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*session_handle = be32_to_cpu(*(int *)&buf.data[10]);
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
@@ -554,7 +659,11 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	struct key *key;
 	int ret, i;
 	/* Create a key sealed by the SRK. */
-	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
+	char *keyinfo = NULL;
+	const char *keytemplate = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000\tpolicydigest=%s";
+	char policy[SHA256_DIGEST_SIZE];
+	char *policydigest = NULL;
+	int session_handle = -1;
 
 	chip = tpm_default_chip();
 	if (!chip)
@@ -584,13 +693,35 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 	if (ret != 0)
 		goto reset;
 
+	policydigest = kmalloc(SHA256_DIGEST_SIZE * 2 + 1, GFP_KERNEL);
+	if (!policydigest) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
+	ret = tpm_setup_policy(chip, &session_handle);
+	if (ret != 0)
+		goto reset;
+
+	ret = tpm_policy_get_digest(chip, session_handle, policy);
+	if (ret != 0)
+		goto flush;
+
+	bin2hex(policydigest, policy, SHA256_DIGEST_SIZE);
+	policydigest[SHA256_DIGEST_SIZE * 2] = '\0';
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, policydigest);
+	if (!keyinfo) {
+		ret = -ENOMEM;
+		goto flush;
+	}
+
 	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
 			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
 			NULL);
 
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
-		goto reset;
+		goto flush;
 	}
 
 	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
@@ -606,8 +737,14 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
 		key_revoke(key);
 		key_put(key);
 	}
+
+flush:
+	tpm2_flush_context(chip, session_handle);
+
 reset:
 	kfree(digests);
+	kfree(keyinfo);
+	kfree(policydigest);
 	tpm_pcr_reset(chip, 23);
 	return ret;
 }
@@ -669,13 +806,14 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 
 	char certhash[SHA256_DIGEST_SIZE];
 	const struct cred *cred = current_cred();
-	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000000\tpolicyhandle=0x%x";
 	struct tpm_digest *digests = NULL;
 	char *blobstring = NULL;
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
 	struct key *key;
 	struct trusted_key_payload *payload;
+	int session_handle = -1;
 	int i, ret;
 
 	chip = tpm_default_chip();
@@ -706,17 +844,24 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 	if (ret != 0)
 		goto reset;
 
-	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
+	ret = tpm_setup_policy(chip, &session_handle);
+	if (ret != 0)
+		goto reset;
+
+	blobstring = kmalloc(blob->blob_len * 2 + 1, GFP_KERNEL);
 	if (!blobstring) {
 		ret = -ENOMEM;
-		goto reset;
+		goto flush;
 	}
 
 	bin2hex(blobstring, blob->blob, blob->blob_len);
-	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
+	blobstring[blob->blob_len * 2] = '\0';
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring,
+			    session_handle);
+
 	if (!keyinfo) {
 		ret = -ENOMEM;
-		goto reset;
+		goto flush;
 	}
 
 	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
@@ -790,6 +935,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
 		key_revoke(key);
 		key_put(key);
 	}
+
+flush:
+	tpm2_flush_context(chip, session_handle);
+
 reset:
 	kfree(keyinfo);
 	kfree(blobstring);
-- 
2.31.0

