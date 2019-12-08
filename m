Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C078116076
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Dec 2019 06:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfLHFLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Dec 2019 00:11:30 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58038 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfLHFL3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Dec 2019 00:11:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A2E738EE111;
        Sat,  7 Dec 2019 21:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781889;
        bh=6P7ulO5kUsgANrqJX1Zkal2IAEF/3e1/uo3ekquTFIc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ViEeZXV27vC3GT3MLyFGdw3Sod/ik32VKF5/rTvDKW7zfPA2AVGE80ABh6s4dDXD+
         xOjxnfX+OzX7g9s+lojAv/kE3Eaw892TgUs74qj3JXJaJAM3jpq0/9R2OyFJEBCUEF
         6wCAPLTZDwmXiqga8RqjXtFhEAoBl0/ZAbSUAjS0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JlHvqPh5zn16; Sat,  7 Dec 2019 21:11:29 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 325CB8EE109;
        Sat,  7 Dec 2019 21:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781889;
        bh=6P7ulO5kUsgANrqJX1Zkal2IAEF/3e1/uo3ekquTFIc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ViEeZXV27vC3GT3MLyFGdw3Sod/ik32VKF5/rTvDKW7zfPA2AVGE80ABh6s4dDXD+
         xOjxnfX+OzX7g9s+lojAv/kE3Eaw892TgUs74qj3JXJaJAM3jpq0/9R2OyFJEBCUEF
         6wCAPLTZDwmXiqga8RqjXtFhEAoBl0/ZAbSUAjS0=
Message-ID: <1575781888.14069.14.camel@HansenPartnership.com>
Subject: [PATCH 5/8] security: keys: trusted: Make sealed key properly
 interoperable
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 07 Dec 2019 21:11:28 -0800
In-Reply-To: <1575781600.14069.8.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current implementation appends a migratable flag to the end of a
key, meaning the format isn't exactly interoperable because the using
party needs to know to strip this extra byte.  However, all other
consumers of TPM sealed blobs expect the unseal to return exactly the
key.  Since TPM2 keys have a key property flag that corresponds to
migratable, use that flag instead and make the actual key the only
sealed quantity.  This is secure because the key properties are bound
to a hash in the private part, so if they're altered the key won't
load.

Backwards compatibility is implemented by detecting whether we're
loading a new format key or not and correctly setting migratable from
the last byte of old format keys.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/keys/trusted-type.h               |  1 +
 include/linux/tpm.h                       |  2 ++
 security/keys/trusted-keys/trusted_tpm2.c | 57 ++++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a61d8f..4728e13aada8 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,6 +22,7 @@ struct trusted_key_payload {
 	unsigned int key_len;
 	unsigned int blob_len;
 	unsigned char migratable;
+	unsigned char old_format;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 03e9b184411b..cd46ab27baa5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -297,6 +297,8 @@ struct tpm_buf {
 };
 
 enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
 	TPM2_OA_USER_WITH_AUTH		= BIT(6),
 };
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 4efc7b64d1cd..a34ab6f90f76 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -207,6 +207,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	unsigned int blob_len;
 	struct tpm_buf buf;
 	u32 hash;
+	u32 flags;
 	int i;
 	int rc;
 
@@ -235,29 +236,30 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len);
 
 	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
 	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
-	tpm_buf_append_u16(&buf, payload->key_len + 1);
+	tpm_buf_append_u16(&buf, payload->key_len);
 	tpm_buf_append(&buf, payload->key, payload->key_len);
-	tpm_buf_append_u8(&buf, payload->migratable);
 
 	/* public */
 	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
 	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
 	tpm_buf_append_u16(&buf, hash);
 
+	/* key properties */
+	flags = 0;
+	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
+	flags |= payload->migratable ? (TPM2_OA_FIXED_TPM |
+					TPM2_OA_FIXED_PARENT) : 0;
+	tpm_buf_append_u32(&buf, flags);
+
 	/* policy */
-	if (options->policydigest_len) {
-		tpm_buf_append_u32(&buf, 0);
-		tpm_buf_append_u16(&buf, options->policydigest_len);
+	tpm_buf_append_u16(&buf, options->policydigest_len);
+	if (options->policydigest_len)
 		tpm_buf_append(&buf, options->policydigest,
 			       options->policydigest_len);
-	} else {
-		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
-		tpm_buf_append_u16(&buf, 0);
-	}
 
 	/* public parameters */
 	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
@@ -330,13 +332,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob;
+	u8 *blob, *pub;
 	int rc;
+	u32 attrs;
 
 	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc)
+	if (rc) {
 		/* old form */
 		blob = payload->blob;
+		payload->old_format = 1;
+	}
 
 	/* new format carries keyhandle but old format doesn't */
 	if (!options->keyhandle)
@@ -347,6 +352,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return -E2BIG;
 
 	public_len = be16_to_cpup((__be16 *) &blob[2 + private_len]);
+
+	pub = blob + 2 + private_len + 2;
+	/* key attributes are always at offset 4 */
+	attrs = get_unaligned_be32(pub + 4);
+	if ((attrs & (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT)) ==
+	    (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT))
+		payload->migratable = 0;
+	else
+		payload->migratable = 1;
+
 	blob_len = private_len + public_len + 4;
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
@@ -427,7 +442,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
 			rc = -EFAULT;
 			goto out;
 		}
@@ -438,9 +453,19 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		}
 		data = &buf.data[TPM_HEADER_SIZE + 6];
 
-		memcpy(payload->key, data, data_len - 1);
-		payload->key_len = data_len - 1;
-		payload->migratable = data[data_len - 1];
+		if (payload->old_format) {
+			/* migratable flag is at the end of the key */
+			memcpy(payload->key, data, data_len - 1);
+			payload->key_len = data_len - 1;
+			payload->migratable = data[data_len - 1];
+		} else {
+			/*
+			 * migratable flag already collected from key
+			 * attributes
+			 */
+			memcpy(payload->key, data, data_len);
+			payload->key_len = data_len;
+		}
 	}
 
 out:
-- 
2.16.4

