Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252962DA051
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 20:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440916AbgLNTYD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 14:24:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440629AbgLNTUa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:20:30 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09A9520B7194;
        Mon, 14 Dec 2020 11:19:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09A9520B7194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973552;
        bh=QkphXWzx5fz1WuzpPcHwgIcg3+cf9Tl76X22FiGdJLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFN1aRobory2qztTVo5zA69tHeZH8OzyDVaoijxqttpQv+req1IdIkjqo1YjR+wLV
         yi5jpKAV0UoMVYzBHSSVt7CQX18is1+P7DF3oMVrNFAV8KSl90eDdJWKWHBnwD870P
         ntHdzk6rW99/4eUZqa/u0dpAdQh6Ov/GViq4cFQc=
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
Subject: [PATCH v11 8/8] arm64: Add IMA log information in kimage used for kexec
Date:   Mon, 14 Dec 2020 11:18:54 -0800
Message-Id: <20201214191854.9050-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address and size of the buffer containing the IMA measurement log need
to be passed from the current kernel to the next kernel on kexec.

Any existing "linux,ima-kexec-buffer" property in the device tree
needs to be removed and its corresponding memory reservation in
the currently running kernel needs to be freed. The address and
size of the current kernel's IMA measurement log need to be added
to the device tree's IMA kexec buffer node and memory for the buffer
needs to be reserved for the log to be carried over to the next kernel
on the kexec call.

Add address and size fields to "struct kimage_arch" for ARM64 platform
to hold the address and size of the IMA measurement log buffer. Remove
any existing "linux,ima-kexec-buffer" property in the device tree and
free the corresponding memory reservation in the currently running
kernel. Add "linux,ima-kexec-buffer" property to the device tree and
reserve the memory for storing the IMA log that needs to be passed from
the current kernel to the next one.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
that the IMA measurement log information is present in the device tree
for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/ima.h           | 24 +++++++++++++
 arch/arm64/include/asm/kexec.h         |  5 +++
 arch/arm64/kernel/Makefile             |  1 +
 arch/arm64/kernel/ima.c                | 49 ++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  8 +++++
 6 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d466addb078..c85d18b1f2fd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1094,6 +1094,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..8b105157e55f
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
+ *
+ */
+#ifndef _ASM_ARCH_IMA_H
+#define _ASM_ARCH_IMA_H
+
+#include <linux/of.h>
+
+#ifdef CONFIG_IMA_KEXEC
+int setup_ima_buffer(const struct kimage *image, void *dtb, int off);
+#else
+static inline int setup_ima_buffer(const struct kimage *image, void *dtb,
+				   int off)
+{
+	remove_ima_buffer(dtb, off);
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+
+#endif /* _ASM_ARCH_IMA_H */
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..2bd19ccb6c43 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,11 @@ struct kimage_arch {
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
+
+#ifdef CONFIG_IMA_KEXEC
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
+#endif
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bbaf0bc4ad60..da83f1b3367e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_SHADOW_CALL_STACK)		+= scs.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
+obj-$(CONFIG_IMA_KEXEC)			+= ima.o
 
 obj-y					+= vdso/ probes/
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
diff --git a/arch/arm64/kernel/ima.c b/arch/arm64/kernel/ima.c
new file mode 100644
index 000000000000..fa7a1dbae183
--- /dev/null
+++ b/arch/arm64/kernel/ima.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
+ *
+ */
+
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/libfdt.h>
+#include <asm/ima.h>
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ *
+ * @image:	kexec image being loaded.
+ * @dtb:	Flattened device tree for the next kernel.
+ * @off:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_ima_buffer(const struct kimage *image, void *dtb, int off)
+{
+	int ret = 0;
+
+	remove_ima_buffer(dtb, off);
+
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+					       "linux,ima-kexec-buffer",
+					       image->arch.ima_buffer_addr,
+					       image->arch.ima_buffer_size);
+		if (ret) {
+			ret = (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+			goto out;
+		}
+
+		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
+				      image->arch.ima_buffer_size);
+	}
+
+out:
+	if (ret)
+		pr_err("Error setting up ima buffer in device tree.\n");
+
+	return ret;
+}
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 3e045cd62451..37a528aca780 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
+#include <asm/ima.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -83,6 +84,13 @@ static int create_dtb(struct kimage *image,
 			}
 		}
 
+		ret = setup_ima_buffer(image, buf,
+				       fdt_path_offset(buf, "/chosen"));
+		if (ret) {
+			vfree(buf);
+			return ret;
+		}
+
 		/* trim it */
 		fdt_pack(buf);
 		*dtb = buf;
-- 
2.29.2

