Return-Path: <linux-integrity+bounces-597-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55C822020
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5462A283D3F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926C154A8;
	Tue,  2 Jan 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kSTFoHIA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAB15494;
	Tue,  2 Jan 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704215453;
	bh=hanOKBxRLakWmH9UUqQaedVWQLb/WJS0hy5D+2/dQkA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=kSTFoHIAFqaPa9dLumqvMPDewTfynR2rNBR2soWRG+zLvnREyYM8eQRyFmfPeBQnN
	 rGj5MfDlxvPYWQVq1bhoI8gQ8KdskAW3ZziurxWhKLnUR4xF/fu+kDgtQFXgH3mN5P
	 qZrA7W8Vg3Jfe7+Xiccwmt8HqaIk+YJzRMBEm3JY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id AC7511286828;
	Tue,  2 Jan 2024 12:10:53 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id nWteLaAdsRZG; Tue,  2 Jan 2024 12:10:53 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0AE991286813;
	Tue,  2 Jan 2024 12:10:52 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v6 09/20] crypto: lib - implement library version of AES in CFB mode
Date: Tue,  2 Jan 2024 12:03:57 -0500
Message-Id: <20240102170408.21969-10-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

Implement AES in CFB mode using the existing, mostly constant-time
generic AES library implementation. This will be used by the TPM code
to encrypt communications with TPM hardware, which is often a discrete
component connected using sniffable wires or traces.

While a CFB template does exist, using a skcipher is a major pain for
non-performance critical synchronous crypto where the algorithm is known
at compile time and the data is in contiguous buffers with valid kernel
virtual addresses.

Tested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/all/20230216201410.15010-1-James.Bottomley@HansenPartnership.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/crypto/aes.h |   5 +
 lib/crypto/Kconfig   |   5 +
 lib/crypto/Makefile  |   3 +
 lib/crypto/aescfb.c  | 257 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 lib/crypto/aescfb.c

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 2090729701ab..9339da7c20a8 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -87,4 +87,9 @@ void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
 extern const u8 crypto_aes_sbox[];
 extern const u8 crypto_aes_inv_sbox[];
 
+void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 iv[AES_BLOCK_SIZE]);
+void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 iv[AES_BLOCK_SIZE]);
+
 #endif
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 45436bfc6dff..b01253cac70a 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -8,6 +8,11 @@ config CRYPTO_LIB_UTILS
 config CRYPTO_LIB_AES
 	tristate
 
+config CRYPTO_LIB_AESCFB
+	tristate
+	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_UTILS
+
 config CRYPTO_LIB_AESGCM
 	tristate
 	select CRYPTO_LIB_AES
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 8d1446c2be71..969baab8c805 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
 obj-$(CONFIG_CRYPTO_LIB_AES)			+= libaes.o
 libaes-y					:= aes.o
 
+obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
+libaescfb-y					:= aescfb.o
+
 obj-$(CONFIG_CRYPTO_LIB_AESGCM)			+= libaesgcm.o
 libaesgcm-y					:= aesgcm.o
 
