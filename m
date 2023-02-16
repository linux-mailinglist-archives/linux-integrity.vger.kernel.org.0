Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BD699D72
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBPUPQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 15:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBPUPP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 15:15:15 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB04C6D7;
        Thu, 16 Feb 2023 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676578514;
        bh=A+1Y4qtwYNGm0gXQjLE/ci9ci8qKKuU2t07hz37bvEk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=TsoqPSRX59yRWrKUfotEmtPnIyWLcG+C4h4Er+Kj9BfBTx3StGAzJruUaQXHT9AFr
         VXm8ZLm7sT2/PsDwXcp8M2Z1O2QHy9TiJqfoT5Otsm5zEeM6DBYyNPIhp4PLBoa+ej
         POB6GSJVS57CELZE4jV+57CAsCRQHZG5+USRcbIE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B2F8C1286E47;
        Thu, 16 Feb 2023 15:15:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oi71gDhzLgIT; Thu, 16 Feb 2023 15:15:14 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2ADF41286F45;
        Thu, 16 Feb 2023 15:15:14 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 01/12] crypto: lib - implement library version of AES in CFB mode
Date:   Thu, 16 Feb 2023 15:13:59 -0500
Message-Id: <20230216201410.15010-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Implement AES in CFB mode using the existing, mostly constant-time
generic AES library implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/crypto/aes.h |  5 +++
 lib/crypto/Kconfig   |  5 +++
 lib/crypto/Makefile  |  3 ++
 lib/crypto/aescfb.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 lib/crypto/aescfb.c

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 2090729701ab..7b9e1df1ccb0 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -87,4 +87,9 @@ void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
 extern const u8 crypto_aes_sbox[];
 extern const u8 crypto_aes_inv_sbox[];
 
+void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 *iv);
+void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 *iv);
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
index 6ec2d4543d9c..33213a01aab1 100644
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
index 000000000000..e9de1c6d874a
--- /dev/null
+++ b/lib/crypto/aescfb.c
@@ -0,0 +1,75 @@
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
+void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 *iv)
+{
+	while (len > 0) {
+		u8 ks[AES_BLOCK_SIZE];
+
+		aescfb_encrypt_block(ctx, ks, iv);
+		crypto_xor_cpy(dst, src, ks, min(len, AES_BLOCK_SIZE));
+		iv = dst;
+
+		dst += AES_BLOCK_SIZE;
+		src += AES_BLOCK_SIZE;
+		len -= AES_BLOCK_SIZE;
+	}
+}
+
+void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
+		    int len, const u8 *iv)
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
+}
+
+MODULE_DESCRIPTION("Generic AES-CFB library");
+MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.35.3

