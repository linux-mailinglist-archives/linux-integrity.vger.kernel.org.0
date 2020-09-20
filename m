Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217B92715F9
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgITQgu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:36:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42272 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITQgt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:36:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8FA628EE1C3;
        Sun, 20 Sep 2020 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600619809;
        bh=5qMJaCGlIzYv7EjWhEvh5984WXVQcvU2H0n+aofto0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FesnUni4vlBhNZGRcKzkgBy+08lsKubi8NDvrfWR6IW2CmkxBWF+prAsNthw53rgh
         cWMa7s6oDo4rJHlB1tAAPZ2CUsymmOiIGB0tELYzOZVlZDQStqZm8QqsgRTXrP4GY2
         nZfDKW7vtmtWvUPyMKe1b4nME2hFIZg+UP84985w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZuFHmkyo1n_f; Sun, 20 Sep 2020 09:36:49 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0DF4A8EE107;
        Sun, 20 Sep 2020 09:36:49 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v12 4/5] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Date:   Sun, 20 Sep 2020 09:33:50 -0700
Message-Id: <20200920163351.11293-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920163351.11293-1-James.Bottomley@HansenPartnership.com>
References: <20200920163351.11293-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Modify the TPM2 key format blob output to export and import in the
ASN.1 form for TPM2 sealed object keys.  For compatibility with prior
trusted keys, the importer will also accept two TPM2B quantities
representing the public and private parts of the key.  However, the
export via keyctl pipe will only output the ASN.1 format.

The benefit of the ASN.1 format is that it's a standard and thus the
exported key can be used by userspace tools (openssl_tpm2_engine,
openconnect and tpm2-tss-engine).  The format includes policy
specifications, thus it gets us out of having to construct policy
handles in userspace and the format includes the parent meaning you
don't have to keep passing it in each time.

This patch only implements basic handling for the ASN.1 format, so
keys with passwords but no policy.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: Updated encode API, added length checks
v5: correct export format after doing interoperability checks
v7: use prefix tpm2_key_ instead of tpmkey_ for functions
v8: resplit commit
v9: select ASN1_ENCODER
v11: add ASN.1 format description
---
 .../security/keys/trusted-encrypted.rst       |  58 +++++
 include/keys/trusted-type.h                   |   1 +
 security/keys/Kconfig                         |   1 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2key.asn1       |  11 +
 security/keys/trusted-keys/trusted_tpm1.c     |   2 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 207 +++++++++++++++++-
 7 files changed, 274 insertions(+), 8 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9483a7425ad5..eb639bb24fcc 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -208,3 +208,61 @@ about the usage can be found in the file
 Another new format 'enc32' has been defined in order to support encrypted keys
 with payload size of 32 bytes. This will initially be used for nvdimm security
 but may expand to other usages that require 32 bytes payload.