diff --git a/lib/crypto/aescfb.c b/lib/crypto/aescfb.c
new file mode 100644
index 000000000000..749dc1258a44
--- /dev/null
+++ b/lib/crypto/aescfb.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Minimal library implementation of AES in CFB mode
+ *
+ * Copyright 2023 Google LLC
+ */
+
+#include <linux/module.h>
+
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+
+#include <asm/irqflags.h>
+
+static void aescfb_encrypt_block(const struct crypto_aes_ctx *ctx, void *dst,
+				 const void *src)
+{
+	unsigned long flags;
+
+	/*
+	 * In AES-CFB, the AES encryption operates on known 'plaintext' (the IV
+	 * and ciphertext), making it susceptible to timing attacks on the
+	 * encryption key. The AES library already mitigates this risk to some
+	 * extent by pulling the entire S-box into the caches before doing any
+	 * substitutions, but this strategy is more effective when running with
+	 * interrupts disabled.
+	 */
+	local_irq_save(flags);
+	aes_encrypt(ctx, dst, src);
+	local_irq_restore(flags);
+}
+
+/**
+ * aescfb_encrypt - Perform AES-CFB encryption on a block of data
+ *
+ * @ctx:	The AES-CFB key schedule
+ * @dst:	Pointer to the ciphertext output buffer
+ * @src:	Pointer the plaintext (may equal @dst for encryption in place)
+ * @len:	The size in bytes of the plaintext and ciphertext.
+ * @iv:		The initialization vector (IV) to use for this block of data
+ */
+void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 iv[AES_BLOCK_SIZE])
+{
+	u8 ks[AES_BLOCK_SIZE];
+	const u8 *v = iv;
+
+	while (len > 0) {
+		aescfb_encrypt_block(ctx, ks, v);
+		crypto_xor_cpy(dst, src, ks, min(len, AES_BLOCK_SIZE));
+		v = dst;
+
+		dst += AES_BLOCK_SIZE;
+		src += AES_BLOCK_SIZE;
+		len -= AES_BLOCK_SIZE;
+	}
+
+	memzero_explicit(ks, sizeof(ks));
+}
+EXPORT_SYMBOL(aescfb_encrypt);
+
+/**
+ * aescfb_decrypt - Perform AES-CFB decryption on a block of data
+ *
+ * @ctx:	The AES-CFB key schedule
+ * @dst:	Pointer to the plaintext output buffer
+ * @src:	Pointer the ciphertext (may equal @dst for decryption in place)
+ * @len:	The size in bytes of the plaintext and ciphertext.
+ * @iv:		The initialization vector (IV) to use for this block of data
+ */
+void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 iv[AES_BLOCK_SIZE])
+{
+	u8 ks[2][AES_BLOCK_SIZE];
+
+	aescfb_encrypt_block(ctx, ks[0], iv);
+
+	for (int i = 0; len > 0; i ^= 1) {
+		if (len > AES_BLOCK_SIZE)
+			/*
+			 * Generate the keystream for the next block before
+			 * performing the XOR, as that may update in place and
+			 * overwrite the ciphertext.
+			 */
+			aescfb_encrypt_block(ctx, ks[!i], src);
+
+		crypto_xor_cpy(dst, src, ks[i], min(len, AES_BLOCK_SIZE));
+
+		dst += AES_BLOCK_SIZE;
+		src += AES_BLOCK_SIZE;
+		len -= AES_BLOCK_SIZE;
+	}
+
+	memzero_explicit(ks, sizeof(ks));
+}
+EXPORT_SYMBOL(aescfb_decrypt);
+
+MODULE_DESCRIPTION("Generic AES-CFB library");
+MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+
+/*
+ * Test code below. Vectors taken from crypto/testmgr.h
+ */
+
+static struct {
+	u8	ptext[64];
+	u8	ctext[64];
+
+	u8	key[AES_MAX_KEY_SIZE];
+	u8	iv[AES_BLOCK_SIZE];
+
+	int	klen;
+	int	len;
+} const aescfb_tv[] __initconst = {
+	{ /* From NIST SP800-38A */
+		.key    = "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae\x2d\x8a\x57\x1e\x03\xac\x9c"
+			  "\x9e\xb7\x6f\xac\x45\xaf\x8e\x51"
+			  "\x30\xc8\x1c\x46\xa3\x5c\xe4\x11"
+			  "\xe5\xfb\xc1\x19\x1a\x0a\x52\xef"
+			  "\xf6\x9f\x24\x45\xdf\x4f\x9b\x17"
+			  "\xad\x2b\x41\x7b\xe6\x6c\x37\x10",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
+			  "\x33\x34\x49\xf8\xe8\x3c\xfb\x4a"
+			  "\xc8\xa6\x45\x37\xa0\xb3\xa9\x3f"
+			  "\xcd\xe3\xcd\xad\x9f\x1c\xe5\x8b"
+			  "\x26\x75\x1f\x67\xa3\xcb\xb1\x40"
+			  "\xb1\x80\x8c\xf1\x87\xa4\xf4\xdf"
+			  "\xc0\x4b\x05\x35\x7c\x5d\x1c\x0e"
+			  "\xea\xc4\xc6\x6f\x9f\xf7\xf2\xe6",
+		.len	= 64,
+	}, {
+		.key	= "\x8e\x73\xb0\xf7\xda\x0e\x64\x52"
+			  "\xc8\x10\xf3\x2b\x80\x90\x79\xe5"
+			  "\x62\xf8\xea\xd2\x52\x2c\x6b\x7b",
+		.klen	= 24,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae\x2d\x8a\x57\x1e\x03\xac\x9c"
+			  "\x9e\xb7\x6f\xac\x45\xaf\x8e\x51"
+			  "\x30\xc8\x1c\x46\xa3\x5c\xe4\x11"
+			  "\xe5\xfb\xc1\x19\x1a\x0a\x52\xef"
+			  "\xf6\x9f\x24\x45\xdf\x4f\x9b\x17"
+			  "\xad\x2b\x41\x7b\xe6\x6c\x37\x10",
+		.ctext	= "\xcd\xc8\x0d\x6f\xdd\xf1\x8c\xab"
+			  "\x34\xc2\x59\x09\xc9\x9a\x41\x74"
+			  "\x67\xce\x7f\x7f\x81\x17\x36\x21"
+			  "\x96\x1a\x2b\x70\x17\x1d\x3d\x7a"
+			  "\x2e\x1e\x8a\x1d\xd5\x9b\x88\xb1"
+			  "\xc8\xe6\x0f\xed\x1e\xfa\xc4\xc9"
+			  "\xc0\x5f\x9f\x9c\xa9\x83\x4f\xa0"
+			  "\x42\xae\x8f\xba\x58\x4b\x09\xff",
+		.len	= 64,
+	}, {
+		.key	= "\x60\x3d\xeb\x10\x15\xca\x71\xbe"
+			  "\x2b\x73\xae\xf0\x85\x7d\x77\x81"
+			  "\x1f\x35\x2c\x07\x3b\x61\x08\xd7"
+			  "\x2d\x98\x10\xa3\x09\x14\xdf\xf4",
+		.klen	= 32,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae\x2d\x8a\x57\x1e\x03\xac\x9c"
+			  "\x9e\xb7\x6f\xac\x45\xaf\x8e\x51"
+			  "\x30\xc8\x1c\x46\xa3\x5c\xe4\x11"
+			  "\xe5\xfb\xc1\x19\x1a\x0a\x52\xef"
+			  "\xf6\x9f\x24\x45\xdf\x4f\x9b\x17"
+			  "\xad\x2b\x41\x7b\xe6\x6c\x37\x10",
+		.ctext	= "\xdc\x7e\x84\xbf\xda\x79\x16\x4b"
+			  "\x7e\xcd\x84\x86\x98\x5d\x38\x60"
+			  "\x39\xff\xed\x14\x3b\x28\xb1\xc8"
+			  "\x32\x11\x3c\x63\x31\xe5\x40\x7b"
+			  "\xdf\x10\x13\x24\x15\xe5\x4b\x92"
+			  "\xa1\x3e\xd0\xa8\x26\x7a\xe2\xf9"
+			  "\x75\xa3\x85\x74\x1a\xb9\xce\xf8"
+			  "\x20\x31\x62\x3d\x55\xb1\xe4\x71",
+		.len	= 64,
+	}, { /* > 16 bytes, not a multiple of 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
+			  "\x33\x34\x49\xf8\xe8\x3c\xfb\x4a"
+			  "\xc8",
+		.len	= 17,
+	}, { /* < 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad",
+		.len	= 7,
+	},
+};
+
+static int __init libaescfb_init(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(aescfb_tv); i++) {
+		struct crypto_aes_ctx ctx;
+		u8 buf[64];
+
+		if (aes_expandkey(&ctx, aescfb_tv[i].key, aescfb_tv[i].klen)) {
+			pr_err("aes_expandkey() failed on vector %d\n", i);
+			return -ENODEV;
+		}
+
+		aescfb_encrypt(&ctx, buf, aescfb_tv[i].ptext, aescfb_tv[i].len,
+			       aescfb_tv[i].iv);
+		if (memcmp(buf, aescfb_tv[i].ctext, aescfb_tv[i].len)) {
+			pr_err("aescfb_encrypt() #1 failed on vector %d\n", i);
+			return -ENODEV;
+		}
+
+		/* decrypt in place */
+		aescfb_decrypt(&ctx, buf, buf, aescfb_tv[i].len, aescfb_tv[i].iv);
+		if (memcmp(buf, aescfb_tv[i].ptext, aescfb_tv[i].len)) {
+			pr_err("aescfb_decrypt() failed on vector %d\n", i);
+			return -ENODEV;
+		}
+
+		/* encrypt in place */
+		aescfb_encrypt(&ctx, buf, buf, aescfb_tv[i].len, aescfb_tv[i].iv);
+		if (memcmp(buf, aescfb_tv[i].ctext, aescfb_tv[i].len)) {
+			pr_err("aescfb_encrypt() #2 failed on vector %d\n", i);
+
+			return -ENODEV;
+		}
+
+	}
+	return 0;
+}
+module_init(libaescfb_init);
+
+static void __exit libaescfb_exit(void)
+{
+}
+module_exit(libaescfb_exit);
+#endif
-- 
2.35.3


