Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821C82CF51D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLDTwo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 14:52:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52672 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgLDTwi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 14:52:38 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26F0820B7187;
        Fri,  4 Dec 2020 11:51:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26F0820B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607111517;
        bh=QjzwkKap5j6BGZIXUMFZtVLppXuA87W5hY580CxO5Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsemOQH9A0VzQkpzu03at+NXfh706D2DoAoDdrG1/MmUhSONyN2/YTRZXVoXyQ5qW
         QirUmFfkFCoE9TbQUEtDcbIJysS5MV1n6YhCF9SgBjjaQSgTaEjPSgSu/8KLYVc6yr
         E/V1PcoQJRM/YLEXSx3DOw9eUrApETd35T5b+7Z4=
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
Subject: [PATCH v10 3/8] powerpc: Move ima buffer functions to drivers/of/kexec.c
Date:   Fri,  4 Dec 2020 11:51:44 -0800
Message-Id: <20201204195149.611-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204195149.611-1-nramas@linux.microsoft.com>
References: <20201204195149.611-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions do_get_kexec_buffer() and get_addr_size_cells(),
defined in arch/powerpc/kexec/ima.c, retrieve the address and size
of the given property from the device tree blob. These functions do
not have architecture specific code, but are currently limited to
powerpc. do_get_kexec_buffer() correctly handles a device tree property
that is a child node of the root node, but not anything other than
the immediate root child nodes.

Move architecture independent functions get_ima_kexec_buffer() and
get_root_addr_size_cells() to "drivers/of/kexec.c". These functions
retrieve the chosen node "linux,ima-kexec-buffer" from the device tree,
and return the address and size of the buffer used for carrying forward
the IMA measurement log across kexec system call.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 drivers/of/kexec.c    | 70 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/kexec.h |  3 ++
 2 files changed, 73 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b7d59105fcb8..516b86f7113a 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -59,3 +59,73 @@ int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
 
 	return -ENOENT;
 }
+
+/**
+ * get_root_addr_size_cells - Get address and size of root node
+ *
+ * @addr_cells: Return address of the root node
+ * @size_cells: Return size of the root node
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int get_root_addr_size_cells(int *addr_cells, int *size_cells)
+{
+	struct device_node *root;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -EOPNOTSUPP;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	*addr_cells = of_n_addr_cells(root);
+	*size_cells = of_n_size_cells(root);
+
+	of_node_put(root);
+
+	return 0;
+}
+
+/**
+ * get_ima_kexec_buffer - Get address and size of IMA kexec buffer
+ *
+ * @fdt: Flattened Device Tree
+ * @chosen_node: Offset of chosen node in the FDT
+ * @addr: Return address of the node
+ * @size: Return size of the node
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int get_ima_kexec_buffer(void *fdt, int chosen_node,
+			 unsigned long *addr, size_t *size)
+{
+	const void *prop;
+	int addr_cells, size_cells, prop_len;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -EOPNOTSUPP;
+
+	rc = get_root_addr_size_cells(&addr_cells, &size_cells);
+	if (rc)
+		return rc;
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
index d0234c4815da..10ff704ab670 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -408,6 +408,9 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #endif /* CONFIG_KEXEC_CORE */
 
 #if defined(CONFIG_OF_FLATTREE)
+extern int get_root_addr_size_cells(int *addr_cells, int *size_cells);
+extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
+				unsigned long *addr, size_t *size);
 extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
 			      unsigned long size);
 #endif /* CONFIG_OF_FLATTREE */
-- 
2.29.2

