Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3004A320293
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBTBfB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBTBer (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:34:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BFC061A2A
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so8711613yba.18
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Le2xy86M2g7vFjnuX/RXj2Z9OeFij6CrkPXndbL+3YM=;
        b=mUmzPMLQ2EhM5ohqQmvRX3zzjTI4HWgSEU8OF6ChUOqqCnyRmUWuS7Fg85iVRVC6D0
         tlS1Qf9auwUtImh2HiRyyIF9zKTBlptAOolf0FoHdiiUmi0OW/MbiiVc5aFxLp0Ixvg1
         cFeCJz9zZMvDoZq8E4OJNEyCKW06WEsbbi1WGGYwxmWGValJTlOySL2JTQ+lyT9DZEcG
         H2uY8kjDRo7fTGbtIHU0o77/si0NRfV4D/hT8to4ifU0A4zu8NUO1F1mRowKzzBwornS
         TsK6HQUR5c3H2o4BOGqBx1XATTaJyYRtgg6nD/nS2R0cTSOvXH5a/+N4HO8Uwo08O0Ik
         vzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Le2xy86M2g7vFjnuX/RXj2Z9OeFij6CrkPXndbL+3YM=;
        b=SbqYx4eJGOpmnUWnrk4s1jJ1SNziKFxrkGKY67mS7s9ywwcLG+3ioxuQkZwWQvMDY8
         gIwlbrseWDkl421y15zUzUb5IX10vQCvD+2V0CtbiKiwK4yzcpjzCMJRuuaLAOoxzD7V
         zXKefaUtqGSgHQELla552Q4HjG+p4Y+gFHEgnQW02blobvLtuN35Zsu9XqTwGgY0J4oc
         WpCIDaj5TFSvwuFkXD6vdDiJvjVd93J2rEhTRycDzcEDCu7/qJdGFiY99iK/HwmBSk35
         eSHHSicrof13q8832GTSa1U35oYeUOm6K7c0DOIrqC8F+Lj4+qTGrxyqq6nem0lAuGKj
         kkKg==
X-Gm-Message-State: AOAM530mEXbugDVS3/KJw9vndheVRSW7ptYPV/2uoZ2bKNZEsVX3+N3m
        ou9lXMLK5b8R+NmMKGwGAM/HEnQGGSGs326DsM7Zbw==
X-Google-Smtp-Source: ABdhPJz+znzmydksCXNSz0qRUgqJOeUsiHxIZRQcS35YoWwljFjdXh5jNWJo2zOzCx4tGEmcAtw9+Y046tcbzA8xOA1QIg==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:a0c9:: with SMTP id
 i9mr15696415ybm.479.1613784799467; Fri, 19 Feb 2021 17:33:19 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:54 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 8/9] pm: hibernate: Verify the digest encryption key
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

