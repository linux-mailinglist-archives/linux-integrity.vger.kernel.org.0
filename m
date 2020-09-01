Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE73259F6F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Sep 2020 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbgIATul (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Sep 2020 15:50:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbgIATuh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Sep 2020 15:50:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EAC6E205CFFB;
        Tue,  1 Sep 2020 12:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAC6E205CFFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598989836;
        bh=woRVXYCthTA+4j2u5YTq7CagahV1PQQeqqiqJHb7g2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuBdJFCBGLILh3WV1UbZ87bA2d5hpYoz5mp0oeR+RBPo4pxXuPIgJmDOM/VFmh0u+
         q7cBfiel1K9x629rPlhh91luVikItriGSg/TxlRs+OQMaA1XdO2FhY5l9UpMTdN9nT
         5kYSSmniIA63YmV6dbjnJZUFyuDAoGMNqSbKhfHY=
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
Subject: [PATCH v5 2/3] arm64: Store IMA log information in kimage used for kexec
Date:   Tue,  1 Sep 2020 12:50:28 -0700
Message-Id: <20200901195029.30039-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901195029.30039-1-nramas@linux.microsoft.com>
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address and size of the buffer containing the IMA measurement log need
to be passed from the current kernel to the next kernel on kexec.

Add address and size fields to "struct kimage_arch" for ARM64 platform
to hold the address and size of the IMA measurement log buffer.
Define an architecture specific function for ARM64 namely
arch_ima_add_kexec_buffer() that will set the address and size of
the current kernel's IMA buffer to be passed to the next kernel on kexec.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <lkp@intel.com> warning: no previous prototype for 'arch_ima_add_kexec_buffer' [-Wmissing-prototypes]
---
 arch/arm64/include/asm/ima.h   | 18 ++++++++++++++++++
 arch/arm64/include/asm/kexec.h |  3 +++
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/ima_kexec.c  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..507fc94ddaba
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,18 @@
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
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size);
+#endif /* CONFIG_IMA_KEXEC */
+
+#endif /* _ASM_ARCH_IMA_H */
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..7bd60c185ad3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,9 @@ struct kimage_arch {
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
+
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a561cbb91d4d..39c5d99b49fc 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_SHADOW_CALL_STACK)		+= scs.o
+obj-$(CONFIG_IMA_KEXEC)			+= ima_kexec.o
 
 obj-y					+= vdso/ probes/
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
new file mode 100644
index 000000000000..1847f1230710
--- /dev/null
+++ b/arch/arm64/kernel/ima_kexec.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
+ *
+ * File: ima_kexec.c
+ *       Defines IMA kexec functions.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/types.h>
+#include <asm/ima.h>
+
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
+ *
+ * @image: kimage structure to set ima buffer information in for kexec
+ * @load_addr: Start address of the IMA buffer
+ * @size: size of the IMA buffer
+ *
+ * Architectures should use this function to pass on the IMA buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size)
+{
+	image->arch.ima_buffer_addr = load_addr;
+	image->arch.ima_buffer_size = size;
+	return 0;
+}
-- 
2.28.0

