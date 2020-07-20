Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5C226338
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgGTPYL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:24:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47690 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTPX4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:23:56 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 79E8E20B490C;
        Mon, 20 Jul 2020 08:23:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79E8E20B490C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258635;
        bh=mSQYMuuqXVC7HaKHue2YtLNqVwqzyhXPL8A7QW+52SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKPSlfJcELwK8WxgPb4TUCDufyEkaaEGWEXzr+8NcMyJbYS5X1lzss38rMCk/96eH
         vDj5jK9vbdYfU+I6wwT1cn5Ijsrx8Q/Eohz+Go1cythQgUfQuqyifjRr8wjVDbv5fu
         vD7y6t1ls1mnLa6WUPeWc8kC67BwiSJ6AltRRNrw=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: [PATCH V3 2/6] Update remove_ima_buffer code to use functions from libfdt reducing wrappers functions.
Date:   Mon, 20 Jul 2020 08:23:38 -0700
Message-Id: <20200720152342.337990-3-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720152342.337990-1-prsriva@linux.microsoft.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 63 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 563313703756..a9e4e9f04273 100644
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
 	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
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
2.25.1

