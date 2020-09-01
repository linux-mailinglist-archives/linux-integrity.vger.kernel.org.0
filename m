Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB86259F76
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Sep 2020 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgIATuu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Sep 2020 15:50:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47390 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgIATuh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Sep 2020 15:50:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4209820B7179;
        Tue,  1 Sep 2020 12:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4209820B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598989835;
        bh=yNzHWDM5Ed8f46M0DceObkP2f0uphEuYaBRctca3MNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADUoRz76938G7tZM1Ai+avVDFv6Dmq4/TMxDVGgqZ4NWHzF058cCtxsH02sI5c3tH
         qTZxksMjmN4enJBlcDVcWZyOL6m2CWOGdC5PP6Ps3+JLxN/XoHRVh2ufMrpv6cDoZV
         gRWFr7CItuLsMtW7VGAX+CcVuagmplZiQywN7a6M=
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
Subject: [PATCH v5 1/3] powerpc: Refactor kexec functions to move arch independent code to IMA
Date:   Tue,  1 Sep 2020 12:50:27 -0700
Message-Id: <20200901195029.30039-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901195029.30039-1-nramas@linux.microsoft.com>
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions ima_get_kexec_buffer() and ima_free_kexec_buffer() that
handle carrying forward the IMA measurement logs on kexec for powerpc
do not have architecture specific code, but they are currently defined
for powerpc only.

Move these functions to IMA subsystem so that it can be used for other
architectures as well. A later patch in this series will use these
functions for carrying forward the IMA measurement log for ARM64.

Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
"linux,ima-kexec-buffer", that is added to the DTB to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h     |  3 --
 arch/powerpc/kexec/ima.c           | 60 ++--------------------
 include/linux/libfdt.h             |  3 ++
 security/integrity/ima/ima_kexec.c | 82 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..bc27fd94de52 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -4,9 +4,6 @@
 
 struct kimage;
 
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
-
 #ifdef CONFIG_IMA
 void remove_ima_buffer(void *fdt, int chosen_node);
 #else
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..f5112ee4bb0b 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -46,60 +46,6 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
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
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -113,12 +59,12 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 	size_t size;
 	const void *prop;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
 	if (!prop)
 		return;
 
 	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
 	if (ret)
 		return;
 
@@ -201,7 +147,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret)
 		return ret;
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
 			  entry_size);
 	if (ret < 0)
 		return -EINVAL;
diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
index 90ed4ebfa692..75fb40aa013b 100644
--- a/include/linux/libfdt.h
+++ b/include/linux/libfdt.h
@@ -5,4 +5,7 @@
 #include <linux/libfdt_env.h>
 #include "../../scripts/dtc/libfdt/libfdt.h"
 
+/* Common device tree properties */
+#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
+
 #endif /* _INCLUDE_LIBFDT_H_ */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..d092285446c2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,8 +10,90 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <linux/ima.h>
 #include "ima.h"
 
+static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size)
+{
+	int addr_cells, size_cells;
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	addr_cells = of_n_addr_cells(root);
+	size_cells = of_n_size_cells(root);
+
+	of_node_put(root);
+
+	if (len < 4 * (addr_cells + size_cells))
+		return -ENOENT;
+
+	*addr = of_read_number(prop, addr_cells);
+	*size = of_read_number(prop + 4 * addr_cells, size_cells);
+
+	return 0;
+}
+
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ima_get_kexec_buffer(void **addr, size_t *size)
+{
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
+	prop = of_find_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, NULL);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
+	if (ret)
+		return ret;
+
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return memblock_free(addr, size);
+
+}
+
 #ifdef CONFIG_IMA_KEXEC
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
-- 
2.28.0

