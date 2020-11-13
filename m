Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD92B2464
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 20:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKMTWy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 14:22:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48962 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKMTWx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:53 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3263320C28C3;
        Fri, 13 Nov 2020 11:22:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3263320C28C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295371;
        bh=vgc5PPqHNzhlC/gOER+sZXJB8kHndlI26Xh9uWAzY3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dH6tM7K16zYOi/aI/8BdaFPZa+VqdncEq2+ppf2NlzEBsJC0RIa9hQ8pxyhpSoS7u
         voRHk0FwkxI2hPR68tkh4wGJKzSPW+nC/t34/LWEK3DBo8xmuuYH55XbWsOG2G+hgK
         LdpVGY5nXlnKUUSRypT1brH6B1YrdTq2P0ygrZB0=
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
Subject: [PATCH v9 4/8] powerpc: Use get_ima_kexec_buffer to get ima kexec buffer
Date:   Fri, 13 Nov 2020 11:22:39 -0800
Message-Id: <20201113192243.1993-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

do_get_kexec_buffer() is called by ima_get_kexec_buffer(),
ima_free_kexec_buffer, and remove_ima_buffer() to retrieve the address
and size of the buffer used for carrying forward the IMA measurement log
across kexec system call. This function correctly handles a device
tree property that is a child node of the root node, but not anything
other than the immediate root child nodes.

Use the architecture independent function get_ima_kexec_buffer(),
defined in "drivers/of/ima_kexec.c", to get the address and size of
the IMA measurement log buffer from the device tree.
Remove do_get_kexec_buffer() since it is not used anymore.

With the above change the static function get_addr_size_cells() in 
arch/powerpc/kexec/ima.c is used only by setup_ima_buffer(), which
is defined when the kernel config CONFIG_IMA_KEXEC is enabled.
Move get_addr_size_cells() under CONFIG_IMA_KEXEC.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 72 ++++++++++++----------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index a36c39db4b1a..df491fab5d4b 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -13,40 +13,6 @@
 #include <linux/libfdt.h>
 #include <asm/ima.h>
 
-static int get_addr_size_cells(int *addr_cells, int *size_cells)
-{
-	struct device_node *root;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return -EINVAL;
-
-	*addr_cells = of_n_addr_cells(root);
-	*size_cells = of_n_size_cells(root);
-
-	of_node_put(root);
-
-	return 0;
-}
-
-static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
-			       size_t *size)
-{
-	int ret, addr_cells, size_cells;
-
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
-	if (len < 4 * (addr_cells + size_cells))
-		return -ENOENT;
-
-	*addr = of_read_number(prop, addr_cells);
-	*size = of_read_number(prop + 4 * addr_cells, size_cells);
-
-	return 0;
-}
-
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -56,16 +22,11 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  */
 int ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret, len;
+	int ret;
 	unsigned long tmp_addr;
 	size_t tmp_size;
-	const void *prop;
 
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
 	if (ret)
 		return ret;
 
@@ -89,7 +50,7 @@ int ima_free_kexec_buffer(void)
 	if (!prop)
 		return -ENOENT;
 
-	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
+	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
 	if (ret)
 		return ret;
 
@@ -98,7 +59,6 @@ int ima_free_kexec_buffer(void)
 		return ret;
 
 	return memblock_free(addr, size);
-
 }
 
 /**
@@ -112,19 +72,15 @@ int ima_free_kexec_buffer(void)
  */
 void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	int ret, len;
+	int ret;
 	unsigned long addr;
 	size_t size;
-	const void *prop;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
-	if (!prop)
+	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
+	if (ret)
 		return;
 
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
 	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
-	if (ret)
-		return;
 
 	ret = delete_fdt_mem_rsv(fdt, addr, size);
 	if (!ret)
@@ -132,6 +88,22 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 }
 
 #ifdef CONFIG_IMA_KEXEC
+static int get_addr_size_cells(int *addr_cells, int *size_cells)
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
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
  *
-- 
2.29.2

