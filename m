Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD72226330
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGTPYB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:24:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47690 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgGTPX6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:23:58 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id C007F20B4911;
        Mon, 20 Jul 2020 08:23:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C007F20B4911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258638;
        bh=J74HKsE6BQB61ViBOZwKU/akj9IUtIuEcshXkxPv29w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTk/w6cv15Tx8/ktbyQ53lq9phIP4OVRmHCbmrsUVjV19MtxDhu4Z0HLaGQS3i6KJ
         41OyVSqjACTGPJQNIN2Dg9Hh9KYibl2yWVECcfdIonozDXmi44D8boksPA7wva2vL+
         zHacS2a7t5KqTCM+XpipvI2GTFUzIAAl8shx4gEg=
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
Subject: [PATCH V3 6/6] Add the property used for carrying forward the IMA measurement logs and update the code to use the defined property string.
Date:   Mon, 20 Jul 2020 08:23:42 -0700
Message-Id: <20200720152342.337990-7-prsriva@linux.microsoft.com>
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
 arch/arm64/kernel/machine_kexec_file.c | 19 ++++++++++---------
 arch/powerpc/kexec/ima.c               |  8 +++++---
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 066670c43626..59058901e641 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,14 +24,15 @@
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
-#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
-#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
-#define FDT_PROP_INITRD_START	"linux,initrd-start"
-#define FDT_PROP_INITRD_END	"linux,initrd-end"
-#define FDT_PROP_BOOTARGS	"bootargs"
-#define FDT_PROP_KASLR_SEED	"kaslr-seed"
-#define FDT_PROP_RNG_SEED	"rng-seed"
-#define RNG_SEED_SIZE		128
+#define FDT_PROP_KEXEC_ELFHDR		"linux,elfcorehdr"
+#define FDT_PROP_MEM_RANGE		"linux,usable-memory-range"
+#define FDT_PROP_INITRD_START		"linux,initrd-start"
+#define FDT_PROP_INITRD_END		"linux,initrd-end"
+#define FDT_PROP_BOOTARGS		"bootargs"
+#define FDT_PROP_KASLR_SEED		"kaslr-seed"
+#define FDT_PROP_RNG_SEED		"rng-seed"
+#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
+#define RNG_SEED_SIZE			128
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -157,7 +158,7 @@ static int setup_dtb(struct kimage *image,
 	if (image->arch.ima_buffer_size > 0) {
 
 		ret = fdt_appendprop_addrrange(dtb, 0, off,
-				"linux,ima-kexec-buffer",
+				FDT_PROP_IMA_KEXEC_BUFFER,
 				image->arch.ima_buffer_addr,
 				image->arch.ima_buffer_size);
 		if (ret)
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index a9e4e9f04273..7d6c43b2eacb 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -12,6 +12,8 @@
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 
+#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
+
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -25,7 +27,7 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 	size_t size;
 	const void *prop;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
 	if (!prop)
 		return;
 
@@ -45,7 +47,7 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 	addr = of_read_number(prop, addr_cells);
 	size = of_read_number(prop + 4 * addr_cells, size_cells);
 
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
 	if (ret)
 		return;
 
@@ -134,7 +136,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret)
 		return ret;
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
 			  entry_size);
 	if (ret < 0)
 		return -EINVAL;
-- 
2.25.1

