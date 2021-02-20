Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47B320296
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBTBfQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBTBfF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:35:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD812C061A30
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 194so8794103ybl.5
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AHjbHsJdHsjDWlT0meS/7wKVqgJA5qMsPwUMgz7CTrY=;
        b=DPjRo4j75pe5NPWUZw2PULq38PKScJgLe5C694z+Od25e1mgQhQ+0ZXITV67hlasB7
         BHs9xe+ceb9RhAHRmdX19BKDLmd5FIXfgd8HemfRm4tTBBBAbKdirqtCV3bLbCZ6fMgH
         Fx4DgvBfX2gig6RPjueqXD+IlBOr8gwiqtvTUgGre0W6u7Vgp1DYhkYrStASE96rNlLp
         1+kNlWDHPnwUYBF4nGUn+mChnYkhsFYkxPUUGh4bK1qbtcGhqDDiGUFIPRRT2WDqRi4T
         MtI3kHh6oBvhW7sOheb/oGp2WKxKuMWh9Rk58TkctHC7Apr/uCRNteVL4cLuYcZAVg/H
         126Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AHjbHsJdHsjDWlT0meS/7wKVqgJA5qMsPwUMgz7CTrY=;
        b=JL41lboZg60lw7FIdtQKdTWpAlp4zmSimOEV+tRHwRu705CpOMkbFVBch+WtboXixd
         PQNbf/Z1Kg76b60fyCPnKW9Q4pAp0RB0pLfy2qlCo32f+WzqWBHVQl3QLWR4C8Q3hZNw
         b1kGSE+mLUIZGGV6iZpLv54BfRimXAHiFtUcWlYR9OJrIeEGsWeYuatbjoMLM/inSC0J
         qQBn9YNB8c5C0yBPI1XEW9OAKrOdpO1FrwxLpLZS1IrLd+ZEdiP74gGRlonfPRagOgdH
         32si+Q4hrTyC9L6dSYfl6YUpklSaalGodXXJWxsTGVixHIVG1jzSfaid1F3ixKmeRKCH
         EzqA==
X-Gm-Message-State: AOAM532FG+wITsefhb3QEHvgQew6g23Lumq9MdyRVMMepcxinx2C2FbG
        dEa2iU8ioZfOsFjf7bP0MCRffpP8IR8MT77d8D7gyw==