+
+
+TPM 2.0 ASN.1 Key Format
+------------------------
+
+The TPM 2.0 ASN.1 key format is designed to be easily recognisable,
+even in binary form (fixing a problem we had with the TPM 1.2 ASN.1
+format) and to be extensible for additions like importable keys and
+policy::
+
+    TPMKey ::= SEQUENCE {
+        type		OBJECT IDENTIFIER
+        emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL
+        parent		INTEGER
+        pubkey		OCTET STRING
+        privkey		OCTET STRING
+    }
+
+type is what distinguishes the key even in binary form since the OID
+is provided by the TCG to be unique and thus forms a recognizable
+binary pattern at offset 3 in the key.  The OIDs currently made
+available are::
+
+    2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
+                    RSA2048 or Elliptic Curve) which can be imported by a
+                    TPM2_Load() operation.
+
+    2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
+                    RSA2048 or Elliptic Curve) which can be imported by a
+                    TPM2_Import() operation.
+
+    2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
+                    bytes) which is sealed by the TPM.  It usually
+                    represents a symmetric key and must be unsealed before
+                    use.
+
+The trusted key code only uses the TPM Sealed Data OID.
+
+emptyAuth is true if the key has well known authorization "".  If it
+is false or not present, the key requires an explicit authorization
+phrase.  This is used by most user space consumers to decide whether
+to prompt for a password.
+
+parent represents the parent key handle, either in the 0x81 MSO space,
+like 0x81000001 for the RSA primary storage key.  Userspace programmes
+also support specifying the primary handle in the 0x40 MSO space.  If
+this happens the Elliptic Curve variant of the primary key using the
+TCG defined template will be generated on the fly into a volatile
+object and used as the parent.  The current kernel code only supports
+the 0x81 MSO form.
+
+pubkey is the binary representation of TPM2B_PRIVATE excluding the
+initial TPM2B header, which can be reconstructed from the ASN.1 octet
+string length.
+
+privkey is the binary representation of TPM2B_PUBLIC excluding the
+initial TPM2B header which can be reconstructed from the ASN.1 octed
+string length.
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index b2ed3481c6a0..b2d87ad21714 100644
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
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 83bc23409164..8fbfedf6d1cc 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -75,6 +75,7 @@ config TRUSTED_KEYS
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
+	select ASN1_ENCODER
 	help
 	  This option provides support for creating, sealing, and unsealing
 	  keys in the kernel. Trusted keys are random number symmetric keys,
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 7b73cebbb378..e0198641eff2 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_tpm1.o
-trusted-y += trusted_tpm2.o
+trusted-y += trusted_tpm2.o tpm2key.asn1.o
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
new file mode 100644
index 000000000000..3f6a9d01d1e5
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -0,0 +1,11 @@
+---
+--- ASN.1 for for TPM 2.0 keys
+---
+
+TPMKey ::= SEQUENCE {
+	type		OBJECT IDENTIFIER ({tpm2_key_type}),
+	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	parent		INTEGER ({tpm2_key_parent}),
+	pubkey		OCTET STRING ({tpm2_key_pub}),
+	privkey		OCTET STRING ({tpm2_key_priv})
+	}
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index eaa2e7ca136e..f235637865b9 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1011,7 +1011,7 @@ static int trusted_instantiate(struct key *key,
 		goto out;
 	}
 
