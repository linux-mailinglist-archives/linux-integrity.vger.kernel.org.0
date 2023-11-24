Return-Path: <linux-integrity+bounces-211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA387F6A78
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 03:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB366B20FF1
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D1A50;
	Fri, 24 Nov 2023 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL2VJivG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A480C
	for <linux-integrity@vger.kernel.org>; Fri, 24 Nov 2023 02:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E88C433C7;
	Fri, 24 Nov 2023 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700791386;
	bh=gVS4iV57gyVIucD1cw7+E+uIf+FtO/Y9r3lFNTxhJg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL2VJivGYgezuXCNa+2mvkNx9oMiHZzoaHR7/jk0ojup/NFowjNT5EfWXJAZn5Pxc
	 wpatcIsU5cMZgBf+v1zA0Yx/WN3MJaDqBmWJRGNBdmWMtEdPBf91Hiq70gHtGUzhOr
	 6Zpi8s/wmGfitAJ7gVWZAOdlRuOsBxFHZgShlxTMHX1zOBvl0vvY8UG+oqqtcukuPN
	 1cF4yhzGoLItMGTCuI5jX7sNYqUIg22C/8ju1UQ3nmYoCUvrLSWT0U52VbI9rH3HKx
	 5je2AfTK11DsL+9mUp8Sthmr9kLwkyjEkicPOXIIVFIZIwHhTbTk4mXdHb2IyJoP7o
	 OuGnAVQJy8SlQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v6 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
Date: Fri, 24 Nov 2023 04:02:37 +0200
Message-ID: <20231124020237.27116-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124020237.27116-1-jarkko@kernel.org>
References: <20231124020237.27116-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take advantage of the new sized buffer (TPM2B) mode of struct tpm_buf in
tpm2_seal_trusted(). This allows to add robustness to the command
construction without requiring to calculate buffer sizes manually.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3 [2023-11-21]: A boundary error check as response for the feeedback
from Mario Limenciello:
https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
v2: Use tpm_buf_read_*
---
 security/keys/trusted-keys/trusted_tpm2.c | 54 +++++++++++++----------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index bc700f85f80b..97b1dfca2dba 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	off_t offset = TPM_HEADER_SIZE;
+	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
 	int i;
@@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		return rc;
 	}
 
+	rc = tpm_buf_init_sized(&sized);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm_put_ops(chip);
+		return rc;
+	}
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
 			     NULL /* nonce */, 0,
@@ -266,36 +275,36 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len);
+	tpm_buf_append_u16(&sized, options->blobauth_len);
 
-	tpm_buf_append_u16(&buf, options->blobauth_len);
 	if (options->blobauth_len)
-		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
+		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
 
-	tpm_buf_append_u16(&buf, payload->key_len);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
+	tpm_buf_append_u16(&sized, payload->key_len);
+	tpm_buf_append(&sized, payload->key, payload->key_len);
+	tpm_buf_append(&buf, sized.data, sized.length);
 
 	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
+	tpm_buf_reset_sized(&sized);
+	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&sized, hash);
 
 	/* key properties */
 	flags = 0;
 	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
-	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
-					    TPM2_OA_FIXED_PARENT);
-	tpm_buf_append_u32(&buf, flags);
+	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
+	tpm_buf_append_u32(&sized, flags);
 
 	/* policy */
-	tpm_buf_append_u16(&buf, options->policydigest_len);
+	tpm_buf_append_u16(&sized, options->policydigest_len);
 	if (options->policydigest_len)
-		tpm_buf_append(&buf, options->policydigest,
-			       options->policydigest_len);
+		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
+	tpm_buf_append_u16(&sized, 0);
+
+	tpm_buf_append(&buf, sized.data, sized.length);
 
 	/* outside info */
 	tpm_buf_append_u16(&buf, 0);
@@ -312,21 +321,20 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		goto out;
 
-	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
-	if (blob_len > MAX_BLOB_SIZE) {
+	blob_len = tpm_buf_read_u32(&buf, &offset);
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
 		rc = -E2BIG;
 		goto out;
 	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+	if (buf.length - offset < blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options,
-				   &buf.data[TPM_HEADER_SIZE + 4],
-				   blob_len);
+	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
 
 out:
+	tpm_buf_destroy(&sized);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
-- 
2.43.0


