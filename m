Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1B22CF522
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgLDTxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 14:53:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52954 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbgLDTxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 14:53:18 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89B2520B718A;
        Fri,  4 Dec 2020 11:51:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89B2520B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607111519;
        bh=drG9z5++NDKCI6ahOaQyIoHZgSgy1kpa74CvAavpIa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMWQZUi9uhP9xJLTTq8g/qcpJ0xSr338r9tAnIeo5ziCqIPG7log8yaNeWoGQxefq
         XRDCwQzWLonOFG89C4QhXtQaTmoemQdIgsm7TDdUxuRE5IvWZHJmtPAbt6WsgQk4ht
         Wk3zIBXZejVpjGUJUYjYWGUccm9A/xpRtBQxAdYk=
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
Subject: [PATCH v10 5/8] powerpc: Move remove_ima_buffer() to drivers/of/kexec.c
Date:   Fri,  4 Dec 2020 11:51:46 -0800
Message-Id: <20201204195149.611-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204195149.611-1-nramas@linux.microsoft.com>
References: <20201204195149.611-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

remove_ima_buffer() removes the chosen node "linux,ima-kexec-buffer"
from the device tree and frees the memory reserved for carrying forward
the IMA measurement logs on kexec. This function does not have
architecture specific code, but is currently limited to powerpc.

Move remove_ima_buffer() to "drivers/of/ima_kexec.c" so that it is
accessible for other architectures as well.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h |  8 ++------
 arch/powerpc/kexec/ima.c       | 26 --------------------------
 drivers/of/kexec.c             | 29 +++++++++++++++++++++++++++++
 include/linux/kexec.h          |  1 +
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..a2fc71bc3b23 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -2,17 +2,13 @@
 #ifndef _ASM_POWERPC_IMA_H
 #define _ASM_POWERPC_IMA_H
 
+#include <linux/kexec.h>
+
 struct kimage;
 
 int ima_get_kexec_buffer(void **addr, size_t *size);
 int ima_free_kexec_buffer(void);
 
-#ifdef CONFIG_IMA
-void remove_ima_buffer(void *fdt, int chosen_node);
-#else
-static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
-#endif
-
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 			      size_t size);
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 906e8212435d..68017123b07d 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -61,32 +61,6 @@ int ima_free_kexec_buffer(void)
 	return memblock_free(addr, size);
 }
 
-/**
- * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
- *
- * @fdt: Flattened Device Tree to update
- * @chosen_node: Offset to the chosen node in the device tree
- *
- * The IMA measurement buffer is of no use to a subsequent kernel, so we always
- * remove it from the device tree.
- */
-void remove_ima_buffer(void *fdt, int chosen_node)
-{
-	int ret;
-	unsigned long addr;
-	size_t size;
-
-	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
-	if (ret)
-		return;
-
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
-
-	ret = delete_fdt_mem_rsv(fdt, addr, size);
-	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
-}
-
 #ifdef CONFIG_IMA_KEXEC
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 516b86f7113a..42d16dfff78d 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -129,3 +129,32 @@ int get_ima_kexec_buffer(void *fdt, int chosen_node,
 
 	return 0;
 }
+
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return;
+
+	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
+	if (ret)
+		return;
+
+	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+
+	ret = delete_fdt_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Removed old IMA buffer reservation.\n");
+}
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 10ff704ab670..52a0efff184d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -411,6 +411,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
 extern int get_root_addr_size_cells(int *addr_cells, int *size_cells);
 extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
 				unsigned long *addr, size_t *size);
+extern void remove_ima_buffer(void *fdt, int chosen_node);
 extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
 			      unsigned long size);
 #endif /* CONFIG_OF_FLATTREE */
-- 
2.29.2