-	if (!options->keyhandle) {
+	if (!options->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index b4a5058107c2..e8dcc47b3388 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2014 Intel Corporation
  */
 
+#include <linux/asn1_encoder.h>
+#include <linux/oid_registry.h>
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/tpm.h>
@@ -12,6 +14,10 @@
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
 
+#include <asm/unaligned.h>
+
+#include "tpm2key.asn1.h"
+
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -20,6 +26,165 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
+
+static int tpm2_key_encode(struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u8 *src, u32 len)
+{
+	const int SCRATCH_SIZE = PAGE_SIZE;
+	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	u8 *work = scratch, *work1;
+	u8 *end_work = scratch + SCRATCH_SIZE;
+	u8 *priv, *pub;
+	u16 priv_len, pub_len;
+
+	priv_len = get_unaligned_be16(src) + 2;
+	priv = src;
+
+	src += priv_len;
+
+	pub_len = get_unaligned_be16(src) + 2;
+	pub = src;
+
+	if (!scratch)
+		return -ENOMEM;
+
+	work = asn1_encode_oid(work, end_work, tpm2key_oid,
+			       asn1_oid_len(tpm2key_oid));
+
+	if (options->blobauth_len == 0) {
+		unsigned char bool[3], *w = bool;
+		/* tag 0 is emptyAuth */
+		w = asn1_encode_boolean(w, w + sizeof(bool), true);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
+			return PTR_ERR(w);
+		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+	}
+
+	/*
+	 * Assume both octet strings will encode to a 2 byte definite length
+	 *
+	 * Note: For a well behaved TPM, this warning should never
+	 * trigger, so if it does there's something nefarious going on
+	 */
+	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
+		 "BUG: scratch buffer is too small"))
+		return -EINVAL;
+
+	work = asn1_encode_integer(work, end_work, options->keyhandle);
+	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
+	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
+
+	work1 = payload->blob;
+	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
+				     scratch, work - scratch);
+	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
+		return PTR_ERR(work1);
+
+	return work1 - payload->blob;
+}
+
+struct tpm2_key_context {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+};
+
+static int tpm2_key_decode(struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u8 **buf)
+{
+	int ret;
+	struct tpm2_key_context ctx;
+	u8 *blob;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
+			       payload->blob_len);
+	if (ret < 0)
+		return ret;
+
+	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
+		return -EINVAL;
+
+	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	if (!blob)
+		return -ENOMEM;
+
+	*buf = blob;
+	options->keyhandle = ctx.parent;
+
+	memcpy(blob, ctx.priv, ctx.priv_len);
+	blob += ctx.priv_len;
+
+	memcpy(blob, ctx.pub, ctx.pub_len);
+
+	return 0;
+}
+
+int tpm2_key_parent(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+	const u8 *v = value;
+	int i;
+
+	ctx->parent = 0;
+	for (i = 0; i < vlen; i++) {
+		ctx->parent <<= 8;
+		ctx->parent |= v[i];
+	}
+
+	return 0;
+}
+
+int tpm2_key_type(void *context, size_t hdrlen,
+		unsigned char tag,
+		const void *value, size_t vlen)
+{
+	enum OID oid = look_up_OID(value, vlen);
+
+	if (oid != OID_TPMSealedData) {
+		char buffer[50];
+
+		sprint_oid(value, vlen, buffer, sizeof(buffer));
+		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
+			 buffer);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int tpm2_key_pub(void *context, size_t hdrlen,
+	       unsigned char tag,
+	       const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->pub = value;
+	ctx->pub_len = vlen;
+
+	return 0;
+}
+
+int tpm2_key_priv(void *context, size_t hdrlen,
+		unsigned char tag,
+		const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->priv = value;
+	ctx->priv_len = vlen;
+
+	return 0;
+}
+
 /**
  * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -79,6 +244,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
+	if (!options->keyhandle)
+		return -EINVAL;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc)
 		return rc;
@@ -146,8 +314,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
-	payload->blob_len = blob_len;
+	payload->blob_len =
+		tpm2_key_encode(payload, options,
+				&buf.data[TPM_HEADER_SIZE + 4],
+				blob_len);
 
 out:
 	tpm_buf_destroy(&buf);
@@ -158,6 +328,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		else
 			rc = -EPERM;
 	}
+	if (payload->blob_len < 0)
+		return payload->blob_len;
 
 	return rc;
 }
@@ -184,13 +356,34 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
+	u8 *blob;
 	int rc;
 
-	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
-	if (private_len > (payload->blob_len - 2))
+	rc = tpm2_key_decode(payload, options, &blob);
+	if (rc) {
+		/* old form */
+		blob = payload->blob;
+		payload->old_format = 1;
+	}
+
+	/* new format carries keyhandle but old format doesn't */
+	if (!options->keyhandle)
+		return -EINVAL;
+
+	/* must be big enough for at least the two be16 size counts */
+	if (payload->blob_len < 4)
+		return -EINVAL;
+
+	private_len = get_unaligned_be16(blob);
+
+	/* must be big enough for following public_len */
+	if (private_len + 2 + 2 > (payload->blob_len))
+		return -E2BIG;
+
+	public_len = get_unaligned_be16(blob + 2 + private_len);
+	if (private_len + 2 + public_len + 2 > payload->blob_len)
 		return -E2BIG;
 
-	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
 	blob_len = private_len + public_len + 4;
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
@@ -206,7 +399,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			     options->keyauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	tpm_buf_append(&buf, payload->blob, blob_len);
+	tpm_buf_append(&buf, blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
@@ -219,6 +412,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
+	if (blob != payload->blob)
+		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.26.2

