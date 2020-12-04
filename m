Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D22CF51A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLDTwj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 14:52:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52720 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgLDTwj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 14:52:39 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D285320B7189;
        Fri,  4 Dec 2020 11:51:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D285320B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607111518;
        bh=oX8q8wUf3czcB5Lpc7ifTPAnAev+bG+rCwc+gi4XvUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL2BncW0XZNcxdSQJnZoOwuNT4KJGnjd5Or6yXYns8mUQyBvqJdnb5SotsTPu1pHT
         udw4UuRkCpBD4YjcppCYhZn2UUUiQuh2QZrYtqY1CyMsZg3TjYPRCQj0Q5L17Y2brS
         XANnYBlH27xZTtKu/JaTP6giUyc6dJzVN1NGP3qc=
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
Subject: [PATCH v10 4/8] powerpc: Use ima kexec node functions
Date:   Fri,  4 Dec 2020 11:51:45 -0800
Message-Id: <20201204195149.611-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204195149.611-1-nramas@linux.microsoft.com>
References: <20201204195149.611-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

do_get_kexec_buffer() and get_addr_size_cells() are called by
ima_get_kexec_buffer(), ima_free_kexec_buffer, and remove_ima_buffer()
to retrieve the address and size of the buffer used for carrying
forward the IMA measurement log across kexec system call. These
functions correctly handle a device tree property that is a child node
of the root node, but not anything other than the immediate root
child nodes.

Use the architecture independent functions get_ima_kexec_buffer()
and get_root_addr_size_cells() defined in "drivers/of/ima_kexec.c",
to get the address and size of the IMA measurement log buffer from
the device tree. Remove do_get_kexec_buffer() and get_addr_size_cells()
since they are not used anymore.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 58 +++++-----------------------------------
 1 file changed, 7 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index a36c39db4b1a..906e8212435d 100644
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
@@ -191,7 +147,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	ret = get_root_addr_size_cells(&addr_cells, &size_cells);
 	if (ret)
 		return ret;
 
-- 
2.29.2