X-Google-Smtp-Source: ABdhPJzDmDLe4ZPw7iSJPXc33ot7QHjnB/KrkLLd5Ij4DEcK/c6DsPaOS9aOJK39H4e6EnR2yDtA16zvqnpOF8cRLY0/9Q==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:4112:: with SMTP id
 o18mr17366423yba.222.1613784801141; Fri, 19 Feb 2021 17:33:21 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:55 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 9/9] pm: hibernate: seal the encryption key with a PCR policy
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The key blob is not secret, and by default the TPM will happily unseal
it regardless of system state. We can protect against that by sealing
the secret with a PCR policy - if the current PCR state doesn't match,
the TPM will refuse to release the secret. For now let's just seal it to
PCR 23. In the long term we may want a more flexible policy around this,
such as including PCR 7.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/tpm.h |   4 ++
 kernel/power/tpm.c  | 161 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index f6970986b097..2e0141978c87 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -225,18 +225,22 @@ enum tpm2_command_codes {
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
+	TPM2_RH_NULL            = 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
diff --git a/kernel/power/tpm.c b/kernel/power/tpm.c
index 34e6cfb98ce4..5de27c2f08be 100644
--- a/kernel/power/tpm.c
+++ b/kernel/power/tpm.c
@@ -125,6 +125,118 @@ static int swsusp_enc_dec(struct trusted_key_payload *payload, char *buf,
 	return ret;
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
+
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+
+	if (be32_to_cpu(head->length) != sizeof(struct tpm_header) +
+	    sizeof(int) + sizeof(u16) + sizeof(nonce)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*session_handle = be32_to_cpu(*(int *)&buf.data[10]);
+	memcpy(nonce, &buf.data[16], sizeof(nonce));
+
+	tpm_buf_destroy(&buf);
+
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
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+
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
+
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
+out:
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 static int tpm_certify_creationdata(struct tpm_chip *chip,
 				    struct trusted_key_payload *payload)
 {
@@ -182,11 +294,14 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 	const struct cred *cred = current_cred();
 	struct trusted_key_payload *payload;
 	struct tpm_digest *digests = NULL;
+	char policy[SHA256_DIGEST_SIZE];
+	char *policydigest = NULL;
 	struct tpm_chip *chip;
 	struct key *key;
+	int session_handle;
 	int ret, i;
-
-	char *keyinfo = "new\t32\tkeyhandle=0x81000001\tcreationpcrs=0x00800000";
+	char *keyinfo = NULL;
+	char *keytemplate = "new\t32\tkeyhandle=0x81000001\tcreationpcrs=0x00800000\tpolicydigest=%s";
 
 	chip = tpm_default_chip();
 
@@ -213,10 +328,35 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 			memcpy(&digests[i], &digest, sizeof(digest));
 	}
 
+	policydigest = kmalloc(SHA256_DIGEST_SIZE * 2 + 1, GFP_KERNEL);
+	if (!policydigest) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
 	ret = tpm_pcr_extend(chip, 23, digests);
 	if (ret != 0)
 		goto reset;
 
+	ret = tpm_setup_policy(chip, &session_handle);
+
+	if (ret != 0)
+		goto reset;
+
+	ret = tpm_policy_get_digest(chip, session_handle, policy);
+
+	if (ret != 0)
+		goto reset;
+
+	bin2hex(policydigest, policy, SHA256_DIGEST_SIZE);
+	policydigest[64] = '\0';
+
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, policydigest);
+	if (!keyinfo) {
+		ret = -ENOMEM;
+		goto reset;
+	}
+
 	key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
 			GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
 			NULL);
@@ -228,6 +368,7 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 
 	ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
 				       NULL);
+
 	if (ret < 0)
 		goto error;
 
@@ -244,6 +385,8 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 	key_revoke(key);
 	key_put(key);
 reset:
+	kfree(keyinfo);
+	kfree(policydigest);
 	kfree(digests);
 	tpm_pcr_reset(chip, 23);
 	return ret;
@@ -252,13 +395,14 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 int swsusp_decrypt_digest(struct swsusp_header *header)
 {
 	const struct cred *cred = current_cred();
-	char *keytemplate = "load\t%s\tkeyhandle=0x81000001";
+	char *keytemplate = "load\t%s\tkeyhandle=0x81000001\tpolicyhandle=0x%x";
 	struct trusted_key_payload *payload;
 	struct tpm_digest *digests = NULL;
 	char certhash[SHA256_DIGEST_SIZE];
 	char *blobstring = NULL;
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
+	int session_handle;
 	struct key *key;
 	int i, ret;
 
@@ -291,15 +435,22 @@ int swsusp_decrypt_digest(struct swsusp_header *header)
 	if (ret != 0)
 		goto reset;
 
-	blobstring = kmalloc(header->blob_len * 2, GFP_KERNEL);
+	ret = tpm_setup_policy(chip, &session_handle);
+
+	if (ret != 0)
+		goto reset;
+
+	blobstring = kmalloc(header->blob_len * 2 + 1, GFP_KERNEL);
 	if (!blobstring) {
 		ret = -ENOMEM;
 		goto reset;
 	}
 
 	bin2hex(blobstring, header->blob, header->blob_len);
+	blobstring[header->blob_len * 2] = '\0';
 
-	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
+	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring,
+			    session_handle);
 	if (!keyinfo) {
 		ret = -ENOMEM;
 		goto reset;
-- 
2.30.0.617.g56c4b15f3c-goog

