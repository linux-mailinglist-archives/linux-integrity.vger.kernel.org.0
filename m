Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BE267B99
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILRbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 13:31:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55074 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgILRbI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 13:31:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7832F8EE0E2;
        Sat, 12 Sep 2020 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599931868;
        bh=DTofm+BJJFi59mTghseaTGq0nbL/Ik10Mlgo69EyJ4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFGU6kjMwlQs357IBxW+SzsE4iDUXsMus5VYEQxwSOPyUSixGRB1YnIT23LGwpMxj
         r1+ZiyDh/CeZ5MYaVDVpQdnuyUVJKHx0FeGfnBROok1BzDuHC1iAdmLX/qjHxB1FW0
         1YayyHgJjWG658X5r9YJSlbcAnGdjB6WOxMrKOvo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s3DY42qMxzz6; Sat, 12 Sep 2020 10:31:08 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 01D0E8EE07B;
        Sat, 12 Sep 2020 10:31:07 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v11 5/5] security: keys: trusted: Make sealed key properly interoperable
Date:   Sat, 12 Sep 2020 10:26:43 -0700
Message-Id: <20200912172643.9063-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
References: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

v2: added length checks to untrusted payload
v8: recover patch
---
 include/linux/tpm.h                       |  2 +
 security/keys/trusted-keys/trusted_tpm2.c | 53 ++++++++++++++++-------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index ae2482510f8c..35224860fd0c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -305,6 +305,8 @@ struct tpm_buf {
 };
 
 enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
 	TPM2_OA_USER_WITH_AUTH		= BIT(6),
 };
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e8dcc47b3388..905c5ca4d51c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -231,6 +231,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	unsigned int blob_len;
 	struct tpm_buf buf;
 	u32 hash;
+	u32 flags;
 	int i;
 	int rc;
 
@@ -259,31 +260,32 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);
+	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len);
 
 	tpm_buf_append_u16(&buf, options->blobauth_len);
 	if (options->blobauth_len)
 		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 
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
@@ -356,8 +358,9 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob;
+	u8 *blob, *pub;
 	int rc;
+	u32 attrs;
 
 	rc = tpm2_key_decode(payload, options, &blob);
 	if (rc) {
@@ -384,6 +387,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (private_len + 2 + public_len + 2 > payload->blob_len)
 		return -E2BIG;
 
+	pub = blob + 2 + private_len + 2;
+	/* key attributes are always at offset 4 */
+	attrs = get_unaligned_be32(pub + 4);
+
+	if ((attrs & (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT)) ==
+	    (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT))
+		payload->migratable = 0;
+	else
+		payload->migratable = 1;
+
 	blob_len = private_len + public_len + 4;
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
@@ -464,7 +477,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
 			rc = -EFAULT;
 			goto out;
 		}
@@ -475,9 +488,19 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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
2.26.2

