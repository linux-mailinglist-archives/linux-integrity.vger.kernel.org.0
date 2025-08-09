Return-Path: <linux-integrity+bounces-6795-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC66B1F599
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CB6561D07
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4A2BF3E0;
	Sat,  9 Aug 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEFsQm1D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D302BF3CF;
	Sat,  9 Aug 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760003; cv=none; b=Duph66no9qfO/wlPCT4qv0sQK1QBgTRevwXTo6RyqX+yoe69TK1jEs84f4doMX1PD7XeNY/py/o9Loxzrv8R6BveoMixKlVFTSPxyKSyo+GN6TXnP0hIAmbHgcK1evZ9rvTdsNcnb5jbYVG9hRo05YsFDEJVyYjb1jt34ckexFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760003; c=relaxed/simple;
	bh=id3V7RxYJTcnGfXIIJnRAXsAif9WQHqpKirnW70demk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVHcfwKRQ5343NCHRKVzAyrYA8mkUNsX63hJC55+4W1KpDykAcwJf6NNbzFSQa90SPTEyk0XM7Pia8u3EIREd4uvwjA7U/VMpgcBg543/IHH8jx6QhJ9eUPN5JajAizeqbRyCSCtmgQeYJub5Uc3qNDmk9bAp/uqZCyMQqWXBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEFsQm1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E0C4CEF9;
	Sat,  9 Aug 2025 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754760002;
	bh=id3V7RxYJTcnGfXIIJnRAXsAif9WQHqpKirnW70demk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEFsQm1Dxs/LicmbD+Mw2mU8Yhj2ZeGM8LcvXY7+SDGOdGcr+ksn7fM36JfiPcdcU
	 ZSFprGj6CA6tSszuZ1AZUU83i7RsHdbOpdvmX12zpKKSraa7mffbZ4yyAYE+yC3nu1
	 T7LJ5bh6144VAOb3PEmMhdBOHlc1ZU7rgPnoAMGBEcYY4rcv2+/szv09fdY8IGMZVS
	 88/SrlHwXu63PjGb9Hna8h77ht/LrDChlA/PRB9Ia55bzht14nKHsuyyKwubfs+b9t
	 2UD96+bGEoyz9HY/SIQ5yiHyajS8ddNkbuwOrjihsHhWqvpEwMWeO3434YqfbsQX3F
	 7hIigJlk+JAlw==
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 3/3] KEYS: trusted_tpm1: Move private functionality out of public header
Date: Sat,  9 Aug 2025 10:19:41 -0700
Message-ID: <20250809171941.5497-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809171941.5497-1-ebiggers@kernel.org>
References: <20250809171941.5497-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move functionality used only by trusted_tpm1.c out of the public header
<keys/trusted_tpm.h>.  Specifically, change the exported functions into
static functions, since they are not used outside trusted_tpm1.c, and
move various other definitions and inline functions to trusted_tpm1.c.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/keys/trusted_tpm.h                | 79 ----------------------
 security/keys/trusted-keys/trusted_tpm1.c | 80 ++++++++++++++++++++---
 2 files changed, 72 insertions(+), 87 deletions(-)

diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index a088b33fd0e3b..0fadc6a4f1663 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -3,94 +3,15 @@
 #define __TRUSTED_TPM_H
 
 #include <keys/trusted-type.h>
 #include <linux/tpm_command.h>
 
-/* implementation specific TPM constants */
-#define TPM_SIZE_OFFSET			2
-#define TPM_RETURN_OFFSET		6
-#define TPM_DATA_OFFSET			10
-
-#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
-#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
-#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
-
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
-struct osapsess {
-	uint32_t handle;
-	unsigned char secret[SHA1_DIGEST_SIZE];
-	unsigned char enonce[TPM_NONCE_SIZE];
-};
-
-/* discrete values, but have to store in uint16_t for TPM use */
-enum {
-	SEAL_keytype = 1,
-	SRK_keytype = 4
-};
-
-int TSS_authhmac(unsigned char *digest, const unsigned char *key,
-			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned int h3, ...);
-int TSS_checkhmac1(unsigned char *buffer,
-			  const uint32_t command,
-			  const unsigned char *ononce,
-			  const unsigned char *key,
-			  unsigned int keylen, ...);
-
-int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
-
 int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options);
 int tpm2_unseal_trusted(struct tpm_chip *chip,
 			struct trusted_key_payload *payload,
 			struct trusted_key_options *options);
 
