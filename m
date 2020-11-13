Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303DF2B2470
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgKMTWw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 14:22:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48918 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgKMTWw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:52 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6A43B20C28C0;
        Fri, 13 Nov 2020 11:22:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A43B20C28C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295371;
        bh=Qh7VUYPFclMMyWjaiJKYdfprvYeY0xzrb/fwOTNg+5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs4Qky8C+MDiORLtu9E9p35ld+uossKJVpx6IWJQ4otQXaY4iFDWm/yVEISJblcSG
         0NqPof29nsJDYsXSZQeUHXbtki+kNvzXj39XsdFlesibHBKGkTtEzQqYmVhWtGNv69
         0jgsuwKrEy3QMa/b4D4V7+LV4bFgVsuEngeOmhhc=
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
Subject: [PATCH v9 3/8] ima: Define get_ima_kexec_buffer() in drivers/of
Date:   Fri, 13 Nov 2020 11:22:38 -0800
Message-Id: <20201113192243.1993-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The function do_get_kexec_buffer(), defined in arch/powerpc/kexec/ima.c,
retrieves the address and size of the given property from the device
tree blob. This function does not have architecture specific code, but is
currently limited to powerpc. This function correctly handles a device
tree property that is a child node of the root node, but not anything
other than the immediate root child nodes.

Define an architecture independent function, namely
get_ima_kexec_buffer(), in "drivers/of/ima_kexec.c". This function
retrieves the chosen node, namely "linux,ima-kexec-buffer", from
the device tree, and returns the address and size of the buffer used
for carrying forward the IMA measurement log across kexec system call.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 drivers/of/Makefile    |  3 ++
 drivers/of/ima_kexec.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/kexec.h  | 11 +++++++
 3 files changed, 79 insertions(+)
 create mode 100644 drivers/of/ima_kexec.c

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 5f42aa3bbac6..5b4af994fed0 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -18,6 +18,9 @@ ifdef CONFIG_OF_FLATTREE
 ifdef CONFIG_KEXEC_FILE
 obj-y += kexec_fdt.o
 endif
+ifdef CONFIG_HAVE_IMA_KEXEC
+obj-y += ima_kexec.o
+endif
 endif
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/ima_kexec.c b/drivers/of/ima_kexec.c
new file mode 100644
index 000000000000..9c14777404f2
--- /dev/null
+++ b/drivers/of/ima_kexec.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_kexec.c
+ *	Defines functions to handle IMA measurement list across
+ *	kexec system call.
+ */
+
+#define pr_fmt(fmt)	"OF: ima-kexec: " fmt
+
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/libfdt.h>
+#include <linux/kexec.h>
+
+/**
+ * get_ima_kexec_buffer - Get address and size of IMA kexec buffer
+ *
+ * @fdt: Flattened Device Tree
+ * @chosen_node: Offset of chosen node in the FDT
+ * @addr: Return address of the node
+ * @size: Return size of the node
+ */
+int get_ima_kexec_buffer(void *fdt, int chosen_node,
+			 unsigned long *addr, size_t *size)
+{
+	const void *prop;
+	int addr_cells, size_cells, prop_len;
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
+	if (fdt)
+		prop = fdt_getprop(fdt, chosen_node,
+				   "linux,ima-kexec-buffer", &prop_len);
+	else
+		prop = of_get_property(of_chosen,
+				       "linux,ima-kexec-buffer", &prop_len);
+
+	if (!prop)
+		return -ENOENT;
+
+	if (prop_len < 4 * (addr_cells + size_cells))
+		return -EINVAL;
+
+	*addr = of_read_number(prop, addr_cells);
+	*size = of_read_number(prop + 4 * addr_cells, size_cells);
+
+	return 0;
+}
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4ce09ccf2628..a4f248caa483 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,6 +407,17 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#if defined(CONFIG_OF_FLATTREE) && defined(CONFIG_HAVE_IMA_KEXEC)
+extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
+				unsigned long *addr, size_t *size);
+#else
+static inline int get_ima_kexec_buffer(void *fdt, int chosen_node,
+				       unsigned long *addr, size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_OF_FLATTREE && CONFIG_HAVE_IMA_KEXEC */
+
 #if defined(CONFIG_OF_FLATTREE) && defined(CONFIG_KEXEC_FILE)
 extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
 			      unsigned long size);
-- 
2.29.2

