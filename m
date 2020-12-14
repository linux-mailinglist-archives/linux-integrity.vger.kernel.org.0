Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE742DA061
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440987AbgLNTZh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 14:25:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58122 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408896AbgLNTTt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:19:49 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EA49720B7185;
        Mon, 14 Dec 2020 11:19:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA49720B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973548;
        bh=13oyFSjeebmBVRsX5qnb18X54SDtFubLxPq4ZGVsI8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCB9lgLh1jdL2MRlI/RAaPjwafQihv0aFHamvmZqwq223axDuTS3j3n/u3uOG6jO6
         Rkpwen20NvQWotHMD8yISBOliqfm0W3jV06XA6pzzNh12hdmEbnZo6dhFlo444+OiY
         9GYDdbyrvgdQMkPwPR9R13ibaD8W7RFXHbdxwBNU=
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
Subject: [PATCH v11 2/8] powerpc: Move ima buffer functions to drivers/of/kexec.c
Date:   Mon, 14 Dec 2020 11:18:48 -0800
Message-Id: <20201214191854.9050-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
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
 drivers/of/kexec.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  3 ++
 2 files changed, 71 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 66787be081fe..9af5371340b1 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -30,6 +30,10 @@
 /**
  * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
  *
+ * @fdt: Flattened Device Tree to update
+ * @start: Starting address of the reservation to delete
+ * @size: Size of the reservation to delete
+ *
  * Return: 0 on success, or negative errno on error.
  */
 static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned long size)
@@ -226,3 +230,67 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 
 	return 0;
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
diff --git a/include/linux/of.h b/include/linux/of.h
index 3375f5295875..fb2ef274135d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -562,6 +562,9 @@ struct kimage;
 int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 			   unsigned long initrd_load_addr, unsigned long initrd_len,
 			   const char *cmdline);
+int get_root_addr_size_cells(int *addr_cells, int *size_cells);
+int get_ima_kexec_buffer(void *fdt, int chosen_node,
+			 unsigned long *addr, size_t *size);
 
 #else /* CONFIG_OF */
 
-- 
2.29.2

