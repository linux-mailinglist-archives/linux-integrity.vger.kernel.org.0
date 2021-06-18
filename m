Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B93ACFE1
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFRQJd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:09:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhFRQJc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG28MY010943;
        Fri, 18 Jun 2021 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7VQWIm0Me1T05QtTzlwBRELdrR3petF4uN1MSPKOTxc=;
 b=YkUfrXzezOWMrylUWtdIUe3+eA9slJrHn8plccrLvU+PXGNrgOFL+0PAiir3hEs8EU3O
 tG08NcNaLo0fkTQYCYRquuos+y2qN9oVGiFF2S8O4qMzZNgBP2Nu+ez2cgKfMxPwqaie
 Ir1G0TH7Tug78r+znLR03e0z0RA08l9vnaHcaD5CjC3Qr0nOKfK3IL/e62eifYQRBUpk
 J3D7cu/1Tb6H7YXKRDua2FhBr5bpiKfa3A7JcDcEUF8m9Ixe8L/y7Q8vxduo46eIJ+q+
 Qa46qAUi9JVkpFitb7RXgVOzUb4gQslpkak90ACRRxkWXiCB4/OvBeyJgAFMo0RJym/e JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp00cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1HlO173205;
        Fri, 18 Jun 2021 16:06:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 396way764e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:56 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG6tYk014368;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 396way7624-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6mto021779;
        Fri, 18 Jun 2021 16:06:48 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:48 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 04/12] x86: Add early SHA support for Secure Launch early measurements
Date:   Fri, 18 Jun 2021 12:12:49 -0400
Message-Id: <1624032777-7013-5-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: Fckh_t6u2UkkJR_dzk_J4Hp1k01XzmUL
X-Proofpoint-GUID: Fckh_t6u2UkkJR_dzk_J4Hp1k01XzmUL
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA algorithms are necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA libraries directly in
the code since the compressed kernel is not uncompressed at this point.

The SHA code here has its origins in the code from the main kernel, commit
c4d5b9ffa31f (crypto: sha1 - implement base layer for SHA-1). That code could
not be pulled directly into the setup portion of the compressed kernel because
of other dependencies it pulls in. The result is this is a modified copy of
that code that still leverages the core SHA algorithms.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile       |   2 +
 arch/x86/boot/compressed/early_sha1.c   | 103 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_sha1.h   |  17 ++++++
 arch/x86/boot/compressed/early_sha256.c |   7 +++
 lib/crypto/sha256.c                     |   8 +++
 lib/sha1.c                              |   4 ++
 6 files changed, 141 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f..059d49a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -102,6 +102,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
new file mode 100644
index 00000000..74f4654
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/unaligned.h>
+
+#include "early_sha1.h"
+
+#define SHA1_DISABLE_EXPORT
+#include "../../../../lib/sha1.c"
+
+/* The SHA1 implementation in lib/sha1.c was written to get the workspace
+ * buffer as a parameter. This wrapper function provides a container
+ * around a temporary workspace that is cleared after the transform completes.
+ */
+static void __sha_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	memset(ws, 0, sizeof(ws));
+	/*
+	 * As this is cryptographic code, prevent the memset 0 from being
+	 * optimized out potentially leaving secrets in memory.
+	 */
+	wmb();
+
+}
+
+void early_sha1_init(struct sha1_state *sctx)
+{
+	sha1_init(sctx->state);
+	sctx->count = 0;
+}
+
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA1_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, data, p);
+			data += p;
+			len -= p;
+
+			__sha_transform(sctx->state, sctx->buffer);
+		}
+
+		blocks = len / SHA1_BLOCK_SIZE;
+		len %= SHA1_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				__sha_transform(sctx->state, data);
+				data += SHA1_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+
+	if (len)
+		memcpy(sctx->buffer + partial, data, len);
+}
+
+void early_sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
diff --git a/arch/x86/boot/compressed/early_sha1.h b/arch/x86/boot/compressed/early_sha1.h
new file mode 100644
index 00000000..6584ea5
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_SHA1_H
+#define BOOT_COMPRESSED_EARLY_SHA1_H
+
+#include <crypto/sha1.h>
+
+void early_sha1_init(struct sha1_state *sctx);
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len);
+void early_sha1_final(struct sha1_state *sctx, u8 *out);
+
+#endif /* BOOT_COMPRESSED_EARLY_SHA1_H */
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 00000000..db8d784
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ */
+
+#define SHA256_DISABLE_EXPORT
+#include "../../../../lib/crypto/sha256.c"
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 72a4b0b..e532220 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -149,13 +149,17 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 	}
 	memcpy(sctx->buf + partial, src, len - done);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_update);
+#endif
 
 void sha224_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	sha256_update(sctx, data, len);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_update);
+#endif
 
 static void __sha256_final(struct sha256_state *sctx, u8 *out, int digest_words)
 {
@@ -188,13 +192,17 @@ void sha256_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 8);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_final);
+#endif
 
 void sha224_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 7);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_final);
+#endif
 
 void sha256(const u8 *data, unsigned int len, u8 *out)
 {
diff --git a/lib/sha1.c b/lib/sha1.c
index 9bd1935..0598efd 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -187,7 +187,9 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	digest[3] += D;
 	digest[4] += E;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_transform);
+#endif
 
 /**
  * sha1_init - initialize the vectors for a SHA1 digest
@@ -201,4 +203,6 @@ void sha1_init(__u32 *buf)
 	buf[3] = 0x10325476;
 	buf[4] = 0xc3d2e1f0;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_init);
+#endif
-- 
1.8.3.1

