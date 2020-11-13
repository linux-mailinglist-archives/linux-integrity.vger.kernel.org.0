Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF02B246E
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKMTXI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 14:23:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48866 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKMTWy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:54 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id AFE4F20C28C9;
        Fri, 13 Nov 2020 11:22:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFE4F20C28C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295373;
        bh=o/LsKz5KAP97Pjx2iDDFWvQb2qw6JOFYx+q03DLLVvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJjmcO5Hy7dEb5cJFGX/Fwm0PcIY8wkVMQYUfb9UNo9b0BI92RJ0jQpEnOhswQcrt
         FN5dBXfMb5jFotBmdk6GboUe6MiZyfIHy+IZiUvW18liITB1hiyvya69l6MSUD4zyA
         rdyIOesvwQ0VPjvqkyn3Z8i13bEtiDeWKA/Z0p4g=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v9 6/8] powerpc: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima
Date:   Fri, 13 Nov 2020 11:22:41 -0800
Message-Id: <20201113192243.1993-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_get_kexec_buffer() retrieves the address and size of the buffer
used for carrying forward the IMA measurement logs on kexec from
the device tree.

ima_free_kexec_buffer() removes the chosen node namely
"linux,ima-kexec-buffer" from the device tree, and frees the buffer
used for carrying forward the IMA measurement logs on kexec.

These functions do not have architecture specific code, but are
currently limited to powerpc.

Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima_kexec.c
in IMA so that they are accessible for other architectures as well.

With the above change the functions in arch/powerpc/kexec/ima.c are
defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
Update the Makefile to build arch/powerpc/kexec/ima.c only when
CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
in arch/powerpc/kexec/ima.c.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h     |  3 --
 arch/powerpc/kexec/Makefile        |  7 +---
 arch/powerpc/kexec/ima.c           | 50 -----------------------------
 security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index a2fc71bc3b23..d8444d27f0d8 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -6,9 +6,6 @@
 
 struct kimage;
 
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
-
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 			      size_t size);
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 4aff6846c772..f54a9dbff4c8 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -9,12 +9,7 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
 
-ifdef CONFIG_HAVE_IMA_KEXEC
-ifdef CONFIG_IMA
-obj-y				+= ima.o
-endif
-endif
-
+obj-$(CONFIG_IMA_KEXEC)		+= ima.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index baa95d1a8304..6a96ed0a90e8 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -13,55 +13,6 @@
 #include <linux/libfdt.h>
 #include <asm/ima.h>
 
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
-{
-	int ret;
-	unsigned long tmp_addr;
-	size_t tmp_size;
-
-	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
-	if (ret)
-		return ret;
-
-	*addr = __va(tmp_addr);
-	*size = tmp_size;
-
-	return 0;
-}
-
-/**
- * ima_free_kexec_buffer - free memory used by the IMA buffer
- */
-int ima_free_kexec_buffer(void)
-{
-	int ret;
-	unsigned long addr;
-	size_t size;
-	struct property *prop;
-
-	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
-	if (!prop)
-		return -ENOENT;
-
-	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
-	if (ret)
-		return ret;
-
-	ret = of_remove_property(of_chosen, prop);
-	if (ret)
-		return ret;
-
-	return memblock_free(addr, size);
-}
-
-#ifdef CONFIG_IMA_KEXEC
 static int get_addr_size_cells(int *addr_cells, int *size_cells)
 {
 	struct device_node *root;
@@ -170,4 +121,3 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 
 	return 0;
 }
-#endif /* CONFIG_IMA_KEXEC */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..3f0fa2673dd3 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -9,9 +9,60 @@
 
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/kexec.h>
+#include <linux/ima.h>
 #include "ima.h"
 
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+
+	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+
+	return 0;
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ */
+static int ima_free_kexec_buffer(void)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
+	if (ret)
+		return ret;
+
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return memblock_free(addr, size);
+}
+
 #ifdef CONFIG_IMA_KEXEC
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
-- 
2.29.2

