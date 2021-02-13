Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C431ACF6
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBMQNB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Feb 2021 11:13:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35998 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBMQMY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Feb 2021 11:12:24 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 93F6020B57A3;
        Sat, 13 Feb 2021 08:10:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93F6020B57A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613232659;
        bh=SHdBiCq39+xWFGNYYaUBGVZkVeITcHxZXZVY9YigYY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmXcmg9fQFZsR/xGAoSL7j7g7qmSPHFb34tsYN3PgM8g5jVS7EckD3E86BwJi07ul
         H6CjuIvV1zMTSm/oX9LGsdC1u9fdGqsd/Wajatgfu15dy/am6zmMruz+eKSNnJyACm
         Oxg6DrkcVUjwKJF3xkNqDev7adXuaMIrwMzDmwbA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v18 06/11] powerpc: Move ima buffer fields to struct kimage
Date:   Sat, 13 Feb 2021 08:10:44 -0800
Message-Id: <20210213161049.6190-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
for powerpc are used to carry forward the IMA measurement list across
kexec system call.  These fields are not architecture specific, but are
currently limited to powerpc.

arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
sets ima_buffer_addr and ima_buffer_size for the kexec system call.
This function does not have architecture specific code, but is
currently limited to powerpc.

Move ima_buffer_addr and ima_buffer_size to "struct kimage".
Set ima_buffer_addr and ima_buffer_size in ima_add_kexec_buffer()
in security/integrity/ima/ima_kexec.c.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 arch/powerpc/include/asm/ima.h     |  3 ---
 arch/powerpc/include/asm/kexec.h   |  5 -----
 arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
 include/linux/kexec.h              |  3 +++
 security/integrity/ima/ima_kexec.c |  8 ++------
 5 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..51f64fd06c19 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -14,9 +14,6 @@ static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size);
-
 int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
 #else
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index f59946c6f9e6..877db8354e01 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -112,11 +112,6 @@ struct kimage_arch {
 	unsigned long elf_headers_sz;
 	void *elf_headers;
 	void *fdt;
-
-#ifdef CONFIG_IMA_KEXEC
-	phys_addr_t ima_buffer_addr;
-	size_t ima_buffer_size;
-#endif
 };
 
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..ed38125e2f87 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -128,23 +128,6 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 }
 
 #ifdef CONFIG_IMA_KEXEC
-/**
- * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
- *
- * Architectures should use this function to pass on the IMA buffer
- * information to the next kernel.
- *
- * Return: 0 on success, negative errno on error.
- */
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size)
-{
-	image->arch.ima_buffer_addr = load_addr;
-	image->arch.ima_buffer_size = size;
-
-	return 0;
-}
-
 static int write_number(void *p, u64 value, int cells)
 {
 	if (cells == 1) {
@@ -180,7 +163,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	u8 value[16];
 
 	remove_ima_buffer(fdt, chosen_node);
-	if (!image->arch.ima_buffer_size)
+	if (!image->ima_buffer_size)
 		return 0;
 
 	ret = get_addr_size_cells(&addr_cells, &size_cells);
@@ -192,11 +175,11 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (entry_size > sizeof(value))
 		return -EINVAL;
 
-	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
+	ret = write_number(value, image->ima_buffer_addr, addr_cells);
 	if (ret)
 		return ret;
 
-	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
+	ret = write_number(value + 4 * addr_cells, image->ima_buffer_size,
 			   size_cells);
 	if (ret)
 		return ret;
@@ -206,13 +189,13 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
-			      image->arch.ima_buffer_size);
+	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
+			      image->ima_buffer_size);
 	if (ret)
 		return -EINVAL;
 
 	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
+		 image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5f61389f5f36..75c670f0dfbb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -304,6 +304,9 @@ struct kimage {
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
+
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
 #endif
 };
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e29bea3dd4cc..8b1a3d50c49c 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -123,12 +123,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
-	if (ret) {
-		pr_err("Error passing over kexec measurement buffer.\n");
-		return;
-	}
-
+	image->ima_buffer_addr = kbuf.mem;
+	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
 
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
-- 
2.30.0

