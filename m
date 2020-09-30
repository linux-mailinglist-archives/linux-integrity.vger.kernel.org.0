Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6D27F3C3
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 23:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgI3U7y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 16:59:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52818 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbgI3U7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 16:59:53 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id BA3AE208D28D;
        Wed, 30 Sep 2020 13:59:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA3AE208D28D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601499592;
        bh=hFmrlFW2NajQatbBI3cSzZ4ZtzyEP6Wz7J2OuV1ut5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwtYNqulSUbubSopnsrvMtTUTVm/Qq6dCCdUp13lp9U3OPWXoa4n5BIhPwsDddD+9
         +E54BMleB6qiXSQsmKBoKHkId1K4WemReJrkZ6+UO/80yYLjIS63wjblRt2/8szeVT
         plHIkhIQa6z1KDTvEPNUzoPf97HHHNfr6Yi2R0MA=
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
Subject: [PATCH v7 2/4] powerpc: Refactor kexec functions to move arch independent code to ima
Date:   Wed, 30 Sep 2020 13:59:39 -0700
Message-Id: <20200930205941.1576-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930205941.1576-1-nramas@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
that handle carrying forward the IMA measurement logs on kexec for
powerpc do not have architecture specific code, but they are currently
defined for powerpc only.

Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
subsystem. A later patch in this series will use these functions for
carrying forward the IMA measurement log for ARM64.

With the above refactoring arch/powerpc/kexec/ima.c contains only
functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
when CONFIG_IMA_KEXEC is enabled.

Move ima_dump_measurement_list() and ima_add_kexec_buffer() to
a new file namely ima_kexec_fdt.c in IMA. Update
security/integrity/ima/Makefile to include ima_kexec_fdt.c only
when CONFIG_IMA_KEXEC is enabled.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h         |   3 -
 arch/powerpc/kexec/Makefile            |   7 +-
 arch/powerpc/kexec/ima.c               |  56 ---------
 security/integrity/ima/Makefile        |   1 +
 security/integrity/ima/ima_kexec.c     | 154 +++++++------------------
 security/integrity/ima/ima_kexec_fdt.c | 136 ++++++++++++++++++++++
 6 files changed, 182 insertions(+), 175 deletions(-)
 create mode 100644 security/integrity/ima/ima_kexec_fdt.c

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index 6355a85a3289..8975f5e0cab8 100644
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
index 2b790230ea15..4fadd8d16891 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -30,61 +30,6 @@ static int get_addr_size_cells(int *addr_cells, int *size_cells)
 	return 0;
 }
 
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
-{
-	int ret, len;
-	unsigned long tmp_addr;
-	size_t tmp_size;
-	const void *prop;
-
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
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
-	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
-	if (ret)
-		return ret;
-
-	ret = of_remove_property(of_chosen, prop);
-	if (ret)
-		return ret;
-
-	return memblock_free(addr, size);
-
-}
-
-#ifdef CONFIG_IMA_KEXEC
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
  *
@@ -177,4 +122,3 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 
 	return 0;
 }
-#endif /* CONFIG_IMA_KEXEC */
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..0c440870a4e9 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,4 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_KEXEC) += ima_kexec_fdt.o
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..987e464be889 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -7,131 +7,65 @@
  * Mimi Zohar <zohar@linux.vnet.ibm.com>
  */
 
-#include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <linux/ima.h>
 #include "ima.h"
 
-#ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
-				     unsigned long segment_size)
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	struct ima_queue_entry *qe;
-	struct seq_file file;
-	struct ima_kexec_hdr khdr;
-	int ret = 0;
-
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
-	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
-			khdr.count++;
-			ima_measurements_show(&file, qe);
-		} else {
-			ret = -EINVAL;
-			break;
-		}
-	}
-
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * fill in reserved space with some buffer details
-	 * (eg. version, buffer size, number of measurements)
-	 */
-	khdr.buffer_size = file.count;
-	if (ima_canonical_fmt) {
-		khdr.version = cpu_to_le16(khdr.version);
-		khdr.count = cpu_to_le64(khdr.count);
-		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
-	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
-
-	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
-			16, 1, file.buf,
-			file.count < 100 ? file.count : 100, true);
-
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
-	return ret;
+	int ret, len;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+	const void *prop;
+
+	prop = of_get_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+	return 0;
 }
 
