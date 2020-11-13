Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9522B2471
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMTWx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 14:22:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48866 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKMTWw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:52 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A562B20C28BD;
        Fri, 13 Nov 2020 11:22:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A562B20C28BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295370;
        bh=IkvO7dopBS6HRCfHMKHPze4rkcRKLBrZYHy+kX5uHHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a71MPBmkLwJuqoYZBwntqI6aXkbO3QdBCK3d9eF+NhuWzm1lFpbOcczRia7Q5LGew
         p4z5LWuWsYawG27OmvFzzkH9Q0GFxycVkUiBRseKIgphvVYNMaOCZOKzHKf445sOP0
         A7ewB4xGEpHEaaQtUEBdxTnqS9yMHwHkLboH3TfY=
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
Subject: [PATCH v9 2/8] powerpc: Move delete_fdt_mem_rsv() to drivers/of
Date:   Fri, 13 Nov 2020 11:22:37 -0800
Message-Id: <20201113192243.1993-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

delete_fdt_mem_rsv() retrieves the memory reserve map entry, for
the given starting address and size, from the device tree blob, and
removes the entry from the device tree blob. This function is called
to free the resources reserved for the buffer used for carrying forward
the IMA measurement logs on kexec. This function does not have
architecture specific code, but is currently limited to powerpc.

Move delete_fdt_mem_rsv() to "drivers/of/kexec_fdt.c" so that it is
accessible for other architectures as well.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/kexec.h |  1 -
 arch/powerpc/kexec/file_load.c   | 32 -------------------
 drivers/of/Makefile              |  6 ++++
 drivers/of/kexec_fdt.c           | 55 ++++++++++++++++++++++++++++++++
 include/linux/kexec.h            | 11 +++++++
 5 files changed, 72 insertions(+), 33 deletions(-)
 create mode 100644 drivers/of/kexec_fdt.c

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 55d6ede30c19..7c223031ecdd 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 int setup_new_fdt(const struct kimage *image, void *fdt,
 		  unsigned long initrd_load_addr, unsigned long initrd_len,
 		  const char *cmdline);
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 
 #ifdef CONFIG_PPC64
 struct kexec_buf;
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 9a232bc36c8f..9efc98b1e2ae 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -109,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
-/**
- * delete_fdt_mem_rsv - delete memory reservation with given address and size
- *
- * Return: 0 on success, or negative errno on error.
- */
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
-{
-	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
-
-	for (i = 0; i < num_rsvs; i++) {
-		uint64_t rsv_start, rsv_size;
-
-		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
-		if (ret) {
-			pr_err("Malformed device tree.\n");
-			return -EINVAL;
-		}
-
-		if (rsv_start == start && rsv_size == size) {
-			ret = fdt_del_mem_rsv(fdt, i);
-			if (ret) {
-				pr_err("Error deleting device tree reservation.\n");
-				return -EINVAL;
-			}
-
-			return 0;
-		}
-	}
-
-	return -ENOENT;
-}
-
 /*
  * setup_new_fdt - modify /chosen and memory reservation for the next kernel
  * @image:		kexec image being loaded.
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 6e1e5212f058..5f42aa3bbac6 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -14,4 +14,10 @@ obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
 
+ifdef CONFIG_OF_FLATTREE
+ifdef CONFIG_KEXEC_FILE
+obj-y += kexec_fdt.o
+endif
+endif
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kexec_fdt.c b/drivers/of/kexec_fdt.c
new file mode 100644
index 000000000000..995d0ad22d0f
--- /dev/null
+++ b/drivers/of/kexec_fdt.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: kexec_fdt.c
+ *	Defines functions to handle memory reservation for buffers
+ *	used to carry data across kexec system call.
+ */
+
+#define pr_fmt(fmt)	"OF: kexec-fdt: " fmt
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ *
+ * @fdt: Flattened Device Tree to update
+ * @start: Starting address of the reservation to delete
+ * @size: Size of the reservation to delete
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+{
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
+
+	for (i = 0; i < num_rsvs; i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == start && rsv_size == size) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting device tree reservation.\n");
+				return -EINVAL;
+			}
+
+			pr_debug("Freed reserved memory at %lu of size %lu\n",
+				 start, size);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..4ce09ccf2628 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,6 +407,17 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#if defined(CONFIG_OF_FLATTREE) && defined(CONFIG_KEXEC_FILE)
+extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+			      unsigned long size);
+#else
+static inline int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+				     unsigned long size)
+{
+	return 0;
+}
+#endif /* CONFIG_OF_FLATTREE && CONFIG_KEXEC_FILE */
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
-- 
2.29.2

