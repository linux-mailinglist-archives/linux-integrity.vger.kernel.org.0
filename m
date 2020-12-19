Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671B22DF0D2
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Dec 2020 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgLSR6T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Dec 2020 12:58:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51052 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLSR6S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Dec 2020 12:58:18 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 916FE20B83F2;
        Sat, 19 Dec 2020 09:57:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 916FE20B83F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608400658;
        bh=gwhplyyF+cjb9TSe4cm7smlJWhMGIDPpcq9lIh4sTKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1FkKJP0EdE7JLakwAeZcCnLu6/R46WagVmE0cXidwYwIJAvPa7rXE4dfi+QkATAo
         n9tyX8FnJGs7DpHJ4TF69pnPOwDHIRqX+Afe9uZpBmtoq3lF0229/VqZywCZhCleKU
         MdIac1VeeJlpi87sbIhYEx/MOF57o44yRqZf5ROM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v13 1/6] ima: Move arch_ima_add_kexec_buffer() to ima
Date:   Sat, 19 Dec 2020 09:57:08 -0800
Message-Id: <20201219175713.18888-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219175713.18888-1-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
sets up the address and size of the IMA measurement list in
the architecture specific fields in kimage struct. This function does not
have architecture specific code, but is currently limited to powerpc.

Move arch_ima_add_kexec_buffer() to ima.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h     |  3 ---
 arch/powerpc/kexec/ima.c           | 17 -----------------
 security/integrity/ima/ima_kexec.c | 22 ++++++++++++++++++++++
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..51f64fd06c19 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -14,9 +14,6 @@ static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size);
-
 int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
 #else
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..7378d59c0c1e 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -128,23 +128,6 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 }
 
 #ifdef CONFIG_IMA_KEXEC
-/**
- * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
- *
- * Architectures should use this function to pass on the IMA buffer
- * information to the next kernel.
- *
- * Return: 0 on success, negative errno on error.
- */
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size)
-{
-	image->arch.ima_buffer_addr = load_addr;
-	image->arch.ima_buffer_size = size;
-
-	return 0;
-}
-
 static int write_number(void *p, u64 value, int cells)
 {
 	if (cells == 1) {
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..38bcd7543e27 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/ima.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -71,6 +72,27 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	return ret;
 }
 
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
+ *
+ * @image: kimage struct to set IMA buffer data
+ * @load_addr: Starting address where IMA buffer is loaded at
+ * @size: Number of bytes in the IMA buffer
+ *
+ * Architectures should use this function to pass on the IMA buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int arch_ima_add_kexec_buffer(struct kimage *image,
+				     unsigned long load_addr, size_t size)
+{
+	image->arch.ima_buffer_addr = load_addr;
+	image->arch.ima_buffer_size = size;
+
+	return 0;
+}
+
 /*
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
-- 
2.29.2

