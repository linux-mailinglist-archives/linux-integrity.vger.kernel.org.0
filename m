Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD1607F3
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGEOdi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 10:33:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36608 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfGEOdi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 10:33:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so396630pgm.3
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jul 2019 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p0PJNMFMACdsyja6XKKuLmDFYVn3mM8KPUhyYKa2az4=;
        b=PUVa6S1e8SX2egbeck5IVKXQflTCiXvnRqhnMAKYdUjIHUBYzEdJnHEI1svFmhY906
         4DXdzJ68JxrVRGU1+8x0bqhkhq7OzugNpuBZgGMbKXwEK76SC+JYQKtnZsxpN5AS/EQN
         3U9V2GfigYf/HacGm82q7wYtcjbbCNO/n2gkZRv3NzMY61VtN2ErulqX40yf2/VhoiTi
         S3Z8f9l3/tv+EWhXRakUQWh7RzjPcmje6hEwDr57afXm44AHSC3Bi/sRLp6q8oS/vjMu
         Od3bLB6wQx5YnoliOmDEk/eLvekP9AA0w+a0lDBpyRhLHE+UyKwqd9yByec+juYZI2LO
         PxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0PJNMFMACdsyja6XKKuLmDFYVn3mM8KPUhyYKa2az4=;
        b=A7IUnjtm4Qun2MTB9HXEjZ4fo3LJLLBQMxUgjKDLtOWlRltHNVqUG8UkWJgmFAFTns
         /uYF0fjx2sZ0JcauK73DN0sgt28qjtguvQKBo5keh+RhFHbgSZkEa0wOQ5gISqBo1OtI
         f27uEn6V7TcLoA5Maz8UCR2tduiDrKuVmYsPWa2ulFjHYe+QKDy+QEyhcPCMb9NKWwmZ
         2VO0OlF8Hgc9tpJQl1WS8T3gCMHDJU+Hjd1BBOh9X3MYyiVkRz9Rad10IXR6BXOUW8f7
         YpqPVxvG26jR8v41Kwrup90AOCyhl3CTgmEFkY20snrVfhe9OxPR71z3v8tVJVOoLPqu
         KZwQ==
X-Gm-Message-State: APjAAAWKeT7OIJELIaa3JBNDLxaIO67NzNs5xPG6Vnxquqvi1mHhYQuJ
        UcjuP2724bSX28fh2Hcy3Qahsw==
X-Google-Smtp-Source: APXvYqyNow9DHrub+FVJLBYUORiNcHUBDFGXIcuBI3cg42oTH0U5HIYjP323WGLJlds/sbCYJvGidg==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr5978409pgm.264.1562337215572;
        Fri, 05 Jul 2019 07:33:35 -0700 (PDT)
Received: from localhost.localdomain ([45.114.73.6])
        by smtp.gmail.com with ESMTPSA id u7sm8348819pgr.94.2019.07.05.07.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jul 2019 07:33:34 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT] KEYS: trusted: Add generic trusted keys framework
Date:   Fri,  5 Jul 2019 20:02:34 +0530
Message-Id: <1562337154-26376-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Current trusted keys framework is tightly coupled to use TPM device as
an underlying implementation which makes it difficult for implementations
like Trusted Execution Environment (TEE) etc. to provide trusked keys
support in case platform doesn't posses a TPM device.

So this patch tries to add generic trusted keys framework where underlying
implemtations like TPM, TEE etc. could be easily plugged-in.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

This patch is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch with a TPM device.

Looking forward to your valuable feedback.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

-Sumit

 crypto/asymmetric_keys/asym_tpm.c        |    2 +-
 include/keys/trusted-type.h              |   45 ++
 include/keys/trusted.h                   |  136 ----
 include/keys/trusted_tpm.h               |  124 +++
 security/keys/Makefile                   |    2 +-
 security/keys/trusted-keys/Makefile      |    7 +
 security/keys/trusted-keys/trusted-tpm.c | 1063 ++++++++++++++++++++++++
 security/keys/trusted-keys/trusted.c     |  342 ++++++++
 security/keys/trusted.c                  | 1295 ------------------------------
 9 files changed, 1583 insertions(+), 1433 deletions(-)
 delete mode 100644 include/keys/trusted.h
 create mode 100644 include/keys/trusted_tpm.h
 create mode 100644 security/keys/trusted-keys/Makefile
 create mode 100644 security/keys/trusted-keys/trusted-tpm.c
 create mode 100644 security/keys/trusted-keys/trusted.c
 delete mode 100644 security/keys/trusted.c

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 76d2ce3..ec3f309 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -13,7 +13,7 @@
 #include <crypto/sha.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 #include <crypto/asym_tpm_subtype.h>
 #include <crypto/public_key.h>
 
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a..5559010 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -40,6 +40,51 @@ struct trusted_key_options {
 	uint32_t policyhandle;
 };
 
+struct trusted_key_ops {
+	/*
+	 * flag to indicate if trusted key implementation supports migration
+	 * or not.
+	 */
+	unsigned char migratable;
+
+	/* trusted key init */
+	int (*init)(void);
+
+	/* seal a trusted key */
+	int (*seal)(struct trusted_key_payload *p, char *datablob);
+
+	/* unseal a trusted key */
+	int (*unseal)(struct trusted_key_payload *p, char *datablob);
+
+	/* get random trusted key */
+	int (*get_random)(unsigned char *key, size_t key_len);
+
+	/* trusted key cleanup */
+	void (*cleanup)(void);
+};
+
 extern struct key_type key_type_trusted;
+#if defined(CONFIG_TCG_TPM)
+extern struct trusted_key_ops tpm_trusted_key_ops;
+#endif
+
+#define TRUSTED_DEBUG 0
+
+#if TRUSTED_DEBUG
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+	pr_info("trusted_key: key_len %d\n", p->key_len);
+	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
+		       16, 1, p->key, p->key_len, 0);
+	pr_info("trusted_key: bloblen %d\n", p->blob_len);
+	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
+		       16, 1, p->blob, p->blob_len, 0);
+	pr_info("trusted_key: migratable %d\n", p->migratable);
+}
+#else
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+}
+#endif
 
 #endif /* _KEYS_TRUSTED_TYPE_H */
diff --git a/include/keys/trusted.h b/include/keys/trusted.h
deleted file mode 100644
index 0071298..0000000
--- a/include/keys/trusted.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TRUSTED_KEY_H
-#define __TRUSTED_KEY_H
-
-/* implementation specific TPM constants */
-#define MAX_BUF_SIZE			1024
-#define TPM_GETRANDOM_SIZE		14
-#define TPM_OSAP_SIZE			36
-#define TPM_OIAP_SIZE			10
-#define TPM_SEAL_SIZE			87
-#define TPM_UNSEAL_SIZE			104
-#define TPM_SIZE_OFFSET			2
-#define TPM_RETURN_OFFSET		6
-#define TPM_DATA_OFFSET			10
-
-#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
-#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
-#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
-
-struct tpm_buf {
-	int len;
-	unsigned char data[MAX_BUF_SIZE];
-};
-
-#define INIT_BUF(tb) (tb->len = 0)
-
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
-#define TPM_DEBUG 0
-
-#if TPM_DEBUG
-static inline void dump_options(struct trusted_key_options *o)
-{
-	pr_info("trusted_key: sealing key type %d\n", o->keytype);
-	pr_info("trusted_key: sealing key handle %0X\n", o->keyhandle);
-	pr_info("trusted_key: pcrlock %d\n", o->pcrlock);
-	pr_info("trusted_key: pcrinfo %d\n", o->pcrinfo_len);
-	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
-		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
-}
-
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-	pr_info("trusted_key: key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("trusted_key: bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("trusted_key: migratable %d\n", p->migratable);
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
-		       16, 1, &s->handle, 4, 0);
-	pr_info("trusted-key: secret:\n");
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
-	pr_info("\ntrusted-key: tpm buffer\n");
-	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
-}
-#else
-static inline void dump_options(struct trusted_key_options *o)
-{
-}
-
-static inline void dump_payload(struct trusted_key_payload *p)
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
-
-static inline void store8(struct tpm_buf *buf, const unsigned char value)
-{
-	buf->data[buf->len++] = value;
-}
-
-static inline void store16(struct tpm_buf *buf, const uint16_t value)
-{
-	*(uint16_t *) & buf->data[buf->len] = htons(value);
-	buf->len += sizeof value;
-}
-
-static inline void store32(struct tpm_buf *buf, const uint32_t value)
-{
-	*(uint32_t *) & buf->data[buf->len] = htonl(value);
-	buf->len += sizeof value;
-}
-
-static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
-			      const int len)
-{
-	memcpy(buf->data + buf->len, in, len);
-	buf->len += len;
-}
-#endif
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
new file mode 100644
index 0000000..fd9bad2
--- /dev/null
+++ b/include/keys/trusted_tpm.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TRUSTED_TPM_H
+#define __TRUSTED_TPM_H
+
+#include <keys/trusted-type.h>
+#include <linux/tpm_command.h>
+
+/* implementation specific TPM constants */
+#define MAX_BUF_SIZE			1024
+#define TPM_GETRANDOM_SIZE		14
+#define TPM_OSAP_SIZE			36
+#define TPM_OIAP_SIZE			10
+#define TPM_SEAL_SIZE			87
+#define TPM_UNSEAL_SIZE			104
+#define TPM_SIZE_OFFSET			2
+#define TPM_RETURN_OFFSET		6
+#define TPM_DATA_OFFSET			10
+
+#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
+#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
+#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
+
+struct tpm_buf {
+	int len;
+	unsigned char data[MAX_BUF_SIZE];
+};
+
+#define INIT_BUF(tb) (tb->len = 0)
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
+int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+			unsigned int keylen, unsigned char *h1,
+			unsigned char *h2, unsigned int h3, ...);
+int TSS_checkhmac1(unsigned char *buffer,
+			  const uint32_t command,
+			  const unsigned char *ononce,
+			  const unsigned char *key,
+			  unsigned int keylen, ...);
+
+int trusted_tpm_send(unsigned char *cmd, size_t buflen);
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
+
+#define TPM_DEBUG 0
+
+#if TPM_DEBUG
+static inline void dump_options(struct trusted_key_options *o)
+{
+	pr_info("trusted_key: sealing key type %d\n", o->keytype);
+	pr_info("trusted_key: sealing key handle %0X\n", o->keyhandle);
+	pr_info("trusted_key: pcrlock %d\n", o->pcrlock);
+	pr_info("trusted_key: pcrinfo %d\n", o->pcrinfo_len);
+	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
+		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+}
+
+static inline void dump_sess(struct osapsess *s)
+{
+	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
+		       16, 1, &s->handle, 4, 0);
+	pr_info("trusted-key: secret:\n");
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
+	pr_info("\ntrusted-key: tpm buffer\n");
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
+static inline void store8(struct tpm_buf *buf, const unsigned char value)
+{
+	buf->data[buf->len++] = value;
+}
+
+static inline void store16(struct tpm_buf *buf, const uint16_t value)
+{
+	*(uint16_t *) &buf->data[buf->len] = htons(value);
+	buf->len += sizeof(value);
+}
+
+static inline void store32(struct tpm_buf *buf, const uint32_t value)
+{
+	*(uint32_t *) &buf->data[buf->len] = htonl(value);
+	buf->len += sizeof(value);
+}
+
+static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
+			      const int len)
+{
+	memcpy(buf->data + buf->len, in, len);
+	buf->len += len;
+}
+#endif
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef540..074f275 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -28,5 +28,5 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 # Key types
 #
 obj-$(CONFIG_BIG_KEYS) += big_key.o
-obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+obj-$(CONFIG_TRUSTED_KEYS) += trusted-keys/
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
new file mode 100644
index 0000000..6ecadfb
--- /dev/null
+++ b/security/keys/trusted-keys/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for trusted keys
+#
+
+obj-$(CONFIG_TRUSTED_KEYS) += trusted.o \
+			trusted-tpm.o
diff --git a/security/keys/trusted-keys/trusted-tpm.c b/security/keys/trusted-keys/trusted-tpm.c
new file mode 100644
index 0000000..933d40a
--- /dev/null
+++ b/security/keys/trusted-keys/trusted-tpm.c
@@ -0,0 +1,1063 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2010 IBM Corporation
+ * Copyright (c) 2019, Linaro Limited
+ *
+ * Author:
+ * David Safford <safford@us.ibm.com>
+ * Switch to generic trusted key framework: Sumit Garg <sumit.garg@linaro.org>
+ *
+ * See Documentation/security/keys/trusted-encrypted.rst
+ */
+
+#include <crypto/hash.h>
+#include <crypto/hash_info.h>
+#include <crypto/sha.h>
+#include <keys/trusted_tpm.h>
+#include <linux/crypto.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/key-type.h>
+#include <linux/parser.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tpm.h>
+
+static const char hmac_alg[] = "hmac(sha1)";
+static const char hash_alg[] = "sha1";
+static struct tpm_chip *chip;
+static struct tpm_digest *digests;
+
+struct sdesc {
+	struct shash_desc shash;
+	char ctx[];
+};
+
+static struct crypto_shash *hashalg;
+static struct crypto_shash *hmacalg;
+
+static struct sdesc *init_sdesc(struct crypto_shash *alg)
+{
+	struct sdesc *sdesc;
+	int size;
+
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
+	sdesc = kmalloc(size, GFP_KERNEL);
+	if (!sdesc)
+		return ERR_PTR(-ENOMEM);
+	sdesc->shash.tfm = alg;
+	return sdesc;
+}
+
+static int TSS_sha1(const unsigned char *data, unsigned int datalen,
+		    unsigned char *digest)
+{
+	struct sdesc *sdesc;
+	int ret;
+
+	sdesc = init_sdesc(hashalg);
+	if (IS_ERR(sdesc)) {
+		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		return PTR_ERR(sdesc);
+	}
+
+	ret = crypto_shash_digest(&sdesc->shash, data, datalen, digest);
+	kzfree(sdesc);
+	return ret;
+}
+
+static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
+		       unsigned int keylen, ...)
+{
+	struct sdesc *sdesc;
+	va_list argp;
+	unsigned int dlen;
+	unsigned char *data;
+	int ret;
+
+	sdesc = init_sdesc(hmacalg);
+	if (IS_ERR(sdesc)) {
+		pr_info("trusted_key: can't alloc %s\n", hmac_alg);
+		return PTR_ERR(sdesc);
+	}
+
+	ret = crypto_shash_setkey(hmacalg, key, keylen);
+	if (ret < 0)
+		goto out;
+	ret = crypto_shash_init(&sdesc->shash);
+	if (ret < 0)
+		goto out;
+
+	va_start(argp, keylen);
+	for (;;) {
+		dlen = va_arg(argp, unsigned int);
+		if (dlen == 0)
+			break;
+		data = va_arg(argp, unsigned char *);
+		if (data == NULL) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = crypto_shash_update(&sdesc->shash, data, dlen);
+		if (ret < 0)
+			break;
+	}
+	va_end(argp);
+	if (!ret)
+		ret = crypto_shash_final(&sdesc->shash, digest);
+out:
+	kzfree(sdesc);
+	return ret;
+}
+
+/*
+ * calculate authorization info fields to send to TPM
+ */
+int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+			unsigned int keylen, unsigned char *h1,
+			unsigned char *h2, unsigned int h3, ...)
+{
+	unsigned char paramdigest[SHA1_DIGEST_SIZE];
+	struct sdesc *sdesc;
+	unsigned int dlen;
+	unsigned char *data;
+	unsigned char c;
+	int ret;
+	va_list argp;
+
+	if (!chip)
+		return -ENODEV;
+
+	sdesc = init_sdesc(hashalg);
+	if (IS_ERR(sdesc)) {
+		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		return PTR_ERR(sdesc);
+	}
+
+	c = !!h3;
+	ret = crypto_shash_init(&sdesc->shash);
+	if (ret < 0)
+		goto out;
+	va_start(argp, h3);
+	for (;;) {
+		dlen = va_arg(argp, unsigned int);
+		if (dlen == 0)
+			break;
+		data = va_arg(argp, unsigned char *);
+		if (!data) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = crypto_shash_update(&sdesc->shash, data, dlen);
+		if (ret < 0)
+			break;
+	}
+	va_end(argp);
+	if (!ret)
+		ret = crypto_shash_final(&sdesc->shash, paramdigest);
+	if (!ret)
+		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
+				  paramdigest, TPM_NONCE_SIZE, h1,
+				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
+out:
+	kzfree(sdesc);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(TSS_authhmac);
+
+/*
+ * verify the AUTH1_COMMAND (Seal) result from TPM
+ */
+int TSS_checkhmac1(unsigned char *buffer,
+			  const uint32_t command,
+			  const unsigned char *ononce,
+			  const unsigned char *key,
+			  unsigned int keylen, ...)
+{
+	uint32_t bufsize;
+	uint16_t tag;
+	uint32_t ordinal;
+	uint32_t result;
+	unsigned char *enonce;
+	unsigned char *continueflag;
+	unsigned char *authdata;
+	unsigned char testhmac[SHA1_DIGEST_SIZE];
+	unsigned char paramdigest[SHA1_DIGEST_SIZE];
+	struct sdesc *sdesc;
+	unsigned int dlen;
+	unsigned int dpos;
+	va_list argp;
+	int ret;
+
+	if (!chip)
+		return -ENODEV;
+
+	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
+	tag = LOAD16(buffer, 0);
+	ordinal = command;
+	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
+	if (tag == TPM_TAG_RSP_COMMAND)
+		return 0;
+	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
+		return -EINVAL;
+	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
+	continueflag = authdata - 1;
+	enonce = continueflag - TPM_NONCE_SIZE;
+
+	sdesc = init_sdesc(hashalg);
+	if (IS_ERR(sdesc)) {
+		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		return PTR_ERR(sdesc);
+	}
+	ret = crypto_shash_init(&sdesc->shash);
+	if (ret < 0)
+		goto out;
+	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
+				  sizeof(result));
+	if (ret < 0)
+		goto out;
+	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
+				  sizeof(ordinal));
+	if (ret < 0)
+		goto out;
+	va_start(argp, keylen);
+	for (;;) {
+		dlen = va_arg(argp, unsigned int);
+		if (dlen == 0)
+			break;
+		dpos = va_arg(argp, unsigned int);
+		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
+		if (ret < 0)
+			break;
+	}
+	va_end(argp);
+	if (!ret)
+		ret = crypto_shash_final(&sdesc->shash, paramdigest);
+	if (ret < 0)
+		goto out;
+
+	ret = TSS_rawhmac(testhmac, key, keylen, SHA1_DIGEST_SIZE, paramdigest,
+			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
+			  1, continueflag, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
+		ret = -EINVAL;
+out:
+	kzfree(sdesc);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(TSS_checkhmac1);
+
+/*
+ * verify the AUTH2_COMMAND (unseal) result from TPM
+ */
+static int TSS_checkhmac2(unsigned char *buffer,
+			  const uint32_t command,
+			  const unsigned char *ononce,
+			  const unsigned char *key1,
+			  unsigned int keylen1,
+			  const unsigned char *key2,
+			  unsigned int keylen2, ...)
+{
+	uint32_t bufsize;
+	uint16_t tag;
+	uint32_t ordinal;
+	uint32_t result;
+	unsigned char *enonce1;
+	unsigned char *continueflag1;
+	unsigned char *authdata1;
+	unsigned char *enonce2;
+	unsigned char *continueflag2;
+	unsigned char *authdata2;
+	unsigned char testhmac1[SHA1_DIGEST_SIZE];
+	unsigned char testhmac2[SHA1_DIGEST_SIZE];
+	unsigned char paramdigest[SHA1_DIGEST_SIZE];
+	struct sdesc *sdesc;
+	unsigned int dlen;
+	unsigned int dpos;
+	va_list argp;
+	int ret;
+
+	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
+	tag = LOAD16(buffer, 0);
+	ordinal = command;
+	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
+
+	if (tag == TPM_TAG_RSP_COMMAND)
+		return 0;
+	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
+		return -EINVAL;
+	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
+			+ SHA1_DIGEST_SIZE + SHA1_DIGEST_SIZE);
+	authdata2 = buffer + bufsize - (SHA1_DIGEST_SIZE);
+	continueflag1 = authdata1 - 1;
+	continueflag2 = authdata2 - 1;
+	enonce1 = continueflag1 - TPM_NONCE_SIZE;
+	enonce2 = continueflag2 - TPM_NONCE_SIZE;
+
+	sdesc = init_sdesc(hashalg);
+	if (IS_ERR(sdesc)) {
+		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		return PTR_ERR(sdesc);
+	}
+	ret = crypto_shash_init(&sdesc->shash);
+	if (ret < 0)
+		goto out;
+	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
+				  sizeof(result));
+	if (ret < 0)
+		goto out;
+	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
+				  sizeof(ordinal));
+	if (ret < 0)
+		goto out;
+
+	va_start(argp, keylen2);
+	for (;;) {
+		dlen = va_arg(argp, unsigned int);
+		if (dlen == 0)
+			break;
+		dpos = va_arg(argp, unsigned int);
+		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
+		if (ret < 0)
+			break;
+	}
+	va_end(argp);
+	if (!ret)
+		ret = crypto_shash_final(&sdesc->shash, paramdigest);
+	if (ret < 0)
+		goto out;
+
+	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
+			  paramdigest, TPM_NONCE_SIZE, enonce1,
+			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
+			  paramdigest, TPM_NONCE_SIZE, enonce2,
+			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
+		ret = -EINVAL;
+out:
+	kzfree(sdesc);
+	return ret;
+}
+
+/*
+ * For key specific tpm requests, we will generate and send our
+ * own TPM command packets using the drivers send function.
+ */
+int trusted_tpm_send(unsigned char *cmd, size_t buflen)
+{
+	int rc;
+
+	if (!chip)
+		return -ENODEV;
+
+	dump_tpm_buf(cmd);
+	rc = tpm_send(chip, cmd, buflen);
+	dump_tpm_buf(cmd);
+	if (rc > 0)
+		/* Can't return positive return codes values to keyctl */
+		rc = -EPERM;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(trusted_tpm_send);
+
+/*
+ * Lock a trusted key, by extending a selected PCR.
+ *
+ * Prevents a trusted key that is sealed to PCRs from being accessed.
+ * This uses the tpm driver's extend function.
+ */
+static int pcrlock(const int pcrnum)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
+}
+
+/*
+ * Create an object specific authorisation protocol (OSAP) session
+ */
+static int osap(struct tpm_buf *tb, struct osapsess *s,
+		const unsigned char *key, uint16_t type, uint32_t handle)
+{
+	unsigned char enonce[TPM_NONCE_SIZE];
+	unsigned char ononce[TPM_NONCE_SIZE];
+	int ret;
+
+	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
+	if (ret != TPM_NONCE_SIZE)
+		return ret;
+
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_COMMAND);
+	store32(tb, TPM_OSAP_SIZE);
+	store32(tb, TPM_ORD_OSAP);
+	store16(tb, type);
+	store32(tb, handle);
+	storebytes(tb, ononce, TPM_NONCE_SIZE);
+
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0)
+		return ret;
+
+	s->handle = LOAD32(tb->data, TPM_DATA_OFFSET);
+	memcpy(s->enonce, &(tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)]),
+	       TPM_NONCE_SIZE);
+	memcpy(enonce, &(tb->data[TPM_DATA_OFFSET + sizeof(uint32_t) +
+				  TPM_NONCE_SIZE]), TPM_NONCE_SIZE);
+	return TSS_rawhmac(s->secret, key, SHA1_DIGEST_SIZE, TPM_NONCE_SIZE,
+			   enonce, TPM_NONCE_SIZE, ononce, 0, 0);
+}
+
+/*
+ * Create an object independent authorisation protocol (oiap) session
+ */
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
+{
+	int ret;
+
+	if (!chip)
+		return -ENODEV;
+
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_COMMAND);
+	store32(tb, TPM_OIAP_SIZE);
+	store32(tb, TPM_ORD_OIAP);
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0)
+		return ret;
+
+	*handle = LOAD32(tb->data, TPM_DATA_OFFSET);
+	memcpy(nonce, &tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)],
+	       TPM_NONCE_SIZE);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(oiap);
+
+struct tpm_digests {
+	unsigned char encauth[SHA1_DIGEST_SIZE];
+	unsigned char pubauth[SHA1_DIGEST_SIZE];
+	unsigned char xorwork[SHA1_DIGEST_SIZE * 2];
+	unsigned char xorhash[SHA1_DIGEST_SIZE];
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+};
+
+/*
+ * Have the TPM seal(encrypt) the trusted key, possibly based on
+ * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
+ */
+static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
+		    uint32_t keyhandle, const unsigned char *keyauth,
+		    const unsigned char *data, uint32_t datalen,
+		    unsigned char *blob, uint32_t *bloblen,
+		    const unsigned char *blobauth,
+		    const unsigned char *pcrinfo, uint32_t pcrinfosize)
+{
+	struct osapsess sess;
+	struct tpm_digests *td;
+	unsigned char cont;
+	uint32_t ordinal;
+	uint32_t pcrsize;
+	uint32_t datsize;
+	int sealinfosize;
+	int encdatasize;
+	int storedsize;
+	int ret;
+	int i;
+
+	/* alloc some work space for all the hashes */
+	td = kmalloc(sizeof(*td), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	/* get session for sealing key */
+	ret = osap(tb, &sess, keyauth, keytype, keyhandle);
+	if (ret < 0)
+		goto out;
+	dump_sess(&sess);
+
+	/* calculate encrypted authorization value */
+	memcpy(td->xorwork, sess.secret, SHA1_DIGEST_SIZE);
+	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
+	ret = TSS_sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
+	if (ret < 0)
+		goto out;
+
+	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
+	if (ret != TPM_NONCE_SIZE)
+		goto out;
+	ordinal = htonl(TPM_ORD_SEAL);
+	datsize = htonl(datalen);
+	pcrsize = htonl(pcrinfosize);
+	cont = 0;
+
+	/* encrypt data authorization key */
+	for (i = 0; i < SHA1_DIGEST_SIZE; ++i)
+		td->encauth[i] = td->xorhash[i] ^ blobauth[i];
+
+	/* calculate authorization HMAC value */
+	if (pcrinfosize == 0) {
+		/* no pcr info specified */
+		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
+				   sess.enonce, td->nonceodd, cont,
+				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
+				   td->encauth, sizeof(uint32_t), &pcrsize,
+				   sizeof(uint32_t), &datsize, datalen, data, 0,
+				   0);
+	} else {
+		/* pcr info specified */
+		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
+				   sess.enonce, td->nonceodd, cont,
+				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
+				   td->encauth, sizeof(uint32_t), &pcrsize,
+				   pcrinfosize, pcrinfo, sizeof(uint32_t),
+				   &datsize, datalen, data, 0, 0);
+	}
+	if (ret < 0)
+		goto out;
+
+	/* build and send the TPM request packet */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
+	store32(tb, TPM_SEAL_SIZE + pcrinfosize + datalen);
+	store32(tb, TPM_ORD_SEAL);
+	store32(tb, keyhandle);
+	storebytes(tb, td->encauth, SHA1_DIGEST_SIZE);
+	store32(tb, pcrinfosize);
+	storebytes(tb, pcrinfo, pcrinfosize);
+	store32(tb, datalen);
+	storebytes(tb, data, datalen);
+	store32(tb, sess.handle);
+	storebytes(tb, td->nonceodd, TPM_NONCE_SIZE);
+	store8(tb, cont);
+	storebytes(tb, td->pubauth, SHA1_DIGEST_SIZE);
+
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0)
+		goto out;
+
+	/* calculate the size of the returned Blob */
+	sealinfosize = LOAD32(tb->data, TPM_DATA_OFFSET + sizeof(uint32_t));
+	encdatasize = LOAD32(tb->data, TPM_DATA_OFFSET + sizeof(uint32_t) +
+			     sizeof(uint32_t) + sealinfosize);
+	storedsize = sizeof(uint32_t) + sizeof(uint32_t) + sealinfosize +
+	    sizeof(uint32_t) + encdatasize;
+
+	/* check the HMAC in the response */
+	ret = TSS_checkhmac1(tb->data, ordinal, td->nonceodd, sess.secret,
+			     SHA1_DIGEST_SIZE, storedsize, TPM_DATA_OFFSET, 0,
+			     0);
+
+	/* copy the returned blob to caller */
+	if (!ret) {
+		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
+		*bloblen = storedsize;
+	}
+out:
+	kzfree(td);
+	return ret;
+}
+
+/*
+ * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
+ */
+static int tpm_unseal(struct tpm_buf *tb,
+		      uint32_t keyhandle, const unsigned char *keyauth,
+		      const unsigned char *blob, int bloblen,
+		      const unsigned char *blobauth,
+		      unsigned char *data, unsigned int *datalen)
+{
+	unsigned char nonceodd[TPM_NONCE_SIZE];
+	unsigned char enonce1[TPM_NONCE_SIZE];
+	unsigned char enonce2[TPM_NONCE_SIZE];
+	unsigned char authdata1[SHA1_DIGEST_SIZE];
+	unsigned char authdata2[SHA1_DIGEST_SIZE];
+	uint32_t authhandle1 = 0;
+	uint32_t authhandle2 = 0;
+	unsigned char cont = 0;
+	uint32_t ordinal;
+	uint32_t keyhndl;
+	int ret;
+
+	/* sessions for unsealing key and data */
+	ret = oiap(tb, &authhandle1, enonce1);
+	if (ret < 0) {
+		pr_info("trusted_key: oiap failed (%d)\n", ret);
+		return ret;
+	}
+	ret = oiap(tb, &authhandle2, enonce2);
+	if (ret < 0) {
+		pr_info("trusted_key: oiap failed (%d)\n", ret);
+		return ret;
+	}
+
+	ordinal = htonl(TPM_ORD_UNSEAL);
+	keyhndl = htonl(SRKHANDLE);
+	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
+	if (ret != TPM_NONCE_SIZE) {
+		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
+		return ret;
+	}
+	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
+			   enonce1, nonceodd, cont, sizeof(uint32_t),
+			   &ordinal, bloblen, blob, 0, 0);
+	if (ret < 0)
+		return ret;
+	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
+			   enonce2, nonceodd, cont, sizeof(uint32_t),
+			   &ordinal, bloblen, blob, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* build and send TPM request packet */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_AUTH2_COMMAND);
+	store32(tb, TPM_UNSEAL_SIZE + bloblen);
+	store32(tb, TPM_ORD_UNSEAL);
+	store32(tb, keyhandle);
+	storebytes(tb, blob, bloblen);
+	store32(tb, authhandle1);
+	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
+	store8(tb, cont);
+	storebytes(tb, authdata1, SHA1_DIGEST_SIZE);
+	store32(tb, authhandle2);
+	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
+	store8(tb, cont);
+	storebytes(tb, authdata2, SHA1_DIGEST_SIZE);
+
+	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	if (ret < 0) {
+		pr_info("trusted_key: authhmac failed (%d)\n", ret);
+		return ret;
+	}
+
+	*datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
+	ret = TSS_checkhmac2(tb->data, ordinal, nonceodd,
+			     keyauth, SHA1_DIGEST_SIZE,
+			     blobauth, SHA1_DIGEST_SIZE,
+			     sizeof(uint32_t), TPM_DATA_OFFSET,
+			     *datalen, TPM_DATA_OFFSET + sizeof(uint32_t), 0,
+			     0);
+	if (ret < 0) {
+		pr_info("trusted_key: TSS_checkhmac2 failed (%d)\n", ret);
+		return ret;
+	}
+	memcpy(data, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t), *datalen);
+	return 0;
+}
+
+/*
+ * Have the TPM seal(encrypt) the symmetric key
+ */
+static int key_seal(struct trusted_key_payload *p,
+		    struct trusted_key_options *o)
+{
+	struct tpm_buf *tb;
+	int ret;
+
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	/* include migratable flag at end of sealed key */
+	p->key[p->key_len] = p->migratable;
+
+	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
+		       p->key, p->key_len + 1, p->blob, &p->blob_len,
+		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
+	if (ret < 0)
+		pr_info("trusted_key: srkseal failed (%d)\n", ret);
+
+	kzfree(tb);
+	return ret;
+}
+
+/*
+ * Have the TPM unseal(decrypt) the symmetric key
+ */
+static int key_unseal(struct trusted_key_payload *p,
+		      struct trusted_key_options *o)
+{
+	struct tpm_buf *tb;
+	int ret;
+
+	tb = kzalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
+			 o->blobauth, p->key, &p->key_len);
+	if (ret < 0)
+		pr_info("trusted_key: srkunseal failed (%d)\n", ret);
+	else
+		/* pull migratable flag out of sealed key */
+		p->migratable = p->key[--p->key_len];
+
+	kzfree(tb);
+	return ret;
+}
+
+enum {
+	Opt_err,
+	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
+	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
+	Opt_hash,
+	Opt_policydigest,
+	Opt_policyhandle,
+};
+
+static const match_table_t key_tokens = {
+	{Opt_keyhandle, "keyhandle=%s"},
+	{Opt_keyauth, "keyauth=%s"},
+	{Opt_blobauth, "blobauth=%s"},
+	{Opt_pcrinfo, "pcrinfo=%s"},
+	{Opt_pcrlock, "pcrlock=%s"},
+	{Opt_migratable, "migratable=%s"},
+	{Opt_hash, "hash=%s"},
+	{Opt_policydigest, "policydigest=%s"},
+	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_err, NULL}
+};
+
+/* can have zero or more token= options */
+static int getoptions(char *c, struct trusted_key_payload *pay,
+		      struct trusted_key_options *opt)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *p = c;
+	int token;
+	int res;
+	unsigned long handle;
+	unsigned long lock;
+	unsigned long token_mask = 0;
+	unsigned int digest_len;
+	int i;
+	int tpm2;
+
+	tpm2 = tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return tpm2;
+
+	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
+
+	while ((p = strsep(&c, " \t"))) {
+		if (*p == '\0' || *p == ' ' || *p == '\t')
+			continue;
+		token = match_token(p, key_tokens, args);
+		if (test_and_set_bit(token, &token_mask))
+			return -EINVAL;
+
+		switch (token) {
+		case Opt_pcrinfo:
+			opt->pcrinfo_len = strlen(args[0].from) / 2;
+			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
+				return -EINVAL;
+			res = hex2bin(opt->pcrinfo, args[0].from,
+				      opt->pcrinfo_len);
+			if (res < 0)
+				return -EINVAL;
+			break;
+		case Opt_keyhandle:
+			res = kstrtoul(args[0].from, 16, &handle);
+			if (res < 0)
+				return -EINVAL;
+			opt->keytype = SEAL_keytype;
+			opt->keyhandle = handle;
+			break;
+		case Opt_keyauth:
+			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
+				return -EINVAL;
+			res = hex2bin(opt->keyauth, args[0].from,
+				      SHA1_DIGEST_SIZE);
+			if (res < 0)
+				return -EINVAL;
+			break;
+		case Opt_blobauth:
+			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
+				return -EINVAL;
+			res = hex2bin(opt->blobauth, args[0].from,
+				      SHA1_DIGEST_SIZE);
+			if (res < 0)
+				return -EINVAL;
+			break;
+		case Opt_migratable:
+			if (*args[0].from == '0')
+				pay->migratable = 0;
+			else
+				return -EINVAL;
+			break;
+		case Opt_pcrlock:
+			res = kstrtoul(args[0].from, 10, &lock);
+			if (res < 0)
+				return -EINVAL;
+			opt->pcrlock = lock;
+			break;
+		case Opt_hash:
+			if (test_bit(Opt_policydigest, &token_mask))
+				return -EINVAL;
+			for (i = 0; i < HASH_ALGO__LAST; i++) {
+				if (!strcmp(args[0].from, hash_algo_name[i])) {
+					opt->hash = i;
+					break;
+				}
+			}
+			if (i == HASH_ALGO__LAST)
+				return -EINVAL;
+			if  (!tpm2 && i != HASH_ALGO_SHA1) {
+				pr_info("trusted_key: TPM 1.x only supports SHA-1.\n");
+				return -EINVAL;
+			}
+			break;
+		case Opt_policydigest:
+			digest_len = hash_digest_size[opt->hash];
+			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
+				return -EINVAL;
+			res = hex2bin(opt->policydigest, args[0].from,
+				      digest_len);
+			if (res < 0)
+				return -EINVAL;
+			opt->policydigest_len = digest_len;
+			break;
+		case Opt_policyhandle:
+			if (!tpm2)
+				return -EINVAL;
+			res = kstrtoul(args[0].from, 16, &handle);
+			if (res < 0)
+				return -EINVAL;
+			opt->policyhandle = handle;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static struct trusted_key_options *trusted_options_alloc(void)
+{
+	struct trusted_key_options *options;
+	int tpm2;
+
+	tpm2 = tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return NULL;
+
+	options = kzalloc(sizeof(*options), GFP_KERNEL);
+	if (options) {
+		/* set any non-zero defaults */
+		options->keytype = SRK_keytype;
+
+		if (!tpm2)
+			options->keyhandle = SRKHANDLE;
+	}
+	return options;
+}
+
+static int tpm_tk_seal(struct trusted_key_payload *p, char *datablob)
+{
+	struct trusted_key_options *options = NULL;
+	int ret = 0;
+	int tpm2;
+
+	tpm2 = tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return tpm2;
+
+	options = trusted_options_alloc();
+	if (!options)
+		return -ENOMEM;
+
+	ret = getoptions(datablob, p, options);
+	if (ret < 0)
+		goto out;
+	dump_options(options);
+
+	if (!options->keyhandle) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tpm2)
+		ret = tpm_seal_trusted(chip, p, options);
+	else
+		ret = key_seal(p, options);
+	if (ret < 0) {
+		pr_info("tpm_trusted_key: key_seal failed (%d)\n", ret);
+		goto out;
+	}
+
+	if (options->pcrlock) {
+		ret = pcrlock(options->pcrlock);
+		if (ret < 0) {
+			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
+			goto out;
+		}
+	}
+out:
+	kzfree(options);
+	return ret;
+}
+
+static int tpm_tk_unseal(struct trusted_key_payload *p, char *datablob)
+{
+	struct trusted_key_options *options = NULL;
+	int ret = 0;
+	int tpm2;
+
+	tpm2 = tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return tpm2;
+
+	options = trusted_options_alloc();
+	if (!options)
+		return -ENOMEM;
+
+	ret = getoptions(datablob, p, options);
+	if (ret < 0)
+		goto out;
+	dump_options(options);
+
+	if (!options->keyhandle) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tpm2)
+		ret = tpm_unseal_trusted(chip, p, options);
+	else
+		ret = key_unseal(p, options);
+	if (ret < 0)
+		pr_info("tpm_trusted_key: key_unseal failed (%d)\n", ret);
+
+	if (options->pcrlock) {
+		ret = pcrlock(options->pcrlock);
+		if (ret < 0) {
+			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
+			goto out;
+		}
+	}
+out:
+	kzfree(options);
+	return ret;
+}
+
+int tpm_tk_get_random(unsigned char *key, size_t key_len)
+{
+	return tpm_get_random(chip, key, key_len);
+}
+
+static void trusted_shash_release(void)
+{
+	if (hashalg)
+		crypto_free_shash(hashalg);
+	if (hmacalg)
+		crypto_free_shash(hmacalg);
+}
+
+static int __init trusted_shash_alloc(void)
+{
+	int ret;
+
+	hmacalg = crypto_alloc_shash(hmac_alg, 0, 0);
+	if (IS_ERR(hmacalg)) {
+		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
+			hmac_alg);
+		return PTR_ERR(hmacalg);
+	}
+
+	hashalg = crypto_alloc_shash(hash_alg, 0, 0);
+	if (IS_ERR(hashalg)) {
+		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
+			hash_alg);
+		ret = PTR_ERR(hashalg);
+		goto hashalg_fail;
+	}
+
+	return 0;
+
+hashalg_fail:
+	crypto_free_shash(hmacalg);
+	return ret;
+}
+
+static int __init init_digests(void)
+{
+	u8 digest[TPM_MAX_DIGEST_SIZE];
+	int ret;
+	int i;
+
+	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret < TPM_MAX_DIGEST_SIZE)
+		return -EFAULT;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		return -ENOMEM;
+
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
+
+	return 0;
+}
+
+static int __init init_tpm_trusted(void)
+{
+	int ret;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	ret = init_digests();
+	if (ret < 0)
+		goto err_put;
+	ret = trusted_shash_alloc();
+	if (ret < 0)
+		goto err_free;
+	ret = register_key_type(&key_type_trusted);
+	if (ret < 0)
+		goto err_release;
+	return 0;
+err_release:
+	trusted_shash_release();
+err_free:
+	kfree(digests);
+err_put:
+	put_device(&chip->dev);
+	return ret;
+}
+
+static void __exit cleanup_tpm_trusted(void)
+{
+	if (chip) {
+		put_device(&chip->dev);
+		kfree(digests);
+		trusted_shash_release();
+		unregister_key_type(&key_type_trusted);
+	}
+}
+
+struct trusted_key_ops tpm_trusted_key_ops = {
+	.migratable = 1, /* migratable by default */
+	.init = init_tpm_trusted,
+	.seal = tpm_tk_seal,
+	.unseal = tpm_tk_unseal,
+	.get_random = tpm_tk_get_random,
+	.cleanup = cleanup_tpm_trusted,
+};
+EXPORT_SYMBOL_GPL(tpm_trusted_key_ops);
diff --git a/security/keys/trusted-keys/trusted.c b/security/keys/trusted-keys/trusted.c
new file mode 100644
index 0000000..1939df7
--- /dev/null
+++ b/security/keys/trusted-keys/trusted.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2010 IBM Corporation
+ * Copyright (c) 2019, Linaro Limited
+ *
+ * Author:
+ * David Safford <safford@us.ibm.com>
+ * Added generic trusted key framework: Sumit Garg <sumit.garg@linaro.org>
+ *
+ * See Documentation/security/keys/trusted-encrypted.rst
+ */
+
+#include <keys/user-type.h>
+#include <keys/trusted-type.h>
+#include <linux/capability.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/key-type.h>
+#include <linux/module.h>
+#include <linux/parser.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+static struct trusted_key_ops *available_tk_ops[] = {
+#if defined(CONFIG_TCG_TPM)
+	&tpm_trusted_key_ops,
+#endif
+};
+static struct trusted_key_ops *tk_ops;
+
+enum {
+	Opt_err,
+	Opt_new, Opt_load, Opt_update,
+};
+
+static const match_table_t key_tokens = {
+	{Opt_new, "new"},
+	{Opt_load, "load"},
+	{Opt_update, "update"},
+	{Opt_err, NULL}
+};
+
+/*
+ * datablob_parse - parse the keyctl data and fill in the
+ *                  payload structure
+ *
+ * On success returns 0, otherwise -EINVAL.
+ */
+static int datablob_parse(char *datablob, struct trusted_key_payload *p)
+{
+	substring_t args[MAX_OPT_ARGS];
+	long keylen;
+	int ret = -EINVAL;
+	int key_cmd;
+	char *c;
+
+	/* main command */
+	c = strsep(&datablob, " \t");
+	if (!c)
+		return -EINVAL;
+	key_cmd = match_token(c, key_tokens, args);
+	switch (key_cmd) {
+	case Opt_new:
+		/* first argument is key size */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		ret = kstrtol(c, 10, &keylen);
+		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
+			return -EINVAL;
+		p->key_len = keylen;
+		ret = Opt_new;
+		break;
+	case Opt_load:
+		/* first argument is sealed blob */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		p->blob_len = strlen(c) / 2;
+		if (p->blob_len > MAX_BLOB_SIZE)
+			return -EINVAL;
+		ret = hex2bin(p->blob, c, p->blob_len);
+		if (ret < 0)
+			return -EINVAL;
+		ret = Opt_load;
+		break;
+	case Opt_update:
+		ret = Opt_update;
+		break;
+	case Opt_err:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+{
+	struct trusted_key_payload *p = NULL;
+	int ret;
+
+	ret = key_payload_reserve(key, sizeof(*p));
+	if (ret < 0)
+		return p;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	p->migratable = tk_ops->migratable;
+
+	return p;
+}
+
+/*
+ * trusted_instantiate - create a new trusted key
+ *
+ * Unseal an existing trusted blob or, for a new key, get a
+ * random key, then seal and create a trusted key-type key,
+ * adding it to the specified keyring.
+ *
+ * On success, return 0. Otherwise return errno.
+ */
+static int trusted_instantiate(struct key *key,
+			       struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *payload = NULL;
+	size_t datalen = prep->datalen;
+	char *datablob;
+	int ret = 0;
+	int key_cmd;
+	size_t key_len;
+
+	if (datalen <= 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] = '\0';
+
+	payload = trusted_payload_alloc(key);
+	if (!payload) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key_cmd = datablob_parse(datablob, payload);
+	if (key_cmd < 0) {
+		ret = key_cmd;
+		goto out;
+	}
+
+	dump_payload(payload);
+
+	switch (key_cmd) {
+	case Opt_load:
+		ret = tk_ops->unseal(payload, datablob);
+		dump_payload(payload);
+		if (ret < 0)
+			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
+		break;
+	case Opt_new:
+		key_len = payload->key_len;
+		ret = tk_ops->get_random(payload->key, key_len);
+		if (ret != key_len) {
+			pr_info("trusted_key: key_create failed (%d)\n", ret);
+			goto out;
+		}
+
+		ret = tk_ops->seal(payload, datablob);
+		if (ret < 0)
+			pr_info("trusted_key: key_seal failed (%d)\n", ret);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+out:
+	kzfree(datablob);
+	if (!ret)
+		rcu_assign_keypointer(key, payload);
+	else
+		kzfree(payload);
+	return ret;
+}
+
+static void trusted_rcu_free(struct rcu_head *rcu)
+{
+	struct trusted_key_payload *p;
+
+	p = container_of(rcu, struct trusted_key_payload, rcu);
+	kzfree(p);
+}
+
+/*
+ * trusted_update - reseal an existing key with new PCR values
+ */
+static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *p;
+	struct trusted_key_payload *new_p;
+	size_t datalen = prep->datalen;
+	char *datablob;
+	int ret = 0;
+
+	if (key_is_negative(key))
+		return -ENOKEY;
+	p = key->payload.data[0];
+	if (!p->migratable)
+		return -EPERM;
+	if (datalen <= 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+
+	new_p = trusted_payload_alloc(key);
+	if (!new_p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] = '\0';
+	ret = datablob_parse(datablob, new_p);
+	if (ret != Opt_update) {
+		ret = -EINVAL;
+		kzfree(new_p);
+		goto out;
+	}
+
+	/* copy old key values, and reseal with new pcrs */
+	new_p->migratable = p->migratable;
+	new_p->key_len = p->key_len;
+	memcpy(new_p->key, p->key, p->key_len);
+	dump_payload(p);
+	dump_payload(new_p);
+
+	ret = tk_ops->seal(new_p, datablob);
+	if (ret < 0) {
+		pr_info("trusted_key: key_seal failed (%d)\n", ret);
+		kzfree(new_p);
+		goto out;
+	}
+
+	rcu_assign_keypointer(key, new_p);
+	call_rcu(&p->rcu, trusted_rcu_free);
+out:
+	kzfree(datablob);
+	return ret;
+}
+
+/*
+ * trusted_read - copy the sealed blob data to userspace in hex.
+ * On success, return to userspace the trusted key datablob size.
+ */
+static long trusted_read(const struct key *key, char __user *buffer,
+			 size_t buflen)
+{
+	const struct trusted_key_payload *p;
+	char *ascii_buf;
+	char *bufp;
+	int i;
+
+	p = dereference_key_locked(key);
+	if (!p)
+		return -EINVAL;
+
+	if (buffer && buflen >= 2 * p->blob_len) {
+		ascii_buf = kmalloc_array(2, p->blob_len, GFP_KERNEL);
+		if (!ascii_buf)
+			return -ENOMEM;
+
+		bufp = ascii_buf;
+		for (i = 0; i < p->blob_len; i++)
+			bufp = hex_byte_pack(bufp, p->blob[i]);
+		if (copy_to_user(buffer, ascii_buf, 2 * p->blob_len) != 0) {
+			kzfree(ascii_buf);
+			return -EFAULT;
+		}
+		kzfree(ascii_buf);
+	}
+	return 2 * p->blob_len;
+}
+
+/*
+ * trusted_destroy - clear and free the key's payload
+ */
+static void trusted_destroy(struct key *key)
+{
+	kzfree(key->payload.data[0]);
+}
+
+struct key_type key_type_trusted = {
+	.name = "trusted",
+	.instantiate = trusted_instantiate,
+	.update = trusted_update,
+	.destroy = trusted_destroy,
+	.describe = user_describe,
+	.read = trusted_read,
+};
+EXPORT_SYMBOL_GPL(key_type_trusted);
+
+static int __init init_trusted(void)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < sizeof(available_tk_ops); i++) {
+		tk_ops = available_tk_ops[i];
+
+		if (!(tk_ops && tk_ops->init && tk_ops->seal &&
+		      tk_ops->unseal && tk_ops->get_random))
+			continue;
+
+		ret = tk_ops->init();
+		if (ret) {
+			if (tk_ops->cleanup)
+				tk_ops->cleanup();
+		} else {
+			break;
+		}
+	}
+
+	if (ret < 0)
+		pr_info("trusted_key: init failed (%d)\n", ret);
+	/*
+	 * encrypted_keys.ko depends on successful load of this module even if
+	 * trusted key implementation is not found.
+	 */
+	return 0;
+}
+
+static void __exit cleanup_trusted(void)
+{
+	if (tk_ops->cleanup)
+		tk_ops->cleanup();
+}
+
+late_initcall(init_trusted);
+module_exit(cleanup_trusted);
+
+MODULE_LICENSE("GPL");
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
deleted file mode 100644
index 9a94672..0000000
--- a/security/keys/trusted.c
+++ /dev/null
@@ -1,1295 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2010 IBM Corporation
- *
- * Author:
- * David Safford <safford@us.ibm.com>
- *
- * See Documentation/security/keys/trusted-encrypted.rst
- */
-
-#include <crypto/hash_info.h>
-#include <linux/uaccess.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/parser.h>
-#include <linux/string.h>
-#include <linux/err.h>
-#include <keys/user-type.h>
-#include <keys/trusted-type.h>
-#include <linux/key-type.h>
-#include <linux/rcupdate.h>
-#include <linux/crypto.h>
-#include <crypto/hash.h>
-#include <crypto/sha.h>
-#include <linux/capability.h>
-#include <linux/tpm.h>
-#include <linux/tpm_command.h>
-
-#include <keys/trusted.h>
-
-static const char hmac_alg[] = "hmac(sha1)";
-static const char hash_alg[] = "sha1";
-static struct tpm_chip *chip;
-static struct tpm_digest *digests;
-
-struct sdesc {
-	struct shash_desc shash;
-	char ctx[];
-};
-
-static struct crypto_shash *hashalg;
-static struct crypto_shash *hmacalg;
-
-static struct sdesc *init_sdesc(struct crypto_shash *alg)
-{
-	struct sdesc *sdesc;
-	int size;
-
-	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
-	sdesc = kmalloc(size, GFP_KERNEL);
-	if (!sdesc)
-		return ERR_PTR(-ENOMEM);
-	sdesc->shash.tfm = alg;
-	return sdesc;
-}
-
-static int TSS_sha1(const unsigned char *data, unsigned int datalen,
-		    unsigned char *digest)
-{
-	struct sdesc *sdesc;
-	int ret;
-
-	sdesc = init_sdesc(hashalg);
-	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
-		return PTR_ERR(sdesc);
-	}
-
-	ret = crypto_shash_digest(&sdesc->shash, data, datalen, digest);
-	kzfree(sdesc);
-	return ret;
-}
-
-static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
-		       unsigned int keylen, ...)
-{
-	struct sdesc *sdesc;
-	va_list argp;
-	unsigned int dlen;
-	unsigned char *data;
-	int ret;
-
-	sdesc = init_sdesc(hmacalg);
-	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hmac_alg);
-		return PTR_ERR(sdesc);
-	}
-
-	ret = crypto_shash_setkey(hmacalg, key, keylen);
-	if (ret < 0)
-		goto out;
-	ret = crypto_shash_init(&sdesc->shash);
-	if (ret < 0)
-		goto out;
-
-	va_start(argp, keylen);
-	for (;;) {
-		dlen = va_arg(argp, unsigned int);
-		if (dlen == 0)
-			break;
-		data = va_arg(argp, unsigned char *);
-		if (data == NULL) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = crypto_shash_update(&sdesc->shash, data, dlen);
-		if (ret < 0)
-			break;
-	}
-	va_end(argp);
-	if (!ret)
-		ret = crypto_shash_final(&sdesc->shash, digest);
-out:
-	kzfree(sdesc);
-	return ret;
-}
-
-/*
- * calculate authorization info fields to send to TPM
- */
-int TSS_authhmac(unsigned char *digest, const unsigned char *key,
-			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned int h3, ...)
-{
-	unsigned char paramdigest[SHA1_DIGEST_SIZE];
-	struct sdesc *sdesc;
-	unsigned int dlen;
-	unsigned char *data;
-	unsigned char c;
-	int ret;
-	va_list argp;
-
-	if (!chip)
-		return -ENODEV;
-
-	sdesc = init_sdesc(hashalg);
-	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
-		return PTR_ERR(sdesc);
-	}
-
-	c = !!h3;
-	ret = crypto_shash_init(&sdesc->shash);
-	if (ret < 0)
-		goto out;
-	va_start(argp, h3);
-	for (;;) {
-		dlen = va_arg(argp, unsigned int);
-		if (dlen == 0)
-			break;
-		data = va_arg(argp, unsigned char *);
-		if (!data) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = crypto_shash_update(&sdesc->shash, data, dlen);
-		if (ret < 0)
-			break;
-	}
-	va_end(argp);
-	if (!ret)
-		ret = crypto_shash_final(&sdesc->shash, paramdigest);
-	if (!ret)
-		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
-				  paramdigest, TPM_NONCE_SIZE, h1,
-				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
-out:
-	kzfree(sdesc);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(TSS_authhmac);
-
-/*
- * verify the AUTH1_COMMAND (Seal) result from TPM
- */
-int TSS_checkhmac1(unsigned char *buffer,
-			  const uint32_t command,
-			  const unsigned char *ononce,
-			  const unsigned char *key,
-			  unsigned int keylen, ...)
-{
-	uint32_t bufsize;
-	uint16_t tag;
-	uint32_t ordinal;
-	uint32_t result;
-	unsigned char *enonce;
-	unsigned char *continueflag;
-	unsigned char *authdata;
-	unsigned char testhmac[SHA1_DIGEST_SIZE];
-	unsigned char paramdigest[SHA1_DIGEST_SIZE];
-	struct sdesc *sdesc;
-	unsigned int dlen;
-	unsigned int dpos;
-	va_list argp;
-	int ret;
-
-	if (!chip)
-		return -ENODEV;
-
-	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
-	tag = LOAD16(buffer, 0);
-	ordinal = command;
-	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
-	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
-	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
-		return -EINVAL;
-	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
-	continueflag = authdata - 1;
-	enonce = continueflag - TPM_NONCE_SIZE;
-
-	sdesc = init_sdesc(hashalg);
-	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
-		return PTR_ERR(sdesc);
-	}
-	ret = crypto_shash_init(&sdesc->shash);
-	if (ret < 0)
-		goto out;
-	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
-				  sizeof result);
-	if (ret < 0)
-		goto out;
-	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
-				  sizeof ordinal);
-	if (ret < 0)
-		goto out;
-	va_start(argp, keylen);
-	for (;;) {
-		dlen = va_arg(argp, unsigned int);
-		if (dlen == 0)
-			break;
-		dpos = va_arg(argp, unsigned int);
-		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
-		if (ret < 0)
-			break;
-	}
-	va_end(argp);
-	if (!ret)
-		ret = crypto_shash_final(&sdesc->shash, paramdigest);
-	if (ret < 0)
-		goto out;
-
-	ret = TSS_rawhmac(testhmac, key, keylen, SHA1_DIGEST_SIZE, paramdigest,
-			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
-			  1, continueflag, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
-		ret = -EINVAL;
-out:
-	kzfree(sdesc);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(TSS_checkhmac1);
-
-/*
- * verify the AUTH2_COMMAND (unseal) result from TPM
- */
-static int TSS_checkhmac2(unsigned char *buffer,
-			  const uint32_t command,
-			  const unsigned char *ononce,
-			  const unsigned char *key1,
-			  unsigned int keylen1,
-			  const unsigned char *key2,
-			  unsigned int keylen2, ...)
-{
-	uint32_t bufsize;
-	uint16_t tag;
-	uint32_t ordinal;
-	uint32_t result;
-	unsigned char *enonce1;
-	unsigned char *continueflag1;
-	unsigned char *authdata1;
-	unsigned char *enonce2;
-	unsigned char *continueflag2;
-	unsigned char *authdata2;
-	unsigned char testhmac1[SHA1_DIGEST_SIZE];
-	unsigned char testhmac2[SHA1_DIGEST_SIZE];
-	unsigned char paramdigest[SHA1_DIGEST_SIZE];
-	struct sdesc *sdesc;
-	unsigned int dlen;
-	unsigned int dpos;
-	va_list argp;
-	int ret;
-
-	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
-	tag = LOAD16(buffer, 0);
-	ordinal = command;
-	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
-
-	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
-	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
-		return -EINVAL;
-	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
-			+ SHA1_DIGEST_SIZE + SHA1_DIGEST_SIZE);
-	authdata2 = buffer + bufsize - (SHA1_DIGEST_SIZE);
-	continueflag1 = authdata1 - 1;
-	continueflag2 = authdata2 - 1;
-	enonce1 = continueflag1 - TPM_NONCE_SIZE;
-	enonce2 = continueflag2 - TPM_NONCE_SIZE;
-
-	sdesc = init_sdesc(hashalg);
-	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
-		return PTR_ERR(sdesc);
-	}
-	ret = crypto_shash_init(&sdesc->shash);
-	if (ret < 0)
-		goto out;
-	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
-				  sizeof result);
-	if (ret < 0)
-		goto out;
-	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
-				  sizeof ordinal);
-	if (ret < 0)
-		goto out;
-
-	va_start(argp, keylen2);
-	for (;;) {
-		dlen = va_arg(argp, unsigned int);
-		if (dlen == 0)
-			break;
-		dpos = va_arg(argp, unsigned int);
-		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
-		if (ret < 0)
-			break;
-	}
-	va_end(argp);
-	if (!ret)
-		ret = crypto_shash_final(&sdesc->shash, paramdigest);
-	if (ret < 0)
-		goto out;
-
-	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
-			  paramdigest, TPM_NONCE_SIZE, enonce1,
-			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
-	if (ret < 0)
-		goto out;
-	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
-		ret = -EINVAL;
-		goto out;
-	}
-	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
-			  paramdigest, TPM_NONCE_SIZE, enonce2,
-			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
-	if (ret < 0)
-		goto out;
-	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
-		ret = -EINVAL;
-out:
-	kzfree(sdesc);
-	return ret;
-}
-
-/*
- * For key specific tpm requests, we will generate and send our
- * own TPM command packets using the drivers send function.
- */
-int trusted_tpm_send(unsigned char *cmd, size_t buflen)
-{
-	int rc;
-
-	if (!chip)
-		return -ENODEV;
-
-	dump_tpm_buf(cmd);
-	rc = tpm_send(chip, cmd, buflen);
-	dump_tpm_buf(cmd);
-	if (rc > 0)
-		/* Can't return positive return codes values to keyctl */
-		rc = -EPERM;
-	return rc;
-}
-EXPORT_SYMBOL_GPL(trusted_tpm_send);
-
-/*
- * Lock a trusted key, by extending a selected PCR.
- *
- * Prevents a trusted key that is sealed to PCRs from being accessed.
- * This uses the tpm driver's extend function.
- */
-static int pcrlock(const int pcrnum)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
-}
-
-/*
- * Create an object specific authorisation protocol (OSAP) session
- */
-static int osap(struct tpm_buf *tb, struct osapsess *s,
-		const unsigned char *key, uint16_t type, uint32_t handle)
-{
-	unsigned char enonce[TPM_NONCE_SIZE];
-	unsigned char ononce[TPM_NONCE_SIZE];
-	int ret;
-
-	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
-	if (ret != TPM_NONCE_SIZE)
-		return ret;
-
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OSAP_SIZE);
-	store32(tb, TPM_ORD_OSAP);
-	store16(tb, type);
-	store32(tb, handle);
-	storebytes(tb, ononce, TPM_NONCE_SIZE);
-
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
-	if (ret < 0)
-		return ret;
-
-	s->handle = LOAD32(tb->data, TPM_DATA_OFFSET);
-	memcpy(s->enonce, &(tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)]),
-	       TPM_NONCE_SIZE);
-	memcpy(enonce, &(tb->data[TPM_DATA_OFFSET + sizeof(uint32_t) +
-				  TPM_NONCE_SIZE]), TPM_NONCE_SIZE);
-	return TSS_rawhmac(s->secret, key, SHA1_DIGEST_SIZE, TPM_NONCE_SIZE,
-			   enonce, TPM_NONCE_SIZE, ononce, 0, 0);
-}
-
-/*
- * Create an object independent authorisation protocol (oiap) session
- */
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
-{
-	int ret;
-
-	if (!chip)
-		return -ENODEV;
-
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OIAP_SIZE);
-	store32(tb, TPM_ORD_OIAP);
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
-	if (ret < 0)
-		return ret;
-
-	*handle = LOAD32(tb->data, TPM_DATA_OFFSET);
-	memcpy(nonce, &tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)],
-	       TPM_NONCE_SIZE);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(oiap);
-
-struct tpm_digests {
-	unsigned char encauth[SHA1_DIGEST_SIZE];
-	unsigned char pubauth[SHA1_DIGEST_SIZE];
-	unsigned char xorwork[SHA1_DIGEST_SIZE * 2];
-	unsigned char xorhash[SHA1_DIGEST_SIZE];
-	unsigned char nonceodd[TPM_NONCE_SIZE];
-};
-
-/*
- * Have the TPM seal(encrypt) the trusted key, possibly based on
- * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
- */
-static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
-		    uint32_t keyhandle, const unsigned char *keyauth,
-		    const unsigned char *data, uint32_t datalen,
-		    unsigned char *blob, uint32_t *bloblen,
-		    const unsigned char *blobauth,
-		    const unsigned char *pcrinfo, uint32_t pcrinfosize)
-{
-	struct osapsess sess;
-	struct tpm_digests *td;
-	unsigned char cont;
-	uint32_t ordinal;
-	uint32_t pcrsize;
-	uint32_t datsize;
-	int sealinfosize;
-	int encdatasize;
-	int storedsize;
-	int ret;
-	int i;
-
-	/* alloc some work space for all the hashes */
-	td = kmalloc(sizeof *td, GFP_KERNEL);
-	if (!td)
-		return -ENOMEM;
-
-	/* get session for sealing key */
-	ret = osap(tb, &sess, keyauth, keytype, keyhandle);
-	if (ret < 0)
-		goto out;
-	dump_sess(&sess);
-
-	/* calculate encrypted authorization value */
-	memcpy(td->xorwork, sess.secret, SHA1_DIGEST_SIZE);
-	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
-	ret = TSS_sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
-	if (ret < 0)
-		goto out;
-
-	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
-	if (ret != TPM_NONCE_SIZE)
-		goto out;
-	ordinal = htonl(TPM_ORD_SEAL);
-	datsize = htonl(datalen);
-	pcrsize = htonl(pcrinfosize);
-	cont = 0;
-
-	/* encrypt data authorization key */
-	for (i = 0; i < SHA1_DIGEST_SIZE; ++i)
-		td->encauth[i] = td->xorhash[i] ^ blobauth[i];
-
-	/* calculate authorization HMAC value */
-	if (pcrinfosize == 0) {
-		/* no pcr info specified */
-		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
-				   sess.enonce, td->nonceodd, cont,
-				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
-				   td->encauth, sizeof(uint32_t), &pcrsize,
-				   sizeof(uint32_t), &datsize, datalen, data, 0,
-				   0);
-	} else {
-		/* pcr info specified */
-		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
-				   sess.enonce, td->nonceodd, cont,
-				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
-				   td->encauth, sizeof(uint32_t), &pcrsize,
-				   pcrinfosize, pcrinfo, sizeof(uint32_t),
-				   &datsize, datalen, data, 0, 0);
-	}
-	if (ret < 0)
-		goto out;
-
-	/* build and send the TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_SEAL_SIZE + pcrinfosize + datalen);
-	store32(tb, TPM_ORD_SEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, td->encauth, SHA1_DIGEST_SIZE);
-	store32(tb, pcrinfosize);
-	storebytes(tb, pcrinfo, pcrinfosize);
-	store32(tb, datalen);
-	storebytes(tb, data, datalen);
-	store32(tb, sess.handle);
-	storebytes(tb, td->nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, td->pubauth, SHA1_DIGEST_SIZE);
-
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
-	if (ret < 0)
-		goto out;
-
-	/* calculate the size of the returned Blob */
-	sealinfosize = LOAD32(tb->data, TPM_DATA_OFFSET + sizeof(uint32_t));
-	encdatasize = LOAD32(tb->data, TPM_DATA_OFFSET + sizeof(uint32_t) +
-			     sizeof(uint32_t) + sealinfosize);
-	storedsize = sizeof(uint32_t) + sizeof(uint32_t) + sealinfosize +
-	    sizeof(uint32_t) + encdatasize;
-
-	/* check the HMAC in the response */
-	ret = TSS_checkhmac1(tb->data, ordinal, td->nonceodd, sess.secret,
-			     SHA1_DIGEST_SIZE, storedsize, TPM_DATA_OFFSET, 0,
-			     0);
-
-	/* copy the returned blob to caller */
-	if (!ret) {
-		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
-		*bloblen = storedsize;
-	}
-out:
-	kzfree(td);
-	return ret;
-}
-
-/*
- * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
- */
-static int tpm_unseal(struct tpm_buf *tb,
-		      uint32_t keyhandle, const unsigned char *keyauth,
-		      const unsigned char *blob, int bloblen,
-		      const unsigned char *blobauth,
-		      unsigned char *data, unsigned int *datalen)
-{
-	unsigned char nonceodd[TPM_NONCE_SIZE];
-	unsigned char enonce1[TPM_NONCE_SIZE];
-	unsigned char enonce2[TPM_NONCE_SIZE];
-	unsigned char authdata1[SHA1_DIGEST_SIZE];
-	unsigned char authdata2[SHA1_DIGEST_SIZE];
-	uint32_t authhandle1 = 0;
-	uint32_t authhandle2 = 0;
-	unsigned char cont = 0;
-	uint32_t ordinal;
-	uint32_t keyhndl;
-	int ret;
-
-	/* sessions for unsealing key and data */
-	ret = oiap(tb, &authhandle1, enonce1);
-	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
-		return ret;
-	}
-	ret = oiap(tb, &authhandle2, enonce2);
-	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
-		return ret;
-	}
-
-	ordinal = htonl(TPM_ORD_UNSEAL);
-	keyhndl = htonl(SRKHANDLE);
-	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
-	if (ret != TPM_NONCE_SIZE) {
-		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
-		return ret;
-	}
-	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
-			   enonce1, nonceodd, cont, sizeof(uint32_t),
-			   &ordinal, bloblen, blob, 0, 0);
-	if (ret < 0)
-		return ret;
-	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
-			   enonce2, nonceodd, cont, sizeof(uint32_t),
-			   &ordinal, bloblen, blob, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	/* build and send TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH2_COMMAND);
-	store32(tb, TPM_UNSEAL_SIZE + bloblen);
-	store32(tb, TPM_ORD_UNSEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle1);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata1, SHA1_DIGEST_SIZE);
-	store32(tb, authhandle2);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata2, SHA1_DIGEST_SIZE);
-
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
-	if (ret < 0) {
-		pr_info("trusted_key: authhmac failed (%d)\n", ret);
-		return ret;
-	}
-
-	*datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
-	ret = TSS_checkhmac2(tb->data, ordinal, nonceodd,
-			     keyauth, SHA1_DIGEST_SIZE,
-			     blobauth, SHA1_DIGEST_SIZE,
-			     sizeof(uint32_t), TPM_DATA_OFFSET,
-			     *datalen, TPM_DATA_OFFSET + sizeof(uint32_t), 0,
-			     0);
-	if (ret < 0) {
-		pr_info("trusted_key: TSS_checkhmac2 failed (%d)\n", ret);
-		return ret;
-	}
-	memcpy(data, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t), *datalen);
-	return 0;
-}
-
-/*
- * Have the TPM seal(encrypt) the symmetric key
- */
-static int key_seal(struct trusted_key_payload *p,
-		    struct trusted_key_options *o)
-{
-	struct tpm_buf *tb;
-	int ret;
-
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
-
-	/* include migratable flag at end of sealed key */
-	p->key[p->key_len] = p->migratable;
-
-	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
-		       p->key, p->key_len + 1, p->blob, &p->blob_len,
-		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
-	if (ret < 0)
-		pr_info("trusted_key: srkseal failed (%d)\n", ret);
-
-	kzfree(tb);
-	return ret;
-}
-
-/*
- * Have the TPM unseal(decrypt) the symmetric key
- */
-static int key_unseal(struct trusted_key_payload *p,
-		      struct trusted_key_options *o)
-{
-	struct tpm_buf *tb;
-	int ret;
-
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
-
-	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
-			 o->blobauth, p->key, &p->key_len);
-	if (ret < 0)
-		pr_info("trusted_key: srkunseal failed (%d)\n", ret);
-	else
-		/* pull migratable flag out of sealed key */
-		p->migratable = p->key[--p->key_len];
-
-	kzfree(tb);
-	return ret;
-}
-
-enum {
-	Opt_err,
-	Opt_new, Opt_load, Opt_update,
-	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
-	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
-	Opt_hash,
-	Opt_policydigest,
-	Opt_policyhandle,
-};
-
-static const match_table_t key_tokens = {
-	{Opt_new, "new"},
-	{Opt_load, "load"},
-	{Opt_update, "update"},
-	{Opt_keyhandle, "keyhandle=%s"},
-	{Opt_keyauth, "keyauth=%s"},
-	{Opt_blobauth, "blobauth=%s"},
-	{Opt_pcrinfo, "pcrinfo=%s"},
-	{Opt_pcrlock, "pcrlock=%s"},
-	{Opt_migratable, "migratable=%s"},
-	{Opt_hash, "hash=%s"},
-	{Opt_policydigest, "policydigest=%s"},
-	{Opt_policyhandle, "policyhandle=%s"},
-	{Opt_err, NULL}
-};
-
-/* can have zero or more token= options */
-static int getoptions(char *c, struct trusted_key_payload *pay,
-		      struct trusted_key_options *opt)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p = c;
-	int token;
-	int res;
-	unsigned long handle;
-	unsigned long lock;
-	unsigned long token_mask = 0;
-	unsigned int digest_len;
-	int i;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return tpm2;
-
-	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
-
-	while ((p = strsep(&c, " \t"))) {
-		if (*p == '\0' || *p == ' ' || *p == '\t')
-			continue;
-		token = match_token(p, key_tokens, args);
-		if (test_and_set_bit(token, &token_mask))
-			return -EINVAL;
-
-		switch (token) {
-		case Opt_pcrinfo:
-			opt->pcrinfo_len = strlen(args[0].from) / 2;
-			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
-				return -EINVAL;
-			res = hex2bin(opt->pcrinfo, args[0].from,
-				      opt->pcrinfo_len);
-			if (res < 0)
-				return -EINVAL;
-			break;
-		case Opt_keyhandle:
-			res = kstrtoul(args[0].from, 16, &handle);
-			if (res < 0)
-				return -EINVAL;
-			opt->keytype = SEAL_keytype;
-			opt->keyhandle = handle;
-			break;
-		case Opt_keyauth:
-			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
-				return -EINVAL;
-			res = hex2bin(opt->keyauth, args[0].from,
-				      SHA1_DIGEST_SIZE);
-			if (res < 0)
-				return -EINVAL;
-			break;
-		case Opt_blobauth:
-			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
-				return -EINVAL;
-			res = hex2bin(opt->blobauth, args[0].from,
-				      SHA1_DIGEST_SIZE);
-			if (res < 0)
-				return -EINVAL;
-			break;
-		case Opt_migratable:
-			if (*args[0].from == '0')
-				pay->migratable = 0;
-			else
-				return -EINVAL;
-			break;
-		case Opt_pcrlock:
-			res = kstrtoul(args[0].from, 10, &lock);
-			if (res < 0)
-				return -EINVAL;
-			opt->pcrlock = lock;
-			break;
-		case Opt_hash:
-			if (test_bit(Opt_policydigest, &token_mask))
-				return -EINVAL;
-			for (i = 0; i < HASH_ALGO__LAST; i++) {
-				if (!strcmp(args[0].from, hash_algo_name[i])) {
-					opt->hash = i;
-					break;
-				}
-			}
-			if (i == HASH_ALGO__LAST)
-				return -EINVAL;
-			if  (!tpm2 && i != HASH_ALGO_SHA1) {
-				pr_info("trusted_key: TPM 1.x only supports SHA-1.\n");
-				return -EINVAL;
-			}
-			break;
-		case Opt_policydigest:
-			digest_len = hash_digest_size[opt->hash];
-			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
-				return -EINVAL;
-			res = hex2bin(opt->policydigest, args[0].from,
-				      digest_len);
-			if (res < 0)
-				return -EINVAL;
-			opt->policydigest_len = digest_len;
-			break;
-		case Opt_policyhandle:
-			if (!tpm2)
-				return -EINVAL;
-			res = kstrtoul(args[0].from, 16, &handle);
-			if (res < 0)
-				return -EINVAL;
-			opt->policyhandle = handle;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-
-/*
- * datablob_parse - parse the keyctl data and fill in the
- * 		    payload and options structures
- *
- * On success returns 0, otherwise -EINVAL.
- */
-static int datablob_parse(char *datablob, struct trusted_key_payload *p,
-			  struct trusted_key_options *o)
-{
-	substring_t args[MAX_OPT_ARGS];
-	long keylen;
-	int ret = -EINVAL;
-	int key_cmd;
-	char *c;
-
-	/* main command */
-	c = strsep(&datablob, " \t");
-	if (!c)
-		return -EINVAL;
-	key_cmd = match_token(c, key_tokens, args);
-	switch (key_cmd) {
-	case Opt_new:
-		/* first argument is key size */
-		c = strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		ret = kstrtol(c, 10, &keylen);
-		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
-			return -EINVAL;
-		p->key_len = keylen;
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_new;
-		break;
-	case Opt_load:
-		/* first argument is sealed blob */
-		c = strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		p->blob_len = strlen(c) / 2;
-		if (p->blob_len > MAX_BLOB_SIZE)
-			return -EINVAL;
-		ret = hex2bin(p->blob, c, p->blob_len);
-		if (ret < 0)
-			return -EINVAL;
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_load;
-		break;
-	case Opt_update:
-		/* all arguments are options */
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_update;
-		break;
-	case Opt_err:
-		return -EINVAL;
-		break;
-	}
-	return ret;
-}
-
-static struct trusted_key_options *trusted_options_alloc(void)
-{
-	struct trusted_key_options *options;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return NULL;
-
-	options = kzalloc(sizeof *options, GFP_KERNEL);
-	if (options) {
-		/* set any non-zero defaults */
-		options->keytype = SRK_keytype;
-
-		if (!tpm2)
-			options->keyhandle = SRKHANDLE;
-	}
-	return options;
-}
-
-static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
-{
-	struct trusted_key_payload *p = NULL;
-	int ret;
-
-	ret = key_payload_reserve(key, sizeof *p);
-	if (ret < 0)
-		return p;
-	p = kzalloc(sizeof *p, GFP_KERNEL);
-	if (p)
-		p->migratable = 1; /* migratable by default */
-	return p;
-}
-
-/*
- * trusted_instantiate - create a new trusted key
- *
- * Unseal an existing trusted blob or, for a new key, get a
- * random key, then seal and create a trusted key-type key,
- * adding it to the specified keyring.
- *
- * On success, return 0. Otherwise return errno.
- */
-static int trusted_instantiate(struct key *key,
-			       struct key_preparsed_payload *prep)
-{
-	struct trusted_key_payload *payload = NULL;
-	struct trusted_key_options *options = NULL;
-	size_t datalen = prep->datalen;
-	char *datablob;
-	int ret = 0;
-	int key_cmd;
-	size_t key_len;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return tpm2;
-
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
-
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
-		return -ENOMEM;
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] = '\0';
-
-	options = trusted_options_alloc();
-	if (!options) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	payload = trusted_payload_alloc(key);
-	if (!payload) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	key_cmd = datablob_parse(datablob, payload, options);
-	if (key_cmd < 0) {
-		ret = key_cmd;
-		goto out;
-	}
-
-	if (!options->keyhandle) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	dump_payload(payload);
-	dump_options(options);
-
-	switch (key_cmd) {
-	case Opt_load:
-		if (tpm2)
-			ret = tpm_unseal_trusted(chip, payload, options);
-		else
-			ret = key_unseal(payload, options);
-		dump_payload(payload);
-		dump_options(options);
-		if (ret < 0)
-			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
-		break;
-	case Opt_new:
-		key_len = payload->key_len;
-		ret = tpm_get_random(chip, payload->key, key_len);
-		if (ret != key_len) {
-			pr_info("trusted_key: key_create failed (%d)\n", ret);
-			goto out;
-		}
-		if (tpm2)
-			ret = tpm_seal_trusted(chip, payload, options);
-		else
-			ret = key_seal(payload, options);
-		if (ret < 0)
-			pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		break;
-	default:
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!ret && options->pcrlock)
-		ret = pcrlock(options->pcrlock);
-out:
-	kzfree(datablob);
-	kzfree(options);
-	if (!ret)
-		rcu_assign_keypointer(key, payload);
-	else
-		kzfree(payload);
-	return ret;
-}
-
-static void trusted_rcu_free(struct rcu_head *rcu)
-{
-	struct trusted_key_payload *p;
-
-	p = container_of(rcu, struct trusted_key_payload, rcu);
-	kzfree(p);
-}
-
-/*
- * trusted_update - reseal an existing key with new PCR values
- */
-static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
-{
-	struct trusted_key_payload *p;
-	struct trusted_key_payload *new_p;
-	struct trusted_key_options *new_o;
-	size_t datalen = prep->datalen;
-	char *datablob;
-	int ret = 0;
-
-	if (key_is_negative(key))
-		return -ENOKEY;
-	p = key->payload.data[0];
-	if (!p->migratable)
-		return -EPERM;
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
-
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
-		return -ENOMEM;
-	new_o = trusted_options_alloc();
-	if (!new_o) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	new_p = trusted_payload_alloc(key);
-	if (!new_p) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] = '\0';
-	ret = datablob_parse(datablob, new_p, new_o);
-	if (ret != Opt_update) {
-		ret = -EINVAL;
-		kzfree(new_p);
-		goto out;
-	}
-
-	if (!new_o->keyhandle) {
-		ret = -EINVAL;
-		kzfree(new_p);
-		goto out;
-	}
-
-	/* copy old key values, and reseal with new pcrs */
-	new_p->migratable = p->migratable;
-	new_p->key_len = p->key_len;
-	memcpy(new_p->key, p->key, p->key_len);
-	dump_payload(p);
-	dump_payload(new_p);
-
-	ret = key_seal(new_p, new_o);
-	if (ret < 0) {
-		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kzfree(new_p);
-		goto out;
-	}
-	if (new_o->pcrlock) {
-		ret = pcrlock(new_o->pcrlock);
-		if (ret < 0) {
-			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kzfree(new_p);
-			goto out;
-		}
-	}
-	rcu_assign_keypointer(key, new_p);
-	call_rcu(&p->rcu, trusted_rcu_free);
-out:
-	kzfree(datablob);
-	kzfree(new_o);
-	return ret;
-}
-
-/*
- * trusted_read - copy the sealed blob data to userspace in hex.
- * On success, return to userspace the trusted key datablob size.
- */
-static long trusted_read(const struct key *key, char __user *buffer,
-			 size_t buflen)
-{
-	const struct trusted_key_payload *p;
-	char *ascii_buf;
-	char *bufp;
-	int i;
-
-	p = dereference_key_locked(key);
-	if (!p)
-		return -EINVAL;
-
-	if (buffer && buflen >= 2 * p->blob_len) {
-		ascii_buf = kmalloc_array(2, p->blob_len, GFP_KERNEL);
-		if (!ascii_buf)
-			return -ENOMEM;
-
-		bufp = ascii_buf;
-		for (i = 0; i < p->blob_len; i++)
-			bufp = hex_byte_pack(bufp, p->blob[i]);
-		if (copy_to_user(buffer, ascii_buf, 2 * p->blob_len) != 0) {
-			kzfree(ascii_buf);
-			return -EFAULT;
-		}
-		kzfree(ascii_buf);
-	}
-	return 2 * p->blob_len;
-}
-
-/*
- * trusted_destroy - clear and free the key's payload
- */
-static void trusted_destroy(struct key *key)
-{
-	kzfree(key->payload.data[0]);
-}
-
-struct key_type key_type_trusted = {
-	.name = "trusted",
-	.instantiate = trusted_instantiate,
-	.update = trusted_update,
-	.destroy = trusted_destroy,
-	.describe = user_describe,
-	.read = trusted_read,
-};
-
-EXPORT_SYMBOL_GPL(key_type_trusted);
-
-static void trusted_shash_release(void)
-{
-	if (hashalg)
-		crypto_free_shash(hashalg);
-	if (hmacalg)
-		crypto_free_shash(hmacalg);
-}
-
-static int __init trusted_shash_alloc(void)
-{
-	int ret;
-
-	hmacalg = crypto_alloc_shash(hmac_alg, 0, 0);
-	if (IS_ERR(hmacalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
-			hmac_alg);
-		return PTR_ERR(hmacalg);
-	}
-
-	hashalg = crypto_alloc_shash(hash_alg, 0, 0);
-	if (IS_ERR(hashalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
-			hash_alg);
-		ret = PTR_ERR(hashalg);
-		goto hashalg_fail;
-	}
-
-	return 0;
-
-hashalg_fail:
-	crypto_free_shash(hmacalg);
-	return ret;
-}
-
-static int __init init_digests(void)
-{
-	u8 digest[TPM_MAX_DIGEST_SIZE];
-	int ret;
-	int i;
-
-	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
-
-	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
-			  GFP_KERNEL);
-	if (!digests)
-		return -ENOMEM;
-
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
-
-	return 0;
-}
-
-static int __init init_trusted(void)
-{
-	int ret;
-
-	/* encrypted_keys.ko depends on successful load of this module even if
-	 * TPM is not used.
-	 */
-	chip = tpm_default_chip();
-	if (!chip)
-		return 0;
-
-	ret = init_digests();
-	if (ret < 0)
-		goto err_put;
-	ret = trusted_shash_alloc();
-	if (ret < 0)
-		goto err_free;
-	ret = register_key_type(&key_type_trusted);
-	if (ret < 0)
-		goto err_release;
-	return 0;
-err_release:
-	trusted_shash_release();
-err_free:
-	kfree(digests);
-err_put:
-	put_device(&chip->dev);
-	return ret;
-}
-
-static void __exit cleanup_trusted(void)
-{
-	if (chip) {
-		put_device(&chip->dev);
-		kfree(digests);
-		trusted_shash_release();
-		unregister_key_type(&key_type_trusted);
-	}
-}
-
-late_initcall(init_trusted);
-module_exit(cleanup_trusted);
-
-MODULE_LICENSE("GPL");
-- 
2.7.4

