Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809324A4D5
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHSRWB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:22:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSRVl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:21:41 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B59220B490D;
        Wed, 19 Aug 2020 10:21:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B59220B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597857701;
        bh=X8QUPik4Ud0vySdFqcWfXjD/MwP+wcsU80sDPW741EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPeJpDxkdUavU2dmrgtPaswWMJ/gzpW5ZxLl3/yPjK0o00tWjMVPc7lXSMey1fdyu
         nM8f7QC/Aq9hJDwtp5G7XsdwgMsmaGpojbZnGCIx7uDvrht6aR1aaSNj9J/0ZGeO7S
         canVxlTXVHiti0oJiCZlQBT8YFuUFsdX18psfsAE=
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
Subject: [PATCH v4 2/5] powerpc: Use libfdt functions to fetch IMA buffer properties
Date:   Wed, 19 Aug 2020 10:21:31 -0700
Message-Id: <20200819172134.11243-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819172134.11243-1-nramas@linux.microsoft.com>
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

remove_ima_buffer() uses custom code to handle properties of
the IMA buffer, such as the buffer's address, size, etc., in 
the device tree. Flat Device Tree (FDT) library (libfdt) provides
helper functions for handling device tree node properties and
they should be used instead.

Use libfdt functions for handling IMA buffer properties in
the device tree node for powerpc.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 63 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index f5112ee4bb0b..573ff708d700 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -12,40 +12,6 @@
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 
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
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -54,7 +20,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  */
 void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	int ret, len;
+	int ret, len, addr_cells, size_cells;
 	unsigned long addr;
 	size_t size;
 	const void *prop;
@@ -63,7 +29,22 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 	if (!prop)
 		return;
 
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	ret = fdt_address_cells(fdt, chosen_node);
+	if (ret < 0)
+		return;
+	addr_cells = ret;
+
+	ret = fdt_size_cells(fdt, chosen_node);
+	if (ret < 0)
+		return;
+	size_cells = ret;
+
+	if (len < 4 * (addr_cells + size_cells))
+		return;
+
+	addr = of_read_number(prop, addr_cells);
+	size = of_read_number(prop + 4 * addr_cells, size_cells);
+
 	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
 	if (ret)
 		return;
@@ -129,9 +110,15 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
+	ret = fdt_address_cells(fdt, chosen_node);
+	if (ret < 0)
+		return ret;
+	addr_cells = ret;
+
+	ret = fdt_size_cells(fdt, chosen_node);
+	if (ret < 0)
 		return ret;
+	size_cells = ret;
 
 	entry_size = 4 * (addr_cells + size_cells);
 
-- 
2.28.0

