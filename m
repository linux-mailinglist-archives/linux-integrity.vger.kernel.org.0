Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1C123FB4
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 07:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfLRGh1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 01:37:27 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42636 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLRGh1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 01:37:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 21B088EE193;
        Tue, 17 Dec 2019 22:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576651047;
        bh=i28LmYkA01BOUs5IMbQLN6R5ef/jnBcB3tiVRSK8BQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWM8n/FtJtLHIxfX4zKJZCSSvmYp6tK2tGU670o6QshC1rbrXqJsBvmcymTaxxCPz
         s1ISTKC4Zu3FDVggHvKN2T5S2F7rABPqVdNLAFQmNfsE5oKm2F2I57YMPQqfNvWzxj
         ass3ES//OtjSuw0oWGv1zA5SWSmf+DV0Yi/3dGDE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SCOoZhgqo9_C; Tue, 17 Dec 2019 22:37:27 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 035968EE0DF;
        Tue, 17 Dec 2019 22:37:25 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v3 4/9] security: keys: trusted: Make sealed key properly interoperable
Date:   Wed, 18 Dec 2019 15:31:37 +0900
Message-Id: <20191218063142.23033-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
References: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
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

v2: added length checks to untrusted payload
---
 include/keys/trusted-type.h               |  1 +
 include/linux/tpm.h                       |  2 +
 security/keys/trusted-keys/trusted_tpm2.c | 76 ++++++++++++++++++++++---------
 3 files changed, 57 insertions(+), 22 deletions(-)

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
index cf10fea5410a..de83f43d2f7a 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -61,16 +61,17 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			return 0;
 		asn1_encode_tag(&work, &work_len, 0, bool, w - bool);
 	}
-	asn1_encode_integer(&work, &work_len, options->keyhandle);
 	/*
 	 * Assume both octet strings will encode to a 2 byte definite length
 	 *
 	 * Note: For a well behaved TPM, this warning should never
 	 * trigger, so if it does there's something nefarious going on
 	 */
-	if (WARN(work - scratch + pub_len + priv_len + 8 > SCRATCH_SIZE,
+	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
 		 "BUG: scratch buffer is too small"))
-		return 0;
+		return -EINVAL;
+
+	asn1_encode_integer(&work, &work_len, options->keyhandle);
 	asn1_encode_octet_string(&work, &work_len, pub, pub_len);
 	asn1_encode_octet_string(&work, &work_len, priv, priv_len);
 
@@ -226,6 +227,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	unsigned int blob_len;
 	struct tpm_buf buf;
 	u32 hash;
+	u32 flags;
 	int i;
 	int rc;
 
@@ -254,29 +256,30 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -349,23 +352,42 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
 		return -EINVAL;
 
-	private_len = be16_to_cpup((__be16 *) &blob[0]);
-	if (private_len > (payload->blob_len - 2))
+	/* must be big enough for at least the two be16 size counts */
+	if (payload->blob_len < 4)
+		return -EINVAL;
+	private_len = get_unaligned_be16(blob);
+	/* must be big enough for following public_len */
+	if (private_len + 2 + 2 > (payload->blob_len))
 		return -E2BIG;
 
-	public_len = be16_to_cpup((__be16 *) &blob[2 + private_len]);
+	public_len = get_unaligned_be16(blob + 2 + private_len);
+	if (private_len + 2 + public_len + 2 > payload->blob_len)
+		return -E2BIG;
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
@@ -446,7 +468,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
 			rc = -EFAULT;
 			goto out;
 		}
@@ -457,9 +479,19 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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