We want to ensure that the key used to encrypt the digest was created by
the kernel during hibernation. To do this we request that the TPM include
information about the value of PCR 23 at the time of key creation in the
sealed blob. On resume, we can ask the TPM to certify that the creation
data is accurate and then make sure that the PCR information in the blob
corresponds to the expected value. Since only the kernel can touch PCR
23, if an attacker generates a key themselves the value of PCR 23 will
have been different, allowing us to reject the key and boot normally
instead of resuming.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/tpm.h |   1 +
 kernel/power/tpm.c  | 150 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e2075e2242a0..f6970986b097 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -216,6 +216,7 @@ enum tpm2_command_codes {
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
 	TPM2_CC_SHUTDOWN	        = 0x0145,
+	TPM2_CC_CERTIFYCREATION	        = 0x014A,
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
diff --git a/kernel/power/tpm.c b/kernel/power/tpm.c
index 953dcbdc56d8..34e6cfb98ce4 100644
--- a/kernel/power/tpm.c
+++ b/kernel/power/tpm.c
@@ -14,6 +14,12 @@ static struct tpm_digest digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* sha256(sha256(empty_pcr | digest)) */
+static char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
+	0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
+	0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
+	0xf3};
+
 struct skcipher_def {
 	struct scatterlist sg;
 	struct crypto_skcipher *tfm;
@@ -21,6 +27,39 @@ struct skcipher_def {
 	struct crypto_wait wait;
 };
 
+static int sha256_data(char *buf, int size, char *output)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc = kmalloc(sizeof(struct shash_desc) +
+			       crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret != 0) {
+		crypto_free_shash(tfm);
+		kfree(desc);
+		return ret;
+	}
+
+	crypto_shash_update(desc, buf, size);
+	crypto_shash_final(desc, output);
+	crypto_free_shash(desc->tfm);
+	kfree(desc);
+
+	return 0;
+}
+
 static int swsusp_enc_dec(struct trusted_key_payload *payload, char *buf,
 			  int enc)
 {
@@ -86,6 +125,58 @@ static int swsusp_enc_dec(struct trusted_key_payload *payload, char *buf,
 	return ret;
 }
 
+static int tpm_certify_creationdata(struct tpm_chip *chip,
+				    struct trusted_key_payload *payload)
+{
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CERTIFYCREATION);
+	if (rc)
+		return rc;
+
+	/* Use TPM_RH_NULL for signHandle */
+	tpm_buf_append_u32(&buf, 0x40000007);
+
+	/* Object handle */
+	tpm_buf_append_u32(&buf, payload->blob_handle);
+
+	/* Auth */
+	tpm_buf_append_u32(&buf, 9);
+	tpm_buf_append_u32(&buf, TPM2_RS_PW);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u8(&buf, 0);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Qualifying data */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Creation data hash */
+	tpm_buf_append_u16(&buf, payload->creation_hash_len);
+	tpm_buf_append(&buf, payload->creation_hash,
+		       payload->creation_hash_len);
+
+	/* signature scheme */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* creation ticket */
+	tpm_buf_append(&buf, payload->tk, payload->tk_len);
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+
+	if (head->return_code != 0)
+		rc = -EINVAL;
+out:
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 int swsusp_encrypt_digest(struct swsusp_header *header)
 {
 	const struct cred *cred = current_cred();
@@ -95,7 +186,7 @@ int swsusp_encrypt_digest(struct swsusp_header *header)
 	struct key *key;
 	int ret, i;
 
-	char *keyinfo = "new\t32\tkeyhandle=0x81000001";
+	char *keyinfo = "new\t32\tkeyhandle=0x81000001\tcreationpcrs=0x00800000";
 
 	chip = tpm_default_chip();
 
@@ -164,6 +255,7 @@ int swsusp_decrypt_digest(struct swsusp_header *header)
 	char *keytemplate = "load\t%s\tkeyhandle=0x81000001";
 	struct trusted_key_payload *payload;
 	struct tpm_digest *digests = NULL;
+	char certhash[SHA256_DIGEST_SIZE];
 	char *blobstring = NULL;
 	char *keyinfo = NULL;
 	struct tpm_chip *chip;
@@ -184,8 +276,10 @@ int swsusp_decrypt_digest(struct swsusp_header *header)
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
 			  GFP_KERNEL);
-	if (!digests)
+	if (!digests) {
+		ret = -ENOMEM;
 		goto reset;
+	}
 
 	for (i = 0; i <= chip->nr_allocated_banks; i++) {
 		digests[i].alg_id = chip->allocated_banks[i].alg_id;
@@ -227,8 +321,58 @@ int swsusp_decrypt_digest(struct swsusp_header *header)
 
 	payload = key->payload.data[0];
 
-	ret = swsusp_enc_dec(payload, header->digest, 0);
+	ret = sha256_data(payload->creation, payload->creation_len, certhash);
+	if (ret < 0)
+		goto out;
+
+	if (memcmp(payload->creation_hash, certhash, SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = tpm_certify_creationdata(chip, payload);
+	if (ret != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We now know that the creation data is authentic - parse it */
+
+	/* TPML_PCR_SELECTION.count */
+	if (be32_to_cpu(*(int *)payload->creation) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(u16 *)&payload->creation[4]) != TPM_ALG_SHA256) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (*(char *)&payload->creation[6] != 3) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* PCR 23 selected */
+	if (be32_to_cpu(*(int *)&payload->creation[6]) != 0x03000080) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (be16_to_cpu(*(u16 *)&payload->creation[10]) !=
+	    SHA256_DIGEST_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
 
+	if (memcmp(&payload->creation[12], expected_digest,
+		   SHA256_DIGEST_SIZE) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = swsusp_enc_dec(payload, header->digest, 0);
 out:
 	key_revoke(key);
 	key_put(key);
-- 
2.30.0.617.g56c4b15f3c-goog

