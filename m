Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6B2DF0D9
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Dec 2020 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgLSR6V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Dec 2020 12:58:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLSR6U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Dec 2020 12:58:20 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E5EB320B83F6;
        Sat, 19 Dec 2020 09:57:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5EB320B83F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608400659;
        bh=2sX3DOQNul17WhMPoQraNg57fmG6VY+bxXXYc4MwJTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOVrA1QYCMhqVU2uQWKbJd+ZrzStgOgCcQZ3zDz6e08cafn8qT4hGDL9W8ei1SGjO
         Pilt2kYj+V3UXhMMKlRdZOQP6wjcCpl0ef/HFiCcL17UPep6EOfASrH8cbPiko/pcv
         t1E82vSwEQ8z7jGBB62eA4hHLuIDYrlswV1GIpPk=
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
Subject: [PATCH v13 3/6] kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
Date:   Sat, 19 Dec 2020 09:57:10 -0800
Message-Id: <20201219175713.18888-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219175713.18888-1-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

fdt_appendprop_addrrange() function adds a property, with the given name,
to the device tree at the given node offset, and also sets the address
and size of the property. This function should be used to add
"linux,ima-kexec-buffer" property to the device tree and set the address
and size of the IMA measurement buffer, instead of using custom function.

Use fdt_appendprop_addrrange() to add  "linux,ima-kexec-buffer" property
to the device tree. This property holds the address and size of
the IMA measurement buffer that needs to be passed from the current
kernel to the next kernel across kexec system call.

Remove custom code that is used in setup_ima_buffer() to add
"linux,ima-kexec-buffer" property to the device tree.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 drivers/of/kexec.c | 57 ++++------------------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 33d97106f176..0031491d9aeb 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -147,36 +147,6 @@ static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
 
 #ifdef CONFIG_IMA_KEXEC
-/**
- * write_number - Convert number to big-endian format
- *
- * @p:		Buffer to write the number to
- * @value:	Number to convert
- * @cells:	Number of cells
- *
- * Return: 0 on success, or negative errno on error.
- */
-static int write_number(void *p, u64 value, int cells)
-{
-	if (cells == 1) {
-		u32 tmp;
-
-		if (value > U32_MAX)
-			return -EINVAL;
-
-		tmp = cpu_to_be32(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else if (cells == 2) {
-		u64 tmp;
-
-		tmp = cpu_to_be64(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else
-		return -EINVAL;
-
-	return 0;
-}
-
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -188,32 +158,15 @@ static int write_number(void *p, u64 value, int cells)
 static int setup_ima_buffer(const struct kimage *image, void *fdt,
 			    int chosen_node)
 {
-	int ret, addr_cells, size_cells, entry_size;
-	u8 value[16];
+	int ret;
 
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
-	entry_size = 4 * (addr_cells + size_cells);
-
-	if (entry_size > sizeof(value))
-		return -EINVAL;
-
-	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
-	if (ret)
-		return ret;
-
-	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
-			   size_cells);
-	if (ret)
-		return ret;
-
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
-			  entry_size);
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				       "linux,ima-kexec-buffer",
+				       image->arch.ima_buffer_addr,
+				       image->arch.ima_buffer_size);
 	if (ret < 0)
 		return -EINVAL;
 
-- 
2.29.2

