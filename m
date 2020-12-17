Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B92DD660
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgLQRhz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 12:37:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51882 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgLQRhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 12:37:54 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 100B020B717B;
        Thu, 17 Dec 2020 09:37:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 100B020B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608226633;
        bh=6vvBn5VQGBGjjRZtwMxzCIKc79NBWrC0769N6wG9rkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXXCKtbBhjOMmJ9+2B+a/D1VaWD4n8ia+6AdgQ3kpHSAaxEyY6w2kWyZu0JH0GjoM
         RO3nZkDBBa50G5GMlpbWKylr/Vum8bVeMV0U3QXiC1xgU34PYHt24dC6gUiSiQfdCa
         kBl2o6aghhYk2GR0fc9GoLlieMjRRdWVUEoMUCds=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     =james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v12 1/4] powerpc: Use fdt_appendprop_addrrange() to add ima buffer to FDT
Date:   Thu, 17 Dec 2020 09:37:05 -0800
Message-Id: <20201217173708.6940-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173708.6940-1-nramas@linux.microsoft.com>
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
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

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 51 ++++++----------------------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..d579d3da4715 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
+#include <asm/ima.h>
 
 static int get_addr_size_cells(int *addr_cells, int *size_cells)
 {
@@ -145,27 +146,6 @@ int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 	return 0;
 }
 
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
@@ -176,35 +156,18 @@ static int write_number(void *p, u64 value, int cells)
  */
 int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 {
-	int ret, addr_cells, size_cells, entry_size;
-	u8 value[16];
+	int ret;
 
 	remove_ima_buffer(fdt, chosen_node);
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				       "linux,ima-kexec-buffer",
+				       image->arch.ima_buffer_addr,
+				       image->arch.ima_buffer_size);
 	if (ret)
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
-	if (ret < 0)
-		return -EINVAL;
+		return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
 
 	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
 			      image->arch.ima_buffer_size);
-- 
2.29.2

