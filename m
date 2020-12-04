Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511A32CF521
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLDTxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 14:53:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52951 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLDTxR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 14:53:17 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B549420B7194;
        Fri,  4 Dec 2020 11:52:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B549420B7194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607111521;
        bh=MJ8cApvzkCo+bglSdhsIgMyxGTncBwj3/wC3rLK+6TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtlg6+rPwCFvBMX4nQQlpvm4IFAigipISMvjueCbe4ks28F0/8XZOngMxTqfkJsc1
         VSehnFsPnUpW19jIiZxB8fTKbfHwxx0g2xdHku4nCnCLUXNN+OF6M14O3sL1C6g4hn
         7tTxV3s6mTgRW3V2tc/231f+dxd92J+90gNPV02Y=
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
Subject: [PATCH v10 8/8] arm64: Add IMA log information in kimage used for kexec
Date:   Fri,  4 Dec 2020 11:51:49 -0800
Message-Id: <20201204195149.611-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204195149.611-1-nramas@linux.microsoft.com>
References: <20201204195149.611-1-nramas@linux.microsoft.com>
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
 arch/arm64/include/asm/ima.h           | 22 ++++++++++++++
 arch/arm64/include/asm/kexec.h         |  5 ++++
 arch/arm64/kernel/Makefile             |  1 +
 arch/arm64/kernel/ima.c                | 41 ++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  8 +++++
 6 files changed, 78 insertions(+)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..bcca4a467eda 100644
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
index 000000000000..354adc8b444c
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
+ *
+ */
+#ifndef _ASM_ARCH_IMA_H
+#define _ASM_ARCH_IMA_H
+
+struct kimage;
+
+#ifdef CONFIG_IMA_KEXEC
+extern int setup_ima_buffer(struct kimage *image, void *dtb, int off);
+#else
+static inline int setup_ima_buffer(struct kimage *image, void *dtb, int off)
+{
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
index 000000000000..d65bdbe1adf6
--- /dev/null
+++ b/arch/arm64/kernel/ima.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Authors:
+ * Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
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
+int setup_ima_buffer(struct kimage *image, void *dtb, int off)
+{
+	int ret = 0;
+
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				"linux,ima-kexec-buffer",
+				image->arch.ima_buffer_addr,
+				image->arch.ima_buffer_size);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
+				      image->arch.ima_buffer_size);
+	}
+
+	return ret;
+}
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..ca7ae1cf3c1d 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -21,7 +21,9 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
+#include <linux/ima.h>
 #include <asm/byteorder.h>
+#include <asm/ima.h>
 
 /* relevant device tree properties */
 #define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
@@ -62,6 +64,8 @@ static int setup_dtb(struct kimage *image,
 
 	off = ret;
 
+	remove_ima_buffer(dtb, ret);
+
 	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
@@ -136,6 +140,10 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	ret = setup_ima_buffer(image, dtb, off);
+	if (ret)
+		goto out;
+
 	/* add rng-seed */
 	if (rng_is_initialized()) {
 		void *rng_seed;
-- 
2.29.2