-#define TPM_DEBUG 0
-
-#if TPM_DEBUG
-static inline void dump_options(struct trusted_key_options *o)
-{
-	pr_info("sealing key type %d\n", o->keytype);
-	pr_info("sealing key handle %0X\n", o->keyhandle);
-	pr_info("pcrlock %d\n", o->pcrlock);
-	pr_info("pcrinfo %d\n", o->pcrinfo_len);
-	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
-		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
-		       16, 1, &s->handle, 4, 0);
-	pr_info("secret:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
-	pr_info("trusted-key: enonce:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
-}
-
-static inline void dump_tpm_buf(unsigned char *buf)
-{
-	int len;
-
-	pr_info("\ntpm buffer\n");
-	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
-}
-#else
-static inline void dump_options(struct trusted_key_options *o)
-{
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-}
-
-static inline void dump_tpm_buf(unsigned char *buf)
-{
-}
-#endif
 #endif
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 126437459a74d..636acb66a4f69 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -22,10 +22,78 @@
 #include <keys/trusted_tpm.h>
 
 static struct tpm_chip *chip;
 static struct tpm_digest *digests;
 
+/* implementation specific TPM constants */
+#define TPM_SIZE_OFFSET			2
+#define TPM_RETURN_OFFSET		6
+#define TPM_DATA_OFFSET			10
+
+#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
+#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
+#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
+
+struct osapsess {
+	uint32_t handle;
+	unsigned char secret[SHA1_DIGEST_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+};
+
+/* discrete values, but have to store in uint16_t for TPM use */
+enum {
+	SEAL_keytype = 1,
+	SRK_keytype = 4
+};
+
+#define TPM_DEBUG 0
+
+#if TPM_DEBUG
+static inline void dump_options(struct trusted_key_options *o)
+{
+	pr_info("sealing key type %d\n", o->keytype);
+	pr_info("sealing key handle %0X\n", o->keyhandle);
+	pr_info("pcrlock %d\n", o->pcrlock);
+	pr_info("pcrinfo %d\n", o->pcrinfo_len);
+	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
+		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+}
+
+static inline void dump_sess(struct osapsess *s)
+{
+	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
+		       16, 1, &s->handle, 4, 0);
+	pr_info("secret:\n");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
+	pr_info("trusted-key: enonce:\n");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
+}
+
+static inline void dump_tpm_buf(unsigned char *buf)
+{
+	int len;
+
+	pr_info("\ntpm buffer\n");
+	len = LOAD32(buf, TPM_SIZE_OFFSET);
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
+}
+#else
+static inline void dump_options(struct trusted_key_options *o)
+{
+}
+
+static inline void dump_sess(struct osapsess *s)
+{
+}
+
+static inline void dump_tpm_buf(unsigned char *buf)
+{
+}
+#endif
+
 static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
 		       unsigned int keylen, ...)
 {
 	struct hmac_sha1_ctx hmac_ctx;
 	va_list argp;
@@ -54,11 +122,11 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
 }
 
 /*
  * calculate authorization info fields to send to TPM
  */
-int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
 			unsigned char *h2, unsigned int h3, ...)
 {
 	unsigned char paramdigest[SHA1_DIGEST_SIZE];
 	struct sha1_ctx sha_ctx;
@@ -92,16 +160,15 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
 				  paramdigest, TPM_NONCE_SIZE, h1,
 				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(TSS_authhmac);
 
 /*
  * verify the AUTH1_COMMAND (Seal) result from TPM
  */
-int TSS_checkhmac1(unsigned char *buffer,
+static int TSS_checkhmac1(unsigned char *buffer,
 			  const uint32_t command,
 			  const unsigned char *ononce,
 			  const unsigned char *key,
 			  unsigned int keylen, ...)
 {
@@ -157,11 +224,10 @@ int TSS_checkhmac1(unsigned char *buffer,
 
 	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
 		return -EINVAL;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(TSS_checkhmac1);
 
 /*
  * verify the AUTH2_COMMAND (unseal) result from TPM
  */
 static int TSS_checkhmac2(unsigned char *buffer,
@@ -242,11 +308,11 @@ static int TSS_checkhmac2(unsigned char *buffer,
 
 /*
  * For key specific tpm requests, we will generate and send our
  * own TPM command packets using the drivers send function.
  */
-int trusted_tpm_send(unsigned char *cmd, size_t buflen)
+static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
 	struct tpm_buf buf;
 	int rc;
 
 	if (!chip)
@@ -268,11 +334,10 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 		rc = -EPERM;
 
 	tpm_put_ops(chip);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(trusted_tpm_send);
 
 /*
  * Lock a trusted key, by extending a selected PCR.
  *
  * Prevents a trusted key that is sealed to PCRs from being accessed.
@@ -322,11 +387,11 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 }
 
 /*
  * Create an object independent authorisation protocol (oiap) session
  */
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
+static int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
 	if (!chip)
 		return -ENODEV;
@@ -339,11 +404,10 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 	*handle = LOAD32(tb->data, TPM_DATA_OFFSET);
 	memcpy(nonce, &tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)],
 	       TPM_NONCE_SIZE);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(oiap);
 
 struct tpm_digests {
 	unsigned char encauth[SHA1_DIGEST_SIZE];
 	unsigned char pubauth[SHA1_DIGEST_SIZE];
 	unsigned char xorwork[SHA1_DIGEST_SIZE * 2];
-- 
2.50.1