-/*
- * Called during kexec_file_load so that IMA can add a segment to the kexec
- * image for the measurement list for the next kernel.
- *
- * This function assumes that kexec_mutex is held.
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-void ima_add_kexec_buffer(struct kimage *image)
+static int ima_free_kexec_buffer(void)
 {
-	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
-				  .buf_min = 0, .buf_max = ULONG_MAX,
-				  .top_down = true };
-	unsigned long binary_runtime_size;
-
-	/* use more understandable variable names than defined in kbuf */
-	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
 
-	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
-	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
-	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
-		kexec_segment_size = ULONG_MAX;
-	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
-					   PAGE_SIZE / 2, PAGE_SIZE);
-	if ((kexec_segment_size == ULONG_MAX) ||
-	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
-		pr_err("Binary measurement list too large.\n");
-		return;
-	}
+	prop = of_find_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, NULL);
+	if (!prop)
+		return -ENOENT;
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
-		return;
-	}
+	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
+	if (ret)
+		return ret;
 
-	kbuf.buffer = kexec_buffer;
-	kbuf.bufsz = kexec_buffer_size;
-	kbuf.memsz = kexec_segment_size;
-	ret = kexec_add_buffer(&kbuf);
-	if (ret) {
-		pr_err("Error passing over kexec measurement buffer.\n");
-		return;
-	}
-
-	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
-	if (ret) {
-		pr_err("Error passing over kexec measurement buffer.\n");
-		return;
-	}
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
 
-	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
-		 kbuf.mem);
+	return memblock_free(addr, size);
 }
-#endif /* IMA_KEXEC */
 
 /*
  * Restore the measurement list from the previous kernel.
diff --git a/security/integrity/ima/ima_kexec_fdt.c b/security/integrity/ima/ima_kexec_fdt.c
new file mode 100644
index 000000000000..186051467e5b
--- /dev/null
+++ b/security/integrity/ima/ima_kexec_fdt.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Authors:
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
+ * Mimi Zohar <zohar@linux.vnet.ibm.com>
+ */
+
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <linux/ima.h>
+#include "ima.h"
+
+static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+				     unsigned long segment_size)
+{
+	struct ima_queue_entry *qe;
+	struct seq_file file;
+	struct ima_kexec_hdr khdr;
+	int ret = 0;
+
+	/* segment size can't change between kexec load and execute */
+	file.buf = vmalloc(segment_size);
+	if (!file.buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	file.size = segment_size;
+	file.read_pos = 0;
+	file.count = sizeof(khdr);	/* reserved space */
+
+	memset(&khdr, 0, sizeof(khdr));
+	khdr.version = 1;
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (file.count < file.size) {
+			khdr.count++;
+			ima_measurements_show(&file, qe);
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * fill in reserved space with some buffer details
+	 * (eg. version, buffer size, number of measurements)
+	 */
+	khdr.buffer_size = file.count;
+	if (ima_canonical_fmt) {
+		khdr.version = cpu_to_le16(khdr.version);
+		khdr.count = cpu_to_le64(khdr.count);
+		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
+	}
+	memcpy(file.buf, &khdr, sizeof(khdr));
+
+	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
+			16, 1, file.buf,
+			file.count < 100 ? file.count : 100, true);
+
+	*buffer_size = file.count;
+	*buffer = file.buf;
+out:
+	if (ret == -EINVAL)
+		vfree(file.buf);
+	return ret;
+}
+
+/*
+ * Called during kexec_file_load so that IMA can add a segment to the kexec
+ * image for the measurement list for the next kernel.
+ *
+ * This function assumes that kexec_mutex is held.
+ */
+void ima_add_kexec_buffer(struct kimage *image)
+{
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	unsigned long binary_runtime_size;
+
+	/* use more understandable variable names than defined in kbuf */
+	void *kexec_buffer = NULL;
+	size_t kexec_buffer_size;
+	size_t kexec_segment_size;
+	int ret;
+
+	/*
+	 * Reserve an extra half page of memory for additional measurements
+	 * added during the kexec load.
+	 */
+	binary_runtime_size = ima_get_binary_runtime_size();
+	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
+		kexec_segment_size = ULONG_MAX;
+	else
+		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
+					   PAGE_SIZE / 2, PAGE_SIZE);
+	if ((kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+		pr_err("Binary measurement list too large.\n");
+		return;
+	}
+
+	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+				  kexec_segment_size);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
+	kbuf.buffer = kexec_buffer;
+	kbuf.bufsz = kexec_buffer_size;
+	kbuf.memsz = kexec_segment_size;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+
+	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kbuf.mem);
+}
-- 
2.28.0

